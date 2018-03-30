From: kbuild test robot <lkp@intel.com>
Date: Fri, 30 Mar 2018 11:16:11 +0800
Subject: [OpenRISC] [PATCH] Extract initrd free logic from arch-specific
	code.
In-Reply-To: <20180328152714.6103-1-shea@shealevy.com>
References: <20180328152714.6103-1-shea@shealevy.com>
Message-ID: <201803300916.uTxZY6Kv%fengguang.wu@intel.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Shea,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc7]
[cannot apply to next-20180329]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Shea-Levy/Extract-initrd-free-logic-from-arch-specific-code/20180330-085507
config: m32r-m32104ut_defconfig (attached as .config)
compiler: m32r-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m32r 

All warnings (new ones prefixed by >>):

warning: (M32R) selects HAVE_ARCH_FREE_INITRD_MEM which has unmet direct dependencies (BLK_DEV_INITRD)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 11473 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20180330/231c92aa/attachment.gz>
