From: Stafford Horne <shorne@gmail.com>
Date: Mon, 17 Apr 2017 08:23:56 +0900
Subject: [OpenRISC] [PATCH 7/7] target/openrisc: Implement full vmstate
	serialization
In-Reply-To: <cover.1492384862.git.shorne@gmail.com>
References: <cover.1492384862.git.shorne@gmail.com>
Message-ID: <fae2ac85b7226ec28c8419f488cd9947bb6142a0.1492384862.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Previously serialization did not persist the tlb, timer, pic and other
key state items.  This meant snapshotting and restoring a running os
would crash. After adding these I am able to take snapshots of a
running linux os and restore at a later time.

I am currently not trying to maintain capatibility with older versions
as I do not believe this really worked before or anyone used it.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/machine.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 27cc751..2adcda8 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -30,9 +30,59 @@ static int env_post_load(void *opaque, int version_id)
 
     env->gpr = env->shadow_gpr[0];
 
+    /* Restore MMU handlers */
+    if (env->sr & SR_DME) {
+        env->tlb->cpu_openrisc_map_address_data =
+            &cpu_openrisc_get_phys_data;
+    } else {
+        env->tlb->cpu_openrisc_map_address_data =
+            &cpu_openrisc_get_phys_nommu;
+    }
+
+    if (env->sr & SR_IME) {
+        env->tlb->cpu_openrisc_map_address_code =
+            &cpu_openrisc_get_phys_code;
+    } else {
+        env->tlb->cpu_openrisc_map_address_code =
+            &cpu_openrisc_get_phys_nommu;
+    }
+
+
     return 0;
 }
 
+static const VMStateDescription vmstate_tlb_entry = {
+    .name = "tlb_entry",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINTTL(mr, OpenRISCTLBEntry),
+        VMSTATE_UINTTL(tr, OpenRISCTLBEntry),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_cpu_tlb = {
+    .name = "cpu_tlb",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT_2DARRAY(itlb, CPUOpenRISCTLBContext,
+                             ITLB_WAYS, ITLB_SIZE, 0,
+                             vmstate_tlb_entry, OpenRISCTLBEntry),
+        VMSTATE_STRUCT_2DARRAY(dtlb, CPUOpenRISCTLBContext,
+                             DTLB_WAYS, DTLB_SIZE, 0,
+                             vmstate_tlb_entry, OpenRISCTLBEntry),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+#define VMSTATE_CPU_TLB(_f, _s)                             \
+    VMSTATE_STRUCT_POINTER(_f, _s, vmstate_cpu_tlb, CPUOpenRISCTLBContext)
+
+
 static int get_sr(QEMUFile *f, void *opaque, size_t size, VMStateField *field)
 {
     CPUOpenRISCState *env = opaque;
@@ -92,6 +142,16 @@ static const VMStateDescription vmstate_env = {
         VMSTATE_UINT32(esr, CPUOpenRISCState),
         VMSTATE_UINT32(fpcsr, CPUOpenRISCState),
         VMSTATE_UINT64(mac, CPUOpenRISCState),
+
+        VMSTATE_CPU_TLB(tlb, CPUOpenRISCState),
+
+        VMSTATE_TIMER_PTR(timer, CPUOpenRISCState),
+        VMSTATE_UINT32(ttmr, CPUOpenRISCState),
+        VMSTATE_UINT32(ttcr, CPUOpenRISCState),
+
+        VMSTATE_UINT32(picmr, CPUOpenRISCState),
+        VMSTATE_UINT32(picsr, CPUOpenRISCState),
+
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.9.3

