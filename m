From: Petr Mladek <pmladek@suse.com>
Date: Wed, 30 Jan 2019 14:38:45 +0100
Subject: [OpenRISC] [PATCH v2 21/21] memblock: drop
 memblock_alloc_*_nopanic() variants
In-Reply-To: <1548057848-15136-22-git-send-email-rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-22-git-send-email-rppt@linux.ibm.com>
Message-ID: <20190130133845.nps4itatl4fm6dcl@pathway.suse.cz>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon 2019-01-21 10:04:08, Mike Rapoport wrote:
> As all the memblock allocation functions return NULL in case of error
> rather than panic(), the duplicates with _nopanic suffix can be removed.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/arc/kernel/unwind.c       |  3 +--
>  arch/sh/mm/init.c              |  2 +-
>  arch/x86/kernel/setup_percpu.c | 10 +++++-----
>  arch/x86/mm/kasan_init_64.c    | 14 ++++++++------
>  drivers/firmware/memmap.c      |  2 +-
>  drivers/usb/early/xhci-dbc.c   |  2 +-
>  include/linux/memblock.h       | 35 -----------------------------------
>  kernel/dma/swiotlb.c           |  2 +-
>  kernel/printk/printk.c         |  9 +--------

For printk:
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

>  mm/memblock.c                  | 35 -----------------------------------
>  mm/page_alloc.c                | 10 +++++-----
>  mm/page_ext.c                  |  2 +-
>  mm/percpu.c                    | 11 ++++-------
>  mm/sparse.c                    |  6 ++----
>  14 files changed, 31 insertions(+), 112 deletions(-)
> 
