Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ACCC43334
	for <openrisc@archiver.kernel.org>; Thu, 14 Jul 2022 04:26:04 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 6E59C24914;
	Thu, 14 Jul 2022 06:26:03 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mail.librecores.org (Postfix) with ESMTPS id 004AF248B4
 for <openrisc@lists.librecores.org>; Thu, 14 Jul 2022 06:26:01 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 712D0B8237E;
 Thu, 14 Jul 2022 04:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FAFC341C8;
 Thu, 14 Jul 2022 04:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657772759;
 bh=2qjO8+odQ7oxEl1fALycalDewY6Q0DjTfZWWlCdvWKE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Lmu1nvSjQKXfZ15bpbI3wt6d+K2AGGWzjyMD6z+2XNvBR+UX2kvaW4ZkaB8+qJ+kZ
 M9hBc/Qbvt4xNdZp2yJ86j8RhDmRJ4+CwmWJFoPWgBCYw5U0J6fE496a26DLkjaRI5
 AeYoig3TTK5U7/WeTqj7uPzEmgwe+45EPgiMhXjnweLtJKcSU8xyXUc34q8BYc8S4z
 cX9CVw6UotbovzEt1bvm/84C9Uxqvaw01Np3FGmYNvDjTgaEBM/zVTC2pDmBCLXkx0
 dZRDO78zF3Yq0vpx3g4ApTLGqADdnH8+RwZR8BYMiPqIPFanD7/GTO+QALOpaLfj/D
 k6CyuqaQZYSLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 09/15] irqchip: or1k-pic: Undefine mask_ack for
 level triggered hardware
Date: Thu, 14 Jul 2022 00:25:34 -0400
Message-Id: <20220714042541.282175-9-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714042541.282175-1-sashal@kernel.org>
References: <20220714042541.282175-1-sashal@kernel.org>
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
index 03d2366118dd..d5f1fabc45d7 100644
--- a/drivers/irqchip/irq-or1k-pic.c
+++ b/drivers/irqchip/irq-or1k-pic.c
@@ -66,7 +66,6 @@ static struct or1k_pic_dev or1k_pic_level = {
 		.name = "or1k-PIC-level",
 		.irq_unmask = or1k_pic_unmask,
 		.irq_mask = or1k_pic_mask,
-		.irq_mask_ack = or1k_pic_mask_ack,
 	},
 	.handle = handle_level_irq,
 	.flags = IRQ_LEVEL | IRQ_NOPROBE,
-- 
2.35.1

