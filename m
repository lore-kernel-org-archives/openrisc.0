From: Dinh Nguyen <dinguyen@kernel.org>
Date: Wed, 23 Feb 2022 17:30:53 -0600
Subject: [OpenRISC] [PATCH v2 07/18] nios2: drop access_ok() check from
 __put_user()
In-Reply-To: <20220216131332.1489939-8-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-8-arnd@kernel.org>
Message-ID: <c6f461f1-1dd9-aec1-2c85-a3eda478a1be@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On 2/16/22 07:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Unlike other architectures, the nios2 version of __put_user() has an
> extra check for access_ok(), preventing it from being used to implement
> __put_kernel_nofault().
> 
> Split up put_user() along the same lines as __get_user()/get_user()
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/nios2/include/asm/uaccess.h | 56 +++++++++++++++++++-------------
>   1 file changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/nios2/include/asm/uaccess.h b/arch/nios2/include/asm/uaccess.h
> index ca9285a915ef..a5cbe07cf0da 100644
> --- a/arch/nios2/include/asm/uaccess.h
> +++ b/arch/nios2/include/asm/uaccess.h
> @@ -167,34 +167,44 @@ do {									\
>   	: "r" (val), "r" (ptr), "i" (-EFAULT));				\
>   }
>   
> -#define put_user(x, ptr)						\
> +#define __put_user_common(__pu_val, __pu_ptr)				\
>   ({									\
>   	long __pu_err = -EFAULT;					\
> -	__typeof__(*(ptr)) __user *__pu_ptr = (ptr);			\
> -	__typeof__(*(ptr)) __pu_val = (__typeof(*ptr))(x);		\
> -	if (access_ok(__pu_ptr, sizeof(*__pu_ptr))) {	\
> -		switch (sizeof(*__pu_ptr)) {				\
> -		case 1:							\
> -			__put_user_asm(__pu_val, "stb", __pu_ptr, __pu_err); \
> -			break;						\
> -		case 2:							\
> -			__put_user_asm(__pu_val, "sth", __pu_ptr, __pu_err); \
> -			break;						\
> -		case 4:							\
> -			__put_user_asm(__pu_val, "stw", __pu_ptr, __pu_err); \
> -			break;						\
> -		default:						\
> -			/* XXX: This looks wrong... */			\
> -			__pu_err = 0;					\
> -			if (copy_to_user(__pu_ptr, &(__pu_val),		\
> -				sizeof(*__pu_ptr)))			\
> -				__pu_err = -EFAULT;			\
> -			break;						\
> -		}							\
> +	switch (sizeof(*__pu_ptr)) {					\
> +	case 1:								\
> +		__put_user_asm(__pu_val, "stb", __pu_ptr, __pu_err);	\
> +		break;							\
> +	case 2:								\
> +		__put_user_asm(__pu_val, "sth", __pu_ptr, __pu_err);	\
> +		break;							\
> +	case 4:								\
> +		__put_user_asm(__pu_val, "stw", __pu_ptr, __pu_err);	\
> +		break;							\
> +	default:							\
> +		/* XXX: This looks wrong... */				\
> +		__pu_err = 0;						\
> +		if (__copy_to_user(__pu_ptr, &(__pu_val),		\
> +			sizeof(*__pu_ptr)))				\
> +			__pu_err = -EFAULT;				\
> +		break;							\
>   	}								\
>   	__pu_err;							\
>   })
>   
> -#define __put_user(x, ptr) put_user(x, ptr)
> +#define __put_user(x, ptr)						\
> +({									\
> +	__auto_type __pu_ptr = (ptr);					\
> +	typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);		\
> +	__put_user_common(__pu_val, __pu_ptr);				\
> +})
> +
> +#define put_user(x, ptr)						\
> +({									\
> +	__auto_type __pu_ptr = (ptr);					\
> +	typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);		\
> +	access_ok(__pu_ptr, sizeof(*__pu_ptr)) ?			\
> +		__put_user_common(__pu_val, __pu_ptr) :			\
> +		-EFAULT;						\
> +})
>   
>   #endif /* _ASM_NIOS2_UACCESS_H */

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
