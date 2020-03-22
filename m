From: Stafford Horne <shorne@gmail.com>
Date: Sun, 22 Mar 2020 09:58:54 +0900
Subject: [OpenRISC] Fpu tininess
In-Reply-To: <1cbd1694-51c1-9b3f-5bb1-6f378b4e703e@mail.ru>
References: <CAAfxs75F6mcX_qHPYLzCbudeONXkSCOqNcXGRR4o+bgMDZ_VxQ@mail.gmail.com>
 <1cbd1694-51c1-9b3f-5bb1-6f378b4e703e@mail.ru>
Message-ID: <20200322005854.GM7926@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Sat, Mar 21, 2020 at 04:06:45PM +0300, Andrey Bacherov wrote:
> Hello Stafford
> 
> ORK1 FPU implements tininess after rounding.
> 
> https://github.com/bandvig/or1k_testfloat/blob/994c84b8c11f3609772c318f8894ecbad860bd89/src/testfloat.c#L145

Thanks, I also set glibc and gcc to emulate with tininess after rounding.
I just tried to run all the tests after switch tininess after rounding off as
well and get the same results.  Perhaps the issue with the underflow flag is not
related to the tininess setting.

Right now my tests are running completely on QEMU simulators.  I was able to track
one of the underflow issues to the software implementation of 'log' to me it
looked like an issue in the soft float implementation.

There are so many layers here, qemu float emulation, gcc float emulation glibc
floating point routines.  I have probably just have something wrong on one
layer,  but I wanted to be sure the simulation is inline with the hardware.


> At least it should...
> 
> I must admit that I wasn't FP-guru while was implementing FP :). And I'm not
> FP-guru now. :). Perhaps I don't understand FP-standard clearly in all
> aspects. As a result "underflow flag" behavior doesn't meet standard
> completely. And I temporary blocked "underflow flag" behavior verification
> in my version of test_float tool:
> 
> https://github.com/bandvig/or1k_testfloat/blob/994c84b8c11f3609772c318f8894ecbad860bd89/src/milieu.h#L50
> 
> "Underflow flag" behavior correction is in my TODO list, but I'm not sure
> that I could pay enough attention for it.
> BTW, it could be task for GSoC, if somebody would be ready to become a
> mentor.

Are your volunteering to mentor a student?  We can raise a project proposal
under the librecores GSoC program.

-Stafford

> WBR
> Andrey
> 
> 
> 20.03.2020 10:21, Stafford Horne wrote:
> > Hi Andrey,
> > 
> > Thanks for replying to the question about fusesoc.
> > 
> > I've been meaning to ask you a question about our fpu implementation.
> > Currently for glibc most  floating point math routines use 64-bit double
> > precision.  Anything not handled by the architecture is emulated.
> > 
> > I have written the emulation patches but the tests are having issues
> > with underflow flags being incorrectly set sometimes.
> > 
> > I have a hunch it may be due to my tininess setting.   Do you know what
> > we should set for:
> > 
> > _FP_TININESS_AFTER_ROUNDING
> > 
> > ?
> > 
> > The glibc patch
> > https://github.com/openrisc/or1k-glibc/commit/4748177bdde92846974fc8ec523d212d6db74aa0
> > 
> > The gcc patch
> > https://github.com/stffrdhrn/gcc/commit/8e99e252edc130162b6d2d7bdef2180305389053
> > 
> > _______________________________________________
> > OpenRISC mailing list
> > OpenRISC at lists.librecores.org
> > https://lists.librecores.org/listinfo/openrisc
> > 
