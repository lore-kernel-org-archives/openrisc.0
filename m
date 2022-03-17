From: Waiman Long <longman@redhat.com>
Date: Thu, 17 Mar 2022 11:03:40 -0400
Subject: [OpenRISC] [PATCH 2/5] asm-generic: ticket-lock: New generic
 ticket-based spinlock
In-Reply-To: <YjM+P32I4fENIqGV@boqun-archlinux>
References: <20220316232600.20419-1-palmer@rivosinc.com>
 <20220316232600.20419-3-palmer@rivosinc.com>
 <YjM+P32I4fENIqGV@boqun-archlinux>
Message-ID: <364c72a9-64ca-592a-510b-d48a963121aa@redhat.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 3/17/22 09:57, Boqun Feng wrote:
> On Wed, Mar 16, 2022 at 04:25:57PM -0700, Palmer Dabbelt wrote:
>> From: Peter Zijlstra <peterz@infradead.org>
>>
>> This is a simple, fair spinlock.  Specifically it doesn't have all the
>> subtle memory model dependencies that qspinlock has, which makes it more
>> suitable for simple systems as it is more likely to be correct.
>>
>> [Palmer: commit text]
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> --
>>
>> I have specifically not included Peter's SOB on this, as he sent his
>> original patch
>> <https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>
>> without one.
>> ---
>>   include/asm-generic/ticket-lock-types.h | 11 ++++
>>   include/asm-generic/ticket-lock.h       | 86 +++++++++++++++++++++++++
>>   2 files changed, 97 insertions(+)
>>   create mode 100644 include/asm-generic/ticket-lock-types.h
>>   create mode 100644 include/asm-generic/ticket-lock.h
>>
>> diff --git a/include/asm-generic/ticket-lock-types.h b/include/asm-generic/ticket-lock-types.h
>> new file mode 100644
>> index 000000000000..829759aedda8
>> --- /dev/null
>> +++ b/include/asm-generic/ticket-lock-types.h
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef __ASM_GENERIC_TICKET_LOCK_TYPES_H
>> +#define __ASM_GENERIC_TICKET_LOCK_TYPES_H
>> +
>> +#include <linux/types.h>
>> +typedef atomic_t arch_spinlock_t;
>> +
>> +#define __ARCH_SPIN_LOCK_UNLOCKED	ATOMIC_INIT(0)
>> +
>> +#endif /* __ASM_GENERIC_TICKET_LOCK_TYPES_H */
>> diff --git a/include/asm-generic/ticket-lock.h b/include/asm-generic/ticket-lock.h
>> new file mode 100644
>> index 000000000000..3f0d53e21a37
>> --- /dev/null
>> +++ b/include/asm-generic/ticket-lock.h
>> @@ -0,0 +1,86 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +/*
>> + * 'Generic' ticket-lock implementation.
>> + *
>> + * It relies on atomic_fetch_add() having well defined forward progress
>> + * guarantees under contention. If your architecture cannot provide this, stick
>> + * to a test-and-set lock.
>> + *
>> + * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
>> + * sub-word of the value. This is generally true for anything LL/SC although
>> + * you'd be hard pressed to find anything useful in architecture specifications
>> + * about this. If your architecture cannot do this you might be better off with
>> + * a test-and-set.
>> + *
>> + * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
>> + * uses atomic_fetch_add() which is SC to create an RCsc lock.
>> + *
> Probably it's better to use "fully-ordered" instead of "SC", because our
> atomic documents never use "SC" or "Sequential Consisteny" to describe
> the semantics, further I'm not sure our "fully-ordered" is equivalent to
> SC, better not cause misunderstanding in the future here.

The terms RCpc, RCsc comes from academia. I believe we can keep this but 
add more comment to elaborate what they are and what do they mean for 
the average kernel engineer.

Cheers,
Longman

