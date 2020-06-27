From: Greentime Hu <green.hu@gmail.com>
Date: Sat, 27 Jun 2020 11:10:05 +0800
Subject: [OpenRISC] [PATCH 17/17] arch: rename copy_thread_tls() back to
 copy_thread()
In-Reply-To: <20200622234326.906346-18-christian.brauner@ubuntu.com>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
 <20200622234326.906346-18-christian.brauner@ubuntu.com>
Message-ID: <CAEbi=3fbt_3DBEMhWUKY04KNxR=Xv0zesFGrJJDnx5D-8KUaaw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Christian Brauner <christian.brauner@ubuntu.com> 於 2020年6月23日 週二 上午7:58寫道：
>
> Now that HAVE_COPY_THREAD_TLS has been removed, rename copy_thread_tls()
> back simply copy_thread(). It's a simpler name, and doesn't imply that only
> tls is copied here. This finishes an outstanding chunk of internal process
> creation work since we've added clone3().
>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Brian Cain <bcain@codeaurora.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Nick Hu <nickhu@andestech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Vincent Chen <deanbo422@gmail.com>
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Rich Felker <dalias@libc.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Guan Xuetao <gxt@pku.edu.cn>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: x86 at kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-alpha at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-snps-arc at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-c6x-dev at linux-c6x.org
> Cc: linux-csky at vger.kernel.org
> Cc: uclinux-h8-devel at lists.sourceforge.jp
> Cc: linux-hexagon at vger.kernel.org
> Cc: linux-ia64 at vger.kernel.org
> Cc: linux-m68k at lists.linux-m68k.org
> Cc: linux-mips at vger.kernel.org
> Cc: openrisc at lists.librecores.org
> Cc: linux-parisc at vger.kernel.org
> Cc: linuxppc-dev at lists.ozlabs.org
> Cc: linux-riscv at lists.infradead.org
> Cc: linux-s390 at vger.kernel.org
> Cc: linux-sh at vger.kernel.org
> Cc: sparclinux at vger.kernel.org
> Cc: linux-um at lists.infradead.org
> Cc: linux-xtensa at linux-xtensa.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  arch/alpha/kernel/process.c      | 2 +-
>  arch/arc/kernel/process.c        | 2 +-
>  arch/arm/kernel/process.c        | 2 +-
>  arch/arm64/kernel/process.c      | 2 +-
>  arch/c6x/kernel/process.c        | 2 +-
>  arch/csky/kernel/process.c       | 2 +-
>  arch/h8300/kernel/process.c      | 2 +-
>  arch/hexagon/kernel/process.c    | 2 +-
>  arch/ia64/kernel/process.c       | 4 ++--
>  arch/m68k/kernel/process.c       | 2 +-
>  arch/microblaze/kernel/process.c | 2 +-
>  arch/mips/kernel/process.c       | 2 +-
>  arch/nds32/kernel/process.c      | 2 +-
>  arch/nios2/kernel/process.c      | 2 +-
>  arch/openrisc/kernel/process.c   | 4 ++--
>  arch/parisc/kernel/process.c     | 2 +-
>  arch/powerpc/kernel/process.c    | 2 +-
>  arch/riscv/kernel/process.c      | 2 +-
>  arch/s390/kernel/process.c       | 2 +-
>  arch/sh/kernel/process_32.c      | 2 +-
>  arch/sparc/kernel/process.c      | 6 +++---
>  arch/sparc/kernel/process_32.c   | 2 +-
>  arch/sparc/kernel/process_64.c   | 2 +-
>  arch/um/kernel/process.c         | 2 +-
>  arch/unicore32/kernel/process.c  | 2 +-
>  arch/x86/kernel/process.c        | 2 +-
>  arch/x86/kernel/unwind_frame.c   | 2 +-
>  arch/xtensa/kernel/process.c     | 2 +-
>  include/linux/sched/task.h       | 2 +-
>  kernel/fork.c                    | 2 +-
>  30 files changed, 34 insertions(+), 34 deletions(-)
>
> [...]
> diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
> index 7dbb1bf64165..1020e2c6dcd8 100644
> --- a/arch/nds32/kernel/process.c
> +++ b/arch/nds32/kernel/process.c
> @@ -149,7 +149,7 @@ void flush_thread(void)
>  DEFINE_PER_CPU(struct task_struct *, __entry_task);
>
>  asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
> -int copy_thread_tls(unsigned long clone_flags, unsigned long stack_start,
> +int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>                     unsigned long stk_sz, struct task_struct *p,
>                     unsigned long tls)
>  {

Hi Christian, Thank you.
Acked-by: Greentime Hu <green.hu@gmail.com>
