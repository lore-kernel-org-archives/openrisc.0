Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B30BC43334
	for <openrisc@archiver.kernel.org>; Thu,  9 Jun 2022 06:04:03 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 74EBB22126;
	Thu,  9 Jun 2022 08:04:02 +0200 (CEST)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by mail.librecores.org (Postfix) with ESMTPS id 3B05F24758
 for <openrisc@lists.librecores.org>; Thu,  9 Jun 2022 08:04:01 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id A2F9D5C0176;
 Thu,  9 Jun 2022 02:03:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Thu, 09 Jun 2022 02:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:sender:subject:subject:to:to;
 s=fm3; t=1654754639; x=1654841039; bh=3oBSHMelw/0F3dJtbYZ0N/Mj7
 XNWyQpFm5hXg/YNoJo=; b=vvL3eAAq6/k26vr5gzs9cvlHGWiwj2pxMmhMX2b+0
 jlwya97lVElM6gPSi6vS7KAVDJ4SOys/BNHUxMqIMR38ISrKfF464Q2St8LTOCTP
 kSgEvTbQCEkGXbC3NNeGC5kvGoMo4Ff0lbEn1O0rbl+I9mY3cl6sVb51b40zGy/a
 bI1mT8Au/4vIKX2of6iMJKabhtBr9sl/OUHkLqYLAam0HcPcJouEeQwfJNpJNJj9
 1j4ihEx+xJRlETrBWPrloWrCWoACneOYrM0rxIzKY+r9lP5JowLsyb+1UehRCH13
 N0TYDfohi7KAzuG6xNEzr1R4Hg+KTJ1TgTz6ays/I+J3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:message-id
 :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1654754639; x=1654841039; bh=3oBSHMelw/0F3dJtbYZ0N/Mj7XNWyQpFm5h
 Xg/YNoJo=; b=DG9DYU4TvCmHrgAHLnwhHMZ94I6tO3O3GbrPG4LokdOOSzUlFrj
 1lmIpCgeBTGehIlkugesATQjB8coxW+9ABefKG1tw+F3GCX6hoKfoHUEHKmNJOax
 Y0acwW6mxF/rMk1mzkQIvvd45m5N8x3ordIq1/hU84IwJBpaALcVo7KvV1BLSb+g
 rJoF7mZLJua/9Q+qD+RR195RIN+q7hxCRpsQzBo39THJwcfMgigockzAkBsTPCuH
 oVmWrOalztM7knoOVV2ZGBukjgh1QrtmyMC7wtj+bFfLS/z+fCzmP3Cm7FcNQfLx
 S3Bty+fi1lWDtQb5zB6aZwQ5tXTaDcuVcVQ==
X-ME-Sender: <xms:To2hYnZP2ND2PZ5gmVxlCDuZgk_26f0nXxQvI1fCJLNPf_oJMkCXtg>
 <xme:To2hYmb1OyCmHjM0ZVRO79V5tSQg_y1E8c4Ot-1uP5eCLzUqMbTu_1r-pE3aziOJ8
 1_Kcvb52Kx79-cVaQ>
X-ME-Received: <xmr:To2hYp94aT1XZeqPG7UudKtbtxiWAyvWaMQHVMXDfGeChNosW0y52zKbf6MnC0uecheFNuRKEhHfspEzhPmb3VfygnX2uDK0G2_y7m4AkwNqdIxnxOL-7ZlTP-SJgMKydU5zOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtkedguddtudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
 lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
 frrghtthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeeh
 hffhkeekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:To2hYtqhvkHx8TZc70Ne4DUe76jbECYl7MnnJKbP-SU9qljmThALTw>
 <xmx:To2hYiqK0MDaPfCC8URWW7TmCy3AqqmgdUu7bozEzo3kRMNID8NFgg>
 <xmx:To2hYjQsi8BAIndrOeDrIOmaCmJtr30yvJjeNEIcedZLzxlfgCBt6Q>
 <xmx:T42hYp3yjivw1AYt3nmReG8KrHVrXcYAtgl4HPZL7aA28FUoL71bkA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jun 2022 02:03:58 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: gcc-patches@gcc.gnu.org
Subject: [PATCH] or1k: Add support for a little-endian target variant
Date: Thu,  9 Jun 2022 01:03:57 -0500
Message-Id: <20220609060357.26436-1-samuel@sholland.org>
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

gcc/ChangeLog:

	* config.gcc: Set TARGET_LITTLE_ENDIAN_DEFAULT from target.
	* config/or1k/elf.h (LINK_SPEC): Pass -EB/-EL to the linker.
	* config/or1k/linux.h (LINK_SPEC): Pass -EB/-EL to the linker.
	* config/or1k/or1k.h (ENDIAN_SPEC): Set default endianness.
	(DRIVER_SELF_SPECS): Set default endianness.
	(ASM_SPEC): Pass -EB/-EL to the assembler.
	(LINK_SPEC): Pass -EB/-EL to the linker.
	(BYTES_BIG_ENDIAN): Make dependent on TARGET_BIG_ENDIAN.
	(WORDS_BIG_ENDIAN): Likewise.
	* config/or1k/or1k.opt: Add -mbig-endian/-mlittle-endian.

libgcc/ChangeLog:

	* config.host (or1k): Generalize arch to or1k*.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 gcc/config.gcc           |  5 +++++
 gcc/config/or1k/elf.h    |  1 +
 gcc/config/or1k/linux.h  |  1 +
 gcc/config/or1k/or1k.h   | 19 +++++++++++++++++--
 gcc/config/or1k/or1k.opt |  8 ++++++++
 libgcc/config.host       |  4 ++--
 6 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/gcc/config.gcc b/gcc/config.gcc
index c5064dd37666..0c3a09dfe810 100644
--- a/gcc/config.gcc
+++ b/gcc/config.gcc
@@ -2866,6 +2866,11 @@ or1k*-*-*)
 	done
 	TM_MULTILIB_CONFIG=`echo $TM_MULTILIB_CONFIG | sed 's/^,//'`
 
+	case ${target} in
+	or1k*le*-*)
+		tm_defines="${tm_defines} TARGET_LITTLE_ENDIAN_DEFAULT=1"
+		;;
+	esac
 	case ${target} in
 	or1k*-*-linux*)
 		tm_file="${tm_file} gnu-user.h linux.h glibc-stdint.h"
diff --git a/gcc/config/or1k/elf.h b/gcc/config/or1k/elf.h
index d3d27028aa37..44c0a0687c7f 100644
--- a/gcc/config/or1k/elf.h
+++ b/gcc/config/or1k/elf.h
@@ -27,6 +27,7 @@
 
 #undef	LINK_SPEC
 #define LINK_SPEC "%{h*}			\
+   %{mbig-endian:-EB} %{mlittle-endian:-EL}	\
    %{static:-Bstatic}				\
    %{shared:-shared}				\
    %{symbolic:-Bsymbolic}			\
diff --git a/gcc/config/or1k/linux.h b/gcc/config/or1k/linux.h
index 80f77c722322..8fe8b0168b11 100644
--- a/gcc/config/or1k/linux.h
+++ b/gcc/config/or1k/linux.h
@@ -36,6 +36,7 @@
 
 #undef LINK_SPEC
 #define LINK_SPEC "%{h*}			\
+   %{mbig-endian:-EB} %{mlittle-endian:-EL}	\
    %{static:-Bstatic}				\
    %{shared:-shared}				\
    %{symbolic:-Bsymbolic}			\
diff --git a/gcc/config/or1k/or1k.h b/gcc/config/or1k/or1k.h
index 18a526d386f1..b5e4a2181336 100644
--- a/gcc/config/or1k/or1k.h
+++ b/gcc/config/or1k/or1k.h
@@ -23,6 +23,21 @@
 
 #include "config/or1k/or1k-opts.h"
 
+#ifndef TARGET_LITTLE_ENDIAN_DEFAULT
+#define ENDIAN_SPEC "-mbig-endian"
+#else
+#define ENDIAN_SPEC "-mlittle-endian"
+#endif
+
+/* Force the default endianness and ABI flags onto the command line
+   in order to make the other specs easier to write.  */
+#undef DRIVER_SELF_SPECS
+#define DRIVER_SELF_SPECS \
+  " %{!mbig-endian:%{!mlittle-endian:" ENDIAN_SPEC "}}"
+
+#define ASM_SPEC "%{mbig-endian:-EB} %{mlittle-endian:-EL}"
+#define LINK_SPEC "%{mbig-endian:-EB} %{mlittle-endian:-EL}"
+
 /* Names to predefine in the preprocessor for this target machine.  */
 #define TARGET_CPU_CPP_BUILTINS()		\
   do						\
@@ -48,8 +63,8 @@
 
 #define DEFAULT_SIGNED_CHAR 1
 #define BITS_BIG_ENDIAN 0
-#define BYTES_BIG_ENDIAN 1
-#define WORDS_BIG_ENDIAN 1
+#define BYTES_BIG_ENDIAN (TARGET_BIG_ENDIAN)
+#define WORDS_BIG_ENDIAN (TARGET_BIG_ENDIAN)
 #define BITS_PER_WORD 32
 #define UNITS_PER_WORD 4
 #define POINTER_SIZE 32
diff --git a/gcc/config/or1k/or1k.opt b/gcc/config/or1k/or1k.opt
index 8a66832a99b1..497f259faae9 100644
--- a/gcc/config/or1k/or1k.opt
+++ b/gcc/config/or1k/or1k.opt
@@ -24,6 +24,14 @@
 HeaderInclude
 config/or1k/or1k-opts.h
 
+mbig-endian
+Target Report RejectNegative Mask(BIG_ENDIAN)
+Use big-endian byte order.
+
+mlittle-endian
+Target Report RejectNegative InverseMask(BIG_ENDIAN, LITTLE_ENDIAN)
+Use little-endian byte order.
+
 mhard-div
 Target RejectNegative InverseMask(SOFT_DIV)
 Enable generation of hardware divide (l.div, l.divu) instructions.  This is the
diff --git a/libgcc/config.host b/libgcc/config.host
index 8c56fcae5d2f..45c8d1a47d9a 100644
--- a/libgcc/config.host
+++ b/libgcc/config.host
@@ -1144,12 +1144,12 @@ nios2-*-*)
 	tmake_file="$tmake_file nios2/t-nios2 t-softfp-sfdf t-softfp-excl t-softfp"
 	extra_parts="$extra_parts crti.o crtn.o"
 	;;
-or1k-*-linux*)
+or1k*-*-linux*)
 	tmake_file="$tmake_file or1k/t-or1k or1k/t-crtstuff"
 	tmake_file="$tmake_file t-softfp-sfdf t-softfp"
 	md_unwind_header=or1k/linux-unwind.h
 	;;
-or1k-*-*)
+or1k*-*-*)
 	tmake_file="$tmake_file or1k/t-or1k or1k/t-crtstuff"
 	tmake_file="$tmake_file t-softfp-sfdf t-softfp"
 	;;
-- 
2.35.1

