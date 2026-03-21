Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04752E63C
	for <linux-openrisc@vger.kernel.org>; Sat, 21 Mar 2026 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774085761; cv=none; b=mupfWk6u5TJIp0B288cMUCpvRcrTkvesgEZPSZwX7gSqVGN0BzIQNBdx4ikhstaNKhWEtfkwBd6wUdnX2Qx/o8QBc9+lvsUM9VDuhTul2tTE1hKlR80KIObT9Y7WpYszuLuhkpl1HZSz+wnZN6J+LbCwUJUbsDXdOF2mz5khHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774085761; c=relaxed/simple;
	bh=gygbfXP5WEaXEUAToDoL+Stj3+nM2DNGzKwp/3EKx6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6UDijrb8kG9XTozJChUhSfQQw8+ArK0AWbRG9I4QfbMdozKOSOezRL5Mu+ckliv9qaIRUxoJl4OafxM0DsYydBMYAjPwAxU8E2VhcoRfuNP9QXhmEg/CNTMCSYhF/rIdNflY16Oh1gCUfVZpUG2qk8BPsZoZlSrcjqqicFe6XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQFIW9rr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQFIW9rr"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b4f48c47cso1031402f8f.0
        for <linux-openrisc@vger.kernel.org>; Sat, 21 Mar 2026 02:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774085758; x=1774690558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y6Md6EAaVnAD6yK0uQblpYua3YBFMftWsFKGRKdGbg=;
        b=NQFIW9rrn2QPu4eu08eN60P9QLAKX+1Y6WDgqXnhfeHcBHfDIOVEFYOdbL2gwOennI
         emO7YdcqHyZBMNhKEn+8ipOYbsY01Fx/08ybJVOiqpOfQAhGCAQUun7DHxU85ksjo/94
         vhpVRgfOIVm+Wrsan48WDrfD6OynciqjDXTcWFpio8EVpd+0Tmm4caJgNINBS5pcWCbS
         PsvnGPaBkUpLmtF/eyA81eyAO31Zw8oohZLh3FwqMgJS6/RH+98A8ocYDi2YKsIjpEhH
         BEHDU0vZ8M05Q6N2eYLNgVwI/EqAy2vSLmcz7v9fRFb5xWVMus6ialC2Rkt/tBwhy9Y2
         JrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774085758; x=1774690558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Y6Md6EAaVnAD6yK0uQblpYua3YBFMftWsFKGRKdGbg=;
        b=RcmXF/5E2Oh2JL3TiP+qrgE1BCQZewF8MuL4PM3Ik+Fe2KGnqu1QNEzehH2s0z73w0
         EI/GEdCsO119p6iA+BniYv1NCt1lk2/ioXFh+lJpby3zmpGuCl4PJ6J10B0Z51L0Wrmn
         wavtidDR1IbdCeufu+/89ebP9Um7WlXAye3RnHYku0EpDlvyaQMOH7gKqy9QHHmc4fxt
         Gt9zVL2EV3T384upTn0G9GHqITbr72IQ3EHxOiDulb4HZB7ii/cXvsiYhiR8PCjhAp1E
         5ItXy9HQObaSTFnYoYpMFfsHF53DrGfHiK6V9DYQIUecXO3d89NH+UtIqKZP69xlH+Tw
         lvgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRSNrgZYYZsVLN70l373P8mKtX2YwnoQBqlzmH0I0DHmU1GRmhQ5Fg7axOve2zmlq5q7pW56bkqH8VXeKRdw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1lPlKCo4VK+45YmbY8oOBVhFG4SvEVe0RkEiFitBdW8TN93Eb
	eVx8HOd6p1b1qjkA3uBxdHZk2T9S+QYEPVJNhCkrcqX1qotjS78WYuu0
X-Gm-Gg: ATEYQzwqAt1FDVPRWkspQCgWlmRPi8HwvGzsxjTJaijjE+u3PwDJwBT//Po0uOT7KmW
	4s8SbZdSImlmLZL85uCC5WTZn/jrLrFDTRgQ8FfnCQLsGWVYLkKqlyfCI0vJakvBSWUGsqUqW3u
	H6DEnyM8UEh4Ovk7Ir6cl9eBfk7V/slpGN2bQwxt0BSpVwDrKIPUdg4BnziqdymqWvGvW/GcilZ
	P+em0I6/q9WuK1S3nqw9QD3ek7ZLVVklY6T8SRgMr36CAUiYWYGsj/Z3UQ5OiXCTcT7nrUX/8CB
	qiJm53FZo6390ilTkfkKvB3YI+fp0c+fgbGPux+X5zf7Y3KO30Go8Nf2KuqbzG6ELUk8jCs3lLV
	nFbfMm2Sw3tB83tjsXB1PKe4kkhmVXslCauGFSptn95bsealO6yXRIgggDEJRKcpfSwnDNufeGd
	oJfjOXmoc1X98nrVBCOxFtWw7aQPWt3FMsxqyP65ObljphOe1amNTMRpwsenPzUyf9ECk8crxq/
	OZEqLBaWTMIYRwg
X-Received: by 2002:a05:6000:290d:b0:439:d242:e8fe with SMTP id ffacd0b85a97d-43b64242fddmr9643859f8f.11.1774085757880;
        Sat, 21 Mar 2026 02:35:57 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm14159634f8f.8.2026.03.21.02.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 02:35:57 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Stafford Horne <shorne@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	chenmiao <chenmiao.ku@gmail.com>,
	Sahil Siddiq <sahilcdq0@gmail.com>,
	linux-openrisc@vger.kernel.org
Subject: [PATCH] openrisc: mm: Fix section mismatch between map_page and __set_fixmap
Date: Sat, 21 Mar 2026 09:35:38 +0000
Message-ID: <20260321093540.3402319-1-shorne@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This warning was reported by the kernel test robot:

  WARNING: modpost: vmlinux: section mismatch in reference: __set_fixmap+0x84 (section: .text.unlikely) -> map_page.isra.0 (section: .init.text)

With commit 4735037b5d9b ("openrisc: Add text patching API support") the
__set_fixmap function was moved out of the .init.text section.
However, the map_page helper that it uses was not moved.  This was not
noticed on gcc 15.1.0 where map_page gets inlined unlike lkp@intel.com
which uses gcc 10.5.0.

Fix this by also moving the map_page helper function out of the init
section.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603211503.E8mMETO3-lkp@intel.com/
Fixes: 4735037b5d9b ("openrisc: Add text patching API support")
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index 78fb0734cdbc..50aee0ea18b7 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -196,7 +196,7 @@ void __init mem_init(void)
 	return;
 }
 
-static int __init map_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
+static int map_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
 {
 	p4d_t *p4d;
 	pud_t *pud;
-- 
2.51.0

