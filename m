Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E32CC433FE
	for <openrisc@archiver.kernel.org>; Thu, 13 Oct 2022 21:49:10 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id B805724B2E;
	Thu, 13 Oct 2022 23:49:09 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mail.librecores.org (Postfix) with ESMTPS id 372D520C8F
 for <openrisc@lists.librecores.org>; Thu, 13 Oct 2022 23:49:08 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id o21so602957ple.5
 for <openrisc@lists.librecores.org>; Thu, 13 Oct 2022 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
 h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
 :subject:from:to:cc:subject:date:message-id:reply-to;
 bh=vBx3K1ot3v49SwgTPYcBqrot/DJk84gW5RbBZvKcvpc=;
 b=iB3xu49D6L5voc5fMv0fn8xMj/pj7TitTcjjeGhKcICioMEE4VRD56ytDcUdFS1obx
 wf1LMKAAZbjgPYY0LNV1ZvUrG4uxtsBSKBu6+lDCFZxAWnanTVLhZp+jAyM4/Bp4AANR
 WG63Elp33E/6w2lyPBWbCgkdqPd6Wh8qWTGJ4eLZpj5UD9sx0Wwh4YLvUPVVn9N1vGGP
 j2CNd1nLCzLSSLR32teu7CvYkTDK8FZ2dvweovEoLGboHKt++w7zT72AMbQ7HHu/dV2C
 ZQDfyG1Wn8MG/Y2nTAxtJX6aEeTHMu4CVSSZCxERy4/5zAOLVhkteWDLLnQQeHYumiMV
 Vucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
 :subject:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vBx3K1ot3v49SwgTPYcBqrot/DJk84gW5RbBZvKcvpc=;
 b=kTylSkk6rL10nKv/X1xeT4Ntkv2/bxULl55C0LYqt8T++l5pYUGVQTgvev/bJMNeVq
 Ydp98MqVuqex1CopwbMnfXnB3LsAB1TllGPX0dJBiWuR1ZPhCVY8MWsAdIb3qBkvAnxB
 ZaEiOIi78V9wBhshG9hMJhlJSHMRTXCZLckkmi4ik0fyk+bUQj/2CDT+TkneFFjM9H9Z
 HJ2699/dtiRzo9kniElzGMLm4b3NRuBUJ2zeNJe+Q7ESTiYdWBWQJpNYfqkp+0e4JrDb
 R/aIfVCmuVZUhItqYHQw3uM+q281KzRdXp9sJW/9t7JANWuKMrC7YyfrUcqVXfV83zwJ
 iLcQ==
X-Gm-Message-State: ACrzQf0KSEtFqLF1SftIGRuOzoWMMf2Wfm+HNtj03BWf2oXGwcN+wXFD
 0f7pVlSek3nkXq6dh4iz5HDfuw==
X-Google-Smtp-Source: AMsMyM5iNFHilxSB65fezOEPSLaI9f6dIP7s/eJti/GmPxhsKihbdce6/fTzfgA+XRF4zucaYGC+hw==
X-Received: by 2002:a17:90a:3841:b0:20b:650:60d1 with SMTP id
 l1-20020a17090a384100b0020b065060d1mr1998734pjf.102.1665697746612; 
 Thu, 13 Oct 2022 14:49:06 -0700 (PDT)
Received: from localhost ([50.221.140.188]) by smtp.gmail.com with ESMTPSA id
 t5-20020a170902e84500b0016dbdf7b97bsm284299plg.266.2022.10.13.14.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Oct 2022 14:49:06 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for openrisc
Date: Thu, 13 Oct 2022 14:46:37 -0700
Message-Id: <20221013214637.30893-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@rivosinc.com>
To: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
 openrisc@lists.librecores.org
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
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@rivosinc.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Github deprecated the git:// links about a year ago, so let's move to
the https:// URLs instead.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I've split these up by github username so folks can take them
independently, as some of these repos have been renamed at github and
thus need more than just a sed to fix them.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 796ba37dd4ff..9a9ca93b63fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15234,7 +15234,7 @@ M:	Stafford Horne <shorne@gmail.com>
 L:	openrisc@lists.librecores.org
 S:	Maintained
 W:	http://openrisc.io
-T:	git git://github.com/openrisc/linux.git
+T:	git https://github.com/openrisc/linux.git
 F:	Documentation/devicetree/bindings/openrisc/
 F:	Documentation/openrisc/
 F:	arch/openrisc/
-- 
2.38.0

