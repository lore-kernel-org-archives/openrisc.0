From: Waiman Long <longman@redhat.com>
Date: Fri, 15 Apr 2022 13:02:42 -0400
Subject: [OpenRISC] [PATCH v3 1/7] asm-generic: ticket-lock: New generic
 ticket-based spinlock
In-Reply-To: <mhng-f4d144dd-b6ed-4f3f-bfc3-6dc29fab14e4@palmer-ri-x1c9>
References: <mhng-f4d144dd-b6ed-4f3f-bfc3-6dc29fab14e4@palmer-ri-x1c9>
Message-ID: <8f2a3903-ab49-23cc-a362-a9857dc38410@redhat.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On 4/15/22 12:46, Palmer Dabbelt wrote:
>
>>> diff --git a/include/asm-generic/spinlock_types.h 
>>> b/include/asm-generic/spinlock_types.h
>>> new file mode 100644
>>> index 000000000000..e56ddb84d030
>>> --- /dev/null
>>> +++ b/include/asm-generic/spinlock_types.h
>>> @@ -0,0 +1,17 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +
>>> +#ifndef __ASM_GENERIC_TICKET_LOCK_TYPES_H
>>> +#define __ASM_GENERIC_TICKET_LOCK_TYPES_H
>>> +
>>> +#include <linux/types.h>
>>> +typedef atomic_t arch_spinlock_t;
>>> +
>>> +/*
>>> + * qrwlock_types depends on arch_spinlock_t, so we must typedef 
>>> that before the
>>> + * include.
>>> + */
>>> +#include <asm/qrwlock_types.h>
>>
>> I believe that if you guard the include line by
>>
>> #ifdef CONFIG_QUEUED_RWLOCK
>> #include <asm/qrwlock_types.h>
>> #endif
>>
>> You may not need to do the hack in patch 5.
>
> Yes, and we actually had it that way the first time around 
> (specifically the ARCH_USES_QUEUED_RWLOCKS, but IIUC that's the same 
> here).  The goal was to avoid adding the ifdef to the asm-generic code 
> and instead keep the oddness in arch/riscv, it's only there for that 
> one commit (and just so we can split out the spinlock conversion from 
> the rwlock conversion, in case there's a bug and these need to be 
> bisected later).
>
> I'd also considered renaming qrwlock* to rwlock*, which would avoid 
> the ifdef and make it a touch easier to override the rwlock 
> implementation, but that didn't seem useful enough to warrant the 
> diff.  These all seem a bit more coupled than I expected them to be 
> (both {spin,qrw}lock{,_types}.h and the bits in linux/), I looked into 
> cleaning that up a bit but it seemed like too much for just the one 
> patch set.

Then you are forcing arches that use asm_generic/spinlock.h to use 
qrwlock as well. Even though most of them probably will, but forcing it 
this way remove the flexibility an arch may want to have.

The difference between CONFIG_QUEUED_RWLOCK and ARCH_USES_QUEUED_RWLOCKS 
is that qrwlock will not be compiled in when PREEMPT_RT || !SMP. So 
CONFIG_QUEUED_RWLOCK is a more accurate guard as to whether qrwlock 
should really be used.

Cheers,
Longman

