From: Stafford Horne <shorne@gmail.com>
Date: Sun, 15 Jan 2017 17:29:04 +0900
Subject: [OpenRISC] [PATCH 07/22] openrisc: add atomic bitops
In-Reply-To: <201701151315.HUoKM2W9%fengguang.wu@intel.com>
References: <596c83f9fb4a2deb52b4d69eaabda059ed9f57b5.1484432596.git.shorne@gmail.com>
 <201701151315.HUoKM2W9%fengguang.wu@intel.com>
Message-ID: <20170115082904.GG25986@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

On Sun, Jan 15, 2017 at 01:42:56PM +0800, kbuild test robot wrote:
> Hi Stefan,
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.10-rc3 next-20170113]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Stafford-Horne/Openrisc-patchees-from-backlog-for-4-11/20170115-121623
> config: openrisc-or1ksim_defconfig (attached as .config)
> compiler: or32-linux-gcc (GCC) 4.5.1-or32-1.0rc1
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=openrisc 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/openrisc/include/asm/bitops/atomic.h: Assembler messages:
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
> --
>    arch/openrisc/include/asm/bitops/atomic.h: Assembler messages:
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
> --
>    arch/openrisc/include/asm/bitops/atomic.h: Assembler messages:
>    arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>    net/core/dev.c: In function 'validate_xmit_skb_list':
>    net/core/dev.c:2989:39: warning: 'tail' may be used uninitialized in this function
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
> --
>    arch/openrisc/include/asm/bitops/atomic.h: Assembler messages:
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
> --
>    arch/openrisc/include/asm/bitops/atomic.h: Assembler messages:
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
> --
>    arch/openrisc/include/asm/bitops/atomic.h: Assembler messages:
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
> --
>    arch/openrisc/include/asm/bitops/atomic.h: Assembler messages:
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
> --
>    arch/openrisc/include/asm/bitops/atomic.h: Assembler messages:
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
> --
>    arch/openrisc/include/asm/bitops/atomic.h: Assembler messages:
> >> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
> >> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>    arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
>    arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
> 
> vim +70 arch/openrisc/include/asm/bitops/atomic.h
> 
>     64	{
>     65		unsigned long mask = BIT_MASK(nr);
>     66		unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
>     67		unsigned long old;
>     68		unsigned long tmp;
>     69	
>   > 70		__asm__ __volatile__(
>     71			"1:	l.lwa	%0,0(%2)	\n"
>   > 72			"	l.or	%1,%0,%3	\n"
>     73			"	l.swa	0(%2),%1	\n"
>     74			"	l.bnf	1b		\n"
>     75			"	 l.nop			\n"
> 

All of these are due to the lwa/swa instructions.  A toolchain from the
last 2 years would be needed to build these instructions.  Can I suggest
that the test chain be updated?  I would suggest musl. But there are
currently two options openrisc team is maintaining.

:: or1k-musl-linux- chain ::

Get it here:
https://github.com/openrisc/or1k-gcc/tree/musl-5.4.0/gcc
  - build using
    https://github.com/openrisc/musl-cross
    (would suggest my pull request - will merge soon
     https://github.com/openrisc/musl-cross/pull/1)


:: or1k-elf- chain ::

Get it here:
  https://github.com/openrisc/or1k-gcc/tree/or1k-5.4.0/gcc
  - build using baremetal/newlib
    https://github.com/openrisc/newlib
  - instructions
    http://openrisc.io/newlib/building.html

- Stafford
