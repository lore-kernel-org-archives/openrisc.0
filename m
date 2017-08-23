From: Stafford Horne <shorne@gmail.com>
Date: Wed, 23 Aug 2017 14:57:13 +0900
Subject: [OpenRISC] [PATCH 5/5] openrisc: Only kick cpu on timeout,
	not on update
In-Reply-To: <cover.1503467674.git.shorne@gmail.com>
References: <cover.1503467674.git.shorne@gmail.com>
Message-ID: <5bbe0752efa40ad6fe397a344967ee0b93394392.1503467674.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Previously we were kicking the cpu on every update.  This caused
problems noticeable in SMP configurations where one CPU got pinned
continuously servicing timer exceptions.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 hw/openrisc/cputimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index 4c5415ff75..850f88761c 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -78,7 +78,6 @@ void cpu_openrisc_timer_update(OpenRISCCPU *cpu)
     }
     next = now + (uint64_t)wait * TIMER_PERIOD;
     timer_mod(cpu->env.timer, next);
-    qemu_cpu_kick(CPU(cpu));
 }
 
 void cpu_openrisc_count_start(OpenRISCCPU *cpu)
@@ -120,6 +119,7 @@ static void openrisc_timer_cb(void *opaque)
     }
 
     cpu_openrisc_timer_update(cpu);
+    qemu_cpu_kick(CPU(cpu));
 }
 
 static const VMStateDescription vmstate_or1k_timer = {
-- 
2.13.5

