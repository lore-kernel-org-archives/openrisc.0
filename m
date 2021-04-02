From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri, 2 Apr 2021 17:21:51 +0200
Subject: [OpenRISC] [PATCH v3 11/17] riscv: Convert to GENERIC_CMDLINE
In-Reply-To: <CAL_JsqK2TT=j1QjiRgTYQvwHqivE-3HgYo2JzxTJSWO2wvK69Q@mail.gmail.com>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <46745e07b04139a22b5bd01dc37df97e6981e643.1616765870.git.christophe.leroy@csgroup.eu>
 <87zgyqdn3d.fsf@igel.home> <81a7e63f-57d4-5c81-acc5-35278fe5bb04@csgroup.eu>
 <CAL_JsqK2TT=j1QjiRgTYQvwHqivE-3HgYo2JzxTJSWO2wvK69Q@mail.gmail.com>
Message-ID: <d71c83a8-cc10-b435-5a28-70ca4df6fdf9@csgroup.eu>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org



Le 26/03/2021 à 16:26, Rob Herring a écrit :
> On Fri, Mar 26, 2021 at 8:20 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>
>>
>>
>> Le 26/03/2021 à 15:08, Andreas Schwab a écrit :
>>> On Mär 26 2021, Christophe Leroy wrote:
>>>
>>>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>>>> index f8f15332caa2..e7c91ee478d1 100644
>>>> --- a/arch/riscv/kernel/setup.c
>>>> +++ b/arch/riscv/kernel/setup.c
>>>> @@ -20,6 +20,7 @@
>>>>    #include <linux/swiotlb.h>
>>>>    #include <linux/smp.h>
>>>>    #include <linux/efi.h>
>>>> +#include <linux/cmdline.h>
>>>>
>>>>    #include <asm/cpu_ops.h>
>>>>    #include <asm/early_ioremap.h>
>>>> @@ -228,10 +229,8 @@ static void __init parse_dtb(void)
>>>>       }
>>>>
>>>>       pr_err("No DTB passed to the kernel\n");
>>>> -#ifdef CONFIG_CMDLINE_FORCE
>>>> -    strlcpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
>>>> +    cmdline_build(boot_command_line, NULL, COMMAND_LINE_SIZE);
>>>>       pr_info("Forcing kernel command line to: %s\n", boot_command_line);
>>>
>>> Shouldn't that message become conditional in some way?
>>>
>>
>> You are right, I did something similar on ARM but looks like I missed it on RISCV.
> 
> How is this hunk even useful? Under what conditions can you boot
> without a DTB? Even with a built-in DTB, the DT cmdline handling would
> be called.
> 

Don't know, I wanted to keep as is today.

Do you think the hunk should be completely removed ?

