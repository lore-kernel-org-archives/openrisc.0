From: Richard Henderson <rth@twiddle.net>
Date: Sun, 28 Oct 2018 01:56:29 +0000
Subject: [OpenRISC] [PATCH v3 3/3] or1k: gcc: initial support for
	openrisc
In-Reply-To: <20181027043702.18414-4-shorne@gmail.com>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-4-shorne@gmail.com>
Message-ID: <ced5813d-aef7-1454-de4b-da327a4c2ff7@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 10/27/18 5:37 AM, Stafford Horne wrote:
> +(define_insn "zero_extendhisi2"
> +  [(set (match_operand:SI 0 "register_operand"                    "=r,r")
> +	(zero_extend:SI (match_operand:HI 1 "nonimmediate_operand" "r,m")))]
> +  ""
> +  "@
> +   l.exthz\t%0, %1
> +   l.lhz\t%0, %1"
> +  [(set_attr "insn_support" "sext,*")])
> +
> +(define_insn "zero_extendqisi2"
> +  [(set (match_operand:SI 0 "register_operand"                    "=r,r")
> +	(zero_extend:SI (match_operand:QI 1 "nonimmediate_operand" "r,m")))]
> +  ""
> +  "@
> +   l.extbz\t%0, %1
> +   l.lbz\t%0, %1"
> +  [(set_attr "insn_support" "sext,*")])

The !sext r/r case is just l.andi.


> +;; Sign extension patterns
> +
> +;; We can do memory extensions with a single load
> +(define_insn "extendhisi2"
> +  [(set (match_operand:SI 0 "register_operand"                     "=r,r")
> +	(sign_extend:SI (match_operand:HI 1 "nonimmediate_operand"  "r,m")))]
> +  ""
> +  "@
> +   l.exths\t%0, %1
> +   l.lhs\t%0, %1"
> +  [(set_attr "insn_support" "sext,*")])
> +
> +(define_insn "extendqisi2"
> +  [(set (match_operand:SI 0 "register_operand"                     "=r,r")
> +	(sign_extend:SI (match_operand:QI 1 "nonimmediate_operand"  "r,m")))]
> +  ""
> +  "@
> +   l.extbs\t%0, %1
> +   l.lbs\t%0, %1"
> +  [(set_attr "insn_support" "sext,*")])

You don't really want to give the register allocator no choice but to spill to
memory in the !sext case.  Another r/r case with a splitter that is conditional
on !sext would work.

Otherwise, OK.


r~
