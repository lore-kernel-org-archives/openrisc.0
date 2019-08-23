From: Stafford Horne <shorne@gmail.com>
Date: Fri, 23 Aug 2019 22:55:39 +0900
Subject: [OpenRISC] [PATCH 05/26] openrisc: map as uncached in ioremap
In-Reply-To: <20190817073253.27819-6-hch@lst.de>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-6-hch@lst.de>
Message-ID: <20190823135539.GC24874@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Aug 17, 2019 at 09:32:32AM +0200, Christoph Hellwig wrote:
> Openrisc is the only architecture not mapping ioremap as uncached,
> which has been the default since the Linux 2.6.x days.  Switch it
> over to implement uncached semantics by default.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/openrisc/include/asm/io.h      | 20 +++-----------------
>  arch/openrisc/include/asm/pgtable.h |  2 +-
>  arch/openrisc/mm/ioremap.c          |  8 ++++----
>  3 files changed, 8 insertions(+), 22 deletions(-)

Acked-by: Stafford Horne <shorne@gmail.com>

Thanks,
 -Stafford 
