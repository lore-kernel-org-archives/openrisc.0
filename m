From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Thu, 6 Aug 2020 21:02:29 +0200
Subject: [OpenRISC] [PATCH v2 6/6] openrisc: uaccess: Add user address
 space check to access_ok
In-Reply-To: <20200805210725.310301-7-shorne@gmail.com>
References: <20200805210725.310301-1-shorne@gmail.com>
 <20200805210725.310301-7-shorne@gmail.com>
Message-ID: <20200806190229.b7jbmkavu7qqzegy@ltop.local>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Aug 06, 2020 at 06:07:25AM +0900, Stafford Horne wrote:
> Now that __user annotations are fixed for openrisc uaccess api's we can
> add checking to the access_ok macro.  This patch adds the __chk_user_ptr
> check, on normal builds the added check is a nop.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  arch/openrisc/include/asm/uaccess.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
> index 85a55359b244..53ddc66abb3f 100644
> --- a/arch/openrisc/include/asm/uaccess.h
> +++ b/arch/openrisc/include/asm/uaccess.h
> @@ -57,7 +57,8 @@ static inline int __range_ok(unsigned long addr, unsigned long size)
>  
>  #define access_ok(addr, size)						\
>  ({ 									\
> -	__range_ok((unsigned long)(addr), (size));			\
> +	__chk_user_ptr(addr);						\
> +	__range_ok((__force unsigned long)(addr), (size));		\
>  })

Just for info, __force is not needed when casting a pointer to
unsigned long (or uintptr_t). It's not incorrect to use one
but I think it's to avoid __force as much as possible.

-- Luc
