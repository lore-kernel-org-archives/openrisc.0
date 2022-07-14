Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F8DCCA488
	for <openrisc@archiver.kernel.org>; Thu, 14 Jul 2022 04:27:59 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id ACFB924914;
	Thu, 14 Jul 2022 06:27:58 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mail.librecores.org (Postfix) with ESMTPS id C7354248B4
 for <openrisc@lists.librecores.org>; Thu, 14 Jul 2022 06:27:56 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 cp18-20020a17090afb9200b001ef79e8484aso5191896pjb.1
 for <openrisc@lists.librecores.org>; Wed, 13 Jul 2022 21:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZWuX6ov4197gAn7zaYMbI8DUTRJY83Rd6vcUzJETd9g=;
 b=Ua3dc38Hbc65M6quhX/3f0MkSCWwVwSy1uos75L73bLQo9YOkV/ouWet0LzjrrwCC4
 7TZWVHIrXc3GzXr/bDq0x/Vg+7g151sJY1c564aIk1bV3mpPHaqWOGQkr7vMuqYxJUV9
 wU5EeVMBlQk1NqzxdDYwPGdaVCuiWdZGcPU85jII6EcRQ7/K+hyH/jw1mG4tDZqLKrbZ
 45S3kjiKmeZ4TauWOrjKizVBNeRk6ddu05eo+L+ovbzTSoby8ZD31UiRD8OA/wnCYdU0
 xFeF8IeefmGh2UTI7sfeuyifpe9WtY9Z1faqvKhwl1ms4cl60s+ym0BkyO5hsJIVJIeK
 tTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZWuX6ov4197gAn7zaYMbI8DUTRJY83Rd6vcUzJETd9g=;
 b=36Rj4DMdgWtpwqilAkR9nQk//RwiElUeO6hl+wG1eTo0KQSPAdbeKnKpKG33RLhru1
 w8KPX58O06j/WB5rxGU4BcVPO3Gr5gynMM9ZP8YD5zTP7a1/hRXKb9Rw1DkuOfuUBHAg
 Kgt/EtcXYoe64yYWggkJazmfZB85eea8qiW5l1krpmZefWKlr5DMMnB8HGXNYEtDfblq
 ihh5fducD34DhMsKF1u1ogw4PvVEnZSAX+1IM2bu6EP64IWhJw4lwsSKizJF5aP58Xvm
 nKCJQLQYeO4KIl9qradT6UAKnoqFfHSC2YSz1pg4EAEZ/kYVVArl3a8ABey6u0fo+8Or
 2dnQ==
X-Gm-Message-State: AJIora8CJ68Dvbd2bvEiIxpIFYGyzADMgh/k1g3GWD3XG7I4ULlOLaXy
 DVZzOhxWgJYLVwW25ZbTJjc=
X-Google-Smtp-Source: AGRyM1vsh2RRLIselvsASRcdl5YWYuT5WWUUCVkeqtEIqmBcATZPEZELX2HnIYva/iFeDF9StaNh8A==
X-Received: by 2002:a17:902:6a81:b0:16b:d807:9acd with SMTP id
 n1-20020a1709026a8100b0016bd8079acdmr6595961plk.40.1657772875392; 
 Wed, 13 Jul 2022 21:27:55 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a17090aa40e00b001eee7950428sm318181pjp.44.2022.07.13.21.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jul 2022 21:27:55 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] openrisc: Add virt defconfig
Date: Thu, 14 Jul 2022 13:27:35 +0900
Message-Id: <20220714042736.2133067-3-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220714042736.2133067-1-shorne@gmail.com>
References: <20220714042736.2133067-1-shorne@gmail.com>
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

