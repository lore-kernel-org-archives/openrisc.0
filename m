From: Corinna Vinschen <vinschen@redhat.com>
Date: Mon, 5 Nov 2018 10:03:29 +0100
Subject: [OpenRISC] [PATCH] newlib/configure.host: Set have_init_fini to
 no for OpenRISC
In-Reply-To: <20181102220002.29760-1-shorne@gmail.com>
References: <20181102220002.29760-1-shorne@gmail.com>
Message-ID: <20181105090329.GD4052@calimero.vinschen.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Nov  3 07:00, Stafford Horne wrote:
> The new GCC port for OpenRISC will use the init_fini_array only and not
> provide the init() and fini() functions.  Disable the function usage by
> default as its no longer needed.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  newlib/configure.host | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/newlib/configure.host b/newlib/configure.host
> index 27bce36a1..6c49cb750 100644
> --- a/newlib/configure.host
> +++ b/newlib/configure.host
> @@ -279,6 +279,7 @@ case "${host_cpu}" in
>  	;;
>    or1k*|or1knd*)
>  	machine_dir=or1k
> +	have_init_fini=no
>  	;;
>    powerpc*)
>  	machine_dir=powerpc
> -- 
> 2.17.2

Pushed.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
Red Hat
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20181105/4450a28b/attachment-0001.sig>
