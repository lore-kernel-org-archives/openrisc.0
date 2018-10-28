From: Richard Henderson <rth@twiddle.net>
Date: Sun, 28 Oct 2018 23:16:13 +0000
Subject: [OpenRISC] [PATCH v3 3/3] or1k: gcc: initial support for
	openrisc
In-Reply-To: <20181028025730.GH5766@gate.crashing.org>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-4-shorne@gmail.com>
 <20181028025730.GH5766@gate.crashing.org>
Message-ID: <ed59f12b-a2a3-fa28-0d03-de1d11bb6e42@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 10/28/18 2:57 AM, Segher Boessenkool wrote:
>> +(define_insn "xorsi3"
>> +  [(set (match_operand:SI 0 "register_operand" "=r,r")
>> +	  (xor:SI
>> +	   (match_operand:SI 1 "register_operand"   "%r,r")
>> +	   (match_operand:SI 2 "reg_or_s16_operand" " r,I")))]
>> +  ""
>> +  "@
>> +  l.xor\t%0, %1, %2
>> +  l.xori\t%0, %1, %2")
> 
> Is this correct?  Should this be unsigned (u16 and K)?

No, l.xori is signed.


r~
