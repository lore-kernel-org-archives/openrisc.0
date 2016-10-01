From: Stafford Horne <shorne@gmail.com>
Date: Sat, 1 Oct 2016 18:37:57 +0900
Subject: [OpenRISC] jor1k linux kernel
In-Reply-To: <57EEC291.4080103@macke.de>
References: <alpine.LFD.2.20.1609272235580.9927@lianli.shorne-pla.net>
 <57ED867D.1080305@macke.de>
 <CAAfxs75QGunmeKchQO6s_q=aS+=_ebvXWqS0Wd0LVn=gPw+Dtw@mail.gmail.com>
 <57EEC291.4080103@macke.de>
Message-ID: <CAAfxs751yW5070Dd0Z=ywYH0xy=+o8WbocScctPdRWoWF6CMjw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

(cc openrisc list)

Thanks Sebastian,

If it turns out these patches are needed I will include them.  Ill cc
you on any of the patches submitted.

-Stafford

On Sat, Oct 1, 2016 at 4:52 AM, Sebastian Macke <sebastian@macke.de> wrote:
> Hi Stafford,
>
> sorry, this year I can't go to orconf. I have a family celebration
> during that time.
> Actually I don't know what linux-trap is doing. Looks like it removed
> the pc increment. I absolutely can't tell you why.
> The ptrace-peekuser patch is for strace. I think I did it, but also
> don't know exactly. But I am sure it works :)
>
> Best
>
> Sebastian
>
>
> Am 9/30/2016 um 2:23 PM schrieb Stafford Horne:
>> Hi Sebastian,
>>
>> Thanks for your input.
>>
>> It definitely is slow, this week is orconf (http://orconf.com/) so
>> things are picking up a bit.  Any chance you will make the trip to
>> Italy?
>>
>> I looked through the patches and it does look like there are some
>> interesting ones there that are not on my immediate queue.  Any of
>> these you think are particularly of interest?
>>   - linux-trap.diflinux-trap.diff    - looks like this increments pt + 4
>>   - linux-ptrace-peekuser.diff     - implements ptrace PEEK/POKE
>>
>> As for the the cpu idle patch it is on my queue after these more
>> important ones go in. I reviewed the patch it looks simple enough.
>>
>> I am maintaining a list here:
>> https://github.com/stffrdhrn/linux/wiki/commit-batches
>>
>> -Stafford
>>
>> On Fri, Sep 30, 2016 at 6:24 AM, Sebastian Macke <sebastian@macke.de> wrote:
>>> Dear Stafford,
>>>
>>> thanks for the interest in jor1k and openrisc. It is great to see, that
>>> OpenRISC still make some progress. Slow but steady :)
>>>
>>> I remember the emails I sent to Jonas. You are right about jor1k. X and
>>> strace is working. I know that strace didn't work during that time with
>>> these patches. I figured out a few months later, that this email was wrong.
>>> strace worked. I never told Jonas about this.
>>>
>>> You can check my patches when download this archive:
>>> http://www.jor1k.com/or1k-toolchain.tar.bz2
>>> Take a look at the Makefile below "linux:". Here are all my patches.
>>>
>>>     cd src/linux; git apply
>>> ../../patches/linux/move_protection_fault_new.patch
>>>     cd src/linux; git checkout arch/openrisc/mm/fault.c
>>>     cd src/linux; git apply ../../patches/linux/linux-fault-print.diff
>>>     cd src/linux; git apply ../../patches/linux/linux-trap.diff
>>>     cd src/linux; git apply ../../patches/linux/linux-ptrace-peekuser.diff
>>>     cd src/linux; git apply ../../patches/linux/linux-ptrace-headers.diff
>>>     cp patches/linux/or1ksim.dts src/linux/arch/openrisc/boot/dts
>>>     cp patches/linux/opencores-kbd.c src/linux/drivers/input/keyboard/
>>>     cp patches/linux/CONFIG_LINUX src/linux/.config
>>>     sed -i~ -e "s/or32/or1k/g" src/linux/arch/openrisc/kernel/vmlinux.lds.S
>>>     sed -i~ -e "s/depends on ARCH_LPC32XX//g"
>>> src/linux/drivers/input/touchscreen/Kconfig
>>>     sed -i~ -e "s/depends on ARCH_LPC32XX//g" src/linux/drivers/rtc/Kconfig
>>>     sed -i~ -e "s/default 100 if HZ_100/default 50 if HZ_100/g"
>>> src/linux/kernel/Kconfig.hz
>>>     sed -i~ -e "s/pr_notice(\"random: %s/\/\//g"
>>> src/linux/drivers/char/random.c
>>>     sed -i~ -e "/depends on CPU_SUBTYPE_SH7760/d"
>>> src/linux/sound/soc/sh/Kconfig
>>>     sed -i~ -e "/depends on SUPERH/d" src/linux/sound/soc/sh/Kconfig
>>>     sed -i~ -e "s/8000_96000/11025/" src/linux/sound/soc/sh/fsi.c
>>>
>>> Most of them are just important for jor1k such as hardware tlb refill. This
>>> is the first patch in the list.
>>>
>>> If you have more questions don't hesitate to ask. What about my patch to let
>>> the CPU go to sleep?
>>>
>>> Best
>>>
>>> Sebastian
>>>
>>>
>>>
>>>
>>>
>>>
>>> Am 9/27/2016 um 3:48 PM schrieb Stafford Horne:
>>>
>>>
>>> Hello Sebastian,
>>>
>>> I have recently started working on the openrisc project and am trying to get
>>> some of the old kernel patches upstream.  I have been working with some help
>>> from Stafan Kristiansson on this.
>>>
>>> See a recent thread on the linux kernel mailing list with my latest efforts:
>>>  - https://lkml.org/lkml/2016/9/16/440
>>>
>>> During the review of patches one patch "openrisc: restore call-saved regs on
>>> sigreturn" got a reply from Jonas saying.
>>>
>>>  "This whole patch was reworked later... what happened to that work?"
>>>
>>> I received a copy of the mail between You, Stefan and Jonas about the
>>> original patch which seemed to be all discussed off any mailing lists. So it
>>> looks like Jonas might be mistaken about any rework unless he sent it only
>>> to you?
>>>
>>> Also, I noticed that in the thread you mentioned two issues
>>>  - X - was failing before the patch, but working after
>>>  - strace - was failing after the patch
>>>
>>> I happened to have a look at jor1k and see that both strace and X seem to be
>>> working fine with a 4.1.0 kernel.
>>>
>>> Do you happen to know if there is a later patch from Jonas which you might
>>> be using?  Are there any patches you are running in your jor1k kernel to get
>>> X and strace working?
>>>
>>> -Stafford
>>>
>>>
>

