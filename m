From: David Laight <David.Laight@ACULAB.COM>
Date: Wed, 16 Feb 2022 13:35:25 +0000
Subject: [OpenRISC] [PATCH v2 02/18] uaccess: fix nios2 and microblaze
 get_user_8()
In-Reply-To: <20220216131332.1489939-3-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-3-arnd@kernel.org>
Message-ID: <4a7e026b07c94668a18cb4857ad6b7a5@AcuMS.aculab.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Arnd Bergmann
> Sent: 16 February 2022 13:13
> 
> These two architectures implement 8-byte get_user() through
> a memcpy() into a four-byte variable, which won't fit.
> 
> Use a temporary 64-bit variable instead here, and use a double
> cast the way that risc-v and openrisc do to avoid compile-time
> warnings.
> 
...
>  	case 4:								\
> -		__get_user_asm("lw", (ptr), __gu_val, __gu_err);	\
> +		__get_user_asm("lw", (ptr), x, __gu_err);		\
>  		break;							\
> -	case 8:								\
> -		__gu_err = __copy_from_user(&__gu_val, ptr, 8);		\
> -		if (__gu_err)						\
> -			__gu_err = -EFAULT;				\
> +	case 8: {							\
> +		__u64 __x = 0;						\
> +		__gu_err = raw_copy_from_user(&__x, ptr, 8) ?		\
> +							-EFAULT : 0;	\
> +		(x) = (typeof(x))(typeof((x) - (x)))__x;		\
>  		break;							\

Wouldn't it be better to just fetch two 32bit values:
Something like (for LE - nios2 is definitely LE:
		__u32 val_lo, val_hi;
		__get_user_asm("lw", (ptr), val_lo, __gu_err);
		__get_user_asm("lw", (ptr) + 4, val_hi, __gu_err);
		x = val_lo | val_hi << 32;
		break;

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

