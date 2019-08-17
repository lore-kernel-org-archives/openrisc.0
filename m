From: Paul Walmsley <paul.walmsley@sifive.com>
Date: Sat, 17 Aug 2019 14:22:15 -0700 (PDT)
Subject: [OpenRISC] [PATCH 24/26] riscv: use the generic ioremap code
In-Reply-To: <20190817073253.27819-25-hch@lst.de>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-25-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1908171421560.4130@viisi.sifive.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, 17 Aug 2019, Christoph Hellwig wrote:

> Use the generic ioremap code instead of providing a local version.
> Note that this relies on the asm-generic no-op definition of
> pgprot_noncached.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/Kconfig               |  1 +
>  arch/riscv/include/asm/io.h      |  3 --
>  arch/riscv/include/asm/pgtable.h |  6 +++
>  arch/riscv/mm/Makefile           |  1 -
>  arch/riscv/mm/ioremap.c          | 84 --------------------------------
>  5 files changed, 7 insertions(+), 88 deletions(-)
>  delete mode 100644 arch/riscv/mm/ioremap.c

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
Tested-by: Paul Walmsley <paul.walmsley@sifive.com> # rv32, rv64 boot
Acked-by: Paul Walmsley <paul.walmsley@sifive.com> # arch/riscv


- Paul
