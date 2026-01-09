Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DC635CBB0
	for <linux-openrisc@vger.kernel.org>; Fri,  9 Jan 2026 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767966284; cv=none; b=Np6qD19rhH1GcWkNyvUzb9tG6jAl/ECrV93cGpI93D7Pc/YKdzfyuQ6SCRKHJvCfaAiFXfiNU8wkGp8KN33dijJtSjz9Tkls22MWWjuhm+X4Lx5V6QinzjLf8ScF7tNFwCsxb1ABZaus1WKGR4yaLxI4PEPDTVdHRLBnA0QcpXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767966284; c=relaxed/simple;
	bh=pcjQxX4xwIbsnp3bNrSxgahevNMF2mF1M2M9A8g+HnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqCgXbOeIZEzt9AxY+XdAb4ZwYU2NQYTgI3FMbp7M1oOaIeInymRdbLFUfYEevZbHGBkx9Zf8kGNZpfiVzBFX2rBIQlG2w1LMsuN5VFtmdbzWwbkrM/nQpPYDNNFGUNak+PU2FklCVU5+OP4bNX/Y5ib2T/sJ0JgTrYHukLUBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvkKJQTT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvkKJQTT"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so28483815e9.3
        for <linux-openrisc@vger.kernel.org>; Fri, 09 Jan 2026 05:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767966274; x=1768571074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fOl8lMRZPoabFAeN7Y+8OmFxBmjdRvwrOInAYDDHms=;
        b=NvkKJQTTR6R3SS5lx9PkamCqEajWoDtgnt2y6ewWoY9g/vRJV0w3IuVKVHxkdnmFEP
         YtiGmbiK5uaPRaIB1jrjcXKQ1tDpiRdW4j/7ywD6lfKwmKhHWaXS9eL1oNKT41wbnriI
         cU2KZa98NrrJA/+NAul0wbivnLSpFiC4idh9FbC1ftYEPVS93WxGuqX3vRsZxJkGqYaD
         ETWpevszdOJ5sunlFlitRpm3IhLbV5Qn8xozKA0RyRoYTjCMkLVFvUSFqwGDbEmmR2dZ
         aQFPc8TpZwSEVjdYgPOcLZUyqrAvoT9DSSzS4MS5jUMDCux53mpHs5dH2VYNtRlheOjW
         TS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767966274; x=1768571074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7fOl8lMRZPoabFAeN7Y+8OmFxBmjdRvwrOInAYDDHms=;
        b=Jhu5jYA3FwLRr3/imqrdKjlF5YbWmw9ZI5VINyRK4heon/dRtsf7fuC2dRErv6+yfi
         U9Tclx9HE1c5KPttxoTQWML5xfZECBY2qHCqNtGKIa/ctVZb9bdW63XSVM5yCmlVWGk0
         ivWrXPntY5YHnQdDlfvTPUStruoEqviOMMLJiQ8J+alFP448JHh+yU6KQyHUdLiUi/bp
         a9LCQPLHp4tE2OWESaz75ZAU7dEvyUITlMYwo47BYc9WgfyVpva4iZYwwngEfDymXEEk
         cIS8J84EUrFhcG3HJzUjnXSIYJ65f3BZEapCvT7/VeaJKfvXeGtdt32OXx4L2EtEplD+
         ruNQ==
X-Gm-Message-State: AOJu0YxnbjU3DX1HEhUUY5KuQGUCocGi2DVcpqWozWmVjCAXyH4qEn4j
	gIEuIFjTWOmMqfqLoYQuAShUXIeO60U/KNTCB2k5g+j9q89Bseb+JMd0fKSMiw==
X-Gm-Gg: AY/fxX65kwu9GwJ9x2qa0YxMsxGTikL/lglMugNo/nvcZryf1e21Ckm6nfces0kOw5/
	YHmldlyB7bbmhuKa7s5pfRAo9GmSTHVYQi2FULwyGwdKDBeivNo6tBA0b8FCRDT32og6Bbfr++4
	VzgEzRXxjrakAzEzv9RgEqTPG8zaS37Mg7YG9PM4U4jXNM9wegVpYSv3wyf8PVl1QQvNmC9wjFa
	HSxOr1wTq8DFdZt3eUlOivV0328o2SWf1zAH9sNmbn0koM7oLcvGJb4yUODpxPBE+L6sfhB8cIQ
	NUaX1HvBbxNDtA8xAclbZLP2GdmFh7FOqa4gZ4Rn+jlPD9ACxYGlOsvAMKtzrjTDWnwLqnVlbAv
	e4Ae4o9GZUmN6T5acyBSUbEebP7/BKGagKEFFlXU1SdmZdGwQlFwXnOkGSQp098IRo59F6V+gJU
	g+m7N8jyUIW0NZA/r4iS650xfMtS2dCTitz3ntBm4bT0EuM27l+ODjdi6a3EXqgC5g
X-Google-Smtp-Source: AGHT+IHI1oIh/l+pNHhz+Cb7RCUFMB+k70iKC6Eky++cfANGCa9CRJhRrYYCxElFJ+VzNeg0ZGTPxg==
X-Received: by 2002:a05:600c:a318:b0:479:2651:3f9c with SMTP id 5b1f17b1804b1-47d8d685db6mr46957855e9.14.1767966273440;
        Fri, 09 Jan 2026 05:44:33 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d87166d0csm65661495e9.6.2026.01.09.05.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:44:32 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	devicetree@vger.kernel.org
Subject: [PATCH v3 3/6] openrisc: dts: Add de0 nano config and devicetree
Date: Fri,  9 Jan 2026 13:43:54 +0000
Message-ID: <20260109134409.2153333-4-shorne@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109134409.2153333-1-shorne@gmail.com>
References: <20260109134409.2153333-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The de0 nano from Terasic is an FPGA board that we use in the OpenRISC
community to test OpenRISC configurations.  Add a base configuration for
the board that runs an OpenRISC CPU at 50Mhz with 32MB ram, UART for
console and some GPIOs for LEDs and switches.

There is an older version of this floating around that defines all of
the hardware on the board including SPI's, flash devices, sram, ADCs
etc.  Eventually it would be good to get the full version upstream
but for now I think a minimal board is good to start with.

Link: https://openrisc.io/tutorials/de0_nano/
Link: https://github.com/olofk/de0_nano

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v2:
 - Move leds block up to the top.
 - Remove unneeded "status" from gpio0.
 - Removed earlycon from de0-nano.dts.

 arch/openrisc/boot/dts/de0-nano-common.dtsi | 42 +++++++++++
 arch/openrisc/boot/dts/de0-nano.dts         | 54 ++++++++++++++
 arch/openrisc/configs/de0_nano_defconfig    | 79 +++++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 arch/openrisc/boot/dts/de0-nano-common.dtsi
 create mode 100644 arch/openrisc/boot/dts/de0-nano.dts
 create mode 100644 arch/openrisc/configs/de0_nano_defconfig

diff --git a/arch/openrisc/boot/dts/de0-nano-common.dtsi b/arch/openrisc/boot/dts/de0-nano-common.dtsi
new file mode 100644
index 000000000000..02e329e28e33
--- /dev/null
+++ b/arch/openrisc/boot/dts/de0-nano-common.dtsi
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	leds0: leds {
+		compatible = "gpio-leds";
+
+		led-heartbeat {
+			gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_HEARTBEAT;
+			linux,default-trigger = "heartbeat";
+			label = "heartbeat";
+		};
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x02000000>;
+	};
+
+	/* 8 Green LEDs */
+	gpio0: gpio@91000000 {
+		compatible = "opencores,gpio";
+		reg = <0x91000000 0x1>, <0x91000001 0x1>;
+		reg-names = "dat", "dirout";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	/* 4 DIP Switches */
+	gpio1: gpio@92000000 {
+		compatible = "opencores,gpio";
+		reg = <0x92000000 0x1>, <0x92000001 0x1>;
+		reg-names = "dat", "dirout";
+		gpio-controller;
+		#gpio-cells = <2>;
+		status = "disabled";
+	};
+};
diff --git a/arch/openrisc/boot/dts/de0-nano.dts b/arch/openrisc/boot/dts/de0-nano.dts
new file mode 100644
index 000000000000..b5b854e7e8b4
--- /dev/null
+++ b/arch/openrisc/boot/dts/de0-nano.dts
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "de0-nano-common.dtsi"
+
+/ {
+	model = "Terasic DE0 Nano";
+	compatible = "opencores,or1ksim";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&pic>;
+
+	aliases {
+		uart0 = &serial0;
+	};
+
+	chosen {
+		stdout-path = "uart0:115200";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "opencores,or1200-rtlsvn481";
+			reg = <0>;
+			clock-frequency = <50000000>;
+		};
+	};
+
+	/*
+	 * OR1K PIC is built into CPU and accessed via special purpose
+	 * registers.  It is not addressable and, hence, has no 'reg'
+	 * property.
+	 */
+	pic: pic {
+		compatible = "opencores,or1k-pic";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+	};
+
+	serial0: serial@90000000 {
+		compatible = "opencores,uart16550-rtlsvn105", "ns16550a";
+		reg = <0x90000000 0x100>;
+		interrupts = <2>;
+		clock-frequency = <50000000>;
+	};
+};
+
+&gpio1 {
+	status = "okay";
+};
diff --git a/arch/openrisc/configs/de0_nano_defconfig b/arch/openrisc/configs/de0_nano_defconfig
new file mode 100644
index 000000000000..bc63905f9cd8
--- /dev/null
+++ b/arch/openrisc/configs/de0_nano_defconfig
@@ -0,0 +1,79 @@
+CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_RD_GZIP is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_LZO is not set
+# CONFIG_RD_LZ4 is not set
+# CONFIG_RD_ZSTD is not set
+CONFIG_EXPERT=y
+# CONFIG_EPOLL is not set
+# CONFIG_TIMERFD is not set
+# CONFIG_EVENTFD is not set
+# CONFIG_AIO is not set
+CONFIG_BUILTIN_DTB_NAME="de0-nano"
+# CONFIG_FPU is not set
+CONFIG_HZ_100=y
+# CONFIG_BLOCK is not set
+CONFIG_SLUB_TINY=y
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_VM_EVENT_COUNTERS is not set
+CONFIG_NET=y
+CONFIG_UNIX=y
+CONFIG_UNIX_DIAG=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_INET_UDP_DIAG=y
+CONFIG_INET_RAW_DIAG=y
+CONFIG_INET_DIAG_DESTROY=y
+# CONFIG_IPV6 is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FW_LOADER is not set
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_LEGACY_PTYS is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_PPS=y
+CONFIG_GPIO_SYSFS=y
+# CONFIG_GPIO_SYSFS_LEGACY is not set
+CONFIG_GPIO_GENERIC_PLATFORM=y
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_ONESHOT=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_CPU=y
+CONFIG_LEDS_TRIGGER_ACTIVITY=y
+CONFIG_LEDS_TRIGGER_GPIO=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+CONFIG_LEDS_TRIGGER_TRANSIENT=y
+CONFIG_LEDS_TRIGGER_PANIC=y
+CONFIG_LEDS_TRIGGER_NETDEV=y
+CONFIG_LEDS_TRIGGER_PATTERN=y
+CONFIG_LEDS_TRIGGER_TTY=y
+# CONFIG_VIRTIO_MENU is not set
+# CONFIG_VHOST_MENU is not set
+# CONFIG_DNOTIFY is not set
+CONFIG_TMPFS=y
+# CONFIG_XZ_DEC_X86 is not set
+# CONFIG_XZ_DEC_POWERPC is not set
+# CONFIG_XZ_DEC_ARM is not set
+# CONFIG_XZ_DEC_ARMTHUMB is not set
+# CONFIG_XZ_DEC_ARM64 is not set
+# CONFIG_XZ_DEC_SPARC is not set
+# CONFIG_XZ_DEC_RISCV is not set
+CONFIG_PRINTK_TIME=y
+# CONFIG_DEBUG_MISC is not set
+# CONFIG_FTRACE is not set
+# CONFIG_RUNTIME_TESTING_MENU is not set
-- 
2.51.0

