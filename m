Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95D5C433F5
	for <openrisc@archiver.kernel.org>; Tue, 17 May 2022 00:56:05 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 0ED6124988;
	Tue, 17 May 2022 02:56:05 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mail.librecores.org (Postfix) with ESMTPS id 99BF12497D
 for <openrisc@lists.librecores.org>; Tue, 17 May 2022 02:56:03 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id d17so16029539plg.0
 for <openrisc@lists.librecores.org>; Mon, 16 May 2022 17:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GLuZhVjtGK5TbXwgi8Odrp2p8Tu7QkWjhdCCk7ovaas=;
 b=OsySeMMZGq6yomS1KDnoTl6b0LIngdBZ3Omh+Vc/fSzyz+imuzyNrjQmUZczLIhegX
 +NV8Gfo9Tput/QUY1MVOp/wmL3M55pSmBtD57O8/1JpQp8rGPdCzSmzBC8eK5opvxFJm
 YnVEuPcnGO9XlQLIge0UeJilt0t25njUQsNYGrybJ/XImbGbZ4O1Yq460hiZQpdk1gs7
 Dg1LZ6ZjFxW3MBu/o51RGLacoJcuoZvqs22cA2+nNAoFmpwfLm1tPRiYd/P2qSL4DGm5
 MwiIpVEpFohND8ZtgZzd0aJ9oq+EKG7OfDkUAcNtTOnbR3Rpu01HowmUYrrc7HGmdsWs
 Q57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GLuZhVjtGK5TbXwgi8Odrp2p8Tu7QkWjhdCCk7ovaas=;
 b=K72fdVFZyKh5ewPWgkoSixuDR7Q+qBDoEwOAw5islsYiUKMwkt6FGAkevLJ2ABKdDD
 muGSBw/Zj9pf7DrPd8sirnLnJllxuVReClmgPNgnFWC1YOhNNHygagQhPjTF0EBwLguV
 R2NEvUzHy6LGGmDspiaKVhIMOgL83ZRwK53wXZa7jaPUT5aFP2zxnsioM8kksNX07/Io
 FL5KsBEX5yDFkDVG/T5g6KlpCmbGgWtfzVyafYnmuwqP3F0sb+OaYyAPgubIkp+YTok9
 O4BjEV8D60QtSuy5rmi01AcTQaLE7JBKdyTrMuo7PgdrUPqGTgr03ilJBsq/5hN3k5+v
 FwCg==
X-Gm-Message-State: AOAM532cASEKzBH+vmune1HCrGvfaGcZP/gyFRUoaHY+ZDmXx4QORFGo
 xXjSxyvinwMJMfgBkPxfuLw5SNDqUI6U8g==
X-Google-Smtp-Source: ABdhPJyRflxVHHKzD7PI9Xa4kr/OcWekhtakidWl3XVIQlsItD1qwG0ktFMPtDJCote4gDFgvalZqQ==
X-Received: by 2002:a17:902:7892:b0:161:61de:eaeb with SMTP id
 q18-20020a170902789200b0016161deeaebmr10850706pll.132.1652748962201; 
 Mon, 16 May 2022 17:56:02 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 t19-20020a62d153000000b0050dc762815dsm7425197pfl.55.2022.05.16.17.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 17:56:01 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 11/13] openrisc/delay: Add include to fix symbol not
 declared warning
Date: Tue, 17 May 2022 09:55:08 +0900
Message-Id: <20220517005510.3500105-12-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220517005510.3500105-1-shorne@gmail.com>
References: <20220517005510.3500105-1-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Add asm/timex.h include for read_current_timer prototype.

Sparse reporting the following warning:

    arch/openrisc/lib/delay.c:23:5: warning: symbol 'read_current_timer' was not declared. Should it be static?

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/lib/delay.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/openrisc/lib/delay.c b/arch/openrisc/lib/delay.c
index 036ae57180ef..5e89e4131304 100644
--- a/arch/openrisc/lib/delay.c
+++ b/arch/openrisc/lib/delay.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/init.h>
+#include <linux/timex.h>
 #include <asm/param.h>
 #include <asm/delay.h>
 #include <asm/timex.h>
-- 
2.31.1

