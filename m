Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694F6C433EF
	for <openrisc@archiver.kernel.org>; Fri,  3 Jun 2022 10:14:58 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id AD9D3242D4;
	Fri,  3 Jun 2022 12:14:57 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mail.librecores.org (Postfix) with ESMTP id 7BC0B2491E
 for <openrisc@lists.librecores.org>; Fri,  3 Jun 2022 12:14:55 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA7A01596;
 Fri,  3 Jun 2022 03:14:54 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.42.23])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B69D63F766;
 Fri,  3 Jun 2022 03:14:46 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Subject: [PATCH 3/6] mips/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date: Fri,  3 Jun 2022 15:44:08 +0530
Message-Id: <20220603101411.488970-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603101411.488970-1-anshuman.khandual@arm.com>
References: <20220603101411.488970-1-anshuman.khandual@arm.com>
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

This defines and exports a platform specific custom vm_get_page_prot() via
subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
macros can be dropped which are no longer needed.

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/mips/Kconfig               |  1 +
 arch/mips/include/asm/pgtable.h | 22 ------------
 arch/mips/mm/cache.c            | 60 +++++++++++++++++++--------------
 3 files changed, 36 insertions(+), 47 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index db09d45d59ec..d0b7eb11ec81 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -14,6 +14,7 @@ config MIPS
 	select ARCH_HAS_STRNLEN_USER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_SUPPORTS_UPROBES
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 374c6322775d..6caec386ad2f 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -41,28 +41,6 @@ struct vm_area_struct;
  * by reasonable means..
  */
 
-/*
- * Dummy values to fill the table in mmap.c
- * The real values will be generated at runtime
- */
-#define __P000 __pgprot(0)
-#define __P001 __pgprot(0)
-#define __P010 __pgprot(0)
-#define __P011 __pgprot(0)
-#define __P100 __pgprot(0)
-#define __P101 __pgprot(0)
-#define __P110 __pgprot(0)
-#define __P111 __pgprot(0)
-
-#define __S000 __pgprot(0)
-#define __S001 __pgprot(0)
-#define __S010 __pgprot(0)
-#define __S011 __pgprot(0)
-#define __S100 __pgprot(0)
-#define __S101 __pgprot(0)
-#define __S110 __pgprot(0)
-#define __S111 __pgprot(0)
-
 extern unsigned long _page_cachable_default;
 extern void __update_cache(unsigned long address, pte_t pte);
 
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 7be7240f7703..012862004431 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -159,30 +159,6 @@ EXPORT_SYMBOL(_page_cachable_default);
 
 #define PM(p)	__pgprot(_page_cachable_default | (p))
 
-static inline void setup_protection_map(void)
-{
-	protection_map[0]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
-	protection_map[1]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
-	protection_map[2]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
-	protection_map[3]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
-	protection_map[4]  = PM(_PAGE_PRESENT);
-	protection_map[5]  = PM(_PAGE_PRESENT);
-	protection_map[6]  = PM(_PAGE_PRESENT);
-	protection_map[7]  = PM(_PAGE_PRESENT);
-
-	protection_map[8]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
-	protection_map[9]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
-	protection_map[10] = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE |
-				_PAGE_NO_READ);
-	protection_map[11] = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE);
-	protection_map[12] = PM(_PAGE_PRESENT);
-	protection_map[13] = PM(_PAGE_PRESENT);
-	protection_map[14] = PM(_PAGE_PRESENT | _PAGE_WRITE);
-	protection_map[15] = PM(_PAGE_PRESENT | _PAGE_WRITE);
-}
-
-#undef PM
-
 void cpu_cache_init(void)
 {
 	if (cpu_has_3k_cache) {
@@ -201,6 +177,40 @@ void cpu_cache_init(void)
 
 		octeon_cache_init();
 	}
+}
 
-	setup_protection_map();
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
+	case VM_READ:
+		return PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
+	case VM_WRITE:
+		return PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
+	case VM_WRITE | VM_READ:
+		return PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
+	case VM_EXEC:
+	case VM_EXEC | VM_READ:
+	case VM_EXEC | VM_WRITE:
+	case VM_EXEC | VM_WRITE | VM_READ:
+		return PM(_PAGE_PRESENT);
+	case VM_SHARED:
+		return PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
+	case VM_SHARED | VM_READ:
+		return PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
+	case VM_SHARED | VM_WRITE:
+		return PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE | _PAGE_NO_READ);
+	case VM_SHARED | VM_WRITE | VM_READ:
+		return PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE);
+	case VM_SHARED | VM_EXEC:
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return PM(_PAGE_PRESENT);
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+	case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
+		return PM(_PAGE_PRESENT | _PAGE_WRITE);
+	default:
+		BUILD_BUG();
+	}
 }
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1

