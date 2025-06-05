Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412782C3272
	for <linux-openrisc@vger.kernel.org>; Thu,  5 Jun 2025 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749116599; cv=none; b=A1IvuZ9C8h042q2r9LFYdN7+q0x8D+xq+4FabqS0Xh8e/1sdIAsKQemXa0/X4MyT4vmwIf929YXJ4SaszDgiyxSkgq2B78QNvrmxfSwk2cNl88tqfuUmFicXyxQBKcZZAplnEnF0R1WmBLlq9e3Dy2UzgWHUU1EpKqgcAgydC00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749116599; c=relaxed/simple;
	bh=3CzAUpmVmfrQ1t4F5v8cEc+jwk13Dy2UTL8cmMebjbQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RYVI86ikiO1gdRegK2WRQYPua6Ja4E5V0g95d886m/08sLQdEcKG2xvICd6eGZ4eAmXtJoN/d3EsiXQspkVXmjKfUEk4L4mradcXH5VpOZhQZZiDjo0eOwe+mdDXB5FZGAh6oauwhU6mWDqq72f+QK9AJc8GMX3mLCxmc7kV7EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZvAUiyFA; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZvAUiyFA"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749116589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lThtLOtQl+h3cysY0wqvjMRcuzy/6SuzhFkQRTpDlE=;
	b=ZvAUiyFAu9nMRJs58c2zOJSV4g2RXqfQC2U3dVx0ORx5bnsaYBTji+MCOs0iMxnNQw6y24
	mZXnixMu3Sbn/L3MmiSDVPvtVDTALEwKNR6w7KlumpV0qTDytZiZZd8lMKSpUesuNbO4G0
	CJQskSEZ0XkPU78YwhMqb3U4lHrL1sI=
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2] mm/pagewalk: split walk_page_range_novma() into
 kernel/user parts
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <5a06f383-7d01-4ea7-a010-013063770240@lucifer.local>
Date: Thu, 5 Jun 2025 17:42:16 +0800
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Oscar Salvador <osalvador@suse.de>,
 Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>,
 Jann Horn <jannh@google.com>,
 loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 linux-openrisc@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1AA4A4B3-AEBE-484A-8EE2-35A15035E748@linux.dev>
References: <20250604141958.111300-1-lorenzo.stoakes@oracle.com>
 <536f5ffd-b4cf-4f35-970c-ad3a7593af2f@suse.cz>
 <5a06f383-7d01-4ea7-a010-013063770240@lucifer.local>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT



> On Jun 5, 2025, at 17:24, Lorenzo Stoakes <lorenzo.stoakes@oracle.com> =
wrote:
>=20
> On Thu, Jun 05, 2025 at 08:56:59AM +0200, Vlastimil Babka wrote:
>> On 6/4/25 16:19, Lorenzo Stoakes wrote:
>>> The walk_page_range_novma() function is rather confusing - it =
supports two
>>> modes, one used often, the other used only for debugging.
>>>=20
>>> The first mode is the common case of traversal of kernel page =
tables, which
>>> is what nearly all callers use this for.
>>>=20
>>> Secondly it provides an unusual debugging interface that allows for =
the
>>> traversal of page tables in a userland range of memory even for that =
memory
>>> which is not described by a VMA.
>>>=20
>>> It is far from certain that such page tables should even exist, but =
perhaps
>>> this is precisely why it is useful as a debugging mechanism.
>>>=20
>>> As a result, this is utilised by ptdump only. Historically, things =
were
>>> reversed - ptdump was the only user, and other parts of the kernel =
evolved
>>> to use the kernel page table walking here.
>>>=20
>>> Since we have some complicated and confusing locking rules for the =
novma
>>> case, it makes sense to separate the two usages into their own =
functions.
>>>=20
>>> Doing this also provide self-documentation as to the intent of the =
caller -
>>> are they doing something rather unusual or are they simply doing a =
standard
>>> kernel page table walk?
>>>=20
>>> We therefore establish two separate functions - =
walk_page_range_debug() for
>>> this single usage, and walk_kernel_page_table_range() for general =
kernel
>>> page table walking.
>>>=20
>>> We additionally make walk_page_range_debug() internal to mm.
>>>=20
>>> Note that ptdump uses the precise same function for kernel walking =
as a
>>=20
>> IMHO it's not clear at this point what "the precise same function" =
means.
>>=20
>>> convenience, so we permit this but make it very explicit by having
>>> walk_page_range_novma() invoke walk_kernel_page_table_range() in =
this case.
>>=20
>>  ^ walk_page_range_debug()
>=20
> Oops will fix.
>=20
>>=20
>> Maybe this could be reworded in the sense (AFAIU) that
>> walk_page_range_debug() can be used for both user space page table =
walking
>> or kernel depending on what mm is passed, so in the case of init_mm =
it
>> invokes walk_kernel_page_table_range() internally.
>=20
> Sure.
>=20
>>=20
>>>=20
>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>> ---
>>> v2:
>>> * Renamed walk_page_range_novma() to walk_page_range_debug() as per =
David.
>>> * Moved walk_page_range_debug() definition to mm/internal.h as per =
Mike.
>>> * Renamed walk_page_range_kernel() to walk_kernel_page_table_range() =
as
>>>  per David.
>>>=20
>>> v1 resend:
>>> * Actually cc'd lists...
>>> * Fixed mistake in walk_page_range_novma() not handling kernel =
mappings and
>>>  update commit message to referene.
>>> * Added Mike's off-list Acked-by.
>>> * Fixed up comments as per Mike.
>>> * Add some historic flavour to the commit message as per Mike.
>>> =
https://lore.kernel.org/all/20250603192213.182931-1-lorenzo.stoakes@oracle=
.com/
>>>=20
>>> v1:
>>> (accidentally sent off-list due to error in scripting)
>>>=20
>>> arch/loongarch/mm/pageattr.c |  2 +-
>>> arch/openrisc/kernel/dma.c   |  4 +-
>>> arch/riscv/mm/pageattr.c     |  8 +--
>>> include/linux/pagewalk.h     |  7 ++-
>>> mm/hugetlb_vmemmap.c         |  2 +-
>>> mm/internal.h                |  4 ++
>>> mm/pagewalk.c                | 98 =
++++++++++++++++++++++++------------
>>> mm/ptdump.c                  |  3 +-
>>> 8 files changed, 82 insertions(+), 46 deletions(-)
>>>=20
>>> diff --git a/arch/loongarch/mm/pageattr.c =
b/arch/loongarch/mm/pageattr.c
>>> index 99165903908a..f5e910b68229 100644
>>> --- a/arch/loongarch/mm/pageattr.c
>>> +++ b/arch/loongarch/mm/pageattr.c
>>> @@ -118,7 +118,7 @@ static int __set_memory(unsigned long addr, int =
numpages, pgprot_t set_mask, pgp
>>> return 0;
>>>=20
>>> mmap_write_lock(&init_mm);
>>> - ret =3D walk_page_range_novma(&init_mm, start, end, &pageattr_ops, =
NULL, &masks);
>>> + ret =3D walk_kernel_page_table_range(start, end, &pageattr_ops, =
NULL, &masks);
>>> mmap_write_unlock(&init_mm);
>>=20
>> You've removed init_mm from walk_page_range_novma() but I see most =
callers
>> do the locking of init_mm immediately around it. This suggests a =
version
>> handling that automatically? A bit complicated by the read/write
>> possibilities, so maybe not worth wrapping? Just a thought, as David =
says ;)
>=20
> Most callers write lock interestingly, but then one read lock's, so we =
can't
> just assume and would need to pass a boolean which would kind of suck.

Hi Lorenzo,

Actually, the write lock introduced in commit 8782fb61cc848 to fix the
race condition when walking user page tables can be replaced with a read
lock. As explained in commit b123d09304d86, it is safe to walk kernel
page tables while holding the mmap read lock. The function name
`walk_kernel_page_table_range` clearly indicates its purpose: walking
kernel page tables. Thus, using a read lock internally is appropriate
and safe. Please correct me, if I am wrong.

To further enhance robustness, it is better to add a WARN_ON check to
ensure that the address range passed to walk_kernel_page_table_range
is indeed within the kernel address space. This will help prevent any
accidental misuse and catch issues early.

Muchun,
Thanks.

>=20
> Also other walkers assume the caller has the lock so it's consistent =
to
> keep it this way.
>=20
>>=20
>>>=20
>>> flush_tlb_kernel_range(start, end);
>>> diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
>>> index 3a7b5baaa450..af932a4ad306 100644
>>> --- a/arch/openrisc/kernel/dma.c
>>> +++ b/arch/openrisc/kernel/dma.c
>>> @@ -72,7 +72,7 @@ void *arch_dma_set_uncached(void *cpu_addr, size_t =
size)
>>>  * them and setting the cache-inhibit bit.
>>>  */
>>> mmap_write_lock(&init_mm);
>>> - error =3D walk_page_range_novma(&init_mm, va, va + size,
>>> + error =3D walk_kernel_page_table_range(va, va + size,
>>> &set_nocache_walk_ops, NULL, NULL);
>>> mmap_write_unlock(&init_mm);
>>>=20
>>> @@ -87,7 +87,7 @@ void arch_dma_clear_uncached(void *cpu_addr, =
size_t size)
>>>=20
>>> mmap_write_lock(&init_mm);
>>> /* walk_page_range shouldn't be able to fail here */
>>> - WARN_ON(walk_page_range_novma(&init_mm, va, va + size,
>>> + WARN_ON(walk_kernel_page_table_range(va, va + size,
>>> &clear_nocache_walk_ops, NULL, NULL));
>>> mmap_write_unlock(&init_mm);
>>> }
>>> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
>>> index d815448758a1..3f76db3d2769 100644
>>> --- a/arch/riscv/mm/pageattr.c
>>> +++ b/arch/riscv/mm/pageattr.c
>>> @@ -299,7 +299,7 @@ static int __set_memory(unsigned long addr, int =
numpages, pgprot_t set_mask,
>>> if (ret)
>>> goto unlock;
>>>=20
>>> - ret =3D walk_page_range_novma(&init_mm, lm_start, lm_end,
>>> + ret =3D walk_kernel_page_table_range(lm_start, lm_end,
>>>     &pageattr_ops, NULL, &masks);
>>=20
>> Note this and other places break the second line's arguments =
alignment on
>> the opening bracket. Maybe it just shows it's a bit fragile style...
>>=20
>>=20
>=20
> Yeah I know :) I know you won't believe this coming from me, but I was
> trying to minimise the churn :P


