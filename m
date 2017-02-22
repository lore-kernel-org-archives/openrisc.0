From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 22 Feb 2017 12:38:32 +0100
Subject: [OpenRISC] [PATCH v3 10/25] openrisc: add spinlock
	implementation
In-Reply-To: <9ec913b47790e9412d5b71a5fc52794ce4ebafb9.1487702890.git.shorne@gmail.com>
References: <cover.1487702890.git.shorne@gmail.com>
 <9ec913b47790e9412d5b71a5fc52794ce4ebafb9.1487702890.git.shorne@gmail.com>
Message-ID: <20170222113832.GQ6515@twins.programming.kicks-ass.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Feb 22, 2017 at 04:11:39AM +0900, Stafford Horne wrote:
> +		lockval.tickets.owner = ACCESS_ONCE(lock->tickets.owner);
> +	return !arch_spin_value_unlocked(ACCESS_ONCE(*lock));
> +	struct __raw_tickets tickets = ACCESS_ONCE(lock->tickets);
> +#define arch_write_can_lock(x)		(ACCESS_ONCE((x)->lock) == 0)
> +#define arch_read_can_lock(x)		(ACCESS_ONCE((x)->lock) < 0x80000000)

Please, no ACCESS_ONCE() in new code, use READ_ONCE() or WRITE_ONCE().
