From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Date: Tue, 14 Dec 2021 17:29:38 -0300
Subject: [OpenRISC] [PATCH v3 02/13] linux/syscalls: Add or1k_atomic
 syscall for OpenRISC
In-Reply-To: <20211210233456.4146479-3-shorne@gmail.com>
References: <20211210233456.4146479-1-shorne@gmail.com>
 <20211210233456.4146479-3-shorne@gmail.com>
Message-ID: <cc9a6327-dcf4-8d2a-6a63-29d70c6bbb34@linaro.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

It matches kernel definition.

LGTM, thanks.

Reviewed-by: Adhemerval Zanella  <adhemerval.zanella@linaro.org>

On 10/12/2021 20:34, Stafford Horne via Libc-alpha wrote:
> ---
>  sysdeps/unix/sysv/linux/syscall-names.list | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sysdeps/unix/sysv/linux/syscall-names.list b/sysdeps/unix/sysv/linux/syscall-names.list
> index 1a74d090b7..a72dee6275 100644
> --- a/sysdeps/unix/sysv/linux/syscall-names.list
> +++ b/sysdeps/unix/sysv/linux/syscall-names.list
> @@ -304,6 +304,7 @@ open_by_handle_at
>  open_tree
>  openat
>  openat2
> +or1k_atomic
>  osf_adjtime
>  osf_afs_syscall
>  osf_alt_plock
