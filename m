From: Stafford Horne <shorne@gmail.com>
Date: Sat,  4 Dec 2021 11:18:41 +0900
Subject: [OpenRISC] [PATCH 2/3] openrisc: Use delay slot for clone and fork
 wrappers
In-Reply-To: <20211204021842.1853549-1-shorne@gmail.com>
References: <20211204021842.1853549-1-shorne@gmail.com>
Message-ID: <20211204021842.1853549-3-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This saves one instruction.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/entry.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index c608f76e5753..8cd2113057c5 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -1162,15 +1162,13 @@ _fork_save_extra_regs_and_call:
 
 ENTRY(__sys_clone)
 	l.movhi	r29,hi(sys_clone)
-	l.ori	r29,r29,lo(sys_clone)
 	l.j	_fork_save_extra_regs_and_call
-	 l.nop
+	 l.ori	r29,r29,lo(sys_clone)
 
 ENTRY(__sys_fork)
 	l.movhi	r29,hi(sys_fork)
-	l.ori	r29,r29,lo(sys_fork)
 	l.j	_fork_save_extra_regs_and_call
-	 l.nop
+	 l.ori	r29,r29,lo(sys_fork)
 
 ENTRY(sys_rt_sigreturn)
 	l.jal	_sys_rt_sigreturn
-- 
2.31.1

