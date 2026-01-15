Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFDA3AE6F4
	for <linux-openrisc@vger.kernel.org>; Thu, 15 Jan 2026 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768489843; cv=none; b=ZxPOYTU9r/fWxV1W06tt+Qz479X2mODMxFe+mS9wIFCQhwzn3mdUQ8X6NAylP+m5V26SSOhJZEwn1bpVDq5HWVuyogU2pkBmKThJ26rJ25i3+n80pc+ul3INVuH7n5ilrjyFb2EqOE+1wCtRIYDcuCzaQBTXdfkSBAyLwPRkGD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768489843; c=relaxed/simple;
	bh=37ssBE3aanUugoLgxto0YwPyHpxoTGe7/lnWA6Cd1/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvIN2RbYFEvuENEkiRn7yVGNlDW1DHjzSFCcRApM3Fq0N5pzrAUzkMBe1EBBC/M+Ty3uq2ZplV2lC1DN92CXuwxgmLJ1qZWBQwm1NQJbAACoKw+1DCra9mKkqlbUy+2lg6CBzZxPiNonJxRHTP8AY3YwbJBTghRQe0I9YN6cisw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awqxOGH4; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awqxOGH4"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-432d256c2a9so1016418f8f.3
        for <linux-openrisc@vger.kernel.org>; Thu, 15 Jan 2026 07:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768489827; x=1769094627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M11xPiXaInwVnEMGq59nYgno6MdcMcqZX62iafSYodw=;
        b=awqxOGH4jxKzmyKtx/4jGpeWy2goEGWU9FqwGpICyoFZX3OrjGqnWcZmvCm2ZoB5lo
         Q94rUkiyxftm3E6tNFPMITfwYCW6nIqofYHJilDDZQepErzvcRKmhWtC50DnHDaYwUIZ
         JokW1sRFd4m3J1HLdXJlW9MYRXEKQTGeLFZqqcDOdvDY2k/xzSNrH1NnXFiCP9FfcZAT
         DcGjOaKUodI0X0C7hsIcqmGfa/SJ12ZaVSp3BEU+Q3YblYq5NxAffJHPGkS6xGdlW1Fz
         4J2gdYae2M+fp5ggzTJjXq62VmoZOUvWcTQC7BTOkg39uMoAJtobHsRYF6efIXmssANM
         ApVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768489827; x=1769094627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M11xPiXaInwVnEMGq59nYgno6MdcMcqZX62iafSYodw=;
        b=V3jwZo/DlL74lX9oxa9cuckgOlDNSuxB0oUxHekriS01KE8RYnCiII5YqJPN7krsHZ
         93bkSZbbID7hVrz6lJW2p6jVGElw2zF/37X5kbCvGI10RMZvpRju+UR1VpCRJ/JNEGw5
         Vu3UzpSIns5Imyzimf1N89NAhko2u3ZyN2F3ERU4KyeAMYkNSxCL3lnbSoPJJpbbvPEP
         zLO5MeUAyhH2oO1LaQGkTIa2naE639GUZV4+P8TsJLYmLyaiY5yP6mHeqnpWaVjcsU5B
         oiRK5Z9yger7ldzvqYHPNb8l+W/q7idpT1J5hkavgindpyoP5eBp5CXG3MoLlmSvobZt
         NKKA==
X-Gm-Message-State: AOJu0Yysn2BlC4FBFYGQbZLunddWOVgiAfZ6P4fzDk++r38IJPTQDH+R
	nLos70wKq9sl0vnsvw+0zsHcTMDxDRm9Dm9X+KYT/m2C3fdzu749tnkF
X-Gm-Gg: AY/fxX7gB+A/Fq3Grz9fthCo3lsai+G98j9RoNn4A5J+dqhWnqpbZwbAVizpUIOKm+H
	eJfh63kOOew0JngimOZZ056Dqk27f1wjONIwBBPhzvjZvBnurw1t6MB0NrdSoP4mjSNdN2HmHBP
	4V5ySz8UymcIHq79jEKMf8OwzCoaz5e6kuE1jnvkl6YMaLKz3b7agrdDdlTKcGCu1bZMpe1jl4p
	x7e7MlFISWltjk7se5pjpucxaJy8LsYONt3sHYTrBAyycBkJ3D8F6P1L0C3DKVAsmKIfEDNC5K+
	ZJ3N5RSJUWxPnDeGHni7vc5E3th6DjQYWkyOxpql+uJjnemhjJloCB4teDx51pSEvXD2ooqxSwD
	oU81ISs93ZTIQ0kOe29v3enOxSj6KVz8E1uMuDBXa1NjDLT/PqiU3CNXdNU3t3XncbCAbTGfUqG
	rJYn42ndA13wKNxfzt7vGx5XruiEVO/3/yoshzM4spvZIb8VTVQcRX9CAjJSEKtJ3i
X-Received: by 2002:a05:600c:a0a:b0:47d:3ead:7440 with SMTP id 5b1f17b1804b1-4801e34fd4cmr521465e9.32.1768489827187;
        Thu, 15 Jan 2026 07:10:27 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6535c7sm7011861f8f.16.2026.01.15.07.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 07:10:26 -0800 (PST)
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
Subject: [PATCH v6 2/6] gpio: mmio: Add compatible for opencores GPIO
Date: Thu, 15 Jan 2026 15:09:58 +0000
Message-ID: <20260115151014.3956805-3-shorne@gmail.com>
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

On FPGA Development boards with GPIOs the OpenRISC architecture uses the
opencores gpio verilog rtl.  This is compatible with the gpio-mmio.  Add
the compatible string to allow probing this driver from the devicetree.

Link: https://opencores.org/projects/gpio
Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Since v4:
 - No changes.
Since v3:
 - Order this patch after the binding patch.
 - Add Reviewed-by's.
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

