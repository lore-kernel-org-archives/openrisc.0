From: Joel Sherrill <joel.sherrill@oarcorp.com>
Date: Sat, 19 Mar 2016 09:56:20 -0500
Subject: [OpenRISC] OpenRISC RTEMS
In-Reply-To: <56ED4668.2070408@wallentowitz.de>
References: <56D49EF1.2050104@oarcorp.com> <56ED4668.2070408@wallentowitz.de>
Message-ID: <56ED6894.7060009@oarcorp.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 03/19/2016 07:30 AM, Stefan Wallentowitz wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi Joel, Hi Hesham,
>
> (included the new mailing list)
>
> I am currently in the process of releasing prebuilt RTEMS toolchains
> for OpenRISC. We have started a tutorial repository for multiple
> targets and want to distribute baremetal, Linux and RTEMS examples
> with it.
>
> For that I am bumping the GCC version to 4.9.3 and GDB to 7.9. I am
> adopting the patching mechanism that Hesham also used in RSB, but I
> found a critical difference during the build.
>
> Joel supplied the RTEMS patch here:
> https://github.com/openrisc/or1k-gcc/commit/1ee8ef4190f85934479fa00abbc29e164af80f00
> In the target macros elfos.h is missing:
> https://github.com/openrisc/or1k-gcc/commit/1ee8ef4190f85934479fa00abbc29e164af80f00#diff-fb3f1781891204d8e51adc85578e9a19R2179
> Hesham's build includes elfos.h:
> https://github.com/heshamelmatary/or1k-rtems/blob/master/patches/gcc-4.8.2-or1k-rtems.diff#L5701
>
> After applying an or1k patch to GCC from our development branch, the
> critical part is the ASM_OUTPUT_ASCII macro:
> https://github.com/openrisc/or1k-gcc/blob/or1k-4.9.3/gcc/config/or1k/or1k.h#L1022
>
> The function used there is only defined in the ARM port, hence I think
> this is an artifact. In our standard builds the macro is overwritten
> by elfos.h.
>
> I think the default fix is to include elfos.h in the target macros,
> but I was wondering if something speaks against it. Is it a decision
> to keep it out, Joel?
>

FWIW when someone wants to do an RTEMS port, I try to do a
first cut at the target adaptation. It is not much as I explain
below but since I have FSF paperwork and can usually do it
quickly, it saves hassle. A target for us starts with CPU-elf and
then:

+ try to build binutils-gdb. There are a few config files in
binutils, bfd, ld, and gdb where CPU-rtems might have to
be added to switch statements.
+ newlib usually doesn't need anything done to compile.
It may need setjmp added later.
+ gcc needs a gcc/config/CPU/rtems.h and a stanza in
a gcc config file. Plus a stanza to match on in libgcc's
config file.

In this case, it looks like my first cut missed a line.

Without testing, my first impression is that the target fragment for
or1k should  look like this:

or1k*-*-rtems*)
        tm_file="${tm_file} dbxelf.h elfos.h newlib-stdint.h 
${cpu_type}/elf.h"
        tm_file="${tm_file} newlib-stdint.h or1k/rtems.h rtems.h"
        extra_parts="crti.o crtbegin.o crtend.o crtn.o"
        ;;


That's based on the fact that the or1knd*-*-elf* below it has the first
line to setup the basic or1k stuff. Then we come behind and tweak that
to ensure newlib is used, __rtems__ is predefined as the target OS,
and then general rtems stuff.

or1k-rtems should be a minor tweak of or1k-elf. The file
config/CPU/rtems.h does something like this as a minimum:

/* Target OS builtins.  */
#undef TARGET_OS_CPP_BUILTINS
#define TARGET_OS_CPP_BUILTINS()        \
   do                        \
     {                        \
     builtin_define ("__rtems__");        \
     builtin_define ("__USE_INIT_FINI__");    \
     builtin_assert ("system=rtems");    \
     }                        \
   while (0)

This ensures the __rtems__ predefine and that the RTEMS init sequence
knows the right C++ constructor code to use.
> Sorry, I am not an expert on this stuff.
>
It is magical.

> Best,
> Stefan
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2
>
> iEYEARECAAYFAlbtRmgACgkQuMYtsrn2U9wqyACfeEO2qA/R+DXo1cNXdZlTctwf
> mekAnRfjaHXcuanNMrKODCUa7XbJP8Wf
> =xINJ
> -----END PGP SIGNATURE-----


-- 
-- Joel Sherrill
Ask me about RTEMS: a free RTOS
Support and Training Available


