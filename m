Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0AAA95E
	for <linux-openrisc@vger.kernel.org>; Sun, 14 Dec 2025 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765735337; cv=none; b=nOIxZ/O/rNOGud3wci8UBvl67TASJ2LKaLOp1u2mIhGTRtnTpmOqn/UT3Xcm77HlM4l/SSwOAk+3VtMKgm/nuGcQNw8lNHlkwFBnWP/ztPPP5d6XTEhmtG39hHFHnyE/N0VUfB79UXt0hHUjVGO2SVmdP8WGTbqzpsal88lgOx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765735337; c=relaxed/simple;
	bh=P3TXGhCZT+rIZJpGSKbPpXIi23ODM0ebjDP4IWKQW/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U0JYYnlxfK11VGLTdp3/dAb8DKUpjqmaDDkT236GWSpqzGXvNEVxW6no/FTXWv71j07e9BTyST/Gx+2bPotIMHjP/umWuQXzWjwfYPQgkG91l0LnKBSxS5laQ9S/OQpioZf1KFNk9Xteluh3WPgacHCzY88B/gjDURpGqrwew7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrqbApE9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrqbApE9"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso11469605e9.0
        for <linux-openrisc@vger.kernel.org>; Sun, 14 Dec 2025 10:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765735333; x=1766340133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BaLVGWHT/6afngHJPtyhcSr7j71rNPZxixu9l9kci/8=;
        b=ZrqbApE9riiT5Bl844MfiTtE/z52ELKm5vs8AEFYZWPEAaDqsIVXKzYUXXS8RpdB5s
         LAdmpIEjzgGm6wNTjSpoMZcrjvcpXQ3cfctgy9MEsjSzj13ULxl0M97cQMUsUMlroS0m
         TLzKLS/xF82BavGFSyhbz54zGFf6apQPyI4LLtUES1Wf878kwaLnLs/Ed0U1KWVj5jZ5
         QOZQfdoIhZRiwHFajlUX/4Nq5wYSKKds3vElg6jTAdpfCTV0zw0/sSCeHHW3Tktcdrl2
         E/y8YanWW17wgHhkoVosgbDAVQZJYjPVFVL0qT3OnnHsRhbzfdX/QTZ5BQuC5KsWYcFw
         6a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765735333; x=1766340133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaLVGWHT/6afngHJPtyhcSr7j71rNPZxixu9l9kci/8=;
        b=P+qSWx/2GSRVEWWq1YBnMagxenU/4J71/GSbnTQwfQJZugzysgUrnsqpGF6lpvJR7S
         EWmUMUTyGv1xG4FvD/SK+Gs6lAWydAVEvTK+JobOksYaIITvTW5WTk+I9h6WyzK+RIvJ
         DOSDY+pY6x+RKYpt9sivSIIEzBarQHJT0WsEsu4eCAHz5hGCaRHv8VAAHzkz/ZhokHKS
         JEooxcaBdw8gMH171l1qy1LjYrf1OVFlzeG72Y0fZ1uU3QyYaGpbmDVbqEcojxiLx0HD
         WPit179ZXwwCJFkO60PVnU1wnFZyli93r/ajqD//lRP9lfXu3MESXnei0sM/RPSYKX7h
         fCUQ==
X-Gm-Message-State: AOJu0YyNKBodaYO9a2hY85ocHY0uuukpicgW2CsV2imJJS2DiXsNCRtU
	b7Z7BNq5PPsGmIxyfKh7EB7y75BZbp00LCweaV/ZzFYuvWxCh1N/tEwE
X-Gm-Gg: AY/fxX7pI+RjRiAOd7TSntmVyVPpQTav0UDowwXRPQS897mj+gn1uJTc0bpV54mbbeA
	8ec60O0LA/P3ovf90xkepsi8otCUm5SkHc0pgSOe7ltl48lGPobOSedUBFdiKa1+zBzJayk8OuQ
	196KcdnHTu5Uh2SBlPdg62CesNm5vQEDJxdybUzAK0rWJFyC4K+ZaFhQNH2rvjW73sq6XcXOBx/
	2Gs/8iIrcLbQfi+5uIR5OFR33P2db6gCy9JdMV5/EXBKHHMSlJ1KQQNSe8frlO2m1IF3c244fRP
	Alf/AG81DkEkWlb2klkCXKkUJeHDpTUH//QmvJXJZNR9Xu6hwZhK8fucXYvgdWEeqvFrO7ve/iv
	LHTe2/pEcUFERzYuIJLNukyz36uTb4sfY5iy/9RXS5L4z/MTkPhi1/jEWQGi023K/8lqiuzI4g4
	AlUTwROVuJMfFBrHfDgIM0RU/34+z3RFp4fRi6Ls5jgEEOlR9IRYEZuqDwzOSzPE6GhaQOkNX6+
	j4=
X-Google-Smtp-Source: AGHT+IFYrZdmaza/sQBYhBRDt4B0FE1MA9WEkCRzQUCqkcUpsLwl9B8UJ6J3Z35lY2PJnc+QbHHWrw==
X-Received: by 2002:a05:600c:4e91:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-47a8f2c2f62mr88590115e9.13.1765735332802;
        Sun, 14 Dec 2025 10:02:12 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f8e90f2sm141041525e9.13.2025.12.14.10.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 10:02:11 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH 0/5] OpenRISC de0 nano single and multicore boards
Date: Sun, 14 Dec 2025 18:01:40 +0000
Message-ID: <20251214180158.3955285-1-shorne@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patches add support for OpenRISC systems running on the De0 Nano FPGA
development board.  We have two SoCs which are available here:

 - https://github.com/olofk/de0_nano - Single core
 - https://github.com/stffrdhrn/de0_nano-multicore - Multicore

As I work on tutorials to help other get started with OpenRISC I would like to
have these defconfig and devicetree definitions in the upstream kernel to avoid
losing them.

When I was working on resurrecting these old setup's I found a major bug in
OpenRISC SMP which is fixed in this series as well.

Link: https://openrisc.io/tutorials/

Stafford Horne (5):
  dt-bindings: Add compatible string opencores,gpio to gpio-mmio
  openrisc: dts: Add de0 nano config and devicetree
  openrisc: Fix IPIs on simple multicore systems
  openrisc: dts: Split simple smp dts to dts and dtsi
  openrisc: dts: Add de0 nano multicore config and devicetree

 .../devicetree/bindings/gpio/gpio-mmio.yaml   |  1 +
 arch/openrisc/boot/dts/de0-nano-common.dtsi   | 41 +++++++++
 arch/openrisc/boot/dts/de0-nano-multicore.dts | 25 +++++
 arch/openrisc/boot/dts/de0-nano.dts           | 54 +++++++++++
 arch/openrisc/boot/dts/simple-smp.dts         | 25 +++++
 .../dts/{simple_smp.dts => simple-smp.dtsi}   | 12 +--
 arch/openrisc/configs/de0_nano_defconfig      | 79 ++++++++++++++++
 .../configs/de0_nano_multicore_defconfig      | 92 +++++++++++++++++++
 arch/openrisc/configs/simple_smp_defconfig    |  2 +-
 arch/openrisc/include/asm/smp.h               |  3 +-
 arch/openrisc/kernel/smp.c                    | 22 ++++-
 drivers/irqchip/irq-ompic.c                   | 15 ++-
 drivers/irqchip/irq-or1k-pic.c                | 27 +++++-
 13 files changed, 384 insertions(+), 14 deletions(-)
 create mode 100644 arch/openrisc/boot/dts/de0-nano-common.dtsi
 create mode 100644 arch/openrisc/boot/dts/de0-nano-multicore.dts
 create mode 100644 arch/openrisc/boot/dts/de0-nano.dts
 create mode 100644 arch/openrisc/boot/dts/simple-smp.dts
 rename arch/openrisc/boot/dts/{simple_smp.dts => simple-smp.dtsi} (89%)
 create mode 100644 arch/openrisc/configs/de0_nano_defconfig
 create mode 100644 arch/openrisc/configs/de0_nano_multicore_defconfig

-- 
2.51.0

