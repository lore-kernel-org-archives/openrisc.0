Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D07E1;
	Wed,  4 Jun 2025 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749024439; cv=none; b=i24vYb0dGPxEcJHBW9coRHSD50zKiOpM1+02mPomCGdOATYbVnK1iYyScx3G7PjWl3SIisyB32C++p01elqzAHJ2jFtjH2Mg/mlOICfxmkAP/a2yaLmvl9mvLiVW8JgW4pdGKI9liZlt+nLNRu4mLuf+T/HCMcblXu9p+gHVKgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749024439; c=relaxed/simple;
	bh=yhf7uIemDFvOFZs2ab9B2tbrEfAJeioCFyGpvougiYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahKfMNXmK2xVEVfdyWf4AU3cQ6hIAVlLDhgSxUR3T/6+chfg2taFgSj39WJsGTdE+RVIO60GKbzGhheeJ3DFvAl+8BBZBKnPOiMd9PZ5q3SEvAFBq745RHJ0GwTwxJvVCWrV9kuz39sg1HCW7MNfCfjGzi97Uyd7YpY0iGBGoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkoN+a3z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkoN+a3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A0AC4CEE7;
	Wed,  4 Jun 2025 08:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749024437;
	bh=yhf7uIemDFvOFZs2ab9B2tbrEfAJeioCFyGpvougiYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UkoN+a3zAHKzxBIHiRC/IlPuT0QSuatYT+VGDnR+NiAJTDjSYu7ZxSKc6OtO3Sjnm
	 p9OKsigQudSpIeAXqCHw/58NONlyuoRuEXMP3isFFcNjqKiLC1mfn0HvwTt6lVdy2J
	 W5V6zRyyi7KgHPk9CsPgnCjTZSvT9Y6yl9RO+baEI1r3bqZC8IO3brMlu8pGr5dQlB
	 JJuNJ+yyDgAz/Ro7+eGjf3MrBrzlv9RVLswj2/I0pUN8Ae1nA0CzPMWIV49FLAj2dX
	 ovNfHEuBbIS2qc7uGqlkuB7GuYGHvg9vuitN6/j5zZhFB8kPoIC4zmvLHgUU15nvUt
	 qEKucBZNRJ20g==
Date: Wed, 4 Jun 2025 11:07:05 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <baohua@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Jann Horn <jannh@google.com>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH RESEND] mm/pagewalk: split walk_page_range_novma() into
 kernel/user parts
Message-ID: <aD_-qdg2OvKQIyRg@kernel.org>
References: <20250603192213.182931-1-lorenzo.stoakes@oracle.com>
 <51ec4269-b132-4163-9cb5-766042a3769d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51ec4269-b132-4163-9cb5-766042a3769d@redhat.com>

On Wed, Jun 04, 2025 at 09:39:30AM +0200, David Hildenbrand wrote:
> On 03.06.25 21:22, Lorenzo Stoakes wrote:
> > The walk_page_range_novma() function is rather confusing - it supports two
> > modes, one used often, the other used only for debugging.
> > 
> > The first mode is the common case of traversal of kernel page tables, which
> > is what nearly all callers use this for.
> 
> ... and what people should be using it for 🙂
> 
> > 
> > Secondly it provides an unusual debugging interface that allows for the
> > traversal of page tables in a userland range of memory even for that memory
> > which is not described by a VMA.
> > 
> > This is highly unusual and it is far from certain that such page tables
> > should even exist, but perhaps this is precisely why it is useful as a
> > debugging mechanism.
> > 
> > As a result, this is utilised by ptdump only. Historically, things were
> > reversed - ptdump was the only user, and other parts of the kernel evolved
> > to use the kernel page table walking here.
> > 
> > Since we have some complicated and confusing locking rules for the novma
> > case, it makes sense to separate the two usages into their own functions.
> > 
> > Doing this also provide self-documentation as to the intent of the caller -
> > are they doing something rather unusual or are they simply doing a standard
> > kernel page table walk?
> > 
> > We therefore maintain walk_page_range_novma() for this single usage, and
> > document the function as such.
> 
> If we have to keep this dangerous interface, it should probably be
> 
> walk_page_range_debug() or walk_page_range_dump()

We can also move it from include/linux/pagewalk.h to mm/internal.h
 
> > 
> > Note that ptdump uses the precise same function for kernel walking as a
> > convenience, so we permit this but make it very explicit by having
> > walk_page_range_novma() invoke walk_page_range_kernel() in this case.
> > 
> > We introduce walk_page_range_kernel() for the far more common case of
> > kernel page table traversal.
> 
> I wonder if we should give it a completely different name scheme to
> highlight that this is something completely different.
> 
> walk_kernel_page_table_range()
> 
> etc.
> 
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
