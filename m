From: Stafford Horne <shorne@gmail.com>
Date: Fri, 6 Nov 2020 06:38:35 +0900
Subject: [OpenRISC] [PATCH] openrisc: add support for TIF_NOTIFY_SIGNAL
In-Reply-To: <874e8313-49bd-3b14-8981-daaa7b0d3992@kernel.dk>
References: <35f5c4f7-06d9-ea5b-1bc1-f26b16eefca0@kernel.dk>
 <1c01cbf6-78ff-e33a-ee7c-57249e3bc6d8@kernel.dk>
 <874e8313-49bd-3b14-8981-daaa7b0d3992@kernel.dk>
Message-ID: <20201105213835.GD3294551@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Nov 05, 2020 at 11:15:23AM -0700, Jens Axboe wrote:
> Adding folks from MAINTAINERS, as the list appears closed.

Thanks, I didn't realize the list was broken, I will ask the admins
about it.

> 
> On 11/5/20 9:18 AM, Jens Axboe wrote:
> > Gentle nudge on this one.
> > 
> > On 10/29/20 10:18 AM, Jens Axboe wrote:
> >> Wire up TIF_NOTIFY_SIGNAL handling for openrisc.
> >>
> >> Cc: openrisc at lists.librecores.org
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >> ---
> >>
> >> 5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
> >> for details:
> >>
> >> https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe at kernel.dk/
> >>
> >> As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
> >> as that will enable a set of cleanups once all of them support it. I'm
> >> happy carrying this patch if need be, or it can be funelled through the
> >> arch tree. Let me know.

Please carry it, you can maintain the dependencies easier.

> >>  arch/openrisc/include/asm/thread_info.h | 2 ++
> >>  arch/openrisc/kernel/signal.c           | 2 +-
> >>  2 files changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/openrisc/include/asm/thread_info.h b/arch/openrisc/include/asm/thread_info.h
> >> index 9afe68bc423b..4f9d2a261455 100644
> >> --- a/arch/openrisc/include/asm/thread_info.h
> >> +++ b/arch/openrisc/include/asm/thread_info.h
> >> @@ -98,6 +98,7 @@ register struct thread_info *current_thread_info_reg asm("r10");
> >>  #define TIF_SINGLESTEP		4	/* restore singlestep on return to user
> >>  					 * mode
> >>  					 */
> >> +#define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
> >>  #define TIF_SYSCALL_TRACEPOINT  8       /* for ftrace syscall instrumentation */
> >>  #define TIF_RESTORE_SIGMASK     9
> >>  #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling						 * TIF_NEED_RESCHED
> >> @@ -109,6 +110,7 @@ register struct thread_info *current_thread_info_reg asm("r10");
> >>  #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
> >>  #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
> >>  #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
> >> +#define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
> >>  #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
> >>  
> >>  
> >> diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
> >> index af66f968dd45..1ebcff271096 100644
> >> --- a/arch/openrisc/kernel/signal.c
> >> +++ b/arch/openrisc/kernel/signal.c
> >> @@ -299,7 +299,7 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
> >>  			if (unlikely(!user_mode(regs)))
> >>  				return 0;
> >>  			local_irq_enable();
> >> -			if (thread_flags & _TIF_SIGPENDING) {
> >> +			if (thread_flags & (_TIF_SIGPENDING|_TIF_NOTIFY_SIGNAL)) {
> >>  				int restart = do_signal(regs, syscall);
> >>  				if (unlikely(restart)) {
> >>  					/*
> >>
> > 
> > 
> 
> 
> -- 
> Jens Axboe

This looks fine to me.

Acked-by: Stafford Horne <shorne@gmail.com>

