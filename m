Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018106;
	b=XUlhERpLqB/js+T2Hq6+mJ204KfX7vufEeVkQ9FcbgLKUWnLUKdAjZXM9grBh7+O1frm
	 q8Ufu2XBt/LBNHbhNxThLY1FUDvGkug6XTFMT1/RYt5+V/F1q/sj9mBhxnq1OXU4ukeQh
	 lAJOXSxITlTbzrtpFyqJO4fmWxUDKsybNQvPhOSnuRjuM/l30rxDQyO/GRPU2K1yfMeje
	 LPQeXOg3We8b9QX51XSCSxbrv7jIma+GjBbWitzTrdPq9NqyauQOU6s+t5y9xnd0Hitf7
	 hQ+0v08av/0NZsbXkJ4JAxhk3ONmWUvA+Zxu+0eO7gatvqVZOL+rv4Be41xco+7D+BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018106;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eX5+FQsuccBi8Flwb7EhSWhHXuSZgtTPDPOP8aOOEYY=;
	b=s0xD0Y+oP3aoKXRH0I8gHrgSOb8GkkkRcqYh1xzOU/G9CCdHSNcBJ6rv0EOy/BgoihwA
	 tgev2pu52WcbOaIMMQxv9Vz+EWdH3sYemUDax5/B8lIJH7aoWisy2jm5tO0AZ5af8pFZu
	 /P+xGgEM37hcihlOjhdavn+cmNk0MbXzJo834jZtS3uNHNeC0Q/qI3tEWmwnfkEQ/N8o5
	 oAt+CDu+jOvFfElraClKlP6cGwA2qy/tdIJcd1VlFMddV7xpMBEvYltNJyf3Xws8ZrzNN
	 IV9QydkM7mKB75fZd122e/Y5VrdwqgZLMS3vYiqdN5yojT+RqJ64P6D+HyNkSAtd1kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4DB6X+Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07960606A320;
	Wed, 18 Nov 2026 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4DB6X+Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C599F1F000C5;
	Wed, 18 Nov 2026 16:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795018105;
	bh=eX5+FQsuccBi8Flwb7EhSWhHXuSZgtTPDPOP8aOOEYY=;
	h=From:To:Cc:Subject:Date;
	b=P4DB6X+QgsIS5swsW8E5NSdFw55ebvCSinmqzhbeKZUmGuFVIVCQp92fLAjnmLcuU
	 NxOGddGznszOUbEbIC/dWuzEv3VNQDoDU9ivDcngQlbcCRSELGFf3hPf3crL1zPeWG
	 zkjTHR9x3GdNlUHqzzYYngcUjMIwJicpEaDwreVzCo6lssp9EFmDyKML+0UU98Mw/V
	 6jfiGxG/CrfvRqgJTub3XK/XCmaOPSP3YkyLzgivtnIN6e3uzG/t5xiw77FK6LSbjj
	 jALl4mCSZkvl4Uxc5k3vWq2beFmQeiPZM7uI2pyUXEFdlAE74l5Iz9e+WSUJFrey4J
	 61NAc6SnohS9w==
From: Arnd Bergmann <arnd@kernel.org>
To: Stafford Horne <shorne@gmail.com>
Cc: soc@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	Vineet Gupta <vgupta@kernel.org>,
	linux-openrisc@vger.kernel.org
Subject: [PATCH] openrisc: stop using libgcc
Date: Wed, 18 Nov 2026 17:08:20 +0100
Message-ID: <20261118160820.2994933-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Post: <mailto:linux-openrisc@vger.kernel.org>
List-Help: <mailto:linux-openrisc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-openrisc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Based on the work for nios2 and arc, remove the inclusion of libgcc
and instead use the kernel's own copy of the required functions.

Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Simon Schuster <schuster.simon@siemens-energy.com>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: linux-openrisc@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Hi Stafford,

I've based this on top of the branch at
https://lore.kernel.org/all/20261118144652.3124085-1-dinguyen@kernel.org/
which I've merged into the asm-generic tree. Vineet already
has a similar patch for arch/arc, and I did the one for
arch/openrisc after seeing that everything is there.

If this looks ok to you, please Ack so I can merge it in the 
asm-generic tree as well.

      Arnd

 arch/openrisc/Kconfig             | 10 ++++++++++
 arch/openrisc/Makefile            |  3 ---
 arch/openrisc/kernel/or32_ksyms.c | 14 --------------
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 6aaedc67a5e0..5be29befd86c 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -22,6 +22,16 @@ config OPENRISC
 	select GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
+	select GENERIC_LIB_LSHRDI3
+	select GENERIC_LIB_ASHLDI3
+	select GENERIC_LIB_ASHRDI3
+	select GENERIC_LIB_MULDI3
+	select GENERIC_LIB_UCMPDI2
+	select GENERIC_LIB_DIVSI3
+	select GENERIC_LIB_MODSI3
+	select GENERIC_LIB_UDIVSI3
+	select GENERIC_LIB_UMODSI3
+	select GENERIC_LIB_MULSI3
 	select GENERIC_PCI_IOMAP
 	select GENERIC_IOREMAP
 	select GENERIC_CPU_DEVICES
diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
index 68249521db5a..38dc87bc6a3a 100644
--- a/arch/openrisc/Makefile
+++ b/arch/openrisc/Makefile
@@ -18,7 +18,6 @@
 KBUILD_DEFCONFIG := or1ksim_defconfig
 
 OBJCOPYFLAGS    := -O binary -R .note -R .comment -S
-LIBGCC 		:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
 
 KBUILD_CFLAGS	+= -pipe -ffixed-r10 -D__linux__
 KBUILD_CFLAGS	+= -msfimm -mshftimm
@@ -55,8 +54,6 @@ ifeq ($(CONFIG_OPENRISC_HAVE_INST_SEXT),y)
 	KBUILD_CFLAGS += $(call cc-option,-msext)
 endif
 
-libs-y		+= $(LIBGCC)
-
 PHONY += vmlinux.bin
 
 vmlinux.bin: vmlinux
diff --git a/arch/openrisc/kernel/or32_ksyms.c b/arch/openrisc/kernel/or32_ksyms.c
index 5aabef30ca09..7ae38030a9d4 100644
--- a/arch/openrisc/kernel/or32_ksyms.c
+++ b/arch/openrisc/kernel/or32_ksyms.c
@@ -27,20 +27,6 @@
 #include <asm/hardirq.h>
 #include <asm/delay.h>
 
-#define DECLARE_EXPORT(name) extern void name(void); EXPORT_SYMBOL(name)
-
-/* compiler generated symbols */
-DECLARE_EXPORT(__udivsi3);
-DECLARE_EXPORT(__divsi3);
-DECLARE_EXPORT(__umodsi3);
-DECLARE_EXPORT(__modsi3);
-DECLARE_EXPORT(__muldi3);
-DECLARE_EXPORT(__mulsi3);
-DECLARE_EXPORT(__ashrdi3);
-DECLARE_EXPORT(__ashldi3);
-DECLARE_EXPORT(__lshrdi3);
-DECLARE_EXPORT(__ucmpdi2);
-
 EXPORT_SYMBOL(__copy_tofrom_user);
 EXPORT_SYMBOL(__clear_user);
 EXPORT_SYMBOL(memset);
-- 
2.53.0

