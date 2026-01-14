Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679761EF09B
	for <linux-openrisc@vger.kernel.org>; Wed, 14 Jan 2026 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768403662; cv=none; b=QbnzeBVKPoKYUDRyeqjyokLMJR1hnS9cqEIoE/tlZeosHdaFZJ/NVcNnZwVELxfwuATatz2cUiPxROMrnjQms2uCFrfabAgRZs9rCW3qkCCu/HWrazKPNO28upF60+8auP5LeetokVIW+47bPl4gpMiJZGo1//1OhYG3ac66g3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768403662; c=relaxed/simple;
	bh=CHfzIK5x4XWL9/QUaUxETkAfLbkuw00XyD5/YC1qkJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZd/spO7pr4cRLyr05eEzwdS1qGH8siwhH8CegpQf5wB5PcXzpO2vsQpQesRq9lv21mNaL1FMiKaTUrqeQYz9xImXHuFtKEQP0e1e3tUHMJxM3264wib1VizR6NKJ5fbYRFwrW7sghMffrk6A6tzqwB+HSho8Ex+kYcTd0L95EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJPeGloq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJPeGloq"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47edffe5540so14544445e9.0
        for <linux-openrisc@vger.kernel.org>; Wed, 14 Jan 2026 07:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768403660; x=1769008460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YKMHDOEQHHupe6LSng+rHSyrir0wywLcfnwHlAz/xGg=;
        b=QJPeGloqkkax/oLPO7PRqGTwZujmlTOB8ZRfqI+Rd86ofrVsqYm9hOdbK5JDziPXse
         cr43TwgX5qSCoHSVLdmXA/eme+tUawRc0tnV5YVjuq2iShhbUfabAj/a4o6Jf0oaDNCq
         K0BL3tDVUFqv7Bo5tnMRikLxEwdxL3MwjqBSkmdrVXMD3teCCjcOCjt5iZ79rXMhoxf8
         5GLZjYBSUB6UerqO3C35H18h7HcwDZo13fDP+PK+okMcqoW3Rin+XuXbng6bt1MAQUTE
         HOxA6gZXfkeEG2AhSch4pad7xncnWHTS6FUS//yxMwiMxpTPKR9UgauNWAG/q6Ueo8li
         JwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768403660; x=1769008460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKMHDOEQHHupe6LSng+rHSyrir0wywLcfnwHlAz/xGg=;
        b=nTx7ijkTitSyivZe5YT0rvF8cUvX3Nb9Hc1YHVKsNkldSAqtstZVHZ/t3gRZIpi0Ty
         4lcLLyhWpFlbmgUohXW/HmR4DaeXKHfP+YoupH4QhwZhYPg1GNEhuA/bRidwOcPwJRwI
         FvSFtBal7wKAR9oFD5gFJ1j18dyWDJZNirY5VHcdrlT6i9mXdjHZIz2OjdwV2ytvQH0N
         juUSMGUvZCQChklS4uHv0McRTAvmwmDyPA/0obwW8wQEHTJjuz+j6gItLugixfZ1rj1B
         ZfCDcI8uejxuVza82AyRtpbfsOzx6/ndmCH6gzKj/Wl6XhFosOIYqjE4qFRm1E5QcnXt
         n6ZA==
X-Gm-Message-State: AOJu0Yzpreys6eUmGVvn8Zmb4L5/0vexEEPYwP6S2CyAV6jhi1RovvJG
	nirDQxUz2q6CTV8IK58DxxdCoCmYLN8MR1uxE6kReaMnAfZj+n1vzG7w
X-Gm-Gg: AY/fxX5lkThJDUPbRNGF8WuH/mvqM0XBcO01ve8SSlrFBMSGd91Be4/DKBLiD+0E/Az
	RjZJhWVpVEDt34TtA+d4GzgVBauU8qwUgXHrA3u1WqSOhT7+rE1zDVaubxyxPvgkyXoa1CW7NwR
	nkrsSlNHbWZyByJdYeCmN5k8qVOOucwZDls5qo7wHjbIg4PRN/AkJ60GfATdmy+ebPqXHfq8Cry
	q/nHDOuoXKg61t6NUsQaxBrHgniIL/rZsi/O1s2HkJwAOzp5yUaUio/9TWMqZNwv3XPWCo8s55m
	5Q47/uOOO5Ccw0wjaESEy+xDiu1JrhbfxB2/OmZ31rZt8cN2bKpvbccvIfWPMb1VejC/RhDZW3J
	/k6dlrQM+iVR1RtyC+QhLH77IVXQZ+kRgcuZjHly7ickJUtSdJzCwo3wAcmJbBj0Vi8282GPIn0
	E9BwpOf/kJ0bjfxQM7EUlnndKL7Q1z3eTPos4QqfgxKucKKpuvnqBwswq7nlcIsBP7
X-Received: by 2002:a05:600c:818c:b0:47e:e2ec:9960 with SMTP id 5b1f17b1804b1-47ee339ba32mr33334245e9.35.1768403659669;
        Wed, 14 Jan 2026 07:14:19 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432dd78f5a8sm30905094f8f.27.2026.01.14.07.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:14:18 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH v5 0/6] OpenRISC de0 nano single and multicore boards
Date: Wed, 14 Jan 2026 15:13:09 +0000
Message-ID: <20260114151328.3827992-1-shorne@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since v4:
 - Rebased the series on linux-next to allow patches to be incremental.
 - Rewrote the dt-bindings patch as an incremental patch, Due to this I
   dropped reviewed-by's.
 - Added acked-by to the IPI fix patch.
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
  dt-bindings: gpio-mmio: Correct opencores GPIO
  gpio: mmio: Add compatible for opencores GPIO
  openrisc: dts: Add de0 nano config and devicetree
  openrisc: Fix IPIs on simple multicore systems
  openrisc: dts: Split simple smp dts to dts and dtsi
  openrisc: dts: Add de0 nano multicore config and devicetree

 .../devicetree/bindings/gpio/gpio-mmio.yaml   | 16 ++--
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
 14 files changed, 390 insertions(+), 24 deletions(-)
 create mode 100644 arch/openrisc/boot/dts/de0-nano-common.dtsi
 create mode 100644 arch/openrisc/boot/dts/de0-nano-multicore.dts
 create mode 100644 arch/openrisc/boot/dts/de0-nano.dts
 create mode 100644 arch/openrisc/boot/dts/simple-smp.dts
 rename arch/openrisc/boot/dts/{simple_smp.dts => simple-smp.dtsi} (90%)
 create mode 100644 arch/openrisc/configs/de0_nano_defconfig
 create mode 100644 arch/openrisc/configs/de0_nano_multicore_defconfig

-- 
2.51.0

