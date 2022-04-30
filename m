From: Jason A. Donenfeld <Jason@zx2c4.com>
Date: Sat, 30 Apr 2022 14:24:33 +0200
Subject: [OpenRISC] [PATCH v8 06/19] openrisc: start CPU timer early in boot
In-Reply-To: <20220430122355.2718797-1-Jason@zx2c4.com>
References: <20220430122355.2718797-1-Jason@zx2c4.com>
Message-ID: <20220430122433.2719029-1-Jason@zx2c4.com>
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
Cc: Stafford Horne <shorne@gmail.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v7->v8:
- Rather than doing get_cycles()+1 to handle the early boot case,
  actually start the timer early in boot. This has the huge advantage of
  properly measuring the boot sequence timing, which could be a valuable
  source of entropy.

 arch/openrisc/include/asm/timex.h | 1 +
 arch/openrisc/kernel/setup.c      | 7 +++++++
 2 files changed, 8 insertions(+)

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
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 0cd04d936a7a..1cb7c1770a17 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -220,6 +220,13 @@ void __init setup_cpuinfo(void)
 
 void __init or1k_early_setup(void *fdt)
 {
+	/* Start the TTCR as early as possible, so that the RNG can make use of
+	 * measurements of boot time from the earliest opportunity. Especially
+	 * important is that the TTCR does not return zero by the time we reach
+	 * rand_initialize().
+	 */
+	mtspr(SPR_TTMR, SPR_TTMR_CR);
+
 	if (fdt)
 		pr_info("FDT at %p\n", fdt);
 	else {
-- 
2.35.1

