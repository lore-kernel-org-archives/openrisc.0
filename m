Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA519C433EF
	for <openrisc@archiver.kernel.org>; Tue, 17 May 2022 00:55:49 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id E887A24970;
	Tue, 17 May 2022 02:55:48 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by mail.librecores.org (Postfix) with ESMTPS id 0412C24970
 for <openrisc@lists.librecores.org>; Tue, 17 May 2022 02:55:47 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id f10so4082082pjs.3
 for <openrisc@lists.librecores.org>; Mon, 16 May 2022 17:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oszu+rft9ZMt8hn3XlfQBiWXh4vkWerpEVjVpNGVwQE=;
 b=GmR3175J1QJA++Kl/bkM18GAR0pdIOR/nKTuYJ02O2yIkNWXEOJPq5w2+cfh2DL/TI
 +jpF745GD82YqiM0gAdhkEKWSc1XbAzth44QQ+UornMYJ4amJjWzRY33tQN2cmVR4ZWe
 aUt8vVXkkVq0g7off74SJU92u11TirCMvQligM3DUzTK7LwzvsjXzY8jNQyQTQVHUY6G
 Wl/ZlIgB8DVF8oJQKkNjJGtI74NFgq2+9SOhSvo8bQx38xZOaKs6snbLQD2nvg3DT4wT
 j7yJRDZp4nZL3LnHSNNdGMqGRVp+SBRs8NMW1exWDQAv5MMUkn6s4sPJL4eNLfA873eH
 Wwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oszu+rft9ZMt8hn3XlfQBiWXh4vkWerpEVjVpNGVwQE=;
 b=PkxXQIoQ+zTIMi/uoN8vocBiKu1YSe4ES4fCECvKPoquX/6np4+omUULVHwlQZi3fY
 Lf1nxKqyBBzeTPj/xWN2TPC+Qw6Mj2vtREwGs8+DISeg7VzyARYMfaLRijZrFx/wX2sp
 BA9mLMvFBPPKFG6X9SKKJhYFLi+Q13pCa+yA5RKp3CYh8Hw24gIDKGJN0Ga9WneP5Iot
 e69X3ifKZQHo8h5iXxsW2NMUsSfRq8MEsXjZajGTgWA8ykLuoUKvj+qxrxBuun4WSTH1
 /IoAjODYKm0fG/XpBOnVd+sGBICtsUC0bdcuTGj0M74YxX74ATJ1yHdsKvFt1Jl2VrcY
 4YvQ==
X-Gm-Message-State: AOAM531im73/SJCT3nGF0n7yAjI94FccpBDrED0IiLWeG3R/gSeuIfBd
 1/n3Wtk/PUFwb53o9WDOIW0=
X-Google-Smtp-Source: ABdhPJx6yIrIZNvt4OMM4DykP/blCEK67dJ+2zkDI1WzYEMFAxHoTyKI6A15UXJyEq9tmctm+aFOgQ==
X-Received: by 2002:a17:902:ce11:b0:15f:4acc:f1fb with SMTP id
 k17-20020a170902ce1100b0015f4accf1fbmr19520857plg.76.1652748945576; 
 Mon, 16 May 2022 17:55:45 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 p26-20020a62b81a000000b0050dc7628177sm7474333pfe.81.2022.05.16.17.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 17:55:44 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/13] openrisc: Update litex defconfig to support glibc
 userland
Date: Tue, 17 May 2022 09:55:03 +0900
Message-Id: <20220517005510.3500105-7-shorne@gmail.com>
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

