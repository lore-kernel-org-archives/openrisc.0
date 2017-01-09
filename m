From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 09 Jan 2017 12:33:46 +0100
Subject: [OpenRISC] [PATCH v2 3/7] nios2: put setup.h in uapi
In-Reply-To: <1483695839-18660-4-git-send-email-nicolas.dichtel@6wind.com>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
 <1483695839-18660-4-git-send-email-nicolas.dichtel@6wind.com>
Message-ID: <3162962.COsNxdSb45@wuerfel>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Friday, January 6, 2017 10:43:55 AM CET Nicolas Dichtel wrote:

> diff --git a/arch/nios2/include/uapi/asm/setup.h b/arch/nios2/include/uapi/asm/setup.h
> new file mode 100644
> index 000000000000..8d8285997ba8
> --- /dev/null
> +++ b/arch/nios2/include/uapi/asm/setup.h
> @@ -0,0 +1,6 @@
> +#ifndef _UAPI_ASM_NIOS2_SETUP_H
> +#define _UAPI_ASM_NIOS2_SETUP_H
> +
> +#include <asm-generic/setup.h>
> +
> +#endif /* _UAPI_ASM_NIOS2_SETUP_H */
> 

This one is only a redirect to an asm-generic header, so it can be
removed completely and replaced with a line in the 
arch/nios2/include/uapi/asm/ file:

generic-y += setup.h

	Arnd
