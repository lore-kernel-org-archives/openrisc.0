From: Palmer Dabbelt <palmer@rivosinc.com>
Date: Wed, 16 Mar 2022 16:25:57 -0700
Subject: [OpenRISC] [PATCH 2/5] asm-generic: ticket-lock: New generic
 ticket-based spinlock
In-Reply-To: <20220316232600.20419-1-palmer@rivosinc.com>
References: <20220316232600.20419-1-palmer@rivosinc.com>
Message-ID: <20220316232600.20419-3-palmer@rivosinc.com>
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
 include/asm-generic/ticket-lock-types.h | 11 ++++
 include/asm-generic/ticket-lock.h       | 86 +++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 include/asm-generic/ticket-lock-types.h
 create mode 100644 include/asm-generic/ticket-lock.h

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
index 000000000000..3f0d53e21a37
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
+#include <asm/ticket-lock-types.h>
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
2.34.1

