From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Tue, 8 Jun 2021 16:34:04 +0800
Subject: [OpenRISC] [PATCH v3 resend 01/15] mm: add setup_initial_init_mm()
 helper
In-Reply-To: <20210608083418.137226-1-wangkefeng.wang@huawei.com>
References: <20210608083418.137226-1-wangkefeng.wang@huawei.com>
Message-ID: <20210608083418.137226-2-wangkefeng.wang@huawei.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Add setup_initial_init_mm() helper to setup kernel text,
data and brk.

Cc: linux-snps-arc at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-csky at vger.kernel.org
Cc: uclinux-h8-devel at lists.sourceforge.jp
Cc: linux-m68k at lists.linux-m68k.org
Cc: openrisc at lists.librecores.org
Cc: linuxppc-dev at lists.ozlabs.org
Cc: linux-riscv at lists.infradead.org
Cc: linux-sh at vger.kernel.org
Cc: linux-s390 at vger.kernel.org
Cc: x86 at kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h | 3 +++
 mm/init-mm.c       | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c274f75efcf9..02aa057540b7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -244,6 +244,9 @@ int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
 
 #define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
 
+void setup_initial_init_mm(void *start_code, void *end_code,
+			   void *end_data, void *brk);
+
 /*
  * Linux kernel virtual memory manager primitives.
  * The idea being to have a "virtual" mm in the same way
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 153162669f80..b4a6f38fb51d 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -40,3 +40,12 @@ struct mm_struct init_mm = {
 	.cpu_bitmap	= CPU_BITS_NONE,
 	INIT_MM_CONTEXT(init_mm)
 };
+
+void setup_initial_init_mm(void *start_code, void *end_code,
+			   void *end_data, void *brk)
+{
+	init_mm.start_code = (unsigned long)start_code;
+	init_mm.end_code = (unsigned long)end_code;
+	init_mm.end_data = (unsigned long)end_data;
+	init_mm.brk = (unsigned long)brk;
+}
-- 
2.26.2

