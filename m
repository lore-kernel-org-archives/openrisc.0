From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Wed, 3 Jul 2019 17:26:58 -0500
Subject: [OpenRISC] [PATCH v2 3/5] or1k: Add mrori option,
 fix option docs
In-Reply-To: <20190703214917.GB2601@lianli.shorne-pla.net>
References: <20190703033351.11924-1-shorne@gmail.com>
 <20190703033351.11924-4-shorne@gmail.com>
 <20190703144902.GX18316@gate.crashing.org>
 <20190703214917.GB2601@lianli.shorne-pla.net>
Message-ID: <20190703222658.GD18316@gate.crashing.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Jul 04, 2019 at 06:49:17AM +0900, Stafford Horne wrote:
> On Wed, Jul 03, 2019 at 09:49:02AM -0500, Segher Boessenkool wrote:
> > On Wed, Jul 03, 2019 at 12:33:49PM +0900, Stafford Horne wrote:
> > > @@ -179,11 +183,11 @@
> > >    [(set (match_operand:SI 0 "register_operand" "=r,r")
> > >  	(rotatert:SI (match_operand:SI 1 "register_operand"  "r,r")
> > >  		  (match_operand:SI 2 "reg_or_u6_operand" "r,n")))]
> > > -  "TARGET_ROR"
> > > +  "TARGET_ROR || TARGET_RORI"
> > >    "@
> > >     l.ror\t%0, %1, %2
> > >     l.rori\t%0, %1, %2"
> > > -  [(set_attr "insn_support" "*,shftimm")])
> > > +  [(set_attr "insn_support" "ror,rori")])
> > 
> > Does this work?  If you use -mno-ror -mrori?  It will then allow generating
> > a reg for the second operand, and ICE later on, as far as I can see?
> 
> It does seem to work.  Why would it produce an internal compiler error?
> 
> One thing I have is RegectNegative on mror and mrori, so -mno-ror will not be
> allowed and cause an error.

But both options are off by default, and neither is enabled or disabled
based on the setting of the other.

> Example: 
> 
>     $ cat ./gcc/testsuite/gcc.target/or1k/ror-4.c
> 
> 	unsigned int rotate6 (unsigned int a) {
> 	  return ( a >> 6 ) | ( a << ( 32 - 6 ) );
> 	}

That's a fixed distance rotate.  My question is will it work if the
distance is a variable.  The other direction should work fine, agreed.

So, does ror-[12].c work with -mrori and no -mror?  The predicates say
this insn pattern is just fine in that case, but the constraints will
disagree.


Segher
