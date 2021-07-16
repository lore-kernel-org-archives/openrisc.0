From: kernel test robot <lkp@intel.com>
Date: Fri, 16 Jul 2021 14:11:09 +0800
Subject: [OpenRISC] [PATCH] openrisc: rename or32 code & comments to or1k
In-Reply-To: <20210716022338.19342-1-rdunlap@infradead.org>
References: <20210716022338.19342-1-rdunlap@infradead.org>
Message-ID: <202107161428.OyGju807-lkp@intel.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Randy,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on openrisc/for-next]
[also build test WARNING on linux/master linus/master v5.14-rc1 next-20210715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Randy-Dunlap/openrisc-rename-or32-code-comments-to-or1k/20210716-102427
base:   https://github.com/openrisc/linux.git for-next
config: openrisc-buildonly-randconfig-r002-20210716 (attached as .config)
compiler: or1k-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d5551791af9959a80485de163c57a26be971ae5e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Randy-Dunlap/openrisc-rename-or32-code-comments-to-or1k/20210716-102427
        git checkout d5551791af9959a80485de163c57a26be971ae5e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/openrisc/kernel/setup.c:220:13: warning: no previous prototype for 'or1k_early_setup' [-Wmissing-prototypes]
     220 | void __init or1k_early_setup(void *fdt)
         |             ^~~~~~~~~~~~~~~~
   arch/openrisc/kernel/setup.c:246:13: warning: no previous prototype for 'detect_unit_config' [-Wmissing-prototypes]
     246 | void __init detect_unit_config(unsigned long upr, unsigned long mask,
         |             ^~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for LOCKDEP
   Depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && (FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
   Selected by
   - LOCK_STAT && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
   - DEBUG_LOCK_ALLOC && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT


vim +/or1k_early_setup +220 arch/openrisc/kernel/setup.c

   210	
   211	/**
   212	 * or1k_early_setup
   213	 *
   214	 * Handles the pointer to the device tree that this kernel is to use
   215	 * for establishing the available platform devices.
   216	 *
   217	 * Falls back on built-in device tree in case null pointer is passed.
   218	 */
   219	
 > 220	void __init or1k_early_setup(void *fdt)
   221	{
   222		if (fdt)
   223			pr_info("FDT at %p\n", fdt);
   224		else {
   225			fdt = __dtb_start;
   226			pr_info("Compiled-in FDT at %p\n", fdt);
   227		}
   228		early_init_devtree(fdt);
   229	}
   230	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 24125 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20210716/a7a8b3bf/attachment-0001.gz>
