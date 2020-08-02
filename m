From: Ingo Molnar <mingo@kernel.org>
Date: Sun, 2 Aug 2020 20:02:23 +0200
Subject: [OpenRISC] [PATCH v2 14/17] x86/setup: simplify
 reserve_crashkernel()
In-Reply-To: <20200802163601.8189-15-rppt@kernel.org>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-15-rppt@kernel.org>
Message-ID: <20200802180223.GB86614@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org


* Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> * Replace magic numbers with defines
> * Replace memblock_find_in_range() + memblock_reserve() with
>   memblock_phys_alloc_range()
> * Stop checking for low memory size in reserve_crashkernel_low(). The
>   allocation from limited range will anyway fail if there is no enough
>   memory, so there is no need for extra traversal of memblock.memory
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Assuming that this got or will get tested with a crash kernel:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
