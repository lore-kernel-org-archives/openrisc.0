Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DB331195C
	for <linux-openrisc@vger.kernel.org>; Tue,  7 Apr 2026 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588293; cv=none; b=c+wTiFfIxFz2cs8vpXLBwIICZBzEZCYrL7QMYd7lwhQXTjuWEkyR2EheCm94s4d4nnvEuudOJSwFfRA8IOkCOhsmmxDsewpFdTSXBLzCmRZzxNjSYAa0rq7ek9xZ1LDVaKS9EIxACi6TPcsJWjSzvGwZFfgw9GVfts/1Cu1EciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588293; c=relaxed/simple;
	bh=GR45AI0o78Ytejg5IdSf+fIb6OLzz6uoIIPfDIjeIWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L3BqVv3inck6KdfgsaTzN6g/EIk02bVzhWY3e0Bkal/RE28DWAD3l/aqVAGNcUVOeHVm9HDRg57FDwwANBVdRN4UOxi8WsqFKSk6Bnoh8Hp+xOARfxfZn4h6Cjo4tZVQJ/AjV1HewTND2NXu2MFRk4tJU6zXnXX1v0ur1JrMzoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqzCghp1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqzCghp1"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b256a4c6b5so32555315ad.0
        for <linux-openrisc@vger.kernel.org>; Tue, 07 Apr 2026 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775588291; x=1776193091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=55j8IddnRN/mRx9o2IbvUofVTQLK3O2pOkhg4YsKhUY=;
        b=TqzCghp1D07Nx9ZaCp8ExzNn+ctR7LJEXe0LvE82b5XZkCOvFt7Q+ioGY82mDH/wWD
         Zd3/aJu9CSCKQ5AbDWkbROC2/I7xNnmZHVeTdGu3DL3gITuDiB0BgFyJkDnTLvy8jYG/
         e/0FDW93NOC8Qjo8jvlBu69oDUGRFSfrq4nZVBaVAe85UnCYsCtgtYKdeP6CkJ79rn0U
         lRCOHny/o2ZqtoEbuss8SlGVxHWym9o/VQfG1Hh1Rq7R9Ix12tHlDYQdkAGqaikPpDCP
         q/XpYe4z7SEcYFQb67VDjNGU1DIffnqA7Hc3ICEc+/oMTv5rjYL+efaF3CxWeOCL8VUi
         p09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775588291; x=1776193091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55j8IddnRN/mRx9o2IbvUofVTQLK3O2pOkhg4YsKhUY=;
        b=eVapk1oiNRiYQuYKW+EaCWwuUPw0zcN0rHzsWDedHvccEQcSzrOJ1nmbqj9aGY3sKR
         L5ZPVEicwpUB3x55SjIA3kQ2oEfS5Kj3OIZ0HCNjBLl17NRGSaaCkU1c628GVJr9fafa
         DWGfzRZ5viSQAWfuCyg/1+VjeaZLajaK+lwiW367LTBHYIH23VGt4NKX0cgGaZwsuwEz
         3e1aySvsrqyW/MlM4FaMstAXcDfvuMrsQIfaoHXXwzjPnVXlYWgvC1tpZvGXrYC2d83W
         k7xC6lYls32Gc2sjiz4hVgEh+h8hRMJuvxtvLO9zUoL9x7p2pKnFF7xpLtfU1pDevlk3
         ssxA==
X-Forwarded-Encrypted: i=1; AJvYcCX1Bm+uaQ6r6MZ9Q0eN+cShcLldg6vX3lJbZzKg7PWzOWoK04fTAoUoL2rUaRrkKiZt7S+0miJamGhfy8A9tQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzR/aIQJjcPENw1Y22uL8yjOmmNtx4A+VeMM7k/Niz56Prkr1bK
	6rL4TwJ3EfIgr+KfMuakupciPhmiDtNa7hCrY3dtAU8hENtOU3iuJF9s
X-Gm-Gg: AeBDiettBjZrjuv0cBo89EWp4+gtob4Ag7VekiFcEh28LKItvJigVwWUy2RxADPx/k2
	9QmZJ2LkzHktT0ezNy6goszTU1ISqmkGmD6iVhX93yt+4ssqR4aW10CpmNpyLjA500pQMPKykr4
	U+YFUxZxWZSVhFjJUYiHmBqDrJI5GwWfThIkSGD+r+xFbhRlwD7Aq4pvBX6SfhKOyR6m4nBiTod
	YoqiJ2KWZHh199XHw0Qnaq5ZgDSblqeiaDmWURBf0m7ukF/ro3PY/kv+F7N1SnN4EQX+/y8E3/6
	SCppXvToFdxvkoYLsfNOirp0OTmgPHDcslkItHb4PVN1FNFcOy1sckpy4G3/KJMtjuHttUsR0gs
	LXIyWgAySpJdruK5Xe8C4YhZSU1mHIWznVrfziaAVgGh1yAbscsYY3WcFV7D1EvvH2xshGaxUmB
	fHiiwQqPg4dJr6SH+3zAPCRPfPSV2+1js=
X-Received: by 2002:a17:903:22c5:b0:2b2:a6a2:c8ca with SMTP id d9443c01a7336-2b2a6a2ca50mr73961255ad.13.1775588291250;
        Tue, 07 Apr 2026 11:58:11 -0700 (PDT)
Received: from valdaarhun.localdomain ([2401:4900:1c45:a41c:c2d5:268a:232e:d07e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749ce29esm193486145ad.81.2026.04.07.11.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 11:58:10 -0700 (PDT)
From: Sahil Siddiq <sahilcdq0@gmail.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	naveen@kernel.org,
	davem@davemloft.net,
	mhiramat@kernel.org
Cc: peterz@infradead.org,
	jpoimboe@kernel.org,
	jbaron@akamai.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	chenmiao.ku@gmail.com,
	johannes@sipsolutions.net,
	nsc@kernel.org,
	masahiroy@kernel.org,
	tytso@mit.edu,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sahil Siddiq <sahilcdq0@gmail.com>
Subject: [RFC 0/2] openrisc: Add support for KProbes
Date: Wed,  8 Apr 2026 00:26:48 +0530
Message-ID: <20260407185650.79816-1-sahilcdq0@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds basic support for KProbes on OpenRISC. There are
a few changes that I would still like to add and test before this
can be considered for merging. I was hoping to get some feedback on
the changes made so far. The implementation in this series is based
on KProbes for LoongArch, MIPS and RISC-V. 

The current state of the series allows traps to be inserted dynamically
in the kernel. A KProbe can be inserted via a kernel module whose
init/exit functions are used to register/unregister a KProbe. A pre-
handler and post-handler can also be provisioned in the module, which
are associated with the KProbe and triggered when the probe is hit. See
the documentation on KProbes for a detailed explanation [1].

The following are yet to be implemented for OpenRISC:
1. kretprobes
2. kprobe-based event tracing
3. ftrace, and kprobe features that depend on ftrace (particularly,
dynamic tracing)

I hope to submit a patch for kretprobes soon (possibly in a revision of
this series).

I wrote a couple of kernel modules to test these changes. They can be found
here [2]. I also ran test_kprobes located at ./lib/tests/ against these
changes [3]. The results are as shown below:

/home # insmod test_kprobes.ko 
KTAP version 1
1..1
    KTAP version 1
    # Subtest: kprobes_test
    # module: test_kprobes
    1..3
    ok 1 test_kprobe
    ok 2 test_kprobes
    ok 3 test_kprobe_missed
# kprobes_test: pass:3 fail:0 skip:0 total:3
# Totals: pass:3 fail:0 skip:0 total:3
ok 1 kprobes_test
/home # 

When compiling the kernel, the following options should be enabled:
1. CONFIG_HAVE_KPROBES=y
2. CONFIG_KPROBES=y

Also ensure that CONFIG_KPROBE_EVENTS is disabled.

To compile /lib/tests/test_kprobes.c, add the following to .config:
1. CONFIG_KUNIT=y
2. CONFIG_DEBUG_KERNEL=y
3. CONFIG_KPROBES_SANITY_TEST=m

The first commit cleans up and reorganizes existing functions, fixes
a few issues with instruction simulation, and introduces new structures
and macros that will be used by KProbes and other tracing facilities
in the future.

The second commit adds support for KProbes. Currently, I have
implemented this in such a way that KProbes can't be used to probe
a few "blacklisted" instructions. Probes can't be inserted in a delay
slot either (similar to MIPS). I have also added a few asm functions
to the blacklist that I think should not be probed. For e.g., "memset"
and "_trap_handler" have been blacklisted because probing them causes
the kernel to hang. However, I am not sure if other functions in "entry.S"
need to be added as well to the blacklist.

Thanks,
Sahil

[1] https://www.kernel.org/doc/html/latest/trace/kprobes.html
[2] https://github.com/valdaarhun/or-dev/tree/main/home
[3] https://github.com/openrisc/linux/blob/for-next/lib/tests/test_kprobes.c

Sahil Siddiq (2):
  openrisc: Add utilities and clean up simulation of instructions
  openrisc: Add KProbes

 arch/openrisc/Kconfig                   |   1 +
 arch/openrisc/configs/or1ksim_defconfig |   2 +
 arch/openrisc/configs/virt_defconfig    |   2 +
 arch/openrisc/include/asm/asm.h         |  22 ++
 arch/openrisc/include/asm/break.h       |  19 ++
 arch/openrisc/include/asm/insn-def.h    |  61 +++-
 arch/openrisc/include/asm/kprobes.h     |  76 +++++
 arch/openrisc/include/asm/spr_defs.h    |   1 +
 arch/openrisc/kernel/Makefile           |   3 +-
 arch/openrisc/kernel/entry.S            |  16 +
 arch/openrisc/kernel/insn.c             |  74 +++++
 arch/openrisc/kernel/jump_label.c       |   2 +-
 arch/openrisc/kernel/kprobes.c          | 381 ++++++++++++++++++++++++
 arch/openrisc/kernel/traps.c            |  67 ++---
 arch/openrisc/lib/memcpy.c              |   2 +
 arch/openrisc/lib/memset.S              |   4 +
 arch/openrisc/mm/fault.c                |   5 +
 samples/kprobes/kprobe_example.c        |   8 +
 18 files changed, 701 insertions(+), 45 deletions(-)
 create mode 100644 arch/openrisc/include/asm/asm.h
 create mode 100644 arch/openrisc/include/asm/break.h
 create mode 100644 arch/openrisc/include/asm/kprobes.h
 create mode 100644 arch/openrisc/kernel/insn.c
 create mode 100644 arch/openrisc/kernel/kprobes.c

-- 
2.53.0

