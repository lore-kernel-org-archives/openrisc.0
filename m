From: Stafford Horne <shorne@gmail.com>
Date: Sat, 19 Jan 2019 09:56:21 -1000
Subject: [OpenRISC] OR1K FPU Tools
In-Reply-To: <1ABC8480744C4D40BD98B00970F56DEB@BAndViG>
References: <B93E7844A51A4DDEAF26362A017A89D9@BAndViG>
 <20181124222244.GA3235@lianli.shorne-pla.net>
 <F20A9C40E8204267AEED14B541E3AF0E@BAndViG>
 <20181127211855.GC3235@lianli.shorne-pla.net>
 <CAAfxs77Egr55C2AJv+HE=S=8NFi_h=LSfPBe4z_OfFOROnM2kA@mail.gmail.com>
 <8BFA5ABB61214594AF57022CFD5BCBE6@BAndViG>
 <CAAfxs772YourE74w8ma1rMsbnmdf1Z4r_LmQcniHs=zbkkUw5A@mail.gmail.com>
 <CAAfxs76NvXuM8wGoQqgAzfayXfWP6+GN1n_Jhj0vThOV0QmCAQ@mail.gmail.com>
 <CAAfxs754kixej8d--PAuh-=idQ0Lt=_M=SqYqLGKSyjCVvG61w@mail.gmail.com>
 <CAAfxs74wrewjQt1uNmm0tid0_69cknfmGh4tDtMWtYj+wEhy0g@mail.gmail.com>
 <3ADA35F1727C43478E251E65657B7168@BAndViG>
 <CAAfxs77Z_YYKc11+rkf1L9tL_87oGgcTjWPom6u_3QnBAj0PLQ@mail.gmail.com>
 <99D3A6CAD94A4F5F8DC0635EB165E03C@BAndViG>
 <1ABC8480744C4D40BD98B00970F56DEB@BAndViG>
Message-ID: <CAAfxs77zz3pA7_2kZwHsRLwcLHDqXjnsOLc4Xewiy-qPBpXVyw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hello,
This is great. I have been working on or1k-tests project and testing the
cappuccino and espresso pipelines.  There are some issues with espresso
which got me stuck.  Let me spend some time conveting the test bench to
support moracchino.

- Stafford

On Sat, Jan 19, 2019, 9:01 AM BAndViG <bandvig@mail.ru wrote:

> Stafford,
>
> I’ve updated https://github.com/openrisc/mor1kx/tree/marocchino_devel
> branch with latest version of MAROCCHINO pipe. Now it includes temporary
> option OPTION_ORFPX64A32_ABI implemented to select support either GCC9’s
> ABI (with {rX,rX+2} GPRs combining for 64-bit operands) or GCC5’s one (with
> {rX,rX+1} GPRs combining). To be able to switch these ABIs the GPRs
> implementation were changed from set of RAM-bocks to set of flop-flop based
> registers. To select GCC9’s ABI the option should be set to “GCC9”. It
> should be set to “GCC5” otherwise. The default value is “GCC5”. If you wish
> to simulate or built image for an FPGA you should replace mor1kx instance
> in your test bench/SoC by mor1kx_top_marocchino one as described in
> “doc/marocchino/marocchino_3_how_to.txt”.
> Now MAROCCHINO has got two clocks: CPU clock and Wishbone clock (see
> details in “doc/marocchino/marocchino_2_status_plans.txt”). For FP
> verification it is enough to use same clock for cpu_clk/wb_clk and same
> reset for cpu_rst/wb_rst.
> One note. MAROCCHINO pipe is huge exactly due to FP64 and flip-flop based
> GPRs. I’m not sure if it could fit de0_nano’s FPGA. On Atlys board my SoC
> consisting of MAROCCHINO+UART+SPI+ETHERNET+DRAM consumes 67% of Spartan-6
> LX45 FPGA.
>
> I’m going to clone your binutils and GCC repos to try your floating point
> implementation.
>
> Andrey
>
>
> *From:* BAndViG <bandvig@mail.ru>
> *Sent:* Sunday, December 30, 2018 10:28 PM
> *To:* Stafford Horne <shorne@gmail.com>
> *Cc:* Openrisc <openrisc@lists.librecores.org>
> *Subject:* Re: OR1K FPU Tools
>
> Stafford,
>
>   Starting from single precision is good idea.
>   The marocchino_devel branch (in Github’s OpenRISC organization) is quite
> old. Nevertheless it could be used for testing SF. I’m continue developing
> in my own repo because I create a lot of experimental branches. The actual
> branch is https://github.com/bandvig/mor1kx/tree/wb_cdc_100 . It includes
> pseudo- clock domain crossing and additional stages in pipe to achieve
> 100MHz on Spartan-6. Pseudo-CDC means that (a) core clock “cpu_clk” must be
> greater or equal to Wishbone clock “wb_clk” (b) core and Wishbone clocks
> must be aligned (if they aren't equal to each other).
>   Re-design GPRs for {rX,rX+2} format could be hard enough for you as you
> aren’t familiar with MAROCCHINO sources. I’m plannig to do it with in about
> one or two weeks.
>   Right now I’m going to implement sign extension instructions (in my
> personal repo again). I think I complete them with in several days.
>
> Andrey
>
>
> *From:* Stafford Horne <shorne@gmail.com>
> *Sent:* Thursday, December 27, 2018 2:04 AM
> *To:* BAndViG <bandvig@mail.ru>
> *Cc:* Openrisc <openrisc@lists.librecores.org>
> *Subject:* Re: OR1K FPU Tools
>
> Hello,
>
> I was actually going to just start with checking marocchino with sf. Then
> if you didn't get around to it I was thinking to work on the GPR changes
> myself.  But I still have a while before getting there.
>
> One reason we maintain a verilator test bench is because we have support
> for debugging with gdb Via a jtag server adapter.  That will be a little
> helpful.
>
> It's good to know that the Icarus performance is good. It's much easier to
> use.
>
> This year a orconf the developer of verilator was there and gave a talk of
> some multithread improvements to verilator, if we need better performance I
> may try that.
>
> - Stafford
>
>
> On Tue, Dec 25, 2018, 8:46 PM BAndViG <bandvig@mail.ru wrote:
>
>> Hello
>>
>> My apologize for long answer. I was busy and hadn’t got free time for
>> MAROCCHINO.
>>
>> Currently, MAROCCHINO still uses {rX,rX+1} pattern for combining GPRs, so
>> you couldn't use MAROCHCHINO-based test bench. In MAROCCHINO I implemented
>> GPRs as set of 4 RAM blocks: A-odd, A-even, B-odd and B-even. However, with
>> GCC-9’s {rX,rX+2} format it have to re-design GPR-module.
>>
>> Some words about Verilator. I tried to use it (version 4.006) for
>> simulation a project (not OpeRISC-based SoC) and found that it isn’t faster
>> than IcarusVerilog 10.1.1 for 64-bit machine.
>>
>> Andrey
>>
>>
>> *From:* Stafford Horne <shorne@gmail.com>
>> *Sent:* Wednesday, December 19, 2018 1:52 AM
>> *To:* BAndViG <bandvig@mail.ru>
>> *Cc:* Openrisc <openrisc@lists.librecores.org>
>> *Subject:* Re: OR1K FPU Tools
>>
>> (ccing the list, I want to let everyone know the fpu gcc/mor1kx
>> development status)
>>
>> Hello
>>
>> Just a quick update. I got the gdb simulator working.  There looks to be
>> a bug in the sim framework which too me a while to track down.  But now all
>> the basic c and assembly tests are working.
>>
>> Now that it's working I'll start testing with your test bench.  After
>> that I'll have a look at getting it working on moracchino. Maybe on
>> verilator first since we need a good mor1kx regression testbed.
>>
>> - Stafford
>>
>>
>> On Fri, Dec 14, 2018, 12:37 AM Stafford Horne <shorne@gmail.com wrote:
>>
>>> Hello,
>>>
>>> Nevermind, I read through the mor1k maraschino code and could see you
>>> are using register pairs for the integer operands as well.
>>>
>>> Example:
>>> {rD,rD+n} = itof({rA,rA+n})
>>> {rD,rD+n} = ftoi({rA,rA+n})
>>>
>>>
>>> I needed to fix a bug in the sim and one in GCC and I am seeing better
>>> results but there are some issues.  Ill keep you posted on progress.
>>>
>>> -Stafford
>>>
>>>
>>>
>>> On Thu, Dec 13, 2018 at 6:37 PM Stafford Horne <shorne@gmail.com> wrote:
>>>
>>>> Hello,
>>>>
>>>> I have been able to get some simple floating point c code tests to work
>>>> in the sim.
>>>>
>>>> However, there seems to be and issue with the sim running the
>>>> mdouble-float code.  Question.
>>>>
>>>> What are the arguments on orfpx64a32 for instructions.
>>>>
>>>> lf.itof.d
>>>> lf.ftoi.d
>>>>
>>>> Are the i's meant to both be single 32bit registers or register pairs?
>>>>
>>>> Example
>>>>
>>>> {rD,rD+n} = itof(rA)
>>>> rD = ftoi({rA,rA+n})
>>>>
>>>> Is that correct? I think the sim has something different.
>>>>
>>>> -stafford
>>>>
>>>>
>>>>
>>>>
>>>> On Wed, Dec 12, 2018, 6:38 AM Stafford Horne <shorne@gmail.com wrote:
>>>>
>>>>> Hi Andrey,
>>>>>
>>>>> I rebased your binutils-gdb changes.  Then I split out the  main.cpu
>>>>> changes from the regeneration patch.   I also regenerated and compiled the
>>>>> sim.
>>>>>
>>>>> It looks good to me so far.
>>>>>
>>>>> Note the change I made to add 1 or 2 to the index of the pair register.
>>>>> Also, I removed the cgen patch.  In my environment I just symlink cgen
>>>>> into the binutils-gdb directory.
>>>>>
>>>>> You can review here:
>>>>> https://github.com/stffrdhrn/binutils-gdb/commits/orfpx64a32
>>>>>
>>>>> On Mon, Dec 10, 2018 at 3:34 AM BAndViG <bandvig@mail.ru> wrote:
>>>>>
>>>>>> Impressive progress, Stafford.
>>>>>> Unfortunately, I haven't got enough time right now to continue
>>>>>> advancing my OpenRISC implementation. I hope I’ll be back [image:
>>>>>> Улыбка] in 1-2 weeks.
>>>>>>
>>>>>> WBR
>>>>>> Andrey
>>>>>>
>>>>>>
>>>>>> *From:* Stafford Horne <shorne@gmail.com>
>>>>>> *Sent:* Sunday, December 09, 2018 4:47 PM
>>>>>> *To:* BAndViG <bandvig@mail.ru>
>>>>>> *Cc:* Richard Henderson <rth@twiddle.net>
>>>>>> *Subject:* Re: OR1K FPU Tools
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> I just pushed some initial patches for fpu support on baremetal gcc.
>>>>>> I can compile some simple test programs.  Also this supports the
>>>>>> mhard-float and mdouble-float flags. You can see here:
>>>>>>
>>>>>> https://github.com/stffrdhrn/gcc/commits/or1k-fpu-1
>>>>>>
>>>>>>
>>>>>> Ccing, Richard so he can see what I'm up too.
>>>>>>
>>>>>> Hi Richard, Andrey is the main developer who implemented the OpenRISC
>>>>>> fpu.  He is still sticking with the old compiler for the fpu support, hence
>>>>>> this is on my to-do list.
>>>>>>
>>>>>> His fpu has expiramental support for doubles on 32 bit OpenRISC via
>>>>>> register pairs.  He will update the core to support the new rN,rN+2 pairing
>>>>>> supported in the new gcc port once my fpu work is tested. I am planning to
>>>>>> use gdb sim right now.
>>>>>>
>>>>>> See:
>>>>>> https://openrisc.io/proposals/orfpx64a32
>>>>>>
>>>>>> -stafford
>>>>>>
>>>>>>
>>>>>> On Wed, Nov 28, 2018, 6:18 AM Stafford Horne <shorne@gmail.com wrote:
>>>>>>
>>>>>>> On Sun, Nov 25, 2018 at 07:16:31PM +0300, BAndViG wrote:
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>> > > In the current implementation of GCC we store doubles in
>>>>>>> reigster pairs
>>>>>>> > > i.e.
>>>>>>> > > {r28, r30} allowing them to be preserved across function calls.
>>>>>>> If we
>>>>>>> > > could
>>>>>>> > > change ORFPX64A32 to match that it would give us better
>>>>>>> performance I
>>>>>>> > > think.
>>>>>>> >
>>>>>>> > I'm not familiar with ABI, so it is quite difficult to me to
>>>>>>> comment this.
>>>>>>> > First, if I understand correctly, you mean GCC9 while speaking
>>>>>>> "current
>>>>>>> > implementation of GCC." Am I right?
>>>>>>>
>>>>>>> Yes.
>>>>>>>
>>>>>>> > Second, does your proposal mean that double operands and result
>>>>>>> should
>>>>>>> > occupy {rx,rx+2} pairs? If "yes", I agree and will change my
>>>>>>> hardware
>>>>>>>
>>>>>>> Yes, thats what I mean.
>>>>>>>
>>>>>>> > implementation as soon as you complete "mdouble-float" option for
>>>>>>> GCC9.
>>>>>>> > By the way, binutils also should be updated to support such layout.
>>>>>>>
>>>>>>> I agree, the hardware should be updated after GCC and
>>>>>>> binutils/simulation is
>>>>>>> available.
>>>>>>>
>>>>>>> -Stafford
>>>>>>>
>>>>>> WBR
>> Andrey
>>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20190119/66787660/attachment-0001.html>
