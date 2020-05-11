From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Mon, 11 May 2020 18:01:35 +0200
Subject: [OpenRISC] [PATCH 03/31] MIPS: unexport
 __flush_icache_user_range
In-Reply-To: <20200510075510.987823-4-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
 <20200510075510.987823-4-hch@lst.de>
Message-ID: <20200511160135.GA17079@alpha.franken.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, May 10, 2020 at 09:54:42AM +0200, Christoph Hellwig wrote:
> __flush_icache_user_range is not used in modular code, so unexport it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/mips/mm/cache.c | 1 -
>  1 file changed, 1 deletion(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
