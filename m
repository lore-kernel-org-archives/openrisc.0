From: Stafford Horne <shorne@gmail.com>
Date: Sun,  9 Jun 2019 06:32:17 +0900
Subject: [OpenRISC] [PATCH v3 01/11] cpu/or1k: Add support for orfp64a32 spec
In-Reply-To: <20190608213225.3230-1-shorne@gmail.com>
References: <20190608213225.3230-1-shorne@gmail.com>
Message-ID: <20190608213225.3230-2-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This patch adds support for OpenRISC 64-bit FPU operations on 32-bit cores by
using register pairs.  The functionality has been added to OpenRISC architecture
specification version 1.3 as per architecture proposal 14[0].

For supporting assembly of both 64-bit and 32-bit precision instructions we have
defined CGEN_VALIDATE_INSN_SUPPORTED.  This allows cgen to use 64-bit bit
architecture assembly parsing on 64-bit toolchains and 32-bit architecture
assembly parsing on 32-bit toolchains.  Without this the assembler has issues
parsing register pairs.

This patch also contains a few fixes to the symantics for existing OpenRISC
single and double precision FPU operations.

[0] https://openrisc.io/proposals/orfpx64a32

cpu/ChangeLog:

yyyy-mm-dd  Andrey Bacherov  <avbacherov@opencores.org>
	    Stafford Horne  <shorne@gmail.com>

	* or1k.cpu (ORFPX64A32-MACHS): New pmacro.
	(ORFPX-MACHS): Removed pmacro.
	* or1k.opc (or1k_cgen_insn_supported): New function.
	(CGEN_VALIDATE_INSN_SUPPORTED): Define macro.
	(parse_regpair, print_regpair): New functions.
	* or1kcommon.cpu (h-spr, spr-shift, spr-address, h-gpr): Reorder
	and add comments.
	(h-fdr): Update comment to indicate or64.
	(reg-pair-reg-lo, reg-pair-reg-hi): New pmacros for register pairs.
	(h-fd32r): New hardware for 64-bit fpu registers.
	(h-i64r): New hardware for 64-bit int registers.
	* or1korbis.cpu (f-resv-8-1): New field.
	* or1korfpx.cpu (rDSF, rASF, rBSF): Update attribute to ORFPX32-MACHS.
	(rDDF, rADF, rBDF): Update operand comment to indicate or64.
	(f-rdoff-10-1, f-raoff-9-1, f-rboff-8-1): New fields.
	(h-roff1): New hardware.
	(double-field-and-ops mnemonic): New pmacro to generate operations
	rDD32F, rAD32F, rBD32F, rDDI and rADI.
	(float-regreg-insn): Update single precision generator to MACH
	ORFPX32-MACHS.  Add generator for or32 64-bit instructions.
	(float-setflag-insn): Update single precision generator to MACH
	ORFPX32-MACHS.  Fix double instructions from single to double
	precision.  Add generator for or32 64-bit instructions.
	(float-cust-insn cust-num): Update single precision generator to MACH
	ORFPX32-MACHS.  Add generator for or32 64-bit instructions.
	(lf-rem-s, lf-itof-s, lf-ftoi-s, lf-madd-s): Update MACH to
	ORFPX32-MACHS.
	(lf-rem-d): Fix operation from mod to rem.
	(lf-rem-d32, lf-itof-d32, lf-ftoi-d32, lf-madd-d32): New instruction.
	(lf-itof-d): Fix operands from single to double.
	(lf-ftoi-d): Update operand mode from DI to WI.
---
Changes since v2:
 - switch from implicit to explicit reg pairs (new functions parse_regpair
   print_regpair)

 cpu/or1k.cpu       |  15 +++--
 cpu/or1k.opc       |  92 +++++++++++++++++++++++++
 cpu/or1kcommon.cpu | 113 +++++++++++++++++++++++++------
 cpu/or1korbis.cpu  |   1 +
 cpu/or1korfpx.cpu  | 165 +++++++++++++++++++++++++++++++++++++++------
 5 files changed, 340 insertions(+), 46 deletions(-)

diff --git a/cpu/or1k.cpu b/cpu/or1k.cpu
index 3a932bcb90..e1ae1b8c88 100644
--- a/cpu/or1k.cpu
+++ b/cpu/or1k.cpu
@@ -1,8 +1,9 @@
 ; OpenRISC 1000 architecture.  -*- Scheme -*-
-; Copyright 2000-2014 Free Software Foundation, Inc.
+; Copyright 2000-2019 Free Software Foundation, Inc.
 ; Contributed for OR32 by Johan Rydberg, jrydberg at opencores.org
 ; Modified by Julius Baxter, juliusbaxter at gmail.com
 ; Modified by Peter Gavin, pgavin at gmail.com
+; Modified by Andrey Bacherov, avbacherov at opencores.org
 ;
 ; This program is free software; you can redistribute it and/or modify
 ; it under the terms of the GNU General Public License as published by
@@ -42,12 +43,12 @@
   (base-insn-bitsize 32)
   )
 
-(define-pmacro OR32-MACHS    or32,or32nd)
-(define-pmacro OR64-MACHS    or64,or64nd)
-(define-pmacro ORBIS-MACHS   or32,or32nd,or64,or64nd)
-(define-pmacro ORFPX-MACHS   or32,or32nd,or64,or64nd)
-(define-pmacro ORFPX32-MACHS or32,or32nd,or64,or64nd)
-(define-pmacro ORFPX64-MACHS or64,or64nd)
+(define-pmacro OR32-MACHS       or32,or32nd)
+(define-pmacro OR64-MACHS       or64,or64nd)
+(define-pmacro ORBIS-MACHS      or32,or32nd,or64,or64nd)
+(define-pmacro ORFPX32-MACHS    or32,or32nd,or64,or64nd)
+(define-pmacro ORFPX64-MACHS    or64,or64nd)
+(define-pmacro ORFPX64A32-MACHS or32,or32nd) ; float64 for 32-bit machs
 
 (define-attr
   (for model)
diff --git a/cpu/or1k.opc b/cpu/or1k.opc
index 5082a30cee..f0adcbb00a 100644
--- a/cpu/or1k.opc
+++ b/cpu/or1k.opc
@@ -40,9 +40,29 @@
 #undef  CGEN_DIS_HASH
 #define CGEN_DIS_HASH(buffer, value) (((unsigned char *) (buffer))[0] >> 2)
 
+/* Check applicability of instructions against machines.  */
+#define CGEN_VALIDATE_INSN_SUPPORTED
+
+extern int or1k_cgen_insn_supported (CGEN_CPU_DESC, const CGEN_INSN *);
+
 /* -- */
 
 /* -- opc.c */
+
+/* Special check to ensure that instruction exists for given machine.  */
+
+int
+or1k_cgen_insn_supported (CGEN_CPU_DESC cd, const CGEN_INSN *insn)
+{
+  int machs = CGEN_INSN_ATTR_VALUE (insn, CGEN_INSN_MACH);
+
+  /* No mach attribute?  Assume it's supported for all machs.  */
+  if (machs == 0)
+    return 1;
+
+  return ((machs & cd->machs) != 0);
+}
+
 /* -- */
 
 /* -- asm.c */
@@ -415,6 +435,78 @@ parse_uimm16_split (CGEN_CPU_DESC cd, const char **strp, int opindex,
   return errmsg;
 }
 
+/* Parse register pairs with syntax rA,rB to a flag + rA value.  */
+
+static const char *
+parse_regpair (CGEN_CPU_DESC cd, const char **strp,
+	       int opindex ATTRIBUTE_UNUSED, unsigned long *valuep)
+{
+  long reg1_index;
+  long reg2_index;
+  const char *errmsg;
+
+  /* The first part should just be a register.  */
+  errmsg = cgen_parse_keyword (cd, strp, &or1k_cgen_opval_h_gpr,
+			       &reg1_index);
+
+  /* If that worked skip the comma separator.  */
+  if (errmsg == NULL)
+    {
+      if (**strp == ',')
+	++*strp;
+      else
+	errmsg = "Unexpected character, expected ','";
+    }
+
+  /* If that worked the next part is just another register.  */
+  if (errmsg == NULL)
+    errmsg = cgen_parse_keyword (cd, strp, &or1k_cgen_opval_h_gpr,
+				 &reg2_index);
+
+  /* Validate the register pair is valid and create the output value.  */
+  if (errmsg == NULL)
+    {
+      int regoffset = reg2_index - reg1_index;
+
+      if (regoffset == 1 || regoffset == 2)
+	{
+	  unsigned short offsetmask;
+	  unsigned short value;
+
+	  offsetmask = ((regoffset == 2 ? 1 : 0) << 5);
+	  value = offsetmask | reg1_index;
+
+	  *valuep = value;
+	}
+      else
+	errmsg = "Invalid register pair, offset not 1 or 2.";
+    }
+
+  return errmsg;
+}
+
+/* -- */
+
+/* -- dis.c */
+
+static void
+print_regpair (CGEN_CPU_DESC cd ATTRIBUTE_UNUSED,
+	       void * dis_info,
+	       long value,
+	       unsigned int attrs ATTRIBUTE_UNUSED,
+	       bfd_vma pc ATTRIBUTE_UNUSED,
+	       int length ATTRIBUTE_UNUSED)
+{
+  disassemble_info *info = dis_info;
+  char reg1_index;
+  char reg2_index;
+
+  reg1_index = value & 0x1f;
+  reg2_index = reg1_index + ((value & (1 << 5)) ? 2 : 1);
+
+  (*info->fprintf_func) (info->stream, "r%d,r%d", reg1_index, reg2_index);
+}
+
 /* -- */
 
 /* -- ibd.h */
diff --git a/cpu/or1kcommon.cpu b/cpu/or1kcommon.cpu
index c0e4f316ad..65154407df 100644
--- a/cpu/or1kcommon.cpu
+++ b/cpu/or1kcommon.cpu
@@ -1,7 +1,8 @@
 ; OpenRISC 1000 32-bit CPU hardware description.  -*- Scheme -*-
-; Copyright 2000-2014 Free Software Foundation, Inc.
+; Copyright 2000-2019 Free Software Foundation, Inc.
 ; Contributed for OR32 by Johan Rydberg, jrydberg at opencores.org
 ; Modified by Julius Baxter, juliusbaxter at gmail.com
+; Modified by Andrey Bacherov, avbacherov at opencores.org
 ;
 ; This program is free software; you can redistribute it and/or modify
 ; it under the terms of the GNU General Public License as published by
@@ -71,6 +72,38 @@
    (fp 2))
   )
 
+;
+; Hardware: [S]pecial [P]urpose [R]egisters
+;
+(define-hardware
+  (name h-spr) (comment "special purpose registers")
+  (attrs VIRTUAL (MACH ORBIS-MACHS))
+  (type register UWI (#x20000))
+  (get (index) (c-call UWI "@cpu at _h_spr_get_raw" index))
+  (set (index newval) (c-call VOID "@cpu at _h_spr_set_raw" index newval))
+)
+
+(define-pmacro spr-shift 11)
+(define-pmacro (spr-address spr-group spr-index)
+  (or (sll UWI (enum UWI (.sym "SPR-GROUP-" spr-group)) spr-shift)
+      (enum UWI (.sym "SPR-INDEX-" spr-group "-" spr-index))))
+
+;
+; Hardware: [G]enepral  [P]urpose [R]egisters
+;
+(define-hardware
+  (name h-gpr) (comment "general registers")
+  (attrs (MACH ORBIS-MACHS))
+  (type register UWI (32))
+  (indices keyword "" REG-INDICES)
+  (get (index) (reg UWI h-spr (add index (spr-address SYS GPR0))))
+  (set (index newval) (set UWI (reg UWI h-spr (add index (spr-address SYS GPR0))) newval))
+  )
+
+;
+; Hardware: virtual registerts for FPU (single precision)
+;           mapped to GPRs
+;
 (define-hardware
   (name h-fsr)
   (comment "floating point registers (single, virtual)")
@@ -81,8 +114,13 @@
   (set (index newval) (set UWI (reg h-gpr index) (zext UWI (subword SI newval 0))))
   )
 
+;
+; Hardware: virtual registerts for FPU (double precision)
+;           mapped to GPRs
+;
 (define-hardware
-  (name h-fdr) (comment "floating point registers (double, virtual)")
+  (name h-fdr)
+  (comment "or64 floating point registers (double, virtual)")
   (attrs VIRTUAL (MACH ORFPX64-MACHS))
   (type register DF (32))
   (indices keyword "" REG-INDICES)
@@ -90,27 +128,64 @@
   (set (index newval) (set UDI (reg h-gpr index) (zext UDI (subword DI newval 0))))
   )
 
-(define-hardware
-  (name h-spr) (comment "special purpose registers")
-  (attrs VIRTUAL (MACH ORBIS-MACHS))
-  (type register UWI (#x20000))
-  (get (index) (c-call UWI "@cpu at _h_spr_get_raw" index))
-  (set (index newval) (c-call VOID "@cpu at _h_spr_set_raw" index newval))
+;
+; Register pairs are offset by 2 for registers r16 and above.  This is to
+; be able to allow registers to be call saved in GCC across function calls.
+;
+(define-pmacro (reg-pair-reg-lo index)
+  (and index (const #x1f))
 )
 
-(define-pmacro spr-shift 11)
-(define-pmacro (spr-address spr-group spr-index)
-  (or (sll UWI (enum UWI (.sym "SPR-GROUP-" spr-group)) spr-shift)
-      (enum UWI (.sym "SPR-INDEX-" spr-group "-" spr-index))))
+(define-pmacro (reg-pair-reg-hi index)
+  (add (and index (const #x1f))
+       (if (eq (sra index (const 5))
+	       (const 1))
+	   (const 2)
+	   (const 1)
+	 )
+    )
+)
+
+;
+; Hardware: vrtual registers for double precision floating point
+;           operands on 32-bit machines
+;           mapped to GPRs
+;
+(define-hardware
+  (name h-fd32r)
+  (comment "or32 floating point registers (double, virtual)")
+  (attrs VIRTUAL (MACH ORFPX64A32-MACHS))
+  (type register DF (32))
+  (get (index) (join DF SI
+                        (reg h-gpr (reg-pair-reg-lo index))
+                        (reg h-gpr (reg-pair-reg-hi index))))
+  (set (index newval)
+       (sequence ()
+                 (set (reg h-gpr (reg-pair-reg-lo index)) (subword SI newval 0))
+                 (set (reg h-gpr (reg-pair-reg-hi index))
+                                 (subword SI newval 1))))
+)
 
+;
+; Hardware: vrtual 64-bit integer registers for conversions
+;           float64 <-> int64 on 32-bit machines
+;           mapped to GPRs
+;
 (define-hardware
-  (name h-gpr) (comment "general registers")
-  (attrs (MACH ORBIS-MACHS))
-  (type register UWI (32))
-  (indices keyword "" REG-INDICES)
-  (get (index) (reg UWI h-spr (add index (spr-address SYS GPR0))))
-  (set (index newval) (set UWI (reg UWI h-spr (add index (spr-address SYS GPR0))) newval))
-  )
+  (name h-i64r)
+  (comment "or32 double word registers (int64, virtual)")
+  (attrs VIRTUAL (MACH ORFPX64A32-MACHS))
+  (type register DI (32))
+  (get (index) (join DI SI
+                        (reg h-gpr (reg-pair-reg-lo index))
+                        (reg h-gpr (reg-pair-reg-hi index))))
+  (set (index newval)
+       (sequence ()
+                 (set (reg h-gpr (reg-pair-reg-lo index)) (subword SI newval 0))
+                 (set (reg h-gpr (reg-pair-reg-hi index))
+                                 (subword SI newval 1))))
+)
+
 
 (define-normal-enum
   except-number
diff --git a/cpu/or1korbis.cpu b/cpu/or1korbis.cpu
index 094f0185a7..308f37861d 100644
--- a/cpu/or1korbis.cpu
+++ b/cpu/or1korbis.cpu
@@ -61,6 +61,7 @@
 (dnf f-resv-10-7   "resv-10-7"                 ((MACH ORBIS-MACHS) RESERVED) 10 7)
 (dnf f-resv-10-3   "resv-10-3"                 ((MACH ORBIS-MACHS) RESERVED) 10 3)
 (dnf f-resv-10-1   "resv-10-1"                 ((MACH ORBIS-MACHS) RESERVED) 10 1)
+(dnf f-resv-8-1    "resv-8-1"                  ((MACH ORBIS-MACHS) RESERVED) 8 1)
 (dnf f-resv-7-4    "resv-7-4"                  ((MACH ORBIS-MACHS) RESERVED) 7 4)
 (dnf f-resv-5-2    "resv-5-2"                  ((MACH ORBIS-MACHS) RESERVED) 5 2)
 
diff --git a/cpu/or1korfpx.cpu b/cpu/or1korfpx.cpu
index 1a128a97b2..eb01f1ca66 100644
--- a/cpu/or1korfpx.cpu
+++ b/cpu/or1korfpx.cpu
@@ -1,6 +1,7 @@
 ; OpenRISC 1000 architecture.  -*- Scheme -*-
-; Copyright 2000-2014 Free Software Foundation, Inc.
+; Copyright 2000-2019 Free Software Foundation, Inc.
 ; Contributed by Peter Gavin, pgavin at gmail.com
+; Modified by Andrey Bacherov, avbacherov at opencores.org
 ;
 ; This program is free software; you can redistribute it and/or modify
 ; it under the terms of the GNU General Public License as published by
@@ -58,19 +59,80 @@
    )
   )
 
-(dnop rDSF "destination register (single floating point mode)" () h-fsr f-r1)
-(dnop rASF "source register A (single floating point mode)"    () h-fsr f-r2)
-(dnop rBSF "source register B (single floating point mode)"    () h-fsr f-r3)
+; Register offset flags, if set offset is 2 otherwise offset is 1
+(dnf f-rdoff-10-1   "destination register pair offset flag" ((MACH ORFPX64A32-MACHS)) 10 1)
+(dnf f-raoff-9-1    "source register A pair offset flag"    ((MACH ORFPX64A32-MACHS)) 9 1)
+(dnf f-rboff-8-1    "source register B pair offset flag"    ((MACH ORFPX64A32-MACHS)) 8 1)
 
-(dnop rDDF "destination register (double floating point mode)" ((MACH ORFPX64-MACHS)) h-fdr f-r1)
-(dnop rADF "source register A (double floating point mode)"    ((MACH ORFPX64-MACHS)) h-fdr f-r1)
-(dnop rBDF "source register B (double floating point mode)"    ((MACH ORFPX64-MACHS)) h-fdr f-r1)
+(dsh h-roff1        "1-bit offset flag"                     () (register BI))
+
+(dnop rDSF "destination register (single floating point mode)" ((MACH ORFPX32-MACHS)) h-fsr f-r1)
+(dnop rASF "source register A (single floating point mode)"    ((MACH ORFPX32-MACHS)) h-fsr f-r2)
+(dnop rBSF "source register B (single floating point mode)"    ((MACH ORFPX32-MACHS)) h-fsr f-r3)
+
+(dnop rDDF "or64 destination register (double floating point mode)" ((MACH ORFPX64-MACHS)) h-fdr f-r1)
+(dnop rADF "or64 source register A (double floating point mode)"    ((MACH ORFPX64-MACHS)) h-fdr f-r2)
+(dnop rBDF "or64 source register B (double floating point mode)"    ((MACH ORFPX64-MACHS)) h-fdr f-r3)
+
+(define-pmacro (double-field-and-ops mnemonic reg offbit op-comment)
+  (begin
+    (define-multi-ifield
+      (name (.sym "f-r" (.downcase mnemonic) "d32"))
+      (comment op-comment)
+      (attrs (MACH ORFPX64A32-MACHS))
+      (mode SI)
+      (subfields reg offbit)
+      ; From the multi-ifield insert the bits into subfields
+      (insert (sequence
+		()
+		(set (ifield reg)
+		  (and (ifield (.sym "f-r" (.downcase mnemonic) "d32"))
+		       (const #x1f))
+		  )
+		(set (ifield offbit)
+		  (and (sra (ifield (.sym "f-r" (.downcase mnemonic) "d32"))
+		            (const 5))
+		       (const 1))
+		  )
+		)
+	)
+      ; Extract the multi-ifield from the subfield bits
+      (extract
+	       (set (ifield (.sym "f-r" (.downcase mnemonic) "d32"))
+		    (or (ifield reg)
+			(sll (ifield offbit)
+			     (const 5)))
+		 )
+        )
+      )
+    (define-operand
+      (name (.sym "r" (.upcase mnemonic) "D32F"))
+      (comment (.str op-comment " (double floating point pair)"))
+      (attrs (MACH ORFPX64A32-MACHS))
+      (type h-fd32r)
+      (index (.sym "f-r" (.downcase mnemonic) "d32"))
+      (handlers (parse "regpair") (print "regpair"))
+      )
+    (define-operand
+      (name (.sym "r" (.upcase mnemonic) "DI"))
+      (comment (.str op-comment " (double integer pair)"))
+      (attrs (MACH ORFPX64A32-MACHS))
+      (type h-i64r)
+      (index (.sym "f-r" (.downcase mnemonic) "d32"))
+      (handlers (parse "regpair") (print "regpair"))
+      )
+    )
+  )
+
+(double-field-and-ops D f-r1 f-rdoff-10-1 "destination register")
+(double-field-and-ops A f-r2 f-raoff-9-1  "source register A")
+(double-field-and-ops B f-r3 f-rboff-8-1  "source register B")
 
 (define-pmacro (float-regreg-insn mnemonic)
   (begin
     (dni (.sym lf- mnemonic -s)
          (.str "lf." mnemonic ".s reg/reg/reg")
-         ((MACH ORFPX-MACHS))
+         ((MACH ORFPX32-MACHS))
          (.str "lf." mnemonic ".s $rDSF,$rASF,$rBSF")
          (+ OPC_FLOAT rDSF rASF rBSF (f-resv-10-3 0) (.sym OPC_FLOAT_REGREG_ (.upcase mnemonic) _S))
          (set SF rDSF (mnemonic SF rASF rBSF))
@@ -84,6 +146,14 @@
          (set DF rDDF (mnemonic DF rADF rBDF))
          ()
          )
+    (dni (.sym lf- mnemonic -d32)
+         (.str "lf." mnemonic ".d regpair/regpair/regpair")
+         ((MACH ORFPX64A32-MACHS))
+         (.str "lf." mnemonic ".d $rDD32F,$rAD32F,$rBD32F")
+         (+ OPC_FLOAT rDD32F rAD32F rBD32F (.sym OPC_FLOAT_REGREG_ (.upcase mnemonic) _D))
+         (set DF rDD32F (mnemonic DF rAD32F rBD32F))
+         ()
+         )
     )
   )
 
@@ -94,18 +164,28 @@
 
 (dni lf-rem-s
      "lf.rem.s reg/reg/reg"
-     ((MACH ORFPX-MACHS))
+     ((MACH ORFPX32-MACHS))
      "lf.rem.s $rDSF,$rASF,$rBSF"
      (+ OPC_FLOAT rDSF rASF rBSF (f-resv-10-3 0) OPC_FLOAT_REGREG_REM_S)
      (set SF rDSF (rem SF rASF rBSF))
      ()
      )
+
 (dni lf-rem-d
      "lf.rem.d reg/reg/reg"
      ((MACH ORFPX64-MACHS))
      "lf.rem.d $rDDF,$rADF,$rBDF"
      (+ OPC_FLOAT rDDF rADF rBDF (f-resv-10-3 0) OPC_FLOAT_REGREG_REM_D)
-     (set DF rDDF (mod DF rADF rBDF))
+     (set DF rDDF (rem DF rADF rBDF))
+     ()
+     )
+
+(dni lf-rem-d32
+     "lf.rem.d regpair/regpair/regpair"
+     ((MACH ORFPX64A32-MACHS))
+     "lf.rem.d $rDD32F,$rAD32F,$rBD32F"
+     (+ OPC_FLOAT rDD32F rAD32F rBD32F OPC_FLOAT_REGREG_REM_D)
+     (set DF rDD32F (rem DF rAD32F rBD32F))
      ()
      )
 
@@ -120,24 +200,34 @@
 
 (dni lf-itof-s
      "lf.itof.s reg/reg"
-     ((MACH ORFPX-MACHS))
+     ((MACH ORFPX32-MACHS))
      "lf.itof.s $rDSF,$rA"
      (+ OPC_FLOAT rDSF rA (f-r3 0) (f-resv-10-3 0) OPC_FLOAT_REGREG_ITOF_S)
      (set SF rDSF (float SF (get-rounding-mode) (trunc SI rA)))
      ()
      )
+
 (dni lf-itof-d
      "lf.itof.d reg/reg"
      ((MACH ORFPX64-MACHS))
-     "lf.itof.d $rDSF,$rA"
-     (+ OPC_FLOAT rDSF rA (f-r3 0) (f-resv-10-3 0) OPC_FLOAT_REGREG_ITOF_D)
+     "lf.itof.d $rDDF,$rA"
+     (+ OPC_FLOAT rDDF rA (f-r3 0) (f-resv-10-3 0) OPC_FLOAT_REGREG_ITOF_D)
      (set DF rDDF (float DF (get-rounding-mode) rA))
      ()
      )
 
+(dni lf-itof-d32
+     "lf.itof.d regpair/regpair"
+     ((MACH ORFPX64A32-MACHS))
+     "lf.itof.d $rDD32F,$rADI"
+     (+ OPC_FLOAT rDD32F rADI (f-r3 0) (f-resv-8-1 0) OPC_FLOAT_REGREG_ITOF_D)
+     (set DF rDD32F (float DF (get-rounding-mode) rADI))
+     ()
+     )
+
 (dni lf-ftoi-s
      "lf.ftoi.s reg/reg"
-     ((MACH ORFPX-MACHS))
+     ((MACH ORFPX32-MACHS))
      "lf.ftoi.s $rD,$rASF"
      (+ OPC_FLOAT rD rASF (f-r3 0) (f-resv-10-3 0) OPC_FLOAT_REGREG_FTOI_S)
      (set WI rD (ext WI (fix SI (get-rounding-mode) rASF)))
@@ -149,7 +239,16 @@
      ((MACH ORFPX64-MACHS))
      "lf.ftoi.d $rD,$rADF"
      (+ OPC_FLOAT rD rADF (f-r3 0) (f-resv-10-3 0) OPC_FLOAT_REGREG_FTOI_D)
-     (set DI rD (fix DI (get-rounding-mode) rADF))
+     (set WI rD (fix WI (get-rounding-mode) rADF))
+     ()
+     )
+
+(dni lf-ftoi-d32
+     "lf.ftoi.d regpair/regpair"
+     ((MACH ORFPX64A32-MACHS))
+     "lf.ftoi.d $rDDI,$rAD32F"
+     (+ OPC_FLOAT rDDI rAD32F (f-r3 0) (f-resv-8-1 0) OPC_FLOAT_REGREG_FTOI_D)
+     (set DI rDDI (fix DI (get-rounding-mode) rAD32F))
      ()
      )
 
@@ -157,7 +256,7 @@
   (begin
     (dni (.sym lf- mnemonic -s)
          (.str "lf.sf" mnemonic ".s reg/reg")
-         ((MACH ORFPX-MACHS))
+         ((MACH ORFPX32-MACHS))
          (.str "lf.sf" mnemonic ".s $rASF,$rBSF")
          (+ OPC_FLOAT (f-r1 0) rASF rBSF (f-resv-10-3 0) (.sym OPC_FLOAT_REGREG_SF (.upcase mnemonic) _S))
          (set BI sys-sr-f (mnemonic SF rASF rBSF))
@@ -166,11 +265,19 @@
     (dni (.sym lf- mnemonic -d)
          (.str "lf.sf" mnemonic ".d reg/reg")
          ((MACH ORFPX64-MACHS))
-         (.str "lf.sf" mnemonic ".d $rASF,$rBSF")
-         (+ OPC_FLOAT (f-r1 0) rASF rBSF (f-resv-10-3 0) (.sym OPC_FLOAT_REGREG_SF (.upcase mnemonic) _D))
+         (.str "lf.sf" mnemonic ".d $rADF,$rBDF")
+         (+ OPC_FLOAT (f-r1 0) rADF rBDF (f-resv-10-3 0) (.sym OPC_FLOAT_REGREG_SF (.upcase mnemonic) _D))
          (set BI sys-sr-f (mnemonic DF rADF rBDF))
          ()
          )
+    (dni (.sym lf- mnemonic -d32)
+         (.str "lf.sf" mnemonic ".d regpair/regpair")
+         ((MACH ORFPX64A32-MACHS))
+         (.str "lf.sf" mnemonic ".d $rAD32F,$rBD32F")
+         (+ OPC_FLOAT (f-r1 0) rAD32F rBD32F (f-resv-10-1 0) (.sym OPC_FLOAT_REGREG_SF (.upcase mnemonic) _D))
+         (set BI sys-sr-f (mnemonic DF rAD32F rBD32F))
+         ()
+         )
     )
   )
 
@@ -183,12 +290,13 @@
 
 (dni lf-madd-s
      "lf.madd.s reg/reg/reg"
-     ((MACH ORFPX-MACHS))
+     ((MACH ORFPX32-MACHS))
      "lf.madd.s $rDSF,$rASF,$rBSF"
      (+ OPC_FLOAT rDSF rASF rBSF (f-resv-10-3 0) OPC_FLOAT_REGREG_MADD_S)
      (set SF rDSF (add SF (mul SF rASF rBSF) rDSF))
      ()
      )
+
 (dni lf-madd-d
      "lf.madd.d reg/reg/reg"
      ((MACH ORFPX64-MACHS))
@@ -198,11 +306,20 @@
      ()
      )
 
+(dni lf-madd-d32
+     "lf.madd.d regpair/regpair/regpair"
+     ((MACH ORFPX64A32-MACHS))
+     "lf.madd.d $rDD32F,$rAD32F,$rBD32F"
+     (+ OPC_FLOAT rDD32F rAD32F rBD32F OPC_FLOAT_REGREG_MADD_D)
+     (set DF rDD32F (add DF (mul DF rAD32F rBD32F) rDD32F))
+     ()
+     )
+
 (define-pmacro (float-cust-insn cust-num)
   (begin
     (dni (.sym "lf-cust" cust-num "-s")
          (.str "lf.cust" cust-num ".s")
-         ((MACH ORFPX-MACHS))
+         ((MACH ORFPX32-MACHS))
          (.str "lf.cust" cust-num ".s $rASF,$rBSF")
          (+ OPC_FLOAT (f-resv-25-5 0) rASF rBSF (f-resv-10-3 0) (.sym "OPC_FLOAT_REGREG_CUST" cust-num "_S"))
          (nop)
@@ -216,6 +333,14 @@
          (nop)
          ()
          )
+    (dni (.sym "lf-cust" cust-num "-d32")
+         (.str "lf.cust" cust-num ".d")
+         ((MACH ORFPX64A32-MACHS))
+         (.str "lf.cust" cust-num ".d")
+         (+ OPC_FLOAT (f-resv-25-5 0) rAD32F rBD32F (f-resv-10-1 0) (.sym "OPC_FLOAT_REGREG_CUST" cust-num "_D"))
+         (nop)
+         ()
+         )
     )
   )
 
-- 
2.21.0

