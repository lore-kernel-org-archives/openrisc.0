From: Ingo Molnar <mingo@kernel.org>
Date: Tue, 28 Jul 2020 10:44:45 -0000
Subject: [OpenRISC] [PATCH 14/15] x86/numa: remove redundant iteration
 over memblock.reserved
In-Reply-To: <20200728051153.1590-15-rppt@kernel.org>
References: <20200728051153.1590-1-rppt@kernel.org>
 <20200728051153.1590-15-rppt@kernel.org>
Message-ID: <20200728104440.GA222284@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org


* Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> numa_clear_kernel_node_hotplug() function first traverses numa_meminfo
> regions to set node ID in memblock.reserved and than traverses
> memblock.reserved to update reserved_nodemask to include node IDs that were
> set in the first loop.
> 
> Remove redundant traversal over memblock.reserved and update
> reserved_nodemask while iterating over numa_meminfo.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/x86/mm/numa.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)

I suspect you'd like to carry this in the -mm tree?

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
