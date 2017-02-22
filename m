From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 22 Feb 2017 12:41:17 +0100
Subject: [OpenRISC] [PATCH v3 10/25] openrisc: add spinlock
	implementation
In-Reply-To: <9ec913b47790e9412d5b71a5fc52794ce4ebafb9.1487702890.git.shorne@gmail.com>
References: <cover.1487702890.git.shorne@gmail.com>
 <9ec913b47790e9412d5b71a5fc52794ce4ebafb9.1487702890.git.shorne@gmail.com>
Message-ID: <20170222114117.GR6515@twins.programming.kicks-ass.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Feb 22, 2017 at 04:11:39AM +0900, Stafford Horne wrote:
> +static inline void arch_spin_unlock(arch_spinlock_t *lock)
> +{
> +	smp_mb();
> +	lock->tickets.owner++;
> +}

This is putting a lot of trust in the compiler, nothing is volatile so
it can do horrible things.

