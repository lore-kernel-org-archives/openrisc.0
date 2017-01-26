From: Stafford Horne <shorne@gmail.com>
Date: Thu, 26 Jan 2017 14:53:03 +0900
Subject: [OpenRISC] [PATCH v2] openrisc: migrate exception table users
 off module.h and onto extable.h
In-Reply-To: <20170125214046.31711-1-paul.gortmaker@windriver.com>
References: <20170122163244.11740-11-paul.gortmaker@windriver.com>
 <20170125214046.31711-1-paul.gortmaker@windriver.com>
Message-ID: <20170126055303.GJ7836@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Jan 25, 2017 at 04:40:46PM -0500, Paul Gortmaker wrote:
> These files were only including module.h for exception table related
> functions.  We've now separated that content out into its own file
> "extable.h" so now move over to that and avoid all the extra header
> content in module.h that we don't really need to compile these files.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: openrisc at lists.librecores.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> 
> [v2: add traps.c to conversion, as without a toolchain, I'm at the
>  mercy of the things found by kbuild; fixing them iteratively... ]
> 
>  arch/openrisc/kernel/traps.c | 2 +-
>  arch/openrisc/mm/fault.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
> index a4574cb4b0fb..73abb3ff4fa3 100644
> --- a/arch/openrisc/kernel/traps.c
> +++ b/arch/openrisc/kernel/traps.c
> @@ -23,7 +23,7 @@
>  #include <linux/init.h>
>  #include <linux/sched.h>
>  #include <linux/kernel.h>
> -#include <linux/module.h>
> +#include <linux/exception.h>

Is this correct or did you want extable.h?

>  #include <linux/kmod.h>
>  #include <linux/string.h>
>  #include <linux/errno.h>
> diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
> index b1a7435e786a..53592a639744 100644
> --- a/arch/openrisc/mm/fault.c
> +++ b/arch/openrisc/mm/fault.c
> @@ -17,7 +17,7 @@
>  
>  #include <linux/mm.h>
>  #include <linux/interrupt.h>
> -#include <linux/module.h>
> +#include <linux/extable.h>
>  #include <linux/sched.h>
>  
>  #include <linux/uaccess.h>
> -- 
> 2.11.0
> 
