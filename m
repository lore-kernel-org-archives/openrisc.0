From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 22 Feb 2017 12:27:37 +0100
Subject: [OpenRISC] [PATCH v3 09/25] openrisc: add optimized atomic
	operations
In-Reply-To: <1479fc4a4a18712003849341affe74b2a0da609a.1487702890.git.shorne@gmail.com>
References: <cover.1487702890.git.shorne@gmail.com>
 <1479fc4a4a18712003849341affe74b2a0da609a.1487702890.git.shorne@gmail.com>
Message-ID: <20170222112737.GM6515@twins.programming.kicks-ass.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Feb 22, 2017 at 04:11:38AM +0900, Stafford Horne wrote:
> +#define atomic_add_return	atomic_add_return
> +#define atomic_sub_return	atomic_sub_return
> +#define atomic_fetch_add	atomic_fetch_add
> +#define atomic_fetch_sub	atomic_fetch_sub
> +#define atomic_fetch_and	atomic_fetch_and
> +#define atomic_fetch_or		atomic_fetch_or
> +#define atomic_fetch_xor	atomic_fetch_xor
> +#define atomic_and	atomic_and
> +#define atomic_or	atomic_or
> +#define atomic_xor	atomic_xor
> +

It would be good to also implement __atomic_add_unless().

Something like so, if I got your asm right..

static inline int __atomic_add_unless(atomic_t *v, int a, int u)
{
	int old, tmp;

	__asm__ __volatile__(
		"1:     l.lwa %0, 0(%2)         \n"
		"       l.sfeq %0, %4           \n"
		"       l.bf 2f                 \n"
		"        l.nop                  \n"
		"	l.add %1, %0, %3	\n"
		"       l.swa 0(%2), %1         \n"
		"       l.bnf 1b                \n"
		"2:      l.nop                  \n"
		: "=&r"(old), "=&r" (tmp)
		: "r"(&v->counter), "r"(a), "r"(u)
		: "cc", "memory");

	return old;
}
