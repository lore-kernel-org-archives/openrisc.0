Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB832904;
	Tue,  5 Aug 2025 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383776; cv=none; b=RkiQunSivatjxVfI/IPdIVvW+yd+sJ38MSGg9eUiXoL9BLcadLD5V8r7a2yVkWj1k+lTVB045ABe340uGGaDeS7+XQ5/OzWBBtWc8K8QSlnir/GdM/Qs+tnwa9zFErz5w6clbz4BngBq3TsxdAAkLskkOFsokfhR+LbRYEA5VOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383776; c=relaxed/simple;
	bh=9LGLvTX0urHIgbIiHKtDC6QR/cHJ4bH+hL+Y4On8v9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t6AGA4N/phePSQSZBlLBksqOe5L6s2TAIVX/bQsT/IHF11z6Epd+yBuPVPU68Uza5MAJQqQ9QAnH+35XMTAaRFj2vuVViMvLzUPDG2uPX4Oz7KMhY+92evh2r3el3I0LxT4SkG+BetPytv/8sEYrlGUvgRDXfttHxoovccCwy+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFwVT5fJ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFwVT5fJ"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76bd202ef81so5786727b3a.3;
        Tue, 05 Aug 2025 01:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754383774; x=1754988574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/SuyQHCDRXTfXm8plR5vpZm5H+fX+JK3Yo6OMujtww=;
        b=PFwVT5fJ42JErd7dy2sOBO5lxjApdrsdE+1iCfzzYOpmnG2X0RDMtAj2GC1heNod4n
         ROOIiJ4tDpbAAg6uKUcLhQj/Mmhu4A/aBaUdtrtI1JVA7m0vWXX0P495hacg2XGQamre
         jAA/4GRvnVQRLH5jffud9anxEkDrxEFafLVDqeDrnJCP5RIvWYbQYUGqOl5+x1PCspRg
         R+s6JQJzb4oXIk5G08qSCM3MP6WWz4gfHmEpEbdi41iKp3vCOZUbW46LvIQy2yNNYzd8
         Hxqs0gRfjM7Q5p8IaVWK1RK3LwjkkPoWFtfDAxwgzO+mD7CMabfKwmpGAazAS9pL8a3W
         In8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754383774; x=1754988574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/SuyQHCDRXTfXm8plR5vpZm5H+fX+JK3Yo6OMujtww=;
        b=lkpmujhiZsxeC8PijQYFRKmZsp6Dcr8ToCF4bYOthcZgGJiHY4TdraXjj3fCBtrZ+u
         c4a1N1J+OerimkORutTSDgZDqBpsImEYmNJ92tXKHWBO/UZxIOHu40FDd9Cdn2de7Za3
         MBQ0RqOLyNIb6CuvXvoNZi9v6vjVLGymy/HGDQhNSdvakT2nnjL0Ski9nA1LSBtadHVy
         yt1dehZ8Px1+VH38pUlmGsfQr6HNILlwnSeiZpg/YSINhx16H5CUY6BuHSkZOLOQXhlJ
         FKO5lj4nRstsBXleJaqqJNZ4BTLfkV1NRlboo0FZTNhOUFm+HNeHEy8ldUGIxvNRQtoG
         beww==
X-Forwarded-Encrypted: i=1; AJvYcCXUGAK0208H1BBZB+XeYHUMcFyRxs9YgYDs2vtXcq3aYvgwc4ui5UBDtBKrtZSIngDVneu+MTM0qg7aPDHhFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM0bWu31skIen52ZvTDbtMgec7fpXbKBOed15qJqUwk6o28C5c
	5zZbY14vAVEkiHWoaR04R435dZmwR3iMsX9T30celwiMi1r8dsPK935r
X-Gm-Gg: ASbGnctTfRPQ+87pzo1TKKlBw/8h8AhLtR6uSFoxNhOBReOfzsTxe4ptZGWXl43oTj6
	EVVVv83peMOzvcp4mi9/qyCqEwYW3ogtammSBzWJrYpsjjr9SVKeENGvyQW/lIVk/ZAMzDa77+b
	XjXSWfAqEOY8SPaDRA03APrU4FVNzyzVKNfk3KSo8tj8KU2Ye+ueYjytLhIo3bPHrCXGuZWGRL9
	wGqmb+gW8ldDpxRFHHxKiD94Xycvv/w9mJhZV1ZNMlXaMX08UWEHCJF7urRYPMi3zdeaDc7AyLR
	wflZVzQ4rAHrXGDqtI+Xo10SSclhHYE2yle4tP9fxrF12FtR8lzpxN66DLy3cIMEBekv8LvSba1
	kxptQ07pwIke+G1xW
X-Google-Smtp-Source: AGHT+IHTWmdlpLu/mnDv5SCvtykRfWj1p0xzVyMi4GLNJutp8IiQHr+pa8yKVoGEtlAeByfrJLxNrw==
X-Received: by 2002:a17:903:22cf:b0:240:6406:c471 with SMTP id d9443c01a7336-24246f30931mr188870275ad.10.1754383774389;
        Tue, 05 Aug 2025 01:49:34 -0700 (PDT)
Received: from nyaos.. ([141.11.79.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eca6eb1sm13701171a91.22.2025.08.05.01.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 01:49:33 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Stafford Horne <shorne@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	chenmiao <chenmiao.ku@gmail.com>
Subject: [PATCH 0/2] Support fixmap and jump_label for openrisc
Date: Tue,  5 Aug 2025 08:49:26 +0000
Message-ID: <20250805084926.4125564-1-chenmiao.ku@gmail.com>
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
implementation for OpenRISC.

1. Implement the patch_map interface and the patch_insn_write single insn 
write API by providing FIX_TEXT_POKE0. And create a new insn-def.h to record 
openrisc's instruction macro definition which only have OPENRISC_INSN_SIZE 
now.

2. Based on the previously implemented patch_insn_write, achieve a complete 
jump_label implementation, directly supporting arch_jump_label_transform_queue.
And add a new macro OPENRISC_INSN_NOP in insn-def.h.

Thanks,

Chen Miao

chenmiao (2):
  openrisc: Add text patching API support
  openrisc: Add jump label support

 .../core/jump-labels/arch-support.txt         |  2 +-
 arch/openrisc/Kconfig                         |  2 +
 arch/openrisc/configs/or1ksim_defconfig       | 19 ++---
 arch/openrisc/configs/virt_defconfig          |  1 +
 arch/openrisc/include/asm/Kbuild              |  1 -
 arch/openrisc/include/asm/fixmap.h            |  1 +
 arch/openrisc/include/asm/insn-def.h          | 15 ++++
 arch/openrisc/include/asm/jump_label.h        | 68 ++++++++++++++++
 arch/openrisc/include/asm/text-patching.h     | 13 +++
 arch/openrisc/kernel/Makefile                 |  2 +
 arch/openrisc/kernel/jump_label.c             | 53 +++++++++++++
 arch/openrisc/kernel/patching.c               | 79 +++++++++++++++++++
 arch/openrisc/kernel/setup.c                  |  2 +
 arch/openrisc/mm/init.c                       |  2 +-
 14 files changed, 245 insertions(+), 15 deletions(-)
 create mode 100644 arch/openrisc/include/asm/insn-def.h
 create mode 100644 arch/openrisc/include/asm/jump_label.h
 create mode 100644 arch/openrisc/include/asm/text-patching.h
 create mode 100644 arch/openrisc/kernel/jump_label.c
 create mode 100644 arch/openrisc/kernel/patching.c

-- 
2.45.2

