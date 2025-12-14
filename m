Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038162405EC
	for <linux-openrisc@vger.kernel.org>; Sun, 14 Dec 2025 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765735338; cv=none; b=BhHEWpGRy7w+S7k3sP12oi7IbAvDFFLDsF/VlJ6A+8sM99rfA2ixLPiqXZfhtqQigzJ1T9vKwo8ILZRWhtT6VWlcTfptpS5IIyFNdecycOfJKg46l2+aiQYSKaWUs9w6hLzcQd5pwqbvoeg4T3YTNse+DTD+ue7F7ZQc95cj0oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765735338; c=relaxed/simple;
	bh=RGei/f5SwSEa8t13vkw1SgXDIi55PhIypHX3O9WgkHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFiTVWxP8DPkbZDGbWmywQqulZJdh59ye7sf5gL7p/h+PQmfjebuZLgvAY1NoA98tp5zMgF1DBMiiYapyqvAPmyYlcORv/FSKcFbfVUY+MlDfxArmGOuV+lEdJd2S05ooq2bmiyzqPpaZklbu54fFxXZMvgO3H8v7EcYyRzHvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U//lDwki; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U//lDwki"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so1488319f8f.1
        for <linux-openrisc@vger.kernel.org>; Sun, 14 Dec 2025 10:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765735335; x=1766340135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxEDIovWgG0RAxcrxkL5LpkDNxOzLaNzDMcC6W7//Xg=;
        b=U//lDwkiHxSjJvR2ScYBuTZH3Fba9Ch2Im0tfUvYLRXSXdjgITVstiwFYQFe/y7Bh4
         Y965nnTcLIQmc62e3OvED8aEgWvP9D7f+BSjiUS2VgqTZJun5GlJ1cR+SBRevtwo6bqu
         trWz8oFgb9ASSwaF7Za05VD7gDM9XovdojVDJSPtTNuuOR9uZcka1IOYPZP+x/poKXjD
         Q3nqf4G5PSydItvGBlb1p/1fexhKkDGIPbtFzaly/aBszmhYGLBBVa2UoMeb7zCYaXaP
         Z+6SDpGBWq5FRpEHlzg6L6FJp7g97ZuLudvpjTCdaKshgFa9TT4EdVBtHfLHAgxsZUGK
         JMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765735335; x=1766340135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IxEDIovWgG0RAxcrxkL5LpkDNxOzLaNzDMcC6W7//Xg=;
        b=Vtaj1kKb6fw7vaF5JH04wFs6znUJNmeSRDYHOGNE0Yv1PFHtsjTmSWk92PVFtcLtu4
         yzlnQHSZDEwjboBdrRfZzBaf/y3ZggpPr4omxEdTY5UmuEydD/WU4ZRQkLmsO2S4LIVJ
         OoMbBcVP5eSoOGjv5hoJiPbDz1QZSjirEsK1RQziot35LOPZ8e4mAJKsCoSRxfzymNVe
         Z14z6QL2cjxmDYyjz8pBSAqcVVilQ/4D6cWkFuFiXpMwcb5OQhN3FeBF2P4RRnJ1gRr/
         bEMknCkSV+WmItrJljp3qk6BFHxA4ZvLNOBTy77IV1vHg5122Hb7eVAV5dZD1i9UHDqY
         l/3g==
X-Gm-Message-State: AOJu0Yz6tEC6uUswfh+/KdURFd+WbM+0KypV4+QbbX47wzJzWeoyE+Ku
	AEGAHyraHBk8oAIfeM/i1NGqVYrTBbOpd28ZCkl9ppWxbea4dSAPenFF
X-Gm-Gg: AY/fxX7TrK9QD0IxTpraW1rjhS6RyCPxyBDCEdOi0NaOkNJ5tjvP5mmdyLTjng/r6hG
	/nSHOs/4NaKOiCdkAUcweRTmqlgdxsmLDNT7PH+KtQKjh7UjyRsHaEdTZDSqfzq57eMs2msNLoH
	CPk5JDX9gnYUB8pOnzgorUQlNxa5eRUslznj2dhaEWNcfPdjjKdWiA3snlfpTd4K+OPUsPRhbZS
	28/C2SHLz3RsFexMtek5HU/WGfBm0GiuC9vxFd1B0VhzFvHmpigV2K+qNbzto1eIIEhbUcROZNM
	FxJIHC/YTJrCBcCIfXGlYOhmTd5SsHac7Rqt9rBJLkOuYEP+Fz8r9MFIJhvoLnZmMz0Msr0tM2G
	GrjPxB+a4fhMmc94dn/tXpFVW8ip8kQDHssrBjzxsywhblJnjocBs134WmwQE7wzU1oR+g5ZGQd
	i54kpPxDF+KmTPm+sCvbM4Ilddgf0sGNQ2Z58j1rHAyv7v7+mvcGf7oPpYzf0MfwykqmgkCXWO3
	N/x5piECPhBjg==
X-Google-Smtp-Source: AGHT+IGgbzrdWAmi3FTKqIKUB2VW7lxYhNhaEz7HG6Q7Cw6Y9LlDIr+hAvgQGiySJ+2joVDShh4tzA==
X-Received: by 2002:a05:6000:2002:b0:430:f975:addd with SMTP id ffacd0b85a97d-430f975afc3mr1930973f8f.5.1765735334845;
        Sun, 14 Dec 2025 10:02:14 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fb7118267sm16191030f8f.27.2025.12.14.10.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 10:02:13 -0800 (PST)
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
Subject: [PATCH 1/5] dt-bindings: Add compatible string opencores,gpio to gpio-mmio
Date: Sun, 14 Dec 2025 18:01:41 +0000
Message-ID: <20251214180158.3955285-2-shorne@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251214180158.3955285-1-shorne@gmail.com>
References: <20251214180158.3955285-1-shorne@gmail.com>
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
 Documentation/devicetree/bindings/gpio/gpio-mmio.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
index b4d55bf6a285..0490580df19e 100644
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

