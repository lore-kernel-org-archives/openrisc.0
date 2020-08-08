From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Sun, 9 Aug 2020 01:08:42 +0200
Subject: [OpenRISC] [PATCH v2 5/6] openrisc: signal: Fix sparse address
 space warnings
In-Reply-To: <20200808224822.GQ80756@lianli.shorne-pla.net>
References: <20200805210725.310301-1-shorne@gmail.com>
 <20200805210725.310301-6-shorne@gmail.com>
 <20200806190449.xqflhmbiiv5btusf@ltop.local>
 <20200808224822.GQ80756@lianli.shorne-pla.net>
Message-ID: <20200808230842.4bdwrvuz3lbgkcom@ltop.local>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Aug 09, 2020 at 07:48:22AM +0900, Stafford Horne wrote:
> On Thu, Aug 06, 2020 at 09:04:49PM +0200, Luc Van Oostenryck wrote:
> > On Thu, Aug 06, 2020 at 06:07:24AM +0900, Stafford Horne wrote:
> > > ---
> > >  arch/openrisc/kernel/signal.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
> > > index 4f0754874d78..7ce0728412f6 100644
> > > --- a/arch/openrisc/kernel/signal.c
> > > +++ b/arch/openrisc/kernel/signal.c
> > > @@ -76,7 +76,7 @@ asmlinkage long _sys_rt_sigreturn(struct pt_regs *regs)
> > >  	 * then frame should be dword aligned here.  If it's
> > >  	 * not, then the user is trying to mess with us.
> > >  	 */
> > > -	if (((long)frame) & 3)
> > > +	if (((__force unsigned long)frame) & 3)
> > >  		goto badframe;
> > 
> > Same as patch 6, the __force is not needed.
> 
> Thanks,  I thought this was complaining before, I tested now and there is no
> problem so I must have been mixed up with something else.

Sparse should have complained with with the cast to long but
purposely doesn't with unsigned long (or uintptr_t).
So, no mix up, I think.
 
Cheers,
-- Luc
