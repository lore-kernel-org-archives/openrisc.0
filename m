From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 22 Feb 2017 13:02:10 +0100
Subject: [OpenRISC] [PATCH v3 10/25] openrisc: add spinlock
	implementation
In-Reply-To: <20170222113709.GP6515@twins.programming.kicks-ass.net>
References: <cover.1487702890.git.shorne@gmail.com>
 <9ec913b47790e9412d5b71a5fc52794ce4ebafb9.1487702890.git.shorne@gmail.com>
 <20170222113709.GP6515@twins.programming.kicks-ass.net>
Message-ID: <20170222120210.GQ6536@twins.programming.kicks-ass.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Feb 22, 2017 at 12:37:09PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 22, 2017 at 04:11:39AM +0900, Stafford Horne wrote:
> 
> 
> > +static inline int arch_spin_trylock(arch_spinlock_t *lock)
> > +{
> > +	unsigned long contended, tmp;
> > +	u32 slock;
> > +
> > +	/* contended = (lock->tickets.owner != lock->tickets.next) */
> > +	__asm__ __volatile__(
> > +		"1:	l.lwa	%0, 0(%3)	\n"
> > +		"	l.srli	%1, %0, 16	\n"
> > +		"	l.andi	%2, %0, 0xffff	\n"
> > +		"	l.sfeq	%1, %2		\n"
> > +		"	l.bnf	1f		\n"
> > +		"	 l.ori	%1, r0, 1	\n"
> > +		"	l.add	%0, %0, %4	\n"
> > +		"	l.swa	0(%3), %0	\n"
> > +		"	l.bnf	1b		\n"
> > +		"	 l.ori	%1, r0, 0	\n"
> 
> #ifdef CONFIG_SMP
> 		"	l.sync			\n"
> #endif

Never mind, this part is silly, your l.swa already implies an l.sync. So
you can completely remove the smp_mb() here.
