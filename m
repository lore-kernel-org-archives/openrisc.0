From: Stafford Horne <shorne@gmail.com>
Date: Mon, 29 Oct 2018 22:34:25 +0900
Subject: [OpenRISC] [PATCH v3 3/3] or1k: gcc: initial support for
	openrisc
In-Reply-To: <ed59f12b-a2a3-fa28-0d03-de1d11bb6e42@twiddle.net>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-4-shorne@gmail.com>
 <20181028025730.GH5766@gate.crashing.org>
 <ed59f12b-a2a3-fa28-0d03-de1d11bb6e42@twiddle.net>
Message-ID: <20181029133425.GE1761@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Oct 28, 2018 at 11:16:13PM +0000, Richard Henderson wrote:
> On 10/28/18 2:57 AM, Segher Boessenkool wrote:
> >> +(define_insn "xorsi3"
> >> +  [(set (match_operand:SI 0 "register_operand" "=r,r")
> >> +	  (xor:SI
> >> +	   (match_operand:SI 1 "register_operand"   "%r,r")
> >> +	   (match_operand:SI 2 "reg_or_s16_operand" " r,I")))]
> >> +  ""
> >> +  "@
> >> +  l.xor\t%0, %1, %2
> >> +  l.xori\t%0, %1, %2")
> > 
> > Is this correct?  Should this be unsigned (u16 and K)?
> 
> No, l.xori is signed.

Right, sorry, I didn't have enough time to look at this at all this morning.  It
is correct.

It looks like the documentation for this page [1] is generated from the cgen cpu
descriptions that were removed from binutils-gdb back in 2014.  Ccing cgen who
seem to maintain this web page.  How can we go about getting it regenerated?

cpu/or1korbis.cpu

    (alu-insn-uimm and)
    (alu-insn-uimm or)
    (alu-insn-simm xor)

    (define-pmacro (alu-carry-insn-simm mnemonic)
      (begin
	(dni (.sym l- mnemonic "i")
	     (.str "l." mnemonic "i reg/reg/simm16")
	     ((MACH ORBIS-MACHS))
	     (.str "l." mnemonic "i $rD,$rA,$simm16")
	     (+ (.sym OPC_ (.upcase mnemonic) "I") rD rA simm16)

[1] https://sourceware.org/cgen/gen-doc/openrisc-insn.html#insns

-Stafford
