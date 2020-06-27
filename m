From: Matthew Wilcox <willy@infradead.org>
Date: Sat, 27 Jun 2020 19:31:10 +0100
Subject: [OpenRISC] [PATCH 0/8] mm: cleanup usage of <asm/pgalloc.h>
In-Reply-To: <20200627143453.31835-1-rppt@kernel.org>
References: <20200627143453.31835-1-rppt@kernel.org>
Message-ID: <20200627183110.GE25039@casper.infradead.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Jun 27, 2020 at 05:34:45PM +0300, Mike Rapoport wrote:
> Most architectures have very similar versions of pXd_alloc_one() and
> pXd_free_one() for intermediate levels of page table. 
> These patches add generic versions of these functions in
> <asm-generic/pgalloc.h> and enable use of the generic functions where
> appropriate.

For the series:

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
