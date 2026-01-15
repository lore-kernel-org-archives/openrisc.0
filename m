Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048053ACA68
	for <linux-openrisc@vger.kernel.org>; Thu, 15 Jan 2026 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768489859; cv=none; b=L6SDof/GwVDtCvhiSESaEJc15fuw5vk2NZ//3YhICfIyvaeJNhcZzEVpmEQLUUAKk0HsdNqdb/On+2hAeHxegaWTgKIfn9N+eYc2txPPKoVKOrGT+qFE7oHWjSztkoU7akPHNuL8igwwShAHNpU1qlElayTm4ZE7oA49YssWmfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768489859; c=relaxed/simple;
	bh=s41epkAbLG9smlbYYXWvYNaWVozGaFQ8TXpu/2hzAWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EV/rici8G5tRJGraePONl/a9hlrTzXFZnY0Q9scv+KIshh9Ts0XNNknXAEdE37Q0iLeH4thH5NQcDs6QssWWPmEluFQ2C+E3Ag1agq3Kf5H4E38ymoc0nHp7hQqD/SL0xzhn4aNHEm/4QJ1roYfwjyXG3qk1R75x+yt0sjQlvbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANeuTuKf; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANeuTuKf"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so733908f8f.1
        for <linux-openrisc@vger.kernel.org>; Thu, 15 Jan 2026 07:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768489839; x=1769094639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3u+3JeZcHRgFBFE83J1Rhnm4t9otRBPxkyt04fpaFbg=;
        b=ANeuTuKfwCK1Hh/exWlDcTd2kPghVqp/TlqH98fOHzF7tYNALZVGGHEc/egO8YQUXx
         Ot3ekhdSUDy0gJQUb6npBHh4/qu1eICOCZrNfUJU4r4Swsi5ZrUtHZxcTQpsg/gRmX4C
         +PTNIl01/ExZm7EdFwT5GMdC+W9GPpKRKgm4Pu3iV+xJXMG2ImB023eHrZGHmdgKWnb5
         zpjdKV0vw57VPso4ZABmMlpFd2KyMPkb4iLtWA18HvLTarHe3VZoOZjSLm9ogNwGFKus
         x4SeUxLfy6a3AiU9QetaoPggD5Hp0Yy/d+/qidgqJHxdOgxT6KEzQmgCnDbBqLOaojtf
         X1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768489839; x=1769094639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3u+3JeZcHRgFBFE83J1Rhnm4t9otRBPxkyt04fpaFbg=;
        b=gmO/lk52ImoIh0z+hRAjuUXdhjtMkqLjk3Iz2qDv1+yRO+iRx6/L6ZNEW6Ww9PdOHm
         Slfo/FAa4hwCyDvVaw0RLQ+0bYtoMx3Xz2lV41Sn2z9BkoW27RPiL2JhuTZCWQeoOFLm
         1jP/uO+eN4WVuXrA93HXwe0WAV/JVNmzWrpNB5A5TA3XUxmu/5/H1O4BiGSHMMlASU10
         /bjz2TEj5QMopkOfKzQ8uV1tfVg0EdNn9y7NTTHlG/wTAezAzuvucRC1pp4Mqce8EPSm
         ++mSSS1wQiHnEY0v9IPhxUamW2PBwkOa7ZSwr38hcsqSd3Wu1Rvrn4ztZVoh84WLp26G
         ZKlg==
X-Gm-Message-State: AOJu0YzW4H9/r74mQga0qbrz5/DQvOMrAlk/oovK48Sc9Y3IGWFyOlyf
	ijjiWHjyOEWcQidtds61c1CSxmmhh0/jhtx9siel/gjPWZWnHVx1EkFB
X-Gm-Gg: AY/fxX4JcFUt9KFZ3700loUw6KZwLpW2evBOMLNJgsmJwt7Pqcsw4JvFYhmlqiDwI9L
	LteyskbXpUJ7Lw24UmZv8mzEL6hmQNIpUdOJxmf+z6rqOVpqv++2MNa+dJhYgsccMmrX77xJ4Yw
	P/rOPmb14/quQRT05RnPLxSDwJE+mA6sQ0NGVU/uXWrkPyKgJ6bu17yisGb7sTSjbhrmMp4w1Nj
	RYqdLJEy3KJUVqjZQBQxgGawuv/F3Jt8rdt8Kl3k9hQG26SLPrtWo+dRbjpU2vQm1zgRi5sKKcR
	7KZ2OXPI5T2w6p+TqnyqGlz6B+dhw1GJn32FGz9fkebWdN6OjQJo3GrPkclPwY5GzdG5je7jE4p
	0SIfEKuxkgpIzlzF9Sk6rXhy4gtVcE2Myy9n9hfAkUq7HDJF+B/w+AIp7NK61/tu3nyzXg5VjXd
	iQF8iErRjrC9KlxAcxWyh6jC/tcskBE6ppDPs5u9Vb/Qj4c94ED6bFICABMZcBAj19
X-Received: by 2002:a5d:5f90:0:b0:431:752:6737 with SMTP id ffacd0b85a97d-4342c549c0bmr7370444f8f.30.1768489839397;
        Thu, 15 Jan 2026 07:10:39 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6b2a61sm6598948f8f.20.2026.01.15.07.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 07:10:38 -0800 (PST)
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
Subject: [PATCH v6 5/6] openrisc: dts: Split simple smp dts to dts and dtsi
Date: Thu, 15 Jan 2026 15:10:01 +0000
Message-ID: <20260115151014.3956805-6-shorne@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260115151014.3956805-1-shorne@gmail.com>
References: <20260115151014.3956805-1-shorne@gmail.com>
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

