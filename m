From: kbuild test robot <lkp@intel.com>
Date: Wed, 21 Dec 2016 12:06:53 +0800
Subject: [OpenRISC] [PATCH] openrisc: Define __kernel_size_t to suppress
 compiler warnings
In-Reply-To: <1482242389-30006-1-git-send-email-shorne@gmail.com>
Message-ID: <201612211228.62uBjDuK%fengguang.wu@intel.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.9 next-20161221]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stafford-Horne/openrisc-Define-__kernel_size_t-to-suppress-compiler-warnings/20161221-024243
config: openrisc-allnoconfig (attached as .config)
compiler: or32-linux-gcc (GCC) 4.5.1-or32-1.0rc1
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All warnings (new ones prefixed by >>):

   mm/slab_common.c: In function 'create_boot_cache':
>> mm/slab_common.c:816:6: warning: format '%zu' expects type 'size_t', but argument 3 has type 'long unsigned int'

vim +816 mm/slab_common.c

45530c44 Christoph Lameter 2012-11-28  800  /* Create a cache during boot when no slab services are available yet */
45530c44 Christoph Lameter 2012-11-28  801  void __init create_boot_cache(struct kmem_cache *s, const char *name, size_t size,
45530c44 Christoph Lameter 2012-11-28  802  		unsigned long flags)
45530c44 Christoph Lameter 2012-11-28  803  {
45530c44 Christoph Lameter 2012-11-28  804  	int err;
45530c44 Christoph Lameter 2012-11-28  805  
45530c44 Christoph Lameter 2012-11-28  806  	s->name = name;
45530c44 Christoph Lameter 2012-11-28  807  	s->size = s->object_size = size;
45906855 Christoph Lameter 2012-11-28  808  	s->align = calculate_alignment(flags, ARCH_KMALLOC_MINALIGN, size);
f7ce3190 Vladimir Davydov  2015-02-12  809  
f7ce3190 Vladimir Davydov  2015-02-12  810  	slab_init_memcg_params(s);
f7ce3190 Vladimir Davydov  2015-02-12  811  
45530c44 Christoph Lameter 2012-11-28  812  	err = __kmem_cache_create(s, flags);
45530c44 Christoph Lameter 2012-11-28  813  
45530c44 Christoph Lameter 2012-11-28  814  	if (err)
31ba7346 Christoph Lameter 2013-01-10  815  		panic("Creation of kmalloc slab %s size=%zu failed. Reason %d\n",
45530c44 Christoph Lameter 2012-11-28 @816  					name, size, err);
45530c44 Christoph Lameter 2012-11-28  817  
45530c44 Christoph Lameter 2012-11-28  818  	s->refcount = -1;	/* Exempt from merging for now */
45530c44 Christoph Lameter 2012-11-28  819  }
45530c44 Christoph Lameter 2012-11-28  820  
45530c44 Christoph Lameter 2012-11-28  821  struct kmem_cache *__init create_kmalloc_cache(const char *name, size_t size,
45530c44 Christoph Lameter 2012-11-28  822  				unsigned long flags)
45530c44 Christoph Lameter 2012-11-28  823  {
45530c44 Christoph Lameter 2012-11-28  824  	struct kmem_cache *s = kmem_cache_zalloc(kmem_cache, GFP_NOWAIT);

:::::: The code at line 816 was first introduced by commit
:::::: 45530c4474d258b822e2639c786606d8257aad8b mm, sl[au]b: create common functions for boot slab creation

:::::: TO: Christoph Lameter <cl@linux.com>
:::::: CC: Pekka Enberg <penberg@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 4315 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20161221/315cecff/attachment.bin>
