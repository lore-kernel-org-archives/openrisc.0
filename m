Received: from mta0.migadu.com (out-233.mta0.migadu.com [91.218.175.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FAE47988A
	for <linux-openrisc@vger.kernel.org>; Wed, 23 Sep 2026 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154795; cv=none; b=S8rQXWajLTsugr0pisZABoq2ak5czL34NggiV1jDNisArvkIGWbl6b0PowijZ1TQ1ULRZ4kB593qMEiITKEfcjqiFFgio1CNPW50h10Y38oP8NbKz/jbnpv22ncq9hk/WnblZJYxWC5zGim2rWXaAHqu25KDxwkaQfBCYKyDkrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154795; c=relaxed/simple;
	bh=MqDx2uNPV3E/fiWMTSd/dV4UjPLeNNzFK2C1QLD5Gus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kj5DYY/TV/eCq0Oc7JSR/SMsbKnCeENvCV5fqgcx0uQws90m85rFhSvVq6p0wJyw6N6zSK1ii3xpHAHwEe40vIM9sywpB6gMFTmrrCQGxBVNtnUyGcbUHcpSpb+kGou2b96i7ckPKlaCNApkk774XSk+Ni3BrbNDy28bolAj1L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vK9iWDIE; arc=none smtp.client-ip=91.218.175.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vK9iWDIE"
X-Envelope-To: linux-openrisc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MqDx2uNPV3E/fiWMTSd/dV4UjPLeNNzFK2C1QLD5Gus=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790154791; v=1; x=1790759591;
 b=vK9iWDIE6zxT8ANVTfOPouwHbv/FHl31USix9G7MGKAU4zu5XU9PV4606WIoI59gzmpHDA5y
 2OtB4CbXZdYVF7/px5MRhbesgu7CZs5FnTa2lOM4dY9F/P/C0YGr2ipWH0VF/AzANipksWW730o
 JT+fCndiBwnuyOimQjF8XnIw=
X-Envelope-To: linux-openrisc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ad223138143f3bbe;
	Wed, 23 Sep 2026 09:13:09 +0000
X-Mizu-Trace-ID: ad223138143f3bbe
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	guoren@kernel.org,
	bcain@kernel.org,
	geert@linux-m68k.org,
	dinguyen@kernel.org,
	schuster.simon@siemens-energy.com,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux@armlinux.org.uk,
	vgupta@kernel.org,
	monstr@monstr.eu,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	davem@davemloft.net,
	andreas@gaisler.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	ysato@users.sourceforge.jp,
	shakeel.butt@linux.dev,
	corbet@lwn.net,
	rdunlap@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org,
	linux-arch@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	hughd@google.com,
	qi.zheng@linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 07/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for m68k-coldfire
Date: Wed, 23 Sep 2026 17:13:03 +0800
Message-ID: <20260923091303.19671-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-7-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-7-fe1ad1f1e303@kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Sep 22, 2026 at 04:35:38PM +0100, Lorenzo Stoakes (ARM) wrote:
>Similar to sun3, the coldfire variant of m68k uses 2-level page tables.
>
>Update its __pte_free_tlb() function to use tlb_remove_ptdesc() in order
>that, with CONFIG_MMU_GATHER_RCU_TABLE_FREE, page tables are freed under
>RCU.
>
>The page tables occupy a page each and have no odd semantics, so this
>change suffices to allow enabling of CONFIG_MMU_GATHER_RCU_TABLE_FREE for
>m68k-coldfire, so do so.
>
>This forms part of an overall effort to switch every architecture to this
>mode.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Yep, ColdFire PTE freeing now goes through tlb_remove_ptdesc() :)

Feel free to add:

Acked-by: Lance Yang <lance.yang@linux.dev>
