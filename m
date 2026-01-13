Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432922C859
	for <linux-openrisc@vger.kernel.org>; Tue, 13 Jan 2026 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320912; cv=none; b=C9JDPSNXkEuMcueNJcNIHcJACCYF5TPOG2A9ulSiB23vYupIiu2L7pl/ie3vDhHX+oiWPhD+JABbgfCBb3S0xeEINWxE9OB5oi3luFzEKRJo+NfQJ376nnMKnOGJkqB+o5a7Kd46ydhMWnoKUkX86CzAjB4gwvd6E02MNkBzOUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320912; c=relaxed/simple;
	bh=TLoU5lWDyws1OeV7OXou1lN7fTwwTLr00N4mF7uK9x0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nV/HZGxuX21ZLhS9Fn1N4psbF8IPkuReWfYdL21TINFvKSBHWvIf/inF3tlEbFcJxUipxHGkELUP3Q+DRML93vzg5Wv5a89u5LKDlMOt2bwku2YHiBXZPpCoR7UWl5f0c6aKP76YKIKubEiuIN6KWJ4xksA2jLanA1x8gPU36QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbwZ8dlp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbwZ8dlp"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47d5e021a53so57847705e9.3
        for <linux-openrisc@vger.kernel.org>; Tue, 13 Jan 2026 08:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768320910; x=1768925710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hvtxYilHF4JVL0eXB0D64yPAf4KKBwd/NTOQX2Jue3w=;
        b=jbwZ8dlpO+NbW2m0Cdbp2Bd042UVS5eSflx4nVu4KNBG2fIeBqbFWQfw6+arzV2d4A
         1lBFdrKuBMN2QU2ViRm+cl0eVi6S8CJzjNF/wgCfjrMR695NI2X2TQmaJ0qWlLg3AKT1
         lSgP1MP3bqEgIoA4cG37+ac84/FlhP0jF7dfEOQvUhB1IXXvsT4Van9xLNfHBJa/4azL
         bkmkAK5iIffoKCMT5dENVv8GLFj9gqj7PTfd7FUdoPO9fIXL/e2MEk+P1ZaQJzSt93mB
         eVHbLbzXyMcGJl/U7BIx5Myd5/9xyp+GWZexyKy8tVr+nLKuNBbp6h4PfaS1P9lFPK2D
         UBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768320910; x=1768925710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvtxYilHF4JVL0eXB0D64yPAf4KKBwd/NTOQX2Jue3w=;
        b=YbQu926iHWTFL/bB+jfHguUrOrQv0W2hn9tH20CucZvwC6k+gv8KvXlmegY61IV+By
         +ZlSsnwFQv7OkY1rpHH8gT0ecvBT3VXBSazjm6DDfMu4BjhrlPJvFrdOlkGS9SrlBexe
         PMh0GkH/aHRYWGGxtyLzfCirwM7x+c2g8QUPcwbxC6sMreGP3IBuJU/oz1wpylwncicG
         PsTicTZTWjeC8Wxm3TZs7REajFao7mURnM6pfkJ735UbwmB2BqwaiDpR+sgNVvygt9SO
         dEbHFE4ZzfCEiK/8KlsIxn1KmIAB15YSjLPYD0jgCW+Eug5TbOkwDh59yvCJTbRlgXJf
         czfw==
X-Gm-Message-State: AOJu0Yxm9DcP+IWANDQV6SO1PxGVkHBp/1BqSSn97/EzOl0rHb+oAIYl
	EPPPIihUWFHnhfnoZ0qWAYDDk2fXpQkGUuyvT5b0Nrp4B2RppFPGY6P3
X-Gm-Gg: AY/fxX7pB6q1u2clOb83lvXpgrwaFpXGqsLc+r0XJ/HInfQOofkor3rkfYRdymM1/6C
	edSg16r6t4sEpLJE9lmrW5gBBBOl77DB/Tj3Q39dPOfa8V2mISO1cLM7q1Lu0kOTu23VGq+DYzi
	HEvwCysMiwZcyPzG4ewWed608Vn6legoIH8YEctX92gCUYI6grPAl1p7DMEMjBj5qIJayK3BniM
	UVbxyr1H6lE3ws48OSm56Ca4FDXiOfg2jNGXEEZ3nigas2DbAH1M/o1WyBcs47LHc5bwUvNoWht
	Z8i2vSvDzxi2IDWIcM0lBaWkKUFBpCnf8mi57Jks7WaIFnwbHensg5tv2aCLEEWba6KgNIpTTrw
	Zla4/ql9e4uXvnjyrnERdLQl2JuEHMnOYWpJ+Xi6FLDJEL6iF97F/Mu+8FqiGT5244DQEAporOM
	X2FMltgV+14t36q9wvfvhF9s51zLrh8Jwu9w69+R7OvwqoGCkJLXHfw9I4m2L0femD
X-Google-Smtp-Source: AGHT+IHGnmH/TbTUHTNUygniJjnxJnceaBkBBxZYIEq6h5tXVP2zWAtGpXJekrtv9xsl6fqRHOSMxQ==
X-Received: by 2002:a05:600c:4ed3:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-47d84b34785mr281616625e9.21.1768320909407;
        Tue, 13 Jan 2026 08:15:09 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f418538sm415828485e9.5.2026.01.13.08.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:15:06 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH v4 0/6] OpenRISC de0 nano single and multicore boards
Date: Tue, 13 Jan 2026 16:11:33 +0000
Message-ID: <20260113161152.3688309-1-shorne@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since v3:
 - Switch order of gpio-mmio driver and bindings patches to patch binding
   first before driver.  Suggested by Krzysztof.
 - Removed example form binding suggested by Krzysztof.
 - Added Reviewed-by's from Geert and Linus W.
Since v2:
 - Fixup (replace) gpio-mmio patch to update driver compatible list and just add
   opencores,gpio to mmio-gpio bindings.  Discussed with Geert and Linus W
   because the 8-bit opencores,gpio is not the same as the 32-bit broadcom
   chip. [1].
 - Update new device trees to use proper ordering, remove debug options, remove
   unneeded "status" properties.  Suggested by Geert.
Since v1:
 - Use proper schema in gpio-mmio suggsted by Conor Dooley
 - Remove 0 clock-frequency definitions in dtsi file

The patches add support for OpenRISC systems running on the De0 Nano FPGA
development board.  We have two SoCs which are available here:

 - https://github.com/olofk/de0_nano - Single core
 - https://github.com/stffrdhrn/de0_nano-multicore - Multicore

As I work on tutorials [2] to help other get started with OpenRISC I would like to
have these defconfig and devicetree definitions in the upstream kernel to avoid
losing them.

When I was working on resurrecting these old setup's I found a major bug in
OpenRISC SMP which is fixed in this series as well.

[1] https://lore.kernel.org/lkml/20251217080843.70621-1-shorne@gmail.com/
[2] https://openrisc.io/tutorials/


Stafford Horne (6):
  dt-bindings: gpio-mmio: Add opencores GPIO
  gpio: mmio: Add compatible for opencores GPIO
  openrisc: dts: Add de0 nano config and devicetree
  openrisc: Fix IPIs on simple multicore systems
  openrisc: dts: Split simple smp dts to dts and dtsi
  openrisc: dts: Add de0 nano multicore config and devicetree

 .../devicetree/bindings/gpio/gpio-mmio.yaml   |  1 +
 arch/openrisc/boot/dts/de0-nano-common.dtsi   | 42 +++++++++
 arch/openrisc/boot/dts/de0-nano-multicore.dts | 25 +++++
 arch/openrisc/boot/dts/de0-nano.dts           | 54 +++++++++++
 arch/openrisc/boot/dts/simple-smp.dts         | 25 +++++
 .../dts/{simple_smp.dts => simple-smp.dtsi}   | 11 +--
 arch/openrisc/configs/de0_nano_defconfig      | 79 ++++++++++++++++
 .../configs/de0_nano_multicore_defconfig      | 92 +++++++++++++++++++
 arch/openrisc/configs/simple_smp_defconfig    |  2 +-
 arch/openrisc/include/asm/smp.h               |  3 +-
 arch/openrisc/kernel/smp.c                    | 22 ++++-
 drivers/gpio/gpio-mmio.c                      |  1 +
 drivers/irqchip/irq-ompic.c                   | 15 ++-
 drivers/irqchip/irq-or1k-pic.c                | 27 +++++-
 14 files changed, 385 insertions(+), 14 deletions(-)
 create mode 100644 arch/openrisc/boot/dts/de0-nano-common.dtsi
 create mode 100644 arch/openrisc/boot/dts/de0-nano-multicore.dts
 create mode 100644 arch/openrisc/boot/dts/de0-nano.dts
 create mode 100644 arch/openrisc/boot/dts/simple-smp.dts
 rename arch/openrisc/boot/dts/{simple_smp.dts => simple-smp.dtsi} (90%)
 create mode 100644 arch/openrisc/configs/de0_nano_defconfig
 create mode 100644 arch/openrisc/configs/de0_nano_multicore_defconfig

-- 
2.51.0

