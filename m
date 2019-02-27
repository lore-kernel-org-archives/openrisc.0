From: Steven Price <steven.price@arm.com>
Date: Wed, 27 Feb 2019 17:05:48 +0000
Subject: [OpenRISC] [PATCH v3 14/34] openrisc: mm: Add p?d_large()
	definitions
In-Reply-To: <20190227170608.27963-1-steven.price@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
Message-ID: <20190227170608.27963-15-steven.price@arm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information is provided by the
p?d_large() functions/macros.

For openrisc, we don't support large pages, so add a stub returning 0.

CC: Jonas Bonn <jonas@southpole.se>
CC: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
CC: Stafford Horne <shorne@gmail.com>
CC: openrisc at lists.librecores.org
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/openrisc/include/asm/pgtable.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 21c71303012f..5a375104ef71 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -228,6 +228,7 @@ extern unsigned long empty_zero_page[2048];
 #define pmd_none(x)	(!pmd_val(x))
 #define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK)) != _KERNPG_TABLE)
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
+#define pmd_large(x)	(0)
 #define pmd_clear(xp)	do { pmd_val(*(xp)) = 0; } while (0)
 
 /*
-- 
2.20.1

