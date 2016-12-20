From: kbuild test robot <lkp@intel.com>
Date: Wed, 21 Dec 2016 04:22:23 +0800
Subject: [OpenRISC] [PATCH] openrisc: Define __kernel_size_t to suppress
 compiler warnings
In-Reply-To: <1482242389-30006-1-git-send-email-shorne@gmail.com>
Message-ID: <201612210415.zQ2N1x5s%fengguang.wu@intel.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.9 next-20161220]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stafford-Horne/openrisc-Define-__kernel_size_t-to-suppress-compiler-warnings/20161221-024243
config: openrisc-or1ksim_defconfig (attached as .config)
compiler: or32-linux-gcc (GCC) 4.5.1-or32-1.0rc1
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All warnings (new ones prefixed by >>):

   crypto/drbg.c: In function 'drbg_seed':
>> crypto/drbg.c:1062:3: warning: format '%zu' expects type 'size_t', but argument 2 has type 'long unsigned int'
   crypto/drbg.c: In function 'drbg_generate':
   crypto/drbg.c:1275:3: warning: format '%zu' expects type 'size_t', but argument 2 has type 'long unsigned int'
--
   drivers/base/component.c: In function 'find_components':
>> drivers/base/component.c:101:3: warning: format '%zu' expects type 'size_t', but argument 4 has type 'long unsigned int'
--
   drivers/char/random.c: In function 'urandom_read':
>> drivers/char/random.c:1749:10: warning: format '%zd' expects type 'signed size_t', but argument 3 has type 'size_t'
   drivers/char/random.c: In function 'write_pool':
>> drivers/char/random.c:1783:11: warning: comparison of distinct pointer types lacks a cast
--
   drivers/tty/serial/earlycon.c: In function 'earlycon_init':
>> drivers/tty/serial/earlycon.c:74:32: warning: comparison of distinct pointer types lacks a cast
--
   fs/libfs.c: In function 'simple_attr_write':
>> fs/libfs.c:876:9: warning: comparison of distinct pointer types lacks a cast
--
   lib/iov_iter.c: In function 'sanity':
>> lib/iov_iter.c:319:2: warning: format '%zd' expects type 'signed size_t', but argument 3 has type 'size_t'
--
   lib/kstrtox.c: In function 'kstrtobool_from_user':
>> lib/kstrtox.c:376:10: warning: comparison of distinct pointer types lacks a cast
   lib/kstrtox.c: In function 'kstrtoull_from_user':
   lib/kstrtox.c:398:1: warning: comparison of distinct pointer types lacks a cast
   lib/kstrtox.c: In function 'kstrtoll_from_user':
   lib/kstrtox.c:399:1: warning: comparison of distinct pointer types lacks a cast
   lib/kstrtox.c: In function 'kstrtoul_from_user':
   lib/kstrtox.c:400:1: warning: comparison of distinct pointer types lacks a cast
   lib/kstrtox.c: In function 'kstrtol_from_user':
   lib/kstrtox.c:401:1: warning: comparison of distinct pointer types lacks a cast
   lib/kstrtox.c: In function 'kstrtouint_from_user':
   lib/kstrtox.c:402:1: warning: comparison of distinct pointer types lacks a cast
   lib/kstrtox.c: In function 'kstrtoint_from_user':
   lib/kstrtox.c:403:1: warning: comparison of distinct pointer types lacks a cast
   lib/kstrtox.c: In function 'kstrtou16_from_user':
   lib/kstrtox.c:404:1: warning: comparison of distinct pointer types lacks a cast
   lib/kstrtox.c: In function 'kstrtos16_from_user':
   lib/kstrtox.c:405:1: warning: comparison of distinct pointer types lacks a cast
   lib/kstrtox.c: In function 'kstrtou8_from_user':
   lib/kstrtox.c:406:1: warning: comparison of distinct pointer types lacks a cast
   lib/kstrtox.c: In function 'kstrtos8_from_user':
   lib/kstrtox.c:407:1: warning: comparison of distinct pointer types lacks a cast
--
   In file included from mm/percpu.c:822:0:
   mm/percpu-km.c: In function 'pcpu_verify_alloc_info':
>> mm/percpu-km.c:106:3: warning: format '%zu' expects type 'size_t', but argument 2 has type 'long unsigned int'
   mm/percpu.c: In function 'pcpu_alloc':
>> mm/percpu.c:891:3: warning: format '%zu' expects type 'size_t', but argument 4 has type 'long unsigned int'
   mm/percpu.c:891:3: warning: format '%zu' expects type 'size_t', but argument 5 has type 'long unsigned int'
   mm/percpu.c:1032:3: warning: format '%zu' expects type 'size_t', but argument 2 has type 'long unsigned int'
   mm/percpu.c:1032:3: warning: format '%zu' expects type 'size_t', but argument 3 has type 'long unsigned int'
   mm/percpu.c: In function 'pcpu_dump_alloc_info':
   mm/percpu.c:1460:9: warning: format '%zu' expects type 'size_t', but argument 3 has type 'long unsigned int'
   mm/percpu.c:1460:9: warning: format '%zu' expects type 'size_t', but argument 4 has type 'long unsigned int'
   mm/percpu.c:1460:9: warning: format '%zu' expects type 'size_t', but argument 5 has type 'long unsigned int'
   mm/percpu.c:1460:9: warning: format '%zu' expects type 'size_t', but argument 6 has type 'long unsigned int'
   mm/percpu.c:1460:9: warning: format '%zu' expects type 'size_t', but argument 7 has type 'long unsigned int'
   mm/percpu.c:1460:9: warning: format '%zu' expects type 'size_t', but argument 8 has type 'long unsigned int'
--
   mm/dmapool.c: In function 'show_pools':
>> mm/dmapool.c:99:6: warning: format '%4Zu' expects type 'size_t', but argument 6 has type 'long unsigned int'
   mm/dmapool.c:99:6: warning: format '%4Zu' expects type 'size_t', but argument 7 has type 'long unsigned int'
--
   net/core/dev_ioctl.c: In function 'dev_ifsioc_locked':
>> net/core/dev_ioctl.c:149:11: warning: comparison of distinct pointer types lacks a cast
   net/core/dev_ioctl.c: In function 'dev_ifsioc':
   net/core/dev_ioctl.c:270:10: warning: comparison of distinct pointer types lacks a cast
--
   net/sunrpc/xprtsock.c: In function 'bc_malloc':
>> net/sunrpc/xprtsock.c:2553:3: warning: format '%zu' expects type 'size_t', but argument 4 has type 'long unsigned int'
..

vim +1062 crypto/drbg.c

541af946 Stephan Mueller 2014-05-31  1046   *
541af946 Stephan Mueller 2014-05-31  1047   * return:
541af946 Stephan Mueller 2014-05-31  1048   *	0 on success
541af946 Stephan Mueller 2014-05-31  1049   *	error value otherwise
541af946 Stephan Mueller 2014-05-31  1050   */
541af946 Stephan Mueller 2014-05-31  1051  static int drbg_seed(struct drbg_state *drbg, struct drbg_string *pers,
541af946 Stephan Mueller 2014-05-31  1052  		     bool reseed)
541af946 Stephan Mueller 2014-05-31  1053  {
57225e67 Stephan Mueller 2015-06-09  1054  	int ret;
57225e67 Stephan Mueller 2015-06-09  1055  	unsigned char entropy[((32 + 16) * 2)];
57225e67 Stephan Mueller 2015-06-09  1056  	unsigned int entropylen = drbg_sec_strength(drbg->core->flags);
541af946 Stephan Mueller 2014-05-31  1057  	struct drbg_string data1;
8c987166 Stephan Mueller 2014-06-28  1058  	LIST_HEAD(seedlist);
541af946 Stephan Mueller 2014-05-31  1059  
541af946 Stephan Mueller 2014-05-31  1060  	/* 9.1 / 9.2 / 9.3.1 step 3 */
541af946 Stephan Mueller 2014-05-31  1061  	if (pers && pers->len > (drbg_max_addtl(drbg))) {
a9089571 Stephan Mueller 2014-07-06 @1062  		pr_devel("DRBG: personalization string too long %zu\n",
541af946 Stephan Mueller 2014-05-31  1063  			 pers->len);
541af946 Stephan Mueller 2014-05-31  1064  		return -EINVAL;
541af946 Stephan Mueller 2014-05-31  1065  	}
541af946 Stephan Mueller 2014-05-31  1066  
8fded592 Herbert Xu      2015-04-21  1067  	if (list_empty(&drbg->test_data.list)) {
8fded592 Herbert Xu      2015-04-21  1068  		drbg_string_fill(&data1, drbg->test_data.buf,
8fded592 Herbert Xu      2015-04-21  1069  				 drbg->test_data.len);
541af946 Stephan Mueller 2014-05-31  1070  		pr_devel("DRBG: using test entropy\n");

:::::: The code at line 1062 was first introduced by commit
:::::: a9089571f2fc203c3ba6595a60f0045f048494da crypto: drbg - Fix format string for debugging statements

:::::: TO: Stephan Mueller <smueller@chronox.de>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 7345 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20161221/d003d1ca/attachment.bin>
