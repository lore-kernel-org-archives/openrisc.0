From: Stafford Horne <shorne@gmail.com>
Date: Sat, 27 Jan 2018 11:33:30 +0900
Subject: [OpenRISC] [PATCH] openrisc: remove unused __ARCH_HAVE_MMU
	define
In-Reply-To: <1516874330-31440-1-git-send-email-tklauser@distanz.ch>
References: <1516874330-31440-1-git-send-email-tklauser@distanz.ch>
Message-ID: <20180127023330.GJ13019@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Jan 25, 2018 at 10:58:50AM +0100, Tobias Klauser wrote:
> The __ARCH_HAVE_MMU define is (and was) used nowhere in the tree and
> also doesn't appear to be used by any libc.

Thanks I have applied this, I dont find in any other libc as well.  Please let
me know if you find it turns up issues in any of your other patches.

-Stafford

> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  arch/openrisc/include/uapi/asm/unistd.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/openrisc/include/uapi/asm/unistd.h b/arch/openrisc/include/uapi/asm/unistd.h
> index 9a3ee389631e..11c5a58ab333 100644
> --- a/arch/openrisc/include/uapi/asm/unistd.h
> +++ b/arch/openrisc/include/uapi/asm/unistd.h
> @@ -17,8 +17,6 @@
>   * (at your option) any later version.
>   */
>  
> -#define __ARCH_HAVE_MMU
> -
>  #define sys_mmap2 sys_mmap_pgoff
>  
>  #define __ARCH_WANT_RENAMEAT
> -- 
> 2.13.0
> 
