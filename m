From: Will Deacon <will@kernel.org>
Date: Mon, 19 Aug 2019 08:36:02 +0100
Subject: [OpenRISC] [PATCH 19/26] arm64: remove __iounmap
In-Reply-To: <20190817073253.27819-20-hch@lst.de>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-20-hch@lst.de>
Message-ID: <20190819073601.4yxjvmyjtpi7tk56@willie-the-truck>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Aug 17, 2019 at 09:32:46AM +0200, Christoph Hellwig wrote:
> No need to indirect iounmap for arm64.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/include/asm/io.h | 3 +--
>  arch/arm64/mm/ioremap.c     | 4 ++--
>  2 files changed, 3 insertions(+), 4 deletions(-)

Not sure why we did it like this...

Acked-by: Will Deacon <will@kernel.org>

Will
