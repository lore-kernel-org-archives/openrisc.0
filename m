Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7859931C575;
	Fri,  5 Sep 2025 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095991; cv=none; b=YaxBa9J8fsjkUGrQmnNDLvNgD2N0fjf+sJlescKXqXdTvdb8BLcn8Tr1uk3Cu9gJb8t3a31C8qhZndvgtLPzSPIw8ZxSY8xgzaLNMrsbWilWvcqsxAC8vAk45cyPtwnvmTyhynOrDm1gGzQNMocLn80TJvqkaDd+xrPCEvGLzuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095991; c=relaxed/simple;
	bh=8sqE/ahpm0Y36jdu4ngt0NVOojifx9tWtMF9a7tnzXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9DX1uHL/MM62VJmdm2rmEOmE3KQDTfcN7t+TH9AUO9Sg13GOb6jJu+N62wyHIUqivcL7bpASRN997bFSYZM7NsJNIe2mSwuGiR7yF3+4JzbBJ8k8FYXXTNcABpPIztGMBYyyHi88H4M/vRSgjSVLAF+b0Yq8MjDkOQTbO8k1qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcgJsoR2; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcgJsoR2"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1960072a12.3;
        Fri, 05 Sep 2025 11:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757095990; x=1757700790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57I9k2ErG6DQw1muwf6AZCWmsU83U3jmJlr69RGHze4=;
        b=EcgJsoR2Q1KmtkpGhj4pyhJKDWh0ufTqFe8j9d+4DbBEvzO7un+Frcca7V64XYMgMv
         x9N4S85+1Wgp73cxZCBBRHP0aDoRlSaYp2KPtmNJbVxhSO+2qIKkUeB/NwDUZARJYUeR
         ucso25xcMg6StnhVX99+Y8PIUbnwCiMiW6BcXtBkDN4+4JRXoeIALzEedpzfXJ7mHaiU
         PmoeFAaJu2+lSpiy4L8F5FoH9iouQrpHHEEDtxS3vgNHZL8VQetrKYMmDb3PmmiNl5AJ
         3Ze420mjPVb9pl0v5pY9VVlhr73p8eOED53weg5dNlg/ZbIy2TYuC3zWwWjJR4fPRmSY
         M1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095990; x=1757700790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57I9k2ErG6DQw1muwf6AZCWmsU83U3jmJlr69RGHze4=;
        b=f1SIEhBSmws1PrJxTbceo4kxWoMlKhbRcIVCAoFzDPpCGKRx+PP5yANfppBuNWXVpG
         Ih2CXgldZHqt+ISJqqynAAWyzfeIAr7tMfo492n+svYxi/VTRw5xZClwEZNPNP8W2lxs
         FldOs6hn1KJFkufskQDkY4h3v/4bvB4n9a9TPYpyRs51lyNrr5M0zApKJUmfoEYXJj5a
         C5peonrpx+/douO+59SGuugUpwwvzRioMUDGXL3ovDcCiFgpsKkA1jl+3rekCxpDfcVe
         qJNyXQetcoXflNQntOrcw2hs5R2Qy7OapURMB/pwYy+WmHCfqjsNx10qEwwDuV7/T+j/
         mxAA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ2ZMhfCkXxNT2h3YSgdIWn8o5v/uGM0XXXS/8mfDATWs3eB+zDJUcstLdMWqOg4fADtOoswZCsl4h80kz4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdfQ5gxXRbbwo8bqA2mEYV3b7pS8SPEB6Uu4WZ24eQSt2FcZKK
	4LXIa0rT0YlzJBGCRHgV2dWu6P0WUCcm1t4V/UWf9qgQ18ZNqJKZ5DkP
X-Gm-Gg: ASbGncv44ssfbTcxmtLExeezaRuUZM/pvdCCQES47Z4QkHW25qyY54Ty2bulWBNelhJ
	RYs0RNM+HcnK0h/IJ+KELplzMMhi1x08+ewztfWe9Nc1jy4IsZIaIwnQ+tPs2tQSUpe10fT1EM4
	zdXolic2jhSRMRUztgl2WCAbeiH17vOxr8ajKNWIu1fH7o+HzVRkCSr9KDOZo4+WEkUKzzcedIM
	UiO4hYGsTCSp4Qopx7yEciO3l3xUQeQ1SgAt7khVfTnwqhURc0fF4AnqmvLTyGo5BugB4XM0bUO
	IsMxF2+gAzsCAIGlZuWDIWpRf32Vngo9QXsM+2i9GioO1fxQoHXFe7+OaqKTsm6dsztd7MxAEWW
	E9ZkIeFzueuPql7qEnnNwQQ1OfsUDpRyg1ew7iu84pTdTmXdTMC2XwgqBP8G/Mcoi8a04jo7a
X-Google-Smtp-Source: AGHT+IFWeTrRPYf/AgEIHrZGRve1Me7lwG2J+WE8tWupLGoONgCAvauUyiOGTInlff0RzYVjlMkttA==
X-Received: by 2002:a17:903:acb:b0:246:76ee:535b with SMTP id d9443c01a7336-24944a8fdd6mr319853245ad.27.1757095989745;
        Fri, 05 Sep 2025 11:13:09 -0700 (PDT)
Received: from nyaos.. (v133-18-108-210.vir.kagoya.net. [133.18.108.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd3095df7sm19940233a12.36.2025.09.05.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:13:09 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Stafford Horne <shorne@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	chenmiao <chenmiao.ku@gmail.com>
Subject: [PATCH v5 2/4] openrisc: Add R_OR1K_32_PCREL relocation type module support
Date: Fri,  5 Sep 2025 18:12:56 +0000
Message-ID: <20250905181258.9430-3-chenmiao.ku@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250905181258.9430-1-chenmiao.ku@gmail.com>
References: <20250905181258.9430-1-chenmiao.ku@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: chenmiao <chenmiao.ku@gmail.com>

To ensure the proper functioning of the jump_label test module, this patch
adds support for the R_OR1K_32_PCREL relocation type for any modules. The
implementation calculates the PC-relative offset by subtracting the
instruction location from the target value and stores the result at the
specified location.

Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
---
 arch/openrisc/kernel/module.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/openrisc/kernel/module.c b/arch/openrisc/kernel/module.c
index c9ff4c4a0b29..4ac4fbaa827c 100644
--- a/arch/openrisc/kernel/module.c
+++ b/arch/openrisc/kernel/module.c
@@ -55,6 +55,10 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
 			value |= *location & 0xfc000000;
 			*location = value;
 			break;
+		case R_OR1K_32_PCREL:
+			value -= (uint32_t)location;
+			*location = value;
+			break;
 		case R_OR1K_AHI16:
 			/* Adjust the operand to match with a signed LO16.  */
 			value += 0x8000;
-- 
2.45.2

