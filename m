Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD78C433EF
	for <openrisc@archiver.kernel.org>; Mon, 25 Jul 2022 02:08:21 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id ECCC420E49;
	Mon, 25 Jul 2022 04:08:20 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mail.librecores.org (Postfix) with ESMTPS id DDDF120D4B
 for <openrisc@lists.librecores.org>; Mon, 25 Jul 2022 04:08:19 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id h132so9077487pgc.10
 for <openrisc@lists.librecores.org>; Sun, 24 Jul 2022 19:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZWuX6ov4197gAn7zaYMbI8DUTRJY83Rd6vcUzJETd9g=;
 b=XqSF0FLr2QcdghFGdajoYosuSawd7eZdo5NaPH1hg4vLniqnKBptDuF7ihMmgpwwxg
 DpRjpjncqaJaTZWKKKXV/veHN7oedCH+J2hr2vpVY8UQm3DFFXa31omH+MC/TgExD6Bk
 Ngu2EdGqZR503533oD9SI7UCw1hA3qcWPHfdEhS163dT04JG/LWgNp6B42tW/cfQZMWT
 fqa0Bn7ocVLBtPRa2arbVyLgC+xoDrOZcuJQqrAwhZEXvq6aoQWa9ZAS7bwmUc4j4Q5g
 Xf1v3/YJdtK59O0BgkN7sTyPB9M141fbtE++wPdhUQY9HHU16g7CYuNkhJ4q+7ZeA0Fl
 0ObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZWuX6ov4197gAn7zaYMbI8DUTRJY83Rd6vcUzJETd9g=;
 b=39Fht2tkuyKHqgaXzGaWHlf2tZlE7psB9994csoaND7Ru8Uo8RHvQ4WH8Gg1JqUa5C
 44ywD+gRLCmOdvrD3WSZNQ/s+58kujnkbvHrPGmGKgph7A6uRgaGO5mFvyOiA9grrImA
 eFbYcmP2kajH1Fy84u74SRV6WQFoOty5g5gmReDdoWqcJd/VSfUvgI4RIqhnqxa68gzT
 3S1vwJvUIVMaxrlwaFSuHrSkUtlOmvyr7JTcewxb/ZlshnEWLvilw8i5aVaj/jj7eAv0
 C3gyvJ3x/Ppf1DYZWIm+kFkLvaZYfUluPpyu0jr3lEKTZ/j8okTqBXrkwym407nmeAQG
 gZoQ==
X-Gm-Message-State: AJIora+n6OVSmIkwcMdJA6UyXE6Oo2lkPmxNHHJWpMGH06qXj2B7Lroz
 1iWmj+kl1rMpNkZEUiKrqts=
X-Google-Smtp-Source: AGRyM1vu51mbhNjjI60KrfJm9SOuVAVVlovM1sCD2glOM1YO6DC3eiWv6836S+SygAu8Tt3irUvFMA==
X-Received: by 2002:a63:4a62:0:b0:412:8c83:a36c with SMTP id
 j34-20020a634a62000000b004128c83a36cmr9024945pgl.404.1658714898394; 
 Sun, 24 Jul 2022 19:08:18 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a056a00212700b0052ab0a73752sm8124216pfj.198.2022.07.24.19.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Jul 2022 19:08:18 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] openrisc: Add virt defconfig
Date: Mon, 25 Jul 2022 11:07:37 +0900
Message-Id: <20220725020737.1221739-4-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220725020737.1221739-1-shorne@gmail.com>
References: <20220725020737.1221739-1-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Arnd Bergmann <arnd@arndb.de>,
 openrisc@lists.librecores.org, Bjorn Helgaas <helgaas@kernel.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

I have been developing a new qemu virt platform to help with more
efficient toolchain and kernel testing [1].

This patch adds the defconfig which is needed to support booting
linux on the platform.

[1] https://lore.kernel.org/qemu-devel/YpwNtowUTxRbh2Uq@antec/T/#m6db180b0d682785fb320e4a05345c12a063e0c47

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/configs/virt_defconfig | 108 +++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 arch/openrisc/configs/virt_defconfig

diff --git a/arch/openrisc/configs/virt_defconfig b/arch/openrisc/configs/virt_defconfig
new file mode 100644
index 000000000000..c1b69166c500
--- /dev/null
+++ b/arch/openrisc/configs/virt_defconfig
@@ -0,0 +1,108 @@
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_CGROUPS=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_OPENRISC_HAVE_INST_CMOV=y
+CONFIG_OPENRISC_HAVE_INST_ROR=y
+CONFIG_OPENRISC_HAVE_INST_RORI=y
+CONFIG_OPENRISC_HAVE_INST_SEXT=y
+CONFIG_NR_CPUS=8
+CONFIG_SMP=y
+CONFIG_HZ_100=y
+# CONFIG_OPENRISC_NO_SPR_SR_DSX is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_INET_DIAG is not set
+CONFIG_TCP_CONG_ADVANCED=y
+# CONFIG_TCP_CONG_BIC is not set
+# CONFIG_TCP_CONG_CUBIC is not set
+# CONFIG_TCP_CONG_WESTWOOD is not set
+# CONFIG_TCP_CONG_HTCP is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_PCI=y
+CONFIG_PCIEPORTBUS=y
+CONFIG_PCI_HOST_GENERIC=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_NBD=y
+CONFIG_VIRTIO_BLK=y
+CONFIG_NETDEVICES=y
+CONFIG_VIRTIO_NET=y
+CONFIG_ETHOC=y
+CONFIG_MICREL_PHY=y
+# CONFIG_WLAN is not set
+CONFIG_INPUT_MOUSEDEV=y
+# CONFIG_LEGACY_PTYS is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_VIRTIO_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
+CONFIG_POWER_RESET_SYSCON_POWEROFF=y
+CONFIG_SYSCON_REBOOT_MODE=y
+# CONFIG_HWMON is not set
+CONFIG_DRM=y
+# CONFIG_DRM_FBDEV_EMULATION is not set
+CONFIG_DRM_VIRTIO_GPU=y
+CONFIG_FB=y
+CONFIG_FIRMWARE_EDID=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
+CONFIG_LOGO=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_INTEL8X0=y
+CONFIG_SND_INTEL8X0M=y
+CONFIG_SND_SOC=y
+CONFIG_SND_VIRTIO=y
+# CONFIG_HID_A4TECH is not set
+# CONFIG_HID_BELKIN is not set
+# CONFIG_HID_CHERRY is not set
+# CONFIG_HID_CHICONY is not set
+# CONFIG_HID_CYPRESS is not set
+# CONFIG_HID_EZKEY is not set
+# CONFIG_HID_ITE is not set
+# CONFIG_HID_KENSINGTON is not set
+# CONFIG_HID_REDRAGON is not set
+# CONFIG_HID_MICROSOFT is not set
+# CONFIG_HID_MONTEREY is not set
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_PLATFORM=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_SERIAL=y
+CONFIG_USB_GADGET=y
+CONFIG_TYPEC=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_GOLDFISH=y
+CONFIG_VIRT_DRIVERS=y
+CONFIG_VIRTIO_PCI=y
+# CONFIG_VIRTIO_PCI_LEGACY is not set
+CONFIG_VIRTIO_INPUT=y
+CONFIG_VIRTIO_MMIO=y
+CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_POSIX_ACL=y
+# CONFIG_DNOTIFY is not set
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_EXFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_NFS_FS=y
+CONFIG_UNICODE=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DYNAMIC_DEBUG=y
+CONFIG_FTRACE=y
-- 
2.36.1

