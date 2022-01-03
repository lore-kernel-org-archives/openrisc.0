From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Date: Mon, 3 Jan 2022 15:31:09 -0300
Subject: [OpenRISC] [PATCH v4 13/13] Documentation for OpenRISC port
In-Reply-To: <20211229044251.2203653-14-shorne@gmail.com>
References: <20211229044251.2203653-1-shorne@gmail.com>
 <20211229044251.2203653-14-shorne@gmail.com>
Message-ID: <f5d43fe6-ca91-dde4-d3a0-779d95479b3b@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On 29/12/2021 01:42, Stafford Horne via Libc-alpha wrote:
> OpenRISC architecture specification:
> 
>  https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.3-rev1.pdf
> 
> Currently the port as of the 2021-12-23 rebasing there are no known architecture
> sepcific test failures.
> 
> Writing credits for the port are:
> 
>  Stafford Horne  <shorne@gmail.com>
>  Christian Svensson  <blue@cmd.nu>
> ---
>  NEWS   | 5 +++++
>  README | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/NEWS b/NEWS
> index 9294a7b953..04b11d3589 100644
> --- a/NEWS
> +++ b/NEWS
> @@ -527,6 +527,11 @@ Major new features:
>    The latest GCC available at this time (10.2) does not support this level of
>    fortification.
>  
> +* Support for OpenRISC on Linux has been added.
> +
> +  The OpenRISC port requires at least Linux 5.4, GCC 11 and binutils 2.35.
> +  Currently only soft-float is supported.
> +
>  Deprecated and removed features, and other changes affecting compatibility:
>  
>  * The mallinfo function is marked deprecated.  Callers should call

Maybe follow the entries for other architectures, for instance following
riscv32 and arc:

  * Support for OpenRISC running on Linux has been added.  This port requires
    as least binutils 2.35, GCC 11, and Linux 5.4.  Currently only soft-float
    ABI is supported.

    (maybe also add the triple name here).

> diff --git a/README b/README
> index d0f0edb393..3d5a78ccff 100644
> --- a/README
> +++ b/README
> @@ -35,6 +35,7 @@ The GNU C Library supports these configurations for using Linux kernels:
>  	microblaze*-*-linux-gnu
>  	mips-*-linux-gnu
>  	mips64-*-linux-gnu
> +	or1k-*-linux-gnu
>  	powerpc-*-linux-gnu	Hardware or software floating point, BE only.
>  	powerpc64*-*-linux-gnu	Big-endian and little-endian.
>  	s390-*-linux-gnu
