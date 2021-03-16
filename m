From: Dave Hansen <dave.hansen@intel.com>
Date: Tue, 16 Mar 2021 14:16:35 -0700
Subject: [OpenRISC] [PATCH] mm: Move mem_init_print_info() into mm_init()
In-Reply-To: <20210316142637.92193-1-wangkefeng.wang@huawei.com>
References: <20210316142637.92193-1-wangkefeng.wang@huawei.com>
Message-ID: <009553ee-8d7b-0b60-8457-f8ac66e27fb4@intel.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 3/16/21 7:26 AM, Kefeng Wang wrote:
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 5430c81eefc9..aa8387aab9c1 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1350,8 +1350,6 @@ void __init mem_init(void)
>  		kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR, PAGE_SIZE, KCORE_USER);
>  
>  	preallocate_vmalloc_pages();
> -
> -	mem_init_print_info(NULL);
>  }

Ignoring any issues with the printk...

Looks harmless enough on x86.  The 32-bit code has some cruft in
mem_init() after mem_init_print_info(), so this patch will change the
location of the mem_init_print_info(), but I think it's actually for the
better, since it will be pushed later in boot.  As long as the x86
pieces stay the same:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
