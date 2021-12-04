From: Stafford Horne <shorne@gmail.com>
Date: Sat,  4 Dec 2021 11:18:42 +0900
Subject: [OpenRISC] [PATCH 3/3] openrisc: Add clone3 ABI wrapper
In-Reply-To: <20211204021842.1853549-1-shorne@gmail.com>
References: <20211204021842.1853549-1-shorne@gmail.com>
Message-ID: <20211204021842.1853549-4-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Like fork and clone the clone3 syscall needs a wrapper to save callee
saved registers, which is required by the OpenRISC ABI.  This came up
after auditing code following a discussion with Rob Landley and Arnd
Bergmann [0].

Tested with the clone3 kselftests and there were no issues.

[0] https://lore.kernel.org/all/41206fc7-f8ce-98aa-3718-ba3e1431e320 at landley.net/T/#m9c0cdb2703813b9df4da04cf6b30de1f1aa89944

Fixes: 07e83dfbe16c ("openrisc: Enable the clone3 syscall")
Cc: Rob Landley <rob@landley.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/syscalls.h | 2 ++
 arch/openrisc/kernel/entry.S         | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/openrisc/include/asm/syscalls.h b/arch/openrisc/include/asm/syscalls.h
index 3a7eeae6f56a..aa1c7e98722e 100644
--- a/arch/openrisc/include/asm/syscalls.h
+++ b/arch/openrisc/include/asm/syscalls.h
@@ -22,9 +22,11 @@ asmlinkage long sys_or1k_atomic(unsigned long type, unsigned long *v1,
 
 asmlinkage long __sys_clone(unsigned long clone_flags, unsigned long newsp,
 			void __user *parent_tid, void __user *child_tid, int tls);
+asmlinkage long __sys_clone3(struct clone_args __user *uargs, size_t size);
 asmlinkage long __sys_fork(void);
 
 #define sys_clone __sys_clone
+#define sys_clone3 __sys_clone3
 #define sys_fork __sys_fork
 
 #endif /* __ASM_OPENRISC_SYSCALLS_H */
diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index 8cd2113057c5..3ca1b1f490b9 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -1165,6 +1165,11 @@ ENTRY(__sys_clone)
 	l.j	_fork_save_extra_regs_and_call
 	 l.ori	r29,r29,lo(sys_clone)
 
+ENTRY(__sys_clone3)
+	l.movhi	r29,hi(sys_clone3)
+	l.j	_fork_save_extra_regs_and_call
+	 l.ori	r29,r29,lo(sys_clone3)
+
 ENTRY(__sys_fork)
 	l.movhi	r29,hi(sys_fork)
 	l.j	_fork_save_extra_regs_and_call
-- 
2.31.1

