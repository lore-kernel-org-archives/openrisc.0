From: Stafford Horne <shorne@gmail.com>
Date: Fri, 24 Feb 2017 13:32:43 +0900
Subject: [OpenRISC] [PATCH v4 23/24] openrisc: Export ioremap symbols used
	by modules
In-Reply-To: <cover.1487910170.git.shorne@gmail.com>
References: <cover.1487910170.git.shorne@gmail.com>
Message-ID: <c6bea9e1af70680328db0ce33167ff3b6a5baa24.1487910170.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Noticed this when building with allyesconfig.  Got build failures due
to iounmap and __ioremap symbols missing.  This patch exports them so
modules can use them.  This is inline with other architectures.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/mm/ioremap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index 8705a46..2175e4b 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -80,6 +80,7 @@ __ioremap(phys_addr_t addr, unsigned long size, pgprot_t prot)
 
 	return (void __iomem *)(offset + (char *)v);
 }
+EXPORT_SYMBOL(__ioremap);
 
 void iounmap(void *addr)
 {
@@ -106,6 +107,7 @@ void iounmap(void *addr)
 
 	return vfree((void *)(PAGE_MASK & (unsigned long)addr));
 }
+EXPORT_SYMBOL(iounmap);
 
 /**
  * OK, this one's a bit tricky... ioremap can get called before memory is
-- 
2.9.3

