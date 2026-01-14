Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D231A548
	for <linux-openrisc@vger.kernel.org>; Wed, 14 Jan 2026 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768403666; cv=none; b=lgQ5Ps6dM8CILiTSE30DiuduRhCutNcikQMbMP0D0vszeaIOyuaxLMQImzJiSfalaN10+6w4Om/wSC8x/E5zArAWG+EnIMR+PAJh/gfX7xpylvXk8cGaLz2v4SMxn4lkpNI5KODn2pJgHK81fDVHvBzVaMteSi42bOtCvukj/D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768403666; c=relaxed/simple;
	bh=37ssBE3aanUugoLgxto0YwPyHpxoTGe7/lnWA6Cd1/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIzdKt4pOOzeXpL0RzndDUfukflH9Em+FWRLJqUbB/I289ToIK89DNdA+r9uSLx8FEMAC/9VGJSIVfLx2+qCt+rJeMEJnnNA4O8C84V3KIvB0BzMJukW2Sniy38G0ZZE/Of1HHwXo5Oa7ieEdlXsazMOEh5HvgdQFsyJ+eroScw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9Jr79n9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9Jr79n9"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so2531865e9.0
        for <linux-openrisc@vger.kernel.org>; Wed, 14 Jan 2026 07:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768403663; x=1769008463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M11xPiXaInwVnEMGq59nYgno6MdcMcqZX62iafSYodw=;
        b=i9Jr79n9u00iGKFtEf0KcXHdST8yKeccRGmnphWvbiYgdVVIx4aWRfxSwviqz1HT4Z
         TXGF6mBg5voH8JWrTiThPwqPIZuccqghQnXSNPF9ZOGUnwfSwOfVEprp4pSrEWtEu1ji
         uWePaAzzHVSvzts5q5NIm56+9EjTwdK4VCnREx5UhMIyKup9GgPG33/tapHihejhlh35
         G26BNX0+kwZhbHz3kR4VnFKpHJC/POJcplvsqjdsGUbgKdS3vkBtFQzmbVzWf6EnQkiy
         LLNHavHhVY6ZgMuaBv4KIeNEKL946EeuMxBl6XJuzqzPt/ULBYLHRwlyCcNTo/seSVfM
         fFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768403663; x=1769008463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M11xPiXaInwVnEMGq59nYgno6MdcMcqZX62iafSYodw=;
        b=lEu5O2qRFtYW5Ad0SkEM9sAa/3O418m1fSRvEdgDiIrSLl8IZ+kkmfVDwJsSlqvjUn
         3UXgk+Hg6Dwct3bh3utnUmZem0G5W+Yt3eNzBN1uBrJ7RSDLpK0ys0ITAXyrFUI9Q8GR
         FG9Fgtjyu8AQ6nzOUUoOeaO1X7MToomFm60RN3qCxRkpPxMVdWnx+r75o8YAOGyRNQ+/
         AEyWl7Zt8KrP1djqMiGRw8snCP+uDbGs63KfMoVXtnGFdAiOA5WFTF6JZVX6oBt+Bgo3
         ad9ikL3FGsE7wk8SonzHifyaZkTl0tGKrOVCn4tOJgWnhJn+K3aIchiPB+22UiEdC/y/
         J7sQ==
X-Gm-Message-State: AOJu0Yw78I9H+TvS/fw8CAgzzSUQgVDnTUXgIZvGcRqooLIvgsDysMg9
	Mixe9GSGF+KRvDlEeRK9G2heB7XnQ1EkJcZBAvmwrqDvi4H8Fd5D0hcN
X-Gm-Gg: AY/fxX5pmX6ewo/Zb5JOQrmPbb1P+6gZF9+Bro9WJBRccUaL2UR0mnos+da+BeUpH6I
	fRgvr8Hq7w/CZoGGgPijzOW+5rIiYZJXVjca9BjvdftPCS1JXyqwAG4sqaLYE4mEtKpPyCtnSYb
	aaWAo6651TjmeYED4oS/Eay/KViL9Ft3zx2uNOOGojXwDgtrqOOeNb8jvBkfcIp83zQgjIcN66F
	Z2GYtUWbonFSyBKoHVv4ow3wN+oMpotsUfCtA7cWlrapmCv8GNGKpqgAj1prqxKi/2xWFaQV49y
	ghKGWDz36P6vXght/yU0A81AkIabVxh/obpbzfdG2ZsW/pDRr/AmthusA1bH0uRwz6js51vs3Vm
	1t/HnSQg0Jgpx7DO+kKdY4jFTQEpM9DJCIqS6xG6/WMotK7FOrHWWS8q8vhmHW0tSWYFniIYy4f
	zitIflGyAdAyAlJIphx6PEs+uKKBq0/3KtQwS7FHyQMN4i17Al9kx32r7PbcYqblYI
X-Received: by 2002:a05:600c:6992:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-47ee3775159mr32707045e9.4.1768403663365;
        Wed, 14 Jan 2026 07:14:23 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee5914232sm40373305e9.14.2026.01.14.07.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:14:22 -0800 (PST)
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
Subject: [PATCH v5 2/6] gpio: mmio: Add compatible for opencores GPIO
Date: Wed, 14 Jan 2026 15:13:11 +0000
Message-ID: <20260114151328.3827992-3-shorne@gmail.com>
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

