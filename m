Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEBDC433EF
	for <openrisc@archiver.kernel.org>; Sat, 21 May 2022 13:14:01 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 50F5D247C2;
	Sat, 21 May 2022 15:14:00 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mail.librecores.org (Postfix) with ESMTPS id EEC3824758
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 15:13:58 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id m12so9426419plb.4
 for <openrisc@lists.librecores.org>; Sat, 21 May 2022 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oLH4/O4hnVy3wOLUc8vz0oBE8xaj2C4NuAcXjfnz4nc=;
 b=niDfWBSUsX18Eo+z1BzxhZCU0ofsCu4DzD5HfoxNZ2DTnYgxx7Gju+frSRnrp+vCXH
 56FcSy+kE3Tzknxnz265wjA6qtdrDw1NHLH7gpTBurdvVMhyQfaY0IKmh7x14FEGzU1J
 sokW175+Q/YkF0Gw+GsrOdzkjO18FNWMHN1NdbBbAoMdbwIW0mTkc6R5dyILzQVh5azT
 7Ga+jYtgsuuqtCBn5LRVaIhqfvZdesaxpIyqKyAymbcjamb7ctqYXusn8eTGtzEEFGP6
 4CMKup3FFKMfsGCjPmY/nUiko07rH+dTyYeXaYgzHKD3aYcjlrH5w+6oDj6SX6PyVyaI
 MVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oLH4/O4hnVy3wOLUc8vz0oBE8xaj2C4NuAcXjfnz4nc=;
 b=5eyrB7s29Pk8ypIZkt+/eDvyThyGZZVhXic0QlBuExycOAEhGKdt17F6j/gWiU5s0O
 dIbyOTahFPcBj/JnQbytns+BduxMixfNFgenBHTZzoKERSa00PSAR5wJ9J/N+SBVa3qz
 bu+J717mSGeUsvrkVp+pNOwNC8FeNhxU7XZ2oAv8Xij9HqLkihV5uZIIXwcnzgm8PEDC
 fD80d2yrSIBt8J6y+Kg9UdC0o9/0ARnzC18lOIbVftCJLi3gkFC+qBXBdPEF76NG9Z8e
 pUW8LFclyKH/bQJHdOUBklRTNj59zhuCI9heuToAtZNfmBfrGiY0U7awE+SjY+Bjxj4f
 OppA==
X-Gm-Message-State: AOAM533xzNuhVjTBrG9w+UkM4a/va/Y8cdhgWY81F9Qfjiqew4Mx13W2
 hatp6fJTbzzLSteyWV8c2lk=
X-Google-Smtp-Source: ABdhPJzKwRby6wAL6fXmsCoBg2Jo18skM3PQfHlN6h+jnaXjyVK1aQ/gnt4kwrr5w8dLwD11V0/c0A==
X-Received: by 2002:a17:90b:1b41:b0:1e0:17f:d17 with SMTP id
 nv1-20020a17090b1b4100b001e0017f0d17mr7128754pjb.85.1653138837559; 
 Sat, 21 May 2022 06:13:57 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a62b510000000b0051843980605sm3593579pfe.181.2022.05.21.06.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 May 2022 06:13:57 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 06/13] openrisc: Update litex defconfig to support glibc
 userland
Date: Sat, 21 May 2022 22:13:16 +0900
Message-Id: <20220521131323.631209-7-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Song Liu <songliubraving@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Mateusz Holenko <mholenko@antmicro.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Gabriel Somlo <gsomlo@gmail.com>, Openrisc <openrisc@lists.librecores.org>,
 KP Singh <kpsingh@kernel.org>, Yonghong Song <yhs@fb.com>,
 Martin KaFai Lau <kafai@fb.com>, Karol Gugala <kgugala@antmicro.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

I have been using a litex SoC for glibc verification.  Update the
default litex config to support required userspace API's needed for the
full glibc testsuite to pass.

This includes enabling the litex mmc driver and filesystems used
in a typical litex environment.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/configs/or1klitex_defconfig | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/openrisc/configs/or1klitex_defconfig b/arch/openrisc/configs/or1klitex_defconfig
index d695879a4d26..d3fb964b4f85 100644
--- a/arch/openrisc/configs/or1klitex_defconfig
+++ b/arch/openrisc/configs/or1klitex_defconfig
@@ -1,22 +1,54 @@
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_CGROUPS=y
+CONFIG_NAMESPACES=y
+CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SGETMASK_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_OPENRISC_BUILTIN_DTB="or1klitex"
 CONFIG_HZ_100=y
+CONFIG_OPENRISC_HAVE_SHADOW_GPRS=y
 CONFIG_NET=y
 CONFIG_PACKET=y
+CONFIG_PACKET_DIAG=y
 CONFIG_UNIX=y
+CONFIG_UNIX_DIAG=y
 CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_INET_UDP_DIAG=y
+CONFIG_INET_RAW_DIAG=y
+# CONFIG_WIRELESS is not set
+# CONFIG_ETHTOOL_NETLINK is not set
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_OF_OVERLAY=y
 CONFIG_NETDEVICES=y
 CONFIG_LITEX_LITEETH=y
+# CONFIG_WLAN is not set
 CONFIG_SERIAL_LITEUART=y
 CONFIG_SERIAL_LITEUART_CONSOLE=y
 CONFIG_TTY_PRINTK=y
+# CONFIG_GPIO_CDEV is not set
+CONFIG_MMC=y
+CONFIG_MMC_LITEX=y
+# CONFIG_VHOST_MENU is not set
+# CONFIG_IOMMU_SUPPORT is not set
 CONFIG_LITEX_SOC_CONTROLLER=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_EXFAT_FS=y
 CONFIG_TMPFS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"
 CONFIG_PRINTK_TIME=y
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
-- 
2.31.1

