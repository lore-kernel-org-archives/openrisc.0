From: Stafford Horne <shorne@gmail.com>
Date: Mon, 13 Sep 2021 21:47:59 +0900
Subject: [OpenRISC] [PATCH 4/5] gdb: or1k: add native linux support
In-Reply-To: <20210913124800.471680-1-shorne@gmail.com>
References: <20210913124800.471680-1-shorne@gmail.com>
Message-ID: <20210913124800.471680-5-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This patch adds support for running gdb natively on OpenRISC linux.
Debugging support is provided via the linux PTRACE interface which is
mostly handled by GDB genric code.  This patch provides the logic of how
to read and write the ptrace registers between linux and GDB.

Single stepping is privided in a separate patch.
---
 gdb/Makefile.in       |   2 +
 gdb/configure.host    |   2 +
 gdb/configure.nat     |   4 +
 gdb/or1k-linux-nat.c  | 210 ++++++++++++++++++++++++++++++++++++++++++
 gdb/or1k-linux-tdep.c |   5 +
 gdb/or1k-linux-tdep.h |  26 ++++++
 6 files changed, 249 insertions(+)
 create mode 100644 gdb/or1k-linux-nat.c
 create mode 100644 gdb/or1k-linux-tdep.h

diff --git a/gdb/Makefile.in b/gdb/Makefile.in
index 320d3326a81..69cc1402594 100644
--- a/gdb/Makefile.in
+++ b/gdb/Makefile.in
@@ -1377,6 +1377,7 @@ HFILES_NO_SRCDIR = \
 	objfiles.h \
 	obsd-nat.h \
 	obsd-tdep.h \
+	or1k-linux-tdep.h \
 	osabi.h \
 	osdata.h \
 	p-lang.h \
@@ -2247,6 +2248,7 @@ ALLDEPFILES = \
 	nios2-tdep.c \
 	obsd-nat.c \
 	obsd-tdep.c \
+	or1k-linux-nat.c \
 	posix-hdep.c \
 	ppc-fbsd-nat.c \
 	ppc-fbsd-tdep.c \
diff --git a/gdb/configure.host b/gdb/configure.host
index 1fc83601e0e..be40cc814fc 100644
--- a/gdb/configure.host
+++ b/gdb/configure.host
@@ -130,6 +130,8 @@ mips*-*-netbsdaout* | mips*-*-knetbsd*-gnu)
 mips*-*-freebsd*)	gdb_host=fbsd ;;
 mips64*-*-openbsd*)	gdb_host=obsd64 ;;
 
+or1k-*-linux*)		gdb_host=linux ;;
+
 powerpc-*-aix* | rs6000-*-* | powerpc64-*-aix*)
 			gdb_host=aix ;;
 powerpc*-*-freebsd*)	gdb_host=fbsd ;;
diff --git a/gdb/configure.nat b/gdb/configure.nat
index 655c75dd1ab..d42cf13e691 100644
--- a/gdb/configure.nat
+++ b/gdb/configure.nat
@@ -271,6 +271,10 @@ case ${gdb_host} in
 		NATDEPFILES="${NATDEPFILES} linux-nat-trad.o \
 		mips-linux-nat.o nat/mips-linux-watch.o"
 		;;
+	    or1k)
+		# Host: Linux/OpenRISC
+		NATDEPFILES="${NATDEPFILES} or1k-linux-nat.o"
+		;;
 	    pa)
 		# Host: Hewlett-Packard PA-RISC machine, running Linux
 		NATDEPFILES="${NATDEPFILES} hppa-linux-nat.o"
diff --git a/gdb/or1k-linux-nat.c b/gdb/or1k-linux-nat.c
new file mode 100644
index 00000000000..1dafa922462
--- /dev/null
+++ b/gdb/or1k-linux-nat.c
@@ -0,0 +1,210 @@
+/* Native-dependent code for GNU/Linux OpenRISC.
+   Copyright (C) 2021 Free Software Foundation, Inc.
+
+   This file is part of GDB.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 3 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
+
+#include "defs.h"
+#include "regcache.h"
+#include "gregset.h"
+#include "linux-nat.h"
+#include "or1k-tdep.h"
+#include "or1k-linux-tdep.h"
+#include "inferior.h"
+
+#include "elf/common.h"
+
+#include <sys/ptrace.h>
+
+/* OpenRISC Linux native additions to the default linux support.  */
+
+class or1k_linux_nat_target final : public linux_nat_target
+{
+public:
+  /* Add our register access methods.  */
+  void fetch_registers (struct regcache *regcache, int regnum) override;
+  void store_registers (struct regcache *regcache, int regnum) override;
+
+  /* Read suitable target description.  */
+  const struct target_desc *read_description () override;
+};
+
+static or1k_linux_nat_target the_or1k_linux_nat_target;
+
+/* Copy general purpose register REGNUM (or all gp regs if REGNUM == -1)
+   from regset GREGS into REGCACHE.  */
+
+static void
+supply_gregset_regnum (struct regcache *regcache, const prgregset_t *gregs,
+		       int regnum)
+{
+  int i;
+  const elf_greg_t *regp = *gregs;
+
+  /* Access all registers */
+  if (regnum == -1)
+    {
+      /* We fill the general purpose registers.  */
+      for (i = OR1K_ZERO_REGNUM + 1; i < OR1K_MAX_GPR_REGS; i++)
+	regcache->raw_supply (i, regp + i);
+
+      /* Supply OR1K_NPC_REGNUM from index 32.  */
+      regcache->raw_supply (OR1K_NPC_REGNUM, regp + 32);
+
+      /* Fill the inaccessible zero register with zero.  */
+      regcache->raw_supply_zeroed (0);
+    }
+  else if (regnum == OR1K_ZERO_REGNUM)
+    regcache->raw_supply_zeroed (0);
+  else if (regnum == OR1K_NPC_REGNUM)
+    regcache->raw_supply (OR1K_NPC_REGNUM, regp + 32);
+  else if (regnum > OR1K_ZERO_REGNUM && regnum < OR1K_MAX_GPR_REGS)
+    regcache->raw_supply (regnum, regp + regnum);
+}
+
+/* Copy all general purpose registers from regset GREGS into REGCACHE.  */
+
+void
+supply_gregset (struct regcache *regcache, const prgregset_t *gregs)
+{
+  supply_gregset_regnum (regcache, gregs, -1);
+}
+
+/* Copy general purpose register REGNUM (or all gp regs if REGNUM == -1)
+   from REGCACHE into regset GREGS.  */
+
+void
+fill_gregset (const struct regcache *regcache, prgregset_t *gregs, int regnum)
+{
+  elf_greg_t *regp = *gregs;
+
+  if (regnum == -1)
+    {
+      /* We fill the general purpose registers.  */
+      for (int i = OR1K_ZERO_REGNUM + 1; i < OR1K_MAX_GPR_REGS; i++)
+	regcache->raw_collect (i, regp + i);
+
+      regcache->raw_collect (OR1K_NPC_REGNUM, regp + 32);
+    }
+  else if (regnum == OR1K_ZERO_REGNUM)
+    /* Nothing to do here.  */
+    ;
+  else if (regnum > OR1K_ZERO_REGNUM && regnum < OR1K_MAX_GPR_REGS)
+    regcache->raw_collect (regnum, regp + regnum);
+  else if (regnum == OR1K_NPC_REGNUM)
+    regcache->raw_collect (OR1K_NPC_REGNUM, regp + 32);
+}
+
+/* Transfering floating-point registers between GDB, inferiors and cores.
+   Since OpenRISC floating-point registers are the same as GPRs these do
+   nothing.  */
+
+void
+supply_fpregset (struct regcache *regcache, const gdb_fpregset_t *fpregs)
+{
+}
+
+void
+fill_fpregset (const struct regcache *regcache,
+	       gdb_fpregset_t *fpregs, int regno)
+{
+}
+
+/* Return a target description for the current target.  */
+
+const struct target_desc *
+or1k_linux_nat_target::read_description ()
+{
+  return tdesc_or1k_linux;
+}
+
+/* Fetch REGNUM (or all registers if REGNUM == -1) from the target
+   into REGCACHE using PTRACE_GETREGSET.  */
+
+void
+or1k_linux_nat_target::fetch_registers (struct regcache *regcache, int regnum)
+{
+  int tid;
+
+  tid = get_ptrace_pid (regcache->ptid());
+
+  if ((regnum >= OR1K_ZERO_REGNUM && regnum < OR1K_MAX_GPR_REGS)
+      || (regnum == OR1K_NPC_REGNUM)
+      || (regnum == -1))
+    {
+      struct iovec iov;
+      elf_gregset_t regs;
+
+      iov.iov_base = &regs;
+      iov.iov_len = sizeof (regs);
+
+      if (ptrace (PTRACE_GETREGSET, tid, NT_PRSTATUS,
+		  (PTRACE_TYPE_ARG3) &iov) == -1)
+	perror_with_name (_("Couldn't get registers"));
+      else
+	supply_gregset_regnum (regcache, &regs, regnum);
+    }
+
+  /* Access to other SPRs has potential security issues, don't support them for
+     now.  */
+}
+
+/* Store REGNUM (or all registers if REGNUM == -1) to the target
+   from REGCACHE using PTRACE_SETREGSET.  */
+
+void
+or1k_linux_nat_target::store_registers (struct regcache *regcache, int regnum)
+{
+  int tid;
+
+  tid = get_ptrace_pid (regcache->ptid ());
+
+  if ((regnum >= OR1K_ZERO_REGNUM && regnum < OR1K_MAX_GPR_REGS)
+      || (regnum == OR1K_NPC_REGNUM)
+      || (regnum == -1))
+    {
+      struct iovec iov;
+      elf_gregset_t regs;
+
+      iov.iov_base = &regs;
+      iov.iov_len = sizeof (regs);
+
+      if (ptrace (PTRACE_GETREGSET, tid, NT_PRSTATUS,
+		  (PTRACE_TYPE_ARG3) &iov) == -1)
+	perror_with_name (_("Couldn't get registers"));
+      else
+	{
+	  fill_gregset (regcache, &regs, regnum);
+
+	  if (ptrace (PTRACE_SETREGSET, tid, NT_PRSTATUS,
+		      (PTRACE_TYPE_ARG3) &iov) == -1)
+	    perror_with_name (_("Couldn't set registers"));
+	}
+    }
+
+  /* Access to SPRs has potential security issues, don't support them for
+     now.  */
+}
+
+/* Initialize OpenRISC Linux native support.  */
+
+void _initialize_or1k_linux_nat ();
+void
+_initialize_or1k_linux_nat ()
+{
+  /* Register the target.  */
+  linux_target = &the_or1k_linux_nat_target;
+  add_inf_child_target (&the_or1k_linux_nat_target);
+}
diff --git a/gdb/or1k-linux-tdep.c b/gdb/or1k-linux-tdep.c
index 2efb4d0b0f9..a71a8202b1e 100644
--- a/gdb/or1k-linux-tdep.c
+++ b/gdb/or1k-linux-tdep.c
@@ -27,6 +27,8 @@
 #include "trad-frame.h"
 #include "gdbarch.h"
 
+#include "features/or1k-linux.c"
+
 /* Define the general register mapping.  The kernel and GDB put registers
    r1 to r31 in the same place.  The NPC register is stored@index 32 in
    linux and 33 in GDB, in GDB 32 is for PPC which is not popupated from linux.
@@ -170,4 +172,7 @@ _initialize_or1k_linux_tdep ()
 {
   gdbarch_register_osabi (bfd_arch_or1k, 0, GDB_OSABI_LINUX,
 			  or1k_linux_init_abi);
+
+  /* Initialize the standard target descriptions.  */
+  initialize_tdesc_or1k_linux ();
 }
diff --git a/gdb/or1k-linux-tdep.h b/gdb/or1k-linux-tdep.h
new file mode 100644
index 00000000000..19294669e64
--- /dev/null
+++ b/gdb/or1k-linux-tdep.h
@@ -0,0 +1,26 @@
+/* Target-dependent code for GNU/Linux on OpenRISC.
+
+   Copyright (C) 2021 Free Software Foundation, Inc.
+
+   This file is part of GDB.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 3 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
+
+#ifndef OR1K_LINUX_TDEP_H
+#define OR1K_LINUX_TDEP_H
+
+/* Target descriptions.  */
+extern struct target_desc *tdesc_or1k_linux;
+
+#endif /* OR1K_LINUX_TDEP_H */
-- 
2.31.1

