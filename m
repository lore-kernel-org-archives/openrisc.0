From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 28 Nov 2017 10:18:38 -0800
Subject: [OpenRISC] [PATCH v3] kbuild: Set KBUILD_CFLAGS before incl.
	arch Makefile
In-Reply-To: <CAK7LNASGYZfQFkM3yMRQaHLUwW5Lhp8CxHGX0bJ9sVja0f=n+A@mail.gmail.com>
References: <CAK7LNAS1NaqPRhK6FOXN=YTMhLagpSrR2=tXn-uWZbpzr=NeoQ@mail.gmail.com>
 <20171115204231.34914-1-ndesaulniers@google.com>
 <CAK7LNAQNEHRapzFem3nr7=EWJPYvZby9K7vem-R99ijYNoguEg@mail.gmail.com>
 <CAK7LNASGYZfQFkM3yMRQaHLUwW5Lhp8CxHGX0bJ9sVja0f=n+A@mail.gmail.com>
Message-ID: <CAKwvOdmcthyd1KbxRr54QztBcmeZ7JA=M_7N1xfmVurVOG=77w@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Masahiro,

Thanks for merging Chris' patch, and sorry for taking so long to respond.

On Wed, Nov 22, 2017 at 8:24 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Linus suggests to move compiler flag testing to Kconfig.

Do you have an LKML link for context?

On Wed, Nov 15, 2017 at 6:32 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> BTW, I notice another issue.
>
> If we move clang settings before including arch Makefile,
> "ifneq ($(CROSS_COMPILE),)" comes early.
>
> Some arch Makefiles (arch/mips/Makefile, arch/blackfin/Makefile, etc.)
> set CROSS_COMPILE there if CROSS_COMPILE is not given.
>
> Then, we have a conflict between two requirements among arch.
>
> [1] arm64, powerpc use ld-option in their Makefile.
>     So, clang flags must be set before inc. arch Makefile.
> [2] mips, blackfin, etc. may set CROSS_COMPILE in their Makefile.
>     So, we want to reference CROSS_COMPILE only after inc. arch Makefile
>
> I have no idea how to solve it.
>
> At this moment, I guess clang is intended to support
> only limited architectures.
>
> It might be OK to be compromised here.

I definitely find it curious that certain arch's define CROSS_COMPILE
themselves.  The benefit is one less argument to supply at compile
time, but it assumes that the toolchain always has a certain prefix.
This makes sense to me when cross compiling, but seems odd when
compiling natively on that arch as the host and target.  Maybe those
arch's use that convention, or simply are always cross compiled for?

Taking a survey of all arch's currently in the kernel via `cd arch; ag
CROSS_COMPILE` and quickly eyeballing the result:

m68k if not set
arc if not set
openrisc for some configs (openrisc/configs/or1ksim_defconfig,
openrisc/configs/simple_smp_defconfig)
blackfin if not set
hexagon for some configs (hexagon/configs/comet_defconfig)
parisc if not set
sh if not set
xtensa if not set
score always
arm for some configs (arm/configs/lpc18xx_defconfig)
h8300 if not set
mips if not set (and explicitly emptied for some configs,
mips/configs/nlm_xlr_defconfig )
unicore32 if not set
tile if not set

The * if not set (or not being on the list) seems correct, as the top
level Makefile will handle this correctly.  Setting it for some
configs seems curious (not necessarily wrong?), emptying it/always
setting it via config sounds wrong to me, but maybe those hosts don't
have toolchains and must always be cross compiled for?

For reference, this file in LLVM source defines the supported backend
targets: https://llvm.org/doxygen/Triple_8h_source.html

Either way, it sounds like we're all set here, I guess I'm just
curious about the LKML link/context and why some configs set
CROSS_COMPILE themselves?
