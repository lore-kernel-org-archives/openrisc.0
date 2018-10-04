From: Stafford Horne <shorne@gmail.com>
Date: Thu,  4 Oct 2018 12:23:17 +0900
Subject: [OpenRISC] [PATCH v3 5/5] or1k: Add OpenRISC gas documentation
In-Reply-To: <20181004032317.17478-1-shorne@gmail.com>
References: <20181004032317.17478-1-shorne@gmail.com>
Message-ID: <20181004032317.17478-6-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>

gas/ChangeLog:

	* doc/Makefile.am (CPU_DOCS): Add entry for OpenRISC.
	* doc/Makefile.in: Regenerated.
	* doc/all.texi: Set OPENRISC.
	* doc/as.texi: Document OpenRISC.
	* doc/c-or1k.texi: New file.
---
 gas/doc/Makefile.am |   1 +
 gas/doc/Makefile.in |   1 +
 gas/doc/all.texi    |   1 +
 gas/doc/as.texi     |  10 ++
 gas/doc/c-or1k.texi | 300 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 313 insertions(+)
 create mode 100644 gas/doc/c-or1k.texi

diff --git a/gas/doc/Makefile.am b/gas/doc/Makefile.am
index 210f2e49f3..e2e4327949 100644
--- a/gas/doc/Makefile.am
+++ b/gas/doc/Makefile.am
@@ -76,6 +76,7 @@ CPU_DOCS = \
 	c-nios2.texi \
 	c-nds32.texi \
 	c-ns32k.texi \
+	c-or1k.texi \
 	c-pdp11.texi \
 	c-pj.texi \
 	c-ppc.texi \
diff --git a/gas/doc/Makefile.in b/gas/doc/Makefile.in
index 765e6b0b66..855259d76e 100644
--- a/gas/doc/Makefile.in
+++ b/gas/doc/Makefile.in
@@ -431,6 +431,7 @@ CPU_DOCS = \
 	c-nios2.texi \
 	c-nds32.texi \
 	c-ns32k.texi \
+	c-or1k.texi \
 	c-pdp11.texi \
 	c-pj.texi \
 	c-ppc.texi \
diff --git a/gas/doc/all.texi b/gas/doc/all.texi
index ef103de78b..23ca4eaacb 100644
--- a/gas/doc/all.texi
+++ b/gas/doc/all.texi
@@ -59,6 +59,7 @@
 @set NIOSII
 @set NDS32
 @set NS32K
+ at set OPENRISC
 @set PDP11
 @set PJ
 @set PPC
diff --git a/gas/doc/as.texi b/gas/doc/as.texi
index f3285b63ea..acecd35225 100644
--- a/gas/doc/as.texi
+++ b/gas/doc/as.texi
@@ -482,6 +482,9 @@ gcc(1), ld(1), and the Info entries for @file{binutils} and @file{ld}.
     [@b{-mfull-regs}] [@b{-m[no-]dx-regs}] [@b{-mpic}] [@b{-mno-relax}]
     [@b{-mb2bb}]
 @end ifset
+ at ifset OPENRISC
+ at c OpenRISC has no machine-dependent assembler options.
+ at end ifset
 @ifset PDP11
 
 @emph{Target PDP11 options:}
@@ -7678,6 +7681,9 @@ subject, see the hardware manufacturer's manual.
 @ifset NS32K
 * NS32K-Dependent::		NS32K Dependent Features
 @end ifset
+ at ifset OPENRISC
+* OpenRISC-Dependent::		OpenRISC 1000 Features
+ at end ifset
 @ifset PDP11
 * PDP-11-Dependent::            PDP-11 Dependent Features
 @end ifset
@@ -7905,6 +7911,10 @@ family.
 @include c-ns32k.texi
 @end ifset
 
+ at ifset OPENRISC
+ at include c-or1k.texi
+ at end ifset
+
 @ifset PDP11
 @include c-pdp11.texi
 @end ifset
diff --git a/gas/doc/c-or1k.texi b/gas/doc/c-or1k.texi
new file mode 100644
index 0000000000..0260fb1117
--- /dev/null
+++ b/gas/doc/c-or1k.texi
@@ -0,0 +1,300 @@
+ at c Copyright (C) 1991-2018 Free Software Foundation, Inc.
+ at c This is part of the GAS manual.
+ at c For copying conditions, see the file as.texinfo.
+ at ifset GENERIC
+ at page
+ at node OpenRISC-Dependent
+ at chapter OPENRISC Dependent Features
+ at end ifset
+ at ifclear GENERIC
+ at node Machine Dependencies
+ at chapter OPENRISC Dependent Features
+ at end ifclear
+
+ at cindex OPENRISC support
+ at menu
+* OpenRISC-Syntax::		Syntax
+* OpenRISC-Float::		Floating Point
+* OpenRISC-Directives::		OpenRISC Machine Directives
+* OpenRISC-Opcodes::		Opcodes
+ at end menu
+
+ at cindex OPENRISC syntax
+ at cindex syntax, OPENRISC
+ at node OpenRISC-Syntax
+ at section OpenRISC Syntax
+The assembler syntax follows the OpenRISC 1000 Architecture Manual.
+
+ at menu
+* OpenRISC-Chars::		Special Characters
+* OpenRISC-Regs::		Register Names
+* OpenRISC-Relocs::		Relocations
+ at end menu
+
+ at node OpenRISC-Chars
+ at subsection Special Characters
+
+ at cindex line comment character, OpenRISC
+ at cindex OpenRISC line comment character
+A @samp{#} character appearing anywhere on a line indicates the start
+of a comment that extends to the end of that line.
+
+ at cindex line separator, OpenRISC
+ at cindex statement separator, OpenRISC
+ at cindex OpenRISC line separator
+ at samp{;} can be used instead of a newline to separate statements.
+
+ at node OpenRISC-Regs
+ at subsection Register Names
+ at cindex OpenRISC registers
+ at cindex register names, OpenRISC
+
+The OpenRISC register file contains 32 general pupose registers.
+
+ at itemize @bullet
+ at item
+The 32 general purpose registers are referred to as @samp{r at var{n}}.
+
+ at item
+The stack pointer register @samp{r1} can be referenced using the alias
+ at samp{sp}.
+
+ at item
+The frame pointer register @samp{r2} can be referenced using the alias
+ at samp{fp}.
+
+ at item
+The link register @samp{r9} can be referenced using the alias @samp{lr}.
+ at end itemize
+
+Floating point operations use the same general purpose registers.  The
+instructions @code{lf.itof.s} (single precision) and @code{lf.itof.d} (double
+precision) can be used to convert integer values to floating point.
+Likewise, instructions @code{lf.ftoi.s} (single precision) and
+ at code{lf.ftoi.d} (double precision) can be used to convert floating point to
+integer.
+
+OpenRISC also contains privileged special purpose registers (SPRs).  The
+SPRs are accessed using the @code{l.mfspr} and @code{l.mtspr} instructions.
+
+ at node OpenRISC-Relocs
+ at subsection Relocations
+ at cindex OpenRISC relocations
+ at cindex relocations, OpenRISC
+
+ELF relocations are available as defined in the OpenRISC architecture
+specification.
+
+ at code{R_OR1K_HI_16_IN_INSN} is obtained using @samp{hi} and
+ at code{R_OR1K_LO_16_IN_INSN} and @code{R_OR1K_SLO16} are obtained using
+ at samp{lo}.  For signed offsets @code{R_OR1K_AHI16} is obtained from
+ at samp{ha}.  For example:
+
+ at example
+l.movhi r5, hi(symbol)
+l.ori   r5, r5, lo(symbol)
+
+l.movhi r5, ha(symbol)
+l.addi  r5, r5, lo(symbol)
+ at end example
+
+These ``high'' mnemonics extract bits 31:16 of their operand,
+and the ``low'' mnemonics extract bits 15:0 of their operand.
+
+The PC relative relocation @code{R_OR1K_GOTPC_HI16} can be obtained by
+enclosing an operand inside of @samp{gotpchi}.  Likewise, the
+ at code{R_OR1K_GOTPC_LO16} relocation can be obtained using @samp{gotpclo}.
+These are mostly used when assembling PIC code.  For example, the
+standard PIC sequence on OpenRISC to get the base of the global offset
+table, PC relative, into a register, can be performed as:
+
+ at example
+l.jal   0x8
+ l.movhi r17, gotpchi(_GLOBAL_OFFSET_TABLE_-4)
+l.ori   r17, r17, gotpclo(_GLOBAL_OFFSET_TABLE_+0)
+l.add   r17, r17, r9
+ at end example
+
+Several relocations exist to allow the link editor to perform GOT data
+references.  The @code{R_OR1K_GOT16} relocation can obtained by enclosing an
+operand inside of @samp{got}.  For example, assuming the GOT base is in
+register @code{r17}.
+
+ at example
+l.lwz   r19, got(a)(r17)
+l.lwz   r21, 0(r19)
+ at end example
+
+Also, several relocations exist for local GOT references.  The
+ at code{R_OR1K_GOTOFF_AHI16} relocation can obtained by enclosing an operand
+inside of @samp{gotoffha}.  Likewise, @code{R_OR1K_GOTOFF_LO16} and
+ at code{R_OR1K_GOTOFF_SLO16} can be obtained by enclosing an operand inside of
+ at samp{gotofflo}.  For example, assuming the GOT base is in register
+ at code{rl7}:
+
+ at example
+l.movhi r19, gotoffha(symbol)
+l.add   r19, r19, r17
+l.lwz   r19, gotofflo(symbol)(r19)
+ at end example
+
+The above PC relative relocations use a @code{l.jal} (jump) instruction
+and reading of the link register to load the PC.  OpenRISC also supports
+page offset PC relative locations without a jump instruction using the
+ at code{l.adrp} instruction.  By default the @code{l.adrp} instruction will
+create an @code{R_OR1K_PCREL_PG21} relocation.
+Likewise, @code{BFD_RELOC_OR1K_LO13} and @code{BFD_RELOC_OR1K_SLO13} can
+be obtained by enclosing an operand inside of @samp{po}.  For example:
+
+ at example
+l.adrp  r3, symbol
+l.ori   r4, r3, po(symbol)
+l.lbz   r5, po(symbol)(r3)
+l.sb    po(symbol)(r3), r6
+ at end example
+
+Likewise the page offset relocations can be used with GOT references.  The
+relocation @code{R_OR1K_GOT_PG21} can be obtained by enclosing an
+ at code{l.adrp} immediate operand inside of @samp{got}.  Likewise,
+ at code{R_OR1K_GOT_LO13} can be obtained by enclosing an operand inside of
+ at samp{gotpo}.  For example to load the value of a GOT symbol into register
+ at samp{r5} we can do:
+
+ at example
+l.adrp  r17, got(_GLOBAL_OFFSET_TABLE_)
+l.lwz   r5, gotpo(symbol)(r17)
+ at end example
+
+There are many relocations that can be requested for access to
+thread local storage variables.  All of the OpenRISC TLS mnemonics
+are supported:
+
+ at itemize @bullet
+ at item
+ at code{R_OR1K_TLS_GD_HI16} is requested using @samp{tlsgdhi}.
+ at item
+ at code{R_OR1K_TLS_GD_LO16} is requested using @samp{tlsgdlo}.
+ at item
+ at code{R_OR1K_TLS_GD_PG21} is requested using @samp{tldgd}.
+ at item
+ at code{R_OR1K_TLS_GD_LO13} is requested using @samp{tlsgdpo}.
+
+ at item
+ at code{R_OR1K_TLS_LDM_HI16} is requested using @samp{tlsldmhi}.
+ at item
+ at code{R_OR1K_TLS_LDM_LO16} is requested using @samp{tlsldmlo}.
+ at item
+ at code{R_OR1K_TLS_LDM_PG21} is requested using @samp{tldldm}.
+ at item
+ at code{R_OR1K_TLS_LDM_LO13} is requested using @samp{tlsldmpo}.
+
+ at item
+ at code{R_OR1K_TLS_LDO_HI16} is requested using @samp{dtpoffhi}.
+ at item
+ at code{R_OR1K_TLS_LDO_LO16} is requested using @samp{dtpofflo}.
+
+ at item
+ at code{R_OR1K_TLS_IE_HI16} is requested using @samp{gottpoffhi}.
+ at item
+ at code{R_OR1K_TLS_IE_AHI16} is requested using @samp{gottpoffha}.
+ at item
+ at code{R_OR1K_TLS_IE_LO16} is requested using @samp{gottpofflo}.
+ at item
+ at code{R_OR1K_TLS_IE_PG21} is requested using @samp{gottp}.
+ at item
+ at code{R_OR1K_TLS_IE_LO13} is requested using @samp{gottppo}.
+
+ at item
+ at code{R_OR1K_TLS_LE_HI16} is requested using @samp{tpoffhi}.
+ at item
+ at code{R_OR1K_TLS_LE_AHI16} is requested using @samp{tpoffha}.
+ at item
+ at code{R_OR1K_TLS_LE_LO16} is requested using @samp{tpofflo}.
+ at item
+ at code{R_OR1K_TLS_LE_SLO16} also is requested using @samp{tpofflo}
+depending on the instruction format.
+ at end itemize
+
+Here are some example TLS model sequences.
+
+First, General Dynamic:
+
+ at example
+l.movhi r17, tlsgdhi(symbol)
+l.ori   r17, r17, tlsgdlo(symbol)
+l.add   r17, r17, r16
+l.or    r3, r17, r17
+l.jal   plt(__tls_get_addr)
+ l.nop
+ at end example
+
+Initial Exec:
+
+ at example
+l.movhi r17, gottpoffhi(symbol)
+l.add   r17, r17, r16
+l.lwz   r17, gottpofflo(symbol)(r17)
+l.add   r17, r17, r10
+l.lbs   r17, 0(r17)
+ at end example
+
+And finally, Local Exec:
+
+ at example
+l.movhi r17, tpoffha(symbol)
+l.add   r17, r17, r10
+l.addi  r17, r17, tpofflo(symbol)
+l.lbs   r17, 0(r17)
+ at end example
+
+ at node OpenRISC-Float
+ at section Floating Point
+
+ at cindex floating point, OPENRISC (@sc{ieee})
+ at cindex OPENRISC floating point (@sc{ieee})
+OpenRISC uses @sc{ieee} floating-point numbers.
+
+ at node OpenRISC-Directives
+ at section OpenRISC Machine Directives
+
+ at cindex OPENRISC machine directives
+ at cindex machine directives, OPENRISC
+The OpenRISC version of @code{@value{AS}} supports the following additional
+machine directives:
+
+ at table @code
+ at cindex @code{align} directive, OpenRISC
+ at item .align
+This must be followed by the desired alignment in bytes.
+
+ at cindex @code{word} directive, OpenRISC
+ at item .word
+On the OpenRISC, the @code{.word} directive produces a 32 bit value.
+
+ at cindex @code{nodelay} directive, OpenRISC
+ at item .nodelay
+On the OpenRISC, the @code{.nodelay} directive sets a flag in elf binaries
+indicating that the binary is generated catering for no delay slots.
+
+ at cindex @code{proc} directive, OpenRISC
+ at item .proc
+This directive is ignored.  Any text following it on the same
+line is also ignored.
+
+ at cindex @code{endproc} directive, OpenRISC
+ at item .endproc
+This directive is ignored.  Any text following it on the same
+line is also ignored.
+ at end table
+
+ at node OpenRISC-Opcodes
+ at section Opcodes
+
+ at cindex OpenRISC opcode summary
+ at cindex opcode summary, OpenRISC
+ at cindex mnemonics, OpenRISC
+ at cindex instruction summary, LM32
+For detailed information on the OpenRISC machine instruction set, see
+ at url{http://www.openrisc.io/architecture/}.
+
+ at code{@value{AS}} implements all the standard OpenRISC opcodes.
-- 
2.17.1

