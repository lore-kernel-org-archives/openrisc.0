From: Jessica Yu <jeyu@kernel.org>
Date: Mon, 18 May 2020 15:04:44 +0200
Subject: [OpenRISC] [PATCH 29/29] module: move the set_fs hack for
 flush_icache_range to m68k
In-Reply-To: <20200515143646.3857579-30-hch@lst.de>
References: <20200515143646.3857579-1-hch@lst.de>
 <20200515143646.3857579-30-hch@lst.de>
Message-ID: <20200518130444.GA21096@linux-8ccs.fritz.box>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

+++ Christoph Hellwig [15/05/20 16:36 +0200]:
>flush_icache_range generally operates on kernel addresses, but for some
>reason m68k needed a set_fs override.  Move that into the m68k code
>insted of keeping it in the module loader.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>---
> arch/m68k/mm/cache.c | 4 ++++
> kernel/module.c      | 8 --------
> 2 files changed, 4 insertions(+), 8 deletions(-)

Thanks for cleaning this up. For module.c:

Acked-by: Jessica Yu <jeyu@kernel.org>

