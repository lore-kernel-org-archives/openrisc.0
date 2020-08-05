From: Baoquan He <bhe@redhat.com>
Date: Wed, 5 Aug 2020 11:57:15 +0800
Subject: [OpenRISC] [PATCH v2 11/17] arch,
 mm: replace for_each_memblock() with for_each_mem_pfn_range()
In-Reply-To: <20200802163601.8189-12-rppt@kernel.org>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-12-rppt@kernel.org>
Message-ID: <20200805035715.GS10792@MiWiFi-R3L-srv>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 08/02/20 at 07:35pm, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> There are several occurrences of the following pattern:
> 
> 	for_each_memblock(memory, reg) {
> 		start_pfn = memblock_region_memory_base_pfn(reg);
> 		end_pfn = memblock_region_memory_end_pfn(reg);
> 
> 		/* do something with start_pfn and end_pfn */
> 	}
> 
> Rather than iterate over all memblock.memory regions and each time query
> for their start and end PFNs, use for_each_mem_pfn_range() iterator to get
> simpler and clearer code.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm/mm/init.c           | 11 ++++-------
>  arch/arm64/mm/init.c         | 11 ++++-------
>  arch/powerpc/kernel/fadump.c | 11 ++++++-----
>  arch/powerpc/mm/mem.c        | 15 ++++++++-------
>  arch/powerpc/mm/numa.c       |  7 ++-----
>  arch/s390/mm/page-states.c   |  6 ++----
>  arch/sh/mm/init.c            |  9 +++------
>  mm/memblock.c                |  6 ++----
>  mm/sparse.c                  | 10 ++++------
>  9 files changed, 35 insertions(+), 51 deletions(-)
> 

Reviewed-by: Baoquan He <bhe@redhat.com>

