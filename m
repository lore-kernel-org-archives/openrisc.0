Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127BF1C3318
	for <linux-openrisc@vger.kernel.org>; Thu,  5 Dec 2024 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403876; cv=none; b=mV0zb9fvcQN8V0oCy6MDG75obfX66QoCadxI6IrMqkTHmYaz3sfTXrYvI70pYCh0P2anKmVYGHcsCcjyGonM7MnJtSaFgzTOLZ456cvq0Y5TEmLYeoVzWvwKrxC37E8SxhOOf1YGz/PinrQuziBrFXeJrMHuvNsi45reZDUjHXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403876; c=relaxed/simple;
	bh=u8j/ST72/79tpf+luUbj7cyXZNpmDIQokPfV7wN0How=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tbkHg8oZlP3XZGeMxv2cYNR1m8mkuW1NnQq41Ke+NyuG/DtQMAKrmMDdQVXUnV6eILEvid0L0+fc5L863uwImmAl97nS0Amb3cj5Iw1Yo5LcOFQF+zlJxJ0uWRhOcWDu0KxljbfQfwjO1DBs7yFts622hhIsv2f+9osTxDNWtcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b16a:6561:fa1:2b32])
	by albert.telenet-ops.be with cmsmtp
	id l14X2D00J3EEtj20614Xwt; Thu, 05 Dec 2024 14:04:31 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tJBWw-000LPC-Jx;
	Thu, 05 Dec 2024 14:04:31 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tJBWx-00EQNK-BB;
	Thu, 05 Dec 2024 14:04:31 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>
Cc: linux-openrisc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] openrisc: Fix misalignments in head.S
Date: Thu,  5 Dec 2024 14:04:26 +0100
Message-Id: <5bd42e2b9e50929f7a1df03655bbaebb78f167ba.1733403630.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Align all line continuations and (sub)section headers in a consistent
way.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/openrisc/kernel/head.S | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index 439e00f81e5dde18..b64ac73455ed3279 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -26,15 +26,15 @@
 #include <asm/asm-offsets.h>
 #include <linux/of_fdt.h>
 
-#define tophys(rd,rs)				\
-	l.movhi	rd,hi(-KERNELBASE)		;\
+#define tophys(rd,rs)						\
+	l.movhi	rd,hi(-KERNELBASE)				;\
 	l.add	rd,rd,rs
 
-#define CLEAR_GPR(gpr)				\
+#define CLEAR_GPR(gpr)						\
 	l.movhi	gpr,0x0
 
-#define LOAD_SYMBOL_2_GPR(gpr,symbol)		\
-	l.movhi gpr,hi(symbol)			;\
+#define LOAD_SYMBOL_2_GPR(gpr,symbol)				\
+	l.movhi gpr,hi(symbol)					;\
 	l.ori   gpr,gpr,lo(symbol)
 
 
@@ -326,21 +326,21 @@
 	l.addi  r1,r1,-(INT_FRAME_SIZE)				;\
 	/* r1 is KSP, r30 is __pa(KSP) */			;\
 	tophys  (r30,r1)					;\
-	l.sw    PT_GPR12(r30),r12					;\
+	l.sw    PT_GPR12(r30),r12				;\
 	l.mfspr r12,r0,SPR_EPCR_BASE				;\
 	l.sw    PT_PC(r30),r12					;\
 	l.mfspr r12,r0,SPR_ESR_BASE				;\
 	l.sw    PT_SR(r30),r12					;\
 	/* save r31 */						;\
 	EXCEPTION_T_LOAD_GPR30(r12)				;\
-	l.sw	PT_GPR30(r30),r12					;\
+	l.sw	PT_GPR30(r30),r12				;\
 	/* save r10 as was prior to exception */		;\
 	EXCEPTION_T_LOAD_GPR10(r12)				;\
-	l.sw	PT_GPR10(r30),r12					;\
-	/* save PT_SP as was prior to exception */			;\
+	l.sw	PT_GPR10(r30),r12				;\
+	/* save PT_SP as was prior to exception */		;\
 	EXCEPTION_T_LOAD_SP(r12)				;\
 	l.sw	PT_SP(r30),r12					;\
-	l.sw    PT_GPR13(r30),r13					;\
+	l.sw    PT_GPR13(r30),r13				;\
 	/* --> */						;\
 	/* save exception r4, set r4 = EA */			;\
 	l.sw	PT_GPR4(r30),r4					;\
@@ -394,7 +394,7 @@ _dispatch_do_ipage_fault:
     .org 0x500
 	EXCEPTION_HANDLE(_timer_handler)
 
-/* ---[ 0x600: Alignment exception ]-------------------------------------- */
+/* ---[ 0x600: Alignment exception ]------------------------------------- */
     .org 0x600
 	EXCEPTION_HANDLE(_alignment_handler)
 
@@ -424,7 +424,7 @@ _dispatch_do_ipage_fault:
     .org 0xc00
 	EXCEPTION_HANDLE(_sys_call_handler)
 
-/* ---[ 0xd00: Floating point exception ]--------------------------------- */
+/* ---[ 0xd00: Floating point exception ]-------------------------------- */
     .org 0xd00
 	EXCEPTION_HANDLE(_fpe_trap_handler)
 
@@ -816,7 +816,7 @@ secondary_start:
 
 #endif
 
-/* ========================================[ cache ]=== */
+/* ==========================================================[ cache ]=== */
 
 	/* alignment here so we don't change memory offsets with
 	 * memory controller defined
-- 
2.34.1

