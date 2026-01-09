Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1535BDAF
	for <linux-openrisc@vger.kernel.org>; Fri,  9 Jan 2026 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767966269; cv=none; b=d8mblUidsZd73bIT54OJEHovZw3XqH+j2xC6YF9T5Vnu4yZTYWSgv4iOoYZBN6L1FESpHjZ56qWn1AvidP7eZCRzRwcKeBt+JuXQCS8aFqfFiLKVSxq75/IlYxebhFsgak2GaSY9nJ1jpNU/opvjs8OsFhzT8PLPPYJYwiaWctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767966269; c=relaxed/simple;
	bh=jf9GAe5/XNqHlZ0uwLx04THFw3xzh+ejemb3PhLVe2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mX6DUjnSZmzUCse9qsHpTkgaCIc60cz1DuGpUarS/ut1sQ5z2lVBi3CEHzDao7fhfeAeXkoEB+yPcs2MU/05ydNQEtzrACCZFqul+PNDoqNOHm67gMW2zN7F1j/xYCdjnkdghSL+BpDV0tCtZ5e1argZKEl1/9nf8HsPG7adNlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gke2i48I; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gke2i48I"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so3686315f8f.3
        for <linux-openrisc@vger.kernel.org>; Fri, 09 Jan 2026 05:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767966266; x=1768571066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vV3VW4TRk7vZrwF4cTlZDuh2FMXs4uwC6OYZ3cT/LdI=;
        b=Gke2i48IcfjM/bRpfxBtqVu8ltAGYvhcufgkZ3Zu4eVnd9Ze9rj8brM6F73LutVCR0
         NT4VZAg/Z10756miBhKhvCnMQ+okCN0j7ZvqUM/DYMt1Er82BoHAKJfgfgRZBE36qw7y
         uQEgOphk/A5Ib8iy7jO3A18XHuoUGKC825chLrKYlidA4UO1YNAELi4ZMu4VJrFmVUaI
         lJrFLnT+U8w79/ex9HeVuOFrnPMUtF3Ar+RXKN5E1fpCB7f4ZDZfj4OfvRw3xxOc80IN
         s+QShDtWiQTwfLCC4wVQXron2aMWhovuqsM3x6Vhh9rCUJlXeTfd+mYx5IHrAw4xpJ3K
         +itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767966266; x=1768571066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vV3VW4TRk7vZrwF4cTlZDuh2FMXs4uwC6OYZ3cT/LdI=;
        b=tSXeKArY7FcsstDtHYvBmOCMw4fT/aqTXEwCEbuF/ZRkZ719AfdUWaxJK794nAstGL
         MjrbOdOQYfDUcHErTgmcMELi2nX2BKuK8Oh+4XmfeQFxhG1WdBNz9SGukmh1KLq5GWjG
         6+76m4G4DfUy+RQ60hDJl+7uCPi1RtIYCwgXFooiRG35kypAtET3tP1BgTBcpAABcFgt
         Gz8MnEZanGVsvkkZIZpXmHEIHdm75MXXMG5c71yQeVc3IMh5VcJ85PiBiVdNSxB4BZCh
         TPGn81cvtM9OGEXMU9fsnxLkj0wsnYBEwXPprWmsi8ZC+H86YOHeUQNMD5TyCpi7WXY8
         T0bg==
X-Gm-Message-State: AOJu0YyZcPdVBiKY0YVNlTqlRUWlAyAloe1Xf/p4LzJjlnb5OCLi5lKP
	bat9r1nBsCfjX1QbgC5puGGBDSRc9V5JuUPXTterwdTS5HRxKYNcwe2j
X-Gm-Gg: AY/fxX4FZPz8B+IxvTgo/caAysJWB3nyboVgoLAtgrcWYX9mFGC7IOQp7fUu3mxc05/
	TbG6D5i1AG5/F9TrXurv+su8K+hpR5GcSG8gIeA2PFPSwfcMTRpdI3f6HJcIDuUduRFTXp2CXNL
	QzHIZYIdSnswdpnz+yTet4HEL/krUpkKBQLue6XqNovazcp02mWkxoonfDbe8t2KSvFnuZRUUgF
	gJQvgj8ZZZ/dpeTXQxZ54yj9ufASpRQ8WkbHejPx1sG1BKt4QVIDLDvWKIiIo6KC/1oYnsWe/ZW
	PVU61vbWGbU70SdxYmWEhdDd7JuJbG5YQEH+35EeYVeu/QTD/4L/b53jxYP0p70k44YHmXDvudU
	MiEs41jRkQ0SRsi/USXtd2E+wKUsvzfbCFR3TuK8yPlql0o+S3DahA2263ZUsKDyBUsMc5ec52S
	+aoKuTxk/Bj+4/0V5eswX3/QEafkpT3p6MpriXeqbkXgUgtz+b7ZQRkbjUhAL2mm4z
X-Google-Smtp-Source: AGHT+IG/REh9ssKpIfP140JT4H5xk1mVz4P63JNqcaC2JTUABJbr0Ck3OTN6x5dTXPTtf9t5owUMcA==
X-Received: by 2002:a05:6000:40cc:b0:432:ddce:284c with SMTP id ffacd0b85a97d-432ddce2b0emr1487056f8f.17.1767966266056;
        Fri, 09 Jan 2026 05:44:26 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e19bfsm22111616f8f.18.2026.01.09.05.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:44:24 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-gpio@vger.kernel.org
Subject: [PATCH v3 1/6] gpio: mmio: Add compatible for opencores GPIO
Date: Fri,  9 Jan 2026 13:43:52 +0000
Message-ID: <20260109134409.2153333-2-shorne@gmail.com>
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

On FPGA Development boards with GPIOs the OpenRISC architecture uses the
opencores gpio verilog rtl.  This is compatible with the gpio-mmio.  Add
the compatible string to allow probing this driver from the devicetree.

Link: https://opencores.org/projects/gpio
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v2:
 - New patch

 drivers/gpio/gpio-mmio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index 5daf962b0323..edbcaad57d00 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -724,6 +724,7 @@ static const struct of_device_id gpio_mmio_of_match[] = {
 	{ .compatible = "wd,mbl-gpio" },
 	{ .compatible = "ni,169445-nand-gpio" },
 	{ .compatible = "intel,ixp4xx-expansion-bus-mmio-gpio" },
+	{ .compatible = "opencores,gpio" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, gpio_mmio_of_match);
-- 
2.51.0

