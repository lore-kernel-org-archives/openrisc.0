From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 8 Jan 2018 08:58:19 -0800
Subject: [OpenRISC] [RFC PATCH] openrisc: Make THREAD_SIZE available to
	vmlinux.lds
In-Reply-To: <151541010076.29169.14786412338552538306.stgit@warthog.procyon.org.uk>
References: <151541010076.29169.14786412338552538306.stgit@warthog.procyon.org.uk>
Message-ID: <20180108165818.GC26729@roeck-us.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Jan 08, 2018 at 11:15:00AM +0000, David Howells wrote:
> Make THREAD_SIZE available to vmlinux.lds on openrisc by including
> asm/thread_info.h the linker script.
> 
> This allows init_stack to be allocated in the linker script in a subsequent
> patch.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: David Howells <dhowells@redhat.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> cc: Guenter Roeck <linux@roeck-us.net>
> cc: Jonas Bonn <jonas@southpole.se>
> cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> cc: Stafford Horne <shorne@gmail.com>
> cc: openrisc at lists.librecores.org
> ---
> 
>  arch/openrisc/kernel/vmlinux.lds.S |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/openrisc/kernel/vmlinux.lds.S b/arch/openrisc/kernel/vmlinux.lds.S
> index 00ddb7804be4..953bdcd54efe 100644
> --- a/arch/openrisc/kernel/vmlinux.lds.S
> +++ b/arch/openrisc/kernel/vmlinux.lds.S
> @@ -28,6 +28,7 @@
>  
>  #include <asm/page.h>
>  #include <asm/cache.h>
> +#include <asm/thread_info.h>
>  #include <asm-generic/vmlinux.lds.h>
>  
>  #ifdef __OR1K__
> 
