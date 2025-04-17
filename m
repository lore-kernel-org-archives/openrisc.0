Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72D22DFA0;
	Thu, 17 Apr 2025 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876974; cv=none; b=a9C099jgGfJmUHFFSdoYnZD/CbdLHimBoMX/Ph0stA6syO01fT78wJhen6xuD3phaewUHMHwe0ZeatKanIVQwdksQD8HMA8UJuSKd+nCpdwLr+ldavVz1s3/Zt1qVif84E7P6REiIEwJ+VSVuknChAZ0k4n7+loYa7esPjadtz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876974; c=relaxed/simple;
	bh=D6BD7yaXWjifISSmqWsVxg0U5Tyiy0r0txP1obJKYCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnMCzbgtYxgjQEwXlVA7SBJ3+CNto3OVdlGILd4WqmN3oCBRSrsHUQYAECZVUZ7M7c7xzRsmNfYJjl6znHE6AjJGjYsfY30MYeqrtZKvduR7AOnFKE4HHSeW00dQ1tMn360lwuCpTN3BWhwIh7ek41r4QhLv1CLRrNGP8mt0xHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A33TB3h4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A33TB3h4"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so3533515e9.2;
        Thu, 17 Apr 2025 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744876970; x=1745481770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PQ6qBq4/QXWpeBCeMtqrat96abr6uthKSQPOpsaWn4=;
        b=A33TB3h4fegA41WYNFAwis7qIxhXWUmbEg+VBgF+FqF6Vw3M6b7JYFmGP1dbzm1aVn
         cZQq1fqbYS31HRIuhk5LGALvEN1X0SN9KZPvG/I4enQm+qtLmkstRzZb2XWuLvu+M7Yg
         Bg7W+f7CBsD7+xBa6Fd55QQFBj80kG2JRH32LuXFtcpj4v7SIAVP1mjISYAmLijNiku3
         FPsAB+cIbUJv46GHyclilIHNJShdN6isP7eoJjJwJad1XvUHBsA7DqsvQVNZyKrZbaob
         sjA/Cwh4//0Q8wkaB8QIHl8o5talLaSSsj555kklaQTEeZ2G0f7qv8Z5TRkC6cZU1x58
         NQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744876970; x=1745481770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PQ6qBq4/QXWpeBCeMtqrat96abr6uthKSQPOpsaWn4=;
        b=fwPWlvsULqvZb5lb6Stq/oCeqWn6VoFVKcl7gfM4CavavDEwxRvLqBV0jsqPhXhkhg
         iT0zFjuzEivjqyAYog4usE7lZPaBVKgaCZLDLMoOYSsbnuszDPzMQwbIdBiumwRSsmrI
         3+hjnCjcQrY9ZUC8kzsfs0T7bUfeuN4Z4nE1smVrzlNgwg3QXBvA8jVdq8AcUMaOy1o3
         dG3Ey20ph+Fy0dfzmdKSPf6WSqpS2PxAGGBrzgcUB0UWO66bfYyRw5B3UMd0nep49snc
         H9TdvwoIk8+KEy/6ghDOCe22ihExx+O8EAHjog9cta28MuWSxEdi+P6OCdIz6LkBlcqV
         NFSA==
X-Forwarded-Encrypted: i=1; AJvYcCXhvtXQlG3ZOz/f+FQdNnoxuTu7zhRXj516g15y4lBsTJJxhO8HR6EEN7sRcxEYhrySOHuFxu7wG6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3BMbatrPY91UBqJDb3VMo336etZEHF1nuK1sikoeFuKJXoKLo
	lVF0lxPtSavN5jH8E7g/XGoJOwb2BrerN3dRNfay8eaA0o69xeYeDx8rUg==
X-Gm-Gg: ASbGncsMOTdLOtHGZfrHiuO69aSx0ZJ7P19Xzwh4ySE72vaBIdg+rvrdFZWMSYQ0clD
	3nEdf1l3EN6HMX4RP7prrCfeGclaEU8QkZw1NiBcY1REET/KxGQrMSQEjqQ6gtcnAMMBie8A4J2
	nIaTjdOKLzMefPAlXwpPKw9q14d5SPEs6IhP+YKxv2ndaSkxKAwoxB7vNIgyb13QEJOkBDLkqcU
	QfIgK7pKsOD5QhiwaxUqsLRR9tQgwJpeFBqYU0NU0RcmsT3a3FUBXZ8Br+uprfxTKK+0pYMCaTj
	ErGQDr4qdINp9ByCovHuIGkCRKAuNhbfr2Y2iw5ys3wnNBBccD5T917abWdiag/wBSyZZoWFIwK
	GaUeq
X-Google-Smtp-Source: AGHT+IFlw0G1uKtnDzkbMo2bwZyuAu9Z8gyPD0MHPScr87gUb8lJm0wNAFu8SxR2S3CR2i2WUQtqiQ==
X-Received: by 2002:a05:600c:5012:b0:43d:b51:46fb with SMTP id 5b1f17b1804b1-4405d5fd33bmr54617515e9.2.1744876970223;
        Thu, 17 Apr 2025 01:02:50 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b53f29fsm43259445e9.37.2025.04.17.01.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 01:02:49 -0700 (PDT)
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
Subject: [PATCH 1/2] Documentation: openrisc: Update mailing list
Date: Thu, 17 Apr 2025 09:02:31 +0100
Message-ID: <20250417080236.4021257-2-shorne@gmail.com>
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

The librecores.org mailing list was replaced with vger.kernel.org last
year after the old mail server went offline.  Update the docs to reflect
the new list.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 Documentation/arch/openrisc/openrisc_port.rst               | 6 +++---
 .../translations/zh_CN/arch/openrisc/openrisc_port.rst      | 6 +++---
 .../translations/zh_TW/arch/openrisc/openrisc_port.rst      | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/arch/openrisc/openrisc_port.rst b/Documentation/arch/openrisc/openrisc_port.rst
index 1565b9546e38..a31ae4960576 100644
--- a/Documentation/arch/openrisc/openrisc_port.rst
+++ b/Documentation/arch/openrisc/openrisc_port.rst
@@ -7,10 +7,10 @@ target architecture, specifically, is the 32-bit OpenRISC 1000 family (or1k).
 
 For information about OpenRISC processors and ongoing development:
 
-	=======		=============================
+	=======		==============================
 	website		https://openrisc.io
-	email		openrisc@lists.librecores.org
-	=======		=============================
+	email		linux-openrisc@vger.kernel.org
+	=======		==============================
 
 ---------------------------------------------------------------------
 
diff --git a/Documentation/translations/zh_CN/arch/openrisc/openrisc_port.rst b/Documentation/translations/zh_CN/arch/openrisc/openrisc_port.rst
index cadc580fa23b..d2e4ca8a46c7 100644
--- a/Documentation/translations/zh_CN/arch/openrisc/openrisc_port.rst
+++ b/Documentation/translations/zh_CN/arch/openrisc/openrisc_port.rst
@@ -17,10 +17,10 @@ OpenRISC 1000系列（或1k）。
 
 关于OpenRISC处理器和正在进行中的开发的信息:
 
-	=======		=============================
+	=======		==============================
 	网站		https://openrisc.io
-	邮箱		openrisc@lists.librecores.org
-	=======		=============================
+	邮箱		linux-openrisc@vger.kernel.org
+	=======		==============================
 
 ---------------------------------------------------------------------
 
diff --git a/Documentation/translations/zh_TW/arch/openrisc/openrisc_port.rst b/Documentation/translations/zh_TW/arch/openrisc/openrisc_port.rst
index 422fe9f7a3f2..86590b016d56 100644
--- a/Documentation/translations/zh_TW/arch/openrisc/openrisc_port.rst
+++ b/Documentation/translations/zh_TW/arch/openrisc/openrisc_port.rst
@@ -17,10 +17,10 @@ OpenRISC 1000系列（或1k）。
 
 關於OpenRISC處理器和正在進行中的開發的信息:
 
-	=======		=============================
+	=======		==============================
 	網站		https://openrisc.io
-	郵箱		openrisc@lists.librecores.org
-	=======		=============================
+	郵箱		linux-openrisc@vger.kernel.org
+	=======		==============================
 
 ---------------------------------------------------------------------
 
-- 
2.47.0

