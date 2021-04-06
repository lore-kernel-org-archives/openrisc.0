From: Stafford Horne <shorne@gmail.com>
Date: Wed, 7 Apr 2021 08:52:08 +0900
Subject: [OpenRISC] [PATCH v6 1/9] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
In-Reply-To: <YGyRrBjomDCPOBUd@boqun-archlinux>
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
 <1617201040-83905-2-git-send-email-guoren@kernel.org>
 <YGyRrBjomDCPOBUd@boqun-archlinux>
Message-ID: <20210406235208.GG3288043@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Apr 07, 2021 at 12:51:56AM +0800, Boqun Feng wrote:
> Hi,
> 
> On Wed, Mar 31, 2021 at 02:30:32PM +0000, guoren at kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> > 
> > Some architectures don't have sub-word swap atomic instruction,
> > they only have the full word's one.
> > 
> > The sub-word swap only improve the performance when:
> > NR_CPUS < 16K
> >  *  0- 7: locked byte
> >  *     8: pending
> >  *  9-15: not used
> >  * 16-17: tail index
> >  * 18-31: tail cpu (+1)
> > 
> > The 9-15 bits are wasted to use xchg16 in xchg_tail.
> > 
> > Please let architecture select xchg16/xchg32 to implement
> > xchg_tail.
> > 
> 
> If the architecture doesn't have sub-word swap atomic, won't it generate
> the same/similar code no matter which version xchg_tail() is used? That
> is even CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32=y, xchg_tail() acts
> similar to an xchg16() implemented by cmpxchg(), which means we still
> don't have forward progress guarantee. So this configuration doesn't
> solve the problem.
> 
> I think it's OK to introduce this config and don't provide xchg16() for
> risc-v. But I don't see the point of converting other architectures to
> use it.

Hello,

For OpenRISC I did ack the patch to convert to
CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32=y.  But I think you are right, the
generic code in xchg_tail and the xchg16 emulation code in produced by OpenRISC
using xchg32 would produce very similar code.  I have not compared instructions,
but it does seem like duplicate functionality.

Why doesn't RISC-V add the xchg16 emulation code similar to OpenRISC?  For
OpenRISC we added xchg16 and xchg8 emulation code to enable qspinlocks.  So
one thought is with CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32=y, can we remove our
xchg16/xchg8 emulation code?

-Stafford
