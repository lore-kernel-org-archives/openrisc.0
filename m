From: Stafford Horne <shorne@gmail.com>
Date: Sat, 04 Jul 2020 21:11:49 -0000
Subject: [OpenRISC] [PATCH] openrisc: Add support for external initrd images
Message-ID: <20200704211136.601768-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

In OpenRISC we set the initrd_start and initrd_end based on the symbols
we setup in vmlinux.lds.S.  However, this is not needed if we use the
generic linker description in INIT_DATA_SECTION.

Removing our own initrd setup reduces code, but also the generic code
supports loading external initrd images.  A bootloader can load a rootfs
image into memory and we can configure devicetree to load it with:

        chosen {
                bootargs = "earlycon";
                stdout-path = "uart0:115200";
                linux,initrd-start = < 0x08000100 >;
                linux,initrd-end = < 0x08200000 >;
        };

Reported-by: Mateusz Holenko <mholenko@antmicro.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/setup.c       |  8 +++++---
 arch/openrisc/kernel/vmlinux.lds.S | 12 ------------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 8aa438e1f51f..b18e775f8be3 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -292,13 +292,15 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.brk = (unsigned long)_end;
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	initrd_start = (unsigned long)&__initrd_start;
-	initrd_end = (unsigned long)&__initrd_end;
 	if (initrd_start == initrd_end) {
+		printk(KERN_INFO "Initial ramdisk not found\n");
 		initrd_start = 0;
 		initrd_end = 0;
+	} else {
+		printk(KERN_INFO "Initial ramdisk at: 0x%p (%lu bytes)\n",
+		       (void *)(initrd_start), initrd_end - initrd_start);
+		initrd_below_start_ok = 1;
 	}
-	initrd_below_start_ok = 1;
 #endif
 
 	/* setup memblock allocator */
diff --git a/arch/openrisc/kernel/vmlinux.lds.S b/arch/openrisc/kernel/vmlinux.lds.S
index 60449fd7f16f..22fbc5fb24b3 100644
--- a/arch/openrisc/kernel/vmlinux.lds.S
+++ b/arch/openrisc/kernel/vmlinux.lds.S
@@ -96,18 +96,6 @@ SECTIONS
 
         __init_end = .;
 
-	. = ALIGN(PAGE_SIZE);
-	.initrd			: AT(ADDR(.initrd) - LOAD_OFFSET)
-	{
-		__initrd_start = .;
-		*(.initrd)
-		__initrd_end = .;
-		FILL (0);
-                . = ALIGN (PAGE_SIZE);
-	}
-
-        __vmlinux_end = .;            /* last address of the physical file */
-
 	BSS_SECTION(0, 0, 0x20)
 
         _end = .;
-- 
2.26.2

