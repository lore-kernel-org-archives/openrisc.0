From: Peter Zijlstra <peterz@infradead.org>
Date: Sat, 7 Apr 2018 11:09:05 +0200
Subject: [OpenRISC] [PATCH] openrisc: define mb() as its mandatory
In-Reply-To: <20180406205852.14821-1-shorne@gmail.com>
References: <20180406205852.14821-1-shorne@gmail.com>
Message-ID: <20180407090905.GQ4082@hirez.programming.kicks-ass.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Apr 07, 2018 at 05:58:49AM +0900, Stafford Horne wrote:
> Following Peter Z's patch ("asm-generic: Disallow no-op mb() for SMP
> systems") which makes mb() mandatory for SMP architectures we define it
> as l.msync.  On OpenRISC this will flush the current cores write buffer
> and trigger remote cores to invalidate their caches of the written
> memory.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> Link: https://lkml.org/lkml/2018/1/31/254
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
> 
> Notes:
>   - Sorry, its been a while since we discussed this patch is the parent to this 
>     still going in Peter?

Oops.. yes it should. It seems I also lost track of it. Thanks for the
reminder!
