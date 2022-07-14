Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41A9CCA486
	for <openrisc@archiver.kernel.org>; Thu, 14 Jul 2022 04:27:04 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 20E2C248B4;
	Thu, 14 Jul 2022 06:27:04 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mail.librecores.org (Postfix) with ESMTPS id 415C3248B4
 for <openrisc@lists.librecores.org>; Thu, 14 Jul 2022 06:27:02 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2F70061EB3;
 Thu, 14 Jul 2022 04:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A334AC34115;
 Thu, 14 Jul 2022 04:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657772820;
 bh=5IEYN5foefB4K0Dyg0jaz4/QY7YbSg5VpEmxben9s0s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kiuFO5ijsrlwaHO6zXzplZ5N+Ne7EQs75fHvML/6/mobeUtxh/2oPET+s5SNYBCWT
 Eqok+jrDqEz6DqzhMW6zt0tFBrhqviLr5P8ryGpOR+kjQEMJE2zFDVhOPzAYiWcLzY
 LKoTSOiXsDwEYihUuev0sz4cPLIYnjToYbmzh5G0JheeZaPAUmFYXV6wM9WsWXLrCB
 Lp0HNtpjLkLrAFeS5p8bE1fgW4Yepqcnakqi4OJkvqt/r1FNRtaM8EDOOVTfSWyu0n
 U+hNpsYQ8zI8iF4cGBb14WzNzlm3+drWWmFYs5TEDn0fD2d3t+Z9lBicZxGoxhX/y9
 AED1TvkLhIEYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 3/5] irqchip: or1k-pic: Undefine mask_ack for
 level triggered hardware
Date: Thu, 14 Jul 2022 00:26:50 -0400
Message-Id: <20220714042653.282599-3-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714042653.282599-1-sashal@kernel.org>
References: <20220714042653.282599-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, jonas@southpole.se,
 Marc Zyngier <maz@kernel.org>, openrisc@lists.librecores.org,
 tglx@linutronix.de
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

From: Stafford Horne <shorne@gmail.com>

[ Upstream commit 8520501346ed8d1c4a6dfa751cb57328a9c843f1 ]

The mask_ack operation clears the interrupt by writing to the PICSR
register.  This we don't want for level triggered interrupt because
it does not actually clear the interrupt on the source hardware.

This was causing issues in qemu with multi core setups where
interrupts would continue to fire even though they had been cleared in
PICSR.

Just remove the mask_ack operation.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-or1k-pic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-or1k-pic.c b/drivers/irqchip/irq-or1k-pic.c
index dd9d5d12fea2..05931fdedbb9 100644
--- a/drivers/irqchip/irq-or1k-pic.c
+++ b/drivers/irqchip/irq-or1k-pic.c
@@ -70,7 +70,6 @@ static struct or1k_pic_dev or1k_pic_level = {
 		.name = "or1k-PIC-level",
 		.irq_unmask = or1k_pic_unmask,
 		.irq_mask = or1k_pic_mask,
-		.irq_mask_ack = or1k_pic_mask_ack,
 	},
 	.handle = handle_level_irq,
 	.flags = IRQ_LEVEL | IRQ_NOPROBE,
-- 
2.35.1

