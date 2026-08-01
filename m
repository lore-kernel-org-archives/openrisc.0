Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF593C09E5;
	Sat,  1 Aug 2026 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785611431; cv=none; b=h6bWd89VbWOmDFxsjAHFpRX74wchBQVuA5xgkNqtpyJbUOZpLAaAyjXMu7z2I4YCuX1sN7HMWGYsfpbxFW/hTR/Dd8vDBM+IzriE73Ec3lUlqjhosvJT52x8/u4bfST20jVDcWDqnsOE6aEgGBfQl7NXpidn+qFeUS/na1mVOVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785611431; c=relaxed/simple;
	bh=fICjAMTExDbQ2nwtlKDyoU40ANk0WTPjnlRs4ixXvNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=quAqXJdWzrINaXEw6kCnDQyXdU+6mX+W17zXKgZtJ0/XCoHTennZ38BFksanCRGPpzI7hN3cT4i5vsvwCjeQxfd8AqBeF5nJE79EVhLhA860bYyi2Aa2NFwCWkTzbZ46BFhtytWSe14FtaYLCY/wdEfLAOMgfgBW/N+idkATqeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=l62gMvHI; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="l62gMvHI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oW5knCla26qKFnpu8F668y4CT4YZRt2jJjFDUhwzFiQ=;
  b=l62gMvHI/iED3JLvEvIV9IN3o6PvxouvGM+M11nsZuDpylGfUJWgARbY
   CyAdqqOPBUCsbjhG1iNWv4IigsmWVMBjezr/qGwzaZIsUa2J9Qf5Ub7MB
   E9nAi+BeDlhSWlQxRBLHs66hntEs6KenkAkJ8xdB0G3ywoMksF4QeStHs
   Y=;
X-CSE-ConnectionGUID: lhoFTlK/SeCTxjWeVENkxw==
X-CSE-MsgGUID: SCWNhkXdQ++WYwG97ktL+g==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.25,198,1779141600"; 
   d="scan'208";a="288769006"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 21:10:08 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Jonas Bonn <jonas@southpole.se>
Cc: kernel-janitors@vger.kernel.org,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] openrisc: drop unneeded semicolon
Date: Sat,  1 Aug 2026 21:09:50 +0200
Message-Id: <20260801191002.1383835-4-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a function-like macro expands to an expression, that expression
doesn't need a semicolon after it.  All uses have been verified to
have their own semicolons.

This was found using the following Coccinelle semantic patch:

@r@
identifier i : script:ocaml() { String.lowercase_ascii i = i };
expression e;
@@

*#define i(...) e;

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/openrisc/mm/tlb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/mm/tlb.c b/arch/openrisc/mm/tlb.c
index 3115f2e4f..2ee00bf30 100644
--- a/arch/openrisc/mm/tlb.c
+++ b/arch/openrisc/mm/tlb.c
@@ -74,11 +74,11 @@ void local_flush_tlb_all(void)
 
 #define flush_dtlb_page_eir(addr) mtspr(SPR_DTLBEIR, addr)
 #define flush_dtlb_page_no_eir(addr) \
-	mtspr_off(SPR_DTLBMR_BASE(0), DTLB_OFFSET(addr), 0);
+	mtspr_off(SPR_DTLBMR_BASE(0), DTLB_OFFSET(addr), 0)
 
 #define flush_itlb_page_eir(addr) mtspr(SPR_ITLBEIR, addr)
 #define flush_itlb_page_no_eir(addr) \
-	mtspr_off(SPR_ITLBMR_BASE(0), ITLB_OFFSET(addr), 0);
+	mtspr_off(SPR_ITLBMR_BASE(0), ITLB_OFFSET(addr), 0)
 
 void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {

