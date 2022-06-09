Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C63C43334
	for <openrisc@archiver.kernel.org>; Thu,  9 Jun 2022 06:01:39 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id F21C1242D4;
	Thu,  9 Jun 2022 08:01:37 +0200 (CEST)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by mail.librecores.org (Postfix) with ESMTPS id 7E7B020E4E
 for <openrisc@lists.librecores.org>; Thu,  9 Jun 2022 08:01:36 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 7A4745C0129;
 Thu,  9 Jun 2022 02:01:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Thu, 09 Jun 2022 02:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:sender:subject:subject:to:to;
 s=fm3; t=1654754495; x=1654840895; bh=Jc3v9+Cujc7dxBizrNXQN1EjE
 +iYuGX6mHxhU0NXQgU=; b=jurxMW1hBK5ubZyUin+72Gv7yZDWtzH0N/JleMbND
 nmOqJX+T6kIyAa4uxWxb/gPCZY/51XzVN7Kz2BvE0zS9oBcAQxlXkuEzxB7dYW3K
 jAFjFkDz6S4TX1TKcAtFYWTXB5/dgzkcri71JCLbyHWAx/Ddk6A6xoB7X3wEWTmQ
 BEE+nB329TjSLk6YuBzv7HOGW/SIk8OnA0+hdEgW0SYETLP03deE0kXknRU42dO4
 R0nxJfu/Fd8kkVDFp3fEzu9goKGHY20q2TdrV9M+eVoF0MuEtxaEjg4cSNt+XT9j
 eIdjJJ651rnfyA54EW2JFJ/BTNC3GdHLRIDzZTtIHVinA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:message-id
 :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1654754495; x=1654840895; bh=Jc3v9+Cujc7dxBizrNXQN1EjE+iYuGX6mHx
 hU0NXQgU=; b=eM8pBxXkWXLILhk+G6xo2l14elt+st3wNSJWtzMkhZdrDEMAe7n
 kTQG33/WocVG3MnjGW0iW1Q6jTFNNpRU5iqreWntMmGlH36YjGwcIwilvxx8IUY5
 /DXYBd2Yvcyl2KEKvpPKNnXF2FCxA2axEmP/82kgnweyGCUgGsrYfrgdnGn0e2AF
 6QRRD9wtQW1OEh7YDE9HZ9AtNK5gEMDPHwfi5Ro+xQeoUjh918K0kSEedo7oX122
 dHJaLrv0ySC9vISlpyK8b5P3v7CcVBFijnUI7ELsVo7BC9dqbu+S04iT+v7hHMh7
 LhCBDt12EzoNQ2TaX/KtYJf6r/HAC403XJg==
X-ME-Sender: <xms:v4yhYl6ccAWsm4Pf8ecVY47IAkSNjBcT4pXtFwwd23Tcfmck28Y5lw>
 <xme:v4yhYi4kDXCr4FpGXaHPfrqvW7-omKP1LXUSLDtEjxC36QOqMMJF_hNW-Rxn0fRSl
 XeJWyY7p3NpjfUcUQ>
X-ME-Received: <xmr:v4yhYscT4rm2ZT2RJbkSz7514DpH90Grsw4HjB684V1MbsGfYotwESwUkG2IOAVxnowIBKmEnFD5jN3HHa14Aixi9mxkqR-K4hKIUuasbhU7fHe8M7SlaGT1r_OHBzRPRjsCDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtkedguddttdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
 lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
 frrghtthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeeh
 hffhkeekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:v4yhYuKhXlXL8-mOEAC2xAhVSNrra2C5fn4tztnWZJiIKre-Fr0bUA>
 <xmx:v4yhYpK9V9O_3I7-mfr3taYLY5185zwv7sTW2zfdJKBClLXjZG_uZQ>
 <xmx:v4yhYnx_K7D_QrjsC1XJITV242uEbh4-QssoWTrZR65_oU1oY2M2GA>
 <xmx:v4yhYgUr8o2KB43of-gxbKvl7p97YPGRNKqQTVrS9URB_yjgEQY3IA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jun 2022 02:01:34 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: binutils@sourceware.org
Subject: [PATCH] or1k: Add support for a little-endian target variant
Date: Thu,  9 Jun 2022 01:01:33 -0500
Message-Id: <20220609060133.26409-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: openrisc@lists.librecores.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

While not officially sanctioned by the architecture spec, little-endian
or1k processors do exist in the wild, for example the Allwinner AR100.
Let's add native support for this, instead of hacks like using objcopy
to byteswap ELF file contents.

bfd/
	* config.bfd (or1k): Split out or1k_elf32_{be,le}vec. Accept
	  or1kle* target variant.
	* configure (or1k): Split out or1k_elf32_{be,le}vec.
	* configure.ac (or1k): Likewise.
	* elf32-or1k.c: Likewise.
	* targets.c: Likewise.

gas/
	* tc-or1k.c: Add -EB and -EL options. Support dynamic endianness
	  selection.
	* tc-or1k.h: Support dynamic endianness selection.
	* configure (or1k): Generalize arch to or1k*.
	* configure.ac (or1k): Likewise.
	* configure.tgt (or1k): Select default endianness from target.

ld/
	* configure.tgt (or1k): Generalize arch to or1k*.
	* emulparams/elf32or1k.sh: Split out big/little target variants.
	* testsuite/ld-elf/binutils.exp: Generalize arch to or1k*.
	* testsuite/ld-ifunc/ifunc.exp: Generalize arch to or1k*.

opcodes/
	* or1k-opc.h: Make CGEN_DIS_HASH endianness-agnostic.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 bfd/config.bfd                   | 12 +++++----
 bfd/configure                    |  3 ++-
 bfd/configure.ac                 |  3 ++-
 bfd/elf32-or1k.c                 |  5 +++-
 bfd/targets.c                    |  6 +++--
 gas/config/tc-or1k.c             | 42 ++++++++++++++++++++++++++------
 gas/config/tc-or1k.h             |  5 +++-
 gas/configure                    |  2 +-
 gas/configure.ac                 |  2 +-
 gas/configure.tgt                |  7 ++++--
 ld/configure.tgt                 |  4 +--
 ld/emulparams/elf32or1k.sh       |  4 ++-
 ld/testsuite/ld-elf/binutils.exp |  2 +-
 ld/testsuite/ld-ifunc/ifunc.exp  |  2 +-
 opcodes/or1k-opc.h               |  2 +-
 15 files changed, 73 insertions(+), 28 deletions(-)

diff --git a/bfd/config.bfd b/bfd/config.bfd
index cfe58247882..d42fea46077 100644
--- a/bfd/config.bfd
+++ b/bfd/config.bfd
@@ -208,7 +208,7 @@ mips*)		 targ_archs=bfd_mips_arch ;;
 nds32*)		 targ_archs=bfd_nds32_arch ;;
 nfp)		 targ_archs=bfd_nfp_arch ;;
 nios2*)          targ_archs=bfd_nios2_arch ;;
-or1k*|or1knd*)	 targ_archs=bfd_or1k_arch ;;
+or1k*)		 targ_archs=bfd_or1k_arch ;;
 pdp11*)		 targ_archs=bfd_pdp11_arch ;;
 pj*)		 targ_archs="bfd_pj_arch bfd_i386_arch";;
 powerpc*)	 targ_archs="bfd_rs6000_arch bfd_powerpc_arch" ;;
@@ -1046,12 +1046,14 @@ case "${targ}" in
     targ_selvecs=nios2_elf32_be_vec
     ;;
 
-  or1k-*-elf | or1k-*-linux* | or1k-*-rtems*)
-    targ_defvec=or1k_elf32_vec
+  or1kle*-*-elf | or1kle*-*-linux* | or1kle*-*-rtems*)
+    targ_defvec=or1k_elf32_le_vec
+    targ_selvecs=or1k_elf32_be_vec
     ;;
 
-  or1knd-*-elf | or1knd-*-linux* | or1knd-*-rtems*)
-    targ_defvec=or1k_elf32_vec
+  or1k*-*-elf | or1k*-*-linux* | or1k*-*-rtems*)
+    targ_defvec=or1k_elf32_be_vec
+    targ_selvecs=or1k_elf32_le_vec
     ;;
 
   pdp11-*-*)
diff --git a/bfd/configure b/bfd/configure
index b23c9eebfd7..3f6c5aaabc9 100755
--- a/bfd/configure
+++ b/bfd/configure
@@ -13515,7 +13515,8 @@ do
     nios2_elf32_le_vec)		 tb="$tb elf32-nios2.lo elf32.lo $elf" ;;
     ns32k_aout_pc532mach_vec)	 tb="$tb pc532-mach.lo aout-ns32k.lo" ;;
     ns32k_aout_pc532nbsd_vec)	 tb="$tb ns32knetbsd.lo aout-ns32k.lo" ;;
-    or1k_elf32_vec)		 tb="$tb elf32-or1k.lo elf32.lo $elf" ;;
+    or1k_elf32_be_vec)		 tb="$tb elf32-or1k.lo elf32.lo $elf" ;;
+    or1k_elf32_le_vec)		 tb="$tb elf32-or1k.lo elf32.lo $elf" ;;
     pdp11_aout_vec)		 tb="$tb pdp11.lo" ;;
     pef_vec)			 tb="$tb pef.lo" ;;
     pef_xlib_vec)		 tb="$tb pef.lo" ;;
diff --git a/bfd/configure.ac b/bfd/configure.ac
index a9078965c40..1998603a414 100644
--- a/bfd/configure.ac
+++ b/bfd/configure.ac
@@ -594,7 +594,8 @@ do
     nios2_elf32_le_vec)		 tb="$tb elf32-nios2.lo elf32.lo $elf" ;;
     ns32k_aout_pc532mach_vec)	 tb="$tb pc532-mach.lo aout-ns32k.lo" ;;
     ns32k_aout_pc532nbsd_vec)	 tb="$tb ns32knetbsd.lo aout-ns32k.lo" ;;
-    or1k_elf32_vec)		 tb="$tb elf32-or1k.lo elf32.lo $elf" ;;
+    or1k_elf32_be_vec)		 tb="$tb elf32-or1k.lo elf32.lo $elf" ;;
+    or1k_elf32_le_vec)		 tb="$tb elf32-or1k.lo elf32.lo $elf" ;;
     pdp11_aout_vec)		 tb="$tb pdp11.lo" ;;
     pef_vec)			 tb="$tb pef.lo" ;;
     pef_xlib_vec)		 tb="$tb pef.lo" ;;
diff --git a/bfd/elf32-or1k.c b/bfd/elf32-or1k.c
index 192e83aa7bc..c080402b3c4 100644
--- a/bfd/elf32-or1k.c
+++ b/bfd/elf32-or1k.c
@@ -3356,9 +3356,12 @@ or1k_grok_psinfo (bfd *abfd, Elf_Internal_Note *note)
 #define ELF_TARGET_ID			OR1K_ELF_DATA
 #define ELF_MAXPAGESIZE			0x2000
 
-#define TARGET_BIG_SYM			or1k_elf32_vec
+#define TARGET_BIG_SYM			or1k_elf32_be_vec
 #define TARGET_BIG_NAME			"elf32-or1k"
 
+#define TARGET_LITTLE_SYM		or1k_elf32_le_vec
+#define TARGET_LITTLE_NAME		"elf32-or1kle"
+
 #define elf_info_to_howto_rel		NULL
 #define elf_info_to_howto		or1k_info_to_howto_rela
 #define elf_backend_relocate_section	or1k_elf_relocate_section
diff --git a/bfd/targets.c b/bfd/targets.c
index 18fec45f02a..e9ed5104414 100644
--- a/bfd/targets.c
+++ b/bfd/targets.c
@@ -835,7 +835,8 @@ extern const bfd_target nios2_elf32_be_vec;
 extern const bfd_target nios2_elf32_le_vec;
 extern const bfd_target ns32k_aout_pc532mach_vec;
 extern const bfd_target ns32k_aout_pc532nbsd_vec;
-extern const bfd_target or1k_elf32_vec;
+extern const bfd_target or1k_elf32_be_vec;
+extern const bfd_target or1k_elf32_le_vec;
 extern const bfd_target pdp11_aout_vec;
 extern const bfd_target pef_vec;
 extern const bfd_target pef_xlib_vec;
@@ -1219,7 +1220,8 @@ static const bfd_target * const _bfd_target_vector[] =
 	&ns32k_aout_pc532mach_vec,
 	&ns32k_aout_pc532nbsd_vec,
 
-	&or1k_elf32_vec,
+	&or1k_elf32_be_vec,
+	&or1k_elf32_le_vec,
 
 	&pdp11_aout_vec,
 
diff --git a/gas/config/tc-or1k.c b/gas/config/tc-or1k.c
index ae4e3452f48..9dc5a46f2e2 100644
--- a/gas/config/tc-or1k.c
+++ b/gas/config/tc-or1k.c
@@ -58,8 +58,16 @@ const char FLT_CHARS[]            = "dD";
 #define OR1K_SHORTOPTS "m:"
 const char * md_shortopts = OR1K_SHORTOPTS;
 
+enum
+{
+  OPTION_LITTLE_ENDIAN = OPTION_MD_BASE,
+  OPTION_BIG_ENDIAN
+};
+
 struct option md_longopts[] =
 {
+  {"EB", no_argument, NULL, OPTION_BIG_ENDIAN},
+  {"EL", no_argument, NULL, OPTION_LITTLE_ENDIAN},
   {NULL, no_argument, NULL, 0}
 };
 size_t md_longopts_size = sizeof (md_longopts);
@@ -67,14 +75,30 @@ size_t md_longopts_size = sizeof (md_longopts);
 unsigned long or1k_machine = 0; /* default */
 
 int
-md_parse_option (int c ATTRIBUTE_UNUSED, const char * arg ATTRIBUTE_UNUSED)
+md_parse_option (int c, const char * arg ATTRIBUTE_UNUSED)
 {
-  return 0;
+  switch (c)
+    {
+    case OPTION_BIG_ENDIAN:
+      target_big_endian = 1;
+      break;
+    case OPTION_LITTLE_ENDIAN:
+      target_big_endian = 0;
+      break;
+    default:
+      return 0;
+    }
+
+  return 1;
 }
 
 void
-md_show_usage (FILE * stream ATTRIBUTE_UNUSED)
+md_show_usage (FILE * stream)
 {
+  fprintf (stream, _(" OR1K-specific assembler options:\n"));
+  fprintf (stream, _("\
+  --EB			generate code for a big endian machine\n\
+  --EL			generate code for a little endian machine\n"));
 }
 
 static void
@@ -111,9 +135,10 @@ md_begin (void)
 
   /* Set the machine number and endian.  */
   gas_cgen_cpu_desc = or1k_cgen_cpu_open (CGEN_CPU_OPEN_MACHS, 0,
-                                              CGEN_CPU_OPEN_ENDIAN,
-                                              CGEN_ENDIAN_BIG,
-                                              CGEN_CPU_OPEN_END);
+                                          CGEN_CPU_OPEN_ENDIAN,
+                                          target_big_endian ?
+                                          CGEN_ENDIAN_BIG : CGEN_ENDIAN_LITTLE,
+                                          CGEN_CPU_OPEN_END);
   or1k_cgen_init_asm (gas_cgen_cpu_desc);
 
   /* This is a callback from cgen to gas to parse operands.  */
@@ -268,7 +293,10 @@ md_cgen_lookup_reloc (const CGEN_INSN *    insn ATTRIBUTE_UNUSED,
 void
 md_number_to_chars (char * buf, valueT val, int n)
 {
-  number_to_chars_bigendian (buf, val, n);
+  if (target_big_endian)
+    number_to_chars_bigendian (buf, val, n);
+  else
+    number_to_chars_littleendian (buf, val, n);
 }
 
 /* Turn a string in input_line_pointer into a floating point constant of type
diff --git a/gas/config/tc-or1k.h b/gas/config/tc-or1k.h
index dd4f7c837c7..6d81b01db7a 100644
--- a/gas/config/tc-or1k.h
+++ b/gas/config/tc-or1k.h
@@ -26,8 +26,11 @@
 extern unsigned long or1k_machine;
 #define TARGET_MACH (or1k_machine)
 
-#define TARGET_FORMAT           "elf32-or1k"
+#define TARGET_FORMAT           (target_big_endian ? "elf32-or1k" : "elf32-or1kle")
+
+#ifndef TARGET_BYTES_BIG_ENDIAN
 #define TARGET_BYTES_BIG_ENDIAN 1
+#endif
 
 extern const char or1k_comment_chars [];
 #define tc_comment_chars or1k_comment_chars
diff --git a/gas/configure b/gas/configure
index dc6a6682aa4..9ea95a3396b 100755
--- a/gas/configure
+++ b/gas/configure
@@ -12684,7 +12684,7 @@ esac
 cgen_cpu_prefix=""
 if test $using_cgen = yes ; then
   case ${target_cpu} in
-    or1knd)
+    or1k*)
        cgen_cpu_prefix=or1k ;;
     *) cgen_cpu_prefix=${target_cpu} ;;
   esac
diff --git a/gas/configure.ac b/gas/configure.ac
index 572e56e281c..03786ed073b 100644
--- a/gas/configure.ac
+++ b/gas/configure.ac
@@ -812,7 +812,7 @@ esac
 cgen_cpu_prefix=""
 if test $using_cgen = yes ; then
   case ${target_cpu} in
-    or1knd)
+    or1k*)
        cgen_cpu_prefix=or1k ;;
     *) cgen_cpu_prefix=${target_cpu} ;;
   esac
diff --git a/gas/configure.tgt b/gas/configure.tgt
index 62f806bdfe8..f4f6e6c216a 100644
--- a/gas/configure.tgt
+++ b/gas/configure.tgt
@@ -86,7 +86,8 @@ case ${cpu} in
   mt)			cpu_type=mt endian=big ;;
   nds32be)		cpu_type=nds32 endian=big ;;
   nds32le)		cpu_type=nds32 endian=little ;;
-  or1k* | or1knd*)	cpu_type=or1k endian=big ;;
+  or1kle*)		cpu_type=or1k endian=little ;;
+  or1k*)		cpu_type=or1k endian=big ;;
   pjl*)			cpu_type=pj endian=little ;;
   pj*)			cpu_type=pj endian=big ;;
   powerpc*le*)		cpu_type=ppc endian=little ;;
@@ -349,7 +350,9 @@ case ${generic_target} in
   ns32k-pc532-lites*)			fmt=aout em=nbsd532 ;;
   ns32k-*-*n*bsd*)			fmt=aout em=nbsd532 ;;
 
+  or1kle*-*-elf | or1kle*-*-rtems*) 	fmt=elf endian=little ;;
   or1k*-*-elf | or1k*-*-rtems*) 	fmt=elf endian=big ;;
+  or1kle*-*-linux*)			fmt=elf em=linux endian=little ;;
   or1k*-*-linux*)			fmt=elf em=linux endian=big ;;
 
   pj*)					fmt=elf ;;
@@ -447,7 +450,7 @@ esac
 
 case ${cpu_type} in
   aarch64 | alpha | arm | csky | i386 | ia64 | microblaze | mips | ns32k | \
-  or1k | or1knd | pdp11 | ppc | riscv | sh | sparc | z80 | z8k | loongarch)
+  or1k | pdp11 | ppc | riscv | sh | sparc | z80 | z8k | loongarch)
     bfd_gas=yes
     ;;
 esac
diff --git a/ld/configure.tgt b/ld/configure.tgt
index c7acf3f11ff..6ab4dceb6be 100644
--- a/ld/configure.tgt
+++ b/ld/configure.tgt
@@ -621,10 +621,10 @@ ns32k-pc532-mach* | ns32k-pc532-ux*)  targ_emul=pc532macha
 ns32k-*-*bsd* | ns32k-pc532-lites*) targ_emul=ns32knbsd
 			targ_extra_ofiles=
 			;;
-or1k-*-elf | or1knd-*-elf | or1k-*-rtems* | or1knd-*-rtems*)
+or1k*-*-elf | or1k*-*-rtems*)
 			targ_emul=elf32or1k
 			;;
-or1k-*-linux* | or1knd-*-linux*)	targ_emul=elf32or1k_linux
+or1k*-*-linux*)		targ_emul=elf32or1k_linux
 			;;
 pdp11-*-*)		targ_emul=pdp11
 			targ_extra_ofiles=
diff --git a/ld/emulparams/elf32or1k.sh b/ld/emulparams/elf32or1k.sh
index 48d2ecfa2b0..ccf940dc1b4 100644
--- a/ld/emulparams/elf32or1k.sh
+++ b/ld/emulparams/elf32or1k.sh
@@ -1,7 +1,9 @@
 SCRIPT_NAME=elf
 MACHINE=
 TEMPLATE_NAME=elf
-OUTPUT_FORMAT="elf32-or1k"
+BIG_OUTPUT_FORMAT="elf32-or1k"
+LITTLE_OUTPUT_FORMAT="elf32-or1kle"
+OUTPUT_FORMAT="$BIG_OUTPUT_FORMAT"
 NOP=0x15000000
 TEXT_START_ADDR=0x0000
 TARGET_PAGE_SIZE=0x2000
diff --git a/ld/testsuite/ld-elf/binutils.exp b/ld/testsuite/ld-elf/binutils.exp
index ee90009bb9b..fd459a2223d 100644
--- a/ld/testsuite/ld-elf/binutils.exp
+++ b/ld/testsuite/ld-elf/binutils.exp
@@ -94,7 +94,7 @@ proc binutils_test { prog_name ld_options test {test_name ""} {readelf_options "
 			      || [istarget "metag-*-*"] \
 			      || [istarget "mips*-*-*"] \
 			      || [istarget "nios2*-*-*"] \
-			      || [istarget "or1k-*-*"] \
+			      || [istarget "or1k*-*-*"] \
 			      || [istarget "riscv*-*-*"] \
 			      || [istarget "sh*-*-*"] \
 			      || [istarget "x86_64-*-rdos*"])]
diff --git a/ld/testsuite/ld-ifunc/ifunc.exp b/ld/testsuite/ld-ifunc/ifunc.exp
index 1cd8d388b26..122468477ec 100644
--- a/ld/testsuite/ld-ifunc/ifunc.exp
+++ b/ld/testsuite/ld-ifunc/ifunc.exp
@@ -38,7 +38,7 @@ if { ![is_elf_format] || ![supports_gnu_osabi]
      || [istarget mn10300-*-*]
      || [istarget nds32*-*-*]
      || [istarget nios2-*-*]
-     || [istarget or1k-*-*]
+     || [istarget or1k*-*-*]
      || [istarget score*-*-*]
      || [istarget sh*-*-*]
      || [istarget tic6x-*-*]
diff --git a/opcodes/or1k-opc.h b/opcodes/or1k-opc.h
index d0950755250..53a3ca4ee21 100644
--- a/opcodes/or1k-opc.h
+++ b/opcodes/or1k-opc.h
@@ -35,7 +35,7 @@ extern "C" {
 #undef  CGEN_DIS_HASH_SIZE
 #define CGEN_DIS_HASH_SIZE 256
 #undef  CGEN_DIS_HASH
-#define CGEN_DIS_HASH(buffer, value) (((unsigned char *) (buffer))[0] >> 2)
+#define CGEN_DIS_HASH(buffer, value) ((value) >> 26)
 
 /* Check applicability of instructions against machines.  */
 #define CGEN_VALIDATE_INSN_SUPPORTED
-- 
2.35.1

