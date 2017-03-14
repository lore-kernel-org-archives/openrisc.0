From: Stafford Horne <shorne@gmail.com>
Date: Tue, 14 Mar 2017 23:56:28 +0900
Subject: [OpenRISC] [PATCH 3/3] openrisc: Export symbols needed by modules
In-Reply-To: <cover.1489502779.git.shorne@gmail.com>
References: <cover.1489502779.git.shorne@gmail.com>
Message-ID: <05e67e380f8a29ce479a180a3bbd145f30236b16.1489502779.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This was detected by allmodconfig, errors reported:

 ERROR: "empty_zero_page" [net/ceph/libceph.ko] undefined!
 ERROR: "__ucmpdi2" [lib/842/842_decompress.ko] undefined!
 ERROR: "empty_zero_page" [fs/nfs/objlayout/objlayoutdriver.ko] undefined!
 ERROR: "empty_zero_page" [fs/exofs/exofs.ko] undefined!
 ERROR: "empty_zero_page" [fs/crypto/fscrypto.ko] undefined!
 ERROR: "__ucmpdi2" [fs/btrfs/btrfs.ko] undefined!
 ERROR: "pm_power_off" [drivers/regulator/act8865-regulator.ko] undefined!

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/or32_ksyms.c | 5 +++++
 arch/openrisc/kernel/process.c    | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/openrisc/kernel/or32_ksyms.c b/arch/openrisc/kernel/or32_ksyms.c
index 5c4695d..2842979 100644
--- a/arch/openrisc/kernel/or32_ksyms.c
+++ b/arch/openrisc/kernel/or32_ksyms.c
@@ -42,6 +42,11 @@ DECLARE_EXPORT(__muldi3);
 DECLARE_EXPORT(__ashrdi3);
 DECLARE_EXPORT(__ashldi3);
 DECLARE_EXPORT(__lshrdi3);
+DECLARE_EXPORT(__ucmpdi2);
+
+extern unsigned long empty_zero_page[2048];
+EXPORT_SYMBOL(empty_zero_page);
 
 EXPORT_SYMBOL(__copy_tofrom_user);
+EXPORT_SYMBOL(__clear_user);
 EXPORT_SYMBOL(memset);
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 828a291..f8da545 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -90,6 +90,7 @@ void arch_cpu_idle(void)
 }
 
 void (*pm_power_off) (void) = machine_power_off;
+EXPORT_SYMBOL(pm_power_off);
 
 /*
  * When a process does an "exec", machine state like FPU and debug
-- 
2.9.3

