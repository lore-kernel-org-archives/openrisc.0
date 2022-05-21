Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEEFC433F5
	for <openrisc@archiver.kernel.org>; Sat, 21 May 2022 13:14:15 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 312202492F;
	Sat, 21 May 2022 15:14:15 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by mail.librecores.org (Postfix) with ESMTPS id C231C247C2
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 15:14:12 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 z7-20020a17090abd8700b001df78c7c209so13665745pjr.1
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 06:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JuZm0iyeNXKvBw7CRNXXxjER+lmIsZfs9nGcE1KNIMA=;
 b=Sc6A9rrs2CNpuzMYl9NDxDJMyzMrUdwkEL59QOtbB4CGMTiqKNH5Eg7kFRFTYWvOCi
 KvMrO/BhJz/8I7CnQdHfCLQgstx5qL4qj7Y7M19/MggfMwPalkmrzQC42OPUc1pRxZDA
 RkbI9VeBT3mvPmUnph6SIduSb9zMORPBz4/duPZy+nTp70iBYDIcLVZt2thsIE8+AlOW
 7EGtjoXIcFgOjCQTVo3gXAxD65fsE2+00LDr/l2QZ1Rw2YLz1G4OpUhP00RoFstbDbhp
 qBRYtHKJnMZprRtRK9CEX8TxxQabMo4eFO2kDaT6+YaE++952T73XbPODjIMZW7beYu/
 jlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JuZm0iyeNXKvBw7CRNXXxjER+lmIsZfs9nGcE1KNIMA=;
 b=hP2rQxG5RiuvfH86t7QgqmeD3oybuNpjiKGr1QS2+IhEeRc+t4Z3L6rKnvMcZX7/DP
 BOTuZMG+ZPujZ+1L036nnLDg4arvok2odUBOmcO03G7CDvzR5ERPuyC+XKpf4WjHaGPF
 rloitT/ogFZGzoR364zTUv7WGYGktjTyQ6KsxmXt35KSyzEGPxi3N6K/Vy+7RBV3rbKM
 7rgVgr1DghBY4yiSvAtsMvMiUP4PKEB2bjn25z6m5xRWQ7PrwsqU9lz7EGagiBbpBAC6
 eZieeaRAoepa3RHMtxWbYiz40N37Nw8EGXkiNoneMtP5rV3wgwXIUUFzj1oQ/v3ld/ab
 U27A==
X-Gm-Message-State: AOAM5324j23rpl1QWXC0ArmBS67ItMYFhkZrzk0hVsw/xY9Wz3Gb/dbL
 7fBNNZ+pNRi+3D2jl6CO26A=
X-Google-Smtp-Source: ABdhPJzskd466pWvMA9IpEpSRlwXzHnjwv1BqbS+UhQIKkByXjc1R/mTGqRMDsXeqdEZ64pVE3orRA==
X-Received: by 2002:a17:90b:180b:b0:1df:b2ac:fafc with SMTP id
 lw11-20020a17090b180b00b001dfb2acfafcmr17065256pjb.101.1653138851293; 
 Sat, 21 May 2022 06:14:11 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a17090301c400b0015e8d4eb2d6sm1187912plh.288.2022.05.21.06.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 May 2022 06:14:10 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 10/13] openrisc/time: Fix symbol scope warnings
Date: Sat, 21 May 2022 22:13:20 +0900
Message-Id: <20220521131323.631209-11-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220521131323.631209-1-shorne@gmail.com>
References: <20220521131323.631209-1-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Randy Dunlap <rdunlap@infradead.org>,
 Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Spare reported the following warnings:
    arch/openrisc/kernel/time.c:64:1: warning: symbol 'clockevent_openrisc_timer' was not declared. Should it be static?
    arch/openrisc/kernel/time.c:66:6: warning: symbol 'openrisc_clockevent_init' was not declared. Should it be static?

This patch fixes by:

 - Add static declaration to clockevent_openrisc_timer as it's used only in
   this file.
 - Add include for asm/time.h for openrisc_clockevent_init declaration.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/time.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/time.c b/arch/openrisc/kernel/time.c
index 6d18989d63d0..8e26c1af5441 100644
--- a/arch/openrisc/kernel/time.c
+++ b/arch/openrisc/kernel/time.c
@@ -23,6 +23,7 @@
 #include <linux/of_clk.h>
 
 #include <asm/cpuinfo.h>
+#include <asm/time.h>
 
 /* Test the timer ticks to count, used in sync routine */
 inline void openrisc_timer_set(unsigned long count)
@@ -61,7 +62,7 @@ static int openrisc_timer_set_next_event(unsigned long delta,
  * timers) we cannot enable the PERIODIC feature.  The tick timer can run using
  * one-shot events, so no problem.
  */
-DEFINE_PER_CPU(struct clock_event_device, clockevent_openrisc_timer);
+static DEFINE_PER_CPU(struct clock_event_device, clockevent_openrisc_timer);
 
 void openrisc_clockevent_init(void)
 {
-- 
2.31.1

