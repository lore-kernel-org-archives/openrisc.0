From: Rob Herring <robh@kernel.org>
Date: Wed,  6 Oct 2021 11:43:30 -0500
Subject: [OpenRISC] [PATCH 10/12] x86: dt: Use of_get_cpu_hwid()
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
Message-ID: <20211006164332.1981454-11-robh@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Replace open coded parsing of CPU nodes' 'reg' property with
of_get_cpu_hwid().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86 at kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/x86/kernel/devicetree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 6a4cb71c2498..3aa1e99df2a9 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -139,12 +139,11 @@ static void __init dtb_cpu_setup(void)
 {
 	struct device_node *dn;
 	u32 apic_id, version;
-	int ret;
 
 	version = GET_APIC_VERSION(apic_read(APIC_LVR));
 	for_each_of_cpu_node(dn) {
-		ret = of_property_read_u32(dn, "reg", &apic_id);
-		if (ret < 0) {
+		apic_id = of_get_cpu_hwid(dn, 0);
+		if (apic_id == ~0U) {
 			pr_warn("%pOF: missing local APIC ID\n", dn);
 			continue;
 		}
-- 
2.30.2

