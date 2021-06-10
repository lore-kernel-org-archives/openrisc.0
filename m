From: Giulio Benetti <giulio.benetti@benettiengineering.com>
Date: Thu, 10 Jun 2021 23:37:17 +0200
Subject: [OpenRISC] [PATCH v2] bfd/elf32-or1k: fix building with gcc
 version < 5
In-Reply-To: <YMJmywxwS/HY7Xbl@antec>
References: <YME2SzQdpj/AVz/2@antec>
 <20210609215233.1611478-1-giulio.benetti@benettiengineering.com>
 <YMFosi4vsWnxf9Sj@bubble.grove.modra.org>
 <3ef9acac-9f1a-2aab-1c9e-a0d4aaae6ccd@benettiengineering.com>
 <YMIOVK3h+AooX4DR@bubble.grove.modra.org>
 <b84656ba-bbae-b5ea-c61f-08230b324102@benettiengineering.com>
 <YMJmywxwS/HY7Xbl@antec>
Message-ID: <01d95419-6762-11a0-39bf-f0bafd85a12a@benettiengineering.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Staffor, Alan, All,

On 6/10/21 9:23 PM, Stafford Horne wrote:
> On Thu, Jun 10, 2021 at 04:48:46PM +0200, Giulio Benetti wrote:
>> Hello Alan, All,
>>
>> On 6/10/21 3:06 PM, Alan Modra wrote:
>>> On Thu, Jun 10, 2021 at 11:07:13AM +0200, Giulio Benetti wrote:
>>>> Hello Alan, All,
>>>>
>>>> On 6/10/21 3:19 AM, Alan Modra wrote:
>>>>> On Wed, Jun 09, 2021 at 11:52:33PM +0200, Giulio Benetti wrote:
>>>>>> Gcc version >= 5 has standard C mode not set to -std=gnu11, so if we use
>>>>>> an old compiler(i.e. gcc 4.9) build fails on:
>>>>>> ```
>>>>>> elf32-or1k.c:2251:3: error: 'for' loop initial declarations are only allowed in
>>>>>> C99 or C11 mode
>>>>>>        for (size_t i = 0; i < insn_count; i++)
>>>>>>        ^
>>>>>> ```
>>>>>
>>>>> Did you find this problem on current mainline binutils?  The configure
>>>>> machinery is supposed to supply the appropriate -std=c99 or -std=gnu99
>>>>> when using older compilers.  That happens for me when I build with
>>>>> gcc-4.9.  I don't think any patch is needed for mainline.
>>>>>
>>>>
>>>> On Buildroot they don't pass -std=c99/g99 and this is the result:
>>>> https://gitlab.com/bootlin/toolchains-builder/-/jobs/1325646298
>>>
>>> That appears to be building binutils 2.35.2
>>>
>>>> This patch seems to follow all the rest code style of binutils
>>>
>>> True, we've only just switched over to requiring C99.
>>
>> Ok so...
>>
>>>> since no
>>>> other part of it fails and this happens only after patch [1] has been
>>>> upstreamed.
>>>>
>>>> Here [2] you can see all the other toolchains built succesfully and only
>>>> Openrisc fails after the patch provided by Stafford([1]).
>>>>
>>>> [1]: http://patches-tcwg.linaro.org/patch/53151/
>>>> [2]: https://gitlab.com/bootlin/toolchains-builder/-/jobs
>>>
>>> OK, so the real problem is in a backport.  It isn't current mainline
>>> binutils configure, which is what I was worried about.
>>
>> ...it happens on mainline too but it can be solved by adding -std=c99 to
>> CFLAGS.
> 
> Do you have an example of it happening on mainline? According to Alan, mainline
> should not happen as we should be applying -std=c99 automatically.  If not we
> can fix that.

I was wrong, it's not on mainline, it's on 2.35.2.

>>> BTW, thank you for posting a fix here, even if it isn't strictly
>>> necessary for mainline.  Please note that I'm not advocating against
>>> your patch.  If target maintainers want to keep their code compatible
>>> with C89 that's fine by me.
>>>
>> I didn't know about this since no other file failed building on C99. What it
>> seems strange to me is that on buildroot binutils seem to be built without
>> -std=c99
> 
> As mainline binutils is supposed to require c99 now.  I rather not change the
> code but fix any issues with configure not setting flags.
> 
> I looked at ./configure.ac and I confirm that we have setup c99 flags.  But I
> also notice in bfd/configure.ac that we define it again without c99, but that
> should not matter as CC should already be defined.  

I've verified that it inherits -std=c99 from upper configure.ac, so no 
need for it. Then please ignore this patch and we will use it backported 
on binutils:
2.32
2.34
2.35.2
2.36.1

in Buildroot. Sorry for the noise :-)

and Best regards
-- 
Giulio Benetti
Benetti Engineering sas

> Either way does the below patch help?
> 
> diff --git a/bfd/configure.ac b/bfd/configure.ac
> index 07a75ed1626..387c74152d0 100644
> --- a/bfd/configure.ac
> +++ b/bfd/configure.ac
> @@ -34,7 +34,7 @@ dnl Default to a non shared library.  This may be overridden
> by the
>   dnl configure option --enable-shared.
>   AC_DISABLE_SHARED
>   
> -AC_PROG_CC
> +AC_PROG_CC_C99
>   AC_GNU_SOURCE
>   AC_USE_SYSTEM_EXTENSIONS
> 
> --
> 
> -Stafford
> 

