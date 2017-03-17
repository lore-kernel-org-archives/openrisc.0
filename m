From: Stafford Horne <shorne@gmail.com>
Date: Fri, 17 Mar 2017 14:39:09 +0900
Subject: [OpenRISC] [PATCH v3 3/5] sim: or1k: add or1k target to sim
In-Reply-To: <cover.1489728532.git.shorne@gmail.com>
References: <cover.1489728532.git.shorne@gmail.com>
Message-ID: <cd62a6638486c5138741a21c33a6e551ca9910ea.1489728533.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

sim/ChangeLog:

2017-03-03  Stafford Horne  <shorne@gmail.com>
	    Peter Gavin  <pgavin@gmail.com>

	* configure.tgt: Add or1k sim.
	* or1k/Makefile.in: New file.
	* or1k/configure.ac: New file.
	* or1k/mloop.in: New file.
	* or1k/or1k-sim.h: New file.
	* or1k/or1k.c: New file.
	* or1k/sim-if.c: New file.
	* or1k/sim-main.h: New file.
	* or1k/traps.c: New file.
---
 sim/configure.tgt     |   4 +
 sim/or1k/Makefile.in  | 142 ++++++++++++++++++++++
 sim/or1k/configure.ac |  17 +++
 sim/or1k/mloop.in     | 242 +++++++++++++++++++++++++++++++++++++
 sim/or1k/or1k-sim.h   |  94 +++++++++++++++
 sim/or1k/or1k.c       | 328 ++++++++++++++++++++++++++++++++++++++++++++++++++
 sim/or1k/sim-if.c     | 270 +++++++++++++++++++++++++++++++++++++++++
 sim/or1k/sim-main.h   |  80 ++++++++++++
 sim/or1k/traps.c      | 208 ++++++++++++++++++++++++++++++++
 9 files changed, 1385 insertions(+)
 create mode 100644 sim/or1k/Makefile.in
 create mode 100644 sim/or1k/configure.ac
 create mode 100644 sim/or1k/mloop.in
 create mode 100644 sim/or1k/or1k-sim.h
 create mode 100644 sim/or1k/or1k.c
 create mode 100644 sim/or1k/sim-if.c
 create mode 100644 sim/or1k/sim-main.h
 create mode 100644 sim/or1k/traps.c

diff --git a/sim/configure.tgt b/sim/configure.tgt
index c958fb3..82b0e89 100644
--- a/sim/configure.tgt
+++ b/sim/configure.tgt
@@ -76,6 +76,10 @@ case "${target}" in
    msp430*-*-*)
        SIM_ARCH(msp430)
        ;;
+   or1k-*-* | or1knd-*-*)
+       SIM_ARCH(or1k)
+       sim_testsuite=yes
+       ;;
    rl78-*-*)
        SIM_ARCH(rl78)
        ;;
diff --git a/sim/or1k/Makefile.in b/sim/or1k/Makefile.in
new file mode 100644
index 0000000..54f0d2e
--- /dev/null
+++ b/sim/or1k/Makefile.in
@@ -0,0 +1,142 @@
+# Makefile template for configure for the or1k simulator
+# Copyright (C) 1996-2017 Free Software Foundation, Inc.
+#
+# This file is part of GDB, the GNU debugger.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 3 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+
+## COMMON_PRE_CONFIG_FRAG
+
+OR1K_OBJS = \
+	or1k.o \
+	arch.o \
+	cpu.o \
+	decode.o \
+	model.o \
+	sem.o \
+	mloop.o \
+	sim-if.o \
+	traps.o
+
+SIM_OBJS = \
+	$(SIM_NEW_COMMON_OBJS) \
+	sim-cpu.o \
+	sim-hload.o \
+	sim-hrw.o \
+	sim-reg.o \
+	cgen-utils.o \
+	cgen-trace.o \
+	cgen-scache.o \
+	cgen-run.o \
+	sim-reason.o \
+	sim-engine.o \
+	sim-model.o \
+	sim-stop.o \
+	$(TRAPS_OBJ)
+
+SIM_OBJS += $(OR1K_OBJS)
+
+# Extra headers included by sim-main.h.
+SIM_EXTRA_DEPS = \
+	$(CGEN_INCLUDE_DEPS) \
+	or1k-sim.h \
+	$(srcdir)/../../opcodes/or1k-desc.h \
+	arch.h \
+	cpuall.h \
+	decode.h
+
+SIM_EXTRA_CFLAGS =
+
+SIM_EXTRA_LIBS = -lm
+
+SIM_RUN_OBJS = nrun.o
+SIM_EXTRA_CLEAN =
+
+## COMMON_POST_CONFIG_FRAG
+
+arch = or1k
+
+# or1k32bf
+
+OR1K32BF_INCLUDE_DEPS = \
+	$(CGEN_MAIN_CPU_DEPS) \
+	cpu.h \
+	decode.h \
+	eng.h
+
+mloop.c eng.h: stamp-mloop ; @true
+stamp-mloop: $(srcdir)/../common/genmloop.sh mloop.in Makefile
+	$(SHELL) $(srccom)/genmloop.sh -shell $(SHELL) \
+		-mono -fast -pbb -switch sem-switch.c \
+		-cpu or1k32bf -infile $(srcdir)/mloop.in
+	$(SHELL) $(srcroot)/move-if-change eng.hin eng.h
+	$(SHELL) $(srcroot)/move-if-change mloop.cin mloop.c
+	touch stamp-mloop
+mloop.o: mloop.c sem-switch.c $(OR1K32BF_INCLUDE_DEPS)
+or1k.o: or1k.c $(OR1K32BF_INCLUDE_DEPS)
+	$(COMPILE) $<
+	$(POSTCOMPILE)
+arch.o: arch.c $(SIM_MAIN_DEPS)
+cpu.o: cpu.c $(OR1K32BF_INCLUDE_DEPS)
+decode.o: decode.c $(OR1K32BF_INCLUDE_DEPS)
+sem.o: sem.c $(OR1K32BF_INCLUDE_DEPS)
+sem-switch.o: sem-switch.c $(OR1K32BF_INCLUDE_DEPS)
+model.o: model.c $(OR1K32BF_INCLUDE_DEPS)
+
+sim-if.o: sim-if.c $(SIM_MAIN_DEPS) $(srcdir)/../common/sim-core.h eng.h
+	$(COMPILE) $<
+	$(POSTCOMPILE)
+
+traps.o: traps.c $(SIM_MAIN_DEPS) eng.h
+	$(COMPILE) $<
+	$(POSTCOMPILE)
+
+# cgen support, enable with --enable-cgen-maint
+CGEN_MAINT = ; @true
+# The following line is commented in or out depending upon --enable-cgen-maint.
+@CGEN_MAINT@CGEN_MAINT =
+
+stamps: stamp-arch stamp-cpu stamp-mloop
+
+# NOTE: Generated source files are specified as full paths,
+# e.g. $(srcdir)/arch.c, because make may decide the files live
+# in objdir otherwise.
+
+OR1K_CGEN_DEPS = \
+	$(CPU_DIR)/or1k.cpu \
+	$(CPU_DIR)/or1k.opc \
+	$(CPU_DIR)/or1kcommon.cpu \
+	$(CPU_DIR)/or1korbis.cpu \
+	$(CPU_DIR)/or1korfpx.cpu \
+	Makefile
+
+stamp-arch: $(CGEN_READ_SCM) $(CGEN_ARCH_SCM) $(OR1K_CGEN_DEPS)
+	$(MAKE) cgen-arch $(CGEN_FLAGS_TO_PASS) \
+	  mach=or32,or32nd \
+	  archfile=$(CPU_DIR)/or1k.cpu \
+	  FLAGS="with-scache"
+	touch $@
+$(srcdir)/arch.h $(srcdir)/arch.c $(srcdir)/cpuall.h: $(CGEN_MAINT) stamp-arch
+	@true
+
+stamp-cpu: $(CGEN_READ_SCM) $(CGEN_CPU_SCM) $(OR1K_CGEN_DEPS)
+	$(MAKE) cgen-cpu-decode $(CGEN_FLAGS_TO_PASS) \
+	  cpu=or1k32bf \
+	  mach=or32,or32nd \
+	  archfile=$(CPU_DIR)/or1k.cpu \
+	  FLAGS="with-scache" \
+	  EXTRAFILES="$(CGEN_CPU_SEM) $(CGEN_CPU_SEMSW)"
+	touch $@
+$(srcdir)/cpu.h $(srcdir)/cpu.c $(srcdir)/model.c $(srcdir)/sem.c $(srcdir)/sem-switch.c $(srcdir)/decode.c $(srcdir)/decode.h: $(CGEN_MAINT) stamp-cpu
+	@true
diff --git a/sim/or1k/configure.ac b/sim/or1k/configure.ac
new file mode 100644
index 0000000..8873a1d
--- /dev/null
+++ b/sim/or1k/configure.ac
@@ -0,0 +1,17 @@
+dnl Process this file with autoconf to produce a configure script.
+AC_PREREQ(2.64)dnl
+AC_INIT(Makefile.in)
+sinclude(../common/acinclude.m4)
+
+SIM_AC_COMMON
+
+SIM_AC_OPTION_ENDIAN(BIG)
+SIM_AC_OPTION_ALIGNMENT(STRICT_ALIGNMENT)
+SIM_AC_OPTION_BITSIZE([32], [31], [32])
+SIM_AC_OPTION_SCACHE(16384)
+SIM_AC_OPTION_DEFAULT_MODEL([or1200])
+SIM_AC_OPTION_ENVIRONMENT
+SIM_AC_OPTION_INLINE()
+SIM_AC_OPTION_CGEN_MAINT
+
+SIM_AC_OUTPUT
diff --git a/sim/or1k/mloop.in b/sim/or1k/mloop.in
new file mode 100644
index 0000000..2011150
--- /dev/null
+++ b/sim/or1k/mloop.in
@@ -0,0 +1,242 @@
+# Simulator main loop for or1k. -*- C -*-
+#
+# Copyright (C) 1996-2017 Free Software Foundation, Inc.
+#
+# This file is part of the GNU Simulators.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 3 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+
+# Syntax:
+# /bin/sh mainloop.in command
+#
+# Command is one of:
+#
+# init
+# support
+# extract-{simple,scache,pbb}
+# {full,fast}-exec-{simple,scache,pbb}
+#
+# A target need only provide a "full" version of one of simple,scache,pbb.
+# If the target wants it can also provide a fast version of same, or if
+# the slow (full featured) version is `simple', then the fast version can be
+# one of scache/pbb.
+# A target can't provide more than this.
+# However for illustration's sake this file provides examples of all.
+
+# ??? After a few more ports are done, revisit.
+# Will eventually need to machine generate a lot of this.
+
+case "x$1" in
+
+xsupport)
+
+cat <<EOF
+
+static INLINE const IDESC *
+extract (SIM_CPU *current_cpu, PCADDR pc, CGEN_INSN_INT insn,
+         ARGBUF *abuf, int fast_p)
+{
+  const IDESC *id = @cpu at _decode (current_cpu, pc, insn, insn, abuf);
+  @cpu at _fill_argbuf (current_cpu, abuf, id, pc, fast_p);
+  if (!fast_p)
+    {
+      int trace_p = PC_IN_TRACE_RANGE_P (current_cpu, pc);
+      int profile_p = PC_IN_PROFILE_RANGE_P (current_cpu, pc);
+      @cpu at _fill_argbuf_tp (current_cpu, abuf, trace_p, profile_p);
+    }
+  return id;
+}
+
+static INLINE SEM_PC
+execute (SIM_CPU *current_cpu, SCACHE *sc, int fast_p)
+{
+  SEM_PC vpc;
+
+  @cpu@_insn_before (current_cpu, vpc, sc->argbuf.idesc);
+
+  if (fast_p)
+    {
+#if ! WITH_SEM_SWITCH_FAST
+#if WITH_SCACHE
+      vpc = (*sc->argbuf.semantic.sem_fast) (current_cpu, sc);
+#else
+      vpc = (*sc->argbuf.semantic.sem_fast) (current_cpu, &sc->argbuf);
+#endif
+#else
+      abort ();
+#endif /* WITH_SEM_SWITCH_FAST */
+    }
+  else
+    {
+#if ! WITH_SEM_SWITCH_FULL
+      ARGBUF *abuf = &sc->argbuf;
+      const IDESC *idesc = abuf->idesc;
+      const CGEN_INSN *idata = idesc->idata;
+#if WITH_SCACHE_PBB
+      int virtual_p = CGEN_INSN_ATTR_VALUE (idata, CGEN_INSN_VIRTUAL);
+#else
+      int virtual_p = 0;
+#endif
+
+      if (! virtual_p)
+        {
+          /* FIXME: call x-before */
+          if (ARGBUF_PROFILE_P (abuf))
+            PROFILE_COUNT_INSN (current_cpu, abuf->addr, idesc->num);
+          /* FIXME: Later make cover macros: PROFILE_INSN_{INIT,FINI}.  */
+          if (PROFILE_MODEL_P (current_cpu)
+              && ARGBUF_PROFILE_P (abuf))
+            @cpu at _model_insn_before (current_cpu, 1 /*first_p*/);
+          CGEN_TRACE_INSN_INIT (current_cpu, abuf, 1);
+          CGEN_TRACE_INSN (current_cpu, idata,
+                      (const struct argbuf *) abuf, abuf->addr);
+        }
+#if WITH_SCACHE
+      vpc = (*sc->argbuf.semantic.sem_full) (current_cpu, sc);
+#else
+      vpc = (*sc->argbuf.semantic.sem_full) (current_cpu, abuf);
+#endif
+      if (! virtual_p)
+        {
+          /* FIXME: call x-after */
+          if (PROFILE_MODEL_P (current_cpu)
+              && ARGBUF_PROFILE_P (abuf))
+            {
+              int cycles;
+
+              cycles = (*idesc->timing->model_fn) (current_cpu, sc);
+              @cpu at _model_insn_after (current_cpu, 1 /*last_p*/, cycles);
+            }
+          CGEN_TRACE_INSN_FINI (current_cpu, abuf, 1);
+        }
+#else
+      abort ();
+#endif /* WITH_SEM_SWITCH_FULL */
+    }
+
+  @cpu at _insn_after (current_cpu, vpc, sc->argbuf.idesc);
+
+  return vpc;
+}
+
+EOF
+
+;;
+
+xinit)
+
+# Nothing needed.
+
+;;
+
+xextract-simple | xextract-scache)
+
+cat <<EOF
+{
+  USI insn = GETIMEMUSI (current_cpu, pc);
+  extract (current_cpu, pc, insn, sc, FAST_P);
+  SEM_SKIP_COMPILE (current_cpu, sc, 1);
+}
+EOF
+
+;;
+
+xextract-pbb)
+
+# Inputs:  current_cpu, pc, sc, max_insns, FAST_P
+# Outputs: sc, pc
+# sc must be left pointing past the last created entry.
+# pc must be left pointing past the last created entry.
+# If the pbb is terminated by a cti insn, SET_CTI_VPC(sc) must be called
+# to record the vpc of the cti insn.
+# SET_INSN_COUNT(n) must be called to record number of real insns.
+
+cat <<EOF
+{
+  SIM_DESC sd = CPU_STATE(current_cpu);
+  const IDESC *idesc;
+  int icount = 0;
+
+  while (max_insns > 0) {
+
+    USI insn = GETIMEMUSI (current_cpu, pc);
+
+    idesc = extract (current_cpu, pc, insn, &sc->argbuf, FAST_P);
+
+    SEM_SKIP_COMPILE (current_cpu, sc, 1);
+
+    ++sc;
+    --max_insns;
+    ++icount;
+    pc += 4;
+
+    if (CGEN_ATTR_BOOLS (CGEN_INSN_ATTRS ((idesc)->idata)) & CGEN_ATTR_MASK (CGEN_INSN_FORCED_CTI))
+      {
+
+        SET_CTI_VPC (sc - 1);
+
+        break;
+
+      }
+    else if (CGEN_ATTR_BOOLS (CGEN_INSN_ATTRS ((idesc)->idata)) & CGEN_ATTR_MASK (CGEN_INSN_DELAYED_CTI))
+      {
+
+        /* handle delay slot */
+        SET_CTI_VPC (sc - 1);
+
+        insn = GETIMEMUSI (current_cpu, pc);
+
+        idesc = extract (current_cpu, pc, insn, &sc->argbuf, FAST_P);
+
+        ++sc;
+        --max_insns;
+        ++icount;
+        pc += 4;
+
+        break;
+      }
+  }
+
+  SET_INSN_COUNT (icount);
+
+}
+EOF
+
+;;
+
+xfull-exec-* | xfast-exec-*)
+
+# Inputs: current_cpu, vpc, FAST_P
+# Outputs: vpc
+# vpc is the virtual program counter.
+
+cat <<EOF
+#if (! FAST_P && WITH_SEM_SWITCH_FULL) || (FAST_P && WITH_SEM_SWITCH_FAST)
+#define DEFINE_SWITCH
+#ifdef WANT_CPU_OR1K32BF
+#include "sem-switch.c"
+#endif
+#else
+  vpc = execute (current_cpu, vpc, FAST_P);
+#endif
+EOF
+
+;;
+
+*)
+  echo "Invalid argument to mainloop.in: $1" >&2
+  exit 1
+  ;;
+
+esac
diff --git a/sim/or1k/or1k-sim.h b/sim/or1k/or1k-sim.h
new file mode 100644
index 0000000..becaf3f
--- /dev/null
+++ b/sim/or1k/or1k-sim.h
@@ -0,0 +1,94 @@
+/* OpenRISC simulator support code header
+   Copyright (C) 1996-2017 Free Software Foundation, Inc.
+
+   This file is part of GDB, the GNU debugger.
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
+#ifndef OR1K_SIM_H
+#define OR1K_SIM_H
+
+#include "symcat.h"
+
+/* GDB register numbers.  */
+#define PPC_REGNUM	32
+#define PC_REGNUM	33
+#define SR_REGNUM	34
+
+/* Misc. profile data.  */
+typedef struct
+{
+} OR1K_MISC_PROFILE;
+
+/* Nop codes used in nop simulation.  */
+#define NOP_NOP         0x0
+#define NOP_EXIT        0x1
+#define NOP_REPORT      0x2
+#define NOP_PUTC        0x4
+#define NOP_CNT_RESET   0x5
+#define NOP_GET_TICKS   0x6
+#define NOP_GET_PS      0x7
+#define NOP_TRACE_ON    0x8
+#define NOP_TRACE_OFF   0x9
+#define NOP_RANDOM      0xa
+#define NOP_OR1KSIM     0xb
+#define NOP_EXIT_SILENT 0xc
+
+#define NUM_SPR 0x20000
+#define SPR_GROUP_SHIFT 11
+#define SPR_GROUP_FIRST(group) (((UWI) SPR_GROUP_##group) << SPR_GROUP_SHIFT)
+#define SPR_ADDR(group,index) (SPR_GROUP_FIRST(group) | ((UWI) SPR_INDEX_##group##_##index))
+
+/* Define word getters and setter helpers based on those from sim/common/cgen-mem.h.  */
+#define GETTWI GETTSI
+#define SETTWI SETTSI
+
+void or1k_cpu_init (SIM_DESC sd, sim_cpu * current_cpu, const USI or1k_vr,
+		    const USI or1k_upr, const USI or1k_cpucfgr);
+
+void or1k32bf_insn_before (sim_cpu * current_cpu, SEM_PC vpc, IDESC * idesc);
+void or1k32bf_insn_after (sim_cpu * current_cpu, SEM_PC vpc, IDESC * idesc);
+void or1k32bf_exception (sim_cpu * current_cpu, USI pc, USI exnum);
+void or1k32bf_rfe (sim_cpu * current_cpu);
+void or1k32bf_nop (sim_cpu * current_cpu, USI uimm16);
+USI or1k32bf_mfspr (sim_cpu * current_cpu, USI addr);
+void or1k32bf_mtspr (sim_cpu * current_cpu, USI addr, USI val);
+
+int or1k32bf_fetch_register (sim_cpu * current_cpu, int rn,
+			     unsigned char *buf, int len);
+int or1k32bf_store_register (sim_cpu * current_cpu, int rn,
+			     unsigned char *buf, int len);
+int or1k32bf_model_or1200_u_exec (sim_cpu * UNUSED current_cpu,
+				  const IDESC * UNUSED idesc, int unit_num,
+				  int referenced);
+int or1k32bf_model_or1200nd_u_exec (sim_cpu * UNUSED current_cpu,
+				    const IDESC * UNUSED idesc, int unit_num,
+				    int referenced);
+void or1k32bf_model_insn_before (sim_cpu * UNUSED current_cpu,
+				 int UNUSED first_p);
+void or1k32bf_model_insn_after (sim_cpu * UNUSED current_cpu,
+				int UNUSED last_p, int UNUSED cycles);
+USI or1k32bf_h_spr_get_raw (sim_cpu * current_cpu, USI addr);
+void or1k32bf_h_spr_set_raw (sim_cpu * current_cpu, USI addr, USI val);
+USI or1k32bf_h_spr_field_get_raw (sim_cpu * current_cpu, USI addr, int msb,
+				  int lsb);
+void or1k32bf_h_spr_field_set_raw (sim_cpu * current_cpu, USI addr, int msb,
+				   int lsb, USI val);
+USI or1k32bf_make_load_store_addr (sim_cpu * current_cpu, USI base, SI offset,
+				   int size);
+
+USI or1k32bf_ff1 (sim_cpu * current_cpu, USI val);
+USI or1k32bf_fl1 (sim_cpu * current_cpu, USI val);
+
+#endif /* OR1K_SIM_H */
diff --git a/sim/or1k/or1k.c b/sim/or1k/or1k.c
new file mode 100644
index 0000000..a3913d3
--- /dev/null
+++ b/sim/or1k/or1k.c
@@ -0,0 +1,328 @@
+/* OpenRISC simulator support code
+   Copyright (C) 1996-2017 Free Software Foundation, Inc.
+
+   This file is part of GDB, the GNU debugger.
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
+#define WANT_CPU_OR1K32BF
+#define WANT_CPU
+
+#include "sim-main.h"
+#include "symcat.h"
+#include "cgen-ops.h"
+#include "cgen-mem.h"
+#include "cpuall.h"
+
+#include <string.h>
+
+int
+or1k32bf_fetch_register (sim_cpu * current_cpu, int rn,
+			 unsigned char *buf, int len)
+{
+  if (rn < 32)
+    SETTWI (buf, GET_H_GPR (rn));
+  else
+    switch (rn)
+      {
+      case PPC_REGNUM:
+	SETTWI (buf, GET_H_SYS_PPC ());
+	break;
+      case PC_REGNUM:
+	SETTWI (buf, GET_H_PC ());
+	break;
+      case SR_REGNUM:
+	SETTWI (buf, GET_H_SYS_SR ());
+	break;
+      default:
+	return 0;
+      }
+  return sizeof (WI);		/* WI from arch.h */
+}
+
+int
+or1k32bf_store_register (sim_cpu * current_cpu, int rn,
+			 unsigned char *buf, int len)
+{
+  if (rn < 32)
+    SET_H_GPR (rn, GETTWI (buf));
+  else
+    switch (rn)
+      {
+      case PPC_REGNUM:
+	SET_H_SYS_PPC (GETTWI (buf));
+	break;
+      case PC_REGNUM:
+	SET_H_PC (GETTWI (buf));
+	break;
+      case SR_REGNUM:
+	SET_H_SYS_SR (GETTWI (buf));
+	break;
+      default:
+	return 0;
+      }
+  return sizeof (WI);		/* WI from arch.h */
+}
+
+int
+or1k32bf_model_or1200_u_exec (sim_cpu * UNUSED current_cpu,
+			      const IDESC * UNUSED idesc, int unit_num,
+			      int referenced)
+{
+  return -1;
+}
+
+int
+or1k32bf_model_or1200nd_u_exec (sim_cpu * UNUSED current_cpu,
+				const IDESC * UNUSED idesc, int unit_num,
+				int referenced)
+{
+  return -1;
+}
+
+void
+or1k32bf_model_insn_before (sim_cpu * UNUSED current_cpu, int UNUSED first_p)
+{
+}
+
+void
+or1k32bf_model_insn_after (sim_cpu * UNUSED current_cpu, int UNUSED last_p,
+			   int UNUSED cycles)
+{
+}
+
+USI
+or1k32bf_h_spr_get_raw (sim_cpu * current_cpu, USI addr)
+{
+  SIM_DESC sd = CPU_STATE (current_cpu);
+  SIM_ASSERT (addr < NUM_SPR);
+  return current_cpu->spr[addr];
+}
+
+void
+or1k32bf_h_spr_set_raw (sim_cpu * current_cpu, USI addr, USI val)
+{
+  SIM_DESC sd = CPU_STATE (current_cpu);
+  SIM_ASSERT (addr < NUM_SPR);
+  current_cpu->spr[addr] = val;
+}
+
+USI
+or1k32bf_h_spr_field_get_raw (sim_cpu * current_cpu, USI addr, int msb,
+			      int lsb)
+{
+  SIM_DESC sd = CPU_STATE (current_cpu);
+  SIM_ASSERT (addr < NUM_SPR);
+  return LSEXTRACTED (current_cpu->spr[addr], msb, lsb);
+}
+
+void
+or1k32bf_h_spr_field_set_raw (sim_cpu * current_cpu, USI addr, int msb,
+			      int lsb, USI val)
+{
+  current_cpu->spr[addr] &= ~LSMASK32 (msb, lsb);
+  current_cpu->spr[addr] |= LSINSERTED (val, msb, lsb);
+}
+
+void
+or1k_cpu_init (SIM_DESC sd, sim_cpu * current_cpu, const USI or1k_vr,
+	       const USI or1k_upr, const USI or1k_cpucfgr)
+{
+  SET_H_SYS_VR (or1k_vr);
+  SET_H_SYS_UPR (or1k_upr);
+  SET_H_SYS_CPUCFGR (or1k_cpucfgr);
+
+#define CHECK_SPR_FIELD(GROUP, INDEX, FIELD, test)                      \
+  do {                                                                  \
+    USI field = GET_H_##SYS##_##INDEX##_##FIELD ();                     \
+    if (!(test)) {                                                      \
+      sim_io_eprintf(sd, "WARNING: unsupported %s field in %s register: 0x%x\n", \
+                     #FIELD, #INDEX, field);                            \
+    }                                                                   \
+  } while (0)
+
+  current_cpu->next_delay_slot = 0;
+  current_cpu->delay_slot = 0;
+
+  CHECK_SPR_FIELD (SYS, UPR, UP, field == 1);
+  CHECK_SPR_FIELD (SYS, UPR, DCP, field == 0);
+  CHECK_SPR_FIELD (SYS, UPR, ICP, field == 0);
+  CHECK_SPR_FIELD (SYS, UPR, DMP, field == 0);
+  CHECK_SPR_FIELD (SYS, UPR, MP, field == 0);
+  CHECK_SPR_FIELD (SYS, UPR, IMP, field == 0);
+  CHECK_SPR_FIELD (SYS, UPR, DUP, field == 0);
+  CHECK_SPR_FIELD (SYS, UPR, PCUP, field == 0);
+  CHECK_SPR_FIELD (SYS, UPR, PICP, field == 0);
+  CHECK_SPR_FIELD (SYS, UPR, PMP, field == 0);
+  CHECK_SPR_FIELD (SYS, UPR, TTP, field == 0);
+  CHECK_SPR_FIELD (SYS, UPR, CUP, field == 0);
+
+  CHECK_SPR_FIELD (SYS, CPUCFGR, NSGR, field == 0);
+  CHECK_SPR_FIELD (SYS, CPUCFGR, CGF, field == 0);
+  CHECK_SPR_FIELD (SYS, CPUCFGR, OB32S, field == 1);
+  CHECK_SPR_FIELD (SYS, CPUCFGR, OB64S, field == 0);
+  CHECK_SPR_FIELD (SYS, CPUCFGR, OF64S, field == 0);
+  CHECK_SPR_FIELD (SYS, CPUCFGR, OV64S, field == 0);
+
+#undef CHECK_SPR_FIELD
+
+  SET_H_SYS_UPR_UP (1);
+
+  SET_H_SYS_SR (SPR_FIELD_MASK_SYS_SR_SM | SPR_FIELD_MASK_SYS_SR_FO);
+
+  SET_H_SYS_FPCSR (0);
+}
+
+void
+or1k32bf_insn_before (sim_cpu * current_cpu, SEM_PC vpc, IDESC * idesc)
+{
+  SIM_DESC sd = CPU_STATE (current_cpu);
+
+  current_cpu->delay_slot = current_cpu->next_delay_slot;
+  current_cpu->next_delay_slot = 0;
+
+  if (current_cpu->delay_slot &&
+      CGEN_ATTR_BOOLS (CGEN_INSN_ATTRS ((idesc)->idata)) &
+      CGEN_ATTR_MASK (CGEN_INSN_NOT_IN_DELAY_SLOT))
+    {
+      USI pc;
+#ifdef WITH_SCACHE
+      pc = vpc->argbuf.addr;
+#else
+      pc = vpc;
+#endif
+      sim_io_error (sd, "invalid instruction in a delay slot at PC 0x%08x",
+		    pc);
+    }
+
+}
+
+void
+or1k32bf_insn_after (sim_cpu * current_cpu, SEM_PC vpc, IDESC * idesc)
+{
+  SIM_DESC sd = CPU_STATE (current_cpu);
+  USI ppc;
+
+#ifdef WITH_SCACHE
+  ppc = vpc->argbuf.addr;
+#else
+  ppc = vpc;
+#endif
+
+  SET_H_SYS_PPC (ppc);
+
+  if (!GET_H_SYS_CPUCFGR_ND () &&
+      CGEN_ATTR_BOOLS (CGEN_INSN_ATTRS ((idesc)->idata)) &
+      CGEN_ATTR_MASK (CGEN_INSN_DELAYED_CTI))
+    {
+      SIM_ASSERT (!current_cpu->delay_slot);
+      current_cpu->next_delay_slot = 1;
+    }
+}
+
+void
+or1k32bf_nop (sim_cpu * current_cpu, USI uimm16)
+{
+  SIM_DESC sd = CPU_STATE (current_cpu);
+
+  switch (uimm16)
+    {
+
+    case NOP_NOP:
+      break;
+
+    case NOP_EXIT:
+      sim_io_printf (CPU_STATE (current_cpu), "exit(%d)\n", GET_H_GPR (3));
+      /* fall through */
+    case NOP_EXIT_SILENT:
+      sim_engine_halt (sd, current_cpu, NULL, CPU_PC_GET (current_cpu),
+		       sim_exited, GET_H_GPR (3));
+      break;
+
+    case NOP_REPORT:
+      sim_io_printf (CPU_STATE (current_cpu), "report(0x%08x);\n",
+		     GET_H_GPR (3));
+      break;
+
+    case NOP_PUTC:
+      sim_io_printf (CPU_STATE (current_cpu), "%c",
+		     (char) (GET_H_GPR (3) & 0xff));
+      break;
+
+    default:
+      sim_io_eprintf (sd, "WARNING: l.nop with unsupported code 0x%08x\n",
+		      uimm16);
+      break;
+    }
+
+}
+
+USI
+or1k32bf_make_load_store_addr (sim_cpu * current_cpu, USI base, SI offset,
+			       int size)
+{
+  SIM_DESC sd = CPU_STATE (current_cpu);
+
+  USI addr = base + offset;
+
+  if (GET_H_SYS_SR_LEE ())
+    {
+      switch (size)
+	{
+
+	case 4:
+	  break;
+
+	case 2:
+	  addr ^= 0x2;
+	  break;
+
+	case 1:
+	  addr ^= 0x3;
+	  break;
+
+	default:
+	  SIM_ASSERT (0);
+	  return 0;
+	}
+    }
+
+  return addr;
+}
+
+USI
+or1k32bf_ff1 (sim_cpu * current_cpu, USI val)
+{
+  USI bit;
+  USI ret;
+  for (bit = 1, ret = 1; bit; bit <<= 1, ret++)
+    {
+      if (val & bit)
+	return ret;
+    }
+  return 0;
+}
+
+USI
+or1k32bf_fl1 (sim_cpu * current_cpu, USI val)
+{
+  USI bit;
+  USI ret;
+  for (bit = 1 << 31, ret = 32; bit; bit >>= 1, ret--)
+    {
+      if (val & bit)
+	return ret;
+    }
+  return 0;
+}
diff --git a/sim/or1k/sim-if.c b/sim/or1k/sim-if.c
new file mode 100644
index 0000000..1a5b930
--- /dev/null
+++ b/sim/or1k/sim-if.c
@@ -0,0 +1,270 @@
+/* Main simulator entry points specific to the OR1K.
+   Copyright (C) 1996-2017 Free Software Foundation, Inc.
+
+   This file is part of GDB, the GNU debugger.
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
+#include "sim-main.h"
+#include "sim-options.h"
+#include "libiberty.h"
+#include "bfd.h"
+
+#ifdef HAVE_STRING_H
+#include <string.h>
+#else
+#ifdef HAVE_STRINGS_H
+#include <strings.h>
+#endif
+#endif
+#ifdef HAVE_STDLIB_H
+#include <stdlib.h>
+#endif
+
+static void free_state (SIM_DESC);
+
+
+/* Cover function of sim_state_free to free the cpu buffers as well.  */
+
+static void
+free_state (SIM_DESC sd)
+{
+  if (STATE_MODULES (sd) != NULL)
+    sim_module_uninstall (sd);
+  sim_cpu_free_all (sd);
+  sim_state_free (sd);
+}
+
+static const USI or1k_default_vr = 0x0;
+static const USI or1k_default_upr = 0x0
+  | SPR_FIELD_MASK_SYS_UPR_UP;
+static const USI or1k_default_cpucfgr = 0x0
+  | SPR_FIELD_MASK_SYS_CPUCFGR_OB32S
+  | SPR_FIELD_MASK_SYS_CPUCFGR_OF32S;
+
+static UWI or1k_upr;
+static UWI or1k_vr;
+static UWI or1k_cpucfgr;
+
+enum
+{
+  OPTION_OR1K_VR,
+  OPTION_OR1K_UPR,
+  OPTION_OR1K_CPUCFGR = OPTION_START,
+};
+
+DECLARE_OPTION_HANDLER (or1k_option_handler);
+
+static const OPTION or1k_options[] = {
+  {{"or1k-cpucfgr", required_argument, NULL, OPTION_OR1K_CPUCFGR},
+   '\0', "INTEGER|default", "Set simulator CPUCFGR value",
+   or1k_option_handler},
+  {{"or1k-vr", required_argument, NULL, OPTION_OR1K_VR},
+   '\0', "INTEGER|default", "Set simulator VR value",
+   or1k_option_handler},
+  {{"or1k-upr", required_argument, NULL, OPTION_OR1K_UPR},
+   '\0', "INTEGER|default", "Set simulator UPR value",
+   or1k_option_handler},
+  {{NULL, no_argument, NULL, 0}, '\0', NULL, NULL, NULL}
+};
+
+SIM_RC
+or1k_option_handler (SIM_DESC sd, sim_cpu * cpu, int opt,
+		     char *arg, int is_command)
+{
+  switch (opt)
+    {
+    case OPTION_OR1K_VR:
+      if (strcmp ("default", arg) == 0)
+	or1k_vr = or1k_default_vr;
+      else
+	{
+	  unsigned long long n;
+	  char *endptr;
+
+	  n = strtoull (arg, &endptr, 0);
+	  if (*arg != '\0' && *endptr == '\0')
+	    or1k_vr = n;
+	  else
+	    return SIM_RC_FAIL;
+	}
+      return SIM_RC_OK;
+
+    case OPTION_OR1K_UPR:
+      if (strcmp ("default", arg) == 0)
+	or1k_upr = or1k_default_upr;
+      else
+	{
+	  unsigned long long n;
+	  char *endptr;
+
+	  n = strtoull (arg, &endptr, 0);
+	  if (*arg != '\0' && *endptr == '\0')
+	    or1k_upr = n;
+	  else
+	    {
+	      sim_io_eprintf (sd,
+			      "invalid argument to option --or1k-upr: `%s'\n",
+			      arg);
+	      return SIM_RC_FAIL;
+	    }
+	}
+      return SIM_RC_OK;
+
+    case OPTION_OR1K_CPUCFGR:
+      if (strcmp ("default", arg) == 0)
+	or1k_cpucfgr = or1k_default_cpucfgr;
+      else
+	{
+	  unsigned long long n;
+	  char *endptr;
+
+	  n = strtoull (arg, &endptr, 0);
+	  if (*arg != '\0' && *endptr == '\0')
+	    or1k_cpucfgr = n;
+	  else
+	    {
+	      sim_io_eprintf (sd,
+			      "invalid argument to option --or1k-cpucfgr: `%s'\n",
+			      arg);
+	      return SIM_RC_FAIL;
+	    }
+	}
+      return SIM_RC_OK;
+
+    default:
+      sim_io_eprintf (sd, "Unknown or1k option %d\n", opt);
+      return SIM_RC_FAIL;
+    }
+
+  return SIM_RC_FAIL;
+}
+
+/* Create an instance of the simulator.  */
+
+SIM_DESC
+sim_open (SIM_OPEN_KIND kind, host_callback * callback,
+	  struct bfd * abfd, char *const *argv)
+{
+  SIM_DESC sd = sim_state_alloc (kind, callback);
+  char c;
+  int i;
+
+  /* The cpu data is kept in a separately allocated chunk of memory.  */
+  if (sim_cpu_alloc_all (sd, 1, cgen_cpu_max_extra_bytes ()) != SIM_RC_OK)
+    {
+      free_state (sd);
+      return 0;
+    }
+
+  if (sim_pre_argv_init (sd, argv[0]) != SIM_RC_OK)
+    {
+      free_state (sd);
+      return 0;
+    }
+
+  or1k_upr = or1k_default_upr;
+  or1k_vr = or1k_default_vr;
+  or1k_cpucfgr = or1k_default_cpucfgr;
+  sim_add_option_table (sd, NULL, or1k_options);
+
+  if (sim_parse_args (sd, argv) != SIM_RC_OK)
+    {
+      free_state (sd);
+      return 0;
+    }
+
+  /* Allocate core managed memory if none specified by user.
+     Use address 4 here in case the user wanted address 0 unmapped.  */
+  if (sim_core_read_buffer (sd, NULL, read_map, &c, 4, 1) == 0)
+    {
+      sim_do_commandf (sd, "memory region 0,0x%x", OR1K_DEFAULT_MEM_SIZE);
+    }
+
+  /* Check for/establish the reference program image.  */
+  if (sim_analyze_program (sd,
+			   (STATE_PROG_ARGV (sd) != NULL
+			    ? *STATE_PROG_ARGV (sd)
+			    : NULL), abfd) != SIM_RC_OK)
+    {
+      free_state (sd);
+      return 0;
+    }
+
+  /* Establish any remaining configuration options.  */
+  if (sim_config (sd) != SIM_RC_OK)
+    {
+      free_state (sd);
+      return 0;
+    }
+
+  if (sim_post_argv_init (sd) != SIM_RC_OK)
+    {
+      free_state (sd);
+      return 0;
+    }
+
+  /* Make sure delay slot mode is consistent with the loaded binary.  */
+  if (STATE_ARCHITECTURE (sd)->mach == bfd_mach_or1knd)
+    or1k_cpucfgr |= SPR_FIELD_MASK_SYS_CPUCFGR_ND;
+  else
+    or1k_cpucfgr &= ~SPR_FIELD_MASK_SYS_CPUCFGR_ND;
+
+  /* Open a copy of the cpu descriptor table.  */
+  {
+    CGEN_CPU_DESC cd =
+      or1k_cgen_cpu_open_1 (STATE_ARCHITECTURE (sd)->printable_name,
+			    CGEN_ENDIAN_BIG);
+    for (i = 0; i < MAX_NR_PROCESSORS; ++i)
+      {
+	SIM_CPU *cpu = STATE_CPU (sd, i);
+	CPU_CPU_DESC (cpu) = cd;
+	CPU_DISASSEMBLER (cpu) = sim_cgen_disassemble_insn;
+      }
+    or1k_cgen_init_dis (cd);
+  }
+
+  /* Initialize various cgen things not done by common framework.
+     Must be done after or1k_cgen_cpu_open.  */
+  cgen_init (sd);
+
+  for (c = 0; c < MAX_NR_PROCESSORS; ++c)
+    {
+      SIM_CPU *cpu = STATE_CPU (sd, i);
+      /* Only needed for profiling, but the structure member is small.  */
+      memset (CPU_OR1K_MISC_PROFILE (cpu), 0,
+	      sizeof (*CPU_OR1K_MISC_PROFILE (cpu)));
+
+      or1k_cpu_init (sd, cpu, or1k_vr, or1k_upr, or1k_cpucfgr);
+    }
+
+  return sd;
+}
+
+
+SIM_RC
+sim_create_inferior (SIM_DESC sd, struct bfd * abfd,
+		     char *const *argv, char *const *envp)
+{
+  SIM_CPU *current_cpu = STATE_CPU (sd, 0);
+  SIM_ADDR addr;
+
+  if (abfd != NULL)
+    addr = bfd_get_start_address (abfd);
+  else
+    addr = 0;
+  sim_pc_set (current_cpu, addr);
+
+  return SIM_RC_OK;
+}
diff --git a/sim/or1k/sim-main.h b/sim/or1k/sim-main.h
new file mode 100644
index 0000000..4efb80e
--- /dev/null
+++ b/sim/or1k/sim-main.h
@@ -0,0 +1,80 @@
+/* OpenRISC simulator main header
+   Copyright (C) 1996-2017 Free Software Foundation, Inc.
+
+   This file is part of GDB, the GNU debugger.
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
+#ifndef SIM_MAIN_H
+#define SIM_MAIN_H
+
+#define WITH_SCACHE_PBB 1
+
+#include "ansidecl.h"
+#include "or1k-desc.h"
+#include "sim-basics.h"
+#include "cgen-types.h"
+#include "arch.h"
+#include "sim-base.h"
+
+#include "or1k-opc.h"
+#include "cgen-sim.h"
+#include "or1k-sim.h"
+
+#define OR1K_DEFAULT_MEM_SIZE 0x800000	/* 8M */
+
+/* The _sim_cpu struct.  */
+struct _sim_cpu
+{
+  /* sim/common cpu base.  */
+  sim_cpu_base base;
+
+  /* Static parts of cgen.  */
+  CGEN_CPU cgen_cpu;
+
+  OR1K_MISC_PROFILE or1k_misc_profile;
+#define CPU_OR1K_MISC_PROFILE(cpu) (& (cpu)->or1k_misc_profile)
+
+  /* CPU specific parts go here.
+     Note that in files that don't need to access these pieces WANT_CPU_FOO
+     won't be defined and thus these parts won't appear.  This is ok in the
+     sense that things work.  It is a source of bugs though.
+     One has to of course be careful to not take the size of this
+     struct and no structure members accessed in non-cpu specific files can
+     go after here.  Oh for a better language.  */
+  UWI spr[NUM_SPR];
+
+  /* Next instruction will be in delay slot.  */
+  BI next_delay_slot;
+  /* Currently in delay slot.  */
+  BI delay_slot;
+
+#ifdef WANT_CPU_OR1K32BF
+  OR1K32BF_CPU_DATA cpu_data;
+#endif
+};
+
+
+
+/* The sim_state struct.  */
+struct sim_state
+{
+  sim_cpu *cpu[MAX_NR_PROCESSORS];
+
+  CGEN_STATE cgen_state;
+
+  sim_state_base base;
+};
+
+#endif /* SIM_MAIN_H */
diff --git a/sim/or1k/traps.c b/sim/or1k/traps.c
new file mode 100644
index 0000000..6691fb9
--- /dev/null
+++ b/sim/or1k/traps.c
@@ -0,0 +1,208 @@
+/* OpenRISC exception, interrupts, syscall and trap support
+   Copyright (C) 1996-2017 Free Software Foundation, Inc.
+
+   This file is part of GDB, the GNU debugger.
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
+#define WANT_CPU_OR1K32BF
+#define WANT_CPU
+
+#include "sim-main.h"
+#include "cgen-ops.h"
+
+SEM_PC
+sim_engine_invalid_insn (SIM_CPU * current_cpu, IADDR cia, SEM_PC vpc)
+{
+  SET_H_SYS_EEAR0 (cia);
+
+#ifdef WANT_CPU_OR1K32BF
+  or1k32bf_exception (current_cpu, cia, EXCEPT_ILLEGAL);
+#endif
+
+  return vpc;
+}
+
+void
+or1k32bf_exception (sim_cpu * current_cpu, USI pc, USI exnum)
+{
+  SIM_DESC sd = CPU_STATE (current_cpu);
+
+  if (exnum == EXCEPT_TRAP)
+    {
+      /* Trap, used for breakpoints, sends control back to gdb breakpoint handling.  */
+      sim_engine_halt (sd, current_cpu, NULL, pc, sim_stopped, SIM_SIGTRAP);
+    }
+  else
+    {
+
+      /* Calculate the exception program counter.  */
+      switch (exnum)
+	{
+	case EXCEPT_RESET:
+	  break;
+
+	case EXCEPT_SYSCALL:
+	  SET_H_SYS_EPCR0 (pc + 4 - (current_cpu->delay_slot ? 4 : 0));
+	  break;
+
+	case EXCEPT_BUSERR:
+	case EXCEPT_ALIGN:
+	case EXCEPT_ILLEGAL:
+	  SET_H_SYS_EPCR0 (pc - (current_cpu->delay_slot ? 4 : 0));
+	  break;
+
+	default:
+	  sim_io_error (sd, "unexpected exception 0x%x raised at PC 0x%08x",
+			exnum, pc);
+	  break;
+	}
+
+      /* Store the curent SR into ESR0.  */
+      SET_H_SYS_ESR0 (GET_H_SYS_SR ());
+
+      /* Indicate in SR if the failed instruction is in delay slot or not.  */
+      SET_H_SYS_SR_DSX (current_cpu->delay_slot);
+
+      current_cpu->next_delay_slot = 0;
+
+      /* Jump program counter into handler.  */
+      IADDR handler_pc =
+	(GET_H_SYS_SR_EPH ()? 0xf0000000 : 0x00000000) + (exnum << 8);
+
+      sim_engine_restart (sd, current_cpu, NULL, handler_pc);
+    }
+}
+
+void
+or1k32bf_rfe (sim_cpu * current_cpu)
+{
+  SET_H_SYS_SR (GET_H_SYS_ESR0 ());
+  SET_H_SYS_SR_FO (1);
+
+  current_cpu->next_delay_slot = 0;
+
+  sim_engine_restart (CPU_STATE (current_cpu),
+		      current_cpu, NULL, GET_H_SYS_EPCR0 ());
+}
+
+USI
+or1k32bf_mfspr (sim_cpu * current_cpu, USI addr)
+{
+  SIM_DESC sd = CPU_STATE (current_cpu);
+
+  if (!GET_H_SYS_SR_SM () && !GET_H_SYS_SR_SUMRA ())
+    {
+      sim_io_eprintf (sd, "WARNING: l.mfspr in user mode (SR 0x%x)\n",
+		      GET_H_SYS_SR ());
+      return 0;
+    }
+
+  if (addr >= NUM_SPR)
+    goto bad_address;
+
+  SI val = GET_H_SPR (addr);
+
+  switch (addr)
+    {
+
+    case SPR_ADDR (SYS, VR):
+    case SPR_ADDR (SYS, UPR):
+    case SPR_ADDR (SYS, CPUCFGR):
+    case SPR_ADDR (SYS, SR):
+    case SPR_ADDR (SYS, PPC):
+    case SPR_ADDR (SYS, FPCSR):
+    case SPR_ADDR (SYS, EPCR0):
+    case SPR_ADDR (MAC, MACLO):
+    case SPR_ADDR (MAC, MACHI):
+      break;
+
+    default:
+      if (addr < SPR_ADDR (SYS, GPR0) || addr > SPR_ADDR (SYS, GPR511))
+	goto bad_address;
+      break;
+
+    }
+
+  return val;
+
+bad_address:
+  sim_io_eprintf (sd, "WARNING: l.mfspr with invalid SPR address 0x%x\n",
+		  addr);
+  return 0;
+
+}
+
+void
+or1k32bf_mtspr (sim_cpu * current_cpu, USI addr, USI val)
+{
+  SIM_DESC sd = CPU_STATE (current_cpu);
+
+  if (!GET_H_SYS_SR_SM () && !GET_H_SYS_SR_SUMRA ())
+    {
+      sim_io_eprintf (sd,
+		      "WARNING: l.mtspr with address 0x%x in user mode (SR 0x%x)\n",
+		      addr, GET_H_SYS_SR ());
+      return;
+    }
+
+  if (addr >= NUM_SPR)
+    goto bad_address;
+
+  switch (addr)
+    {
+
+    case SPR_ADDR (SYS, FPCSR):
+    case SPR_ADDR (SYS, EPCR0):
+    case SPR_ADDR (SYS, ESR0):
+    case SPR_ADDR (MAC, MACHI):
+    case SPR_ADDR (MAC, MACLO):
+      SET_H_SPR (addr, val);
+      break;
+
+    case SPR_ADDR (SYS, SR):
+      SET_H_SPR (addr, val);
+      SET_H_SYS_SR_FO (1);
+      break;
+
+    case SPR_ADDR (SYS, NPC):
+      current_cpu->next_delay_slot = 0;
+
+      sim_engine_restart (CPU_STATE (current_cpu), current_cpu, NULL, val);
+      break;
+
+    case SPR_ADDR (TICK, TTMR):
+      /* Allow some registers to be silently cleared.  */
+      if (val != 0)
+	sim_io_eprintf (sd,
+			"WARNING: l.mtspr to SPR address 0x%x with invalid value 0x%x\n",
+			addr, val);
+      break;
+
+    default:
+      if (addr >= SPR_ADDR (SYS, GPR0) && addr <= SPR_ADDR (SYS, GPR511))
+	SET_H_SPR (addr, val);
+      else
+	goto bad_address;
+      break;
+
+    }
+
+  return;
+
+bad_address:
+  sim_io_eprintf (sd, "WARNING: l.mtspr with invalid SPR address 0x%x\n",
+		  addr);
+
+}
-- 
2.9.3

