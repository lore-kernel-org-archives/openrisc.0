From: Matthew Wilcox <willy@infradead.org>
Date: Sun, 17 Jun 2018 15:50:46 -0700
Subject: [OpenRISC] [PATCH] openrisc: Call destructor during
	__pte_free_tlb
In-Reply-To: <20180617221243.10126-1-shorne@gmail.com>
References: <20180617221243.10126-1-shorne@gmail.com>
Message-ID: <20180617225046.GB21805@bombadil.infradead.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Jun 18, 2018 at 07:12:42AM +0900, Stafford Horne wrote:
> During the __pte_free_tlb path openrisc fails to call the page
> destructor which would clear the new bits that were introduced.
> To fix this we are calling the destructor.
> 
> It seem openrisc was the only architecture missing this,  all other
> architectures either call the destructor like we are doing here or use
> pte_free.

It may be worth noting that failing to call the destructor was also
messing up the zone stats (and would be causing other problems if
you were using SPLIT_PTE_PTLOCKS).

At any rate, Acked-by: Matthew Wilcox <willy@infradead.org>
