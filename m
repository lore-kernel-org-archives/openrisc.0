Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8C4340DBE
	for <linux-openrisc@vger.kernel.org>; Wed, 17 Dec 2025 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765958939; cv=none; b=IOC5cUwE3hPbaYLxE19qRdQ+0Qkk9ooKlXWVCTEt9+7IteDMNtQaxKQNOr/Kzi3jJJQz+LoUlrPUVIDwpfXaVUQBrsBrBtp1N4o9HfPeB/bjF7jCou6y+IM1P/AGO+MfFgfzkNwVi29aH46yVaNN/A2ERoPEmoHvBM99Ad1gMeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765958939; c=relaxed/simple;
	bh=9GXdb++mBgfHhLSUuUJeimiIv2M7AqOK8vxaB/ra2Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cbuGqvFk6/ZMlqoR85r0eIQALbUfiBM272/AAmJc/JgDRH4Blf3bz/GDUGxhLXIFL9Njyc+AmgKs5/xxKVYl+7aR99vBWacK9Na/NrtH+vtE0671n78VERqSuMFznomgmh8zBR1LvYO5WYIJmWIcO53xJ3tjl269bFdzowCMa7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqqTLza6; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqqTLza6"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so2653197f8f.3
        for <linux-openrisc@vger.kernel.org>; Wed, 17 Dec 2025 00:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765958936; x=1766563736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hntdZ0AL8tO1hGhDChLTEPbwkSJczkq/EoSmNVJXeRg=;
        b=BqqTLza6ztLY18aJBPkB3hDFzJ/KXe6DDK5liAaLhINwod+DGT5AWprCuMjUE3GBia
         v6DysndOdjt4ngUmz2kWT121Y/J9p3VGVwMW9qwHa41xylnTF1lKslvAohxW/33tZa7v
         NY5GxGEXLkpbiU73TBdXZ9/o77MqCi/9UoDXxTeeJ3Rn2tkkLVDeoXHmPz37T13W/eZn
         8/GrnohLB3+L5iI9JieKWLoioVZxJJUpBPom82VeUODmILb8iGHq0BGyoEllysuAOT8p
         +wtlzjlpyr4FYvSBWHA8IgzzPP0vhacWoe3l1l35INvdroXVPGktAgFzHCa+97sdPFcX
         0c1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765958936; x=1766563736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hntdZ0AL8tO1hGhDChLTEPbwkSJczkq/EoSmNVJXeRg=;
        b=Jb0HabISh4FfsqM7D4gddxG2W1VfGmfk37O2qKzns8WBJqyMLlnKVE6HAFJazze6BC
         7ygBBwoYDaMXdr6D2FjtQbmRelrECoPOo26fH8TRF0PL/J/+kIarctMV33e800rv5kz/
         1ngRl6l0Ddm2rGlGjoSWb7R623SNqM0dLb/eJFy//+a/JIrmvS+F1JM5GIbAaiz8KWF/
         6Nv9UA49Kc8HOv37N9dgD0z18exBC+aic9QoJH0o3j7eEYYpY/A+UkznxgYpZifbIiRm
         ijw2AaAwr8qYz26R+IaMd8HqU5Z7p0z65wWhhRI1vdn7UsbNlYJgqTTN5hRXBM7TTARn
         ckvw==
X-Gm-Message-State: AOJu0YxZFJcaKU2e6D8FZ0RBxvF8AVTg0QlSMDlJGhLiTzBKNbpQ3x7i
	QYB9Q+oW8MTV+utrn4O/sBl1zuUBJGrmKzV4REetXVj+q5mLweLxYtF7xPjlvQ==
X-Gm-Gg: AY/fxX4y9HRgFY8pBrzL+13pk87/tLzdCuCLism9CCpDwCdLRf8s9aLViWOTCxTh+V3
	2TFFc4ik2Bvoc7nnrO2gF/bMMkc9Q+ZXqNJpZ8m5KgAK+dETmRTM7CznxLG7pNxNy32E28CaGd3
	nRPeP3glb4nT9ROMfOZr+6iZH0Bi3Scox9KS8d3mDFD+90jxtqJolX8A3ROrdWb+jhE1NuXGqMM
	2dcAMZH9AlYeGrz7Ifi+k3xWzcY/OaBlhJpTLfK3Uz4djLUOGK/S3vFxsKAl+swIsVwe7VL2PZi
	15+ptb+8YxEmi2dikxW7a/mjKpvxug4qxxDUBr0QlPsoK6Wxq7QPGtQ8Qh7lMNa6eVcx1I/zUd7
	aBSB9EFR/mfwBJFfosUYJ9+fJH5RQSBEex1/wLaG8jpfK1E6PnuvKQH2VBu4GCWKgBt1ll61Wow
	ESwo9H4gYsswopnTNu/Pq+RHVJzFhUw27BVTRDoikmA7I6T2yjm1cHkkJ17R3zAvDG
X-Google-Smtp-Source: AGHT+IE/5kg9Z7TJzGr9ROwS9N/sQVlEOaOtbT81QFu/K3RyKQMmCm7uAXHr92A0/nHohCFvGWHNMA==
X-Received: by 2002:a05:6000:22c5:b0:430:f454:84ae with SMTP id ffacd0b85a97d-430f45486b4mr13043951f8f.63.1765958935417;
        Wed, 17 Dec 2025 00:08:55 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310ade7bf9sm3417220f8f.24.2025.12.17.00.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 00:08:54 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 0/5] OpenRISC de0 nano single and multicore boards
Date: Wed, 17 Dec 2025 08:08:26 +0000
Message-ID: <20251217080843.70621-1-shorne@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since v1:
 - Use proper schema in gpio-mmio suggsted by Conor Dooley
 - Remove 0 clock-frequency definitions in dtsi file

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

 .../devicetree/bindings/gpio/gpio-mmio.yaml   | 15 ++-
 arch/openrisc/boot/dts/de0-nano-common.dtsi   | 41 +++++++++
 arch/openrisc/boot/dts/de0-nano-multicore.dts | 25 +++++
 arch/openrisc/boot/dts/de0-nano.dts           | 54 +++++++++++
 arch/openrisc/boot/dts/simple-smp.dts         | 25 +++++
 .../dts/{simple_smp.dts => simple-smp.dtsi}   |  9 +-
 arch/openrisc/configs/de0_nano_defconfig      | 79 ++++++++++++++++
 .../configs/de0_nano_multicore_defconfig      | 92 +++++++++++++++++++
 arch/openrisc/configs/simple_smp_defconfig    |  2 +-
 arch/openrisc/include/asm/smp.h               |  3 +-
 arch/openrisc/kernel/smp.c                    | 22 ++++-
 drivers/irqchip/irq-ompic.c                   | 15 ++-
 drivers/irqchip/irq-or1k-pic.c                | 27 +++++-
 13 files changed, 390 insertions(+), 19 deletions(-)
 create mode 100644 arch/openrisc/boot/dts/de0-nano-common.dtsi
 create mode 100644 arch/openrisc/boot/dts/de0-nano-multicore.dts
 create mode 100644 arch/openrisc/boot/dts/de0-nano.dts
 create mode 100644 arch/openrisc/boot/dts/simple-smp.dts
 rename arch/openrisc/boot/dts/{simple_smp.dts => simple-smp.dtsi} (90%)
 create mode 100644 arch/openrisc/configs/de0_nano_defconfig
 create mode 100644 arch/openrisc/configs/de0_nano_multicore_defconfig

-- 
2.51.0

