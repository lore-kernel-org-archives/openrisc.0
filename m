Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20194432BC4
	for <linux-openrisc@vger.kernel.org>; Wed, 15 Jul 2026 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111684; cv=none; b=QSyaBosJ0NL/fpXJjQe8qiiV7RYIa687T6z/qo1m00EsxnJ7mj09qdfMqIBaiJlnl0siakoEgLq6ivJl+MpbHuHRXb+j+Ijq+WOtvvavw5nHwQ3EXBsiZ+vVCJSPrA20DZKLJVw4M5CRed9V2/QjmwSHgoLC+M/jmHuInGiji6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111684; c=relaxed/simple;
	bh=dYuyA6Dz/ajxhYT4dU+02MPd/j4lWQd1ctOD3UM1CNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9/5NhjoZQCqnPR+4iSmFlvvU4PqA1C/XsBq5nruVv5+y8ltt+g2OwJlj5PTWAyBlKWi+J3VYNzvyNBFMGC1lNMyKymZ8jtp7txdOF/GZqaWl0sO/tHMO0oMGx7DisYO/qiN+iypN8TWCTl8Aas78yXEReRfKdvpagYRGPFOR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5c11362f67eso1669785e0c.1
        for <linux-openrisc@vger.kernel.org>; Wed, 15 Jul 2026 03:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784111682; x=1784716482;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BcTdMoZv6JVy6M/fO3WdP9FofoXGw30zAP9bsFgIqfs=;
        b=fRRDu8xS2hAkHIlevTS6YjNusuTrj5uYkv+VWs1uHn6ga4+Lqbau62roDYj8Wig+X+
         1LRaIa6i3ah5EY5f3CjcBEuBPSSw8O23hSeDp/0eQPB/Mx02PdF92quM1QeqlR37/pBn
         p2FVJylei9ERcYy5iOm7+4KjCQ2KwISwsbRDkbkzOJ73D6Pd2zEjK6ZAbp/JnzqqsHqW
         9u/hSQK5tN+JB9qebmDxKkw9lrPjRQu6KEHAvJpLioPLQ+HTUvABw8aHgei+MF5T4Mce
         NErGTuO3Lr5o3rHXBUn1WuD1MmK9upvqC8BgeZv1QChperZBIU0jW9gFT7+c4o1Sl6Bo
         7pag==
X-Forwarded-Encrypted: i=1; AHgh+RqExNObey3NvQoYwsWPBMeHMsc48UzgKuCbOn/ZVeJM8En+K89G+V0PpLr25msS9W2pHEOvR7GtypDshs9WdA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4GLx3yeeNuL2eKKPzZ++N+xVg/0aDKFIkwEa+1bbeHrg65g7T
	ixouhpa1FPbhC5ga1y50SOJz8ltk0AY7ALbWKVTp3Qg4uEaHsrjFMFOEKvEOvGfPHGc=
X-Gm-Gg: AfdE7cmcgAJHHB9v/ekufq1vlYbGc3PmcXTPHqvDLrEywBFTa8mz6S7KYdW5YIGgvaq
	B1mng8/+uhbEF9DM9oUOThV4bGUCt87Vx9Frr97HonqO5FVI6Z2byiFDMveVQs5f7WM4QyCVbkm
	AoGWdIUcVMAcTveCG7blBCTr9Y6c0KlR/OLYTaURxYPYbRZyX1TsQ5cEGKvE4zn9qwYsm9pwpNc
	mxsy/znr17qcvMFzgzC11zCUitNeJS/iDMnnfnDtWi2hbYH34McnRmvnq/fZyAWCVzS+Ql8TiZo
	l/ELz0CD/oq0WtVxvCne/zIcJ4rg44l8XKDYznEhWejETATh+QnsZwug5nyl5na8oAt8rb0RT24
	lyUYfWmLOOoSIbtXXWGME4SEkrviojdS0rKQrFZaD+ZaX95J2H3llip7MyE6vIg5tNSigRHsHBn
	ewzu2OQX3Jji/A33Ydxzittb43kJZQpyAFdK2WEUtKLAVQORalWA==
X-Received: by 2002:a05:6102:54a5:b0:745:1c72:cf84 with SMTP id ada2fe7eead31-74533d90cdfmr11243358137.18.1784111681978;
        Wed, 15 Jul 2026 03:34:41 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ecf790293sm10403476241.0.2026.07.15.03.34.41
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 03:34:41 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7391d5504b5so1421367137.3
        for <linux-openrisc@vger.kernel.org>; Wed, 15 Jul 2026 03:34:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpe/3yf2CfZKFRgkt5ZaRdK3A36xNYp96Wq/eo654kVI3RSE8E0XO1XLFvYhHOZi0WpYZVpK5z4uPA5ym2szQ==@vger.kernel.org
X-Received: by 2002:a05:6102:94c:b0:730:db02:1d08 with SMTP id
 ada2fe7eead31-74533c1eae8mr11245328137.10.1784111681255; Wed, 15 Jul 2026
 03:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3ea30f8a-bb29-4bf5-8400-1c4840d46a88@kernel.org>
 <7e84b200-25eb-43a6-b5e2-5f27f2d82a77@intel.com> <31988089-095a-4eed-b5e2-c677c70f79f6@kernel.org>
 <14e250db-1641-4085-8d13-02f819657d5f@intel.com> <d83c76b3-ea4d-4c41-b4c5-f5ae558ace55@kernel.org>
 <alYgMxKqRnF6_X0A@e129823.arm.com> <6df814c9-405c-48d8-96ea-929c4b28949b@intel.com>
 <alZe-Cu7yQw9qRXU@e129823.arm.com> <alZo9feSrSB_StfO@e129823.arm.com>
 <CAMuHMdUqL=vJFAzYgcRVNbD_VWWwhehwTuhTfwLt_yRR8c+B0g@mail.gmail.com> <aldV23PwIXnFloaN@e129823.arm.com>
In-Reply-To: <aldV23PwIXnFloaN@e129823.arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Jul 2026 12:34:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVOHm6MmP9QsNVvxLsGp1e0jC9u9RGb6+xee0ZBs4Zwfw@mail.gmail.com>
X-Gm-Features: AUfX_mxU0lxjO-fzCeQeNX344H_SVkvovWXaE8EEgaGKFYO5e9NLd2LkTofC79k
Message-ID: <CAMuHMdVOHm6MmP9QsNVvxLsGp1e0jC9u9RGb6+xee0ZBs4Zwfw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/34] x86: mm: carve out the generic compile-time
 folded pgtable case in effective_prot()
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-arch@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, x86@kernel.org, linux-mm@kvack.org, 
	kasan-dev@googlegroups.com, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
	linux@armlinux.org.uk, akpm@linux-foundation.org, ankur.a.arora@oracle.com, 
	rppt@kernel.org, linmag7@gmail.com, chleroy@kernel.org, klarasmodin@gmail.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, kas@kernel.org, 
	zhangtianyang@loongson.cn, wangyuli@aosc.io, tsbogend@alpha.franken.de, 
	ljs@kernel.org, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, ryan.roberts@arm.com, pasha.tatashin@soleen.com, 
	rmclure@linux.ibm.com, baolin.wang@linux.alibaba.com, tj@kernel.org, 
	kevin.brodsky@arm.com, anup@brainfault.org, atish.patra@linux.dev, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, kasong@tencent.com, baohua@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, anshuman.khandual@arm.com, 
	yang@os.amperecomputing.com, chaitanyas.prakash@arm.com, ardb@kernel.org, 
	guoren@kernel.org, yang.li85200@gmail.com, viro@zeniv.linux.org.uk, 
	dinguyen@kernel.org, schuster.simon@siemens-energy.com, 
	wangruikang@iscas.ac.cn, junhui.liu@pigmoral.tech, muchun.song@linux.dev, 
	vishal.moola@gmail.com, namcao@linutronix.de, pavel@kernel.org, 
	djbw@kernel.org, yu-cheng.yu@intel.com, baolu.lu@linux.intel.com, 
	Jonathan.Cameron@huawei.com, coxu@redhat.com, andreas@gaisler.com, 
	liam@infradead.org, vbabka@kernel.org, surenb@google.com, mhocko@suse.com, 
	shorne@gmail.com, jonas@southpole.se, stefan.kristiansson@saunalahti.fi
Content-Type: text/plain; charset="UTF-8"

Hi Yeoreum,

On Wed, 15 Jul 2026 at 11:42, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> > On Tue, 14 Jul 2026 at 18:51, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> > > --- a/mm/ptdump.c
> > > +++ b/mm/ptdump.c
> > > @@ -190,6 +190,23 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
> > >         st->note_page_flush(st);
> > >  }
> > >
> > > +bool pdtump_pt_level_first(struct mm_struct *mm, int level)
> > > +{
> > > +       if (!mm || level > CONFIG_PGTABLE_LEVELS)
> > > +               return false;
> > > +
> > > +       if (mm_pmd_folded(mm) && level == 3)
> > > +               return true;
> > > +       if (mm_pud_folded(mm) && level == 2)
> > > +               return true;
> > > +       if (mm_p4d_folded(mm) && level == 1)
> > > +               return true;
> >
> > Is this order (... && level == ...) the optimal order?
> > On arm64, mm_pud_folded() and mm_p4d_folded() perform several checks.
> >
> > > +       if (level == 0)
> > > +               return true;
> > > +
> > > +       return false;
> > > +}
>
> It is. since the purpose of ptdump_pt_level_first is designed to be used
> in the *callback* of pXd_entry(). IOW, if we check level 0 first,
> it always returns wrong return in folded case.

I meant the order inside the if () conditions.
E.g.
"if (mm_pud_folded(mm) && level == 2)" does the expensive check first.
"if (level == 2 && mm_pud_folded(mm))" does the cheap check first.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
