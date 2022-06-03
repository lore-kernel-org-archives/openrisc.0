Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E17CCA47F
	for <openrisc@archiver.kernel.org>; Fri,  3 Jun 2022 10:14:31 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 1591A247DC;
	Fri,  3 Jun 2022 12:14:30 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mail.librecores.org (Postfix) with ESMTP id B5DD1242D4
 for <openrisc@lists.librecores.org>; Fri,  3 Jun 2022 12:14:28 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCFAE1063;
 Fri,  3 Jun 2022 03:14:27 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.42.23])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CDDE03F766;
 Fri,  3 Jun 2022 03:14:18 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Subject: [PATCH 0/6] mm/mmap: Enable more platforms with
 ARCH_HAS_VM_GET_PAGE_PROT
Date: Fri,  3 Jun 2022 15:44:05 +0530
Message-Id: <20220603101411.488970-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Will Deacon <will@kernel.org>, Jonas Bonn <jonas@southpole.se>,
 linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Heiko Carstens <hca@linux.ibm.com>, openrisc@lists.librecores.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 Dinh Nguyen <dinguyen@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

From the last discussion [1], some more platforms (s390, mips, csky, nios2,
openrisc) were willing to enable ARCH_HAS_VM_GET_PAGE_PROT and also provide
custom vm_get_page_prot() via switch case statement implementation without
any objection. All those platform specific patches have already been acked.

This series makes protection_map[] array private on platforms which define
their own vm_get_page_prot() via ARCH_HAS_VM_GET_PAGE_PROT, and also drops
off their __PXXX/__SXXX macros. This also enables new platforms as in this
series, to drop off their __PXXX/__SXXX macros as generic protection_map[]
is no longer visible to them.

[1] https://lore.kernel.org/all/1646045273-9343-2-git-send-email-anshuman.khandual@arm.com/

This series applies on current mainline and also has been build tested on
multiple platforms.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org
Cc: openrisc@lists.librecores.org
Cc: linux-csky@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (6):
  mm/mmap: Restrict generic protection_map[] array visibility
  s390/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  mips/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  csky/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  nios2/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  openrisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT

 arch/arm64/include/asm/pgtable-prot.h | 18 --------
 arch/arm64/mm/mmap.c                  | 21 ++++++++++
 arch/csky/Kconfig                     |  1 +
 arch/csky/include/asm/pgtable.h       | 18 --------
 arch/csky/mm/init.c                   | 32 ++++++++++++++
 arch/mips/Kconfig                     |  1 +
 arch/mips/include/asm/pgtable.h       | 22 ----------
 arch/mips/mm/cache.c                  | 60 ++++++++++++++++-----------
 arch/nios2/Kconfig                    |  1 +
 arch/nios2/include/asm/pgtable.h      | 24 -----------
 arch/nios2/mm/init.c                  | 47 +++++++++++++++++++++
 arch/openrisc/Kconfig                 |  1 +
 arch/openrisc/include/asm/pgtable.h   | 18 --------
 arch/openrisc/mm/init.c               | 41 ++++++++++++++++++
 arch/powerpc/include/asm/pgtable.h    |  2 +
 arch/powerpc/mm/book3s64/pgtable.c    | 20 +++++++++
 arch/s390/Kconfig                     |  1 +
 arch/s390/include/asm/pgtable.h       | 17 --------
 arch/s390/mm/mmap.c                   | 33 +++++++++++++++
 arch/sparc/include/asm/pgtable_32.h   |  2 +
 arch/sparc/include/asm/pgtable_64.h   | 19 ---------
 arch/sparc/mm/init_64.c               | 20 +++++++++
 arch/x86/include/asm/pgtable_types.h  | 19 ---------
 arch/x86/mm/pgprot.c                  | 19 +++++++++
 include/linux/mm.h                    |  2 +
 mm/mmap.c                             |  2 +-
 26 files changed, 280 insertions(+), 181 deletions(-)

-- 
2.25.1

