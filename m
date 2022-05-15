Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70471C433EF
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 12:42:32 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id B0BBA20CE9;
	Sun, 15 May 2022 14:42:31 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mail.librecores.org (Postfix) with ESMTPS id C3312248F2
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 14:42:29 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id x12so11688470pgj.7
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 05:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oszu+rft9ZMt8hn3XlfQBiWXh4vkWerpEVjVpNGVwQE=;
 b=QUztnKckQLs6QOL8wh+L9s4NyE/A8ErSr88cMUnsKmTDwPlNYC6Rp4+HzfVNvYV2Oa
 Q7MGVkowm1N/DDlz6Xg20X9zN3qSuCedUqwcV48ueXbh26LWmY/cpQuchz59prtRtOO5
 IrUCN1j327AKQZLblw1wKiz5B6wgpf1OMkk9wFQc0ZgEToQBhP1ina+2fwH1e+XmTzM1
 OAEoDZH9ak8dX2+IFHY18sz75yGaAcUIZ7+YmBXKk6Q9LyHAaC4kFoMdeo8uvT3jxzFU
 1y5+634tI12cXc4Lmt6sfuxj2GTmTpHINqtZx4D0oYCHh/UEFkDZXygge0r9iDfd0KA+
 wkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oszu+rft9ZMt8hn3XlfQBiWXh4vkWerpEVjVpNGVwQE=;
 b=Bv/r8dlTckPmWJJK5xiuAt2WrSsUT3sGSQH0rerEnAUdwWcij6diTWVUDcOvumZ0Bn
 aT1r8W7tK9aSYkygyc6d7mHP0MMLU50MKb43SwnNLhG4U48XUHhDpgZ9SWNSF2byERr4
 6CAvZiL4cl8G98Oy+Ca1dDvN6SrpnQzIO+ZrtLjUT0pr3BvF66Ufhn+EuWqPkO68+tGE
 MezHI/zNQcaNiz1t4sXQDtXx2A10D4o9xKGTEvVhjDCLu6G/zMVs6D9IftT/vhxFmzKb
 1D6vMVsSqabHt5ouKwmblL/q3ns8wbvkeQtA/G2E+4yTdalNbudPiwlInFyo68YMrxL2
 uHnQ==
X-Gm-Message-State: AOAM532ZBNtyIbzbdRMeWJXk54MVdGtTJdiIDDefchfjxLP46lrlGKkQ
 67UJ1/rMVUrgNkYYFBU48+M=
X-Google-Smtp-Source: ABdhPJxY/yTMQfvtEzhS34eTR0MZAVjQ59q1O6m6syIwdFav8U5MnXyWVoR9IZMyQi/HTPqQgRyI8Q==
X-Received: by 2002:a63:7056:0:b0:3f2:638e:c914 with SMTP id
 a22-20020a637056000000b003f2638ec914mr1958482pgn.65.1652618548432; 
 Sun, 15 May 2022 05:42:28 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a656a48000000b003c14af50622sm4957616pgu.58.2022.05.15.05.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 May 2022 05:42:27 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/13] openrisc: Update litex defconfig to support glibc
 userland
Date: Sun, 15 May 2022 21:41:51 +0900
Message-Id: <20220515124158.3167452-7-shorne@gmail.com>
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
 arch/openrisc/configs/or1klitex_defconfig | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/openrisc/configs/or1klitex_defconfig b/arch/openrisc/configs/or1klitex_defconfig
index d695879a4d26..4c0138340bd9 100644
--- a/arch/openrisc/configs/or1klitex_defconfig
+++ b/arch/openrisc/configs/or1klitex_defconfig
@@ -1,22 +1,55 @@
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
+# CONFIG_OPENRISC_HAVE_INST_RORI is not set
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

