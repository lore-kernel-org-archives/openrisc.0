Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D79BC433F5
	for <openrisc@archiver.kernel.org>; Mon, 30 May 2022 13:53:02 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 4C7CB2412D;
	Mon, 30 May 2022 15:53:02 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mail.librecores.org (Postfix) with ESMTPS id 44C182410F
 for <openrisc@lists.librecores.org>; Mon, 30 May 2022 15:53:01 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DEC53B80DAB;
 Mon, 30 May 2022 13:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BB2C3411A;
 Mon, 30 May 2022 13:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653918779;
 bh=Xlh2jYqXF5aWMkpYTrGr9h+FlAuLQOz3xMpWM9qsbjg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ag8cajVcjVFPaqJOTl6Lco1bbKm5m7DVAXRVZDLNnOI42Z+UjHEQn8K3iY1jlBoWD
 s2If/td9jICItwbQ/WJFdiYfW8y8gOy4J6rpW8HrQNBscs5zempWBiW8j82YR944T9
 SaeZ3QCLKpQ3UGzxdkXO1LaSX67+k/CWpK07M2iaKIMlcNURCnT9CdiCHSNq7VVn0A
 BDqritZ44Sd8JVR1zQP3b3yC1bQTr35Xd6GIOWWrnUQcIhnzrozsH5vuONa4dG/e+1
 GYJ1IRLrmpPELmlyKCWK1/wEPTH1ldyqABRpkOOl143oI/qFrCj2B6d1Fh5XKwYzt+
 U00NNtu2XBM0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 18/24] openrisc: start CPU timer early in boot
Date: Mon, 30 May 2022 09:52:05 -0400
Message-Id: <20220530135211.1937674-18-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530135211.1937674-1-sashal@kernel.org>
References: <20220530135211.1937674-1-sashal@kernel.org>
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
Cc: Jonas Bonn <jonas@southpole.se>, Sasha Levin <sashal@kernel.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Arnd Bergmann <arnd@arndb.de>,
 rdunlap@infradead.org, linux@dominikbrodowski.net,
 openrisc@lists.librecores.org, Thomas Gleixner <tglx@linutronix.de>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

[ Upstream commit 516dd4aacd67a0f27da94f3fe63fe0f4dbab6e2b ]

In order to measure the boot process, the timer should be switched on as
early in boot as possible. As well, the commit defines the get_cycles
macro, like the previous patches in this series, so that generic code is
aware that it's implemented by the platform, as is done on other archs.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Acked-by: Stafford Horne <shorne@gmail.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/openrisc/include/asm/timex.h | 1 +
 arch/openrisc/kernel/head.S       | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/openrisc/include/asm/timex.h b/arch/openrisc/include/asm/timex.h
index 9935cad1b9b9..34d015bf0462 100644
--- a/arch/openrisc/include/asm/timex.h
+++ b/arch/openrisc/include/asm/timex.h
@@ -27,6 +27,7 @@ static inline cycles_t get_cycles(void)
 {
 	return mfspr(SPR_TTCR);
 }
+#define get_cycles get_cycles
 
 /* This isn't really used any more */
 #define CLOCK_TICK_RATE 1000
diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index 98dd6860bc0b..0b6be5b3522b 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -452,6 +452,15 @@ _start:
 	l.ori	r3,r0,0x1
 	l.mtspr	r0,r3,SPR_SR
 
+	/*
+	 * Start the TTCR as early as possible, so that the RNG can make use of
+	 * measurements of boot time from the earliest opportunity. Especially
+	 * important is that the TTCR does not return zero by the time we reach
+	 * rand_initialize().
+	 */
+	l.movhi r3,hi(SPR_TTMR_CR)
+	l.mtspr r0,r3,SPR_TTMR
+
 	CLEAR_GPR(r1)
 	CLEAR_GPR(r2)
 	CLEAR_GPR(r3)
-- 
2.35.1

