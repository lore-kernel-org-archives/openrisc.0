Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8606C29AAEA;
	Thu,  4 Sep 2025 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980079; cv=none; b=MGC9Ej0WH1F93x4vY7gmcLwpNX4s0VTvMQ2Mak/Jzv7bOirs3978QUsNAjkObkrA36jPlR534hJaM1QwZL89ViViCOriFOta9eTDadY2pb8zmD4gaXPkcSkUsUfab+7K/g8Z/G9MP+RLyaoynKxfSoDU2US9JK80XUP7Ji6ZGME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980079; c=relaxed/simple;
	bh=i2nafBkNwQgFl5rpeNdSMRL6JBBBjM+BG+dTG5K1gAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLR/FAOQbOp+eeZ7ZtXBxn0KZYFSOgdXtZyydExMb3wb/8O63dxmUQX+xLbQpfyGeAsKzggG++hS5P0jCGsTY7ar/6MsLtVHYwzP5Q3l9J/15aoWkbb5tr8yzKLASDug3xwMWoaxcFpTLQq8IhqlbGOGYVwCB8ckdCojsQBwCso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8buFOKc; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8buFOKc"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32b959b4895so349715a91.1;
        Thu, 04 Sep 2025 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756980077; x=1757584877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ki826I6LC2wPdNkCXDL1NW7JtQHmmjb2hJ+tp/qyoNw=;
        b=K8buFOKc0inb7IEyw4tlVNFGaVZFsGDpOk+1FBmHSUoiF6fHA3T7xILQg/NN4Owmb3
         GKyVUgbkM+F1QILTcbQxWqS44/Ad/bryc6iTVSfjl2CIs4LtUkr5tBrv5pC6ATaFcAQc
         74nlU0SV9zHP0F6dcf3AkgX6LD/gyHkrMZkcze6qC2HxFdDIPA3rrII1kSmqN+LUuzAT
         wfqjjIEenUPIpZuGWyxcKaq/7HGRR9NNuGsPtfjrdTqcDF44a15vDPUHIkXejZQ8SOCE
         0N/NKLApJuFqbT0liqbjtYvnIGqXUd6nHeR89DLQESqM4uCbGh9I1YsSPciJIzyjXIYV
         T4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756980077; x=1757584877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ki826I6LC2wPdNkCXDL1NW7JtQHmmjb2hJ+tp/qyoNw=;
        b=n3LcJoHFP2/jSur4APP8eiAzNunELSK9LnlAtu2nFdHJVpGEQcbEJjqKSWTv81+qmB
         J6g0urVthw93uOOIDumVfrZU8L2tXXh/jcqOtLWViEJ34mGHDAYP0t2j9h3HmKMCwNQ7
         oJSMC+0rKIYX9JXQuxYnOMbnOar848PCM/e/0iA6Bw2tAgtkapf8od9J6w3fciTzxxg7
         FDK7GBOLPLGEbm9tUp4vXzTuEoJ+j+fm2u2tMiLPfm6+F4ByM4ygV1AzY/t4Myfi/MAs
         ZqTAyuXRSfKQuA6SBiloNaC9IN+Q05o/6la4fxm69cBCuc7UGtMSTA3YTrbDhTMdKDtX
         f1Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVSRrv8AzOCoJBnwoLqlnenOnAUePdHH1cN8km1maadBL/GPKeTWeEpCx5Im5JeyQwhtJsZ3taLmFW8ADvdgw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6cVo7WlvuNW2XPR7Ri9EVHDadTyPQPkbsZHjIaJmmRLif5u0a
	4qAK+ZU3KRHrHpjobLxFtyYEW0ftImByorHu5z7z8DCQELS05lHDpqlegAMXRMHYyBxysw==
X-Gm-Gg: ASbGncvNymin3O4O9jf7ASPJUDuay7dX3PZiPp6Ke2SZN2R4dATfvfwVWAYT0ZZ2v/A
	TUX3O6vs0TAFOk+ZgEoSF0cyrt93eWv0eMeq3kNjoZiQRRF0OYzPZSK9v/Yd5LYgUS3RgRqxt1/
	fEfccJvf36Q/l7VH55HfNZUKFo1qCUXKHOG7jWRfIXSabFn46ZKHwF/BttlSzBzX7eVB0xpxBc2
	vebM3ln81sfy+K+Ff/O34I3Zgc2XVgU68hxnW0BqVPYOfd93lpTViBFZ4v2s6EQ/KiDKZfF0nbH
	TC69PsWmNYMPT9XCgnsWQFldenaypoNNZlc7bwUKCOzUZXGfHQDW0iqhj5/pylbTQ3nH8Ox/6vR
	OgkVVMeZ2Ll0DGXDkowpIR7yMpd4cGhEmDvgIEQDItRDxKbk90Mc=
X-Google-Smtp-Source: AGHT+IGiPpwAhtV6hn0STCKQ+PXkyAiYKj6iOCTqUwtWnZI/CnCp6LUbol+WbtS0KUgVhYK6wEnh4g==
X-Received: by 2002:a17:90b:3ec8:b0:324:e96a:2ada with SMTP id 98e67ed59e1d1-328156b9277mr23357172a91.21.1756980076932;
        Thu, 04 Sep 2025 03:01:16 -0700 (PDT)
Received: from nyaos.. (v133-18-108-210.vir.kagoya.net. [133.18.108.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b747c2d66sm3510656a91.28.2025.09.04.03.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 03:01:16 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Cc: chenmiao <chenmiao.ku@gmail.com>
Subject: [PATCH v4 0/4] openrisc: Support basic trace mechanism
Date: Thu,  4 Sep 2025 10:00:48 +0000
Message-ID: <20250904100109.688033-1-chenmiao.ku@gmail.com>
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

Link: https://lore.kernel.org/openrisc/20250805084926.4125564-1-chenmiao.ku@gmail.com/T/#u

Thanks,

Chen Miao

---
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
 arch/openrisc/kernel/jump_label.c             | 52 ++++++++++++
 arch/openrisc/kernel/module.c                 |  4 +
 arch/openrisc/kernel/patching.c               | 79 +++++++++++++++++++
 arch/openrisc/kernel/setup.c                  |  2 +
 arch/openrisc/mm/init.c                       |  6 +-
 15 files changed, 256 insertions(+), 16 deletions(-)
 create mode 100644 arch/openrisc/include/asm/insn-def.h
 create mode 100644 arch/openrisc/include/asm/jump_label.h
 create mode 100644 arch/openrisc/include/asm/text-patching.h
 create mode 100644 arch/openrisc/kernel/jump_label.c
 create mode 100644 arch/openrisc/kernel/patching.c

-- 
2.45.2

