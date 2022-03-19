From: guoren@kernel.org <guoren@kernel.org>
Date: Sat, 19 Mar 2022 11:54:54 +0800
Subject: [OpenRISC] [PATCH V2 2/5] asm-generic: qspinlock: Indicate the use
 of mixed-size atomics
In-Reply-To: <20220319035457.2214979-1-guoren@kernel.org>
References: <20220319035457.2214979-1-guoren@kernel.org>
Message-ID: <20220319035457.2214979-3-guoren@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: Peter Zijlstra <peterz@infradead.org>

The qspinlock implementation depends on having well behaved mixed-size
atomics.  This is true on the more widely-used platforms, but these
requirements are somewhat subtle and may not be satisfied by all the
platforms that qspinlock is used on.

Document these requirements, so ports that use qspinlock can more easily
determine if they meet these requirements.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
---
 include/asm-generic/qspinlock.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index d74b13825501..a7a1296b0b4d 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -2,6 +2,36 @@
 /*
  * Queued spinlock
  *
+ * A 'generic' spinlock implementation that is based on MCS locks. An
+ * architecture that's looking for a 'generic' spinlock, please first consider
+ * ticket-lock.h and only come looking here when you've considered all the
+ * constraints below and can show your hardware does actually perform better
+ * with qspinlock.
+ *
+ *
+ * It relies on atomic_*_release()/atomic_*_acquire() to be RCsc (or no weaker
+ * than RCtso if you're power), where regular code only expects atomic_t to be
+ * RCpc.
+ *
+ * It relies on a far greater (compared to ticket-lock.h) set of atomic
+ * operations to behave well together, please audit them carefully to ensure
+ * they all have forward progress. Many atomic operations may default to
+ * cmpxchg() loops which will not have good forward progress properties on
+ * LL/SC architectures.
+ *
+ * One notable example is atomic_fetch_or_acquire(), which x86 cannot (cheaply)
+ * do. Carefully read the patches that introduced queued_fetch_set_pending_acquire().
+ *
+ * It also heavily relies on mixed size atomic operations, in specific it
+ * requires architectures to have xchg16; something which many LL/SC
+ * architectures need to implement as a 32bit and+or in order to satisfy the
+ * forward progress guarantees mentioned above.
+ *
+ * Further reading on mixed size atomics that might be relevant:
+ *
+ *   http://www.cl.cam.ac.uk/~pes20/popl17/mixed-size.pdf
+ *
+ *
  * (C) Copyright 2013-2015 Hewlett-Packard Development Company, L.P.
  * (C) Copyright 2015 Hewlett-Packard Enterprise Development LP
  *
-- 
2.25.1

