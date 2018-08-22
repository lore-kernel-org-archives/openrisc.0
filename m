From: Palmer Dabbelt <palmer@sifive.com>
Date: Wed, 22 Aug 2018 10:51:17 -0700 (PDT)
Subject: [OpenRISC] [PATCH v2] kbuild: rename LDFLAGS to KBUILD_LDFLAGS
In-Reply-To: <1534945405-16396-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <mhng-5d4b0f73-4c16-4111-a203-dc8076a2f3bc@palmer-si-x1c4>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, 22 Aug 2018 06:43:25 PDT (-0700), yamada.masahiro at socionext.com wrote:
> Commit a0f97e06a43c ("kbuild: enable 'make CFLAGS=...' to add
> additional options to CC") renamed CFLAGS to KBUILD_CFLAGS.
>
> Commit 222d394d30e7 ("kbuild: enable 'make AFLAGS=...' to add
> additional options to AS") renamed AFLAGS to KBUILD_AFLAGS.
>
> Commit 06c5040cdb13 ("kbuild: enable 'make CPPFLAGS=...' to add
> additional options to CPP") renamed CPPFLAGS to KBUILD_CPPFLAGS.
>
> For some reason, LDFLAGS was not renamed.
>
> Using a well-known variable like LDFLAGS may result in accidental
> override of the variable.
>
> Kbuild generally uses KBUILD_ prefixed variables for the internally
> appended options, so here is one more conversion to sanitize the
> naming convention.
>
> I did not touch Makefiles under tools/ since the tools build system
> is a different world.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>
> Changes in v2:
>   - Rebased on Linus's tree
>
>  Makefile                           | 6 +++---
>  arch/arc/Makefile                  | 2 +-
>  arch/arm/Makefile                  | 4 ++--
>  arch/arm64/Makefile                | 4 ++--
>  arch/c6x/Makefile                  | 3 +--
>  arch/h8300/Makefile                | 2 +-
>  arch/hexagon/Makefile              | 4 +---
>  arch/m68k/Makefile                 | 2 +-
>  arch/microblaze/Makefile           | 4 ++--
>  arch/mips/Makefile                 | 2 +-
>  arch/mips/boot/compressed/Makefile | 2 +-
>  arch/mips/lasat/image/Makefile     | 2 +-
>  arch/nds32/Makefile                | 4 ++--
>  arch/powerpc/Makefile              | 6 +++---
>  arch/riscv/Makefile                | 4 ++--
>  arch/s390/Makefile                 | 2 +-
>  arch/sh/Makefile                   | 4 ++--
>  arch/sparc/Makefile                | 4 ++--
>  arch/um/Makefile                   | 2 +-
>  arch/x86/Makefile                  | 4 ++--
>  arch/x86/Makefile.um               | 4 ++--
>  arch/x86/boot/compressed/Makefile  | 6 +++---
>  arch/xtensa/Makefile               | 2 +-
>  arch/xtensa/boot/boot-elf/Makefile | 2 +-
>  scripts/Kbuild.include             | 4 ++--
>  scripts/Makefile.build             | 4 ++--
>  scripts/Makefile.lib               | 2 +-
>  scripts/Makefile.modpost           | 2 +-
>  28 files changed, 45 insertions(+), 48 deletions(-)

[...]

> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 9ddd88b..61ec424 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -29,7 +29,7 @@ ifeq ($(CONFIG_ARCH_RV64I),y)
>  	KBUILD_CFLAGS	+= $(call cc-ifversion, -ge, 0500, -DCONFIG_ARCH_SUPPORTS_INT128)
>
>  	KBUILD_MARCH = rv64im
> -	LDFLAGS += -melf64lriscv
> +	KBUILD_LDFLAGS += -melf64lriscv
>  else
>  	BITS := 32
>  	UTS_MACHINE := riscv32
> @@ -37,7 +37,7 @@ else
>  	KBUILD_CFLAGS += -mabi=ilp32
>  	KBUILD_AFLAGS += -mabi=ilp32
>  	KBUILD_MARCH = rv32im
> -	LDFLAGS += -melf32lriscv
> +	KBUILD_LDFLAGS += -melf32lriscv
>  endif
>
>  KBUILD_CFLAGS += -Wall

Ah, thanks -- I'd noticed this when we were messing around in here recently and 
assumed there was some reason for the non-orthogonality.  As far as the RISC-V 
stuff goes, feel free to add a 

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

I can deal with the inevitable merge conflicts on our end, as they'll be 
trivial :).
