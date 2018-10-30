From: Richard Henderson <rth@twiddle.net>
Date: Tue, 30 Oct 2018 15:57:03 +0000
Subject: [OpenRISC] [PATCH v3 3/3] or1k: gcc: initial support for
	openrisc
In-Reply-To: <20181030121806.GB2843@lianli.shorne-pla.net>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-4-shorne@gmail.com>
 <ced5813d-aef7-1454-de4b-da327a4c2ff7@twiddle.net>
 <20181030121806.GB2843@lianli.shorne-pla.net>
Message-ID: <0d25c0ba-7de0-668c-ebcb-350d17029846@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 10/30/18 12:18 PM, Stafford Horne wrote:
> OK, I was just being lazy allowing the spill.  Do you think the split/expand
> would be an RTL using left shift / right shift?  Can you think of something
> more clever?  Since "real" hardware does not usually support shifts with an
> immediate we will need 1 instruction to load shift amount. i.e.
> 
>   l.ori %0, r0, 24
>   l.sll %1, %1, %0
>   l.sra %0, %1, %0

This clobbers %1.

So, ouch.  I think we will want to avoid creating this particular pattern in
the first place unless l.exts exists then.  We would use another pattern like

(define_insn "*sign_extend_mem<mode>"
  [(set (match_operand:SI 0 "register_operand" "=r")
	(sign_extend:SI
	  (match_operand:HI 1 "memory_operand" "m")))]
  ""
  "l.lhs\t%0, %1")

following the TARGET_SEXT pattern.  In this way combine can use this pattern
without getting us into trouble with the register allocator later.

> I am submitting patches on my git branch or1k-port-4. Just in case you want to
> track progress.

Will do.


r~
