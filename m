From: Dinh Nguyen <dinguyen@kernel.org>
Date: Thu, 24 Feb 2022 22:31:04 -0600
Subject: [OpenRISC] [PATCH v2 13/18] uaccess: generalize access_ok()
In-Reply-To: <20220216131332.1489939-14-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-14-arnd@kernel.org>
Message-ID: <d12e6bcc-089d-568b-62cf-036c68c08ca0@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On 2/16/22 07:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are many different ways that access_ok() is defined across
> architectures, but in the end, they all just compare against the
> user_addr_max() value or they accept anything.
> 
> Provide one definition that works for most architectures, checking
> against TASK_SIZE_MAX for user processes or skipping the check inside
> of uaccess_kernel() sections.
> 
> For architectures without CONFIG_SET_FS(), this should be the fastest
> check, as it comes down to a single comparison of a pointer against a
> compile-time constant, while the architecture specific versions tend to
> do something more complex for historic reasons or get something wrong.
> 
> Type checking for __user annotations is handled inconsistently across
> architectures, but this is easily simplified as well by using an inline
> function that takes a 'const void __user *' argument. A handful of
> callers need an extra __user annotation for this.
> 
> Some architectures had trick to use 33-bit or 65-bit arithmetic on the
> addresses to calculate the overflow, however this simpler version uses
> fewer registers, which means it can produce better object code in the
> end despite needing a second (statically predicted) branch.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Mark Rutland <mark.rutland@arm.com> [arm64, asm-generic]
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/Kconfig                          |  7 ++++
>   arch/alpha/include/asm/uaccess.h      | 34 +++------------
>   arch/arc/include/asm/uaccess.h        | 29 -------------
>   arch/arm/include/asm/uaccess.h        | 20 +--------
>   arch/arm64/include/asm/uaccess.h      | 11 ++---
>   arch/csky/include/asm/uaccess.h       |  8 ----
>   arch/hexagon/include/asm/uaccess.h    | 25 ------------
>   arch/ia64/include/asm/uaccess.h       |  5 +--
>   arch/m68k/Kconfig.cpu                 |  1 +
>   arch/m68k/include/asm/uaccess.h       | 19 +--------
>   arch/microblaze/include/asm/uaccess.h |  8 +---
>   arch/mips/include/asm/uaccess.h       | 29 +------------
>   arch/nds32/include/asm/uaccess.h      |  7 +---
>   arch/nios2/include/asm/uaccess.h      | 11 +----

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
