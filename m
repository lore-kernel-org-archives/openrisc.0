From: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 02 Aug 2021 12:56:13 +1000
Subject: [OpenRISC] [PATCH 2/3] trace: refactor TRACE_IRQFLAGS_SUPPORT
 in Kconfig
In-Reply-To: <20210731052233.4703-2-masahiroy@kernel.org>
References: <20210731052233.4703-1-masahiroy@kernel.org>
 <20210731052233.4703-2-masahiroy@kernel.org>
Message-ID: <87lf5klfle.fsf@mpe.ellerman.id.au>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Masahiro Yamada <masahiroy@kernel.org> writes:
> Make architectures select TRACE_IRQFLAGS_SUPPORT instead of
> having many defines.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/Kconfig                  | 3 +++
>  arch/arc/Kconfig              | 4 +---
>  arch/arm/Kconfig              | 5 +----
>  arch/arm64/Kconfig            | 4 +---
>  arch/csky/Kconfig             | 4 +---
>  arch/hexagon/Kconfig          | 4 +---
>  arch/microblaze/Kconfig       | 1 +
>  arch/microblaze/Kconfig.debug | 5 -----
>  arch/mips/Kconfig             | 1 +
>  arch/mips/Kconfig.debug       | 4 ----
>  arch/nds32/Kconfig            | 4 +---
>  arch/nios2/Kconfig            | 3 ---
>  arch/openrisc/Kconfig         | 4 +---
>  arch/parisc/Kconfig           | 1 +
>  arch/parisc/Kconfig.debug     | 3 ---
>  arch/powerpc/Kconfig          | 5 +----
>  arch/riscv/Kconfig            | 4 +---
>  arch/s390/Kconfig             | 1 +
>  arch/s390/Kconfig.debug       | 3 ---
>  arch/sh/Kconfig               | 1 +
>  arch/sh/Kconfig.debug         | 3 ---
>  arch/sparc/Kconfig            | 1 +
>  arch/sparc/Kconfig.debug      | 4 ----
>  arch/um/Kconfig               | 5 +----
>  arch/x86/Kconfig              | 1 +
>  arch/x86/Kconfig.debug        | 3 ---
>  arch/xtensa/Kconfig           | 4 +---
>  27 files changed, 21 insertions(+), 64 deletions(-)

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index d01e3401581d..76a28452c042 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -94,10 +94,6 @@ config STACKTRACE_SUPPORT
>  	bool
>  	default y
>  
> -config TRACE_IRQFLAGS_SUPPORT
> -	bool
> -	default y
> -
>  config LOCKDEP_SUPPORT
>  	bool
>  	default y
> @@ -271,6 +267,7 @@ config PPC
>  	select STRICT_KERNEL_RWX if STRICT_MODULE_RWX
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
> +	select TRACE_IRQFLAGS_SUPPORT
>  	select VIRT_TO_BUS			if !PPC64
>  	#
>  	# Please keep this list sorted alphabetically.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
