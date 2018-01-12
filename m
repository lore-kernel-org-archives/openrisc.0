From: Eric W. Biederman <ebiederm@xmission.com>
Date: Thu, 11 Jan 2018 18:59:32 -0600
Subject: [OpenRISC] [PATCH 03/11] signal/openrisc: Fix do_unaligned_access
	to send the proper signal
In-Reply-To: <87373b6ghs.fsf@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
Message-ID: <20180112005940.23279-3-ebiederm@xmission.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

While reviewing the signal sending on openrisc the do_unaligned_access
function stood out because it is obviously wrong.  A comment about an
si_code set above when actually si_code is never set.  Leading to a
random si_code being sent to userspace in the event of an unaligned
access.

Looking further SIGBUS BUS_ADRALN is the proper pair of signal and
si_code to send for an unaligned access. That is what other
architectures do and what is required by posix.

Given that do_unaligned_access is broken in a way that no one can be
relying on it on openrisc fix the code to just do the right thing.

Cc: stable at vger.kernel.org
Fixes: 769a8a96229e ("OpenRISC: Traps")
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: openrisc at lists.librecores.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/openrisc/kernel/traps.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 4085d72fa5ae..9e38dc66c9e4 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -266,12 +266,12 @@ asmlinkage void do_unaligned_access(struct pt_regs *regs, unsigned long address)
 	siginfo_t info;
 
 	if (user_mode(regs)) {
-		/* Send a SIGSEGV */
-		info.si_signo = SIGSEGV;
+		/* Send a SIGBUS */
+		info.si_signo = SIGBUS;
 		info.si_errno = 0;
-		/* info.si_code has been set above */
-		info.si_addr = (void *)address;
-		force_sig_info(SIGSEGV, &info, current);
+		info.si_code = BUS_ADRALN;
+		info.si_addr = (void __user *)address;
+		force_sig_info(SIGBUS, &info, current);
 	} else {
 		printk("KERNEL: Unaligned Access 0x%.8lx\n", address);
 		show_registers(regs);
-- 
2.14.1

