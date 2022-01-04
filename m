From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Date: Tue, 4 Jan 2022 09:28:12 -0300
Subject: [OpenRISC] [PATCH v5 13/13] Documentation for OpenRISC port
In-Reply-To: <20220104031414.2416928-14-shorne@gmail.com>
References: <20220104031414.2416928-1-shorne@gmail.com>
 <20220104031414.2416928-14-shorne@gmail.com>
Message-ID: <b4207a34-da46-1464-dec2-70c3a39e969d@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On 04/01/2022 00:14, Stafford Horne via Libc-alpha wrote:
> OpenRISC architecture specification:
> 
>  https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.3-rev1.pdf
> 
> Currently the port as of the 2022-01-03 rebasing there are no known
> architecture specific test failures.
> 
> Writing credits for the port are:
> 
>  Stafford Horne  <shorne@gmail.com>
>  Christian Svensson  <blue@cmd.nu>

LGTM, thanks.

Reviewed-by: Adhemerval Zanella  <adhemerval.zanella@linaro.org>


> ---
>  NEWS   | 9 +++++++++
>  README | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/NEWS b/NEWS
> index 9da2a740ec..1b7a64d654 100644
> --- a/NEWS
> +++ b/NEWS
> @@ -106,6 +106,15 @@ Major new features:
>    can use it to efficiently locate unwinding information for a code
>    address.
>  
> +* Support for OpenRISC running on Linux has been added.  This port requires
> +  as least binutils 2.35, GCC 11, and Linux 5.4.  Currently only soft-float
> +  ABI is supported:
> +
> +    - or1k-linux-gnu
> +
> +  The OpenRISC ABI is 32-bit big-endian and uses 64-bit time (y2038 safe) and
> +  64-bit file offsets (LFS default).
> +
>  Deprecated and removed features, and other changes affecting compatibility:
>  
>  * On x86-64, the LD_PREFER_MAP_32BIT_EXEC environment variable support
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
