Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C887F3ACA60
	for <linux-openrisc@vger.kernel.org>; Thu, 15 Jan 2026 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768489851; cv=none; b=k7KYzWixIXOspolg0U+w+qDDlebcr3UXA4QlEttms3CUqzyP/mspYs2xvnVQQ+vY7fdsDA9bYq1rUOnJlMo3mYx9tLrczstSUwMWMrmytPstv0yRtQNUR9k8UIKFgfNsHiur6XglZl26m/+cQshQNneb0a7pCGZrhvNu+JB0N78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768489851; c=relaxed/simple;
	bh=PNeDbXYo5zazX/SvVAQJ2rx4q1Th398ozEOCr2jn4yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMgO3G/X6bcVEjyjeFqeDQCfxJXHtbxwLnk15ymFKfOu2Ws7TCdySkkqnlpqBRYiPV3cH8+9PE/kmysjTqUCVs1EjClmwOViriDgU+MCCUbtU23Ljcy5K9TpFZ8kRoqbe7+kAapnQs+NLoLEBpJ+guT8I1gnpDqr4ZhJMqM2poY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfavWUDz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfavWUDz"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-432d28870ddso519495f8f.3
        for <linux-openrisc@vger.kernel.org>; Thu, 15 Jan 2026 07:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768489823; x=1769094623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hjkdMLvTnIC8N16mPSO5hD1UHrxqMiGHiKZBI0fYgAU=;
        b=hfavWUDzK1I/6VU4tmh6QTd+s9Rrbtkm2Gn9RGcimOwtwjUthhvRKmC3CGN/BdT0Lw
         BDSTvq2eGmayrMhYy3bwvr2laOYHH/m6z/7yMBp+J9sxgAthW8ueCstfdC9N6ERAK4Vi
         oaqZVpd/+kmoRUYTTGnPDNV6PmucsL4uCjbpGvCrD23pvojzgjjdzMCapaO8gYLYxQdl
         9cdDRs+3CCRill+2WZi5NuhMonh1GY+U1d89PbUkbfDA+DH7/PYePo1Xv7Bx/gmhcDZc
         i5+Ot1WCb3gSC5OvMs6b9yehdrljxq4mcVvzcoefKIJN2bQKpd85HUvboMI+2AEV/W6F
         VdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768489823; x=1769094623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjkdMLvTnIC8N16mPSO5hD1UHrxqMiGHiKZBI0fYgAU=;
        b=uMTgn5LBpK3QTcqX5LXskwo0t2dpzb+nDBBt2uLvWhuZDXRMSOEIPxEAqP9PfjQfK3
         o4ez1yIM9T4MxhF5/UT+goT8NGJl4H4KDlrWtFcVWwjpXivGuAuvM7pVyzLjO/b9Kgkg
         p7XThVq1ct8l85pBLiUsGLGZKbbu+2TNRwo/akzV4Fe0wQN45jMvXj4PVy9C62ENeDXL
         C+LvMBim414L6YuBr82PUjtl/YJo3LoTEhNq6zjRvrhLGLspm+2UHjdMOerxt75vK+7Z
         SKWD0yiJ7KimpfSBc14lFbd/QMtkWPrs+fROxHScR7uhJdmUiaeXmb5Migp3+gwHZSjU
         d13g==
X-Gm-Message-State: AOJu0YyXQePEdpy+nfb+zjXXK5FZ7dPysXTZTg4H7gC0erA/AtJbdx8p
	SlHaND04BOIYNKPl09m07T0YtKk2FBOkHdAztrz1JaQKb1cWLL1k890K
X-Gm-Gg: AY/fxX6MNK85kGTjI9e/1+7hznToQsXrNQbu9zRxwrfWWMDa0ZXE3VyMQF0xzPVloEd
	zNt5tNgH54WN1+qHENFg/TlxenuU8/5RPwCKvizyY52jkfUf8yudm1qzSgw2nNJ4mIzkgbaqUwp
	EZE1SkUu6K0gQH2kTS6SS5+e/zkyjv8rhcqSFFYu7PCcFTd5eUFB70F6UiWDzFRXtlOmcPaKeY0
	Mq4u7+I+gNNwMB0INY8rE/g3rbeJn6s/Gp8dt+9eMu1jGegeOFN3Ozs7v4smclZIAg16x8B7LJo
	vA3+lXIC2GU1v+kOZd9jJxnbrShnry3UiiFkRYxWto2tikdrL7lAoMJAaVXeQHV9ZhvpYEsI/p/
	5IHigOQq6eS1nTTL4xB0f3iPv02462CN3pjc4GOOhDDe6H0d9tMsRnM4U7wFkwPpfZX2dEQQyrP
	DqBdigZvmBL8oA63+l5oZCJJwZEN8/BSHND9gR3mhBvQ5ucJQtWI0OqgpzcwthOSHf
X-Received: by 2002:a05:6000:200d:b0:430:f7ae:af3c with SMTP id ffacd0b85a97d-4342c54888emr8651766f8f.31.1768489823083;
        Thu, 15 Jan 2026 07:10:23 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af653596sm6626191f8f.14.2026.01.15.07.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 07:10:22 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH v6 0/6] OpenRISC de0 nano single and multicore boards
Date: Thu, 15 Jan 2026 15:09:56 +0000
Message-ID: <20260115151014.3956805-1-shorne@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since v5:
 - Adjust dt-binding patch based on suggestions from Geert and Krzysztof.
 - Add reviewed-by's on the dt-binding patch.
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

