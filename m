From: Stafford Horne <shorne@gmail.com>
Date: Wed, 31 Oct 2018 07:44:20 +0900
Subject: [OpenRISC] [PATCH v3 3/3] or1k: gcc: initial support for
	openrisc
In-Reply-To: <0d25c0ba-7de0-668c-ebcb-350d17029846@twiddle.net>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-4-shorne@gmail.com>
 <ced5813d-aef7-1454-de4b-da327a4c2ff7@twiddle.net>
 <20181030121806.GB2843@lianli.shorne-pla.net>
 <0d25c0ba-7de0-668c-ebcb-350d17029846@twiddle.net>
Message-ID: <20181030224420.GE2843@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Oct 30, 2018 at 03:57:03PM +0000, Richard Henderson wrote:
> On 10/30/18 12:18 PM, Stafford Horne wrote:
> > OK, I was just being lazy allowing the spill.  Do you think the split/expand
> > would be an RTL using left shift / right shift?  Can you think of something
> > more clever?  Since "real" hardware does not usually support shifts with an
> > immediate we will need 1 instruction to load shift amount. i.e.
> > 
> >   l.ori %0, r0, 24
> >   l.sll %1, %1, %0
> >   l.sra %0, %1, %0
> 
> This clobbers %1.

Right, it was just a rough idea to create another r/r pattern.
 
> So, ouch.  I think we will want to avoid creating this particular pattern in
> the first place unless l.exts exists then.  We would use another pattern like
> 
> (define_insn "*sign_extend_mem<mode>"
>   [(set (match_operand:SI 0 "register_operand" "=r")
> 	(sign_extend:SI
> 	  (match_operand:HI 1 "memory_operand" "m")))]
>   ""
>   "l.lhs\t%0, %1")
> 
> following the TARGET_SEXT pattern.  In this way combine can use this pattern
> without getting us into trouble with the register allocator later.

OK, thats simple enough then.  I had thought you were asking for creating
another r/r pattern using define_split.  That might be better than requiring a
memory load/store to do sign extension, but I guess we can optimize that later
if needed. (Thats what my original thought was.)

-Stafford
