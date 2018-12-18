From: Stafford Horne <shorne@gmail.com>
Date: Wed, 19 Dec 2018 07:52:00 +0900
Subject: [OpenRISC] OR1K FPU Tools
In-Reply-To: <CAAfxs754kixej8d--PAuh-=idQ0Lt=_M=SqYqLGKSyjCVvG61w@mail.gmail.com>
References: <B93E7844A51A4DDEAF26362A017A89D9@BAndViG>
 <20181124222244.GA3235@lianli.shorne-pla.net>
 <F20A9C40E8204267AEED14B541E3AF0E@BAndViG>
 <20181127211855.GC3235@lianli.shorne-pla.net>
 <CAAfxs77Egr55C2AJv+HE=S=8NFi_h=LSfPBe4z_OfFOROnM2kA@mail.gmail.com>
 <8BFA5ABB61214594AF57022CFD5BCBE6@BAndViG>
 <CAAfxs772YourE74w8ma1rMsbnmdf1Z4r_LmQcniHs=zbkkUw5A@mail.gmail.com>
 <CAAfxs76NvXuM8wGoQqgAzfayXfWP6+GN1n_Jhj0vThOV0QmCAQ@mail.gmail.com>
 <CAAfxs754kixej8d--PAuh-=idQ0Lt=_M=SqYqLGKSyjCVvG61w@mail.gmail.com>
Message-ID: <CAAfxs74wrewjQt1uNmm0tid0_69cknfmGh4tDtMWtYj+wEhy0g@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

(ccing the list, I want to let everyone know the fpu gcc/mor1kx development
status)

Hello

Just a quick update. I got the gdb simulator working.  There looks to be a
bug in the sim framework which too me a while to track down.  But now all
the basic c and assembly tests are working.

Now that it's working I'll start testing with your test bench.  After that
I'll have a look at getting it working on moracchino. Maybe on verilator
first since we need a good mor1kx regression testbed.

- Stafford


On Fri, Dec 14, 2018, 12:37 AM Stafford Horne <shorne@gmail.com wrote:

> Hello,
>
> Nevermind, I read through the mor1k maraschino code and could see you are
> using register pairs for the integer operands as well.
>
> Example:
> {rD,rD+n} = itof({rA,rA+n})
> {rD,rD+n} = ftoi({rA,rA+n})
>
>
> I needed to fix a bug in the sim and one in GCC and I am seeing better
> results but there are some issues.  Ill keep you posted on progress.
>
> -Stafford
>
>
>
> On Thu, Dec 13, 2018 at 6:37 PM Stafford Horne <shorne@gmail.com> wrote:
>
>> Hello,
>>
>> I have been able to get some simple floating point c code tests to work
>> in the sim.
>>
>> However, there seems to be and issue with the sim running the
>> mdouble-float code.  Question.
>>
>> What are the arguments on orfpx64a32 for instructions.
>>
>> lf.itof.d
>> lf.ftoi.d
>>
>> Are the i's meant to both be single 32bit registers or register pairs?
>>
>> Example
>>
>> {rD,rD+n} = itof(rA)
>> rD = ftoi({rA,rA+n})
>>
>> Is that correct? I think the sim has something different.
>>
>> -stafford
>>
>>
>>
>>
>> On Wed, Dec 12, 2018, 6:38 AM Stafford Horne <shorne@gmail.com wrote:
>>
>>> Hi Andrey,
>>>
>>> I rebased your binutils-gdb changes.  Then I split out the  main.cpu
>>> changes from the regeneration patch.   I also regenerated and compiled the
>>> sim.
>>>
>>> It looks good to me so far.
>>>
>>> Note the change I made to add 1 or 2 to the index of the pair register.
>>> Also, I removed the cgen patch.  In my environment I just symlink cgen
>>> into the binutils-gdb directory.
>>>
>>> You can review here:
>>> https://github.com/stffrdhrn/binutils-gdb/commits/orfpx64a32
>>>
>>> On Mon, Dec 10, 2018 at 3:34 AM BAndViG <bandvig@mail.ru> wrote:
>>>
>>>> Impressive progress, Stafford.
>>>> Unfortunately, I haven't got enough time right now to continue
>>>> advancing my OpenRISC implementation. I hope I’ll be back [image:
>>>> Улыбка] in 1-2 weeks.
>>>>
>>>> WBR
>>>> Andrey
>>>>
>>>>
>>>> *From:* Stafford Horne <shorne@gmail.com>
>>>> *Sent:* Sunday, December 09, 2018 4:47 PM
>>>> *To:* BAndViG <bandvig@mail.ru>
>>>> *Cc:* Richard Henderson <rth@twiddle.net>
>>>> *Subject:* Re: OR1K FPU Tools
>>>>
>>>> Hello,
>>>>
>>>> I just pushed some initial patches for fpu support on baremetal gcc. I
>>>> can compile some simple test programs.  Also this supports the mhard-float
>>>> and mdouble-float flags. You can see here:
>>>>
>>>> https://github.com/stffrdhrn/gcc/commits/or1k-fpu-1
>>>>
>>>>
>>>> Ccing, Richard so he can see what I'm up too.
>>>>
>>>> Hi Richard, Andrey is the main developer who implemented the OpenRISC
>>>> fpu.  He is still sticking with the old compiler for the fpu support, hence
>>>> this is on my to-do list.
>>>>
>>>> His fpu has expiramental support for doubles on 32 bit OpenRISC via
>>>> register pairs.  He will update the core to support the new rN,rN+2 pairing
>>>> supported in the new gcc port once my fpu work is tested. I am planning to
>>>> use gdb sim right now.
>>>>
>>>> See:
>>>> https://openrisc.io/proposals/orfpx64a32
>>>>
>>>> -stafford
>>>>
>>>>
>>>> On Wed, Nov 28, 2018, 6:18 AM Stafford Horne <shorne@gmail.com wrote:
>>>>
>>>>> On Sun, Nov 25, 2018 at 07:16:31PM +0300, BAndViG wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>> > > In the current implementation of GCC we store doubles in reigster
>>>>> pairs
>>>>> > > i.e.
>>>>> > > {r28, r30} allowing them to be preserved across function calls.
>>>>> If we
>>>>> > > could
>>>>> > > change ORFPX64A32 to match that it would give us better
>>>>> performance I
>>>>> > > think.
>>>>> >
>>>>> > I'm not familiar with ABI, so it is quite difficult to me to comment
>>>>> this.
>>>>> > First, if I understand correctly, you mean GCC9 while speaking
>>>>> "current
>>>>> > implementation of GCC." Am I right?
>>>>>
>>>>> Yes.
>>>>>
>>>>> > Second, does your proposal mean that double operands and result
>>>>> should
>>>>> > occupy {rx,rx+2} pairs? If "yes", I agree and will change my hardware
>>>>>
>>>>> Yes, thats what I mean.
>>>>>
>>>>> > implementation as soon as you complete "mdouble-float" option for
>>>>> GCC9.
>>>>> > By the way, binutils also should be updated to support such layout.
>>>>>
>>>>> I agree, the hardware should be updated after GCC and
>>>>> binutils/simulation is
>>>>> available.
>>>>>
>>>>> -Stafford
>>>>>
>>>>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20181219/88241cff/attachment.html>
