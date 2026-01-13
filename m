Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B864199EAD
	for <linux-openrisc@vger.kernel.org>; Tue, 13 Jan 2026 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320939; cv=none; b=raDlfyqjLNeiK3H3MFZ0Q9rvtUH5RcJp2Up0bEVtQgaX/enJFWBevegtGMQH2w/qlDwRUGlx8O6xuMBQOm4L8PTBtj6RrmjWx46vrPhbWCRMXahtqcFcg3/l5ogz1xwxTlsdMhRdMkR2lS794bHG4sA8/H+v2wWEZWNFxJgLcDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320939; c=relaxed/simple;
	bh=un/mmc47M7TzaiskJcRDfyxuLNhftyXJQ1e6SZgvuK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tI62Czb+4LZHtj5YEPfj0pLAQXkZMq6oTpemHSKSiu1toFzzgHpt0oOdJIpKLYMxev89jsiV7gMjZnVSAGlajUUIbIeOMGqV5mrLy0D/5cJkH+MGGahD7FNxwSZxdj9qpUKXi7jeixo/7AMU9exVYodNHSpkeSkB3jcsovUU/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NafGZAfK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NafGZAfK"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47eddddcdcfso3219045e9.1
        for <linux-openrisc@vger.kernel.org>; Tue, 13 Jan 2026 08:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768320937; x=1768925737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3suL/FJnULndAdzhv6eYWlf/ToXJG1zAeBlGIDXgmts=;
        b=NafGZAfKVuA2KsTg26aJLVmgGp07nKC+VLjLMiZiwExvTW53tJpt6oy9z5+XLueJMS
         VPTeLQ/bKUPYmg5BW0dKd87BLG+DHQmmypb/FBDVrto4ntDn1szAEuYSFtfHBXE7yEVD
         gbBkT3TxQtuXl+IPqaTQ1t0LaHkYU6GCrfxZuM6QWY/HxYmcXDjkHJZaNw4oh6qQ3Y12
         DYY3dXznLcCP1oUah2PbouKCpW/xqmYuViyynTLgAb+RyrXxaW4lon5+w720aD3XbBkY
         kLf54e9h7kdgABav+cC/QPb73WmUpu/0yalJK5I5Ts3o1M3aGh+hBYGx5y/paM5mZ6Fa
         bCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768320937; x=1768925737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3suL/FJnULndAdzhv6eYWlf/ToXJG1zAeBlGIDXgmts=;
        b=qdmc0ZWC8NCMeJfvU8ihV8qahG2QnQyu6By60hWp2Mqnawn5e9q7Z6n7K1arj7vIk0
         7dAgHWhrFxfKBn5EWBuXelPv5SBSuzhvrm1pv1GqyxBqhOpuK6OsreNexZcJkBmfHX1N
         7ZMhjQwfGkn9jWcTXQQ+oog4Ba2l8M3i7UUzrlwVRjcEmu26zFzLPU0/ju7AeDgCrHbo
         MJ6rBjQ7HDy4bbQESf5Oltk/Qi0keftsbxjy4/Ig0ekTsr8czPZ2Ve0oqX8yamrNqveQ
         LSSWLtr9bZQevrwdPUoEU45O33FkewYRRHyJZCZ2HY9AYV2uR2SBuWTjyA2FSRycaekr
         PbAw==
X-Gm-Message-State: AOJu0YxlwjPsWx5p4AIeVYOroVQi+FkmAHht9PTlIE7oJn2I1+pLZNde
	ZavBAKg4Tji2PkLl2EyPOa+WvSbT0oInanTpMXUxyogXQULey+EOWqsD
X-Gm-Gg: AY/fxX76JN/dMQhJ+6R0o1dJSiUTtw9pkfIRWdXA+wPmCtVhk3B+sUeBZQRaDgxEmSq
	fIOP3mYGew7bnkELHH2INR8/LxqNKE7YL/bWj/U/T2jPQwVQX51WMSHQHJYvBmhqxZGIccmLSQK
	4BrnWI13mjb1rtThSLrqe6MW6lEit9xH5Ui3tIW1FUWDl7MVn7gn4HHsWSP/ho1/Ys6wXmVEHgJ
	Mu3vIHjj4wI2fPe1iI8XpqCPZlb24vxJdf2F9ZsrestRDosgukRLjzBhb0l/a9SsnEZblPDsuqW
	hoKrJQkXOqVEJCbB+psXUX8FNg7bEB/+zj/B7YGoVD1qyQ3RUWWyHS/vl4joIn+agZD3WoncjxZ
	WAig66Uf0GhdxpqrIlN8cBqgS4KlNKvU8bRHYc+MBUiqZyHFPrDMr8Wxb+SP4z/GSVWpHjXLHcK
	aTLFUV9eIZalUwK3PbWj9tNAw3xMD7TMwstc+9hUB1PuGB1WhhT/wIjR+Dvdfk3sfUgGEFG//kM
	24=
X-Google-Smtp-Source: AGHT+IEUmUYkeDP+S1h3o6VFVFRiGbNpyWnRfokREMXteE+Q59STqyI+MVlOpmbRPK5R/Plvb3OZlw==
X-Received: by 2002:a05:600c:3b15:b0:475:dd89:acb with SMTP id 5b1f17b1804b1-47d84b3472amr250733125e9.22.1768320936453;
        Tue, 13 Jan 2026 08:15:36 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47edfd5cfd5sm20913665e9.8.2026.01.13.08.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:15:35 -0800 (PST)
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
Subject: [PATCH v4 6/6] openrisc: dts: Add de0 nano multicore config and devicetree
Date: Tue, 13 Jan 2026 16:11:39 +0000
Message-ID: <20260113161152.3688309-7-shorne@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113161152.3688309-1-shorne@gmail.com>
References: <20260113161152.3688309-1-shorne@gmail.com>
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

