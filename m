From: Stafford Horne <shorne@gmail.com>
Date: Sun,  9 Aug 2020 08:06:44 +0900
Subject: [OpenRISC] [PATCH v3 3/6] openrisc: uaccess: Use static inline
 function in access_ok
In-Reply-To: <20200808230647.833047-1-shorne@gmail.com>
References: <20200808230647.833047-1-shorne@gmail.com>
Message-ID: <20200808230647.833047-4-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

As suggested by Linus when reviewing commit 9cb2feb4d21d
("arch/openrisc: Fix issues with access_ok()") last year; making
__range_ok an inline function also fixes the used twice issue that the
commit was fixing.  I agree it's a good cleanup.  This patch addresses
that as I am currently working on the access_ok macro to fixup sparse
annotations in OpenRISC.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/openrisc/include/asm/uaccess.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index f2fc5c4b88c3..4b59dc9ad300 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -48,16 +48,19 @@
 /* Ensure that the range from addr to addr+size is all within the process'
  * address space
  */
-#define __range_ok(addr, size) (size <= get_fs() && addr <= (get_fs()-size))
+static inline int __range_ok(unsigned long addr, unsigned long size)
+{
+	const mm_segment_t fs = get_fs();
+
+	return size <= fs && addr <= (fs - size);
+}
 
 /* Ensure that addr is below task's addr_limit */
 #define __addr_ok(addr) ((unsigned long) addr < get_fs())
 
 #define access_ok(addr, size)						\
 ({ 									\
-	unsigned long __ao_addr = (unsigned long)(addr);		\
-	unsigned long __ao_size = (unsigned long)(size);		\
-	__range_ok(__ao_addr, __ao_size);				\
+	__range_ok((unsigned long)(addr), (size));			\
 })
 
 /*
-- 
2.26.2

