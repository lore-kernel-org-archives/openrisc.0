Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7029CC433F5
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 12:42:48 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id B6E4720D0C;
	Sun, 15 May 2022 14:42:47 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mail.librecores.org (Postfix) with ESMTPS id 70A1E20CE9
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 14:42:46 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 nr2-20020a17090b240200b001df2b1bfc40so1798428pjb.5
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 05:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GLuZhVjtGK5TbXwgi8Odrp2p8Tu7QkWjhdCCk7ovaas=;
 b=fHtUivnJoBf3l4Gf5biNPi9eZWy15SghJR1BJwRCBbwC7wMdjWc/qEjslDCqaSNuTu
 h52U9exkwSZj6vYxkXcLULEg4OFBLPXo89w/bT2QGVDandmJsW0Yy2M8qro0mjRC0ia5
 FdwD52GptLNwKXd/ssnRQy5zjgdlOb87+AeGdq04w+DWssKGTs8D/rcPVdY2Ygz/RyfZ
 BiX/N1hvuDm64MZ9kVjwYOWb4gjHA0FK70BOPAkFdW+9WDSNigqjlBowPo6dAHXgiTMj
 TaOYMNDu52zdlH5+DjwOHW1hECQSAhWnxB3Q6WdHXaTr2g/+kOS35KwTvxaZkr8OV924
 /kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GLuZhVjtGK5TbXwgi8Odrp2p8Tu7QkWjhdCCk7ovaas=;
 b=fbWqTyAaXjzSbBvazSc1KJbfIzbN8V+u0I99TVqKo1lwAOdSCkjZTeMAeyXXQ1zF8b
 9NbyFqDKFJTaolwu40q0ih8vLWD3QcGp2aXejy2thI0N27uAHq9aU9aXq4DgsQuBS8p0
 jJbSCQC/l+ig9fk9nIoJby+shSabQz6JvgD7eAB3COayrmxZOkXvb7mJgFQYymak3v6e
 iA3xvSzzyB3+oqZ721Vzw31GieY8TUmWcXi7KnYsrln5MwWyq7TsozBnYv9b3ostJZsR
 vcqP2W7AWtxjWWwlSaqOw1rX8f5dO3Q25k4tQ5IPAkxRe35NpnuINmNKdzULCy1z+BWr
 ZWvA==
X-Gm-Message-State: AOAM533CV1u9PCgYy0V+ajWZHIh6iEkgdVy/6MCG5xum73AYhJf0Ptyc
 geXpZniMjR52ivxe4C1Hyjk=
X-Google-Smtp-Source: ABdhPJyfDRaC1XGZwXsUE0diCH1PbRApttn1a39/4+JR6GneKpJfCrvz3Sa/Jrpxp8+gb+crg+a9jQ==
X-Received: by 2002:a17:90b:4b4b:b0:1dc:8724:3f75 with SMTP id
 mi11-20020a17090b4b4b00b001dc87243f75mr25340838pjb.178.1652618565106; 
 Sun, 15 May 2022 05:42:45 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 t12-20020a17090a950c00b001dbe7ccdd4dsm6551557pjo.10.2022.05.15.05.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 May 2022 05:42:44 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/13] openrisc/delay: Add include to fix symbol not declared
 warning
Date: Sun, 15 May 2022 21:41:56 +0900
Message-Id: <20220515124158.3167452-12-shorne@gmail.com>
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

