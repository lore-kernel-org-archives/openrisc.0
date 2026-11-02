Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618516;
	b=D9LzG3kZkJQLug3QKscuGpkvgOKeBC0j/KD64Rnr3TXwWHtClINbUzQ2dO4sK1DWKGek
	 3f0cKp9TKRbc5/+dZhntQadgPmzKFXZCcF16bRo5bCUypjVAB7lRSwQYGeOi13/2eP6wO
	 F+/Ld1O4RrvsA4JK36cTSDFDOBuQhKpncmIzXIUALxrGuP8YvXgCCIdwopNz6xfyfybt8
	 G56HJs8+2B6hbMpsXHocKqJMGD6sOtZJlEBGKIBdP0QRz/C8o9Ap7aI/kBWdW58sfugvj
	 C23dvLywxJRhD8k41q9aUbJgyoJ0DDU0Z7PUy7tDcrixIxyWvx6ewKOmpTC+0sE3aHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618516;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=JJr4pyTBUPDwtFxqouKNlkLHudO0sOE1ps0QHQE9jbo=;
	b=1YDntbF0xHYsvikhF/gptaKVRoOHZl/oFXnyixG1C9/NOFNCC3tiTWDKrTVDxW/atej5
	 3MpQxun2MMKuzcO3XDSJ+cP5ZdU0x5Oc3s8fpz+Nm/w5CqZ747Wkl6EkS6gasnBaG2Tun
	 1y8iaKSnOZYIuL0cPMogOdznvTicWUpCjKV7LDfB0lmwimDPCMtRlkO+7LL6ABH8ehzrT
	 KzYOpqB/V+QoAq5K9h8AW0BBdGAE67YWI3tylYmDTNx0e0atGYpDIaMC3dHoe4k6KHL71
	 vKegqgPLhjExR/Yc2+mOHU/72GFsdbq06rWdXuukjkOVvcCWzfc1reuzcsoCZFIWCEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="Tf5YISm/";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CAF606A333
	for <linux-openrisc@vger.kernel.org>; Mon,  2 Nov 2026 11:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78CAF606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Tf5YISm/
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E230B2A6B;
	Mon,  2 Nov 2026 03:21:51 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 000EB3F632;
	Mon,  2 Nov 2026 03:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793618515; bh=pfH49/wekZWH0tUlmAGPYfXLPMYhwWIki53rOu3JrVc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tf5YISm/NbZvwkPEnUHnWMU4HZk+CDcrkirL9z+8KS5qYFwMCSdPLDcxtwNkqYbla
	 mFdwJmtXdDZOweXSP/PDkgFSpVfkODm5NlcHFi+CoNzkIVmyQp1290rt9pBK2JiC9o
	 kYPxrWkSuMDqiTHtpyDsilHlX/0l2sFdrwt6OtRE=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 02 Nov 2026 11:21:16 +0000
Subject: [PATCH RESEND v2 03/21] ARM: mm: remove custom pgdp_get()
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Post: <mailto:linux-openrisc@vger.kernel.org>
List-Help: <mailto:linux-openrisc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-openrisc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-dummy_ptxp3-v2-3-78840b2ec73c@arm.com>
References: <20261102-dummy_ptxp3-v2-0-78840b2ec73c@arm.com>
In-Reply-To: <20261102-dummy_ptxp3-v2-0-78840b2ec73c@arm.com>
To: Russell King <linux@armlinux.org.uk>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
 Bibo Mao <maobibo@loongson.cn>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-openrisc@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=794; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=yi3BzhiHjasTHpKXh1MmDEBzfM1jM8lRPSh1W8s2lTo=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBq6HIwc/GAt+z5/OOvI3XR8a7QDzLX+Kmmbr+jA
 ZF852tvsq2JAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCauhyMAAKCRBt1cPRWsUx
 Myg5C/wNk/i75t104WkQdgspkcwkRtCjKwHmV8D+fUK6nYb7ji1MHoEsVIe1sHMK0ADIk7OhxRS
 S3rpo2/d6+5qv/LmYF55JqittempBiiZZ+UFylH0lRHBfdXkOQNDbYCPopeHy3uEZbCUONl2ATe
 9mMlptrkZULQOx0oikCg1Pz3pLbent5TKJ9XwhSE7M7utu5izrQrquojB54trKaQfNCZQ8qS3GG
 tv3+PZd7ghv+bTvhDvi9AvjoCnZREX6rWFwVv/mxSR3zoOuloBrW+44ASZJpqJAWzwvREAM4N//
 UAbJCBV2ykb6MBSmZEEKQKIEDhhQRAY489gVgAMjOa/Un448WLURsjNETK4mMK064AuH8uQ5gyT
 krvRSxNzJeqsDewqn8e638zfsd7jtGSAsu6S5FT1p3KZGa6B6217eOXhOvTHJkAkrjOCNk/J/RB
 AXmrtPiCPS1sZsFy11YkhRK35X9QswfJPdmpKES7oBqQdrPfh4pA3GXP9KNqQLUay7cv8=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

Now that pgd_t is no longer an array and rely on the common
code pgdp_get(), which is a static inline function that returns pgd_t.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/arm/include/asm/pgtable.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 8dd17d20faa33..ff3868acea945 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -134,8 +134,6 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
-#define pgdp_get(pgpd)		READ_ONCE(*pgdp)
-
 #define pud_page(pud)		pmd_page(__pmd(pud_val(pud)))
 #define pud_write(pud)		pmd_write(__pmd(pud_val(pud)))
 

-- 
2.43.0

