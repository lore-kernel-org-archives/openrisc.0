From: Rob Herring <robh@kernel.org>
Date: Wed,  6 Oct 2021 11:43:23 -0500
Subject: [OpenRISC] [PATCH 03/12] ARM: broadcom: Use of_get_cpu_hwid()
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
Message-ID: <20211006164332.1981454-4-robh@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Replace open coded parsing of CPU nodes 'reg' property with
of_get_cpu_hwid().

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list at broadcom.com
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-bcm/bcm63xx_pmb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-bcm/bcm63xx_pmb.c b/arch/arm/mach-bcm/bcm63xx_pmb.c
index 0e5a05bac3ea..003f1472ab45 100644
--- a/arch/arm/mach-bcm/bcm63xx_pmb.c
+++ b/arch/arm/mach-bcm/bcm63xx_pmb.c
@@ -91,10 +91,10 @@ static int bcm63xx_pmb_get_resources(struct device_node *dn,
 	struct of_phandle_args args;
 	int ret;
 
-	ret = of_property_read_u32(dn, "reg", cpu);
-	if (ret) {
+	*cpu = of_get_cpu_hwid(dn, 0);
+	if (*cpu == ~0U) {
 		pr_err("CPU is missing a reg node\n");
-		return ret;
+		return -ENODEV;
 	}
 
 	ret = of_parse_phandle_with_args(dn, "resets", "#reset-cells",
-- 
2.30.2

