Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DEB3ACF06
	for <linux-openrisc@vger.kernel.org>; Thu, 15 Jan 2026 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768489849; cv=none; b=sQLmjE+Hov6F6TNlqPcQOH5N//bwvXvpfSXskSXzGeQkNHI44/NaHHYzuk/FChbUZ9pMwhCe1r968zhBi0zwX4qtPlk4bII6SXkFLE2gEhdwvw3VNMdA4CmGt8Lff2plTdWTANIQXgQ5wtDX1VBPNirCErRPS5ob1NF1K2MGnKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768489849; c=relaxed/simple;
	bh=QL67zO2OXNn7d293fXZUWqsB5I5Tjghhi53EjdI7gqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoMZy4htWqmQ+teQYlw6vIvc/ajzyvBlH5u7x0cVrEE4z4EFnjiVAHdlCOdopdSZnzwKw0PtAqg6bMJYNqZ76rAtKz1eT2ymk5i3J5x+5yvunnhK9Btc8/9k5C6R5Yy4HVqzRRik90ugtvodFc3e+f+urTBZ3RO1tlD+o59tMx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWvtb05M; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWvtb05M"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fed090e5fso550528f8f.1
        for <linux-openrisc@vger.kernel.org>; Thu, 15 Jan 2026 07:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768489825; x=1769094625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KyUY1CKl3fCa1LRr33ngkD0vxuK8KXOZ0/VtJmlEFc=;
        b=JWvtb05MBamycS/ROxb2C9GOaRTqsNyEzgj8yvxERVPpYjBxqHtssz43oGNrrHppK1
         x+Hgz0A20Do5YsPM5ZKoPhBLNtMQSvfeBBu0MfGFrAxS6Iv4LSwve4YK1ytWVzDkijdp
         m6kf6YxlgET7199gdWZgbryU4luh8QzQX7WIdtBWS7orgETvmkOmZjA/WuTnt7MCatTG
         oUxiI6av+xCKhr/RYE7Xehk6pIr9sANw4u2/CBg3fKU9Xv4IXuIyNHnzRC2Ht5C4Yprz
         fTNTyT8bw0DMXeyG55ZulzAn1XAWyxgv+WIXdX1LmLkQ8raLJwqms0QgMYURTau3BVdW
         j0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768489825; x=1769094625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7KyUY1CKl3fCa1LRr33ngkD0vxuK8KXOZ0/VtJmlEFc=;
        b=O3zH7f8GKbHsYdhw9kHa3N0ho9ySC5amLH6/KMu28xmi1A274vwmZRwT0g3wcUAZfm
         XmRicwv7Y4osryvRtsZNjdoxwpSdNuxvvIjcXSymonI6Pq4Tj1ocPUyLPtdmhX/7O8g8
         GU7hUyXYKV+5Lh4/xb/xjYyqdDBmbqOYnzlLDmJ0gcR0j7BxnsnuvKxdVibQcCb5ZrGA
         YPki937cYgYaOnkQJOldlvYPdH6nREbastEVnTfOtFsQgTxwPHLLkHJX3KNPTBvVu3Cr
         mp0SRrCbKiwRaqKN4XvqxlUAtHIEnQqfB/adjjmwal9y25fnsasu42KNpY9yMxy1x3mm
         5UXQ==
X-Gm-Message-State: AOJu0YwJU/DR8KTs4/2PBiSS6t3BR0a3eDEXhDWx7Qrbr3TlU1K7lrP+
	8JDYQv7RMwXRVYeJOOnVnYL1LuFycQaC5ujZE76Vc3zOvkyd7Zw4Iqcq
X-Gm-Gg: AY/fxX7o87T0jAKxq35cclCKmyP0nygBa6Eu/5gLo0sKRx9lZZW1/zuYsGPYueQmZzX
	O6OczEwiLJeCMR1f/ON73YbBmVf+6HSwp7h2UW6EjNzthTG/6Xeq54+3JIOFmex37EBEugnZbRC
	xBwbbBWBqEesD6C+jhmYGjPfKcdFs1OhyNJSbB+dnBGdTQd2W5YlXXITeN/tUvOcGsSbUR2VyTN
	RK3lYVSab/a2c04HSM8drKkhXn9qSuz/XZWQUi7rArEtdnjVDqqvXLBjwisGi0T8i3d7VHLh9h6
	a7umPhRVRo8ZzlUp2s4ZjwrC9699r9Z7JXTlEO+VIxb6JJVJnTusSQrNRUGe7Cj2Q+UxIcvvFZm
	wrw/GWNs/ZtMU8XQGmpCtzyLxS1sODVlKTNh6RHTYAcYcHekgPKFczFXuyBKNlePbHw3/zNN3rT
	w62z3HL7fX2BYpP/zakXj1ZoNcndfen2wS1pIoPRM1e8Pp79OgGFyKyoNbIX22Gp/J
X-Received: by 2002:a05:6000:22ca:b0:432:8651:4071 with SMTP id ffacd0b85a97d-4342c4ff4e4mr7932953f8f.18.1768489825150;
        Thu, 15 Jan 2026 07:10:25 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a6c0sm6528481f8f.5.2026.01.15.07.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 07:10:24 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-gpio@vger.kernel.org
Subject: [PATCH v6 1/6] dt-bindings: gpio-mmio: Correct opencores GPIO
Date: Thu, 15 Jan 2026 15:09:57 +0000
Message-ID: <20260115151014.3956805-2-shorne@gmail.com>
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

In commit f48b5e8bc2e1 ("dt-bindings: gpio-mmio: Add compatible string
for opencores,gpio") we marked opencores,gpio to be allowed with
brcm,bcm6345-gpio. This was wrong, opencores,gpio is not compatible with
brcm,bcm6345-gpio. It has a different register map and is 8-bit vs
Broadcom which is 32-bit. Change opencores,gpio to be a separate
compatible string for MMIO GPIO.

Also, as this change rewrote the entire enum, I took this opportunity to
alphabetically sort the list.

Fixes: f48b5e8bc2e1 ("dt-bindings: gpio-mmio: Add compatible string for opencores,gpio")
Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Since v5:
 - Updated comment based on comments from Krzysztof and Geert.
 - Added reviewed-by's.
 - Sorted the enum list and added not to commit message based on comment
   from Krzysztof.
Since v4:
 - New patch.
 - Rebased old patch and rewrote commit message.

 .../devicetree/bindings/gpio/gpio-mmio.yaml      | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
index 7ee40b9bc562..1b2d253b19c1 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
@@ -18,16 +18,12 @@ description:
 
 properties:
   compatible:
-    oneOf:
-      - enum:
-          - brcm,bcm6345-gpio
-          - ni,169445-nand-gpio
-          - wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
-          - intel,ixp4xx-expansion-bus-mmio-gpio
-      - items:
-          - enum:
-              - opencores,gpio
-          - const: brcm,bcm6345-gpio
+    enum:
+      - brcm,bcm6345-gpio
+      - intel,ixp4xx-expansion-bus-mmio-gpio
+      - ni,169445-nand-gpio
+      - opencores,gpio
+      - wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
 
   big-endian: true
 
-- 
2.51.0

