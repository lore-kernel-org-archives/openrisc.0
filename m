From: Stafford Horne <shorne@gmail.com>
Date: Thu, 8 Apr 2021 05:12:58 +0900
Subject: [OpenRISC] [PATCH v6 1/9] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
In-Reply-To: <YG1/xRgWlLHD4j/8@hirez.programming.kicks-ass.net>
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
 <1617201040-83905-2-git-send-email-guoren@kernel.org>
 <YGyRrBjomDCPOBUd@boqun-archlinux>
 <20210406235208.GG3288043@lianli.shorne-pla.net>
 <YG1/xRgWlLHD4j/8@hirez.programming.kicks-ass.net>
Message-ID: <20210407201258.GH3288043@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Apr 07, 2021 at 11:47:49AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 07, 2021 at 08:52:08AM +0900, Stafford Horne wrote:
> > Why doesn't RISC-V add the xchg16 emulation code similar to OpenRISC?  For
> > OpenRISC we added xchg16 and xchg8 emulation code to enable qspinlocks.  So
> > one thought is with CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32=y, can we remove our
> > xchg16/xchg8 emulation code?
> 
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32 is guaranteed crap.
>
> All the architectures that have wanted it are RISC style LL/SC archs,
> and for them a cmpxchg loop is a daft thing to do, since it reduces the
> chance of it behaving sanely.
> 
> Why would we provide something that's known to be suboptimal? If an
> architecture chooses to not care about determinism and or fwd progress,
> then that's their choice. But not one, I feel, we should encourage.

Thanks, this is the response I was hoping my comment would provoke.

So not enabling CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32 for architectures
unless they really want it should be the way.

-Stafford
