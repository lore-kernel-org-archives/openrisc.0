Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FDB26CE04
	for <linux-openrisc@vger.kernel.org>; Wed, 14 Jan 2026 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768403664; cv=none; b=HODJbwxvBxGFS+sVLVK4tZOPzCnGVGb6ReFGZHY3OOQI9Idz4a/E5z+mKV3Je6VtcclyCbyJg2rSWAf7Rx36oATq7lodHzgJGrQ6k5qbEKaSuGrn5X9Su9JVY/9HLSiZy61hI7DiP0II0dY/mCFE0TKZHeyLAm75LZ7g4zixqqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768403664; c=relaxed/simple;
	bh=i1sxNWay3OrLSO3MFPSI+TEryrt2fH9KJo4+hr4Oujo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dse6nbcVJxxPAclWbHq9Fq23j8YkU/C18y19fCP5ttGD+CcvF36jDL+bTRrDebXC57vcGfaYWXBQbqC6S+YiizDPDmZzNcqLZ9zTEs3atn1spYWzc7N0fsqgLLi0015qxKnaq6Z+EoSoqA7pRve2BCEARv5FqHRiuSje5AXQ+fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2Aet/NC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2Aet/NC"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso81442485e9.3
        for <linux-openrisc@vger.kernel.org>; Wed, 14 Jan 2026 07:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768403662; x=1769008462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1b8JXi4AZ9AeOAP9TFfNlUgwjeng9UHzVaIg37xeoa0=;
        b=L2Aet/NCnTLdq96q8bIc8VeauRAU8UeZYJoRZEtl4Je0AKsqv5BdI2kEk4+UuQYPxr
         JYqiWU61wQfQZoEwplAZ0LFgONlo/zVSPpMlUNjqr5Z5H9S31YOgUY0OS+cmuiQAQPXN
         Xrrv7F3nZ5TuDCH2keAKsuhMgmXaXf1RWu6mcVDzXF0DcnUWRe4shNIdlzAZLAK87m2q
         YFddBaMybE5AQqo/pQXUc5EaChEX4Gatfg5hd1gEkplBz73Rqs7nlaim32/1he5H3GOx
         CDWVg4WS0vkW0OHE11m9DNXoLNEBhoVou9fZ35RU5MX4SlHiWZ93wruNLC+ANCQYNEVR
         o3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768403662; x=1769008462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1b8JXi4AZ9AeOAP9TFfNlUgwjeng9UHzVaIg37xeoa0=;
        b=ZffJtFodK8EEPrgCBus5Z01b9gjMAsxXZOEl9LZqHZQHjxlGzxYhvnOBKqFVf6AnL0
         KJHMAzgBILiYLqSgvbSLpfBJzi+Gbvpm2emoYv/ABvRxXpr+3vUizbrxYoqjPR9ZBANZ
         WHjJ8Orv/heIv01bokGBKVxAun1nZk0O25+QIbNBMqEoqECqrLmM7zIaNxuqasZhoeki
         UHFGZ7CKCr98UPFSrWTRauLUT3RYB7GeWhAxDA97cs6Fi0GRdPI6dDQr9pLRSMGxe/7n
         v6bYKkOu6ojCHMjIzF8NUMeD/V9R7KrDgJHbP60Qn0gJ6tY/cR8Y3czKmpDnYsCHp5Yf
         1xqw==
X-Gm-Message-State: AOJu0YzPAr2sjM/gQF6F7wyA2HUQfEyd4gwnDIBUdpBHrg5dx9kCsXQ/
	E3MApGLumuLsA1DiHxKkqpE/BF/xJpWHGpqegZjcB/wq6atoCnMTAPKz
X-Gm-Gg: AY/fxX77poOaSzJKLjGEELkdm8EwIX1dmOBpGm6LYw9ft/tYRl3fysDuKNMDFTHzTpl
	M/5sorv0QxvljfcLY2F4u03YPK+4iI+ivGtnaeEAQP4SilsvE1PyfKOVQ3+8pZfhW+/j+EL4q7b
	L8XGI2Ojxgerqi+ZaoXOx+/8v0SBnZMgZ8EeZquVXEVNPcIkz2r/E69sqYViywioRXNrwlJcntK
	fQRHn9PJ2+yKQAnLDT9KH/e8AuU5yJpw2ku+/G3jBBBOo2/vl+3QvvE11Ty90pEBQad5+vz17Ua
	+Xfh6rpOVAn4If1N4pgeWBZkqpBnejBb4B1kyRWvK5AIsjSSLNk64qt3adliyf6iXTG3qZPuFVR
	9yCdBjeW6ZaUXZsGvBU4l5/3B/nIq7OprpIoyfnmGrtmsDXxoIktCr++smaAfeTtZETO+77fJ/Z
	KxdL7e03sUIQfIg9QiGCmDWOey60hy/3s5Kk7PxUehglYiXhjK6PyOzH9fcluPtVbTiFALi2st3
	o4=
X-Received: by 2002:a05:600c:4f56:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-47ee33993eemr47277185e9.31.1768403661606;
        Wed, 14 Jan 2026 07:14:21 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee55d4279sm33909775e9.8.2026.01.14.07.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:14:20 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-gpio@vger.kernel.org
Subject: [PATCH v5 1/6] dt-bindings: gpio-mmio: Correct opencores GPIO
Date: Wed, 14 Jan 2026 15:13:10 +0000
Message-ID: <20260114151328.3827992-2-shorne@gmail.com>
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

In commit f48b5e8bc2e1 ("dt-bindings: gpio-mmio: Add compatible
string for opencores,gpio") we marked opencores,gpio to be allowed with
brcm,bcm6345-gpio. This was wrong, opencores,gpio is not hardware
equivalent to brcm,bcm6345-gpio. It has a different register map and
is 8-bit vs braodcom which is 32-bit.  Change opencores,gpio to be a
separate compatible string for MMIO GPIO.

Fixes: f48b5e8bc2e1 ("dt-bindings: gpio-mmio: Add compatible string for opencores,gpio")
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v4:
 - New patch.
 - Rebased old patch and rewrote commit message.

 .../devicetree/bindings/gpio/gpio-mmio.yaml      | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
index 7ee40b9bc562..a8823ca65e78 100644
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
+      - ni,169445-nand-gpio
+      - wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
+      - intel,ixp4xx-expansion-bus-mmio-gpio
+      - opencores,gpio
 
   big-endian: true
 
-- 
2.51.0

