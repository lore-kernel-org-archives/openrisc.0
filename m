From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 22 May 2017 23:11:33 +0200 (CEST)
Subject: [OpenRISC] [PATCH 1/1] futex: remove duplicated code
In-Reply-To: <20170515131644.GA3605@arm.com>
References: <20170515130742.18357-1-jslaby@suse.cz>
 <20170515131644.GA3605@arm.com>
Message-ID: <alpine.DEB.2.20.1705222259580.2407@nanos>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, 15 May 2017, Will Deacon wrote:
> Hi Jiri,
> 
> On Mon, May 15, 2017 at 03:07:42PM +0200, Jiri Slaby wrote:
> > There is code duplicated over all architecture's headers for
> > futex_atomic_op_inuser. Namely op decoding, access_ok check for uaddr,
> > and comparison of the result.
> > 
> > Remove this duplication and leave up to the arches only the needed
> > assembly which is now in arch_futex_atomic_op_inuser.
> > 
> > Note that s390 removed access_ok check in d12a29703 ("s390/uaccess:
> > remove pointless access_ok() checks") as access_ok there returns true.
> > We introduce it back to the helper for the sake of simplicity (it gets
> > optimized away anyway).
> 
> Whilst I think this is a good idea, the code in question actually results
> in undefined behaviour per the C spec and is reported by UBSAN. See my
> patch fixing arm64 here (which I'd forgotten about):
> 
> https://www.spinics.net/lists/linux-arch/msg38564.html
> 
> But, as stated in the thread above, I think we should go a step further
> and remove FUTEX_OP_{OR,ANDN,XOR,OPARG_SHIFT} altogether. They don't
> appear to be used by userspace, and this whole thing is a total mess.

You wish. The constants are not used, but FUTEX_WAKE_OP _IS_ used by
glibc. They only have one argument it seems:

   #define FUTEX_OP_CLEAR_WAKE_IF_GT_ONE      ((4 << 24) | 1)

but I'm pretty sure that there is enough (probably horrible) code (think
java) out there using FUTEX_WAKE_OP for whatever (non)sensical reasons in
any available combination.

Thanks,

	tglx
