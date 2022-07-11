Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C0EC43334
	for <openrisc@archiver.kernel.org>; Thu, 14 Jul 2022 04:51:22 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 675A320D55;
	Thu, 14 Jul 2022 06:51:21 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mail.librecores.org (Postfix) with ESMTPS id D960624993
 for <openrisc@lists.librecores.org>; Mon, 11 Jul 2022 05:46:39 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id r1so3389937plo.10
 for <openrisc@lists.librecores.org>; Sun, 10 Jul 2022 20:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qmBhjPhdel7Ory0h+LtHmaoT8CpQHwHtjRSzAczsGS8=;
 b=UY5oZcsZHFdGH9KcetDN8dqr2Mf0qiwqMqlLdkQ+0PNZPPWK8nytWfBrVg68lCyEAN
 jrVXhCD+p/9vhueaNcEswnstaaqhbi96KvKB1URC0IEAGTbb7bQ3L2sJKv8fP4/q3fdz
 qnhDuiRe5eJunmVyfmUC7y6G6huMy6rKKY2vpo7MUN+GN+8Yg69bDGSpiExtmJG6nmwc
 HGrj6W5Zy4EILKOUdTTBtFEUayRpo9P6vRZIShjByCsnQmdWy7cHknQIBwTn6y+6JaHt
 7Jslc7TiuDWWVL3D1WVwoeXWF4xp0s+zIBfTFhbW89tgNx9jEYuB6VyOj7QkOyyjH+tF
 MEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qmBhjPhdel7Ory0h+LtHmaoT8CpQHwHtjRSzAczsGS8=;
 b=w3lKC1kqFuItOAx4AV0wekN4D1v+RcuW848OizTCqIQdvGNN3v+45syqrPt+a9ornB
 LF7wi8eWufEhtuA9/yxxF3QeKPhMe4da9OFXsysQrbBlqQr9t9JX5kEwtLuk/8v8q/i5
 TJW2Jm0cKmvERNyj9k9Mlc7vTZbxUL+PMJRZABVC3mA8zd6vOC/EmxXDkLZJzk3y8OVs
 Bzbml9ly1UFDcCYnHfazI9iRfH5V694xwFA77M3ECyc9S4Ee9Ern1k+pnL0uoslyE0I3
 +FDWnXmXlYANGg0tXtSm8NYAsHiy6fqt7hmGzk92BE9x9q32g3VZkVgy50dYZh+xK8oz
 UKZg==
X-Gm-Message-State: AJIora8etZV1HXQoLygxGS6be8YxLytgBwrtqfURsgdU1h1Qs6TmkyZw
 eJXjcNe4bNQr1lasl/qMU9s=
X-Google-Smtp-Source: AGRyM1uXqBxzEnWgTK+S6bqpqoqltGNYamS7CTaFawotYp6lLuQkplQPx4DboSyk03U1rFf9/7Vqqw==
X-Received: by 2002:a17:90b:1b48:b0:1ef:a90d:eae1 with SMTP id
 nv8-20020a17090b1b4800b001efa90deae1mr15050227pjb.68.1657511198328; 
 Sun, 10 Jul 2022 20:46:38 -0700 (PDT)
Received: from localhost.localdomain (47-72-206-164.dsl.dyn.ihug.co.nz.
 [47.72.206.164]) by smtp.gmail.com with ESMTPSA id
 a13-20020a170902eccd00b001664d88aab3sm3447949plh.240.2022.07.10.20.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Jul 2022 20:46:37 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2 0/4] mm: arm64: bring up BATCHED_UNMAP_TLB_FLUSH
Date: Mon, 11 Jul 2022 15:46:11 +1200
Message-Id: <20220711034615.482895-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 Jul 2022 06:51:20 +0200
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: linux-s390@vger.kernel.org, zhangshiming@oppo.com, lipeifeng@oppo.com,
 arnd@arndb.de, corbet@lwn.net, realmz6@gmail.com,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
 yangyicong@hisilicon.com, openrisc@lists.librecores.org,
 darren@os.amperecomputing.com, huzhanyuan@oppo.com, guojian@oppo.com,
 linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Though ARM64 has the hardware to do tlb shootdown, the hardware
broadcasting is not free.
A simplest micro benchmark shows even on snapdragon 888 with only
8 cores, the overhead for ptep_clear_flush is huge even for paging
out one page mapped by only one process:
5.36%  a.out    [kernel.kallsyms]  [k] ptep_clear_flush

While pages are mapped by multiple processes or HW has more CPUs,
the cost should become even higher due to the bad scalability of
tlb shootdown.

The same benchmark can result in 16.99% CPU consumption on ARM64
server with around 100 cores according to Yicong's test on patch
4/4.

This patchset leverages the existing BATCHED_UNMAP_TLB_FLUSH by
1. only send tlbi instructions in the first stage -
	arch_tlbbatch_add_mm()
2. wait for the completion of tlbi by dsb while doing tlbbatch
	sync in arch_tlbbatch_flush()
My testing on snapdragon shows the overhead of ptep_clear_flush
is removed by the patchset. The micro benchmark becomes 5% faster
even for one page mapped by single process on snapdragon 888.


-v2:
1. Collected Yicong's test result on kunpeng920 ARM64 server;
2. Removed the redundant vma parameter in arch_tlbbatch_add_mm()
   according to the comments of Peter Zijlstra and Dave Hansen
3. Added ARCH_HAS_MM_CPUMASK rather than checking if mm_cpumask
   is empty according to the comments of Nadav Amit

Thanks, Yicong, Peter, Dave and Nadav for your testing or reviewing
, and comments.

-v1:
https://lore.kernel.org/lkml/20220707125242.425242-1-21cnbao@gmail.com/

Barry Song (4):
  Revert "Documentation/features: mark BATCHED_UNMAP_TLB_FLUSH doesn't
    apply to ARM64"
  mm: rmap: Allow platforms without mm_cpumask to defer TLB flush
  mm: rmap: Extend tlbbatch APIs to fit new platforms
  arm64: support batched/deferred tlb shootdown during page reclamation

 Documentation/features/arch-support.txt       |  1 -
 .../features/vm/TLB/arch-support.txt          |  2 +-
 arch/arm/Kconfig                              |  1 +
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/include/asm/tlbbatch.h             | 12 ++++++++++
 arch/arm64/include/asm/tlbflush.h             | 23 +++++++++++++++++--
 arch/loongarch/Kconfig                        |  1 +
 arch/mips/Kconfig                             |  1 +
 arch/openrisc/Kconfig                         |  1 +
 arch/powerpc/Kconfig                          |  1 +
 arch/riscv/Kconfig                            |  1 +
 arch/s390/Kconfig                             |  1 +
 arch/um/Kconfig                               |  1 +
 arch/x86/Kconfig                              |  1 +
 arch/x86/include/asm/tlbflush.h               |  3 ++-
 mm/Kconfig                                    |  3 +++
 mm/rmap.c                                     | 14 +++++++----
 17 files changed, 59 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/include/asm/tlbbatch.h

-- 
2.25.1

