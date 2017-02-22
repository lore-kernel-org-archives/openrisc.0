From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 22 Feb 2017 12:19:40 +0100
Subject: [OpenRISC] [PATCH v3 08/25] openrisc: add cmpxchg and xchg
	implementations
In-Reply-To: <58010da3ed6e62743cc99674349f91022b41e92a.1487702890.git.shorne@gmail.com>
References: <cover.1487702890.git.shorne@gmail.com>
 <58010da3ed6e62743cc99674349f91022b41e92a.1487702890.git.shorne@gmail.com>
Message-ID: <20170222111940.GR6500@twins.programming.kicks-ass.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Feb 22, 2017 at 04:11:37AM +0900, Stafford Horne wrote:
> +	__asm__ __volatile__(
> +		"1:	l.lwa %0, 0(%1)		\n"
> +		"	l.sfeq %0, %2		\n"
> +		"	l.bnf 1f		\n"
> +		"	 l.nop			\n"
> +		"	l.swa 0(%1), %3		\n"
> +		"	l.bnf 1b		\n"
> +		"1:	 l.nop			\n"
> +		: "=&r"(old)
> +		: "r"(ptr), "r"(old), "r"(new)
> +		: "cc", "memory");

I just noticed this, but having both labels have the same name is
somewhat confusing.
