From: Stafford Horne <shorne@gmail.com>
Date: Wed, 22 Feb 2017 04:11:53 +0900
Subject: [OpenRISC] [PATCH v3 24/25] openrisc: Export ioremap symbols used
	by modules
In-Reply-To: <cover.1487702890.git.shorne@gmail.com>
References: <cover.1487702890.git.shorne@gmail.com>
Message-ID: <240621f3d305172c1d86355241b14e4423518594.1487702890.git.shorne@gmail.com>
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

