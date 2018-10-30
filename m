From: Stafford Horne <shorne@gmail.com>
Date: Tue, 30 Oct 2018 21:18:06 +0900
Subject: [OpenRISC] [PATCH v3 3/3] or1k: gcc: initial support for
	openrisc
In-Reply-To: <ced5813d-aef7-1454-de4b-da327a4c2ff7@twiddle.net>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-4-shorne@gmail.com>
 <ced5813d-aef7-1454-de4b-da327a4c2ff7@twiddle.net>
Message-ID: <20181030121806.GB2843@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Oct 28, 2018 at 01:56:29AM +0000, Richard Henderson wrote:
> On 10/27/18 5:37 AM, Stafford Horne wrote:
> > +(define_insn "zero_extendhisi2"
> > +  [(set (match_operand:SI 0 "register_operand"                    "=r,r")
> > +	(zero_extend:SI (match_operand:HI 1 "nonimmediate_operand" "r,m")))]
> > +  ""
> > +  "@
> > +   l.exthz\t%0, %1
> > +   l.lhz\t%0, %1"
> > +  [(set_attr "insn_support" "sext,*")])
> > +
> > +(define_insn "zero_extendqisi2"
> > +  [(set (match_operand:SI 0 "register_operand"                    "=r,r")
> > +	(zero_extend:SI (match_operand:QI 1 "nonimmediate_operand" "r,m")))]
> > +  ""
> > +  "@
> > +   l.extbz\t%0, %1
> > +   l.lbz\t%0, %1"
> > +  [(set_attr "insn_support" "sext,*")])
> 
> The !sext r/r case is just l.andi.

OK.

> > +;; Sign extension patterns
> > +
> > +;; We can do memory extensions with a single load
> > +(define_insn "extendhisi2"
> > +  [(set (match_operand:SI 0 "register_operand"                     "=r,r")
> > +	(sign_extend:SI (match_operand:HI 1 "nonimmediate_operand"  "r,m")))]
> > +  ""
> > +  "@
> > +   l.exths\t%0, %1
> > +   l.lhs\t%0, %1"
> > +  [(set_attr "insn_support" "sext,*")])
> > +
> > +(define_insn "extendqisi2"
> > +  [(set (match_operand:SI 0 "register_operand"                     "=r,r")
> > +	(sign_extend:SI (match_operand:QI 1 "nonimmediate_operand"  "r,m")))]
> > +  ""
> > +  "@
> > +   l.extbs\t%0, %1
> > +   l.lbs\t%0, %1"
> > +  [(set_attr "insn_support" "sext,*")])
> 
> You don't really want to give the register allocator no choice but to spill to
> memory in the !sext case.  Another r/r case with a splitter that is conditional
> on !sext would work.

OK, I was just being lazy allowing the spill.  Do you think the split/expand
would be an RTL using left shift / right shift?  Can you think of something
more clever?  Since "real" hardware does not usually support shifts with an
immediate we will need 1 instruction to load shift amount. i.e.

  l.ori %0, r0, 24
  l.sll %1, %1, %0
  l.sra %0, %1, %0

If we support shift with immediate it would just be:

  l.slli %1, %1, 24
  l.srai %0, %1, 24

But, I cant think of anything better.

> Otherwise, OK.

Thanks,

I am submitting patches on my git branch or1k-port-4. Just in case you want to
track progress.

 - Stafford
