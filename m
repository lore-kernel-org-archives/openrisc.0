From: guoren@kernel.org <guoren@kernel.org>
Date: Sun, 28 Mar 2021 06:30:27 +0000
Subject: [OpenRISC] [PATCH v5 6/7] sparc: qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
In-Reply-To: <1616913028-83376-1-git-send-email-guoren@kernel.org>
References: <1616913028-83376-1-git-send-email-guoren@kernel.org>
Message-ID: <1616913028-83376-7-git-send-email-guoren@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Guo Ren <guoren@linux.alibaba.com>

We don't have native hw xchg16 instruction, so let qspinlock
generic code to deal with it.

Using the full-word atomic xchg instructions implement xchg16 has
the semantic risk for atomic operations.

This patch cancels the dependency of on qspinlock generic code on
architecture's xchg16.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Rob Gardner <rob.gardner@oracle.com>
---
 arch/sparc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 164a5254c91c..1079fe3f058c 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -91,6 +91,7 @@ config SPARC64
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS_XCHG32
 	select GENERIC_TIME_VSYSCALL
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_PTE_SPECIAL
-- 
2.17.1

