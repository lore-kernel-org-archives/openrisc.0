Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4D31C575;
	Fri,  5 Sep 2025 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095986; cv=none; b=Xsu+K6cka6cw+WUbN+umH9mkLnWbJR6lQG7E9Z0NH0NL+xiqX/FEURBeIaEE1UJYAk87fyphNSsa+h+nPqELQ/oniP3V7jDSgCPsXtm6Wau3osXnVBg5ZuDGg2z6CTLYNokXgmbejI+TR6nvYlKGUw4/VnbV1gcrWApUa1CSNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095986; c=relaxed/simple;
	bh=ATZ6nqKQ0C5TxxSeVYRX6ew0/pXGaWpVRNbwJvJtne0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NHNu5Q9hLsYdaxTWlJaBO+QgcLrXtq5dEWSnvD7597X/HM+CSuWvOBf17Wo5TFFJw0/KVqkZIN4VrV1vzZGXpRgm/EjXL0BYzSjJBM7ltV6q+6fmMTMtAQ1btdof8cbySGBHMpzh1vt9obXMXMlh1Df4GpbwCoPou0RB8szV0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjKjOsqL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjKjOsqL"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7724df82cabso2875099b3a.2;
        Fri, 05 Sep 2025 11:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757095985; x=1757700785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i/zx7tDrRgS08firBPO5ix4sp4YFE+fpANKcQa8rqd0=;
        b=HjKjOsqL624QkXRpUM9Wsi2wOspReIjSC85/WLwlWFOxWhzNxwPeKFo31HXCn3HAcu
         hkR1LWkBqsskckTgQv7pr4nIRxrk45nlBCFsSma7eRw3oBT8t9KQHMwtKd/DLzZ6c1F2
         GKFBeDCQHTweh50ItKVo196G6cNs1R18qW9f3sydKpWot/qCuP9xxB4T1w1BoP22lvil
         YsyvvpAwRUAlNMILJzU3iBpV4tnUoK/cMm5r2hjEi08SQLA3XU9zz543xEPl3LHV4Rys
         eKdbcQ/Kmt6b6OcJXBnkmDB+IjufDF4FpjGGIZ1pB6wGrFnniohZAbgb2Ribjy8glKA0
         +aCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095985; x=1757700785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/zx7tDrRgS08firBPO5ix4sp4YFE+fpANKcQa8rqd0=;
        b=Y9wj0glaNobr/ri2+HYrvXv5+lylMnjRU04QomHTrAqomnbnx/jJdkha2O33ganhc2
         bshcAO2HpJVMy+WWxVqqQMBbKujmjUS1J2pgymeHBqcZxqelMBZA/xBKHJZvbkfZ0jbq
         LQ1wG72peSlGfLiDh5YcJNwHrT29A7NWVXWdnojl8o3EepIYk1kwuWLDDHjNKEBe+vNe
         AajotmrrFLc4I7DaR7Hou3f2VM/fVATLDhD7AYnh00HDDnSPWbKdYoHzXkJsAnrcKSGs
         biAKV56X3BmpO2+HNTyBhzWIFUvRLWyJSMyDmdtnY9PFfSQzLjzanJO4Dsbj9hMw0twu
         weNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEpZNFC15acYJzc5jNpG7ngyp796xRdGsiTOsncfVk6Qo8esBUOvtugrVHJiOnPlgclkNit8pOogBFZvpORQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7va4Rex/ttUE7tf6rt77MYPIuFmxSkoNsUQzPbzjIRE0FLFzS
	kzqDr0GZVi0SJFIXC9RB7BdsjX2RYZKFWbUkCuSXTMStoDzdk+/ExzMB
X-Gm-Gg: ASbGnctQlhfGeDxOscAFMuKfyFmlbgZBRbpJ2Y3Kxctx49f1rGIZ+ExxtFPgsUaxKrL
	ZAVnyd7TJ30MFE2NKxwaUwkAYBvZSZ+HJ2VXa0C5aUb8MBX/TtC+kVh+uHTZEwgtMMOnlok2o78
	K5ifZLfj4g/PP9kSmTTlgtp7abESfXwsCUTv5VAiHYM3Yrh8zKqLrekAxg/Ebyb+PHQ4laIouh+
	Datuj6j1KgsNOC+nBWZ03VFJTZdvVmujo6Z1X/korB1/6XgzqEGR+LQfJwyor4+u7s0lmi+Ur2H
	XMLh3ZvR7ZTvwGmvdQfibXXcWgxQewdwHWnDOH0QboUqfnH0SvsV66H5TkFX6dao91rCWroMfTe
	F2ON44mfKLsx/VS/h633tLOvhnWsF5Akf63NcST0nvhpuKPT4QPs=
X-Google-Smtp-Source: AGHT+IEhNHrKim0YeGLTRgSLC+pNLUIlxsn3LrVE3tAUNRgHDmyqE1H9BcVPHbNe7JBEE37znqEstw==
X-Received: by 2002:a05:6a20:3ca5:b0:248:7a71:55e with SMTP id adf61e73a8af0-2487a71088cmr15107746637.42.1757095984543;
        Fri, 05 Sep 2025 11:13:04 -0700 (PDT)
Received: from nyaos.. (v133-18-108-210.vir.kagoya.net. [133.18.108.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd3095df7sm19940233a12.36.2025.09.05.11.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:13:04 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Stafford Horne <shorne@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	chenmiao <chenmiao.ku@gmail.com>
Subject: [PATCH v5 0/4] openrisc: Support basic trace mechanism
Date: Fri,  5 Sep 2025 18:12:54 +0000
Message-ID: <20250905181258.9430-1-chenmiao.ku@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: chenmiao <chenmiao.ku@gmail.com>

Hello everyone,

This implements a basic text patching mechanism and a complete jump_label
implementation for OpenRISC. It should be noted that the jump_label have
passed testing.

1. Implement the patch_map interface and the patch_insn_write single insn
write API by providing FIX_TEXT_POKE0. And create a new insn-def.h to record
openrisc's instruction macro definition which only have OPENRISC_INSN_SIZE
now.

2. Support for the R_OR1K_32_PCREL relocation type is added for module insertion,
enabling subsequent jump_label selftest module insertion.

3. Regenerate defconfigs for or1ksim_defconfig and virt_defconfig.

4. Based on the previously implemented patch_insn_write, achieve a complete
jump_label implementation, directly supporting arch_jump_label_transform_queue.
And add a new macro OPENRISC_INSN_NOP in insn-def.h.

Link: https://lore.kernel.org/openrisc/CAKxVwgdGe59F=giPXsukmQDO=XY58BH2gAMCV6uCR=vmwkAyyQ@mail.gmail.com/T/#t

Thanks,

Chen Miao

---
Changes in V5:
  - Simplified some code in the fourth patch and removed unnecessary braces.

Changes in V4:
  - Added testing for jump_label
  - Split part of the jump_label patch content to form the third patch
  - Implemented R_OR1K_32_PCREL module support for jump_label testing

Changes in V3:
  - Removed the is_exit_text used, added some necessary comments.
  - Modify some macro like __ASSEMBLY__ to __ASSEMBLER__ and ensure the
    defconfig by make savedefconfig.

Changes in V2:
  - Add a new insn-def.h to record the insn macro.
  - Modify the patch_insn_write API from const void* to u32 insn.
  - Using the modified patch_insn_write API in 
    arch_jump_label_transform_queue.

chenmiao (4):
  openrisc: Add text patching API support
  openrisc: Add R_OR1K_32_PCREL relocation type module support
  openrisc: Regenerate defconfigs.
  openrisc: Add jump label support

 .../core/jump-labels/arch-support.txt         |  2 +-
 arch/openrisc/Kconfig                         |  2 +
 arch/openrisc/configs/or1ksim_defconfig       | 19 ++---
 arch/openrisc/configs/virt_defconfig          |  2 +-
 arch/openrisc/include/asm/Kbuild              |  1 -
 arch/openrisc/include/asm/fixmap.h            |  1 +
 arch/openrisc/include/asm/insn-def.h          | 15 ++++
 arch/openrisc/include/asm/jump_label.h        | 72 +++++++++++++++++
 arch/openrisc/include/asm/text-patching.h     | 13 +++
 arch/openrisc/kernel/Makefile                 |  2 +
 arch/openrisc/kernel/jump_label.c             | 51 ++++++++++++
 arch/openrisc/kernel/module.c                 |  4 +
 arch/openrisc/kernel/patching.c               | 79 +++++++++++++++++++
 arch/openrisc/kernel/setup.c                  |  2 +
 arch/openrisc/mm/init.c                       |  6 +-
 15 files changed, 255 insertions(+), 16 deletions(-)
 create mode 100644 arch/openrisc/include/asm/insn-def.h
 create mode 100644 arch/openrisc/include/asm/jump_label.h
 create mode 100644 arch/openrisc/include/asm/text-patching.h
 create mode 100644 arch/openrisc/kernel/jump_label.c
 create mode 100644 arch/openrisc/kernel/patching.c

-- 
2.45.2

