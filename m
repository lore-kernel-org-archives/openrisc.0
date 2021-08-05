From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 5 Aug 2021 12:31:37 -0700
Subject: [OpenRISC] [PATCH] openrisc: Fix compiler warnings in setup
In-Reply-To: <20210805030035.2994973-1-shorne@gmail.com>
References: <20210805030035.2994973-1-shorne@gmail.com>
Message-ID: <655ef6e0-defb-7467-25df-f9a13ab96694@infradead.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 8/4/21 8:00 PM, Stafford Horne wrote:
> This was pointed out with the recent name change of or32_early_setup to
> or1k_early_setup.  Investigating the file I found a few other warnings
> so cleaning them up here.
> 
>      arch/openrisc/kernel/setup.c:220:13: warning: no previous prototype for 'or1k_early_setup' [-Wmissing-prototypes]
>        220 | void __init or1k_early_setup(void *fdt)
> 	  |             ^~~~~~~~~~~~~~~~
> 
> Fix this the missing or1k_early_setup prototype warning by adding an
> asm/setup.h file to define the prototype.
> 
>      arch/openrisc/kernel/setup.c:246:13: warning: no previous prototype for 'detect_unit_config' [-Wmissing-prototypes]
>        246 | void __init detect_unit_config(unsigned long upr, unsigned long mask,
> 	  |             ^~~~~~~~~~~~~~~~~~
> 
> The function detect_unit_config is not used, just remove it.
> 
>      arch/openrisc/kernel/setup.c:221: warning: Function parameter or member 'fdt' not described in 'or1k_early_setup'
> 
> Add @fdt docs to the function comment to suppress this warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Hi Stafford,

Does this patch apply to your openrisc tree, but not to
linux-next?  I get a patch error when trying to apply it
to linux-next-20210805 and this warning is still present:

../arch/openrisc/kernel/setup.c:221:13: warning: no previous prototype for 'or32_early_setup' [-Wmissing-prototypes]
   221 | void __init or32_early_setup(void *fdt)
       |             ^~~~~~~~~~~~~~~~

presumably because some openrisc patches are not yet in linux-next??

thanks.

> ---
>   arch/openrisc/include/asm/setup.h | 14 ++++++++++++++
>   arch/openrisc/kernel/setup.c      | 16 +---------------
>   2 files changed, 15 insertions(+), 15 deletions(-)
>   create mode 100644 arch/openrisc/include/asm/setup.h
> 



-- 
~Randy

