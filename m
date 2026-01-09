Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F3935BDC4
	for <linux-openrisc@vger.kernel.org>; Fri,  9 Jan 2026 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767966287; cv=none; b=Z49u3KnxF9JH/2i/FvROd/QhvvohM677Bn7F334mra47mKKBTQ2OCd2uACmfBB+NLC3GaaswbXXbGAYR5SP4UcMki0Hm8wHBb0TMJlYrWptBhXM3nSiNSmDuwySMqO2DdestQoZvKidqf7WcSOQnbF37qJGjCLoMEICe6sVWrfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767966287; c=relaxed/simple;
	bh=Jk40KbzqIx5hqF0fGScSRmcvuwcowCOVTp3y98D7ttI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4Gfex/nJy7wSzYUigPg3ekYUwua3EVMZ/uplfPloCPbAIMig2u43BHTfUaUtDy9piP2VcXsWGRjedKjQcUtnTkP9ToprkL0X9hvXXy88uyM/U7grCdsOrUcb0fXXyewyCERv35/K/4LuBNbV8X5azDdpRRxpke2LfZDddLRX5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJ3YcSoc; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ3YcSoc"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so2388462f8f.0
        for <linux-openrisc@vger.kernel.org>; Fri, 09 Jan 2026 05:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767966281; x=1768571081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9KAGzffhLwgZtEGqvIhJp5ztHd8BXXtK9/Mqf8WQC8=;
        b=LJ3YcSocsEsEkGjlvzW+uZB01JuFHctd7FcBaKMf6eW0CsYI+W6IJI8QH2TflzOeZY
         Qn2wG/iemt9HN6Hw0v5rsCkTOZH8eF4mhnR9iwy+73PozUY2QPgxSiSdM1609C8vcVdN
         IlwD980EDjH6U4GWHhsV3dIhkAVowBhIQb5t4BjQ3O6R4NtUfBxQNXhY4F6S5zGtJ8R8
         L5FCBgGn3bX6k9rU9mSdXU84ZwLOYtmioYfijrUewHt+1OShPx2RbpRsAa32sathP3g8
         SjnJ8Y0SX+v6Hb+itwHFUKF3Nx3za6yBpOrW5G/4G8+3pU9ERAuZSFxRn91l4sE1pIaN
         P/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767966281; x=1768571081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h9KAGzffhLwgZtEGqvIhJp5ztHd8BXXtK9/Mqf8WQC8=;
        b=rOEyu85v5uYbb57QWsoK7LOthm9kHSpOWMXOIgL7X2zJYjXED9aapNJYqkhlJdGWsJ
         Ofzdco5mBewxN/2rNkDTZKKRzXMCPUo9iz6vRBHKNtS+UuxIJSY1H8sp7zu7w8EtGTGX
         wGu7mdDZHbIUGnlNJ4/KpSpyC2maXCbTVyR0t5mhG/jjL2RznZwwn6am/ziNz98S8J5b
         DNj66p34np2463mKaHCo2Aw5EsFzJU47XQDLyfoqGlD4BPpDUnOZiHNlLR+Tx4IDdaaW
         ZAzrr7hijog9xWx6pLIQp5nEfMuyuCr1odRcWmE13pVTS367MofOi5fJzxr895QeE9Oz
         xUvQ==
X-Gm-Message-State: AOJu0YxIyknj98Skq3ceH15ISOIZbzpRDNT/H8ZbO+xk0CMw/xSLG+6e
	EZw9cLiv+QTW67vtHFFteTJLxzoRjfT/IgAn9yxGl2XNB0y77jEssKGh
X-Gm-Gg: AY/fxX5MDcVZALNCRiHaf/p7NHxGUCh3W4n/zL6yZdxGax0nsrAG0g/Fm38TIhg90Uk
	O5/vp71QK4F8EJGRE7YKVAG6jpGxg16q6wZIGDiIRqqY6fY1+JCEghmXzXDQsLDTf5ST1dBJL6r
	OgMhHrntbVsfwIozFh20XNphJd1chB77VfqSDsPGyINmF5HBognqyJ7ksE+HU//cG46S9LdWCh6
	Ovt6Gc7i6X57ALrB10VKv+sY0e7kk77nev8WkiMQFbD4a7PkgZKgolpQYu8uJWKfHYp+0mGrgge
	RzEd4pv5QlaoXikTApbnPXvoCc9QZXkU8WMUwvtVZiL55RDLv2IKClIHxvAzgqUE+08duiCjbkQ
	rBDQkROuGIqOFdOR6YHIs1gQc3XRxdnixX6tYI6H/KSE7B/DqbLRzozaIOVFLS8zOlV4/VSx0jJ
	IVVLqM37CBDpmj8eUUiXDuWEnn4b8W6ALQO7WINwxkVZhkuV+ljwvpAfVzP1OouxPJ
X-Google-Smtp-Source: AGHT+IGM8KlvuOEj2l6wbPBLsHAhqqd75ebW2krjPuvGemmsc0Zci5UJFpJTLkAibIHRVq3tqoO+gQ==
X-Received: by 2002:a05:6000:1448:b0:430:fd60:940f with SMTP id ffacd0b85a97d-432c363351fmr11796354f8f.14.1767966280954;
        Fri, 09 Jan 2026 05:44:40 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dadcfsm22392537f8f.3.2026.01.09.05.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:44:40 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Masahiro Yamada <masahiroy@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v3 5/6] openrisc: dts: Split simple smp dts to dts and dtsi
Date: Fri,  9 Jan 2026 13:43:56 +0000
Message-ID: <20260109134409.2153333-6-shorne@gmail.com>
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

Split out the common memory, CPU and PIC definitions of the simple SMP
system to a DTSI file which we will later use for our De0 Nano multicore
board device tree.  We also take this opportunity to swich underscores
to dashes as that seems to be the more common convention for DTS files.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
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

