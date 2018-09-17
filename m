From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 18 Sep 2018 00:41:40 +0200
Subject: [OpenRISC] [PATCH 4.9 07/70] kthread: fix boot hang (regression) on
	MIPS/OpenRISC
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
Message-ID: <20180917211649.775405318@linuxfoundation.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vegard Nossum <vegard.nossum@oracle.com>

commit b0f5a8f32e8bbdaae1abb8abe2d3cbafaba57e08 upstream.

This fixes a regression in commit 4d6501dce079 where I didn't notice
that MIPS and OpenRISC were reinitialising p->{set,clear}_child_tid to
NULL after our initialisation in copy_process().

We can simply get rid of the arch-specific initialisation here since it
is now always done in copy_process() before hitting copy_thread{,_tls}().

Review notes:

 - As far as I can tell, copy_process() is the only user of
   copy_thread_tls(), which is the only caller of copy_thread() for
   architectures that don't implement copy_thread_tls().

 - After this patch, there is no arch-specific code touching
   p->set_child_tid or p->clear_child_tid whatsoever.

 - It may look like MIPS/OpenRISC wanted to always have these fields be
   NULL, but that's not true, as copy_process() would unconditionally
   set them again _after_ calling copy_thread_tls() before commit
   4d6501dce079.

Fixes: 4d6501dce079c1eb6bf0b1d8f528a5e81770109e ("kthread: Fix use-after-free if kthread fork fails")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net> # MIPS only
Acked-by: Stafford Horne <shorne@gmail.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips at linux-mips.org
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: openrisc at lists.librecores.org
Cc: Jamie Iles <jamie.iles@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/process.c     |    1 -
 arch/openrisc/kernel/process.c |    2 --
 2 files changed, 3 deletions(-)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -118,7 +118,6 @@ int copy_thread(unsigned long clone_flag
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs, *regs = current_pt_regs();
 	unsigned long childksp;
-	p->set_child_tid = p->clear_child_tid = NULL;
 
 	childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
 
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -152,8 +152,6 @@ copy_thread(unsigned long clone_flags, u
 
 	top_of_kernel_stack = sp;
 
-	p->set_child_tid = p->clear_child_tid = NULL;
-
 	/* Locate userspace context on stack... */
 	sp -= STACK_FRAME_OVERHEAD;	/* redzone */
 	sp -= sizeof(struct pt_regs);


