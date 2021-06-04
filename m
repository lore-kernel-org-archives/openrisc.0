From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Fri, 4 Jun 2021 15:06:19 +0800
Subject: [OpenRISC] [PATCH v2 01/15] mm: add setup_initial_init_mm() helper
In-Reply-To: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
References: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
Message-ID: <20210604070633.32363-2-wangkefeng.wang@huawei.com>
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
 include/linux/mm_types.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5aacc1c10a45..e1d2429089a4 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -572,6 +572,14 @@ struct mm_struct {
 };
 
 extern struct mm_struct init_mm;
+static inline void setup_initial_init_mm(void *start_code, void *end_code,
+					 void *end_data, void *brk)
+{
+	init_mm.start_code = (unsigned long)start_code;
+	init_mm.end_code = (unsigned long)end_code;
+	init_mm.end_data = (unsigned long)end_data;
+	init_mm.brk = (unsigned long)brk;
+}
 
 /* Pointer magic because the dynamic array size confuses some compilers. */
 static inline void mm_init_cpumask(struct mm_struct *mm)
-- 
2.26.2

