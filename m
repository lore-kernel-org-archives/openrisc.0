Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9272319610
	for <linux-openrisc@vger.kernel.org>; Wed, 14 Jan 2026 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768403671; cv=none; b=ST5hMWI90sGcoRVzSSAIKbvtP3DtK5Ud+u4FmT4dnyugffMLxIb5Sp6fac5N8iqGvMlBlmG/BXhN0NRMhwLjlJstNXMBrgR2Y6VWQZtCBpFExRBAdsJBOkkbzIubNSNdz1xKDc+auUqAR29q0cs26UlYFfRY05I4hnLnlT0qd/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768403671; c=relaxed/simple;
	bh=X+1J5PrXk/eYAdcNrlogIy51e8BwUbac79/oxhidec0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/t01Wfqu2EzseAvESKoAgnJhNEgO48v+qdDrbTXto6Vno9ieU6IrtWS8v3BBEO0+XEzCiKw15SQPPhozfzPy66nKac5Dy4lZJcR9FfgyMdGig1T2CwQcevLBl1hYZEO6YAAB5ZwpNNrEWXL1DNR0OfAIybLfyZGv/aJARrXfxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSPCCXSO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSPCCXSO"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee4338e01so3694875e9.2
        for <linux-openrisc@vger.kernel.org>; Wed, 14 Jan 2026 07:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768403668; x=1769008468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1s6pH8NPA0ipZmaojy8syPtuylZJ77gPmpuGh7ODFgg=;
        b=RSPCCXSOAUDaZqmkmBRNvLm2rHJ7n1oVXsDgZkM4zV0xeWrGfxmUy+G9+H+l38qgKe
         mKMv1iSz+sbrZ6AouZztWLXOaboNVM/jYpX1N84bniKs8dE4SZ0VPeNAUAqpQr/uq6sE
         RjqgWv3auJQMxlUAVRDn/zv0+sEdku8PkpvWoWKvpiyMW5nLr4R7VBnQvts6aakr1a3M
         f5PEB4IllfQEqwWKKv0zPk0V+7PCd5Up6RcGUH1F0bt3Iv363qZJT64j58F9P7TsdtqH
         5HxvGFqsJP7tTj9EBQ2zwLSXy84LXHtP9oT5Y2OeLGrCy1K4/Nfej3QN4hmMC2Pq4nzb
         xeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768403668; x=1769008468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1s6pH8NPA0ipZmaojy8syPtuylZJ77gPmpuGh7ODFgg=;
        b=UgHR8mT4ZbFG2dXBGUOLxFCl4HkM6JxvlCyaLB/g0KuEvsLKOtQLjPXwoXg0zBp4oC
         Qe4B/KGrbxAxqjmZxEspbR78tCpat1qBOBXcxJZl8i8i2lv1G4z5YRVAUAB5zNwgP8Fr
         1/czWRyLLEliqAAtH3KvpLlFRvTeHp4y30sDG3TWvMRTo+0LAXeq4iJyyYEFFBFrJKr1
         mRW8JgVUlGvISA0+HLF2ERz1Xh/uARRs4aaMMSNbbZW1pHjN+SkiXNudvbVTtR9ZqVIt
         WMN3k0j6uQgd3+e1GmtkWageBo7sKX927tuJ2xvVWaKpXl1r+qV5nqFivKSuOvm5P8hC
         CdTA==
X-Gm-Message-State: AOJu0Yw/xv6kO4i4r7WTqPX2NIAbpgFMRXDO1tVGSh/+bPp40UYUOsKf
	EaL+sDMtDcDrzdjAoQmcwQHGroXiEA+5VS1G92jFaChHZ7lTyZFnlYj2
X-Gm-Gg: AY/fxX5xw7Ci4c/eBA+iWcYfWAK3fIWM9QLy+pRgb04yEq5Twr7h/kBF6uw4hF2/0jp
	YOywQDFZNmF3jCiLrHrT6JyambG63XghAKrFDqWs7KrMUqlXbSKwz6oBWN5KiXDsF4iC4RW4GPC
	vuBat8Qrhp4TyFxw5sehJF0kRba7fS7touFnsS20kBIBWV9rXSDfXsipB9Eu6gy7vVRU95zEmFR
	wA6Kv7e87k78rdSavEKbBc0TWTw4Y3FQKSwpLhiIKUPMlxMxzUkS816l42HUNI39/1On5rD0EhR
	20OpEBgDoUuGW7T6Yqik8ql+1LJJzjVGQj7ch3xWoGKftYpTI91jt5yIpC8epd8rYHv48ObD2wq
	NXnx1J3lDSsEpMP0GtUSabD9ECdp5d2Osqz1CqeLUHfwvtZGzdrU4jnaWa1cl6+CAVdf5nyqvvD
	LZLCYOkECIuz6eR5PWU+0GnIfzW3qPOPL78seY39V5pqvKu1xLnuL/Ya+6MIhoiXfV
X-Received: by 2002:a05:600c:a318:b0:47e:e952:86c9 with SMTP id 5b1f17b1804b1-47ee952876fmr8858615e9.0.1768403668144;
        Wed, 14 Jan 2026 07:14:28 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacc5sm50466226f8f.5.2026.01.14.07.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:14:27 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: [PATCH v5 3/6] openrisc: dts: Add de0 nano config and devicetree
Date: Wed, 14 Jan 2026 15:13:12 +0000
Message-ID: <20260114151328.3827992-4-shorne@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114151328.3827992-1-shorne@gmail.com>
References: <20260114151328.3827992-1-shorne@gmail.com>
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
Since v3:
 - No changes.
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

