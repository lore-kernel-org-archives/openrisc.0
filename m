From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 21 Oct 2019 11:47:17 +0300
Subject: [OpenRISC] [PATCH 03/21] ia64: rename ioremap_nocache to
 ioremap_uc
In-Reply-To: <20191017174554.29840-4-hch@lst.de>
References: <20191017174554.29840-1-hch@lst.de>
 <20191017174554.29840-4-hch@lst.de>
Message-ID: <915c9aaa-ea20-7c29-7ee8-5c5f68f7d123@cogentembedded.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello!

On 17.10.2019 20:45, Christoph Hellwig wrote:

> On ia64 ioremap_nocache fails if attributs don't match.  Not other

   Attributes?

> architectures does this, and we plan to get rid of ioremap_nocache.
> So get rid of the special semantics and define ioremap_nocache in
> terms of ioremap as no portable driver could rely on the behavior
> anyway.
> 
> However x86 implements ioremap_uc with a in a similar way as the ia64

    With a what?

> version of ioremap_nocache, so implement that instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/ia64/include/asm/io.h | 6 +++---
>   arch/ia64/mm/ioremap.c     | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
> index 54e70c21352a..fec9df9609ed 100644
> --- a/arch/ia64/include/asm/io.h
> +++ b/arch/ia64/include/asm/io.h
[...]

MBR, Sergei
