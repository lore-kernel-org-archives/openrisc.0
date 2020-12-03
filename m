From: Heiko Carstens <hca@linux.ibm.com>
Date: Thu, 03 Dec 2020 14:55:02 -0000
Subject: [OpenRISC] [PATCH AUTOSEL 5.9 27/39] sched/idle: Fix
 arch_cpu_idle() vs tracing
In-Reply-To: <20201203132834.930999-27-sashal@kernel.org>
References: <20201203132834.930999-1-sashal@kernel.org>
 <20201203132834.930999-27-sashal@kernel.org>
Message-ID: <20201203145442.GC9994@osiris>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Dec 03, 2020 at 08:28:21AM -0500, Sasha Levin wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> [ Upstream commit 58c644ba512cfbc2e39b758dd979edd1d6d00e27 ]
> 
> We call arch_cpu_idle() with RCU disabled, but then use
> local_irq_{en,dis}able(), which invokes tracing, which relies on RCU.
> 
> Switch all arch_cpu_idle() implementations to use
> raw_local_irq_{en,dis}able() and carefully manage the
> lockdep,rcu,tracing state like we do in entry.
> 
> (XXX: we really should change arch_cpu_idle() to not return with
> interrupts enabled)
> 
> Reported-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> Link: https://lkml.kernel.org/r/20201120114925.594122626 at infradead.org
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This patch broke s390 irq state tracing. A patch to fix this is
scheduled to be merged upstream today (hopefully).
Therefore I think this patch should not yet go into 5.9 stable.
