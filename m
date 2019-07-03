From: Stafford Horne <shorne@gmail.com>
Date: Thu, 4 Jul 2019 06:49:17 +0900
Subject: [OpenRISC] [PATCH v2 3/5] or1k: Add mrori option,
 fix option docs
In-Reply-To: <20190703144902.GX18316@gate.crashing.org>
References: <20190703033351.11924-1-shorne@gmail.com>
 <20190703033351.11924-4-shorne@gmail.com>
 <20190703144902.GX18316@gate.crashing.org>
Message-ID: <20190703214917.GB2601@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Jul 03, 2019 at 09:49:02AM -0500, Segher Boessenkool wrote:
> On Wed, Jul 03, 2019 at 12:33:49PM +0900, Stafford Horne wrote:
> > @@ -179,11 +183,11 @@
> >    [(set (match_operand:SI 0 "register_operand" "=r,r")
> >  	(rotatert:SI (match_operand:SI 1 "register_operand"  "r,r")
> >  		  (match_operand:SI 2 "reg_or_u6_operand" "r,n")))]
> > -  "TARGET_ROR"
> > +  "TARGET_ROR || TARGET_RORI"
> >    "@
> >     l.ror\t%0, %1, %2
> >     l.rori\t%0, %1, %2"
> > -  [(set_attr "insn_support" "*,shftimm")])
> > +  [(set_attr "insn_support" "ror,rori")])
> 
> Does this work?  If you use -mno-ror -mrori?  It will then allow generating
> a reg for the second operand, and ICE later on, as far as I can see?

It does seem to work.  Why would it produce an internal compiler error?

One thing I have is RegectNegative on mror and mrori, so -mno-ror will not be
allowed and cause an error.

Example: 

    $ cat ./gcc/testsuite/gcc.target/or1k/ror-4.c

	unsigned int rotate6 (unsigned int a) {
	  return ( a >> 6 ) | ( a << ( 32 - 6 ) );
	}

# With rori, direct immediate.

    $ or1k-elf-gcc -O2 -c -mrori ./gcc/testsuite/gcc.target/or1k/ror-4.c 
    $ or1k-elf-objdump -d ror-4.o 

	ror-4.o:     file format elf32-or1k

	Disassembly of section .text:

	00000000 <rotate6>:
	   0:   44 00 48 00     l.jr r9
	   4:   b9 63 00 c6     l.rori r11,r3,0x6

# With ror, loading immediate to temporary register first.

    $ or1k-elf-gcc -O2 -c -mror ./gcc/testsuite/gcc.target/or1k/ror-4.c 
    $ or1k-elf-objdump -d ror-4.o 

	ror-4.o:     file format elf32-or1k

	Disassembly of section .text:

	00000000 <rotate6>:
	   0:   aa 20 00 06     l.ori r17,r0,0x6
	   4:   44 00 48 00     l.jr r9
	   8:   e1 63 88 c8     l.ror r11,r3,r17

-Stafford
