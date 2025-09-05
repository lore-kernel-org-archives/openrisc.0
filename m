Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1127A305948;
	Fri,  5 Sep 2025 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095994; cv=none; b=coakvlPWsHap2yMWwwhnGuAyerl1s2ct14zGHEKxkcY+kzHFGWsxhvTSXXPHnr/+4oRxU4l/oe8n5Op3fwybt+KveoUald9LpoEYYWiuWTOZJnlZ5Aho5U128IFqGgy/NWYtQOLkT9xEG19wE12MLvvq469F1dt5qkN/pX3ikmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095994; c=relaxed/simple;
	bh=AIZqPgluwqpePOPT3MvDMxrsH2xlD8v9qId4APJeL3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eu6SOnGGPjhjWh7TV66F4KiCaVsHszo7iKPyzFs9JKKD48nxeMIdpdMXmLeQhFwK3VjUPuC+UXp9+KqdGbr9h1IhvX7ITfXmEsVtfDReywyuwt7xTKa3SVUHR87wtkxMF+8KxEnXZaYkeJ/MeF3faVTWvnt7iEteTtaIsdIx0zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5bQNIkM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5bQNIkM"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24b1622788dso17765115ad.2;
        Fri, 05 Sep 2025 11:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757095992; x=1757700792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRBZvA6tPDIGNoeLji756p9DxOWg2MHueudkSvigYAI=;
        b=N5bQNIkMWzxLQl6fHT88aW7XG6ZiNQO2lt4/RnQxflaUcBSGJZ6L425Tm3oT/Ya0uq
         G+He5iN8gqJSdWKvnpkG4NjpT3V8Ri+b6OxVvtrzoMoYpDW1CvZVYxouhlesDN34arJb
         D6CvS9+v8bLk8rmpcFseLIACiqkOR4Q1ERi89tbC5mUeftPO4bDBH+flvqBP3YM+3AIz
         /LiWfvyLrakUnYprop4QpzrcJUZU1SMKDYkgdx4D2XyHiNl/Hhsda/G2FYi0GZ0sY7mQ
         wQ+tDaYiXN1TnBYjPuym2bjBP2rw5PPH4KHtFj7u0UWk+kdC0nJvq9B2pXX/k0vAxTo5
         QZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095992; x=1757700792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRBZvA6tPDIGNoeLji756p9DxOWg2MHueudkSvigYAI=;
        b=b+lQfgPV9e+jGR3G6SuT4yxS+DO9bG3pCxb+8QXCuBRiwL9iFwb2WrFPmf4Wz0XafV
         G8zNqD45CuRWWkT2GjCuN1WSWkLuyJNFI8cCpTx7CO1WqBUO9H0HfKmQFpm7thoxcWDL
         c31tf4UkSp0Nojwpt8z3XfXQvwFeInHEK4KNh3rRuSUu/cIvbnLQimkcp1BevYdbFCU7
         fdJMpJZxFGk9pI9xyXySYO2NdAELVvUw4uQieytr7xWzfn1I1mIMiHK26ntt4ztqoxy+
         dKSIZuRTj+EjseQPlD/KmzUgaL0PKoqUN/jraOG7YTZADGWKTiPTwnm0otecGpeflKb4
         gvzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV581v5IoOdH+e7f0zUa9NCCE4UXWqE/Wh3WPo5O0OWfMcY69QLy1G0/j+79P8lTrC5LcY1gsL2C9xkt8dVOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzMyAY2BCU79/Jxo+lS0lLZkC/3FZkl6/0wjJv80BTyKIVQYRB
	wDVudYvefwXxbCFJk1tt27LoxHbAfcwk+Rh/4FxcXMQe2ouFIWPRoRxyz59KKpfGZB7wQw==
X-Gm-Gg: ASbGncu/8VDg18cGoXkb8AQqnLTuSwytd+lLy/9Ceta6z/ITfjG/ptiB9rLyht7lCcB
	932dXwqng+9u3SY1a/R0EHz6dLOPoCTMLG2I/54tFs451+j7eZTgh/K3strBVwJO7NU+MggWlo8
	umEUoxImPqlHLdprylhVOAnw8lR9QEwtPg/ofMRSmoJ/S8sDKa/cPh063IOnH5MYYv1sF2H4rKQ
	2ubTlVBUTjYyPv23FidxZftVDr3v0PVsxC7NSRD6/7LiQ4hlwckuGUokI8z2Uzkr/9uwPLIkMSE
	+tUl9D5Dztr9/zCUBhMyl6KbJTmj6UfMrxaDjzsKmpfIxscX0zBT0C+LkSEURGV0r/PuSaG3Ox5
	iBLthgz5/92mSj3Vw7W0cQ/8Gp5MkD67jRKYlvEqRQoReNycXwb4=
X-Google-Smtp-Source: AGHT+IFjFH7blnOboZp2FXiEo1b7F5VKD3m4qEugDhybRU7cWg5AGM7Fx0kkNVzkZl/GIUrT+oKxYQ==
X-Received: by 2002:a17:903:1d1:b0:24d:4a96:7b30 with SMTP id d9443c01a7336-24d4ab50264mr50522365ad.35.1757095992296;
        Fri, 05 Sep 2025 11:13:12 -0700 (PDT)
Received: from nyaos.. (v133-18-108-210.vir.kagoya.net. [133.18.108.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd3095df7sm19940233a12.36.2025.09.05.11.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:13:11 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Stafford Horne <shorne@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	chenmiao <chenmiao.ku@gmail.com>
Subject: [PATCH v5 3/4] openrisc: Regenerate defconfigs.
Date: Fri,  5 Sep 2025 18:12:57 +0000
Message-ID: <20250905181258.9430-4-chenmiao.ku@gmail.com>
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

Regenerating defconfigs allows subsequent changes to the configs to
be related only to the corresponding modifications, without mixing
changes from other configs.

Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
---
 arch/openrisc/configs/or1ksim_defconfig | 18 ++++++------------
 arch/openrisc/configs/virt_defconfig    |  1 -
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
index 59fe33cefba2..58e27d8fdb4e 100644
--- a/arch/openrisc/configs/or1ksim_defconfig
+++ b/arch/openrisc/configs/or1ksim_defconfig
@@ -3,26 +3,22 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_RD_GZIP is not set
 CONFIG_EXPERT=y
-# CONFIG_KALLSYMS is not set
 # CONFIG_EPOLL is not set
 # CONFIG_TIMERFD is not set
 # CONFIG_EVENTFD is not set
 # CONFIG_AIO is not set
-# CONFIG_VM_EVENT_COUNTERS is not set
-# CONFIG_COMPAT_BRK is not set
-CONFIG_SLUB=y
-CONFIG_SLUB_TINY=y
-CONFIG_MODULES=y
-# CONFIG_BLOCK is not set
+# CONFIG_KALLSYMS is not set
 CONFIG_BUILTIN_DTB_NAME="or1ksim"
 CONFIG_HZ_100=y
+CONFIG_MODULES=y
+# CONFIG_BLOCK is not set
+CONFIG_SLUB_TINY=y
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_VM_EVENT_COUNTERS is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_TCP_CONG_ADVANCED=y
 # CONFIG_TCP_CONG_BIC is not set
@@ -35,7 +31,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_FW_LOADER is not set
-CONFIG_PROC_DEVICETREE=y
 CONFIG_NETDEVICES=y
 CONFIG_ETHOC=y
 CONFIG_MICREL_PHY=y
@@ -53,4 +48,3 @@ CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_DNOTIFY is not set
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
-# CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/openrisc/configs/virt_defconfig b/arch/openrisc/configs/virt_defconfig
index c1b69166c500..8a581e932766 100644
--- a/arch/openrisc/configs/virt_defconfig
+++ b/arch/openrisc/configs/virt_defconfig
@@ -55,7 +55,6 @@ CONFIG_DRM=y
 # CONFIG_DRM_FBDEV_EMULATION is not set
 CONFIG_DRM_VIRTIO_GPU=y
 CONFIG_FB=y
-CONFIG_FIRMWARE_EDID=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 CONFIG_LOGO=y
-- 
2.45.2

