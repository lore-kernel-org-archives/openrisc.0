From: Petr Mladek <pmladek@suse.com>
Date: Thu, 17 Jan 2019 10:28:42 +0100
Subject: [OpenRISC] [PATCH 21/21] memblock: drop
	memblock_alloc_*_nopanic() variants
In-Reply-To: <1547646261-32535-22-git-send-email-rppt@linux.ibm.com>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
 <1547646261-32535-22-git-send-email-rppt@linux.ibm.com>
Message-ID: <20190117092842.wnvsc6em5mxga3rn@pathway.suse.cz>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed 2019-01-16 15:44:21, Mike Rapoport wrote:
> As all the memblock allocation functions return NULL in case of error
> rather than panic(), the duplicates with _nopanic suffix can be removed.

[...]

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index c4f0a41..ae65221 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1147,17 +1147,14 @@ void __init setup_log_buf(int early)
>  	if (!new_log_buf_len)
>  		return;
>  
> -	if (early) {
> -		new_log_buf =
> -			memblock_alloc(new_log_buf_len, LOG_ALIGN);
> -	} else {
> -		new_log_buf = memblock_alloc_nopanic(new_log_buf_len,
> -							  LOG_ALIGN);
> -	}
> -
> +	new_log_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);

The above change is enough.

>  	if (unlikely(!new_log_buf)) {
> -		pr_err("log_buf_len: %lu bytes not available\n",
> -			new_log_buf_len);
> +		if (early)
> +			panic("log_buf_len: %lu bytes not available\n",
> +				new_log_buf_len);

panic() is not needed here. printk() will just continue using
the (smaller) static buffer.

> +		else
> +			pr_err("log_buf_len: %lu bytes not available\n",
> +			       new_log_buf_len);
>  		return;
>  	}

Best Regards,
Petr
