Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107B251E423
	for <linux-openrisc@vger.kernel.org>; Mon,  7 Sep 2026 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788800041; cv=pass; b=JmezYcaHR1xAYGPychW4CeQp/OvhiswhQe+Hetf28hdOxS0SWYPh8EUJs1eG0YLoyjVRqma+XIWpWiZHXzhAN+2yP+8Ffe7YyM1mhDcjrF4Ok7Y1/AMhANa7D4BYQxRF9hQGtWWawjdt5xKEN1DOvW2nhb2BVQ02EIZ+rGU0bUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788800041; c=relaxed/simple;
	bh=7nZvXQAXFpGDq6OvBtcrjZaQ3gxcarFF2OJUmuf6SHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExmoBNBnpN+OvOtaEeXY4lv4N9+QZAx949e8qBR2za1Zpz5tZVz5j7UqXtjo0PLEDR/AYpmzWv/f7R0KFJi5nkin+V/rblajlDrdZV1u7PdHjqmukePJHobk7pwzH+QHeSTPqsQsaWlfDhgqEdhq2rthmsBMPZ9I3sGB5kHfosI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZOEcfTft; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZOEcfTft"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5307425f44bso312201cf.1
        for <linux-openrisc@vger.kernel.org>; Mon, 07 Sep 2026 09:53:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788800036; cv=none;
        d=google.com; s=arc-20260327;
        b=cAHWjGrsTzgcLdmJ6YGlCRuckXni3uVrbH+Gh+23+XkY/98hvAQDhDvv5dC6rHO626
         wrTKJViD3EUGLQvjJeDDLhhyzuIHx4fKEPJdeZwoP47QyX1zOc3szfSOxmTJz+uazoFH
         XEhNW189cwIJkJjRPJ3BdnFy5hv3aA+dQufoFfR9PKRqKmVbkj/vpIt2bocfamDYbUBV
         WgdXLuNhhPZlaTk/abkFDHTqnjGDxkA6VL83Zpw1QHC6ibR1S8WdWXk6ahEM0w8NPX6X
         lNlj3cGdGSzTnUtjmIlBW/+PVPEK0qZjced2a3WeFt6a263G2FYRUAzZDKLV7afgbNic
         Plzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WOgo3zFXzbtiQDjz57z5HXaLiQwAncd9HG4Gw1Bp/lg=;
        fh=bzDCf+aT+evlnrLqnx9izgYnE0B6qdSP66Uukd+phJ4=;
        b=CsL8iq90VTS6r6IvpF+DxcQDBaoZIStxYuNIbTDdSa23d11d3crtqsUCB/7lPjgBzb
         YVKhZj2ECkrgXeRGhuaihq7clL/1/J5fq9X8cSLKDl4pUHyi6Y39BEORHz+nPKpFpinR
         FdkFNDmA4SF4moz8Ww1IsNrpz/zvVdGe2BqBeRGTVmjbWIGSkQGWD8+rYvAYInvLzh6D
         +QBfRACiOftybXrQrdzlZ8DxNmLidGJzsKRxZGvs24xsMgu5Zjwlu3WZQIbTFgF0uE6i
         E6P2FB6ledkcwjEJ8fnsW/7qfnfESULTgr5O0vXB+4AGqRTz3qNP013QWWB47jqYJFhF
         svdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788800036; x=1789404836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WOgo3zFXzbtiQDjz57z5HXaLiQwAncd9HG4Gw1Bp/lg=;
        b=ZOEcfTftJhzBn8TSOkOKtoVoBUfs0xbVZP9wHIME5s8DaKMIumqZANXdTWAZZQG4bO
         PsjF2/5Q7dfdSw5e/4doJHeaSAcrrwzHm5okWijPOCxUqMYTFuITP+L3zhdL7LBMLzBT
         Jt+SHOoAutj1CLKQTV1FN0mPF2EGxDqFcsLwjlFwQHiJXiI0RuPd1xWARyOCutR3amvc
         sQxz5M40LQ87mSFr29zXtVACvT1zPuvn5cV0my4RhbsT0V7tcqvEyDMudV1T+uNnLK+a
         Py2kZwd1qLLizUDEbVxEWP3v9J2sunX74cBomy/fdJ0WlRZ+GPuOIbhrioUU/SARwrl5
         i5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788800036; x=1789404836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WOgo3zFXzbtiQDjz57z5HXaLiQwAncd9HG4Gw1Bp/lg=;
        b=dZozMdEaEW5Agkm18a1pOxJ1boyDOpw4nxNHOqfiC8LfvaZy280seRxRdO3TRsxa+U
         HBjyXwNEaG+VvOjnG5SDo9llFvIvd9zZA5SRPiGxb1WwF2aJTb4zlUETbBnba2MpBUkS
         BMy250APTRkEGCBxfTXSN6f9g0lshlhTVCZjS8UCC/ddNNak+k3iOAdMHO/zz+Ljw3/X
         SBwLPDiLHkHQOV6eB2AFowLwFVb2Getvf3bbU6fdsqPmz1WnmrSl9hTsqsr5nMvb58Wi
         PVSJV6rnSVIemqZgb6EW0mDyNCUnopnAKgfql3ro93ewevGGe0SlK/YJWIt/2sExnuNv
         EYFg==
X-Forwarded-Encrypted: i=1; AKwUvBzsSIF/qsTS8sUy1WEnN7mmh665nCDnZmXBxLIjVfEfcWGtDTJLwBXch2FIgJmLLlQDM+MyoZtmhEfXTjbzGQ==@vger.kernel.org
X-Gm-Message-State: AFuF++l+cG7z7zwFBR1qHrSa2BF36qahOxDWjeGW8K+pEhL0Aj40OlpM
	Cd5n4NLQNIHnChV6+L0lbhiU+0VsdpLMC8du+dcbJuHUrlVXJCvr/YbwTjnkhKddvW7tdskXTpE
	Mfin6Whvahohc7NKMQLVaMY8vr7aPN2K2Q4h3HQdU
X-Gm-Gg: AYBFou0/Z4Vq7xsHe+LmPAay/KJRY6DtuJVFBY28XSWY+hdfHGj7gYGTDpj1iTjtN6b
	WV4qZyH9hOwWDKjk/ou88MQxc336FLf/dzFLTGFcRh222kvLfV63iuKb61GvyAbMRB/teQJrHL5
	vXIdWCgHiMet5GGUFULq7Jf5t+psuugmZuJDu/5aKIFqpVx4OJcD4XoNdgIxc/UtZl4mSZ387Kf
	xJLhiZo/D9PgO2dzFOZeR9g3cRN5VRE8rKPFoce85FA4gJbUpbQJMAVF06+Vo1wRqkXDHdhAoc5
	xcPpigkO8NQanoSwrX+3Wm4BBDcdSI3STicb2MMn3bg=
X-Received: by 2002:a05:622a:28e:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-530920caba6mr3560401cf.0.1788800035234; Mon, 07 Sep 2026
 09:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-12-5456a81c8212@kernel.org>
 <apbUpMDJglS99_yK@thinkstation> <apbfzUwBQyxe3P9R@gremlin>
 <apcH74QsR5I-DIbL@thinkstation> <apcJhtvnd45EkjJI@gremlin>
In-Reply-To: <apcJhtvnd45EkjJI@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 7 Sep 2026 09:53:43 -0700
X-Gm-Features: AcwNN1WRGdFWOzxEbOcmfkztqDuQQAGpor7Xm60pdWlD2DjKNo1Y7S4S7DNXdgs
Message-ID: <CAJuCfpH_v4YU+hsQDU_yQ4HZDf-2C6DuiJU5PGL+uVAsTwkZug@mail.gmail.com>
Subject: Re: [PATCH 12/12] mm: change the contract for free_pgtables(), update docs
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Simon Schuster <schuster.simon@siemens-energy.com>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, 
	Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 10:25=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Tue, Sep 01, 2026 at 06:15:17PM +0100, Kiryl Shutsemau wrote:
> > On Tue, Sep 01, 2026 at 03:31:26PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > On Tue, Sep 01, 2026 at 02:57:13PM +0100, Kiryl Shutsemau wrote:
> > > > On Tue, Sep 01, 2026 at 12:01:32PM +0100, Lorenzo Stoakes (ARM) wro=
te:
> > > > > diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> > > > > index b91b1a98029c..ff8ff3706485 100644
> > > > > --- a/mm/pgtable-generic.c
> > > > > +++ b/mm/pgtable-generic.c
> > > > > @@ -386,9 +386,21 @@ pte_t *pte_offset_map_rw_nolock(struct mm_st=
ruct *mm, pmd_t *pmd,
> > > > >   * be read-only/read-write protected.
> > > > >   *
> > > > >   * Note that free_pgtables(), used after unmapping detached vmas=
, or when
> > > > > - * exiting the whole mm, does not take page table lock before fr=
eeing a page
> > > > > - * table, and may not use RCU at all: "outsiders" like khugepage=
d should avoid
> > > > > - * pte_offset_map() and co once the vma is detached from mm or m=
m_users is zero.
> > > > > + * exiting the whole mm, does not take the page table lock befor=
e freeing a
> > > > > + * table.
> > > > > + *
> > > > > + * However, the PMD entry is cleared first, and the table freed =
only after
> > > > > + * an RCU grace period, so a walker that mapped the table under
> > > > > + * rcu_read_lock() stays safe, and the pmd_same() recheck in
> > > > > + * pte_offset_map_lock() detects the teardown.
> > > > > + *
> > > > > + * Therefore it is safe for "outsiders" like khugepaged to use
> > > > > + * pte_offset_map() and co. for VMAs that might be undergoing pa=
ge table
> > > > > + * teardown.
> > > >
> > > > Is it strictly true?
> > > >
> > > > free_pte_range() clears the pmd without taking the PTL, so the
> > > > pmd_same() recheck in pte_offset_map_lock() can pass and the pmd ge=
ts
> > > > cleared right after.
> > > >
> > > > Readers are fine -- __pte_offset_map() holds rcu_read_lock() until
> > > > pte_unmap(), so the table cannot go away.
> > > >
> > > > khugepaged is an odd example here. collapse_pte_mapped_thp() and
> > > > retract_page_tables() don't rely on this recheck -- they take pmd_l=
ock()
> > > > plus the ptl and do their own pmd_same() under both.
> > > >
> > > > Can we say walks are safe and leave the write rule where it is?
> > >
> > > Hmm yeah, ah page tables, what a rabbit hole of horror :)
> > >
> > > I guess this is effectively a reflection of the 'write lock on write,=
 RCU load
> > > on read' pattern in RCU itself generally.
> > >
> > > So, maybe something like:
> > >
> > >  * Note that free_pgtables(), used after unampping detached vmas, or =
when
> > >  * exiting the whoel mm, does not take a page table lock before freei=
ng a page
> > >  * table.
> > >  *
> > >  * As page table freeing itself is RCU-safe, page table readers can s=
afely run
> > >  * concurrently with page table teardown. However, writers cannot, as=
 without
> > >  * a lock nothing prevents concurrent teardown.
> > >  */
> > >
> > > Instead? What do you think?
> >
> > s/whoel/whole/
>
> Haha yup the inevitable typo...

Also s/unampping/unmapping please.
>
> >
> > Otherwise, LGTM.
>
> Thanks! :)
>
> >
> > --
> >   Kiryl Shutsemau / Kirill A. Shutemov
>
> --
> Cheers, Lorenzo
