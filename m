From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Wed, 23 Feb 2022 08:41:27 +0100
Subject: [OpenRISC] [PATCH v2 09/18] mips: use simpler access_ok()
In-Reply-To: <20220216131332.1489939-10-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-10-arnd@kernel.org>
Message-ID: <20220223074127.GA8287@alpha.franken.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Feb 16, 2022 at 02:13:23PM +0100, Arnd Bergmann wrote:
> diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
> index db9a8e002b62..d7c89dc3426c 100644
> --- a/arch/mips/include/asm/uaccess.h
> +++ b/arch/mips/include/asm/uaccess.h
> @@ -19,6 +19,7 @@
>  #ifdef CONFIG_32BIT
>  
>  #define __UA_LIMIT 0x80000000UL
> +#define TASK_SIZE_MAX	__UA_LIMIT

using KSEG0 instead would IMHO be the better choice. This gives the
chance to remove __UA_LIMIT completly after cleaning up ptrace.c

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
