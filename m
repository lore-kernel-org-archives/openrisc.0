From: Andrey Bacherov <bandvig@mail.ru>
Date: Fri, 8 May 2020 22:53:05 +0300
Subject: [OpenRISC] OpenRISC: User mode writing to FPCSR
In-Reply-To: <20200506220323.GB2550@lianli.shorne-pla.net>
References: <20200506220323.GB2550@lianli.shorne-pla.net>
Message-ID: <652e3bb7-93aa-4310-e798-2258b00300af@mail.ru>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello Stafford,

I agree with your proposal (1).
It looks reasonable.

Andrey

> Hello,
> 
> Now that I am writing this email, I probably should be writing a spec
> change proposal (https://openrisc.io/architecture).
> 
> Anyway,  while working on the glibc port for OpenRISC I find that pretty much
> every architecture allows reading and writing to the floating point control
> register (in openRISC FPCSR) in userland.  This is used by userland to control
> the rounding mode and exception reading and controlling of the FPU.
> 
> However, on OpenRISC this is only writable in supervisor mode.  We can read it
> by enabling a flag in the SR.  But not write to it.
> 
> I propose that we either:
> 
>    1. Allow both read and write to FPCSR is SR[SUMRA] is set. (preferred)
>    2. Create a new flag in SR to enable FPCSR writing.
> 
> This will require changes to:
> 
>   - The SPEC
>   - Linux Kernel preserve FPCSR during context switches
>   - Qemu to allow writes to FPCSR (I have done part of this already, as its
>     needed for glibc testing)
>   - Other simulators.
>   - Mor1kx and Marocchino verilog cores
> 
> Does this sound reasonable?
> 
> p.s. another approach would be to add a syscall for setting the fpcsr, but I
> don't think that is very good, as we would still need to support saving fpcsr
> during context switches for it to work.
> 
> -Stafford
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc
> 
