Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB8B2F99B5;
	Thu,  4 Sep 2025 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980103; cv=none; b=cwNm3qQCTo2eSVSIe7C1rIs9dYV8QpAqlC4OxEeZA71pzqwHN2DU8AOAJQgcq1mrGs7HhxTdDi+6VeJoa6jc1QDlrbEDbuon4Z2Nom1uC/xPjdkao9Uem/gYHpIFpHZ1WCUvAa1VsduEpUN4lr69Zkqe8vQ8w7+GigxLXTjasZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980103; c=relaxed/simple;
	bh=AIZqPgluwqpePOPT3MvDMxrsH2xlD8v9qId4APJeL3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIm8qGuN4nFmUSp5b8DmlW6z/SrLUS4qwW+SZLbQfqe3nqbnIL77qkKRasCHuzsk/MbE5+Bw5ZsybSAG6Vb5tpHHvtSM4Apzxi9ii+ZaIf1w0MHJtUoIV0xcqKzOcFpH5OrZfH5vNVgkt4Pp77BLggGo3j/hcHY51Z96Qx74zrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaBMNMFb; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaBMNMFb"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4e84a61055so543415a12.0;
        Thu, 04 Sep 2025 03:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756980101; x=1757584901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRBZvA6tPDIGNoeLji756p9DxOWg2MHueudkSvigYAI=;
        b=VaBMNMFbwXTrQs+zrG67hTFaccSnLByJAb0bUv6xRmONBXpGWfs4/kfisRm6vITSPy
         EwOQFqjwHsSBu3GYvGZc9O0hbIDYLisnCH9t//CMq2syva4F5rQGGiNdJGnhJGS8WpiE
         vqltaIVM1vqLKWRv0ium57UKmx4S8BFuatqh0Iuzlohql2BZydMysKrKsJewtfU+I43u
         NrQAY1wawf49k/81VEcQRc/g1ydEIpfZlZ2RkP9AUv/9VZ5YUe8crMPQ44xaXtAyA+T/
         7KFAxSsviSJQCzd1snjY0BkMLROpWZqo5a5Dq99Ged+cCrH7ZgIuQzMyuC7whKgQAiQj
         +LNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756980101; x=1757584901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRBZvA6tPDIGNoeLji756p9DxOWg2MHueudkSvigYAI=;
        b=lvEtXB6Yhh/LK19/d8TZCBzObMEDrES0Ht9f8HAnD4Kao5t8121NHAJ1PI3GjhGWfM
         X7KybXbLycRfqpAdrVKCEbGiQYuHuYRyjYzQPgarc3nIxBU7TR2jWq+CRg0ajcutjUZq
         A0IwlMhKuEv3SsHQrdN1zy23f2GHlTQmdCPU0AoIqN2uT1TetyCZnj9OxfQoewtWTyxN
         F/wXB0kXuWOG95xawY4fdAwz2j2i3kljHN+pQi1ep0R16pgS+TOduY7Udm0LqxExkBYN
         di0g8YCJDNlFSfGCYhuxIShIzLtj49nhp8zKazfSb6wslrOy+M+/SD6xPiVIrl6i3U/d
         NDFA==
X-Forwarded-Encrypted: i=1; AJvYcCXcMWwKuvpIlx/Dy2ceipt5OmxJMMW+zA3SUWIb4yurvAqfRkzec3l7ce/rfVJ55MA4ZKWtu0UxZyyp5idUbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJMJxiggsYuPxoErywRTa2UeE+aTSCAWLJEBr/8s+4OG3kxOJe
	i0sDOkb/Ys9StvrZwT1quUDZVN0q4/g3CvXBH5r8itOEPmitT2btWSsD4sy4JftwwN/q4Q==
X-Gm-Gg: ASbGncs98yhnkUo1TwBIQoniKc6EdeIP9XoO92mSfdCfhrW8i5TqZj/uC6ZcFE8icKQ
	nkIjNJn0C4Zp5Fhi5nTzPHRZ3Clf3A1WCTCi/bpQb+zxdK4TTom85moIN3gyfbiz4XFs0EMsFAA
	MlUBlVsBX/9wNrc8lBWTkU20njpUyF2wHLDD0jnQXes8jl38ILB+tIUs3gwjQrUfS01q8G+g3L+
	W0HY0CXCHXbzHnE89MhTO7ZfgmSeSyT6NSH20FJm6SeB6BjCLQ8Ia9z1W4j7QKAUEDucWlSngNL
	IBMQZXb6g/3sa0CaAf8omX7Tjts2DUj+ms4faW2+xWcMSWfaQ2WPeaCFYOSTAuHjh3vBGOHXtPR
	GpjTYtX/alKOKmAxyp27VgnEzO9fJF8+CSE7M8MEgFCyLwj+vxGo=
X-Google-Smtp-Source: AGHT+IGLYPl3TxMWSwxIUVbUGsljF0qkmh52JVvNkBVe+C640U3h7jC99A2ZKRvMhv7tjxkLCSrUUA==
X-Received: by 2002:a17:90b:17cb:b0:327:ea30:b with SMTP id 98e67ed59e1d1-328156baa8bmr26043452a91.18.1756980100728;
        Thu, 04 Sep 2025 03:01:40 -0700 (PDT)
Received: from nyaos.. (v133-18-108-210.vir.kagoya.net. [133.18.108.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b747c2d66sm3510656a91.28.2025.09.04.03.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 03:01:39 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Cc: chenmiao <chenmiao.ku@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 3/4] openrisc: Regenerate defconfigs.
Date: Thu,  4 Sep 2025 10:00:51 +0000
Message-ID: <20250904100109.688033-4-chenmiao.ku@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250904100109.688033-1-chenmiao.ku@gmail.com>
References: <20250904100109.688033-1-chenmiao.ku@gmail.com>
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

