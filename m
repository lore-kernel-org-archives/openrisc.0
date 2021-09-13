From: Stafford Horne <shorne@gmail.com>
Date: Mon, 13 Sep 2021 21:47:56 +0900
Subject: [OpenRISC] [PATCH 1/5] gdb: or1k: implement gdb server
In-Reply-To: <20210913124800.471680-1-shorne@gmail.com>
References: <20210913124800.471680-1-shorne@gmail.com>
Message-ID: <20210913124800.471680-2-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This patch adds gdbserver support for OpenRISC.  This has been used for
debugging the glibc port that in being worked on here:

  https://github.com/openrisc/or1k-glibc/tree/or1k-port-2

Hence the comment about registers definitions being inline with glibc.
---
 gdb/features/Makefile         |   1 +
 gdb/features/or1k-linux.xml   |  13 ++
 gdb/regformats/or1k-linux.dat |  40 +++++
 gdbserver/Makefile.in         |   1 +
 gdbserver/configure.srv       |   8 +
 gdbserver/linux-or1k-low.cc   | 266 ++++++++++++++++++++++++++++++++++
 6 files changed, 329 insertions(+)
 create mode 100644 gdb/features/or1k-linux.xml
 create mode 100644 gdb/regformats/or1k-linux.dat
 create mode 100644 gdbserver/linux-or1k-low.cc

diff --git a/gdb/features/Makefile b/gdb/features/Makefile
index aa38d176539..d467fe7145f 100644
--- a/gdb/features/Makefile
+++ b/gdb/features/Makefile
@@ -47,6 +47,7 @@
 WHICH = mips-linux mips-dsp-linux \
 	mips64-linux mips64-dsp-linux \
 	nios2-linux \
+	or1k-linux \
 	rs6000/powerpc-32 \
 	rs6000/powerpc-32l rs6000/powerpc-altivec32l rs6000/powerpc-e500l \
 	rs6000/powerpc-64l rs6000/powerpc-altivec64l rs6000/powerpc-vsx32l \
diff --git a/gdb/features/or1k-linux.xml b/gdb/features/or1k-linux.xml
new file mode 100644
index 00000000000..598538d124f
--- /dev/null
+++ b/gdb/features/or1k-linux.xml
@@ -0,0 +1,13 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2021 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE target SYSTEM "gdb-target.dtd">
+<target>
+  <architecture>or1k</architecture>
+  <osabi>GNU/Linux</osabi>
+  <xi:include href="or1k-core.xml"/>
+</target>
diff --git a/gdb/regformats/or1k-linux.dat b/gdb/regformats/or1k-linux.dat
new file mode 100644
index 00000000000..7b64646fc65
--- /dev/null
+++ b/gdb/regformats/or1k-linux.dat
@@ -0,0 +1,40 @@
+# THIS FILE IS GENERATED.  -*- buffer-read-only: t -*- vi :set ro:
+# Generated from: or1k-linux.xml
+name:or1k_linux
+xmltarget:or1k-linux.xml
+expedite:r1,npc
+32:r0
+32:r1
+32:r2
+32:r3
+32:r4
+32:r5
+32:r6
+32:r7
+32:r8
+32:r9
+32:r10
+32:r11
+32:r12
+32:r13
+32:r14
+32:r15
+32:r16
+32:r17
+32:r18
+32:r19
+32:r20
+32:r21
+32:r22
+32:r23
+32:r24
+32:r25
+32:r26
+32:r27
+32:r28
+32:r29
+32:r30
+32:r31
+32:ppc
+32:npc
+32:sr
diff --git a/gdbserver/Makefile.in b/gdbserver/Makefile.in
index 12e9b2777ae..d524a7e8775 100644
--- a/gdbserver/Makefile.in
+++ b/gdbserver/Makefile.in
@@ -196,6 +196,7 @@ SFILES = \
 	$(srcdir)/linux-m68k-low.cc \
 	$(srcdir)/linux-mips-low.cc \
 	$(srcdir)/linux-nios2-low.cc \
+	$(srcdir)/linux-or1k-low.cc \
 	$(srcdir)/linux-ppc-low.cc \
 	$(srcdir)/linux-riscv-low.cc \
 	$(srcdir)/linux-s390-low.cc \
diff --git a/gdbserver/configure.srv b/gdbserver/configure.srv
index 971f537bffa..6e09b0eeb79 100644
--- a/gdbserver/configure.srv
+++ b/gdbserver/configure.srv
@@ -175,6 +175,14 @@ case "${gdbserver_host}" in
 			srv_linux_usrregs=yes
 			srv_linux_thread_db=yes
 			;;
+  or1k*-*-linux*)	srv_regobj="or1k-linux.o"
+			srv_tgtobj="$srv_linux_obj linux-or1k-low.o"
+			srv_xmlfiles="or1k-linux.xml"
+			srv_xmlfiles="${srv_xmlfiles} or1k-core.xml"
+			srv_linux_regsets=yes
+			srv_linux_usrregs=yes
+			srv_linux_thread_db=yes
+			;;
   powerpc*-*-linux*)	srv_regobj="powerpc-32l.o"
 			srv_regobj="${srv_regobj} powerpc-altivec32l.o"
 			srv_regobj="${srv_regobj} powerpc-vsx32l.o"
diff --git a/gdbserver/linux-or1k-low.cc b/gdbserver/linux-or1k-low.cc
new file mode 100644
index 00000000000..d3ca1391c79
--- /dev/null
+++ b/gdbserver/linux-or1k-low.cc
@@ -0,0 +1,266 @@
+/* GNU/Linux/OR1K specific low level interface for the GDB server.
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
+#include "server.h"
+#include "linux-low.h"
+#include "elf/common.h"
+#include "nat/gdb_ptrace.h"
+#include <endian.h>
+#include "gdb_proc_service.h"
+#include <asm/ptrace.h>
+
+#ifndef PTRACE_GET_THREAD_AREA
+#define PTRACE_GET_THREAD_AREA 25
+#endif
+
+/* Linux target op definitions for the OpenRISC architecture.  */
+
+class or1k_target : public linux_process_target
+{
+public:
+
+  const regs_info *get_regs_info () override;
+
+  const gdb_byte *sw_breakpoint_from_kind (int kind, int *size) override;
+
+protected:
+
+  void low_arch_setup () override;
+
+  bool low_cannot_fetch_register (int regno) override;
+
+  bool low_cannot_store_register (int regno) override;
+
+  bool low_supports_breakpoints () override;
+
+  CORE_ADDR low_get_pc (regcache *regcache) override;
+
+  void low_set_pc (regcache *regcache, CORE_ADDR newpc) override;
+
+  bool low_breakpoint_at (CORE_ADDR pc) override;
+};
+
+/* The singleton target ops object.  */
+
+static or1k_target the_or1k_target;
+
+bool
+or1k_target::low_supports_breakpoints ()
+{
+  return true;
+}
+
+CORE_ADDR
+or1k_target::low_get_pc (regcache *regcache)
+{
+  return linux_get_pc_32bit (regcache);
+}
+
+void
+or1k_target::low_set_pc (regcache *regcache, CORE_ADDR pc)
+{
+  linux_set_pc_32bit (regcache, pc);
+}
+
+/* The following definition must agree with the number of registers
+   defined in "struct user_regs" in GLIBC
+   (sysdeps/unix/sysv/linux/or1k/sys/ucontext.h), and also with
+   OR1K_NUM_REGS in GDB proper.  */
+
+#define or1k_num_regs 35
+
+/* Defined in auto-generated file or1k-linux.c.  */
+
+void init_registers_or1k_linux (void);
+extern const struct target_desc *tdesc_or1k_linux;
+
+/* This union is used to convert between int and byte buffer
+   representations of register contents.  */
+
+union or1k_register
+{
+  unsigned char buf[4];
+  int reg32;
+};
+
+/* Return the ptrace ``address'' of register REGNO. */
+
+static int or1k_regmap[] = {
+  -1,  1,  2,  3,  4,  5,  6,  7,
+  8,  9,  10, 11, 12, 13, 14, 15,
+  16, 17, 18, 19, 20, 21, 22, 23,
+  24, 25, 26, 27, 28, 29, 30, 31,
+  -1, /* PC */
+  -1, /* ORIGINAL R11 */
+  -1  /* SYSCALL NO */
+};
+
+/* Implement the low_arch_setup linux target ops method.  */
+
+void
+or1k_target::low_arch_setup ()
+{
+  current_process ()->tdesc = tdesc_or1k_linux;
+}
+
+/* Implement the low_cannot_fetch_register linux target ops method.  */
+
+bool
+or1k_target::low_cannot_fetch_register (int regno)
+{
+  return (or1k_regmap[regno] == -1);
+}
+
+/* Implement the low_cannot_store_register linux target ops method.  */
+
+bool
+or1k_target::low_cannot_store_register (int regno)
+{
+  return (or1k_regmap[regno] == -1);
+}
+
+/* Breakpoint support.  */
+
+static const unsigned int or1k_breakpoint = 0x21000001;
+#define or1k_breakpoint_len 4
+
+/* Implementation of target ops method "sw_breakpoint_from_kind".  */
+
+const gdb_byte *
+or1k_target::sw_breakpoint_from_kind (int kind, int *size)
+{
+  *size = or1k_breakpoint_len;
+  return (const gdb_byte *) &or1k_breakpoint;
+}
+
+/* Implement the low_breakpoint_at linux target ops method.  */
+
+bool
+or1k_target::low_breakpoint_at (CORE_ADDR where)
+{
+  unsigned int insn;
+
+  read_memory (where, (unsigned char *) &insn, 4);
+  if (insn == or1k_breakpoint)
+    return true;
+  return false;
+}
+
+/* Fetch the thread-local storage pointer for libthread_db.  */
+
+ps_err_e
+ps_get_thread_area (struct ps_prochandle *ph,
+		    lwpid_t lwpid, int idx, void **base)
+{
+  if (ptrace (PTRACE_GET_THREAD_AREA, lwpid, NULL, base) != 0)
+    return PS_ERR;
+
+  /* IDX is the bias from the thread pointer to the beginning of the
+     thread descriptor.  It has to be subtracted due to implementation
+     quirks in libthread_db.  */
+  *base = (void *) ((char *) *base - idx);
+
+  return PS_OK;
+}
+
+/* Helper functions to collect/supply a single register REGNO.  */
+
+static void
+or1k_collect_register (struct regcache *regcache, int regno,
+			union or1k_register *reg)
+{
+  union or1k_register tmp_reg;
+
+  collect_register (regcache, regno, &tmp_reg.reg32);
+  reg->reg32 = tmp_reg.reg32;
+}
+
+static void
+or1k_supply_register (struct regcache *regcache, int regno,
+		       const union or1k_register *reg)
+{
+  supply_register (regcache, regno, reg->buf);
+}
+
+/* We have only a single register set on OpenRISC.  */
+
+static void
+or1k_fill_gregset (struct regcache *regcache, void *buf)
+{
+  union or1k_register *regset = (union or1k_register *) buf;
+  int i;
+
+  for (i = 1; i < or1k_num_regs; i++)
+    or1k_collect_register (regcache, i, regset + i);
+}
+
+static void
+or1k_store_gregset (struct regcache *regcache, const void *buf)
+{
+  const union or1k_register *regset = (union or1k_register *) buf;
+  int i;
+
+  for (i = 0; i < or1k_num_regs; i++)
+    or1k_supply_register (regcache, i, regset + i);
+}
+
+static struct regset_info or1k_regsets[] =
+{
+  { PTRACE_GETREGSET, PTRACE_SETREGSET, NT_PRSTATUS,
+    or1k_num_regs * 4, GENERAL_REGS,
+    or1k_fill_gregset, or1k_store_gregset },
+  NULL_REGSET
+};
+
+static struct regsets_info or1k_regsets_info =
+  {
+    or1k_regsets, /* regsets */
+    0, /* num_regsets */
+    NULL, /* disabled_regsets */
+  };
+
+static struct usrregs_info or1k_usrregs_info =
+  {
+    or1k_num_regs,
+    or1k_regmap,
+  };
+
+static struct regs_info or1k_regs =
+  {
+    NULL, /* regset_bitmap */
+    &or1k_usrregs_info,
+    &or1k_regsets_info
+  };
+
+const regs_info *
+or1k_target::get_regs_info ()
+{
+  return &or1k_regs;
+}
+
+/* The linux target ops object.  */
+
+linux_process_target *the_linux_target = &the_or1k_target;
+
+void
+initialize_low_arch (void)
+{
+  init_registers_or1k_linux ();
+
+  initialize_regsets_info (&or1k_regsets_info);
+}
-- 
2.31.1

