From: Andrey Bacherov <bandvig@mail.ru>
Date: Sat, 21 Mar 2020 16:06:45 +0300
Subject: [OpenRISC] Fpu tininess
In-Reply-To: <CAAfxs75F6mcX_qHPYLzCbudeONXkSCOqNcXGRR4o+bgMDZ_VxQ@mail.gmail.com>
References: <CAAfxs75F6mcX_qHPYLzCbudeONXkSCOqNcXGRR4o+bgMDZ_VxQ@mail.gmail.com>
Message-ID: <1cbd1694-51c1-9b3f-5bb1-6f378b4e703e@mail.ru>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hello Stafford

ORK1 FPU implements tininess after rounding.

https://github.com/bandvig/or1k_testfloat/blob/994c84b8c11f3609772c318f8894ecbad860bd89/src/testfloat.c#L145

At least it should...

I must admit that I wasn't FP-guru while was implementing FP :). And I'm 
not FP-guru now. :). Perhaps I don't understand FP-standard clearly in 
all aspects. As a result "underflow flag" behavior doesn't meet standard 
completely. And I temporary blocked "underflow flag" behavior 
verification in my version of test_float tool:

https://github.com/bandvig/or1k_testfloat/blob/994c84b8c11f3609772c318f8894ecbad860bd89/src/milieu.h#L50

"Underflow flag" behavior correction is in my TODO list, but I'm not 
sure that I could pay enough attention for it.
BTW, it could be task for GSoC, if somebody would be ready to become a 
mentor.

WBR
Andrey


20.03.2020 10:21, Stafford Horne wrote:
> Hi Andrey,
> 
> Thanks for replying to the question about fusesoc.
> 
> I've been meaning to ask you a question about our fpu implementation.  
> Currently for glibc most  floating point math routines use 64-bit double 
> precision.  Anything not handled by the architecture is emulated.
> 
> I have written the emulation patches but the tests are having issues 
> with underflow flags being incorrectly set sometimes.
> 
> I have a hunch it may be due to my tininess setting.   Do you know what 
> we should set for:
> 
> _FP_TININESS_AFTER_ROUNDING
> 
> ?
> 
> The glibc patch
> https://github.com/openrisc/or1k-glibc/commit/4748177bdde92846974fc8ec523d212d6db74aa0
> 
> The gcc patch
> https://github.com/stffrdhrn/gcc/commit/8e99e252edc130162b6d2d7bdef2180305389053
> 
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc
> 
