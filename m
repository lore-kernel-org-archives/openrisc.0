Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6B26AFA;
	Fri, 18 Oct 2024 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260067; cv=none; b=s9XTSeVhYN/scybUlJVcSJqgNW3/5dnUnXnqUCOwv76LHMTRbL83KKNKx8G0LJ5z20BvnUFL/ygeMHdJsIkeeYP32XmAbXJ42BLiDVotT1096uhn/nv/CUXiZDclgwK0fXgIFMv8TSlHGL3HahTmLHzSmS/XYrJ1JG9sS/WgNCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260067; c=relaxed/simple;
	bh=Ley6Es3VGtdDZ4Qv270Cn0asYT58N2zkZo1w4Z6pPk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ogdv2xAVbuhGAJSWUxPxvXez8ehcIk04rzoRBX3tdlM659/TgjQJfqP3btghTCr8sEIfNd8joH/SkinsGommXIKbgz/sGi8D/sTYL8+IrNnuvz2l1Jc0D9HSaxZw62yTOYv0GcZzyzN28rdtt0sSLCkBD797ivtK8tHKekcGhfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj1tJkHt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj1tJkHt"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d63a79bb6so1566653f8f.0;
        Fri, 18 Oct 2024 07:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729260062; x=1729864862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Vx2MnrBLoCzscS6mShtKpOSetOXBodREMEvTPrgvoE=;
        b=mj1tJkHtzogW4sP1e636XI3GpFnD2HsPGEAVFVcXZkkGLU3z+a/UdyjLjpGDyrO9S7
         oFW7QFGQFouOcDlQlWsdhQ+dtDKmfwgdmernpJcKsDcQ/EiDrJnJfDZgKO2jDUXkddRn
         s7AbPstHtgZMt/kLmY0iPYQRbmBSWsjaSt5iiTN4M4cOF7Rl3il+k9ltHcXckCz09Qst
         AV+loM+Lng9CTkb+MBcIl/r327BPC3ehhqWISjzadXRBhPCAYfltl8FW5IHilu8Tlnnx
         qck8WZkmkLLvw0FZsYHnML6sKbVEa5bq1+VrFQeFTh6Sg47io30wooJsBw3dInmwxN0M
         CYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729260062; x=1729864862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Vx2MnrBLoCzscS6mShtKpOSetOXBodREMEvTPrgvoE=;
        b=tSNsBG4W4xPz3wODrMn0wJ8j5UchYf+ejnuBbLFXqb11RsxBmIhtBEZlPZ0oVyM4rd
         r3VFJFzDL4nCCECtGpbEdHynh4UWL9Ip4U4rzhOmFS+A1ABbFqK5XBn+EYa03519Cykf
         nV+hDJDGUabACsWNAu6yBHqjwVQNCrCPZLIaaTn6dvDKFysGQ+zd3F7qgpeAxxOFNuyR
         rPuAw6fokgiPRQWPHKJujXDGXB3HSdp1INws9wn0pY/N6uGQaVPiNL7+5YHfiHFfQiBF
         fTI1OaSgP7cIVCU5MCbgug6rqNYFiaKqH5HAnhu0rwWN2Q2yKLmtBt/oH4QzD4ulg5hK
         mI8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8Q8fQH2UTQWPBDfxOH6ptHLH/ZE0NuhFNIwKWlTbjE1IyC/Q1qkL5/LoQlSlkujtUOFB7n0noMqYBNvBSsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmqTcGI8qRob49Nz2jhnOVUyJeXw3t7y6JKBJAPcksyArQjHmD
	HcW9++wnZm/O3IGDTjVqKNdpRPESLTiDP7aBVU9gEhemVa15fIUYypJqf1d1
X-Google-Smtp-Source: AGHT+IHj7B5liVBVdt+srf7FrLnpi/Ce837IGUHulRGjrRsunyMxaF9JxmXQ65wYU+SvlqI1mtxwMA==
X-Received: by 2002:a05:6000:1f0d:b0:371:8eb3:603a with SMTP id ffacd0b85a97d-37eab7280bcmr1599445f8f.27.1729260060913;
        Fri, 18 Oct 2024 07:01:00 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf11560csm2007047f8f.93.2024.10.18.07.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:00:59 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Stafford Horne <shorne@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Dawei Li <set_pte_at@outlook.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-openrisc@vger.kernel.org
Subject: [PATCH v2] openrisc: Implement fixmap to fix earlycon
Date: Fri, 18 Oct 2024 15:00:49 +0100
Message-ID: <20241018140052.665806-1-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 53c98e35dcbc ("openrisc: mm: remove unneeded early ioremap
code") it was commented that early ioremap was not used in OpenRISC.  I
acked this but was wrong, earlycon was using it.  Earlycon setup now
fails with the below trace:

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

To fix this we could either implement early_ioremap again or implement
fixmap.  In this patch we choose the later option of implementing basic
fixmap support.

While fixing this we also remove the old FIX_IOREMAP slots that were
used by early ioremap code.  That code was also removed by commit
53c98e35dcbc ("openrisc: mm: remove unneeded early ioremap code") but
these definitions were not cleaned up.

Fixes: 53c98e35dcbc ("openrisc: mm: remove unneeded early ioremap code")
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Changes since v1:
 - Fix earlycon mis spelling in subject
 - Add support for clearing pte entries on fixmap removal
 - Add a tlb flush after updating the page table
 - Use pgprot_t directly in map_page rather than converting

 arch/openrisc/Kconfig              |  3 +++
 arch/openrisc/include/asm/fixmap.h | 21 ++++-------------
 arch/openrisc/mm/init.c            | 37 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 16 deletions(-)

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
index 1dcd78c8f0e9..d0cb1a0126f9 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -207,6 +207,43 @@ void __init mem_init(void)
 	return;
 }
 
+static int __init map_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
+{
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	p4d = p4d_offset(pgd_offset_k(va), va);
+	pud = pud_offset(p4d, va);
+	pmd = pmd_offset(pud, va);
+	pte = pte_alloc_kernel(pmd, va);
+
+	if (pte == NULL)
+		return -ENOMEM;
+
+	if (pgprot_val(prot))
+		set_pte_at(&init_mm, va, pte, pfn_pte(pa >> PAGE_SHIFT, prot));
+	else
+		pte_clear(&init_mm, va, pte);
+
+	local_flush_tlb_page(NULL, va);
+	return 0;
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
+	map_page(address, phys, prot);
+}
+
 static const pgprot_t protection_map[16] = {
 	[VM_NONE]					= PAGE_NONE,
 	[VM_READ]					= PAGE_READONLY_X,
-- 
2.47.0

