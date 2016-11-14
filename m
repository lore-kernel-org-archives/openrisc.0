From: Stafford Horne <shorne@gmail.com>
Date: Mon, 14 Nov 2016 22:30:39 +0900
Subject: [OpenRISC] [PATCH v2 9/9] openrisc: include l.swa in check for
	write data pagefault
In-Reply-To: <1479130239-30707-1-git-send-email-shorne@gmail.com>
References: <1479130239-30707-1-git-send-email-shorne@gmail.com>
Message-ID: <a9fae5563e34217ff99efafde7e7bf607a5d5ec6.1479128947.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

During page fault handling we check the last instruction to understand
if the fault was for a read or for a write.  By default we fall back to
read.  New instructions were added to the openrisc 1.1 spec for an
atomic load/store pair (l.lwa/l.swa).

This patch adds the opcode for l.swa (0x33) allowing it to be treated as
a write operation.

Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
[shorne at gmail.com: expanded a bit on the comment]

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index 572d223..aac0bde 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -264,7 +264,7 @@ EXCEPTION_ENTRY(_data_page_fault_handler)
 	l.srli  r6,r6,26                   // check opcode for write access
 #endif
 
-	l.sfgeui r6,0x34		   // check opcode for write access
+	l.sfgeui r6,0x33		   // check opcode for write access
 	l.bnf   1f
 	l.sfleui r6,0x37
 	l.bnf   1f
-- 
2.7.4


