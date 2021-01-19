From: Stafford Horne <shorne@gmail.com>
Date: Wed, 20 Jan 2021 06:18:14 +0900
Subject: [OpenRISC] [PATCH] openrisc: io: Add missing __iomem annotation
 to iounmap()
In-Reply-To: <20201228083328.3823431-1-geert+renesas@glider.be>
References: <20201228083328.3823431-1-geert+renesas@glider.be>
Message-ID: <20210119211814.GK2002709@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Dec 28, 2020 at 09:33:28AM +0100, Geert Uytterhoeven wrote:
> With C=1:
> 
>     drivers/soc/renesas/rmobile-sysc.c:330:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *[assigned] base @@
>     drivers/soc/renesas/rmobile-sysc.c:330:33: sparse:     expected void *addr
>     drivers/soc/renesas/rmobile-sysc.c:330:33: sparse:     got void [noderef] __iomem *[assigned] base
> 
> Fix this by adding the missing __iomem annotation to iounmap().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed and OK.  I queued this to my 5.11 fixes branch.  I will send a PR for this
over the weekend.

https://github.com/openrisc/linux/commits/or1k-5.11-fixes

(Found this one in spam and hopefully fixed up my filters now)

-Stafford
