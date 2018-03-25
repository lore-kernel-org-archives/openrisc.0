From: Shea Levy <shea@shealevy.com>
Date: Sun, 25 Mar 2018 18:18:38 -0400
Subject: [OpenRISC] [PATCH v2 01/16] initrd: Add generic code path for
	common initrd unloading logic.
In-Reply-To: <20180325221853.10839-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
 <20180325221853.10839-1-shea@shealevy.com>
Message-ID: <20180325221853.10839-2-shea@shealevy.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 init/initramfs.c | 7 +++++++
 usr/Kconfig      | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/init/initramfs.c b/init/initramfs.c
index 7e99a0038942..5f2e3dba4822 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -526,6 +526,13 @@ extern unsigned long __initramfs_size;
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
+#ifdef CONFIG_INITRAMFS_GENERIC_UNLOAD
+void __init free_initrd_mem(unsigned long start, unsigned long end)
+{
+       free_reserved_area((void *)start, (void *)end, -1, "initrd");
+}
+#endif
+
 static void __init free_initrd(void)
 {
 #ifdef CONFIG_KEXEC_CORE
diff --git a/usr/Kconfig b/usr/Kconfig
index 43658b8a975e..fd79d4d6fa26 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -233,3 +233,7 @@ config INITRAMFS_COMPRESSION
 	default ".lzma" if RD_LZMA
 	default ".bz2"  if RD_BZIP2
 	default ""
+
+# Arches can select this for a generic initrd unloading codepath
+config INITRAMFS_GENERIC_UNLOAD
+	bool
-- 
2.16.2

