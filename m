Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77D3C433F5
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 12:42:55 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 1643320D0C;
	Sun, 15 May 2022 14:42:55 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by mail.librecores.org (Postfix) with ESMTPS id 5ED5520D0C
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 14:42:53 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id n10so11962472pjh.5
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 05:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YyxbfrF93QriCFR9e9/Ieq2jTtQBkK6LoG1jr7zyJxk=;
 b=U4Co/+AWH+Ddsj+Q3im68TyC5N9SC0cFTsnznuJFxX/IyRuGJJQYvXXTz6iIE5+vem
 H+EVLemfG7PuYiboxjaQNH//2vdhQSqBBeGk8cn/C+EREkfxrVY7g4ABXEeldgIS7Ykb
 iDSe1HAlyhvep86v+yfc+G4juohyWhoQ1owOBShDac2HcLZlkANNdKK2CqOvCwO+Pz6V
 EHdXeR/wC+d2M4vMbGf1JMDRs5eNlGAnPD8BgmZkWGjeUQyBpZOUY7oKCkUOcse1rs3s
 jYFMGjRNaTYflTH5Ri0hCJAqZHN1/7y53N6sy8JrOJJ68F0fRPrisPYMw+zbEpA99Hjs
 HMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YyxbfrF93QriCFR9e9/Ieq2jTtQBkK6LoG1jr7zyJxk=;
 b=Q3zzdZUQw9tNUg3NAjq+LfqYR9HFKXWc+D/ksc5WbPZxfyZU1K7wWm+yaxAmGMZTzp
 ydxA8GgULCHn69HDSKN1Iy29T/BOQmNj4YM42exBEfYTY9ZW6M81+RbY+S1+3S73EI54
 U9nBiatBR3PhkwNvEJPRnm6GIN9TkqvCDAdf2iEGPGxpqYp3xsDo4ak3cozuhis4rh8h
 oo5UpmfpXzwWXYN8voV3E3Ddj3gfgsce632b8ikNLcn2mUo/PrcLUjjTyDIvwp3IQbaE
 hnDQpluYQJPpexJQdGOTbCroTmm/jV8QGUGjfD061W6PaiSncDLxDSz2dLvA7JpkP9OG
 SV6A==
X-Gm-Message-State: AOAM532+f6cz6KqA17LmhbPf5oesIlQNUo43A1WQg2Iu82OND2zkUabn
 q85UpLTKbZgoZB6TtM5zH1nc2syeQbhx/Q==
X-Google-Smtp-Source: ABdhPJwv2LEfSzfEbP9zNb35/Pe2z5GG2Xehf3U8lWg9Vput1lt9MRyGSG/JsXoyvckZIL5sLBZssA==
X-Received: by 2002:a17:902:f682:b0:15e:951b:8091 with SMTP id
 l2-20020a170902f68200b0015e951b8091mr13108157plg.106.1652618571891; 
 Sun, 15 May 2022 05:42:51 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 bc12-20020a170902930c00b0015e8d4eb20esm5069369plb.88.2022.05.15.05.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 May 2022 05:42:51 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 13/13] openrisc: Remove unused IMMU tlb workardound
Date: Sun, 15 May 2022 21:41:58 +0900
Message-Id: <20220515124158.3167452-14-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220515124158.3167452-1-shorne@gmail.com>
References: <20220515124158.3167452-1-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Openrisc <openrisc@lists.librecores.org>,
 Randy Dunlap <rdunlap@infradead.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

This looks to be some historical code that was used to convert TLB
misses on branches from l.bf, l.jal, l.j etc all to a trampoline
using l.jr (jump register).  I don't see this being used and I don't
know the history of it so remove it.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/head.S | 209 ------------------------------------
 1 file changed, 209 deletions(-)

diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index 21db50563f97..9b59d0ca665c 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -1325,215 +1325,6 @@ i_pte_not_present:
 
 /* =================================================[ debugging aids ]=== */
 
-	.align 64
-_immu_trampoline:
-	.space 64
-_immu_trampoline_top:
-
-#define TRAMP_SLOT_0		(0x0)
-#define TRAMP_SLOT_1		(0x4)
-#define TRAMP_SLOT_2		(0x8)
-#define TRAMP_SLOT_3		(0xc)
-#define TRAMP_SLOT_4		(0x10)
-#define TRAMP_SLOT_5		(0x14)
-#define TRAMP_FRAME_SIZE	(0x18)
-
-ENTRY(_immu_trampoline_workaround)
-	// r2 EEA
-	// r6 is physical EEA
-	tophys(r6,r2)
-
-	LOAD_SYMBOL_2_GPR(r5,_immu_trampoline)
-	tophys	(r3,r5)			// r3 is trampoline (physical)
-
-	LOAD_SYMBOL_2_GPR(r4,0x15000000)
-	l.sw	TRAMP_SLOT_0(r3),r4
-	l.sw	TRAMP_SLOT_1(r3),r4
-	l.sw	TRAMP_SLOT_4(r3),r4
-	l.sw	TRAMP_SLOT_5(r3),r4
-
-					// EPC = EEA - 0x4
-	l.lwz	r4,0x0(r6)		// load op @ EEA + 0x0 (fc address)
-	l.sw	TRAMP_SLOT_3(r3),r4	// store it to _immu_trampoline_data
-	l.lwz	r4,-0x4(r6)		// load op @ EEA - 0x4 (f8 address)
-	l.sw	TRAMP_SLOT_2(r3),r4	// store it to _immu_trampoline_data
-
-	l.srli  r5,r4,26                // check opcode for write access
-	l.sfeqi r5,0                    // l.j
-	l.bf    0f
-	l.sfeqi r5,0x11                 // l.jr
-	l.bf    1f
-	l.sfeqi r5,1                    // l.jal
-	l.bf    2f
-	l.sfeqi r5,0x12                 // l.jalr
-	l.bf    3f
-	l.sfeqi r5,3                    // l.bnf
-	l.bf    4f
-	l.sfeqi r5,4                    // l.bf
-	l.bf    5f
-99:
-	l.nop
-	l.j	99b			// should never happen
-	l.nop	1
-
-	// r2 is EEA
-	// r3 is trampoline address (physical)
-	// r4 is instruction
-	// r6 is physical(EEA)
-	//
-	// r5
-
-2:	// l.jal
-
-	/* 19 20 aa aa	l.movhi r9,0xaaaa
-	 * a9 29 bb bb  l.ori	r9,0xbbbb
-	 *
-	 * where 0xaaaabbbb is EEA + 0x4 shifted right 2
-	 */
-
-	l.addi	r6,r2,0x4		// this is 0xaaaabbbb
-
-					// l.movhi r9,0xaaaa
-	l.ori	r5,r0,0x1920		// 0x1920 == l.movhi r9
-	l.sh	(TRAMP_SLOT_0+0x0)(r3),r5
-	l.srli	r5,r6,16
-	l.sh	(TRAMP_SLOT_0+0x2)(r3),r5
-
-					// l.ori   r9,0xbbbb
-	l.ori	r5,r0,0xa929		// 0xa929 == l.ori r9
-	l.sh	(TRAMP_SLOT_1+0x0)(r3),r5
-	l.andi	r5,r6,0xffff
-	l.sh	(TRAMP_SLOT_1+0x2)(r3),r5
-
-	/* falthrough, need to set up new jump offset */
-
-
-0:	// l.j
-	l.slli	r6,r4,6			// original offset shifted left 6 - 2
-//	l.srli	r6,r6,6			// original offset shifted right 2
-
-	l.slli	r4,r2,4			// old jump position: EEA shifted left 4
-//	l.srli	r4,r4,6			// old jump position: shifted right 2
-
-	l.addi	r5,r3,0xc		// new jump position (physical)
-	l.slli	r5,r5,4			// new jump position: shifted left 4
-
-	// calculate new jump offset
-	// new_off = old_off + (old_jump - new_jump)
-
-	l.sub	r5,r4,r5		// old_jump - new_jump
-	l.add	r5,r6,r5		// orig_off + (old_jump - new_jump)
-	l.srli	r5,r5,6			// new offset shifted right 2
-
-	// r5 is new jump offset
-					// l.j has opcode 0x0...
-	l.sw	TRAMP_SLOT_2(r3),r5	// write it back
-
-	l.j	trampoline_out
-	l.nop
-
-/* ----------------------------- */
-
-3:	// l.jalr
-
-	/* 19 20 aa aa	l.movhi r9,0xaaaa
-	 * a9 29 bb bb  l.ori	r9,0xbbbb
-	 *
-	 * where 0xaaaabbbb is EEA + 0x4 shifted right 2
-	 */
-
-	l.addi	r6,r2,0x4		// this is 0xaaaabbbb
-
-					// l.movhi r9,0xaaaa
-	l.ori	r5,r0,0x1920		// 0x1920 == l.movhi r9
-	l.sh	(TRAMP_SLOT_0+0x0)(r3),r5
-	l.srli	r5,r6,16
-	l.sh	(TRAMP_SLOT_0+0x2)(r3),r5
-
-					// l.ori   r9,0xbbbb
-	l.ori	r5,r0,0xa929		// 0xa929 == l.ori r9
-	l.sh	(TRAMP_SLOT_1+0x0)(r3),r5
-	l.andi	r5,r6,0xffff
-	l.sh	(TRAMP_SLOT_1+0x2)(r3),r5
-
-	l.lhz	r5,(TRAMP_SLOT_2+0x0)(r3)	// load hi part of jump instruction
-	l.andi	r5,r5,0x3ff		// clear out opcode part
-	l.ori	r5,r5,0x4400		// opcode changed from l.jalr -> l.jr
-	l.sh	(TRAMP_SLOT_2+0x0)(r3),r5 // write it back
-
-	/* falthrough */
-
-1:	// l.jr
-	l.j	trampoline_out
-	l.nop
-
-/* ----------------------------- */
-
-4:	// l.bnf
-5:	// l.bf
-	l.slli	r6,r4,6			// original offset shifted left 6 - 2
-//	l.srli	r6,r6,6			// original offset shifted right 2
-
-	l.slli	r4,r2,4			// old jump position: EEA shifted left 4
-//	l.srli	r4,r4,6			// old jump position: shifted right 2
-
-	l.addi	r5,r3,0xc		// new jump position (physical)
-	l.slli	r5,r5,4			// new jump position: shifted left 4
-
-	// calculate new jump offset
-	// new_off = old_off + (old_jump - new_jump)
-
-	l.add	r6,r6,r4		// (orig_off + old_jump)
-	l.sub	r6,r6,r5		// (orig_off + old_jump) - new_jump
-	l.srli	r6,r6,6			// new offset shifted right 2
-
-	// r6 is new jump offset
-	l.lwz	r4,(TRAMP_SLOT_2+0x0)(r3)	// load jump instruction
-	l.srli	r4,r4,16
-	l.andi	r4,r4,0xfc00		// get opcode part
-	l.slli	r4,r4,16
-	l.or	r6,r4,r6		// l.b(n)f new offset
-	l.sw	TRAMP_SLOT_2(r3),r6	// write it back
-
-	/* we need to add l.j to EEA + 0x8 */
-	tophys	(r4,r2)			// may not be needed (due to shifts down_
-	l.addi	r4,r4,(0x8 - 0x8)	// jump target = r2 + 0x8 (compensate for 0x8)
-					// jump position = r5 + 0x8 (0x8 compensated)
-	l.sub	r4,r4,r5		// jump offset = target - new_position + 0x8
-
-	l.slli	r4,r4,4			// the amount of info in imediate of jump
-	l.srli	r4,r4,6			// jump instruction with offset
-	l.sw	TRAMP_SLOT_4(r3),r4	// write it to 4th slot
-
-	/* fallthrough */
-
-trampoline_out:
-	// set up new EPC to point to our trampoline code
-	LOAD_SYMBOL_2_GPR(r5,_immu_trampoline)
-	l.mtspr	r0,r5,SPR_EPCR_BASE
-
-	// immu_trampoline is (4x) CACHE_LINE aligned
-	// and only 6 instructions long,
-	// so we need to invalidate only 2 lines
-
-	/* Establish cache block size
-	   If BS=0, 16;
-	   If BS=1, 32;
-	   r14 contain block size
-	*/
-	l.mfspr r21,r0,SPR_ICCFGR
-	l.andi	r21,r21,SPR_ICCFGR_CBS
-	l.srli	r21,r21,7
-	l.ori	r23,r0,16
-	l.sll	r14,r23,r21
-
-	l.mtspr	r0,r5,SPR_ICBIR
-	l.add	r5,r5,r14
-	l.mtspr	r0,r5,SPR_ICBIR
-
-	l.jr	r9
-	l.nop
-
 /*
  * DESC: Prints ASCII character stored in r7
  *
-- 
2.31.1

