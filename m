From: Dmitry V. Levin <ldv@altlinux.org>
Date: Wed, 21 Nov 2018 22:00:10 +0300
Subject: [OpenRISC] [PATCH v2 16/15] syscall_get_arch: add "struct
 task_struct *" argument
In-Reply-To: <20181121184004.jro532jopnbmru2m@pburton-laptop>
References: <20181107042751.3b519062@akathisia>
 <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
 <20181120001128.GA11300@altlinux.org>
 <20181121004422.GA29053@altlinux.org>
 <20181121184004.jro532jopnbmru2m@pburton-laptop>
Message-ID: <20181121190009.GA10301@altlinux.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Paul,

On Wed, Nov 21, 2018 at 06:40:06PM +0000, Paul Burton wrote:
> Hi Dmitry,
> 
> On Wed, Nov 21, 2018 at 03:44:22AM +0300, Dmitry V. Levin wrote:
> > This argument is required to extend the generic ptrace API
> > with PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going to be
> > called from ptrace_request() along with other syscall_get_* functions
> > with a tracee as their argument.
> > 
> > This change partially reverts commit 5e937a9ae913 ("syscall_get_arch:
> > remove useless function arguments").
> > 
> >%
> > 
> > diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
> > index 0170602a1e4e..52b633f20abd 100644
> > --- a/arch/mips/include/asm/syscall.h
> > +++ b/arch/mips/include/asm/syscall.h
> > @@ -73,7 +73,7 @@ static inline unsigned long mips_get_syscall_arg(unsigned long *arg,
> >  #ifdef CONFIG_64BIT
> >  	case 4: case 5: case 6: case 7:
> >  #ifdef CONFIG_MIPS32_O32
> > -		if (test_thread_flag(TIF_32BIT_REGS))
> > +		if (test_ti_thread_flag(task_thread_info(task), TIF_32BIT_REGS))
> >  			return get_user(*arg, (int *)usp + n);
> >  		else
> >  #endif
> 
> This ought to be test_tsk_thread_flag(task, TIF_32BIT_REGS) instead of
> open-coding test_tsk_thread_flag.

This will be corrected, thanks for letting me know.

> More fundamentally though, this change doesn't seem to be (directly)
> related to the change you describe in the commit message - it's not
> syscall_get_arch being modified here. I suspect this should be a
> separate commit, or if not please explain in the commit message why this
> change is included.

Good point, this is a fix that should not have been included into this commit.
The bug was found while preparing the syscall_get_arch change, and this
hunk just slipped in.  I'll send it as a separate commit.

> Compounding the lack of clarity is the fact that I only received this
> patch, not the whole series, so I can't view the change in the context
> of the rest of the series.
> 
> > @@ -140,14 +140,14 @@ extern const unsigned long sys_call_table[];
> >  extern const unsigned long sys32_call_table[];
> >  extern const unsigned long sysn32_call_table[];
> >  
> > -static inline int syscall_get_arch(void)
> > +static inline int syscall_get_arch(struct task_struct *task)
> >  {
> >  	int arch = AUDIT_ARCH_MIPS;
> >  #ifdef CONFIG_64BIT
> > -	if (!test_thread_flag(TIF_32BIT_REGS)) {
> > +	if (!test_ti_thread_flag(task_thread_info(task), TIF_32BIT_REGS)) {
> >  		arch |= __AUDIT_ARCH_64BIT;
> >  		/* N32 sets only TIF_32BIT_ADDR */
> > -		if (test_thread_flag(TIF_32BIT_ADDR))
> > +		if (test_ti_thread_flag(task_thread_info(task), TIF_32BIT_ADDR))
> >  			arch |= __AUDIT_ARCH_CONVENTION_MIPS64_N32;
> >  	}
> >  #endif
> 
> This does seem like the described change, but there are 2 more instances
> of open-coding test_tsk_thread_flag which ought to be cleaned up.

This will be cleaned up, thanks for letting me know.


-- 
ldv
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20181121/0639cad7/attachment-0001.sig>
