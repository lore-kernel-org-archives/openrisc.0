From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Tue, 2 Jan 2018 11:47:19 +0000
Subject: [OpenRISC] [PATCH -next] irqchip/ompic: fix return value check in
	ompic_of_init()
Message-ID: <1514893639-70586-1-git-send-email-weiyongjun1@huawei.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

In case of error, the function ioremap() returns NULL pointer not
ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Fixes: 9b54470afd83 ("irqchip: add initial support for ompic")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/irqchip/irq-ompic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-ompic.c b/drivers/irqchip/irq-ompic.c
index cf6d0c4..400b119 100644
--- a/drivers/irqchip/irq-ompic.c
+++ b/drivers/irqchip/irq-ompic.c
@@ -171,9 +171,9 @@ static int __init ompic_of_init(struct device_node *node,
 
 	/* Setup the device */
 	ompic_base = ioremap(res.start, resource_size(&res));
-	if (IS_ERR(ompic_base)) {
+	if (!ompic_base) {
 		pr_err("ompic: unable to map registers");
-		return PTR_ERR(ompic_base);
+		return -ENOMEM;
 	}
 
 	irq = irq_of_parse_and_map(node, 0);

