From: Doug Evans <dje@google.com>
Date: Mon, 09 Oct 2017 17:05:58 +0000
Subject: [OpenRISC] [PATCH v5 2/6] sim: cgen: add MUL2OFSI and MUL1OFSI
 macros (needed for OR1K l.mul[u])
Message-ID: <001a113b1b7650e4fd055b2034d6@google.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Stafford Horne writes:
 > On Sat, Oct 07, 2017 at 12:00:55PM -0400, Simon Marchi wrote:
 > > On 2017-10-05 09:49 AM, Stafford Horne wrote:
 > > > From: Peter Gavin <pgavin@gmail.com>
 > > > 
 > > > sim/common/ChangeLog:
 > > > 
 > > > 2012-03-14  Peter Gavin  <pgavin@gmail.com>
 > > > 
 > > > 	* cgen-ops.h (MUL2OFSI): New macro, 1's complement overflow.
 > > > 	(MUL1OFSI): New macro, 2's complement overflow.

Maybe I'm missing something but the text looks backwards.
IOW:

	* cgen-ops.h (MUL2OFSI): New function, 2's complement overflow.
	(MUL1OFSI): New function, 1's complement overflow.

?

OK with that change (and the other suggested changes to date).

 > > 
 > > Macro?  Aren't they functions?
 > 
 > Yes, I am not sure where macro came from.  Maybe I added that, maybe it was
 > there before.
 > 
 > > > ---
 > > >  sim/common/cgen-ops.h | 18 ++++++++++++++++++
 > > >  1 file changed, 18 insertions(+)
 > > > 
 > > > diff --git a/sim/common/cgen-ops.h b/sim/common/cgen-ops.h
 > > > index 97585d7943..ffbdf3fd6e 100644
 > > > --- a/sim/common/cgen-ops.h
 > > > +++ b/sim/common/cgen-ops.h
 > > > @@ -631,6 +631,22 @@ SUBOFQI (QI a, QI b, BI c)
 > > >    return res;
 > > >  }
 > > >  
 > > > +SEMOPS_INLINE BI
 > > > +MUL2OFSI (SI a, SI b)
 > > > +{
 > > > +  DI tmp = MULDI (EXTSIDI(a), EXTSIDI(b));
 > > 
 > > Add spaces before the parentheses.
 > 
 > Right, fixed.
 > 
 > > > +  BI res = tmp < -0x80000000LL || tmp > 0x7fffffffLL;
 > > > +  return res;
 > > > +}
 > > > +
 > > > +SEMOPS_INLINE BI
 > > > +MUL1OFSI (USI a, USI b)
 > > > +{
 > > > +  UDI tmp = MULDI (ZEXTSIDI(a), ZEXTSIDI(b));
 > > 
 > > Here too.
 > > 
 > > Otherwise, this patch makes sense to me.
 > > 
 > > Simon
 > 
 > Thank You
 >  -Stafford

