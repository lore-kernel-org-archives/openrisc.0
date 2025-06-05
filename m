Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCC01F03D9
	for <linux-openrisc@vger.kernel.org>; Thu,  5 Jun 2025 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106623; cv=none; b=ouMWJw0qJof/o62ozHrCcxf6HUb8lXbPH++FTFbVVBZhXkO0PbeGKUvvyQ27rqeWf78PvZskyspi2fj4rOSftn2fswN0wUKb8wF+LPaHOa9cw/k+lxfnOBY8tL5nWE+rnbsC6uTA3jsPrQc4nI0FMtK03LnGMWqkZ/lFw94Jf9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106623; c=relaxed/simple;
	bh=q79+Um1+HXmTCuXp48qIXfskJas9hJ2zahTLYz1FM4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqqrWY+WevtrON0KbENYkpv3QR4UUlEVqAg18i5AX405ukDMrKT3gfMcV4X/6lM3ymzRBi81dJoyHc6loMuXAcV93kSo0G3eDMCBzB871hCXAjwomESD689D+IHIwzZIRSDZj86J7eCaER7XiUV9pzf1RSiuiYwrY+f7IP57WS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A2jx7igy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oP1XkW7f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A2jx7igy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oP1XkW7f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A2jx7igy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oP1XkW7f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A2jx7igy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oP1XkW7f"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0BBA344E8;
	Thu,  5 Jun 2025 06:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749106619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wPI4ofmTk/E4f6+NaUnYTS8dt4fvqBsAjz20vg9T5ho=;
	b=A2jx7igySZ/yVPwubUtmc7FJFO1ugw0ElRhqfchp0SdKNCeUtSR13WYTlt36wn3Z0yy8c/
	uEq4rvyK5bL5tG2N8p0l4fcHmncC2QgtJsmP6mIpD3kTJKD3W6EG0yPNBLPGsIgkC+zRfy
	gtu6v9p8OpykT91eIoJ5ZE5/yTpz17U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749106619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wPI4ofmTk/E4f6+NaUnYTS8dt4fvqBsAjz20vg9T5ho=;
	b=oP1XkW7fUFiGZ+uMI0VOtQkeBavyIGTALJn0hqDpVUGgKl5G800tbwPqlrnhNvpsAz4wbg
	A76527JC5m4PWdDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749106619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wPI4ofmTk/E4f6+NaUnYTS8dt4fvqBsAjz20vg9T5ho=;
	b=A2jx7igySZ/yVPwubUtmc7FJFO1ugw0ElRhqfchp0SdKNCeUtSR13WYTlt36wn3Z0yy8c/
	uEq4rvyK5bL5tG2N8p0l4fcHmncC2QgtJsmP6mIpD3kTJKD3W6EG0yPNBLPGsIgkC+zRfy
	gtu6v9p8OpykT91eIoJ5ZE5/yTpz17U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749106619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wPI4ofmTk/E4f6+NaUnYTS8dt4fvqBsAjz20vg9T5ho=;
	b=oP1XkW7fUFiGZ+uMI0VOtQkeBavyIGTALJn0hqDpVUGgKl5G800tbwPqlrnhNvpsAz4wbg
	A76527JC5m4PWdDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9008B137FE;
	Thu,  5 Jun 2025 06:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0wrcIrs/QWiwIgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 05 Jun 2025 06:56:59 +0000
Message-ID: <536f5ffd-b4cf-4f35-970c-ad3a7593af2f@suse.cz>
Date: Thu, 5 Jun 2025 08:56:59 +0200
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/pagewalk: split walk_page_range_novma() into
 kernel/user parts
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Barry Song <baohua@kernel.org>, David Hildenbrand <david@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Jann Horn <jannh@google.com>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mm@kvack.org
References: <20250604141958.111300-1-lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250604141958.111300-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,oracle.com,google.com,suse.com,linux.dev,suse.de,xen0n.name,southpole.se,saunalahti.fi,gmail.com,sifive.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.linux.dev,vger.kernel.org,lists.infradead.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 6/4/25 16:19, Lorenzo Stoakes wrote:
> The walk_page_range_novma() function is rather confusing - it supports two
> modes, one used often, the other used only for debugging.
> 
> The first mode is the common case of traversal of kernel page tables, which
> is what nearly all callers use this for.
> 
> Secondly it provides an unusual debugging interface that allows for the
> traversal of page tables in a userland range of memory even for that memory
> which is not described by a VMA.
> 
> It is far from certain that such page tables should even exist, but perhaps
> this is precisely why it is useful as a debugging mechanism.
> 
> As a result, this is utilised by ptdump only. Historically, things were
> reversed - ptdump was the only user, and other parts of the kernel evolved
> to use the kernel page table walking here.
> 
> Since we have some complicated and confusing locking rules for the novma
> case, it makes sense to separate the two usages into their own functions.
> 
> Doing this also provide self-documentation as to the intent of the caller -
> are they doing something rather unusual or are they simply doing a standard
> kernel page table walk?
> 
> We therefore establish two separate functions - walk_page_range_debug() for
> this single usage, and walk_kernel_page_table_range() for general kernel
> page table walking.
> 
> We additionally make walk_page_range_debug() internal to mm.
> 
> Note that ptdump uses the precise same function for kernel walking as a

IMHO it's not clear at this point what "the precise same function" means.

> convenience, so we permit this but make it very explicit by having
> walk_page_range_novma() invoke walk_kernel_page_table_range() in this case.

  ^ walk_page_range_debug()

Maybe this could be reworded in the sense (AFAIU) that
walk_page_range_debug() can be used for both user space page table walking
or kernel depending on what mm is passed, so in the case of init_mm it
invokes walk_kernel_page_table_range() internally.

> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
> v2:
> * Renamed walk_page_range_novma() to walk_page_range_debug() as per David.
> * Moved walk_page_range_debug() definition to mm/internal.h as per Mike.
> * Renamed walk_page_range_kernel() to walk_kernel_page_table_range() as
>   per David.
> 
> v1 resend:
> * Actually cc'd lists...
> * Fixed mistake in walk_page_range_novma() not handling kernel mappings and
>   update commit message to referene.
> * Added Mike's off-list Acked-by.
> * Fixed up comments as per Mike.
> * Add some historic flavour to the commit message as per Mike.
> https://lore.kernel.org/all/20250603192213.182931-1-lorenzo.stoakes@oracle.com/
> 
> v1:
> (accidentally sent off-list due to error in scripting)
> 
>  arch/loongarch/mm/pageattr.c |  2 +-
>  arch/openrisc/kernel/dma.c   |  4 +-
>  arch/riscv/mm/pageattr.c     |  8 +--
>  include/linux/pagewalk.h     |  7 ++-
>  mm/hugetlb_vmemmap.c         |  2 +-
>  mm/internal.h                |  4 ++
>  mm/pagewalk.c                | 98 ++++++++++++++++++++++++------------
>  mm/ptdump.c                  |  3 +-
>  8 files changed, 82 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
> index 99165903908a..f5e910b68229 100644
> --- a/arch/loongarch/mm/pageattr.c
> +++ b/arch/loongarch/mm/pageattr.c
> @@ -118,7 +118,7 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask, pgp
>  		return 0;
> 
>  	mmap_write_lock(&init_mm);
> -	ret = walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL, &masks);
> +	ret = walk_kernel_page_table_range(start, end, &pageattr_ops, NULL, &masks);
>  	mmap_write_unlock(&init_mm);

You've removed init_mm from walk_page_range_novma() but I see most callers
do the locking of init_mm immediately around it. This suggests a version
handling that automatically? A bit complicated by the read/write
possibilities, so maybe not worth wrapping? Just a thought, as David says ;)

> 
>  	flush_tlb_kernel_range(start, end);
> diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
> index 3a7b5baaa450..af932a4ad306 100644
> --- a/arch/openrisc/kernel/dma.c
> +++ b/arch/openrisc/kernel/dma.c
> @@ -72,7 +72,7 @@ void *arch_dma_set_uncached(void *cpu_addr, size_t size)
>  	 * them and setting the cache-inhibit bit.
>  	 */
>  	mmap_write_lock(&init_mm);
> -	error = walk_page_range_novma(&init_mm, va, va + size,
> +	error = walk_kernel_page_table_range(va, va + size,
>  			&set_nocache_walk_ops, NULL, NULL);
>  	mmap_write_unlock(&init_mm);
> 
> @@ -87,7 +87,7 @@ void arch_dma_clear_uncached(void *cpu_addr, size_t size)
> 
>  	mmap_write_lock(&init_mm);
>  	/* walk_page_range shouldn't be able to fail here */
> -	WARN_ON(walk_page_range_novma(&init_mm, va, va + size,
> +	WARN_ON(walk_kernel_page_table_range(va, va + size,
>  			&clear_nocache_walk_ops, NULL, NULL));
>  	mmap_write_unlock(&init_mm);
>  }
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index d815448758a1..3f76db3d2769 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -299,7 +299,7 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
>  			if (ret)
>  				goto unlock;
> 
> -			ret = walk_page_range_novma(&init_mm, lm_start, lm_end,
> +			ret = walk_kernel_page_table_range(lm_start, lm_end,
>  						    &pageattr_ops, NULL, &masks);

Note this and other places break the second line's arguments alignment on
the opening bracket. Maybe it just shows it's a bit fragile style...


