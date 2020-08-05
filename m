From: Baoquan He <bhe@redhat.com>
Date: Wed, 5 Aug 2020 17:29:48 +0800
Subject: [OpenRISC] [PATCH v2 17/17] memblock: use separate iterators
 for memory and reserved regions
In-Reply-To: <20200802163601.8189-18-rppt@kernel.org>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-18-rppt@kernel.org>
Message-ID: <20200805092948.GX10792@MiWiFi-R3L-srv>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 08/02/20 at 07:36pm, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> for_each_memblock() is used to iterate over memblock.memory in
> a few places that use data from memblock_region rather than the memory
> ranges.
> 
> Introduce separate for_each_mem_region() and for_each_reserved_mem_region()
> to improve encapsulation of memblock internals from its users.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  .clang-format                  |  3 ++-
>  arch/arm64/kernel/setup.c      |  2 +-
>  arch/arm64/mm/numa.c           |  2 +-
>  arch/mips/netlogic/xlp/setup.c |  2 +-
>  arch/x86/mm/numa.c             |  2 +-
>  include/linux/memblock.h       | 19 ++++++++++++++++---
>  mm/memblock.c                  |  4 ++--
>  mm/page_alloc.c                |  8 ++++----
>  8 files changed, 28 insertions(+), 14 deletions(-)
> 
...

> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 9e51b3fd4134..a6970e058bd7 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -522,9 +522,22 @@ static inline unsigned long memblock_region_reserved_end_pfn(const struct memblo
>  	return PFN_UP(reg->base + reg->size);
>  }
>  
> -#define for_each_memblock(memblock_type, region)					\
> -	for (region = memblock.memblock_type.regions;					\
> -	     region < (memblock.memblock_type.regions + memblock.memblock_type.cnt);	\
> +/**
> + * for_each_mem_region - itereate over registered memory regions
                                          ~~~~~~~~~~~~~~~~~

Wonder why emphasize 'registered' memory.

Other than this confusion to me, this patch looks good.

Reviewed-by: Baoquan He <bhe@redhat.com>

