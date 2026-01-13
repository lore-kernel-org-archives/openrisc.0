Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5840425F78F
	for <linux-openrisc@vger.kernel.org>; Tue, 13 Jan 2026 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320934; cv=none; b=PLax3k8qruuvpLpL8zkT99P4lpfT+M1pYWLOhjzp3IczF+no64en/Tgx8sCaFMppoZAXnIGGFaA/yqnjefW9HLJ7l6XdNWNuoqClmqwHrigWr1/cemELagendw3KLVBLzxShEACdVVPaJ7NKQdOYK63AltN41zym1Nc6ysxu1Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320934; c=relaxed/simple;
	bh=s41epkAbLG9smlbYYXWvYNaWVozGaFQ8TXpu/2hzAWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSJTwNhXND68PP6Xgj0uweeLRo6aE+gdUv+ekItYeapV29fsWkf62AyN/2Cx60iffsQw9CgkNJretvM8pefCTYKVcjRwtrlEURaEDQ7CJHUm8BahlhMSH1/lPj+SxmimFx3hhXvI295+bKQd3cRz7+zEhz5wMUHI/H8oQdpsDWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUaveW4v; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUaveW4v"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so52946955e9.2
        for <linux-openrisc@vger.kernel.org>; Tue, 13 Jan 2026 08:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768320931; x=1768925731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3u+3JeZcHRgFBFE83J1Rhnm4t9otRBPxkyt04fpaFbg=;
        b=CUaveW4vjBWPZTsKNsUL4+nytLX093sNsOcwq1Ah0PaDdfmQ02F39GQ38D5mUlyYmZ
         cbrSiB7kcJnXm2WSfE845xTC+x3ZOxw7hkj7JUxyQs73ql699jvHoM7GanCmyVodZlqj
         3/V0NfDdpGx7vfvPc7AaHvJ+r3YwxkX6O8Cc4gnCigd/Jvmh6YarJlFhXB5JNAecvUbt
         BViCrP/5IvewpOi6wxOWwhznHVT3gq4HVN3wJptKBJKcTL1FR9hOedweHDjKvdWi6M18
         ZiFFXX7vW15LY9lzrIzpe4IcvwT0XdaSf3xq9qkkPE/hnwPNTgTFGZRhgu2GHMYLO5gI
         2mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768320931; x=1768925731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3u+3JeZcHRgFBFE83J1Rhnm4t9otRBPxkyt04fpaFbg=;
        b=xR5KkgeZJsOFsmdHpyB+EWjGnup3SmHwIbWRqS0IqV2DWnNs/b94LGfqTZC4e7mcGH
         UiYMics1rAlhnPHvjoHq069iU53Fhke1hI4TVKLi2aXDe1GIqutA02KdDsRrqiHTToxb
         K3zxu1mIn1X9oc02zu/1KC7fBa9FjHBp5+IKnKD/UEzpLeiLRF0F4Uc7Y7wMZpR+Uya8
         PUGYmMqFrebJsRtFIAAHPxGHYmg981CeP4D9+TIs7tNMDvA8fWqCeJivq60pIHG7UsgH
         g6Yl2XCHbJ+kqqA9CCEtWJNtrJjasNxE/FEmd+H+qnB0nTLPdzXIdMEJYADb9KN+R0Wd
         uKoQ==
X-Gm-Message-State: AOJu0Yy3eb1Zmr8aj8ldAXQOVMBU0pKQoGP/Byg7pSNo0MAPMZ8sxeZx
	8qGS4tEhiKZjmK9YDwOlCNvhBH6MilgVwWvQ1GU7az+VJLtUwoXiLkZi
X-Gm-Gg: AY/fxX7rUNQUNmINLvYU5sgmNWdMa7IxukZI2TvcxY21WHSHdol9f0Gu6/i5+CDI8rs
	8FmDiH9VvAhhVBCPhrSRlhwdK5VCSmNA+rsIPM7VXQuL+WAZEMMkMWcTVk9pZdRVNM/X8ke63tL
	0IhsO1FYrRAeWMjRtAh4bxFPs9761Ju2kEdLl2TUgny9o0kEv0e9h+67u8YWa5yrDfKC+lVaNmd
	BJEnSa4vVHjXUXZk0CfP8N6cpx7ytG9pogjMxaxPm2n5Sq/nsyFnWz1FvHZTIoK7vC1JJ+M2F/2
	NvLDJjvRQfisgicG7UZMi0VUr4N3iRsn9/Qr+Z6BNkn8ZYZcAtKpvhs7D1/NhTHhToqaTqH8Y5x
	qy0KgoBFcx/WpHLGP+yafTP1/p70TzCJlFlgQo1bZPAZ92UMa/Um+fc5eDQMDZ9AJeVXuGruvc5
	nmrRUM2PqCIyhfWfIFHJiWsbiNMuUY3dlIUsWixrvvsvlciDN4oBIbQ5Ozemnzo7j7
X-Google-Smtp-Source: AGHT+IGhLvJfxVLRGqghrhgN1dMGCIANA0QJw3+JAhwPNyMjUoAIPGjWB7rlYfend9xQbfhK4N/+2w==
X-Received: by 2002:a05:600c:4fd0:b0:477:7925:f7fb with SMTP id 5b1f17b1804b1-47d84b200d1mr257784645e9.10.1768320930358;
        Tue, 13 Jan 2026 08:15:30 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee27cf06bsm1066485e9.4.2026.01.13.08.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:15:27 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 5/6] openrisc: dts: Split simple smp dts to dts and dtsi
Date: Tue, 13 Jan 2026 16:11:38 +0000
Message-ID: <20260113161152.3688309-6-shorne@gmail.com>
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

Split out the common memory, CPU and PIC definitions of the simple SMP
system to a DTSI file which we will later use for our De0 Nano multicore
board device tree.  We also take this opportunity to swich underscores
to dashes as that seems to be the more common convention for DTS files.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v3:
 - No changes.
Since v2:
 - Sort blocks alphabetically.

 arch/openrisc/boot/dts/simple-smp.dts         | 25 +++++++++++++++++++
 .../dts/{simple_smp.dts => simple-smp.dtsi}   | 11 ++++----
 arch/openrisc/configs/simple_smp_defconfig    |  2 +-
 3 files changed, 31 insertions(+), 7 deletions(-)
 create mode 100644 arch/openrisc/boot/dts/simple-smp.dts
 rename arch/openrisc/boot/dts/{simple_smp.dts => simple-smp.dtsi} (90%)

diff --git a/arch/openrisc/boot/dts/simple-smp.dts b/arch/openrisc/boot/dts/simple-smp.dts
new file mode 100644
index 000000000000..01cf219e6aac
--- /dev/null
+++ b/arch/openrisc/boot/dts/simple-smp.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "simple-smp.dtsi"
+
+/ {
+	model = "Simple SMP Board";
+};
+
+&cpu0 {
+	clock-frequency = <20000000>;
+};
+
+&cpu1 {
+	clock-frequency = <20000000>;
+};
+
+&enet0 {
+	status = "okay";
+};
+
+&serial0 {
+	clock-frequency = <20000000>;
+};
diff --git a/arch/openrisc/boot/dts/simple_smp.dts b/arch/openrisc/boot/dts/simple-smp.dtsi
similarity index 90%
rename from arch/openrisc/boot/dts/simple_smp.dts
rename to arch/openrisc/boot/dts/simple-smp.dtsi
index 71af0e117bfe..42d6eda33b71 100644
--- a/arch/openrisc/boot/dts/simple_smp.dts
+++ b/arch/openrisc/boot/dts/simple-smp.dtsi
@@ -1,4 +1,3 @@
-/dts-v1/;
 / {
 	compatible = "opencores,or1ksim";
 	#address-cells = <1>;
@@ -22,15 +21,15 @@ memory@0 {
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		cpu@0 {
+
+		cpu0: cpu@0 {
 			compatible = "opencores,or1200-rtlsvn481";
 			reg = <0>;
-			clock-frequency = <20000000>;
 		};
-		cpu@1 {
+
+		cpu1: cpu@1 {
 			compatible = "opencores,or1200-rtlsvn481";
 			reg = <1>;
-			clock-frequency = <20000000>;
 		};
 	};
 
@@ -57,7 +56,6 @@ serial0: serial@90000000 {
 		compatible = "opencores,uart16550-rtlsvn105", "ns16550a";
 		reg = <0x90000000 0x100>;
 		interrupts = <2>;
-		clock-frequency = <20000000>;
 	};
 
 	enet0: ethoc@92000000 {
@@ -65,5 +63,6 @@ enet0: ethoc@92000000 {
 		reg = <0x92000000 0x800>;
 		interrupts = <4>;
 		big-endian;
+		status = "disabled";
 	};
 };
diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
index 6008e824d31c..db77c795225e 100644
--- a/arch/openrisc/configs/simple_smp_defconfig
+++ b/arch/openrisc/configs/simple_smp_defconfig
@@ -20,7 +20,7 @@ CONFIG_SLUB=y
 CONFIG_SLUB_TINY=y
 CONFIG_MODULES=y
 # CONFIG_BLOCK is not set
-CONFIG_BUILTIN_DTB_NAME="simple_smp"
+CONFIG_BUILTIN_DTB_NAME="simple-smp"
 CONFIG_SMP=y
 CONFIG_HZ_100=y
 CONFIG_OPENRISC_HAVE_SHADOW_GPRS=y
-- 
2.51.0

