From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 11 Jan 2017 07:46:24 +0100
Subject: [OpenRISC] [PATCH 2/9] Move dma_ops from archdata into struct
	device
In-Reply-To: <20170111005648.14988-3-bart.vanassche@sandisk.com>
References: <20170111005648.14988-1-bart.vanassche@sandisk.com>
 <20170111005648.14988-3-bart.vanassche@sandisk.com>
Message-ID: <20170111064624.GA26893@kroah.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Jan 10, 2017 at 04:56:41PM -0800, Bart Van Assche wrote:
> Several RDMA drivers, e.g. drivers/infiniband/hw/qib, use the CPU to
> transfer data between memory and PCIe adapter. Because of performance
> reasons it is important that the CPU cache is not flushed when such
> drivers transfer data. Make this possible by allowing these drivers to
> override the dma_map_ops pointer. Additionally, introduce the function
> set_dma_ops() that will be used by a later patch in this series.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: David Howells <dhowells@redhat.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Geoff Levand <geoff@infradead.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James E.J. Bottomley <jejb@parisc-linux.org>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Mikael Starvik <starvik@axis.com>
> Cc: Muli Ben-Yehuda <mulix@mulix.org>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: x86 at kernel.org
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: adi-buildroot-devel at lists.sourceforge.net
> Cc: iommu at lists.linux-foundation.org
> Cc: linux-alpha at vger.kernel.org
> Cc: linux-am33-list at redhat.com
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-c6x-dev at linux-c6x.org
> Cc: linux-cris-kernel at axis.com
> Cc: linux-hexagon at vger.kernel.org
> Cc: linux-ia64 at vger.kernel.org
> Cc: linux-m68k at lists.linux-m68k.org
> Cc: linux-metag at vger.kernel.org
> Cc: linux-mips at linux-mips.org
> Cc: linux-parisc at vger.kernel.org
> Cc: linux-pci at vger.kernel.org
> Cc: linux-rdma at vger.kernel.org
> Cc: linux-s390 at vger.kernel.org
> Cc: linux-sh at vger.kernel.org
> Cc: linux-snps-arc at lists.infradead.org
> Cc: linux-xtensa at linux-xtensa.org
> Cc: linuxppc-dev at lists.ozlabs.org
> Cc: nios2-dev at lists.rocketboards.org
> Cc: openrisc at lists.librecores.org
> Cc: sparclinux at vger.kernel.org
> Cc: uclinux-h8-devel at lists.sourceforge.jp

That's a crazy cc: list, you should break this up into smaller pieces,
otherwise it's going to bounce...

> diff --git a/include/linux/device.h b/include/linux/device.h
> index 491b4c0ca633..c7cb225d36b0 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -885,6 +885,8 @@ struct dev_links_info {
>   * a higher-level representation of the device.
>   */
>  struct device {
> +	const struct dma_map_ops *dma_ops; /* See also get_dma_ops() */
> +
>  	struct device		*parent;
>  
>  	struct device_private	*p;

Why not put this new pointer down with the other dma fields in this
structure?  Any specific reason it needs to be first?

thanks,

greg k-h
