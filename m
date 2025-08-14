Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33A91E531;
	Thu, 14 Aug 2025 03:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142047; cv=none; b=YYPqZfOjuwhOX/y0FagoiAaSN2uSLHQQbTl0LxdpphxcCte/6PhHtouIP1tAjvuOVIYyDEQchsOOrK2kzv0u7dV8ZXM7/jFPaDjKljyeODO+BnHNc/z4dvL25qxyOUgRfet/DaPauh5fNU8AHzNGUrhkI6jl7Q5Geza5LNL0JjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142047; c=relaxed/simple;
	bh=Rt7hDmJcpp51I8gE1XuCdFFZ5EaQEXI2g9YtZAyM7a0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMRSszt5f9PC7oPyVfFLu27orAxdadATI/FTwpgAAezS4Hey7PkXH2QhweiTKL+PKsjNblmlxJ2GwwBgXwJAQDRagtnx7R+NmVR8q8UEcjjpqHl4sS2zBLaLF9kxeAF+aFphcQ0U685oBy0XRB2tRJ8l2ovjbq0igHc7STfVEDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ir5TnI21; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir5TnI21"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-323266d6f57so660171a91.0;
        Wed, 13 Aug 2025 20:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755142045; x=1755746845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vD5amTfVJMTFV460IjTilS7jJKgvQx/6rucIOlm1hbc=;
        b=Ir5TnI21AQ9wBOS9pGUdPbI1Q7E9ik787mX4D80VTdX647OzIVdM24aceY2LsU9/RC
         gYmgsVa9W7FXekMx+/XB5PDIm7FeWbpMlCvasu0VqzgAUgG2GUZsrzIBlwfz85eZ/Tff
         NPFsT5uoCWK5rj1m0At3ieQqVLizHPUIq47tl4BxZb817hicM3X5Ob0tOZbgTrtesiTm
         3y3nIFz88/eaj3qnFhTYFhe2JFdUgYf3bN6+Z4HosbQcHhbiXE5on88J2qHS5XjyuaEH
         8GHd1bQ+svi0qJctmu+l3ZK1Qk0osiSQLWjNyfPjE/s+n2BvD12EytdW9ltIAM7xzPLE
         0Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755142045; x=1755746845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vD5amTfVJMTFV460IjTilS7jJKgvQx/6rucIOlm1hbc=;
        b=DSPQikU0HpIUyYTPDLhvW7wo1vYAlxG2pz1qsA537CV+PokciT1u5EMjhtQl5jmF5T
         wUcUIjr/t413fzD68eT+dJmO1TZHfR6/Bsm2BoyhU2rj603Wua+V4N1vbh9FCPmOA6TZ
         Gg/K3HXJ5HGQxyLkT1YhpWHh1oQZKW3ID7xHu2u2BbrbCmtsuje4UcF6UvmVMdUnjUSG
         40/AKomcfbFJHB5rCNYUbmLg+a+0rSq8PcfekUQJ9iG+htAycoWc7dNfJhUdeE447KCF
         g8tv4bF6V+usRJ7GiNXd1ZOcFObBY9qzbwahvzy+h8YhmvCABDkSu9oK2IfxyzmDu6Ft
         N/bw==
X-Forwarded-Encrypted: i=1; AJvYcCUcxh7Sfd4bMNGDt4zsBGhsx2PV+1Bkqc4tHVso7h8maySQYz8bR+ZBdUIFT2M/OoAZJm+J4CI806Bi8k7zdA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ObuemGhscsbykSuFME8oLdQyNElTQE6lL0UV+ARkF6lVsseu
	nNzUP1pLjDEij14991zcGaquXrsXipoyGvtNrV7Kma7ooOo2x5Rur/QeZo8vV1KKIk6O6A==
X-Gm-Gg: ASbGncug2qyxuNEaeZBrSAL37kbJltVAVI7iIuqrf6BolJNWa6BaQwK3p+/mowrBQOl
	V77Wg8zQlTpJ4sYwCpJq0jDIzQs+ExqE7VmUv8+Tb+XxMKXREgrcAEZ2kdk+Vzcyg3KBtd/qZmu
	0d90tUGJTSrVFZFfNHvnWQhK3O2Yecha+hdP7kIG1NLYjEHzyShg5TnWZku47E6X8S4UfkW3tME
	YaEu1k9KFNIykS+H5tK7Kcp/YbPlcyGmWjjCRqyhzNN5qfCc3KAQFcRyVS6yF6Fh19Ee4djEBp3
	O5+wIf0mMjpuub4UDQhxFrGTQcK2+xnGiBa7cs24gPLtSe42r7/X4aG5S689HpBrtQpCqW/sOdv
	NRF/F8P8PJPMvprRdcvG0mqPDur+p
X-Google-Smtp-Source: AGHT+IH5TAdEnSLBBh3pf6IJmF8Hp73k5k2+xK2Uf0bNB8unEOdnC0uJnJnz5LcY3rI3Ybzd20VcIA==
X-Received: by 2002:a17:90b:264b:b0:321:1682:2d49 with SMTP id 98e67ed59e1d1-32327cc148dmr2069547a91.32.1755142044821;
        Wed, 13 Aug 2025 20:27:24 -0700 (PDT)
Received: from nyaos.. ([45.12.134.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32331167ff6sm276009a91.27.2025.08.13.20.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 20:27:24 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Stafford Horne <shorne@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	chenmiao <chenmiao.ku@gmail.com>
Subject: [PATCH v3 0/2] openrisc: Support fixmap and jump_label
Date: Thu, 14 Aug 2025 03:27:00 +0000
Message-ID: <20250814032717.785395-1-chenmiao.ku@gmail.com>
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

Link: https://lore.kernel.org/openrisc/20250805084926.4125564-1-chenmiao.ku@gmail.com/T/#u

Thanks,

Chen Miao

---
Changes in V3:
  - Removed the is_exit_text used, added some necessary comments.
  - Modify some macro like __ASSEMBLY__ to __ASSEMBLER__ and ensure the
    defconfig by make savedefconfig.

Changes in V2:
  - Add a new insn-def.h to record the insn macro.
  - Modify the patch_insn_write API from const void* to u32 insn.
  - Using the modified patch_insn_write API in 
    arch_jump_label_transform_queue.


chenmiao (2):
  openrisc: Add text patching API support
  openrisc: Add jump label support

 .../core/jump-labels/arch-support.txt         |  2 +-
 arch/openrisc/Kconfig                         |  2 +
 arch/openrisc/configs/or1ksim_defconfig       | 19 ++---
 arch/openrisc/configs/virt_defconfig          |  2 +-
 arch/openrisc/include/asm/Kbuild              |  1 -
 arch/openrisc/include/asm/fixmap.h            |  1 +
 arch/openrisc/include/asm/insn-def.h          | 15 ++++
 arch/openrisc/include/asm/jump_label.h        | 68 ++++++++++++++++
 arch/openrisc/include/asm/text-patching.h     | 13 ++++
 arch/openrisc/kernel/Makefile                 |  2 +
 arch/openrisc/kernel/jump_label.c             | 52 +++++++++++++
 arch/openrisc/kernel/patching.c               | 78 +++++++++++++++++++
 arch/openrisc/kernel/setup.c                  |  2 +
 arch/openrisc/mm/init.c                       | 10 ++-
 14 files changed, 251 insertions(+), 16 deletions(-)
 create mode 100644 arch/openrisc/include/asm/insn-def.h
 create mode 100644 arch/openrisc/include/asm/jump_label.h
 create mode 100644 arch/openrisc/include/asm/text-patching.h
 create mode 100644 arch/openrisc/kernel/jump_label.c
 create mode 100644 arch/openrisc/kernel/patching.c

-- 
2.45.2

