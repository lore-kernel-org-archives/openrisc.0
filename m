From: guoren@kernel.org <guoren@kernel.org>
Date: Sat, 19 Mar 2022 11:54:53 +0800
Subject: [OpenRISC] [PATCH V2 1/5] asm-generic: ticket-lock: New generic
 ticket-based spinlock
In-Reply-To: <20220319035457.2214979-1-guoren@kernel.org>
References: <20220319035457.2214979-1-guoren@kernel.org>
Message-ID: <20220319035457.2214979-2-guoren@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Peter Zijlstra <peterz@infradead.org>

This is a simple, fair spinlock.  Specifically it doesn't have all the
subtle memory model dependencies that qspinlock has, which makes it more
suitable for simple systems as it is more likely to be correct.

[Palmer: commit text]
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

--

I have specifically not included Peter's SOB on this, as he sent his
original patch
<https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>
without one.
---
 include/asm-generic/spinlock.h          | 11 +++-
 include/asm-generic/spinlock_types.h    | 15 +++++
 include/asm-generic/ticket-lock-types.h | 11 ++++
 include/asm-generic/ticket-lock.h       | 86 +++++++++++++++++++++++++
 4 files changed, 120 insertions(+), 3 deletions(-)
 create mode 100644 include/asm-generic/spinlock_types.h
 create mode 100644 include/asm-generic/ticket-lock-types.h
 create mode 100644 include/asm-generic/ticket-lock.h

diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
index adaf6acab172..a8e2aa1bcea4 100644
--- a/include/asm-generic/spinlock.h
+++ b/include/asm-generic/spinlock.h
@@ -1,12 +1,17 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_GENERIC_SPINLOCK_H
 #define __ASM_GENERIC_SPINLOCK_H
+
 /*
- * You need to implement asm/spinlock.h for SMP support. The generic
- * version does not handle SMP.
+ * Using ticket-spinlock.h as generic for SMP support.
  */
 #ifdef CONFIG_SMP
-#error need an architecture specific asm/spinlock.h
+#include <asm-generic/ticket-lock.h>
+#ifdef CONFIG_QUEUED_RWLOCKS
+#include <asm-generic/qrwlock.h>
+#else
+#error Please select ARCH_USE_QUEUED_RWLOCKS in architecture Kconfig
+#endif
 #endif
 
 #endif /* __ASM_GENERIC_SPINLOCK_H */
diff --git a/include/asm-generic/spinlock_types.h b/include/asm-generic/spinlock_types.h
new file mode 100644
index 000000000000..ba8ef4b731ba
--- /dev/null
+++ b/include/asm-generic/spinlock_types.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_SPINLOCK_TYPES_H
+#define __ASM_GENERIC_SPINLOCK_TYPES_H
+
+/*
+ * Using ticket spinlock as generic for SMP support.
+ */
+#ifdef CONFIG_SMP
+#include <asm-generic/ticket-lock-types.h>
+#include <asm-generic/qrwlock_types.h>
+#else
+#error The asm-generic/spinlock_types.h is not for CONFIG_SMP=n
+#endif
+
+#endif /* __ASM_GENERIC_SPINLOCK_TYPES_H */
diff --git a/include/asm-generic/ticket-lock-types.h b/include/asm-generic/ticket-lock-types.h
new file mode 100644
index 000000000000..829759aedda8
--- /dev/null
+++ b/include/asm-generic/ticket-lock-types.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_GENERIC_TICKET_LOCK_TYPES_H
+#define __ASM_GENERIC_TICKET_LOCK_TYPES_H
+
+#include <linux/types.h>
+typedef atomic_t arch_spinlock_t;
+
+#define __ARCH_SPIN_LOCK_UNLOCKED	ATOMIC_INIT(0)
+
+#endif /* __ASM_GENERIC_TICKET_LOCK_TYPES_H */
diff --git a/include/asm-generic/ticket-lock.h b/include/asm-generic/ticket-lock.h
new file mode 100644
index 000000000000..59373de3e32a
--- /dev/null
+++ b/include/asm-generic/ticket-lock.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * 'Generic' ticket-lock implementation.
+ *
+ * It relies on atomic_fetch_add() having well defined forward progress
+ * guarantees under contention. If your architecture cannot provide this, stick
+ * to a test-and-set lock.
+ *
+ * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
+ * sub-word of the value. This is generally true for anything LL/SC although
+ * you'd be hard pressed to find anything useful in architecture specifications
+ * about this. If your architecture cannot do this you might be better off with
+ * a test-and-set.
+ *
+ * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
+ * uses atomic_fetch_add() which is SC to create an RCsc lock.
+ *
+ * The implementation uses smp_cond_load_acquire() to spin, so if the
+ * architecture has WFE like instructions to sleep instead of poll for word
+ * modifications be sure to implement that (see ARM64 for example).
+ *
+ */
+
+#ifndef __ASM_GENERIC_TICKET_LOCK_H
+#define __ASM_GENERIC_TICKET_LOCK_H
+
+#include <linux/atomic.h>
+#include <asm-generic/ticket-lock-types.h>
+
+static __always_inline void ticket_lock(arch_spinlock_t *lock)
+{
+	u32 val = atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
+	u16 ticket = val >> 16;
+
+	if (ticket == (u16)val)
+		return;
+
+	atomic_cond_read_acquire(lock, ticket == (u16)VAL);
+}
+
+static __always_inline bool ticket_trylock(arch_spinlock_t *lock)
+{
+	u32 old = atomic_read(lock);
+
+	if ((old >> 16) != (old & 0xffff))
+		return false;
+
+	return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, for RCsc */
+}
+
+static __always_inline void ticket_unlock(arch_spinlock_t *lock)
+{
+	u16 *ptr = (u16 *)lock + __is_defined(__BIG_ENDIAN);
+	u32 val = atomic_read(lock);
+
+	smp_store_release(ptr, (u16)val + 1);
+}
+
+static __always_inline int ticket_is_locked(arch_spinlock_t *lock)
+{
+	u32 val = atomic_read(lock);
+
+	return ((val >> 16) != (val & 0xffff));
+}
+
+static __always_inline int ticket_is_contended(arch_spinlock_t *lock)
+{
+	u32 val = atomic_read(lock);
+
+	return (s16)((val >> 16) - (val & 0xffff)) > 1;
+}
+
+static __always_inline int ticket_value_unlocked(arch_spinlock_t lock)
+{
+	return !ticket_is_locked(&lock);
+}
+
+#define arch_spin_lock(l)		ticket_lock(l)
+#define arch_spin_trylock(l)		ticket_trylock(l)
+#define arch_spin_unlock(l)		ticket_unlock(l)
+#define arch_spin_is_locked(l)		ticket_is_locked(l)
+#define arch_spin_is_contended(l)	ticket_is_contended(l)
+#define arch_spin_value_unlocked(l)	ticket_value_unlocked(l)
+
+#endif /* __ASM_GENERIC_TICKET_LOCK_H */
-- 
2.25.1

