From: Jason A. Donenfeld <Jason@zx2c4.com>
Date: Tue,  3 May 2022 01:20:56 +0200
Subject: [OpenRISC] [PATCH] hw/openrisc: support 4 serial ports in or1ksim
Message-ID: <20220502232056.248292-1-Jason@zx2c4.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

The 8250 serial controller supports 4 serial ports, so wire them all up,
so that we can have more than one basic I/O channel.

Cc: Stafford Horne <shorne@gmail.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 hw/openrisc/openrisc_sim.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index bf434e9737..fe07db1cc5 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -71,6 +71,10 @@ enum {
     OR1KSIM_ETHOC_IRQ = 4,
 };
 
+enum {
+    OR1KSIM_UART_COUNT = 4
+};
+
 static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
@@ -239,11 +243,13 @@ static void openrisc_sim_ompic_init(Or1ksimState *state, hwaddr base,
 
 static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
                                      hwaddr size, int num_cpus,
-                                     OpenRISCCPU *cpus[], int irq_pin)
+                                     OpenRISCCPU *cpus[], int irq_pin,
+                                     int uart_idx)
 {
     void *fdt = state->fdt;
     char *nodename;
     qemu_irq serial_irq;
+    char alias[sizeof("uart0")];
     int i;
 
     if (num_cpus > 1) {
@@ -258,7 +264,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
         serial_irq = get_cpu_irq(cpus, 0, irq_pin);
     }
     serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
-                   serial_hd(0), DEVICE_NATIVE_ENDIAN);
+                   serial_hd(OR1KSIM_UART_COUNT - uart_idx - 1), DEVICE_NATIVE_ENDIAN);
 
     /* Add device tree node for serial. */
     nodename = g_strdup_printf("/serial@%" HWADDR_PRIx, base);
@@ -271,7 +277,8 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
 
     /* The /chosen node is created during fdt creation. */
     qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
-    qemu_fdt_setprop_string(fdt, "/aliases", "uart0", nodename);
+    snprintf(alias, sizeof(alias), "uart%d", uart_idx);
+    qemu_fdt_setprop_string(fdt, "/aliases", alias, nodename);
     g_free(nodename);
 }
 
@@ -414,9 +421,11 @@ static void openrisc_sim_init(MachineState *machine)
                                 smp_cpus, cpus, OR1KSIM_OMPIC_IRQ);
     }
 
-    openrisc_sim_serial_init(state, or1ksim_memmap[OR1KSIM_UART].base,
-                             or1ksim_memmap[OR1KSIM_UART].size, smp_cpus, cpus,
-                             OR1KSIM_UART_IRQ);
+    for (n = 0; n < OR1KSIM_UART_COUNT; ++n)
+            openrisc_sim_serial_init(state, or1ksim_memmap[OR1KSIM_UART].base +
+                                            or1ksim_memmap[OR1KSIM_UART].size * n,
+                                     or1ksim_memmap[OR1KSIM_UART].size, smp_cpus, cpus,
+                                     OR1KSIM_UART_IRQ, n);
 
     load_addr = openrisc_load_kernel(ram_size, kernel_filename);
     if (load_addr > 0) {
-- 
2.35.1

