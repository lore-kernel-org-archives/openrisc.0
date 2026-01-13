Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAB71B3925
	for <linux-openrisc@vger.kernel.org>; Tue, 13 Jan 2026 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320916; cv=none; b=m3rSyz6enmgD5RE8eyUUa1gOYMXKWhRFIVuqs8IPoq+1gmh9A1olcHsJwri8lmWLLy4wXcOoV9JtvdzZJLOyEN119GUJpFRzQl6avKRpp3uIx/4QOGlz4s1L6r5KwG56dNI6zsX0CM8HAhebGf6Y3rm2n7ybSoB2atB7GRwKkNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320916; c=relaxed/simple;
	bh=RA2MpMFiQcW8woGky10vbDaNAxzlqZLD9Qto0cY6qXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAdyVlrKglzWgzv3Iomj8XjcMQOjzwm1U1vFvnLbux0IkqroNzjnEkCRv17Bgz6HzKXFfxpDO53O9MYVVHq5fx6QUCBNfkruuE2qenQWFRLacjH008HNaieVRFsT6r+QAMbFu7ZEgzNzf2jTLpQfmLFJ2dQrsgldsZrVqSbBSmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHVkvVZp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHVkvVZp"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee0291921so3774585e9.3
        for <linux-openrisc@vger.kernel.org>; Tue, 13 Jan 2026 08:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768320913; x=1768925713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFO76MpaV7TKA3kGHuuWwQjUOsm9CcTqHJpQLHw5X70=;
        b=WHVkvVZp2tFn5fN3VtseiKJ4MUg2bBz3rTLusO4W+lEFKP2Yx1ZXpSxk0l+3Tts4l0
         kgrgL4f5xvg8bgqt1ss7OxTbRg0kK2MA2idmBMM9ZWlsmOHJxGoHA/0cLrQXjCF4BPTZ
         lgJ3LtWMfzrt3z0/2dHULeRYcZEW2cEIAHXahwm6H/maf7DBqXm//hszdUPIlHjU6uHg
         f5YUetVj3ocJ95zdOMcwbApYj1KwOjx2Fs8DASZ+SS3MSL4PuQT469C5pNh1yuFB2DNM
         FcbB9Q9Seq79gCJPeCn+IqSo4At3FSu8CeBe6yn9yAXFdB6yLtxyCjY8f6suGJF0sK0B
         udCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768320913; x=1768925713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iFO76MpaV7TKA3kGHuuWwQjUOsm9CcTqHJpQLHw5X70=;
        b=w/4mCln0uHdZfgSlDxvbnHHz9tjaQ6yQ+K/ysnDGAHC7WcOYfhEvMDm5KpuV/VWWxz
         gWAnRqHaVgk0goWcDxnCtDH4v9yYW3oz/phAL7cSxY3h//YPvn7L4gjuMzHHEdHHWbdT
         p8Lp8JxqtFsV4YGlkIwuRMN8qvT4VgcLpLqC9EiW+btup38KQwMkgnfKVpOvPimFq/wr
         enX7MzODuf/U33YL7ch2yGd60wIFN1iH8J9v8pUJDD/PZPbhrIVIhwD1RNfPpSLV7MDz
         LjTJKnFMXiLIv4ZIb9eBYqBLj2pp7sOIRQ8beKGJfBe0tsz8pEZTi6F6j2ibrn3l87Uo
         4kaA==
X-Gm-Message-State: AOJu0Yx65Z9vApd8lK9Tw9NDwBszil0CF6uDsYyT/RW5oUBdmGTyGiaR
	5xD8Egb5hpJ7WV0xv386p8DZ7q+HAvJ0xjlgH73y9R/65P+0wjFt9XS5/albzA==
X-Gm-Gg: AY/fxX4dMrpbeemfb/0dy4utsSh5CeNMPhDtAssJfiZQq78pTGZylw2M7eduPDpbsYO
	BzGUXf1+Tyd54N99ZTcjb1reeUQemmiEUiRB3Bx+4mnd7++geEaypjoOxo5WvKHqxmGiA/eUu8S
	vKVoShrsg0uLCCmqquwkwt6mTYP1FF6iSs0nIXsofdYoIukD9X6rqYHjjaKMdAr2FDUbbmXqDbT
	0/naj/FHSGS/gTLtKby8bNUKyuMWQhecPfQeub2GUuNFv23aFQD7EsRjgD6ogPiWE/muFVB0LOU
	i7aORLRA/8Bxb6FxdZDrMLkRf9m7hTdBQ4S1Je0H3QjJiWoxbOWhrHnBaplX3POHBgjPwNPVhIf
	MN/5Q5uPbHn3Cyta46LU5S5D/lWh9V/85DwmumPOkF9TgXCSVE4HNExzQ2BLoDjGT0jPhJZCgNG
	BYpjKPo7090FKFn9T9+U8RTTFAP/3QJWt15giZDG+LUwFwLdnqrT/vgx55rmwJB95c
X-Google-Smtp-Source: AGHT+IHTmM9+1s27vLw2S1CrS8QJkz3b9Itz6K3HmIo/KuWYYIxo4nw1Xc0bBi5bp063eE8Hi+T2eQ==
X-Received: by 2002:a05:600c:890e:b0:479:3a88:de5d with SMTP id 5b1f17b1804b1-47d8f284042mr148197935e9.36.1768320912845;
        Tue, 13 Jan 2026 08:15:12 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f4184e1sm403936465e9.4.2026.01.13.08.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:15:10 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-gpio@vger.kernel.org
Subject: [PATCH v4 1/6] dt-bindings: gpio-mmio: Add opencores GPIO
Date: Tue, 13 Jan 2026 16:11:34 +0000
Message-ID: <20260113161152.3688309-2-shorne@gmail.com>
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

Add a device tree binding for the opencores GPIO controller.

On FPGA Development boards with GPIOs the OpenRISC architecture uses the
opencores gpio verilog rtl which is compatible with the MMIO GPIO driver.

Link: https://opencores.org/projects/gpio
Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Since v3:
 - Removed example.
 - Re-order this patch to be before adding compatible string to driver as per
   device tree binding patch rules.
 - Add Reviewed-by's.
Since v2:
 - Fixup (replace) patch to simply add opencores,gpio and add an example.
   (It was incorrect to specifying opencores,gpio with brcm,bcm6345-gpio
    as opencores,gpio is not the same hardware, its 8-bit vs 32-bit)
Since v1:
 - Fix schema to actually match the example.

 Documentation/devicetree/bindings/gpio/gpio-mmio.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
index ee5d5d25ae82..a8823ca65e78 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
@@ -23,6 +23,7 @@ properties:
       - ni,169445-nand-gpio
       - wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
       - intel,ixp4xx-expansion-bus-mmio-gpio
+      - opencores,gpio
 
   big-endian: true
 
-- 
2.51.0

