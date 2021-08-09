From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 8 Aug 2021 18:31:28 -0700
Subject: [OpenRISC] [PATCH] openrisc: Fix compiler warnings in setup
In-Reply-To: <20210805030035.2994973-1-shorne@gmail.com>
References: <20210805030035.2994973-1-shorne@gmail.com>
Message-ID: <20210809013128.GA3698029@roeck-us.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Aug 05, 2021 at 12:00:33PM +0900, Stafford Horne wrote:
> This was pointed out with the recent name change of or32_early_setup to
> or1k_early_setup.  Investigating the file I found a few other warnings
> so cleaning them up here.
> 
>     arch/openrisc/kernel/setup.c:220:13: warning: no previous prototype for 'or1k_early_setup' [-Wmissing-prototypes]
>       220 | void __init or1k_early_setup(void *fdt)
> 	  |             ^~~~~~~~~~~~~~~~
> 
> Fix this the missing or1k_early_setup prototype warning by adding an
> asm/setup.h file to define the prototype.
> 
>     arch/openrisc/kernel/setup.c:246:13: warning: no previous prototype for 'detect_unit_config' [-Wmissing-prototypes]
>       246 | void __init detect_unit_config(unsigned long upr, unsigned long mask,
> 	  |             ^~~~~~~~~~~~~~~~~~
> 
> The function detect_unit_config is not used, just remove it.
> 
>     arch/openrisc/kernel/setup.c:221: warning: Function parameter or member 'fdt' not described in 'or1k_early_setup'
> 
> Add @fdt docs to the function comment to suppress this warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Puzzled. This patch gives me:

Building openrisc:or1ksim_defconfig ... failed
------------
Error log:
In file included from ./arch/openrisc/include/asm/page.h:35,
                 from ./include/linux/generic-radix-tree.h:39,
                 from lib/generic-radix-tree.c:3:
./arch/openrisc/include/asm/setup.h:11:13: error:
		expected '=', ',', ';', 'asm' or '__attribute__' before 'or1k_early_setup'
   11 | void __init or1k_early_setup(void *fdt);
      |             ^~~~~~~~~~~~~~~~
make[1]: *** [scripts/Makefile.build:272: lib/generic-radix-tree.o] Error 1

Bisect log attached for completeness.

Guenter

---
# bad: [7999516e20bd9bb5d1f7351cbd05ca529a3a8d60] Add linux-next specific files for 20210806
# good: [c500bee1c5b2f1d59b1081ac879d73268ab0ff17] Linux 5.14-rc4
git bisect start 'HEAD' 'v5.14-rc4'
# bad: [66f67fa46df4630dfcad6bd2d3bb4af20d3a2490] Merge remote-tracking branch 'mlx5-next/mlx5-next'
git bisect bad 66f67fa46df4630dfcad6bd2d3bb4af20d3a2490
# bad: [e2e00a1babe63d45518d967d17f4f17a31b051fa] Merge remote-tracking branch 'cifsd/cifsd-for-next'
git bisect bad e2e00a1babe63d45518d967d17f4f17a31b051fa
# good: [d1af031ab8b8114a190af28e8f70636e8dbbd9d1] Merge remote-tracking branch 'qcom/for-next'
git bisect good d1af031ab8b8114a190af28e8f70636e8dbbd9d1
# bad: [014a079a3d5f4e6426e42659284911abc1ae7b58] Merge remote-tracking branch 'pidfd/for-next'
git bisect bad 014a079a3d5f4e6426e42659284911abc1ae7b58
# good: [4e2cdb3c5c59ae30a2e282734d57d9aeaf428ce1] Merge remote-tracking branch 'clk/clk-next'
git bisect good 4e2cdb3c5c59ae30a2e282734d57d9aeaf428ce1
# good: [e6e9bca186a091f1fbbfe202c65b1e4f099476a2] Merge branch 'features' into for-next
git bisect good e6e9bca186a091f1fbbfe202c65b1e4f099476a2
# good: [dcc54fc624d3a285ccbe97e9bbe3a6b26f1dfc01] Merge remote-tracking branch 'mips/mips-next'
git bisect good dcc54fc624d3a285ccbe97e9bbe3a6b26f1dfc01
# bad: [9dec8a9fb4d32a212290548f166e39d8a1d02e61] Merge remote-tracking branch 'risc-v/for-next'
git bisect bad 9dec8a9fb4d32a212290548f166e39d8a1d02e61
# bad: [a82c3bd806da0fb68319be21f088bdb70712ed6c] Merge remote-tracking branch 'powerpc/next'
git bisect bad a82c3bd806da0fb68319be21f088bdb70712ed6c
# bad: [01315cd759a2c7c1436b661cc1f54c202f127b4a] Merge remote-tracking branch 'parisc-hd/for-next'
git bisect bad 01315cd759a2c7c1436b661cc1f54c202f127b4a
# bad: [19e14f3a81d227f1c8b8d5371de28b3ab3deb556] openrisc: Fix compiler warnings in setup
git bisect bad 19e14f3a81d227f1c8b8d5371de28b3ab3deb556
# good: [11648cbb7b335b7eb54e1ff973fb938939616f46] openrisc: rename or32 code & comments to or1k
git bisect good 11648cbb7b335b7eb54e1ff973fb938939616f46
# first bad commit: [19e14f3a81d227f1c8b8d5371de28b3ab3deb556] openrisc: Fix compiler warnings in setup
