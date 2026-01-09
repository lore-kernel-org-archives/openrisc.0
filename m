Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518A835BDC4
	for <linux-openrisc@vger.kernel.org>; Fri,  9 Jan 2026 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767966273; cv=none; b=Xu7Qvx8tKGXFskSNYPLVgzQBCM7xtb2TTYbCrYTEEYEGMZ+pWZytbHRr7Sck1rIV1Qb5qNbCeSx4fufaxS0N9edzGn8R1toEpnIaC5BOo8e8MYEyDZC89N3MvDK5iNwBVnpcmvf+aWh/F57tUnMZHA5oxHhspY/KwUmQsQgkLRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767966273; c=relaxed/simple;
	bh=1LQ7pgQADLkv3Q2JfJ0YKNTNCFMPBPWWQX+7eb5Jfpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngaSDNKRISl2kQYtmc5ud8KaTZI4oiI10Egh7iQRsR+R6Xx205+pB0Jwkec91AKMD6Eh+XX2QcpPSpOHCtnczryxyBoVYeHSgh0DmDpNnDEhjEQSG4vKWxzpKMtLLmwBzpB6d+iA2x1p+O3oKGr9ctOi9wedNjPQ6AQjgj88xag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T22xqPjo; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T22xqPjo"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so1280202f8f.2
        for <linux-openrisc@vger.kernel.org>; Fri, 09 Jan 2026 05:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767966269; x=1768571069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvvQmiFOUMr/XdsMeV6yI6szLxAkwyU8Gztse0HmU4Y=;
        b=T22xqPjoUng3R0/lbVqftLHXYgAkCfQn9SJwHiC5fAy1/qCs7D450jYCl3UW1zjeHy
         RZ9JTxonquhy3i+wQZJQ9/ndBGBuS2jSRINlJLj5Bj/2RkrfVcqs31laj+PDzfnESoBq
         FUs3irdpEZ4dSCGtLxTfOGfrasm6ICBTK9o7C8kD9g8qSYj3bdFb3yf0xJWYvdDjS3ao
         IhZMadggx/q87TczZtxQIHGcBDZ89GR+b9y3zLCTbYZSJHDIeBqTCES3yLa+ISRS0waH
         47Vf/ThVhpohJLwOsNO+HXGHZ4wPv+vP50ahkaufIw1ZwpHpuC3nk/RViYvjj6KSfm9k
         XzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767966269; x=1768571069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SvvQmiFOUMr/XdsMeV6yI6szLxAkwyU8Gztse0HmU4Y=;
        b=S+iuMHiiaBtWinwHHv9n8nMvc1eqdoeizdO3I9wAZi+zxl4TGR9LpmUldJgdBQ2IWr
         ZOibmVyfmCcTQQuzoFHraXs0J0Xg9ygglzV3JKTOxFfJ3nRASftqLDwtYgk03lSYnFSv
         VfSjdXN6ajKcuQs6fQ9Ehi216XjYOW6L2nGtM/ZHzUFsPOGKfTy9rv2XKZJI5g76EHrl
         lxoapBfOh7yWj1hhODRSGRi4b95y05VJOxgyr+kuqmcm480nbSLgJVlGi/EzN7Zp8UJ3
         Rk3WR3Np4gEo354sTt5pd2yEUT0Ny34KwHenSvFMjrpp3F2Dhbe0Co2wO+deMSoVigs7
         iuLQ==
X-Gm-Message-State: AOJu0YwhYR2au7/H8TsJe2weA2j03+QrZCHagdpIeua8fwionfxC7QS9
	jksfiWRZBdOSf+gVjN2629AQCuHb7B9nu5DwYItxuUN1U3atzz+Z+Sj5
X-Gm-Gg: AY/fxX6qvD0iSi+4+OsRUZjDBbT9Tu9cTzDllbzbd/5tlwxFp+SIwWRv7TxpsGn8zdb
	u6LHC5HHsOMhWSebHkHkLNrllMBflChRXyTi4qBVWOHy7suUQt2DnMtlkGiY0+AS20Kfqa4eqs1
	2nvLLTL/ox18a3PCfvypWeq5p71FQn/NTt1Vp408OLLqdp+PRHr67M0Wewmn4E9ZcPmE/FhiQ25
	HsQL5e7UTilf1IAIN/+NUPhGF+OAuSmm+x2wJNPPZcHe8O3ycncPfc1IXqzND5PYDYFXA1HaywO
	vmjcxxw6mloMrX+9mTdkTWn0CoKOpNGR4xM22JhlIylGNESilYF0KY8bGaxzP/tDibnv8zR/tr5
	SZwnL7pxTlwWCMWBv9FIyXUlhTMehyKRvUZFMEcT1fdpBf1vX/i3uhuzrjoGj6uBsbGfo0zNzXb
	997SNtDxO85I2uZUvdNe3ENrb24Zb0bktri6JRoj+auEAWg6CjZxZW47fQY0B2haE5owJ84QHrp
	sk=
X-Google-Smtp-Source: AGHT+IEcyqPvQXXgSb8upUybhhoHWlS++tR42ZMn0J3rAkpHIq7i7iKiZeRqR+4mcCGlOkEYTV7yLA==
X-Received: by 2002:a05:6000:420f:b0:430:fc0f:8f9f with SMTP id ffacd0b85a97d-432c37982f5mr11382930f8f.37.1767966268426;
        Fri, 09 Jan 2026 05:44:28 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5fe83bsm22896047f8f.38.2026.01.09.05.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:44:27 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 2/6] dt-bindings: gpio-mmio: Add opencores GPIO
Date: Fri,  9 Jan 2026 13:43:53 +0000
Message-ID: <20260109134409.2153333-3-shorne@gmail.com>
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

Add a device tree binding for the opencores GPIO controller.

On FPGA Development boards with GPIOs the OpenRISC architecture uses the
opencores gpio verilog rtl which is compatible with the MMIO GPIO driver.

Link: https://opencores.org/projects/gpio
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v2:
 - Fixup patch to simply add opencores,gpio and add an example.
Since v1:
 - Fix schema to actually match the example.

 Documentation/devicetree/bindings/gpio/gpio-mmio.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
index ee5d5d25ae82..d44edc181e0a 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
@@ -23,6 +23,7 @@ properties:
       - ni,169445-nand-gpio
       - wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
       - intel,ixp4xx-expansion-bus-mmio-gpio
+      - opencores,gpio
 
   big-endian: true
 
@@ -160,3 +161,11 @@ examples:
             intel,ixp4xx-eb-write-enable = <1>;
         };
     };
+
+    gpio@91000000 {
+        compatible = "opencores,gpio";
+        reg = <0x91000000 0x1>, <0x91000001 0x1>;
+        reg-names = "dat", "dirout";
+        gpio-controller;
+        #gpio-cells = <2>;
+    };
-- 
2.51.0

