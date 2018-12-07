From: Stafford Horne <shorne@gmail.com>
Date: Fri,  7 Dec 2018 15:39:09 +0900
Subject: [OpenRISC] [RESEND PATCH] gdb/or1k: Add linux debugging support
Message-ID: <20181207063909.15365-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

(Resend to include binutils list)

Up until now OpenRISC GDB only has supported bare metal debugging.  This
patch adds linux userspace debugging and core dump analysis support.

The changes are loosely based on nios2 and riscv implementations.

This was tested with linux 4.20 core dumps for executables linked
against musl libc.

bfd/ChangeLog:

	* elf32-or1k.c (or1k_grok_prstatus): New function.
	(or1k_grok_psinfo): Likewise.

gdb/ChangeLog:

	* Makefile.in (ALL_TARGET_OBS): Add or1k-linux-tdep.o.
	* configure.tgt: Add or1k*-*-linux*.
	* or1k-linux-tdep.c: New file.
	* or1k-tdep.c (or1k_gdbarch_init): Call gdbarch_init_osabi.
---
 bfd/elf32-or1k.c      |  55 ++++++++++++++
 gdb/Makefile.in       |   1 +
 gdb/configure.tgt     |   8 ++
 gdb/or1k-linux-tdep.c | 170 ++++++++++++++++++++++++++++++++++++++++++
 gdb/or1k-tdep.c       |   3 +
 5 files changed, 237 insertions(+)
 create mode 100644 gdb/or1k-linux-tdep.c

diff --git a/bfd/elf32-or1k.c b/bfd/elf32-or1k.c
index a2b0ff147f..8edd7584e4 100644
--- a/bfd/elf32-or1k.c
+++ b/bfd/elf32-or1k.c
@@ -3226,6 +3226,58 @@ elf32_or1k_merge_private_bfd_data (bfd *ibfd, struct bfd_link_info *info)
 
 }
 
+/* Implement elf_backend_grok_prstatus:
+   Support for core dump NOTE sections.  */
+static bfd_boolean
+or1k_grok_prstatus (bfd *abfd, Elf_Internal_Note *note)
+{
+  int offset;
+  size_t size;
+
+  switch (note->descsz)
+    {
+    default:
+      return FALSE;
+
+    case 212:	      /* Linux/OpenRISC */
+      /* pr_cursig */
+      elf_tdata (abfd)->core->signal = bfd_get_16 (abfd, note->descdata + 12);
+
+      /* pr_pid */
+      elf_tdata (abfd)->core->pid = bfd_get_32 (abfd, note->descdata + 24);
+
+      /* pr_reg */
+      offset = 72;
+      size = 132;
+
+      break;
+    }
+
+  /* Make a ".reg/999" section.  */
+  return _bfd_elfcore_make_pseudosection (abfd, ".reg",
+					  size, note->descpos + offset);
+}
+
+/* Implement elf_backend_grok_psinfo.  */
+static bfd_boolean
+or1k_grok_psinfo (bfd *abfd, Elf_Internal_Note *note)
+{
+  switch (note->descsz)
+    {
+    default:
+      return FALSE;
+
+    case 128:	      /* Linux/OpenRISC elf_prpsinfo */
+      elf_tdata (abfd)->core->program
+	= _bfd_elfcore_strndup (abfd, note->descdata + 32, 16);
+      elf_tdata (abfd)->core->command
+	= _bfd_elfcore_strndup (abfd, note->descdata + 48, 80);
+    }
+
+  return TRUE;
+}
+
+
 #define ELF_ARCH			bfd_arch_or1k
 #define ELF_MACHINE_CODE		EM_OR1K
 #define ELF_TARGET_ID			OR1K_ELF_DATA
@@ -3269,4 +3321,7 @@ elf32_or1k_merge_private_bfd_data (bfd *ibfd, struct bfd_link_info *info)
 #define elf_backend_adjust_dynamic_symbol	or1k_elf_adjust_dynamic_symbol
 #define elf_backend_finish_dynamic_symbol	or1k_elf_finish_dynamic_symbol
 
+#define elf_backend_grok_prstatus	  or1k_grok_prstatus
+#define elf_backend_grok_psinfo		  or1k_grok_psinfo
+
 #include "elf32-target.h"
diff --git a/gdb/Makefile.in b/gdb/Makefile.in
index 1099d710c9..b8cb130b9f 100644
--- a/gdb/Makefile.in
+++ b/gdb/Makefile.in
@@ -740,6 +740,7 @@ ALL_TARGET_OBS = \
 	nios2-tdep.o \
 	nto-tdep.o \
 	obsd-tdep.o \
+	or1k-linux-tdep.o \
 	or1k-tdep.o \
 	ppc-fbsd-tdep.o \
 	ppc-linux-tdep.o \
diff --git a/gdb/configure.tgt b/gdb/configure.tgt
index 9b646fa1a2..27f122ad04 100644
--- a/gdb/configure.tgt
+++ b/gdb/configure.tgt
@@ -471,6 +471,14 @@ nios2*-*-*)
 	gdb_target_obs="nios2-tdep.o"
 	;;
 
+or1k*-*-linux*)
+	# Target: OpenCores OpenRISC 1000 32-bit running Linux
+	gdb_target_obs="or1k-tdep.o or1k-linux-tdep.o solib-svr4.o \
+			symfile-mem.o glibc-tdep.o linux-tdep.o"
+	gdb_sim=../sim/or1k/libsim.a
+	build_gdbserver=yes
+	;;
+
 or1k-*-* | or1knd-*-*)
 	# Target: OpenCores OpenRISC 1000 32-bit implementation bare metal
 	gdb_target_obs="or1k-tdep.o"
diff --git a/gdb/or1k-linux-tdep.c b/gdb/or1k-linux-tdep.c
new file mode 100644
index 0000000000..d867dcee41
--- /dev/null
+++ b/gdb/or1k-linux-tdep.c
@@ -0,0 +1,170 @@
+/* Target-dependent code for GNU/Linux on OpenRISC processors.
+   Copyright (C) 2018 Free Software Foundation, Inc.
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
+#include "or1k-tdep.h"
+#include "osabi.h"
+#include "glibc-tdep.h"
+#include "linux-tdep.h"
+#include "solib-svr4.h"
+#include "regset.h"
+#include "tramp-frame.h"
+#include "trad-frame.h"
+
+/* Define the general register mapping.  The kernel puts the PC at offset 0,
+   gdb puts it at offset 32.  Register x0 is always 0 and can be ignored.
+   Registers x1 to x31 are in the same place.  */
+
+static const struct regcache_map_entry or1k_linux_gregmap[] =
+{
+  { 32, OR1K_ZERO_REGNUM, 4 }, /* r0 to r31 */
+  { 1,  OR1K_NPC_REGNUM, 4 },
+  { 0 }
+};
+
+/* Define the general register regset.  */
+
+static const struct regset or1k_linux_gregset =
+{
+  or1k_linux_gregmap, regcache_supply_regset, regcache_collect_regset
+};
+
+/* Define hook for core file support.  */
+
+static void
+or1k_linux_iterate_over_regset_sections (struct gdbarch *gdbarch,
+					 iterate_over_regset_sections_cb *cb,
+					 void *cb_data,
+					 const struct regcache *regcache)
+{
+  cb (".reg", (33 * 4), (33 * 4), &or1k_linux_gregset, NULL, cb_data);
+}
+
+/* Signal trampoline support.  */
+
+static void or1k_linux_sigframe_init (const struct tramp_frame *self,
+				       struct frame_info *this_frame,
+				       struct trad_frame_cache *this_cache,
+				       CORE_ADDR func);
+
+#define OR1K_RT_SIGRETURN		139
+
+#define OR1K_INST_L_ORI_R11_R0_IMM	0xa9600000
+#define OR1K_INST_L_SYS_1		0x20000001
+#define OR1K_INST_L_NOP			0x15000000
+
+static const struct tramp_frame or1k_linux_sigframe = {
+  SIGTRAMP_FRAME,
+  4,
+  {
+    { OR1K_INST_L_ORI_R11_R0_IMM | OR1K_RT_SIGRETURN, ULONGEST_MAX },
+    { OR1K_INST_L_SYS_1, ULONGEST_MAX },
+    { OR1K_INST_L_NOP, ULONGEST_MAX },
+    { TRAMP_SENTINEL_INSN }
+  },
+  or1k_linux_sigframe_init,
+  NULL
+};
+
+/* Runtime signal frames look like this:
+  struct rt_sigframe {
+    struct siginfo info;
+    struct ucontext uc;
+    unsigned char retcode[16];
+  };
+
+  struct ucontext {
+    unsigned long     uc_flags;     - 4
+    struct ucontext  *uc_link;      - 4
+    stack_t           uc_stack;     - 4 * 3
+    struct sigcontext uc_mcontext;
+    sigset_t          uc_sigmask;
+  };
+
+  struct sigcontext {
+    struct user_regs_struct regs;
+    unsigned long oldmask;
+  };
+
+  struct user_regs_struct {
+    unsigned long gpr[32];
+    unsigned long pc;
+    unsigned long sr;
+  };  */
+
+#define SIGFRAME_SIGINFO_SIZE		128
+#define UCONTEXT_MCONTEXT_OFFSET	20
+
+static void
+or1k_linux_sigframe_init (const struct tramp_frame *self,
+			   struct frame_info *this_frame,
+			   struct trad_frame_cache *this_cache,
+			   CORE_ADDR func)
+{
+  CORE_ADDR frame_sp = get_frame_sp (this_frame);
+  CORE_ADDR mcontext_base;
+  CORE_ADDR regs_base;
+
+  mcontext_base = frame_sp + SIGFRAME_SIGINFO_SIZE + UCONTEXT_MCONTEXT_OFFSET;
+
+  /* Handle the general registers 0-31 followed by the PC.  */
+  regs_base = mcontext_base;
+  for (int i = 0; i < 32; i++)
+    trad_frame_set_reg_addr (this_cache, OR1K_ZERO_REGNUM + i,
+			     regs_base + (i * 4));
+  trad_frame_set_reg_addr (this_cache, OR1K_NPC_REGNUM, regs_base + (32 * 4));
+  trad_frame_set_reg_addr (this_cache, OR1K_SR_REGNUM, regs_base + (33 * 4));
+
+  /* Choice of the bottom of the sigframe is somewhat arbitrary.  */
+  trad_frame_set_id (this_cache, frame_id_build (frame_sp, func));
+}
+
+/* Initialize OpenRISC Linux ABI info.  */
+
+static void
+or1k_linux_init_abi (struct gdbarch_info info, struct gdbarch *gdbarch)
+{
+  linux_init_abi (info, gdbarch);
+
+  set_solib_svr4_fetch_link_map_offsets (gdbarch,
+					 svr4_ilp32_fetch_link_map_offsets);
+
+  /* GNU/Linux uses SVR4-style shared libraries.  */
+  set_gdbarch_skip_trampoline_code (gdbarch, find_solib_trampoline_target);
+
+  /* GNU/Linux uses the dynamic linker included in the GNU C Library.  */
+  set_gdbarch_skip_solib_resolver (gdbarch, glibc_skip_solib_resolver);
+
+  /* Enable TLS support.  */
+  set_gdbarch_fetch_tls_load_module_address (gdbarch,
+                                             svr4_fetch_objfile_link_map);
+
+  set_gdbarch_iterate_over_regset_sections
+    (gdbarch, or1k_linux_iterate_over_regset_sections);
+
+  tramp_frame_prepend_unwinder (gdbarch, &or1k_linux_sigframe);
+}
+
+/* Initialize OpenRISC Linux target support.  */
+
+void
+_initialize_or1k_linux_tdep (void)
+{
+  gdbarch_register_osabi (bfd_arch_or1k, 0, GDB_OSABI_LINUX,
+			  or1k_linux_init_abi);
+}
diff --git a/gdb/or1k-tdep.c b/gdb/or1k-tdep.c
index a9ef44baac..1949605626 100644
--- a/gdb/or1k-tdep.c
+++ b/gdb/or1k-tdep.c
@@ -1256,6 +1256,9 @@ or1k_gdbarch_init (struct gdbarch_info info, struct gdbarch_list *arches)
       tdesc_use_registers (gdbarch, tdesc, tdesc_data);
     }
 
+  /* Hook in ABI-specific overrides, if they have been registered.  */
+  gdbarch_init_osabi (info, gdbarch);
+
   return gdbarch;
 }
 
-- 
2.19.1

