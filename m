From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Tue, 8 Jun 2021 16:34:13 +0800
Subject: [OpenRISC] [PATCH v3 resend 10/15] openrisc: convert to
 setup_initial_init_mm()
In-Reply-To: <20210608083418.137226-1-wangkefeng.wang@huawei.com>
References: <20210608083418.137226-1-wangkefeng.wang@huawei.com>
Message-ID: <20210608083418.137226-11-wangkefeng.wang@huawei.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Use setup_initial_init_mm() helper to simplify code.

Acked-by: Stafford Horne <shorne@gmail.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc at lists.librecores.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/openrisc/kernel/setup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index c6f9e7b9f7cb..8ae2da6ac097 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -293,10 +293,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	/* process 1's initial memory region is the kernel code/data */
-	init_mm.start_code = (unsigned long)_stext;
-	init_mm.end_code = (unsigned long)_etext;
-	init_mm.end_data = (unsigned long)_edata;
-	init_mm.brk = (unsigned long)_end;
+	setup_initial_init_mm(_stext, _etext, _edata, _end);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start == initrd_end) {
-- 
2.26.2

