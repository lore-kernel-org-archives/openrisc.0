From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 26 May 2020 18:11:59 +0100
Subject: [OpenRISC] [PATCH v2 03/20] mm: remove
 CONFIG_HAVE_MEMBLOCK_NODE_MAP option
In-Reply-To: <20200429121126.17989-4-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
 <20200429121126.17989-4-rppt@kernel.org>
Message-ID: <20200526171159.GJ17051@gaia>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Apr 29, 2020 at 03:11:09PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The CONFIG_HAVE_MEMBLOCK_NODE_MAP is used to differentiate initialization
> of nodes and zones structures between the systems that have region to node
> mapping in memblock and those that don't.
> 
> Currently all the NUMA architectures enable this option and for the
> non-NUMA systems we can presume that all the memory belongs to node 0 and
> therefore the compile time configuration option is not required.
> 
> The remaining few architectures that use DISCONTIGMEM without NUMA are
> easily updated to use memblock_add_node() instead of memblock_add() and
> thus have proper correspondence of memblock regions to NUMA nodes.
> 
> Still, free_area_init_node() must have a backward compatible version
> because its semantics with and without CONFIG_HAVE_MEMBLOCK_NODE_MAP is
> different. Once all the architectures will use the new semantics, the
> entire compatibility layer can be dropped.
> 
> To avoid addition of extra run time memory to store node id for
> architectures that keep memblock but have only a single node, the node id
> field of the memblock_region is guarded by CONFIG_NEED_MULTIPLE_NODES and
> the corresponding accessors presume that in those cases it is always 0.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  .../vm/numa-memblock/arch-support.txt         |  34 ------
>  arch/alpha/mm/numa.c                          |   4 +-
>  arch/arm64/Kconfig                            |   1 -

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
