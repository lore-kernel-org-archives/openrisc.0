From: Jiri Slaby <jslaby@suse.cz>
Date: Fri, 18 May 2018 10:30:24 +0200
Subject: [OpenRISC] [PATCH 4.9 27/33] futex: Remove duplicated code and
 fix undefined behaviour
In-Reply-To: <20180518081536.166573281@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
 <20180518081536.166573281@linuxfoundation.org>
Message-ID: <e8dc5f94-3b52-dcf0-3b5e-b442bde7d803@suse.cz>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On 05/18/2018, 10:16 AM, Greg Kroah-Hartman wrote:
> 4.9-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Jiri Slaby <jslaby@suse.cz>
> 
> commit 30d6e0a4190d37740e9447e4e4815f06992dd8c3 upstream.
...
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -1458,6 +1458,45 @@ out:
>  	return ret;
>  }
>  
> +static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
> +{
> +	unsigned int op =	  (encoded_op & 0x70000000) >> 28;
> +	unsigned int cmp =	  (encoded_op & 0x0f000000) >> 24;
> +	int oparg = sign_extend32((encoded_op & 0x00fff000) >> 12, 12);
> +	int cmparg = sign_extend32(encoded_op & 0x00000fff, 12);

12 is wrong here – wherever you apply this, you need also a follow-up fix:
commit d70ef22892ed6c066e51e118b225923c9b74af34
Author: Jiri Slaby <jslaby@suse.cz>
Date:   Thu Nov 30 15:35:44 2017 +0100

    futex: futex_wake_op, fix sign_extend32 sign bits

thanks,
-- 
js
suse labs
