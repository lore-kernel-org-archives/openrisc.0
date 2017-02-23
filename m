From: Richard Henderson <rth@twiddle.net>
Date: Thu, 23 Feb 2017 12:01:20 +1100
Subject: [OpenRISC] gcc7 port and improvements
Message-ID: <93ad6594-b3f1-5a4f-14d4-f45cb72229f5@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Several years ago I did some cleanup work to the openrisc gcc port, but wasn't 
able to test it properly, so it languished.

I have recently rebased that onto the gcc7 branch that is nearing release. 
Test results are fairly good using qemu for testing (I do have some odd linkage 
problems that suggest that I ought to rebuild my old sys-root from scratch).

I won't post patches here unless desired, but instead a link to my branch:

   git://github.com/rth7680/gcc.git or1k-7-2

An incomplete list of visible improvements are:

   * 64-bit arithmetic using addc/addic.

   * Define "cstore" pattern, i.e. comparisons with a boolean result,
     e.g. x = (y < 0).  This can use addc or cmov.

   * Prologue rewritten to take advantage of red-zone, and only store
     registers that are required.

   * Tail calls added.

   * Atomic operations rewritten to properly handle delay slots.

   * The -fpic register is chosen dynamically.  This allows us to use
     a call-clobbered register for leaf functions.


If this goes well, I have some additional patches to revive that enhance both 
binutils and gcc with additional relocations so that the low-part of an address 
can be moved into a load or store offset.  E.g. instead of

	l.movhi	r4, hi(foo)
	l.ori	r4, r4, lo(foo)
	l.lw	r5, 0(r4)
	l.sw	0(r4), r6

we can do

	l.movhi	r4, ha(foo)
	l.lw	r5, lo(foo)(r4)
	l.sw	lo(foo)(r4), r6


r~
