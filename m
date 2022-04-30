From: Jason A. Donenfeld <Jason@zx2c4.com>
Date: Sun,  1 May 2022 00:42:40 +0200
Subject: [OpenRISC] [PATCH v9 06/21] openrisc: start CPU timer early in boot
In-Reply-To: <CAHmME9r-=ShRomP=Nrcz-GjP4kv4e9wKHvNdAMiRui7_FSbH-A@mail.gmail.com>
References: <CAHmME9r-=ShRomP=Nrcz-GjP4kv4e9wKHvNdAMiRui7_FSbH-A@mail.gmail.com>
Message-ID: <20220430224240.3157636-1-Jason@zx2c4.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

In order to measure the boot process, the timer should be switched on as
early in boot as possible. This is necessary so that by the time the
setup code reaches random_init(), get_cycles() (by way of
random_get_entropy()) returns non-zero, indicating that it is actually
capable of counting. So this commit enables the timer immediately upon
booting up. As well, the commit define the get_cycles macro, like the
previous patches in this series, so that generic code is aware that it's
implemented by the platform, as is done on other archs.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Acked-by: Stafford Horne <shorne@gmail.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v8->v9:
- Use Stafford's suggested assembly in head.S instead of doing this
  later on in C, so that the cycle counter starts very early and thus
  "measures" boot.

 arch/openrisc/include/asm/timex.h | 1 +
 arch/openrisc/kernel/head.S       | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/openrisc/include/asm/timex.h b/arch/openrisc/include/asm/timex.h
index d52b4e536e3f..5487fa93dd9b 100644
--- a/arch/openrisc/include/asm/timex.h
+++ b/arch/openrisc/include/asm/timex.h
@@ -23,6 +23,7 @@ static inline cycles_t get_cycles(void)
 {
 	return mfspr(SPR_TTCR);
 }
+#define get_cycles get_cycles
 
 /* This isn't really used any more */
 #define CLOCK_TICK_RATE 1000
diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index 15f1b38dfe03..871f4c858859 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -521,6 +521,15 @@ _start:
 	l.ori	r3,r0,0x1
 	l.mtspr	r0,r3,SPR_SR
 
+	/*
+	 * Start the TTCR as early as possible, so that the RNG can make use of
+	 * measurements of boot time from the earliest opportunity. Especially
+	 * important is that the TTCR does not return zero by the time we reach
+	 * rand_initialize().
+	 */
+	l.movhi r3,hi(SPR_TTMR_CR)
+	l.mtspr r0,r3,SPR_TTMR
+
 	CLEAR_GPR(r1)
 	CLEAR_GPR(r2)
 	CLEAR_GPR(r3)
-- 
2.35.1

