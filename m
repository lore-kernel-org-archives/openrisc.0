Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF83C22E400;
	Thu, 17 Apr 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876979; cv=none; b=OkzuSEmrY/bfZJHJk28PRnxHwGE42yMwm5P6BgOZwZ55EykF3qjBSFnV3pW6cAZxmbRpA3KQuftwAuCh5nNgTpnkXdgdh05e1AA65JNZcJCM8feHwNlgqa3q7GAAMqOl5xgjcZItjRDx83Jp1blpFt1H0d4GYDUaOBAGpxEwh2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876979; c=relaxed/simple;
	bh=D1bY3QgHIcLYutjlYyWqbA9dkMg7WciKWie+i1+8deU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhpZ551fbGAoFYaxF3N+Pfl8mJG+eTOuoMTIEE44GsR3r9VfJVHUeJ8erSGWPzhFvjKNl2f+Uz/m4NJFbSRiEFfmvuAGcqogiMhnfn/CT47vLRh3PkJy0pY+VYi2U/v2RFWswfl8SEgEw10OXLo1TZGu48XAss4V4RHNKFnU2aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iK85Ka02; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK85Ka02"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3913958ebf2so441434f8f.3;
        Thu, 17 Apr 2025 01:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744876974; x=1745481774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYs5GDp2ino7QTjWon4vKsjDHJCAvrGyMyoO2ZCcuzU=;
        b=iK85Ka027sGoBDvK/hU7VyaMtld9lozrlzIb0/vY/zR0jrCwwnUr2YRERX0WvMB5H/
         s8TQxtY2nAQeLIVU81m4lUQqcN5ih8Iq0QJFdyXJV3Vw0y2J0M5njlgcBaPr10aJ30yT
         q7hyJou3oW4j9ls6BIqvCjvZocEgSQoyyi8/7kvRZAxTl+k4sehYPqv9Wkh9g6yKpKad
         9MimLMVmTKA3ulyk7mmlUfsUp2+j98WPsnKIbBiu+WoVPuU+MLCCFfakgK5fpHvaWy+Y
         dmYATfZJdIp2/MLWNOoax6k+4w75po1MUkEjgse82f6mI8XvA/YsUmljs1uWRyysbR73
         TlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744876974; x=1745481774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYs5GDp2ino7QTjWon4vKsjDHJCAvrGyMyoO2ZCcuzU=;
        b=QbBfM894hZyheLXdhVImRLmO8Fj5rn0l0vd15BmoFlG+DFly07FmsUOaRunCwNqUY1
         IqpdwowiY0ILRs1Q6ZK/ZuJomwP4Huah7bEhzwtb37Y0idAox3OldIAI5cytpCU1EG94
         ZzDXOOmrcuZUKd8xUpF9RS4P+4GilUHHbKCQKECY06a3HdRf5txoByplaRZM9CyIg+0H
         JhIaQSwWVwhxnI4rnBg4IsHJrZghoifTkWhXZ5/Qs4n7EuUNuDKGldDVHbZcNJ7eFIX8
         +ROhOJtS/zD4Ux0UXqP9Q4F32JvWrvPceGCSOrzAzCU+Q393PiTNjFiirK172Glwo/eO
         d15g==
X-Forwarded-Encrypted: i=1; AJvYcCWGvfee2IbQd0cSd3WJPyStxpa7uSAYktE1evJxvpNTXZf6m6yjDue3QOizxa/+jUNskxeE6RQQ4RM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzzjz4Zl42YYTnigr4MBwA1xx/sOMXv109Ai0Ciyav61Z5mlwo
	6Lm8lVQxYuw/Cv9hR0hT7JVxPFIa5IqY/os53i/mwlFjkocU7S1vLsawbg==
X-Gm-Gg: ASbGnctPDWXzMiRDAqEvwZKTA3i0tNcXiFu+LVNC8c0K6mgtvNXMQo8BAriQwP5sQOV
	7bHpVm6sokYYJXaCaRUqx+U4JTC2SIKytOJ/cN4GY05fQ4UpIVJ1/v0lQ3dR01Aj/Tvo+wcilYb
	h9pbjewabKo5zb9+0lsFk9jnTDWQPkzE3XaQrpvosI0V2rTsf3dHgqHAfele+tAuatDCONyCRWp
	maT8jmQZNP6iqD/k4W+Q+z15gihVvV+CAS0h5OWWl2Ld+y0zI04Z5nPuaOQhJs70bPenlozOc8M
	Fh/IasT/pf6x7/sgJHvWTiQwCS3QEZcu930WawQlZP8YiBhsGVLeRqrBnh/i0BX6dIowxrxoAnS
	0etYv
X-Google-Smtp-Source: AGHT+IEys/tXYtyVg1/oxhJ6T+l8eBWJNg4JhchGNZx2hCx5uvQG7Q2mLg6Gf/6s39PCtO2nn++Qzw==
X-Received: by 2002:a05:6000:248a:b0:391:48d4:bd02 with SMTP id ffacd0b85a97d-39ee5b1bcc7mr3854010f8f.29.1744876973910;
        Thu, 17 Apr 2025 01:02:53 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9640bcsm19149241f8f.1.2025.04.17.01.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 01:02:52 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	linux-doc@vger.kernel.org
Subject: [PATCH 2/2] Documentation: openrisc: Update toolchain binaries URL
Date: Thu, 17 Apr 2025 09:02:32 +0100
Message-ID: <20250417080236.4021257-3-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250417080236.4021257-1-shorne@gmail.com>
References: <20250417080236.4021257-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The old development toolchain binaries were hosted in the or1k-gcc
development github repo release page.  However, now that we have all
code upstream I cut releases from stable upstream tarballs.  It does not
make sense to tag the or1k-gcc github repo releases for these stable
releases.

Update the toolchain binaries URL to point to where they are now hosted
on the or1k-toolchain-build github release page.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 Documentation/arch/openrisc/openrisc_port.rst               | 6 +++---
 .../translations/zh_CN/arch/openrisc/openrisc_port.rst      | 6 +++---
 .../translations/zh_TW/arch/openrisc/openrisc_port.rst      | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/arch/openrisc/openrisc_port.rst b/Documentation/arch/openrisc/openrisc_port.rst
index a31ae4960576..a8f307a3b499 100644
--- a/Documentation/arch/openrisc/openrisc_port.rst
+++ b/Documentation/arch/openrisc/openrisc_port.rst
@@ -27,11 +27,11 @@ Toolchain binaries can be obtained from openrisc.io or our github releases page.
 Instructions for building the different toolchains can be found on openrisc.io
 or Stafford's toolchain build and release scripts.
 
-	==========	=================================================
-	binaries	https://github.com/openrisc/or1k-gcc/releases
+	==========	==========================================================
+	binaries	https://github.com/stffrdhrn/or1k-toolchain-build/releases
 	toolchains	https://openrisc.io/software
 	building	https://github.com/stffrdhrn/or1k-toolchain-build
-	==========	=================================================
+	==========	==========================================================
 
 2) Building
 
diff --git a/Documentation/translations/zh_CN/arch/openrisc/openrisc_port.rst b/Documentation/translations/zh_CN/arch/openrisc/openrisc_port.rst
index d2e4ca8a46c7..d728e4db0b85 100644
--- a/Documentation/translations/zh_CN/arch/openrisc/openrisc_port.rst
+++ b/Documentation/translations/zh_CN/arch/openrisc/openrisc_port.rst
@@ -36,11 +36,11 @@ OpenRISC工具链和Linux的构建指南
 工具链的构建指南可以在openrisc.io或Stafford的工具链构建和发布脚本
 中找到。
 
-	======      =================================================
-	二进制      https://github.com/openrisc/or1k-gcc/releases
+	======      ==========================================================
+	二进制      https://github.com/stffrdhrn/or1k-toolchain-build/releases
 	工具链      https://openrisc.io/software
 	构建        https://github.com/stffrdhrn/or1k-toolchain-build
-	======      =================================================
+	======      ==========================================================
 
 2) 构建
 
diff --git a/Documentation/translations/zh_TW/arch/openrisc/openrisc_port.rst b/Documentation/translations/zh_TW/arch/openrisc/openrisc_port.rst
index 86590b016d56..a1e4517dc601 100644
--- a/Documentation/translations/zh_TW/arch/openrisc/openrisc_port.rst
+++ b/Documentation/translations/zh_TW/arch/openrisc/openrisc_port.rst
@@ -36,11 +36,11 @@ OpenRISC工具鏈和Linux的構建指南
 工具鏈的構建指南可以在openrisc.io或Stafford的工具鏈構建和發佈腳本
 中找到。
 
-	======      =================================================
-	二進制      https://github.com/openrisc/or1k-gcc/releases
+	======      ==========================================================
+	二進制      https://github.com/stffrdhrn/or1k-toolchain-build/releases
 	工具鏈      https://openrisc.io/software
 	構建        https://github.com/stffrdhrn/or1k-toolchain-build
-	======      =================================================
+	======      ==========================================================
 
 2) 構建
 
-- 
2.47.0

