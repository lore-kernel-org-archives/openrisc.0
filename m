Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE091C0DED;
	Fri, 27 Sep 2024 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449040; cv=none; b=mL+Yv0ole7gcDbfTkeC8LIz+ur/WWW2WJAYXMEKdw0iPJ3PfN8g2u1+1L1X2GvwdCcT+ATLjRMtJUISlv2XJoxG0C3O7ryuHzqgUAAyglqtZ5jqEFm0P0ikKMMMBJvRcy7O4nIRMnvUjnMrHCGFPkJ9/3p/iCqRwA0VCfh4uT6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449040; c=relaxed/simple;
	bh=iJ45fvLCkoCq/NM5VFXVYlJANk7NQ5g0O+CaSmLIbLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sozLPthuoCqr3Ee1P3Pxn6cGl1Rcr/xbBU3VEH5ByWO+wBeGDLFNZ53aBo/OCWlbHEeDM5/dkL+evQbvJ0QjrCxXQtMsPkchluPfuYrsx4azjgrgIyQkBzqRewoOjhSq/epUxTOXTn/xjAUNQERil0SySAoJ8tFFrdB+UelQfgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDPk87GY; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDPk87GY"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f7528f4658so21860721fa.3;
        Fri, 27 Sep 2024 07:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727449035; x=1728053835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb9IX3yRl7dl/yfTaoyaz4ZFMe4bzq/mwO1rvGCAOhw=;
        b=DDPk87GYQj7y/SRg4mHdpv9tBA7rgf9II5RPgz0jAICOEcXuqvNpVsXcqiPK0eNjkY
         GH/N0nrriSl5xHaVxVwglUrJhPKgXoElxnmsVSeq9mxTahnXOJv1wtZBl6vVEgRENuLt
         ebiP3jdmuRA1iEo9W+AHUC+ueKG97dSS1HQwDHEkiNyZjBz7LapbW6Ucab4IiV6UsArw
         3ZCfYWxnzz/cFrizD/Gzfa0EDJ+iT785ZGp0b39DQmwvp8kO2HJEZH99Gv1M+sJ0+pKU
         JvVq9O8tGcY4J8uTfe5iO8QqKz0rDD7+VWd4mGaq2nKza+dg2uIcBfuVuUWiIAP1wL7D
         3g6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449035; x=1728053835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gb9IX3yRl7dl/yfTaoyaz4ZFMe4bzq/mwO1rvGCAOhw=;
        b=MP+IM+2ZJBjOwojWcA8t7gnknAUiq39ywF/TZ1KM90G5vlJB3JFczANHsjqZNwTA1c
         gBrxJI2b3KXcJM2TKxshdJMzxZJ40Mo4QoZ7h4SwXL4sJ63F7C//79PcW6QN/Q8LS/6f
         UsY2+qj/jAAx8v44nefQRsveBLYkhKbyQzCFe2BrLm3b8J6YCPlP8t/+tGhfZPgwdC9E
         bmJnOl4ORKsvv+96fQZGYf1CZ2Lp0C7HTlX10rC4hqIFQ9oQ5nsDBagTmmh4kxmCrEyi
         RS1ymeJXouCPP3tasmv9JR32x3uU5WyYf3uIRx3+U8Lo33ZWxntUVtFRtmkWDe9V40tx
         aZeg==
X-Forwarded-Encrypted: i=1; AJvYcCVAXeBS3PQQRN7t0IQrHnUUSFRaDA86DxPJl/Rali5xQMN+Se5JPG0SB9LazM2VqHTR0UM3sQ39nYfHjYmG2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB1ybsE4TFiRvLJUHfhTbsdYLs7DAAzm7Afhhmhn2SbnDFzXm/
	lLgJcMD6mGkRGbsBQvSlMei3jeSHHCq/NX3tdqY97hZwwOJfSjNVKuQKoPBe7nI=
X-Google-Smtp-Source: AGHT+IGpq4XVA/JtvOSkaHkfn0YelZrSDEAI/UtaDLUhQvv6IcWEr8oegT8VWkdnLNZmZqxqum8MAw==
X-Received: by 2002:a05:6512:3d93:b0:536:a695:942c with SMTP id 2adb3069b0e04-5389fc29ca0mr2340854e87.7.1727449034293;
        Fri, 27 Sep 2024 07:57:14 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88245e737sm1227129a12.56.2024.09.27.07.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 07:57:11 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Stafford Horne <shorne@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Dawei Li <set_pte_at@outlook.com>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	linux-openrisc@vger.kernel.org
Subject: [PATCH] openrisc: Implement fixmap to fix eralycon
Date: Fri, 27 Sep 2024 15:56:56 +0100
Message-ID: <20240927145700.1963518-1-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 53c98e35dcbc ("openrisc: mm: remove unneeded early ioremap
code") it was commented that early ioremap was not used in OpenRISC.  I
acked this but was wrong.  Earlycon now fails with the below trace:

    Kernel command line: earlycon
    ------------[ cut here ]------------
    WARNING: CPU: 0 PID: 0 at mm/ioremap.c:23
    generic_ioremap_prot+0x118/0x130
    Modules linked in:
    CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted
    6.11.0-rc5-00001-gce02fd891c38-dirty #141
    Call trace:
    [<(ptrval)>] dump_stack_lvl+0x7c/0x9c
    [<(ptrval)>] dump_stack+0x1c/0x2c
    [<(ptrval)>] __warn+0xb4/0x108
    [<(ptrval)>] ? generic_ioremap_prot+0x118/0x130
    [<(ptrval)>] warn_slowpath_fmt+0x60/0x98
    [<(ptrval)>] generic_ioremap_prot+0x118/0x130
    [<(ptrval)>] ioremap_prot+0x20/0x30
    [<(ptrval)>] of_setup_earlycon+0xd4/0x2e0
    [<(ptrval)>] early_init_dt_scan_chosen_stdout+0x18c/0x1c8
    [<(ptrval)>] param_setup_earlycon+0x3c/0x60
    [<(ptrval)>] do_early_param+0xb0/0x118
    [<(ptrval)>] parse_args+0x184/0x4b8
    [<(ptrval)>] ? start_kernel+0x0/0x78c
    [<(ptrval)>] parse_early_options+0x40/0x50
    [<(ptrval)>] ? do_early_param+0x0/0x118
    [<(ptrval)>] parse_early_param+0x48/0x68
    [<(ptrval)>] ? start_kernel+0x318/0x78c
    [<(ptrval)>] ? start_kernel+0x0/0x78c
    ---[ end trace 0000000000000000 ]---

To fix this we could either implement early_ioremap or implement fixmap.
In this patch we choose the later option of implementing basic fixmap
support.

While fixing this we also remove the old FIX_IOREMAP slots that were
used by early ioremap code.  That code was also removed by commit
53c98e35dcbc ("openrisc: mm: remove unneeded early ioremap code") but
these definitions were not cleaned up.

Fixes: 53c98e35dcbc ("openrisc: mm: remove unneeded early ioremap code")
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig              |  3 +++
 arch/openrisc/include/asm/fixmap.h | 21 +++++-------------
 arch/openrisc/mm/init.c            | 34 ++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 69c0258700b2..3279ef457c57 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -65,6 +65,9 @@ config STACKTRACE_SUPPORT
 config LOCKDEP_SUPPORT
 	def_bool  y
 
+config FIX_EARLYCON_MEM
+	def_bool y
+
 menu "Processor type and features"
 
 choice
diff --git a/arch/openrisc/include/asm/fixmap.h b/arch/openrisc/include/asm/fixmap.h
index ecdb98a5839f..aaa6a26a3e92 100644
--- a/arch/openrisc/include/asm/fixmap.h
+++ b/arch/openrisc/include/asm/fixmap.h
@@ -26,29 +26,18 @@
 #include <linux/bug.h>
 #include <asm/page.h>
 
-/*
- * On OpenRISC we use these special fixed_addresses for doing ioremap
- * early in the boot process before memory initialization is complete.
- * This is used, in particular, by the early serial console code.
- *
- * It's not really 'fixmap', per se, but fits loosely into the same
- * paradigm.
- */
 enum fixed_addresses {
-	/*
-	 * FIX_IOREMAP entries are useful for mapping physical address
-	 * space before ioremap() is useable, e.g. really early in boot
-	 * before kmalloc() is working.
-	 */
-#define FIX_N_IOREMAPS  32
-	FIX_IOREMAP_BEGIN,
-	FIX_IOREMAP_END = FIX_IOREMAP_BEGIN + FIX_N_IOREMAPS - 1,
+	FIX_EARLYCON_MEM_BASE,
 	__end_of_fixed_addresses
 };
 
 #define FIXADDR_SIZE		(__end_of_fixed_addresses << PAGE_SHIFT)
 /* FIXADDR_BOTTOM might be a better name here... */
 #define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)
+#define FIXMAP_PAGE_IO		PAGE_KERNEL_NOCACHE
+
+extern void __set_fixmap(enum fixed_addresses idx,
+			 phys_addr_t phys, pgprot_t flags);
 
 #include <asm-generic/fixmap.h>
 
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index 1dcd78c8f0e9..7397d18c95d7 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -207,6 +207,40 @@ void __init mem_init(void)
 	return;
 }
 
+static int __init map_page(unsigned long va, phys_addr_t pa, int flags)
+{
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pd;
+	pte_t *pg;
+	int err = -ENOMEM;
+
+	p4d = p4d_offset(pgd_offset_k(va), va);
+	pud = pud_offset(p4d, va);
+	pd = pmd_offset(pud, va);
+	pg = pte_alloc_kernel(pd, va);
+
+	if (pg != NULL) {
+		err = 0;
+		set_pte_at(&init_mm, va, pg, pfn_pte(pa >> PAGE_SHIFT,
+				__pgprot(flags)));
+	}
+	return err;
+}
+
+void __init __set_fixmap(enum fixed_addresses idx,
+			 phys_addr_t phys, pgprot_t prot)
+{
+	unsigned long address = __fix_to_virt(idx);
+
+	if (idx >= __end_of_fixed_addresses) {
+		BUG();
+		return;
+	}
+
+	map_page(address, phys, pgprot_val(prot));
+}
+
 static const pgprot_t protection_map[16] = {
 	[VM_NONE]					= PAGE_NONE,
 	[VM_READ]					= PAGE_READONLY_X,
-- 
2.44.0

