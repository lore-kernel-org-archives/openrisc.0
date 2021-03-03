From: Stafford Horne <shorne@gmail.com>
Date: Thu,  4 Mar 2021 05:19:04 +0900
Subject: [OpenRISC] [PATCH] openrisc: Define the elf binary entry point
Message-ID: <20210303201904.3509658-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Entry is used by qemu to find where to start booting, we define
this to the 0x100 reset vector as is done by default when the CPU
resets.  This fixes the qemu boot issue.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/cpu/barebox.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/openrisc/cpu/barebox.lds.S b/arch/openrisc/cpu/barebox.lds.S
index adb0c22f8..45c5f2553 100644
--- a/arch/openrisc/cpu/barebox.lds.S
+++ b/arch/openrisc/cpu/barebox.lds.S
@@ -17,6 +17,7 @@
 #include <asm-generic/barebox.lds.h>
 
 OUTPUT_FORMAT("elf32-or1k", "elf32-or1k", "elf32-or1k")
+ENTRY(__reset)
 __DYNAMIC  =  0;
 
 MEMORY
-- 
2.26.2

