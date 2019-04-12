From: Stafford Horne <shorne@gmail.com>
Date: Sat, 13 Apr 2019 05:21:45 +0900
Subject: [OpenRISC] [PATCH v2 6/6] sim/common: Fix issue with wrong byte
 order on BE targets
In-Reply-To: <20190411222749.GB2737@embecosm.com>
References: <20190409213925.32699-1-shorne@gmail.com>
 <20190409213925.32699-7-shorne@gmail.com>
 <20190411222749.GB2737@embecosm.com>
Message-ID: <20190412202145.GA32284@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Andrew,

On Thu, Apr 11, 2019 at 11:27:49PM +0100, Andrew Burgess wrote:
> * Stafford Horne <shorne@gmail.com> [2019-04-10 06:39:25 +0900]:
> 
> > Currently only the OpenRISC sim uses this JOINSIDF() function to compose a
> > double float from 2 registers.  The old code doesn't seem to work as the
> > work order gets swapped when running on a x86_64 host.  This change
> > fixes that, but I am not sure if its the best thing to do.
> > 
> > On mips they do similar reg pair floating point operations composing
> > doubles from 2 32-bit registers in sim/mips/cp1.c value_fpr().
> > 
> > sim/common/ChangeLog:
> > 
> > 	* cgen-ops.h (JOINSIDF): Fix big endian check.
> > ---
> >  sim/common/cgen-ops.h | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/sim/common/cgen-ops.h b/sim/common/cgen-ops.h
> > index 841552066f..d718394723 100644
> > --- a/sim/common/cgen-ops.h
> > +++ b/sim/common/cgen-ops.h
> > @@ -431,12 +431,8 @@ JOINSIDI (SI x0, SI x1)
> >  SEMOPS_INLINE DF
> >  JOINSIDF (SI x0, SI x1)
> >  {
> > -  union { SI in[2]; DF out; } x;
> > -  if (CURRENT_TARGET_BYTE_ORDER == BFD_ENDIAN_BIG)
> 
> I think this is the problem with the existing code, we're using memory
> on the HOST to perform packing / unpacking, and so its the byte
> ordering of the HOST that we care about here, not the target.
> 
> If I change the above line to instead be:
> 
>      if (HOST_BYTE_ORDER == BFD_ENDIAN_BIG)
> 
> then everything works fine.
> 
> On inspection I believe all of the uses of CURRENT_TARGET_BYTE_ORDER
> in this file should be similarly replaced.
> 
> I've attached a patch for this change.  If you agree I'll go ahead and
> push it.

I tested this with the or1k testsuite and it does seem to work fine, thank you.
Please go ahead.

I thought I had tried this fix as well, I guess not.

-Stafford
