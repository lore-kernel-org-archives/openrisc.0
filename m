From: Will Deacon <will@kernel.org>
Date: Mon, 11 May 2020 08:51:15 +0100
Subject: [OpenRISC] [PATCH 02/31] arm64: fix the flush_icache_range
 arguments in machine_kexec
In-Reply-To: <20200510075510.987823-3-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
 <20200510075510.987823-3-hch@lst.de>
Message-ID: <20200511075115.GA16134@willie-the-truck>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

[+James and Catalin]

On Sun, May 10, 2020 at 09:54:41AM +0200, Christoph Hellwig wrote:
> The second argument is the end "pointer", not the length.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/kernel/machine_kexec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 8e9c924423b4e..a0b144cfaea71 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -177,6 +177,7 @@ void machine_kexec(struct kimage *kimage)
>  	 * the offline CPUs. Therefore, we must use the __* variant here.
>  	 */
>  	__flush_icache_range((uintptr_t)reboot_code_buffer,
> +			     (uintptr_t)reboot_code_buffer +
>  			     arm64_relocate_new_kernel_size);

Urgh, well spotted. It's annoyingly different from __flush_dcache_area().

But now I'm wondering what this code actually does... the loop condition
in invalidate_icache_by_line works with 64-bit arithmetic, so we could
spend a /very/ long time here afaict. It's also a bit annoying that we
do a bunch of redundant D-cache maintenance too.

Should we use invalidate_icache_range() here instead? (and why does that
thing need to toggle uaccess)? Argh, too many questions!

Will
