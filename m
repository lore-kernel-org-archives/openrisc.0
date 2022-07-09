Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44365C43334
	for <openrisc@archiver.kernel.org>; Sat,  9 Jul 2022 21:16:51 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 6758621052;
	Sat,  9 Jul 2022 23:16:50 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mail.librecores.org (Postfix) with ESMTPS id 99F34208C2
 for <openrisc@lists.librecores.org>; Sat,  9 Jul 2022 23:16:48 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id p9so1829621pjd.3
 for <openrisc@lists.librecores.org>; Sat, 09 Jul 2022 14:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZWuX6ov4197gAn7zaYMbI8DUTRJY83Rd6vcUzJETd9g=;
 b=o6vJUaK5s3FRRIr1orvVL8DhPS6tgH7MkcPUxL62UVIkJj/miqCG73eUkcn/J//J/h
 BLcv0ikNeOtsh4fq0zRSajFCXzJzwlEmIaEkgHOtaaKSr+luwEsEit3MD591YFAmlKfr
 FOzGjIgXDeuHsHaTxL8+aR/ZlIu88MtaeE/k+5w2cyU1WRQHJkVy1yZB7AV60BgAysxh
 JS8t2InMRmP6rvGbrRHcsP7Ib3LUqAyyYdfyZg8QwUR3kX7Ou4i9s+UVfFb4dug9orh7
 MuQBIo5RCa3A75OxusFOcB5++d8w4OVt+6Etsds6+MmGgKV/OQE2GvmBdrPEy1/+UzaV
 xvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZWuX6ov4197gAn7zaYMbI8DUTRJY83Rd6vcUzJETd9g=;
 b=WG4d3nzXmKV+u27V757bC8Jrwb5niLT1KbG56MM882rf27ck5mn3kup1FgVxc9F9Ji
 6y/kHCyJ9XywEsxV9MRspA7+bKfj1Jzmd4AWq7gIk1ab+28eEi3bv3gOwl6j4GGX5yid
 N+7AUl4MJzMDFrM5qTkYrM/RdobYtFGsCwRlPY9SiQVg6MqutDtP6DgrWHBCE8+JvWav
 X8RzBgHhc9ruAONf2vdy4gmRY8/oJ2y+zD+VvYqDGTb0y/kDFdttT3oy1Xt3ogmO1pRk
 MLBZCVjnbIiHsOcZ/sA1Go67AA9ozNElh+eSG68nX7S/Ot0gSv7Bb5g62al3zWjWLRhu
 porw==
X-Gm-Message-State: AJIora94pboHjLrLxSdjhXMI1nqR2t0/yYuvw9BIkNQWiEbFhvUa98HX
 OZmRoAx0CH4n+RN03f10zI0=
X-Google-Smtp-Source: AGRyM1uvjZnIh0oHuLg51QGQVl97sMhJ6t+Q15UlazhWY7up63kdsrc+Or8FTQhBwmQT1qjcWn6smQ==
X-Received: by 2002:a17:903:22c7:b0:16b:fa15:63d4 with SMTP id
 y7-20020a17090322c700b0016bfa1563d4mr10623100plg.2.1657401407139; 
 Sat, 09 Jul 2022 14:16:47 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 z16-20020aa79490000000b0051c6613b5basm1901097pfk.134.2022.07.09.14.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Jul 2022 14:16:46 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] openrisc: Add virt defconfig
Date: Sun, 10 Jul 2022 06:15:49 +0900
Message-Id: <20220709211549.1163327-3-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220709211549.1163327-1-shorne@gmail.com>
References: <20220709211549.1163327-1-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Openrisc <openrisc@lists.librecores.org>
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

