From: BAndViG <bandvig@mail.ru>
Date: Sun, 24 Feb 2019 14:06:31 +0300
Subject: [OpenRISC] OR1K FPU Tools
In-Reply-To: <CAAfxs74OyTpSeD2=6pJ7+_sRiObmo1m5APAPFR-t0R-nTpUTZg@mail.gmail.com>
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
 <CAAfxs77zz3pA7_2kZwHsRLwcLHDqXjnsOLc4Xewiy-qPBpXVyw@mail.gmail.com>
 <CAAfxs74OyTpSeD2=6pJ7+_sRiObmo1m5APAPFR-t0R-nTpUTZg@mail.gmail.com>
Message-ID: <D895AF9F0EEE4A389D083FE663DF646A@BAndViG>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hello,

GCC9 and floating point status update.

I build GCC9+NewLIB based tool-chain and tried to compile and run my FPU tools. I added “-O2” option to NewLIB’s compiler options, but without –mhard-float and –mdouble-float options. That means all math functions use soft subroutines instead of fp-instructions. As a result, it is desirable to get low performance of math functions computation.

“TestFloat”.
I updated systfloat.S from “testfloat” tool to meet GCC9 ABI about correct handling double precision operands (find updated version in attachment). 
With the update all “testfloat” tests were passed for both single and double precision cases.

“Whetstone”
Excluding math functions (see note above) all other tests should operate normally.
I build single precision version of Whetstone with options “–O2 –flto”. All tests passed. Next I’m planning to re-bulid NewLIB with –mhard-float option (but without –mdouble-float) and check full support for single precision.
I also tried double precision version of Whetstone, however it hangs up being compiled ether with “–O2 –flto” or just “-O2” options. The only variant to get operable double precision Whetstone is to build it with “-O0” option.

WBR
Andrey


From: Stafford Horne 
Sent: Monday, January 21, 2019 9:52 PM
To: BAndViG 
Cc: Openrisc 
Subject: Re: OR1K FPU Tools

Hello, 

I have started adapting this to run in my test harness.  Its going to take some time as I only get about 30 minutes a day.  Some things to mention.
   1 The tests I will run first are in stffrdhrn/or1k-tests   (mirror of openrisc/or1k-tests)
   2 The test harness uses the SoC design stffrdhrn/mor1kx-generic (mirror of openrisc/mor1kx-generic)
   3 The harness requires that the pipeline be in mor1kx module (I noticed marocchino is separated out, I will try to add it in)
   4 The harness requires support for the monitor_* signals (I noticed marocchino doesn't support them)

I am almost done with 3 and 4, but I have to go out now.  If you have any comments are suggestions please let me know.

-Stafford

 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20190224/dee8dd18/attachment.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: systfloat.S.zip
Type: application/octet-stream
Size: 1500 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20190224/dee8dd18/attachment.obj>
