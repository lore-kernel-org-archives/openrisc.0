From: Stafford Horne <shorne@gmail.com>
Date: Tue, 22 Mar 2022 06:29:29 +0900
Subject: [OpenRISC] [PATCH 3/5] openrisc: Move to ticket-spinlock
In-Reply-To: <20220316232600.20419-4-palmer@rivosinc.com>
References: <20220316232600.20419-1-palmer@rivosinc.com>
 <20220316232600.20419-4-palmer@rivosinc.com>
Message-ID: <YjjuOZMzQlnqfLDJ@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Mar 16, 2022 at 04:25:58PM -0700, Palmer Dabbelt wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> We have no indications that openrisc meets the qspinlock requirements,
> so move to ticket-spinlock as that is more likey to be correct.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> ---
> 
> I have specifically not included Peter's SOB on this, as he sent his
> original patch
> <https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>
> without one.
> ---
>  arch/openrisc/Kconfig                      | 1 -
>  arch/openrisc/include/asm/Kbuild           | 5 ++---
>  arch/openrisc/include/asm/spinlock.h       | 3 +--
>  arch/openrisc/include/asm/spinlock_types.h | 2 +-
>  4 files changed, 4 insertions(+), 7 deletions(-)

Hello,

This series breaks SMP support on OpenRISC.  I haven't traced it down yet, it
seems trivial but I have a few places to check.

I replied to this on a kbuild warning thread, but also going to reply here with
more information.

 https://lore.kernel.org/lkml/YjeY7CfaFKjr8IUc at antec/#R

So far this is what I see:

  * ticket_lock is stuck trying to lock console_sem
  * it is stuck on atomic_cond_read_acquire
    reading lock value: returns 0    (*lock is 0x10000)
    ticket value: is 1
  * possible issues:
    - OpenRISC is big endian, that seems to impact ticket_unlock, it looks
      like we are failing on the first call to ticket_lock though

Backtrace:
    (gdb) target remote :10001
    Remote debugging using :10001
    ticket_lock (lock=0xc049e078 <console_sem>) at include/asm-generic/ticket-lock.h:39
    39              atomic_cond_read_acquire(lock, ticket == (u16)VAL);
    (gdb) bt
    #0  ticket_lock (lock=0xc049e078 <console_sem>) at include/asm-generic/ticket-lock.h:39
    #1  do_raw_spin_lock (lock=0xc049e078 <console_sem>) at include/linux/spinlock.h:185
    #2  __raw_spin_lock_irqsave (lock=0xc049e078 <console_sem>) at include/linux/spinlock_api_smp.h:111
    #3  _raw_spin_lock_irqsave (lock=0xc049e078 <console_sem>) at kernel/locking/spinlock.c:162
    Backtrace stopped: Cannot access memory at address 0xc0491ee8

Code:

    31      static __always_inline void ticket_lock(arch_spinlock_t *lock)
    32      {
    33              u32 val = atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
    34              u16 ticket = val >> 16;
    35
    36              if (ticket == (u16)val)
    37                      return;
    38
    39              atomic_cond_read_acquire(lock, ticket == (u16)VAL); <--- stuck here
    40      }

Assembly:

    c04232ac <_raw_spin_lock_irqsave>:
    c04232ac:       9c 21 ff f0     l.addi r1,r1,-16
    c04232b0:       d4 01 10 08     l.sw 8(r1),r2
    c04232b4:       9c 41 00 10     l.addi r2,r1,16
    c04232b8:       d4 01 80 00     l.sw 0(r1),r16
    c04232bc:       d4 01 90 04     l.sw 4(r1),r18
    c04232c0:       d4 01 48 0c     l.sw 12(r1),r9
    c04232c4:       07 ef 8b 35     l.jal c0005f98 <arch_local_save_flags>
    c04232c8:       e2 03 18 04     l.or r16,r3,r3
    c04232cc:       18 60 00 00     l.movhi r3,0x0
    c04232d0:       07 ef 8b 3c     l.jal c0005fc0 <arch_local_irq_restore>
    c04232d4:       e2 4b 58 04     l.or r18,r11,r11
    c04232d8:       1a 60 00 01     l.movhi r19,0x1
atomic_fetch_add:
    c04232dc:       6e 30 00 00     l.lwa r17,0(r16)
    c04232e0:       e2 31 98 00     l.add r17,r17,r19
    c04232e4:       cc 10 88 00     l.swa 0(r16),r17
    c04232e8:       0f ff ff fd     l.bnf c04232dc <_raw_spin_lock_irqsave+0x30>
    c04232ec:       15 00 00 00      l.nop 0x0
u16 ticket = val >> 16;
    c04232f0:       ba 71 00 50     l.srli r19,r17,0x10
    c04232f4:       a6 31 ff ff     l.andi r17,r17,0xffff
    c04232f8:       e4 13 88 00     l.sfeq r19,r17
    c04232fc:       10 00 00 0e     l.bf c0423334 <_raw_spin_lock_irqsave+0x88>
    c0423300:       e1 72 90 04      l.or r11,r18,r18
if (ticket == (u16)val):
    c0423304:       86 30 00 00     l.lwz r17,0(r16)
    c0423308:       a6 31 ff ff     l.andi r17,r17,0xffff
    c042330c:       e4 11 98 00     l.sfeq r17,r19
    c0423310:       10 00 00 07     l.bf c042332c <_raw_spin_lock_irqsave+0x80>
    c0423314:       15 00 00 00      l.nop 0x0
atomic_cond_read_acquire:
    c0423318:       86 30 00 00     l.lwz r17,0(r16)
    c042331c:       a6 31 ff ff     l.andi r17,r17,0xffff
    c0423320:       e4 33 88 00     l.sfne r19,r17
    c0423324:       13 ff ff fd     l.bf c0423318 <_raw_spin_lock_irqsave+0x6c>
    c0423328:       15 00 00 00      l.nop 0x0
    c042332c:       22 00 00 00     l.msync
    c0423330:       e1 72 90 04     l.or r11,r18,r18
    c0423334:       86 01 00 00     l.lwz r16,0(r1)
    c0423338:       86 41 00 04     l.lwz r18,4(r1)
    c042333c:       84 41 00 08     l.lwz r2,8(r1)
    c0423340:       85 21 00 0c     l.lwz r9,12(r1)
    c0423344:       44 00 48 00     l.jr r9
    c0423348:       9c 21 00 10     l.addi r1,r1,16


-Stafford

> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index f724b3f1aeed..f5fa226362f6 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -30,7 +30,6 @@ config OPENRISC
>  	select HAVE_DEBUG_STACKOVERFLOW
>  	select OR1K_PIC
>  	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
> -	select ARCH_USE_QUEUED_SPINLOCKS
>  	select ARCH_USE_QUEUED_RWLOCKS
>  	select OMPIC if SMP
>  	select ARCH_WANT_FRAME_POINTERS
> diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
> index ca5987e11053..cb260e7d73db 100644
> --- a/arch/openrisc/include/asm/Kbuild
> +++ b/arch/openrisc/include/asm/Kbuild
> @@ -1,9 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  generic-y += extable.h
>  generic-y += kvm_para.h
> -generic-y += mcs_spinlock.h
> -generic-y += qspinlock_types.h
> -generic-y += qspinlock.h
> +generic-y += ticket-lock.h
> +generic-y += ticket-lock-types.h
>  generic-y += qrwlock_types.h
>  generic-y += qrwlock.h
>  generic-y += user.h
> diff --git a/arch/openrisc/include/asm/spinlock.h b/arch/openrisc/include/asm/spinlock.h
> index 264944a71535..40e4c9fdc349 100644
> --- a/arch/openrisc/include/asm/spinlock.h
> +++ b/arch/openrisc/include/asm/spinlock.h
> @@ -15,8 +15,7 @@
>  #ifndef __ASM_OPENRISC_SPINLOCK_H
>  #define __ASM_OPENRISC_SPINLOCK_H
>  
> -#include <asm/qspinlock.h>
> -
> +#include <asm/ticket-lock.h>
>  #include <asm/qrwlock.h>
>  
>  #define arch_spin_relax(lock)	cpu_relax()
> diff --git a/arch/openrisc/include/asm/spinlock_types.h b/arch/openrisc/include/asm/spinlock_types.h
> index 7c6fb1208c88..58ea31fa65ce 100644
> --- a/arch/openrisc/include/asm/spinlock_types.h
> +++ b/arch/openrisc/include/asm/spinlock_types.h
> @@ -1,7 +1,7 @@
>  #ifndef _ASM_OPENRISC_SPINLOCK_TYPES_H
>  #define _ASM_OPENRISC_SPINLOCK_TYPES_H
>  
> -#include <asm/qspinlock_types.h>
> +#include <asm/ticket-lock-types.h>
>  #include <asm/qrwlock_types.h>
>  
>  #endif /* _ASM_OPENRISC_SPINLOCK_TYPES_H */
> -- 
> 2.34.1
> 
