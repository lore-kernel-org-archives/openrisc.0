Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70516A935;
	Wed,  6 Aug 2025 02:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754445931; cv=none; b=GxSzkRbdsKMdxqlSTRgwAoNgpoipR+FWS/+OmnE4Bu+ZU8/Qppk5OoNFgAjAaR9gBsfVWNiOLQI3xeCcBXk/YjmIvMmYBqlOM4L6GnPF4iG1WiuOjxIk7ggJrCsRW8zQmxH7m3C6MnR1rw1uU+Q3CWmLP/hQRaQk44AtwteD78M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754445931; c=relaxed/simple;
	bh=m3OWJlAwWV1CXl0AW5lSqCdAzYKCSR5qZ5wBzwnCtps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hTHylVFRu1qblNu/aZkbx0XIG5MtxQEHFMhrA5GauGsNRV2yh4qD6I8p7lOL7mO4usNd0Qkr5FegLcQb9+447orbFomJXFS1ShF87IGjWKiYcDww+o+GkpGL+trODD5od2Pib0fTgo/WcnJ+ToGfDyfn54IRTJdhJ7YEf9lNtRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA497PdY; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA497PdY"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73c17c770a7so5793871b3a.2;
        Tue, 05 Aug 2025 19:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754445929; x=1755050729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y3HhJ8HOEhQIRKeo+HZS7nHg/pWD5QCSj+Jeq0wu+ig=;
        b=FA497PdYEBbzAmk6WbBxOSLCZv6zgrJ38zjE3LqzYL7CUFt6wNF2bUb56Uif4KuxuC
         tBk62nYbBp+x00VgkcAxjro5Q1gXCFjueeDxQHBgtuhIXugU+hyy8d8ygI+76A07G8Tu
         qGptfyr5k0vdM4AcAkAwLSocrGb41AYQxvkxyVDQXHg+A+OPqcfK2MHEPHPZBUxoTVIR
         +0ItiRUTIRg/BugbPLnIUGN229Ph6EM7WqQC5eDv7uIVzh5siw9jz5pqpcj0sYDsTdEG
         dXkb0ixXULkS1pVcegBclNIBX2AhDl/61da+cRYxmDYXfZ5B/481U49eAzzCtbXgqLPR
         W/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754445929; x=1755050729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3HhJ8HOEhQIRKeo+HZS7nHg/pWD5QCSj+Jeq0wu+ig=;
        b=VcR17+AL5Hapan4ONnNcSNPBkblHfffVVnzL3kfclQ4ksb5+Jb2FkHVjDL6T8w8DIX
         HKTfnopvasQUY6m9yFbbugR34qszeRkZemAs+DozZqC4SqyFFcuimG+XhDe23K7uGOcK
         5hKVZmD5GXG2JSs38IJuyV7VcMln3pjPb9uOwhpFt/COocx2JXK+saQV+t01E48mE3DQ
         k+Sh/jy/0CqG1kRnvHFV50uP9749J5UFWA/fVvo/1GlLxebGvEMZTOgjbVDbaLK0wUZE
         S0q2h3do/hOO1FO0lGN2YW1XhwY6DytgxdbquYQjWopmg8++QZJukomq/vMGM3WQV15v
         rF8A==
X-Gm-Message-State: AOJu0Yxg8BvQLL+r2F/p3b7QFxgFazsUPEMW8AKGoHdVWnV1V9rtXt/6
	PfyQpD4AzCsBR36JVv9dhVjzTWJ0O8kieFVrRQOXxkENqUXrc2Q3eWL1WTxw6SjJFtgy9/kt
X-Gm-Gg: ASbGncs4kpUSUeHKy2rNvICNMqZwoZt5rS5e60mX5IpSIa1TRmUP+KQtWGE+E++N6+m
	p/VcQ+elVGVwVJivrXJJ37MlTjrtsuVkvvSRfjpvuB3hsNTowh6gdXSLonzutsyrR70ZunW5xGv
	iN2ORD4eGceoA5IdG74YneAFYer8R/GeM0zpNwPMs3VReNv1lJmoycK2Y72ahpjnytv89unmXga
	CIjWtCF7Y/1WGo9nHO9ERzxhaP5Vd54H+4bpIyO1X94nfazQ4lWbEPI5YXBjZRzFi3RpG+JUg37
	1bJ/5OYMOn6pgj1beS7qP5sOXBNdQ6LxDunCFDKOgluZOWAqRPhmYfDCEjmvOLO1lWzwmQyjAJi
	wp5FYHp8YD2T23zaWeXg3yN+x5Lo=
X-Google-Smtp-Source: AGHT+IFRFJgUJHEbUFwALs+Bi4vNvXgjugukcSfH3gF8H2BehReNGBNGRU/xo1lvmOqwDrJ7t0Cklg==
X-Received: by 2002:a05:6a00:4f92:b0:748:f750:14c6 with SMTP id d2e1a72fcca58-76c2b00b6d9mr1298077b3a.14.1754445929170;
        Tue, 05 Aug 2025 19:05:29 -0700 (PDT)
Received: from nyaos.. ([141.11.79.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcf531sm14068499b3a.92.2025.08.05.19.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 19:05:28 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	chenmiao <chenmiao.ku@gmail.com>
Subject: [PATCH v2 0/2] Support fixmap and jump_label for openrisc
Date: Wed,  6 Aug 2025 02:05:02 +0000
Message-ID: <20250806020520.570988-1-chenmiao.ku@gmail.com>
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

- V2: modify the patch_insn_write API from const void* to u32 insn.

2. Based on the previously implemented patch_insn_write, achieve a complete 
jump_label implementation, directly supporting arch_jump_label_transform_queue.
And add a new macro OPENRISC_INSN_NOP in insn-def.h.

- V2: using the modified patch_insn_write API in 
arch_jump_label_transform_queue.

Link: https://lore.kernel.org/openrisc/20250805084926.4125564-1-chenmiao.ku@gmail.com/T/#u

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

