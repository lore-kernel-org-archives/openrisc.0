From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 8 Aug 2021 19:28:38 -0700
Subject: [OpenRISC] [PATCH] openrisc: Fix compiler warnings in setup
In-Reply-To: <20210809013128.GA3698029@roeck-us.net>
References: <20210805030035.2994973-1-shorne@gmail.com>
 <20210809013128.GA3698029@roeck-us.net>
Message-ID: <0a3de28d-17d5-ec22-0ffb-97f5ca11c127@infradead.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 8/8/21 6:31 PM, Guenter Roeck wrote:
> On Thu, Aug 05, 2021 at 12:00:33PM +0900, Stafford Horne wrote:
>> This was pointed out with the recent name change of or32_early_setup to
>> or1k_early_setup.  Investigating the file I found a few other warnings
>> so cleaning them up here.
>>
>>      arch/openrisc/kernel/setup.c:220:13: warning: no previous prototype for 'or1k_early_setup' [-Wmissing-prototypes]
>>        220 | void __init or1k_early_setup(void *fdt)
>> 	  |             ^~~~~~~~~~~~~~~~
>>
>> Fix this the missing or1k_early_setup prototype warning by adding an
>> asm/setup.h file to define the prototype.
>>
>>      arch/openrisc/kernel/setup.c:246:13: warning: no previous prototype for 'detect_unit_config' [-Wmissing-prototypes]
>>        246 | void __init detect_unit_config(unsigned long upr, unsigned long mask,
>> 	  |             ^~~~~~~~~~~~~~~~~~
>>
>> The function detect_unit_config is not used, just remove it.
>>
>>      arch/openrisc/kernel/setup.c:221: warning: Function parameter or member 'fdt' not described in 'or1k_early_setup'
>>
>> Add @fdt docs to the function comment to suppress this warning.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> Puzzled. This patch gives me:

Stafford posted a v2 earlier today:
https://lore.kernel.org/lkml/20210808135437.3640549-1-shorne at gmail.com/


> Building openrisc:or1ksim_defconfig ... failed
> ------------
> Error log:
> In file included from ./arch/openrisc/include/asm/page.h:35,
>                   from ./include/linux/generic-radix-tree.h:39,
>                   from lib/generic-radix-tree.c:3:
> ./arch/openrisc/include/asm/setup.h:11:13: error:
> 		expected '=', ',', ';', 'asm' or '__attribute__' before 'or1k_early_setup'
>     11 | void __init or1k_early_setup(void *fdt);
>        |             ^~~~~~~~~~~~~~~~
> make[1]: *** [scripts/Makefile.build:272: lib/generic-radix-tree.o] Error 1
> 
> Bisect log attached for completeness.

That needs #include <linux/init.h>

-- 
~Randy

