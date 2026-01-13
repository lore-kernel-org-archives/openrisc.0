Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF098EED8
	for <linux-openrisc@vger.kernel.org>; Tue, 13 Jan 2026 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320919; cv=none; b=j2Aa994QoswskOob9Ti1GM1AXylvi42nEFkPG+zqCGaBSzEilJSyzbxBoXcKT4/uuXD8k2i+voQtZopID5V5GWD9jAc5IPhsXaz0LeAfc+a8SKQes/79S7XJ3rZlNq36qYSBe0nzjkptNJWjBTqLgB4+ZAnWug6ALbVFsoq3PkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320919; c=relaxed/simple;
	bh=FnV3NQEZpSrckq7ZRbBQNezPa9LjdzizI84I9YL8+Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnU2FMf+xzijgFTHQFxu0+tmaYZsKsgaa91tn+tp1dpA6ecbFXv6T6OVV7UhFmE+PcNqaKbh361zturYSzy/B8q23TA+tFVv3hOcO/m9B+iZqEsTkV0A67RNkTu+rqWLesrsR9BK1Hk7ZS2rB5FhuFi80UBGB7rcpeslprPZEyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeWg//FZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeWg//FZ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47d5e021a53so57848945e9.3
        for <linux-openrisc@vger.kernel.org>; Tue, 13 Jan 2026 08:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768320916; x=1768925716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KrS+lv5lwDbRvbVFcdtMBkDtiHuhxyAyg1FHmuvd6Q=;
        b=ZeWg//FZIeQ5P5Q/HgM8xuUr9VaP0c++F2pn/qTYyZ6xPCAXlejHI6LudXakkiE1r/
         MWYPj/WBWKSnCDox77Wn06wfe+ds3IrFzaaYPDfNR+pNK08xZ58DBnuwtmYUhYRQ+Afs
         KCaE3xNX14mGn1AGIH3taswtS4MLJK2vE5sDAp6w0yZx7ZQywQg6SbnBRqsqQYb+odSd
         SxWVaHbnT9cSBVkaebPQaezhKrTzhCZo+32rtyFTOK6hNXrsMwVbjQhiZwPhJeswxxDV
         ASk21IRmEnWXtkSuGhhZiVX8F/F4x4ewQgXLnsoTRx++XakJ2WS8Fsrsy67A8hewUyMM
         uH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768320916; x=1768925716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6KrS+lv5lwDbRvbVFcdtMBkDtiHuhxyAyg1FHmuvd6Q=;
        b=A8vhuMRLR0g8b7Fegd5SFYq1NELv0rGzOeT0wI8PTVzonqOWhyMQNkR5PT0+oBHloF
         vPeFPneXyftf0T44BbJHDjKctJ9yMMG2NUI2xP6JlMvQRuKmV9ZS6eaUo8vUMriPcy29
         vbw6rxM7zw/D5zruHNjsdtMOIa7mJ+kNQSmtbZ5b9k2Pxy1MIX9j7wTZIAM5RkAPfZej
         mUbcpxSjKrtBLMyEFWcU7CAUVDjdSOeeAs1WTbDWDpidfffVoeLrE2rETziztGVPAv+g
         0dk31E7GYyyrpP9zJVADXF5sOIvWYwRhBfOCh6nv8MqJVMpXhUzcy7IDC/Xg26C6WxAY
         Wokg==
X-Gm-Message-State: AOJu0Ywe/+O1/J1p6m2h01lp7gHAn4Iw7Kd9M9MYottkKkMwk4LXJ3ve
	YVzES8ptaIWFk+QIeJlbWC76AeeHugsYwM2ryJjDofihn1q4p4/KoNAF
X-Gm-Gg: AY/fxX7/6/yatFwleoa4VOERzWOmsrRdTjqISJVkrPNIpGeBMM4nFG7y/NARBoEJ9m/
	aCSti6Sv8+ufmcHMmKuWpR4jNcya9uX0s8eHjuFJ7VL9JYjfnGkJeJXcSNB1tyZnCidHfqad49H
	w50AJkKUyh0J4Fa/xyPE6x7ZAV+tDN5M2SewlYAGy7FJecVz/sWhc4lGB3GgwTM4gqkpVKrNPqT
	hIei3fX25WWM/4lkhCowpFqJgQdmc532cqwELXeDMpSg+PHWnQpP4zt6Z/Adr9sBskbm/v9epSP
	xMAfJ5+9W2sDgRUclPudYADCsp2hZ2nkxLkdpl6Q3jnL+tGTq//VOsAeDTxTOqP8D5fNsjYd//N
	KGVHGa8VkCxFqPqVuuE+RIR+RN7ztzAkX58iseygF20lEea3b+2l3TH4FL0aX9hld0tt5CfbNve
	H7E8W//1lO9MUygVTr6fqZi8VazJbw9yVmHZRkymIWa8cN1lohTRDHUbfHqBzy+Hzh
X-Google-Smtp-Source: AGHT+IFY7anv3CNwWIMho0+cvlpNv8144HIzUKvGLCKenedti8elP6yPkg0qEPScLVQhzPLK3UPXeg==
X-Received: by 2002:a05:600c:83c9:b0:47b:e2a9:2bd9 with SMTP id 5b1f17b1804b1-47d84b3b719mr285114485e9.31.1768320915920;
        Tue, 13 Jan 2026 08:15:15 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacd1sm44182976f8f.4.2026.01.13.08.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:15:13 -0800 (PST)
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
Subject: [PATCH v4 2/6] gpio: mmio: Add compatible for opencores GPIO
Date: Tue, 13 Jan 2026 16:11:35 +0000
Message-ID: <20260113161152.3688309-3-shorne@gmail.com>
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

On FPGA Development boards with GPIOs the OpenRISC architecture uses the
opencores gpio verilog rtl.  This is compatible with the gpio-mmio.  Add
the compatible string to allow probing this driver from the devicetree.

Link: https://opencores.org/projects/gpio
Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
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

