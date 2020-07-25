From: Andrey Bacherov <bandvig@mail.ru>
Date: Sat, 25 Jul 2020 14:13:14 +0300
Subject: [OpenRISC] Fpu tininess
In-Reply-To: <20200322005854.GM7926@lianli.shorne-pla.net>
References: <CAAfxs75F6mcX_qHPYLzCbudeONXkSCOqNcXGRR4o+bgMDZ_VxQ@mail.gmail.com>
 <1cbd1694-51c1-9b3f-5bb1-6f378b4e703e@mail.ru>
 <20200322005854.GM7926@lianli.shorne-pla.net>
Message-ID: <d3c3f6f7-c242-876a-d99d-18a1312fc0f1@mail.ru>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Sorry for the very late reply, Stafford.

>>
>> ORK1 FPU implements tininess after rounding.
>>
>> https://github.com/bandvig/or1k_testfloat/blob/994c84b8c11f3609772c318f8894ecbad860bd89/src/testfloat.c#L145
> 
> Thanks, I also set glibc and gcc to emulate with tininess after rounding.
> I just tried to run all the tests after switch tininess after rounding off as
> well and get the same results.  Perhaps the issue with the underflow flag is not
> related to the tininess setting.
> 
> Right now my tests are running completely on QEMU simulators.  I was able to track
> one of the underflow issues to the software implementation of 'log' to me it
> looked like an issue in the soft float implementation.
> 
> There are so many layers here, qemu float emulation, gcc float emulation glibc
> floating point routines.  I have probably just have something wrong on one
> layer,  but I wanted to be sure the simulation is inline with the hardware.

I've re-implemented tininess detection and underflow flag behavior.
https://github.com/openrisc/or1k_marocchino/pull/20
Now FPU perform tininess detection BEFORE rounding because the approach 
looks simpler.
I verified the mods with TestFloat tool with unlocked underflow check.
As I wrote in the comment of the pull request I'm interested to have 
ability to run glibc FP-related tests on my Atlys board. Could you guide 
me which glibc and gcc sources would be better for that? From your forks 
or from upstream?
And how build and run glibc tests?

> Are your volunteering to mentor a student?  We can raise a project proposal
> under the librecores GSoC program.

I'm apologize, but supervising is definitely not for me.

WBR
Andrey
