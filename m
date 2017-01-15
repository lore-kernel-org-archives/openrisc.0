From: kbuild test robot <lkp@intel.com>
Date: Sun, 15 Jan 2017 13:42:56 +0800
Subject: [OpenRISC] [PATCH 07/22] openrisc: add atomic bitops
In-Reply-To: <596c83f9fb4a2deb52b4d69eaabda059ed9f57b5.1484432596.git.shorne@gmail.com>
Message-ID: <201701151315.HUoKM2W9%fengguang.wu@intel.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stefan,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.10-rc3 next-20170113]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stafford-Horne/Openrisc-patchees-from-backlog-for-4-11/20170115-121623
config: openrisc-or1ksim_defconfig (attached as .config)
compiler: or32-linux-gcc (GCC) 4.5.1-or32-1.0rc1
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All errors (new ones prefixed by >>):

   arch/openrisc/include/asm/bitops/atomic.h: Assembler messages:
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
--
   arch/openrisc/include/asm/bitops/atomic.h: Assembler messages:
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
--
   arch/openrisc/include/asm/bitops/atomic.h: Assembler messages:
   arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
   net/core/dev.c: In function 'validate_xmit_skb_list':
   net/core/dev.c:2989:39: warning: 'tail' may be used uninitialized in this function
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
--
   arch/openrisc/include/asm/bitops/atomic.h: Assembler messages:
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
--
   arch/openrisc/include/asm/bitops/atomic.h: Assembler messages:
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
--
   arch/openrisc/include/asm/bitops/atomic.h: Assembler messages:
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
--
   arch/openrisc/include/asm/bitops/atomic.h: Assembler messages:
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
--
   arch/openrisc/include/asm/bitops/atomic.h: Assembler messages:
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:35: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:37: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:90: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:92: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
--
   arch/openrisc/include/asm/bitops/atomic.h: Assembler messages:
>> arch/openrisc/include/asm/bitops/atomic.h:70: Error: unknown opcode2 `l.lwa'.
>> arch/openrisc/include/asm/bitops/atomic.h:72: Error: unknown opcode2 `l.swa'.
   arch/openrisc/include/asm/bitops/atomic.h:18: Error: unknown opcode2 `l.lwa'.
   arch/openrisc/include/asm/bitops/atomic.h:20: Error: unknown opcode2 `l.swa'.

vim +70 arch/openrisc/include/asm/bitops/atomic.h

    64	{
    65		unsigned long mask = BIT_MASK(nr);
    66		unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
    67		unsigned long old;
    68		unsigned long tmp;
    69	
  > 70		__asm__ __volatile__(
    71			"1:	l.lwa	%0,0(%2)	\n"
  > 72			"	l.or	%1,%0,%3	\n"
    73			"	l.swa	0(%2),%1	\n"
    74			"	l.bnf	1b		\n"
    75			"	 l.nop			\n"

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 7343 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170115/ade2ea8c/attachment-0001.bin>
