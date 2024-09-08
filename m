Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AF14D8B1
	for <linux-openrisc@vger.kernel.org>; Sun,  8 Sep 2024 06:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725776887; cv=none; b=P5J+QKbnayRq0PpEWEdpd6sfcJmjhXj7rLOth3gy12Wl6Zwk8fZEOq975X3STgevSp8FevEItUTSapbLSXLn10uqRZdBFqT0CbClRkWaa46KMgYz6sBoTTH23ZmM0YW4+bIk5anOuwgvJphoBO1r25Q/8MOSSTyP0+gRepKSo8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725776887; c=relaxed/simple;
	bh=bHf3jxDKMOu4UMUjiTEgrKF9tnD+Jtp6jFEwRRgk1P8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JwEpvucNz1XFUOJUtWC+0bCgxbpGhDxcHNhdhB1pXFEB1UmMTS1rOYKvglhjyHGhwER/XH50gCQ053bf0a7DLoMoZ4mz7Bq2gaJYqq7NHtq5Pv5RvsBDoqsaLPUG96COTWYyV7ogPu7Eh0GmYDpYa6kTPVj6xLo2cRGKc2F/PbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCxwBVkz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCxwBVkz"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c26852aff1so3666685a12.3
        for <linux-openrisc@vger.kernel.org>; Sat, 07 Sep 2024 23:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725776884; x=1726381684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6R/TZIsXBzuReDabzK3J/0O6ds/Phifq4VURxFA64W4=;
        b=fCxwBVkz4OsNbfD8Ayrqyc7P0HV3IevNNWWvOr3fue1I4WgXpV4KxMscc4TQ7llUB6
         pjCpbSd3o+h98o+oIfnZk6MpSolP16YsqTeINi1ilvEIniibGGYf5nETF4lsDtU3vnSF
         ekLoaQ1xdpvTtlNCrlkKPTisxAzXhK0voUuvjU5FgtsRGwzSL5zVnsh+uuI4dIzDf7eW
         wxP0WqAYXmn8icmiUWjt6QdMB5XXar1ml24yYnK9B9CTqqsaMsrbJK2qknKxReOp4snj
         BNIEMVYmdidylmMn26W0+TgiTydS3uS10UzFZzkEACAwByF4TuLhZyHW69h5UfoD8RIO
         37kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725776884; x=1726381684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6R/TZIsXBzuReDabzK3J/0O6ds/Phifq4VURxFA64W4=;
        b=I+kp/TSeTx0wy44XBslYWx0v/KJbYGVqvLFGkEHizu8AZ8QhDUuKmO7M/lR6dBlp+c
         /kTjLgPLYjFmuFV1ZCzs5jA5uxGigHiS5RQqkPxWd00Mgmw0Mm46HYLGRd0H4iXwQ/1k
         ueLk0I+GzYiEzesJNXjxgogpUI1LicbtSraYETmIKGtvQZhp2ZXbIDIpuatk0cQXdmBm
         7Q1RNYmlQbrBOTS/mpUUQhdbmWdEr3Jxv3KAxUJuY4Lt3fzhIIz2VlGR4GPTiJZuMSJf
         R4Ln29ImVJRpmNDqyUkDJemJfMo1OoBwpl5SQWnNV1uNY3vdb0SV3yzIhpj/xxs92Mdm
         bWiQ==
X-Gm-Message-State: AOJu0YxpchCKepzwAF16MM0H4bTOV5hZuaGXrcm7Y9XYKu8opmYdpGn1
	xbxKTgropaqQlMyuu+5JJmuxc63lWOwM5omZpwI4AD7CMkPv9mUg
X-Google-Smtp-Source: AGHT+IEXtLQY4zAyGZeRMs7InslJorDB+smfhjNE6Mhlu+4SyU7e82Z7krjotibaE8yMBzE96kK1ng==
X-Received: by 2002:a17:907:968a:b0:a8d:2d35:3dc4 with SMTP id a640c23a62f3a-a8d2d353f15mr185933266b.18.1725776883314;
        Sat, 07 Sep 2024 23:28:03 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ced41esm159980966b.171.2024.09.07.23.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 23:28:01 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Stafford Horne <shorne@gmail.com>,
	Jia Liu <proljc@gmail.com>
Subject: [PATCH v2] hw/openrisc/openrisc_sim: keep serial@90000000 as default
Date: Sun,  8 Sep 2024 07:27:56 +0100
Message-ID: <20240908062756.70514-1-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

We used to only have a single UART on the platform and it was located at
address 0x90000000. When the number of UARTs was increased to 4, the
first UART remained at it's location, but instead of being the first one
to be registered, it became the last.

This caused QEMU to pick 0x90000300 as the default UART, which broke
software that hardcoded the address of 0x90000000 and expected it's
output to be visible when the user configured only a single console.

This caused regressions[1] in the barebox test suite when updating to a
newer QEMU. As there seems to be no good reason to register the UARTs in
inverse order, let's register them by ascending address, so existing
software can remain oblivious to the additional UART ports.

Changing the order of uart registration alone breaks Linux which
was choosing the UART at 0x90000300 as the default for ttyS0.  To fix
Linux we fix two things in the device tree:

 1. Define stdout-path only one time for the first registerd UART
    instead of incorrectly defining for each UART.
 2. Change the UART alias name from 'uart0' to 'serial0' as almost all
    Linux tty drivers look for an alias starting with "serial".

[1]: https://lore.barebox.org/barebox/707e7c50-aad1-4459-8796-0cc54bab32e2@pengutronix.de/T/#m5da26e8a799033301489a938b5d5667b81cef6ad

Fixes: 777784bda468 ("hw/openrisc: support 4 serial ports in or1ksim")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
[stafford: Change to serial0 alias and update change message]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v1:
 - Stafford is sending the patch for Ahmad now.
 - Added 'Fixes'
 - Only define stdout-path one time.
 - Change alias name from 'uartN' to 'serialN'

 hw/openrisc/openrisc_sim.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index bffd6f721f..2a15a3a4f0 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -250,7 +250,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
     void *fdt = state->fdt;
     char *nodename;
     qemu_irq serial_irq;
-    char alias[sizeof("uart0")];
+    char alias[sizeof("serial0")];
     int i;
 
     if (num_cpus > 1) {
@@ -265,7 +265,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
         serial_irq = get_cpu_irq(cpus, 0, irq_pin);
     }
     serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
-                   serial_hd(OR1KSIM_UART_COUNT - uart_idx - 1),
+                   serial_hd(uart_idx),
                    DEVICE_NATIVE_ENDIAN);
 
     /* Add device tree node for serial. */
@@ -277,10 +277,13 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
     qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", OR1KSIM_CLK_MHZ);
     qemu_fdt_setprop(fdt, nodename, "big-endian", NULL, 0);
 
-    /* The /chosen node is created during fdt creation. */
-    qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
-    snprintf(alias, sizeof(alias), "uart%d", uart_idx);
+    if (uart_idx == 0) {
+        /* The /chosen node is created during fdt creation. */
+        qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
+    }
+    snprintf(alias, sizeof(alias), "serial%d", uart_idx);
     qemu_fdt_setprop_string(fdt, "/aliases", alias, nodename);
+
     g_free(nodename);
 }
 
-- 
2.44.0

