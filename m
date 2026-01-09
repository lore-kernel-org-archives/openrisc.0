Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C8E359F93
	for <linux-openrisc@vger.kernel.org>; Fri,  9 Jan 2026 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767966267; cv=none; b=hlIooq7NzMUKCUHQvvUkIGOA6bpY+Mr4+47WUTn902ImYG6DB2M9MVtl7Dcdk9r7ortRJBCoglF/nPRjQ22BE5vd/6cq3nfh1VvnIWvnq2t4DUgm3iwL9WI9v/PmI8He/fIsSsnd6rqINmdFSxyLcSZB1f9G23JF+nF4zskOpkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767966267; c=relaxed/simple;
	bh=Amxa2H4M7mvNEUmb4XToiPWm8I8kvlFU4pW+NM3AKsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VUtECyDNVB3T3y8XNjA9at2JECE+xizZ/ULlOQxWkERGaqtDjprLNT+ADBzlLtUaClBbY6rk4qrJngYwUhUjkVM5ZXEWs2EZHlzdhgOtlr3jhcDN6B3qRsH/mHwoQN8yZwb1lFNCjeOf3o8jTGFSglTDKKpNPLqakRl8LVH4tiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+MmWP0p; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+MmWP0p"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477770019e4so33978175e9.3
        for <linux-openrisc@vger.kernel.org>; Fri, 09 Jan 2026 05:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767966264; x=1768571064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yssL9BdVfcD9liJYi2aGNMU55yln4yWI0yIFd6UPGXs=;
        b=Q+MmWP0pIqcu51/Xt8U3Kg1P81o0mSzsjcAPlFvm9vioZtAnd+jCRMYlriFLqdYw9m
         9KZPbXt55GKhzeMPq+yfv/qffEB+xY1Y4EsXPmJXrLDnKl3w7txEZBpmD4iyoElm7Rp0
         xMnqFK+aTkJh8HU63Cb3/ruF+C8tg5IUmbXdkGEWkBc4r9kHJ4RkDc3um1uiGg3iDVBJ
         ICN0Knhdg5o8Mri4KIYsMMpl/hXzil6iqmW9HUAWyCW8lKlsvGHVN2oTQb8GS2UlkbLX
         B28h28YzWZ8xEzlcmM909icEtUMfKRHgatKIvpHlpAizMgQnrXpjvAcdrFOpGRuCfEUm
         qEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767966264; x=1768571064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yssL9BdVfcD9liJYi2aGNMU55yln4yWI0yIFd6UPGXs=;
        b=qA47EhJdygJc5kpkehIC14IOy6Ru6Jow7l2Kos/3S1YKXxfjAF/0LEtx6zoSNbEcy2
         iap/nqI9I4fKfrOhMcWZRcqu6OxMvMjsM/iRDm5wOKnY9f9T+G2uj7brlPoZQqCICU5x
         knlSTfnAD52KHOvoVxRtLrTHw7ib3M9crMgNwbQULXF377nN++umzFbMDc04CS8kRY1U
         MskbfNxWzXTc6d0WLIo7lBDBVWs4eAgU3iw6frcmOfPDxCglOiadidJM07jd2nxDT+fb
         EDLj/5B6cX/LBZEHJJrWigK5bwM4neMj0TKoOeL0RGn3EAjm0EFQOkbfWEF+pzAp52ru
         1Ibw==
X-Gm-Message-State: AOJu0YyqjnCdWAJVN2/gwfAYbjQfkRL2aKzBYA7VMGifrL0VcHBZR4nr
	1ZWWMCHfN1zl/tfzFE7F/EhYyvRUedhj4Qu+UPNdl5Q9boQSvhyy97uI
X-Gm-Gg: AY/fxX6CJgh1BvigHE+NeZOcFfqEIIdnHZ0eDcZNj3jvThmz0Hm/pIVf7S+swEuhqNN
	XWqIXVhIeVsOz8O9tcp/fgbSwroaw0vIFvNTwss/OYflEryZwVmxQ8fz/wHIohnnLPGf7QjqfZg
	6Qry/LT9mrmKIQ1EkekyGw8c9Hez2ASjrzxP6QjbpUBi+nY8cwCCV6kei21l3Ma2Ke3OhTSod+1
	SLjlmmeWJ28WYSNf9Jy0NYGXzmtxg/4eJGBa9Wq3c/AKDcxFB812SI50hQnaI/s8qPt6xnShCb9
	FRAyLwWho84IrXhtII6zpcyWv8EqNh4x8C/0Z7YQmi2qZQ6CGSKq90by74xTEuXeEa9Uxt90kJE
	QrmfD69JIXnoLxCc/3HAn3L8bNY6TpTEqf+cAxHd8amuLsHP19Rj/+1fomGJjnViz1Ghow9urlf
	4De+vVxKDTzZxcm+CUcWshd4JKLxL9K3jqX4N2+1ysX7XbldEQyLikXGNiPXdntCWS9i6HBUbNy
	oI=
X-Google-Smtp-Source: AGHT+IHBOLn6//N48s3vJeu9LyI8bnaLrzWC32zt6D2UIlMcgr3BMxN9i9xZbPFqbp925YJRPjNXeg==
X-Received: by 2002:a05:600c:4fd0:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-47d84b17785mr109684985e9.12.1767966263749;
        Fri, 09 Jan 2026 05:44:23 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d86c6ff40sm138181145e9.2.2026.01.09.05.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:44:22 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH v3 0/6] OpenRISC de0 nano single and multicore boards
Date: Fri,  9 Jan 2026 13:43:51 +0000
Message-ID: <20260109134409.2153333-1-shorne@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since v2:
 - Fixup gpio-mmio patch to update driver compatible list and just
   add opencores,gpio to mmio-gpio bindings.  Discussed with Geert and
   Linus W [1].
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
  gpio: mmio: Add compatible for opencores GPIO
  dt-bindings: gpio-mmio: Add opencores GPIO
  openrisc: dts: Add de0 nano config and devicetree
  openrisc: Fix IPIs on simple multicore systems
  openrisc: dts: Split simple smp dts to dts and dtsi
  openrisc: dts: Add de0 nano multicore config and devicetree

 .../devicetree/bindings/gpio/gpio-mmio.yaml   |  9 ++
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
 14 files changed, 393 insertions(+), 14 deletions(-)
 create mode 100644 arch/openrisc/boot/dts/de0-nano-common.dtsi
 create mode 100644 arch/openrisc/boot/dts/de0-nano-multicore.dts
 create mode 100644 arch/openrisc/boot/dts/de0-nano.dts
 create mode 100644 arch/openrisc/boot/dts/simple-smp.dts
 rename arch/openrisc/boot/dts/{simple_smp.dts => simple-smp.dtsi} (90%)
 create mode 100644 arch/openrisc/configs/de0_nano_defconfig
 create mode 100644 arch/openrisc/configs/de0_nano_multicore_defconfig

-- 
2.51.0

