Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56FE34105F
	for <linux-openrisc@vger.kernel.org>; Wed, 17 Dec 2025 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765958943; cv=none; b=O7BuRtxObGRv+jwlK8cCNzVC7Y+xY1Tnj4MxXdhIntf/cFwCOgA0fKb7jGOXzk+/RHcM0oSa/K6PMFtO0rW8QOshU/UsEGZf+UOYhoTI1vNFBXGMNzxITAK3rmLTDhJGMpw3tkqDYlaJHxhUy8tY6F3oF5u5Qfs1k/ejDPXWk7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765958943; c=relaxed/simple;
	bh=WYGDwtO9eQNVNa8ZVym/Vt5s9Af72lv4Y1u8XOfzFPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDrkOFYyJXQ2L8mutT+4PmfNOQ6A1Y1Dc7yWqy3wOb37evaMVjJU0oyBeH/QHvtinsd3ikLV9EMUhocFeuQAGCm780+aAgS1w8O0R+rWpMmzrv4elGpdUw8MQagPZav/flTO6GEqRZWIMytnZ760kH/Ru6aIUucYRXh2rLP6dhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnwZvAxH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnwZvAxH"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so42914255e9.1
        for <linux-openrisc@vger.kernel.org>; Wed, 17 Dec 2025 00:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765958939; x=1766563739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNdbat0FCjuFkU/WW3WZpT0/Ox10m6+452sPx2EkmMU=;
        b=OnwZvAxHh53g7oaA2/aZE6FPlfIY0YYKx2wfwSo3lQza6vHpDCZ070Std54DpfK9xb
         /hSrFjvgPrHM96TzkBYgxjQTvjuzWkIYpTIbjxIZvfJLtvllO33zSlfv/YR6mSMwW3P9
         CuQgXGS/KVxwNr9Z7rsC4rXulpCMS5GR6hqYrhsAD68K1cf00N7GXeAGisR/m8+CkecY
         GCIYp9A2yN+tLq4JQBpEhA4ylx2Oo4o42kCG0JvwyOEES0KT/ZfRAkCW5mI1v4gd4ti2
         F2KSnNtPc9xgdOpmxrk16xD3t8ykkugKGnbMwlfIRporRpOle47MD564F/YX4qX3flxB
         vmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765958939; x=1766563739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MNdbat0FCjuFkU/WW3WZpT0/Ox10m6+452sPx2EkmMU=;
        b=m/rI7qKX1clTRsyx10OVPSTkFeLuHORuRC1+fl45AwpvB9WJusTJuMycaosn5kdYQ6
         v3wwW+MtXNlQsD6o8Vgiu8OQkh48bwSDktwZO+5b0zx7i3YXJvIyAF5OueAgh5xVlbsH
         VhilMdCc1OHc2htJ0hU0+/YkPtEmvTvOfwyzASgzsQZrnY2Ur2bez0vvut4r0XUr4ua3
         RIg3ihokicvDOMeadkgO/ua/oJmNhdPEPHs+2XxV0LUVbnUusKEvOD5XXi5vwvN/JGYD
         sA9bKvDT/rEojMsBdYMeTe5lE5DO95RExS3arDKW98WOHzO/UP/at4fNGrrxcDKbKm+T
         VRUQ==
X-Gm-Message-State: AOJu0YxjiI5gutTKz7tJ0i7za4FGSFvMc+cFDDg6HwLNEX8ztL+b7iH0
	WeQB8q2QHFmJzz9FwEEFKM9uQ7rds+tIuUQDWTcW9XNBTLJIJKmCWqIw
X-Gm-Gg: AY/fxX718dLjDEAKb1X6P3Vk3idlgMmXrvoPpKVgHaDVN0TZIygYXnHWJyDjq9mg2xe
	IRMDh5GRElQ9HFqRQQmBEMW5YmDH2Y2ocYSyPd2pVuPa/Ab4hvXQZDwFQE3gPlVfTnDM2dEFnNF
	BpF1leXLyYDYb3Acrc7bTPnhratzlC91oE6vewa/z6pa6pvGCyhYsWddx+DPG5A2R9HOipKvc3Z
	DZTOMTcMaAUECKAufd4J3O2c1d29rktxeBRZa2E+F8yWs62VV7Hngcge4GpOf/u3DAVOrC9uoBU
	j8JOCuLzzNNMIOFInMnB4HjxQLrKs/psy3GJsffBed9Oh+EN7tfRrsJgwPTMd3tdo06mMrm7czh
	PSTWVa0xsQ3BmRv9SXgMqPNef9eO9orILb59ZOkZsz6UmhV6d/at5VZJbNZDF3XeuOEnKmZNBam
	nCfWOCcDsjF32iqQ+GoA6O1aC1C8+/jwIh3Ol4hyO8Sbgf+3dG++ztoVLz/fh6bkhX
X-Google-Smtp-Source: AGHT+IGIniiX4z2xcB+HJw7rpdiF/WcO2McouN4KlikrTH48po4ehonwpvhBjzZMT7mg2YbyGVhW7A==
X-Received: by 2002:a05:600c:4ed0:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-47a8f90ea5fmr200713865e9.30.1765958938898;
        Wed, 17 Dec 2025 00:08:58 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bdc1cb6a8sm25518315e9.2.2025.12.17.00.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 00:08:56 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: Add compatible string opencores,gpio to gpio-mmio
Date: Wed, 17 Dec 2025 08:08:27 +0000
Message-ID: <20251217080843.70621-2-shorne@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217080843.70621-1-shorne@gmail.com>
References: <20251217080843.70621-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In FPGA Development boards with GPIOs we use the opencores gpio verilog
rtl.  This is compatible with the gpio-mmio.  Add the compatible string
to allow as below.

Example:

        gpio0: gpio@91000000 {
                compatible = "opencores,gpio", "brcm,bcm6345-gpio";
                reg = <0x91000000 0x1>, <0x91000001 0x1>;
                reg-names = "dat", "dirout";
                gpio-controller;
                #gpio-cells = <2>;
                status = "okay";
        };

Link: https://opencores.org/projects/gpio
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v1:
 - Fix schema to actually match the example.

 .../devicetree/bindings/gpio/gpio-mmio.yaml       | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
index b4d55bf6a285..6fcf5fd2cb66 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
@@ -18,11 +18,16 @@ description:
 
 properties:
   compatible:
-    enum:
-      - brcm,bcm6345-gpio
-      - ni,169445-nand-gpio
-      - wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
-      - intel,ixp4xx-expansion-bus-mmio-gpio
+    oneOf:
+      - enum:
+          - brcm,bcm6345-gpio
+          - ni,169445-nand-gpio
+          - wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
+          - intel,ixp4xx-expansion-bus-mmio-gpio
+      - items:
+          - enum:
+              - opencores,gpio
+          - const: brcm,bcm6345-gpio
 
   big-endian: true
 
-- 
2.51.0

