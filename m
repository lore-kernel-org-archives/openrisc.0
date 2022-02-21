From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Mon, 21 Feb 2022 16:21:30 +0100
Subject: [OpenRISC] [PATCH v2 09/18] mips: use simpler access_ok()
In-Reply-To: <CAK8P3a2usZWPDDDUcscwS0aVKsY6aLXFGFPqYNkm4hcDERim9w@mail.gmail.com>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-10-arnd@kernel.org>
 <20220221132456.GA7139@alpha.franken.de>
 <CAK8P3a2usZWPDDDUcscwS0aVKsY6aLXFGFPqYNkm4hcDERim9w@mail.gmail.com>
Message-ID: <20220221152130.GA17373@alpha.franken.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Feb 21, 2022 at 03:31:23PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 21, 2022 at 2:24 PM Thomas Bogendoerfer
> <tsbogend@alpha.franken.de> wrote:
> > On Wed, Feb 16, 2022 at 02:13:23PM +0100, Arnd Bergmann wrote:
> > >
> > > diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
> > > index db9a8e002b62..d7c89dc3426c 100644
> >
> > this doesn't work. For every access above maximum implemented virtual address
> > space of the CPU an address error will be issued, but not a TLB miss.
> > And address error isn't able to handle this situation.
> 
> Ah, so the __ex_table entry only catches TLB misses?

no, but there is no __ex_table handling in address error hanlder (yet).

> Does this mean it also traps for kernel memory accesses, or do those
> work again?

it will trap for every access.


> If the addresses on mips64 are separate like on
> sparc64 or s390, the entire access_ok() step could be replaced
> by a fixup code in the exception handler. I suppose this depends on
> CONFIG_EVA and you still need a limit check at least when EVA is
> disabled.

only EVA has seperate address spaces for kernel/user.

> > Is there a reason to not also #define TASK_SIZE_MAX   __UA_LIMIT like
> > for the 32bit case ?
> >
> 
> For 32-bit, the __UA_LIMIT is a compile-time constant, so the check
> ends up being trivial. On all other architectures, the same thing can
> be done after the set_fs removal, so I was hoping it would work here
> as well.

ic

> I suspect doing the generic (size <= limit) && (addr <= (limit - size))
> check on mips64 with the runtime limit ends up slightly slower
> than the current code that checks a bit mask instead. If you like,
> I'll update it this way, otherwise I'd need help in form of a patch
> that changes the exception handling so __get_user/__put_user
> also return -EFAULT for an address error.

that's what the patch does. For aligned accesses the patch should
do the right thing, but it breaks unaligned get_user/put_user.
Checking if the trapping vaddr is between end of CPU VM space and
TASK_MAX_SIZE before exception handling should do the trick. I'll
send a patch, if this works.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
