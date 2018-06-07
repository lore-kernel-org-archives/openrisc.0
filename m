From: Ben Hutchings <ben@decadent.org.uk>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Subject: [OpenRISC] [PATCH 3.16 125/410] signal/openrisc: Fix
 do_unaligned_access to send the proper signal
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
Message-ID: <lsq.1528380321.856687679@decadent.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Eric W. Biederman" <ebiederm@xmission.com>

commit 500d58300571b6602341b041f97c082a461ef994 upstream.

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

Fixes: 769a8a96229e ("OpenRISC: Traps")
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: openrisc at lists.librecores.org
Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/openrisc/kernel/traps.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -302,12 +302,12 @@ asmlinkage void do_unaligned_access(stru
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

