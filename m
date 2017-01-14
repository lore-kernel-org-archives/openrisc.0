From: Stafford Horne <shorne@gmail.com>
Date: Sun, 15 Jan 2017 08:08:19 +0900
Subject: [OpenRISC] [PATCH 22/22] openrisc: head: Move init strings to
	rodata section
In-Reply-To: <cover.1484432596.git.shorne@gmail.com>
References: <cover.1484432596.git.shorne@gmail.com>
Message-ID: <9b64212208e25d04257e6d5ba8f14219b1cd83be.1484432596.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The strings used during the head/init phase of openrisc bootup were
stored in the executable section of the binary.

This causes compilation to fail when using CONFIG_DEBUG_INFO with
error:
 Error: unaligned opcodes detected in executable segment

Also, this patch removes unused strings.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/head.S | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index a22f1fc..573e131 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -1530,11 +1530,7 @@ ENTRY(_early_uart_init)
 	l.jr	r9
 	l.nop
 
-_string_copying_linux:
-	.string "\n\n\n\n\n\rCopying Linux... \0"
-
-_string_ok_booting:
-	.string "Ok, booting the kernel.\n\r\0"
+	.section .rodata
 
 _string_unhandled_exception:
 	.string "\n\rRunarunaround: Unhandled exception 0x\0"
@@ -1545,12 +1541,6 @@ _string_epc_prefix:
 _string_nl:
 	.string "\n\r\0"
 
-	.global	_string_esr_irq_bug
-_string_esr_irq_bug:
-	.string "\n\rESR external interrupt bug, for details look into entry.S\n\r\0"
-
-
-
 /* ========================================[ page aligned structures ]=== */
 
 /*
-- 
2.9.3

