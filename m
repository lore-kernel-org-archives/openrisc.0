From: Boqun Feng <boqun.feng@gmail.com>
Date: Thu, 17 Mar 2022 23:34:18 +0800
Subject: [OpenRISC] [PATCH 2/5] asm-generic: ticket-lock: New generic
 ticket-based spinlock
In-Reply-To: <364c72a9-64ca-592a-510b-d48a963121aa@redhat.com>
References: <20220316232600.20419-1-palmer@rivosinc.com>
 <20220316232600.20419-3-palmer@rivosinc.com>
 <YjM+P32I4fENIqGV@boqun-archlinux>
 <364c72a9-64ca-592a-510b-d48a963121aa@redhat.com>
Message-ID: <YjNU+tj5YJrYtwtK@boqun-archlinux>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Mar 17, 2022 at 11:03:40AM -0400, Waiman Long wrote:
[...]
> > > + * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
> > > + * sub-word of the value. This is generally true for anything LL/SC although
> > > + * you'd be hard pressed to find anything useful in architecture specifications
> > > + * about this. If your architecture cannot do this you might be better off with
> > > + * a test-and-set.
> > > + *
> > > + * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
> > > + * uses atomic_fetch_add() which is SC to create an RCsc lock.
> > > + *
> > Probably it's better to use "fully-ordered" instead of "SC", because our
> > atomic documents never use "SC" or "Sequential Consisteny" to describe
> > the semantics, further I'm not sure our "fully-ordered" is equivalent to
> > SC, better not cause misunderstanding in the future here.
> 
> The terms RCpc, RCsc comes from academia. I believe we can keep this but add

I'm not saying we cannot keep "RCpc" and "RCsc", and we actually use
them to describe the memory ordering attributes of our lock or atomic
primitives. These terms are well defined.

The thing is that instead of "SC" we use "fully-ordered" to describe the
memory ordering semantics of atomics like cmpxchg(), and IIUC the
definition of "SC" isn't equivalent to "fully-ordered", in other words,
there is no "SC" atomic in Linux kernel right now. So using "SC" here
is not quite right. Just say "...which is fully-ordered to create an
RCsc lock."

But yes, maybe I'm wrong, and "SC" can be used exchangably with
"fully-ordered", but at least some reasoning is needed.

Regards,
Boqun

> more comment to elaborate what they are and what do they mean for the
> average kernel engineer.
> 
> Cheers,
> Longman
> 
