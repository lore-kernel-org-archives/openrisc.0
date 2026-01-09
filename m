Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCEA306483
	for <linux-openrisc@vger.kernel.org>; Fri,  9 Jan 2026 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767966292; cv=none; b=WkX1IVVD9lYscaq6IIEarscxYMBapQRgeTjEiQpjSVfv5wBzw6Jbw3GQJYgp2r67/byLUPnZHOc5M1CUKW7y9klLlEhqq2Lx8h64M8JL9o6nQOdIRdqFmMsy/V72aMB9KfZgt4r81an6hN6QihSbUzvovvBtU4o+BE2PLYDSzyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767966292; c=relaxed/simple;
	bh=un/mmc47M7TzaiskJcRDfyxuLNhftyXJQ1e6SZgvuK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtSVx9x6YgHyw6NkJgIKOoT2fFmJNTrDugOxD7QJkXOvb8zp2t81a4+SMec7nMLByKJo2qXqUHEpLW9kBzRc9zVY2lBJD5HKxGzs4e+8O9Amm+avi1q/gHOgmXd/OCsG/OQP2EQUt1T175a2z53yeDCwoyYjy6Jmr23CpHkW3bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNbkOVHJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNbkOVHJ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4775895d69cso21437385e9.0
        for <linux-openrisc@vger.kernel.org>; Fri, 09 Jan 2026 05:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767966287; x=1768571087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3suL/FJnULndAdzhv6eYWlf/ToXJG1zAeBlGIDXgmts=;
        b=BNbkOVHJuM61hroXQEUf4tD48fdrMj44dVqg4T6q4U9EvvVQRlOkdE8wzTCpnJaNL8
         Gu6npJEFb293fzL/xFAxCJ+kzX0X2TznpGaMsdZar5PN+u8/xx1fDi5xZpFbLKNli/i8
         A1mb20iL/2wfKuQU+2rLEAH5R58pIrqGIyUtM8ZtNUIi7GDkTgP08XTzxU8wh0HxFgmD
         0efbJUCAsnB2P+DaGvrgwfRr9DOgD4Lcgn+cKlig3+Lqtkqjfyv87dhMwirOQKBdL/vy
         IyKCi9oqm73Pk3onII2w7JOnKlHIeRuLpmyPq7sHtj6d3NUiz1mduzq3+XPCS4Lhwcbx
         EuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767966287; x=1768571087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3suL/FJnULndAdzhv6eYWlf/ToXJG1zAeBlGIDXgmts=;
        b=Til170FmvCkKLKfM3R0c3TPkcD6URCVcgrc08PRVLD7o8z3HKbvqrZEpCJHudIst7N
         IvYeZLr2YM8qP/Qm4/xZ3H9f3PK6fOxFMFt4WTtUU47Lc8mxSFXtHHsVvGtax2WC7ow/
         ApkvZXI2MAUNrm4ZN8WY7kh8iTuVxk9DR8OaW1KYfb7r1ZrVRMAZosXwE1HWMVd3ab5N
         8xDU5xMvq8Pw6CHyVIs7qsjGbqcAYs9X5qvZ1ZruFmJYWpeaNqt7RF4X/IjREvjKT06s
         qs99/Fs69P0TsYX5yJQk9UghDi3NvmXRq8UtETV/9Gbha44bVeUysquvC/FgPGzamEOn
         ty2A==
X-Gm-Message-State: AOJu0YyXGuJAeVXrWzWhVQPEJvWINsZxRHBVVPGxT8yx9m+PSJ/YISrY
	XOUJ2ORrA6XhZ3hyByI41U6v0I5yT1pcwWuO4WeRJ8CCQo3l+G4KzsX/
X-Gm-Gg: AY/fxX57r77N/QjvRSSMVGUbVH+nziHApJuFQYTvqei/Bk6/FR6A+FCqCFrCbHop9ml
	iVWJnGWxMwIcCYcNu0ggA/BkEu0NTlsLhRYLT+BK9/ynOVj3PK3IKdmcTxD5ThUEQ/hLu2PTxG/
	KReY7mcUo5JfuyD4+1w9qi9PhoJkrvYv3Tz8SjCDmEDMFZ7IG9q7UdbqfmaCzknALuB7owOF1Mc
	uy/IkZtTYEz2DlrK4JOvb6efwrVZKYvVKKxuxlTTiN9NwdUdKrBqjFFGi1Od0J/ZOVxtonMaDD+
	sG5w31fruNYs35FsEG24a2PI3CJvOqye2Y9kTJMJyQHVC5mKStF3DnMhgfMrjIxxeuRFYeNbW3y
	m+nKoIfxzvG4EkK1/uOn7ADwqdWPMgKRnCONZ42R7y7T+bKeSPzRq3UupZf2cVSO3oxzOd2n2i1
	i8fUZxfiHU2HSyw89spRD7MK8/qPObdk3wqjg9RO6WExS0TZVL2c2VofTaM1apn3QA
X-Google-Smtp-Source: AGHT+IE99p/CLtv5Zj8y/txZ2Wbbjq0dZuLvZFBHO9UfljnaNFb8iqcEoGGSdqeGjdp54IRzV0pUjw==
X-Received: by 2002:a05:600c:83c7:b0:479:3a86:dc1c with SMTP id 5b1f17b1804b1-47d84b52e31mr108307525e9.36.1767966286873;
        Fri, 09 Jan 2026 05:44:46 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8636cb0dsm73838105e9.0.2026.01.09.05.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:44:45 -0800 (PST)
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
Subject: [PATCH v3 6/6] openrisc: dts: Add de0 nano multicore config and devicetree
Date: Fri,  9 Jan 2026 13:43:57 +0000
Message-ID: <20260109134409.2153333-7-shorne@gmail.com>
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

Add a multicore configuration for the Terasic de0 nano FPGA development
board.  This SoC runs 2 OpenRISC CPUs at 50Mhz with 32MB ram, UART for
console and GPIOs for LEDs.

This FPGA SoC is based on the simple-smp reference board and brings in
devices from the de0 nano common DTSI file.

A default config is added that brings together the device tree and
driver setup.

Link: https://github.com/stffrdhrn/de0_nano-multicore

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/boot/dts/de0-nano-multicore.dts | 25 +++++
 .../configs/de0_nano_multicore_defconfig      | 92 +++++++++++++++++++
 2 files changed, 117 insertions(+)
 create mode 100644 arch/openrisc/boot/dts/de0-nano-multicore.dts
 create mode 100644 arch/openrisc/configs/de0_nano_multicore_defconfig

diff --git a/arch/openrisc/boot/dts/de0-nano-multicore.dts b/arch/openrisc/boot/dts/de0-nano-multicore.dts
new file mode 100644
index 000000000000..b6cf286afaa4
--- /dev/null
+++ b/arch/openrisc/boot/dts/de0-nano-multicore.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/dts-v1/;
+
+#include "simple-smp.dtsi"
+#include "de0-nano-common.dtsi"
+
+/ {
+	model = "Terasic DE0 Nano - Multicore";
+};
+
+&cpu0 {
+	clock-frequency = <50000000>;
+};
+
+&cpu1 {
+	clock-frequency = <50000000>;
+};
+
+&serial0 {
+	clock-frequency = <50000000>;
+};
diff --git a/arch/openrisc/configs/de0_nano_multicore_defconfig b/arch/openrisc/configs/de0_nano_multicore_defconfig
new file mode 100644
index 000000000000..d33b1226e09c
--- /dev/null
+++ b/arch/openrisc/configs/de0_nano_multicore_defconfig
@@ -0,0 +1,92 @@
+CONFIG_LOCALVERSION="-de0nano-smp"
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_RD_GZIP is not set
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_XZ is not set
+# CONFIG_RD_LZO is not set
+# CONFIG_RD_LZ4 is not set
+CONFIG_EXPERT=y
+# CONFIG_EPOLL is not set
+# CONFIG_TIMERFD is not set
+# CONFIG_EVENTFD is not set
+# CONFIG_AIO is not set
+CONFIG_KALLSYMS_ALL=y
+CONFIG_DCACHE_WRITETHROUGH=y
+CONFIG_BUILTIN_DTB_NAME="de0-nano-multicore"
+CONFIG_OPENRISC_HAVE_INST_CMOV=y
+CONFIG_SMP=y
+CONFIG_HZ_100=y
+CONFIG_JUMP_LABEL=y
+# CONFIG_BLOCK is not set
+CONFIG_SLUB_TINY=y
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_VM_EVENT_COUNTERS is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_UNIX_DIAG=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_TCP_CONG_ADVANCED=y
+# CONFIG_TCP_CONG_BIC is not set
+# CONFIG_TCP_CONG_CUBIC is not set
+# CONFIG_TCP_CONG_WESTWOOD is not set
+# CONFIG_TCP_CONG_HTCP is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FW_LOADER is not set
+CONFIG_NETDEVICES=y
+CONFIG_ETHOC=y
+CONFIG_MICREL_PHY=y
+# CONFIG_WLAN is not set
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_LEGACY_PTYS is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_GPIO_SYSFS=y
+# CONFIG_GPIO_CDEV_V1 is not set
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
+# CONFIG_DNOTIFY is not set
+CONFIG_TMPFS=y
+CONFIG_NFS_FS=y
+CONFIG_XZ_DEC=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_GDB_SCRIPTS=y
+CONFIG_VMLINUX_MAP=y
+CONFIG_HARDLOCKUP_DETECTOR=y
+CONFIG_WQ_WATCHDOG=y
+CONFIG_WQ_CPU_INTENSIVE_REPORT=y
+CONFIG_STACKTRACE=y
+CONFIG_RCU_CPU_STALL_CPUTIME=y
+# CONFIG_RCU_TRACE is not set
-- 
2.51.0

