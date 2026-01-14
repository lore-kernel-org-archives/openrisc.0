Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A131B10F
	for <linux-openrisc@vger.kernel.org>; Wed, 14 Jan 2026 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768403678; cv=none; b=ejU/Gi8iTKcKgsfMwDSjvdL9FvGL8iHWLDXkinvH3PYQ/ZIBGsgQeQM4E4jR0cTQ1O+MQ9EaL2xJDeH3XoDBp6K/kUAm0HWUbiJAmEjRPyJxW+UkXEvFM4t9qBebXPhe3ko+8k/kHS0MAacB+98HBcaJrE/jrMewvIWVnG+T4d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768403678; c=relaxed/simple;
	bh=s41epkAbLG9smlbYYXWvYNaWVozGaFQ8TXpu/2hzAWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIC99emnI9g3e4Je6PUsm3MtSVU1CrWJis7WuVWHVQfgmAsut0X2/yAdhokRZNdFObMSuyKiCM/tKOt2Sia8zmtUELn5LGvFNE9GZtf5HxePqGoZ3SLBOK7cJlqdZuHKywmjuAZGZu5fdGLQK7I6M3SrREeiGCBhiOPQCUuC8/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jN4V0PmJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN4V0PmJ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee974e230so1707335e9.2
        for <linux-openrisc@vger.kernel.org>; Wed, 14 Jan 2026 07:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768403675; x=1769008475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3u+3JeZcHRgFBFE83J1Rhnm4t9otRBPxkyt04fpaFbg=;
        b=jN4V0PmJfqQOdvtqfPnuxJkA6A7Zd7k3gWcEPAKty+pTAimGiQ479dV4XQSN79eonG
         ld0M7tzo8vR3Yp71p8b130brZRzrhtYtoiE1x2ETzTCwurOVt/hQY9ARgvhqLBkP/+Uq
         nDtZ5HKnHq7H6X2cOBJRWPWuP2RSMiO1Zw2TFcS6psauyxUp4e0AfPIHm1nogaaNX9gZ
         BaSNxlBDUPstGIOebH5ml917sh/6SZnn0wH9RRdYCQSV8f0tSkXzqqyFq+Th5hUX2kJJ
         iDOsEu1SI+Uk/UwaKDIfVzgo1j0slHF/CZUebNKg8jwQw5hGp82glEcVihy9ECHuSIdU
         9JWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768403675; x=1769008475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3u+3JeZcHRgFBFE83J1Rhnm4t9otRBPxkyt04fpaFbg=;
        b=hIcnmQz+VURDU+bP3U3YLbRjrLXCzQUvNl8mAoUJmVt9JjrzRW1rav3q5RFMX4W2pD
         5mXaA6V0siAwvxT/HVD8d+sFSGmmZIj1/tRvvQaMkyiT5JKkvorHaz3VgfAgsekt/vAX
         /9sncNkA3hYQP2TEINIb7qfidJvzr2pdf4DCMbGxWGbaMD60PMdqKZ+b2VbDJaMCAdho
         dMcvdIAy34bQrvY51KGNuWZZV/S5ako9JtUftyfna2+dSzNV4D8p0/N3rI/FKY0Vehio
         QNjgN49MOgKgttpgO4cKYntpKY+UEmNlQcPZ9hISHvdJu11Ped9PcFrYl9xwqOYWSloh
         vytQ==
X-Gm-Message-State: AOJu0Yz9eApFBrgqnbMY8o5Z1PgWC4yJYkXkY8iAvba3X1XEvUrTAaTg
	NLDSkN/NSQIOs7HSJagVvsNphIVLBIEFTrZ8Gy9An7vtrC2aRsZljUmc
X-Gm-Gg: AY/fxX7JZIoy/HqciuZhHHl/PvZbVpbGgVEd0Wiz/P+pkT7ErTNCInP9v4ud6LefcsP
	TUNXcut65vITUOHxbLxznI6B7DPaJ+jk6p5K8JVw/cW/9VIt1DOJlk80a7K1Apkir7yZX8x31QO
	eLtT4D9ff9hojwLAdY2L0MVlehAzDcKFToFhdReyO+SZr9PPVwnYVlM9e8Pk/y76L4Oitj6RecS
	+1q9mwQNGYS24BvJUUy4uw67WEL5+wDMEqq/wKzz+Bsv5AP1/rJQ/hw1fSf7mTcGLooyan3UiFR
	Ps1prSN2KAxcYsskzBHdkmxl326I71fw8KZSRqHWwDHqgb7lOajmpc9tIGftOI0O1PVy0oaTDnI
	N8WjjxbVu9AkApzazr51ZqCWPJ4UHW/qLvNE+Do7SMh2CrTTH9wBLfTay2ud3LUhYvYdC/O3sNO
	Mj3UlogI0HsHnKHhLVRPqzipb1G+qoGCdxBZl8ii3b/2SxQwbSi/Ie7iX4rxp0r+BG
X-Received: by 2002:a05:600c:c16e:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-47ee32fd6b9mr31039625e9.11.1768403675446;
        Wed, 14 Jan 2026 07:14:35 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee55c547dsm32361355e9.4.2026.01.14.07.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:14:34 -0800 (PST)
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
Subject: [PATCH v5 5/6] openrisc: dts: Split simple smp dts to dts and dtsi
Date: Wed, 14 Jan 2026 15:13:14 +0000
Message-ID: <20260114151328.3827992-6-shorne@gmail.com>
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

