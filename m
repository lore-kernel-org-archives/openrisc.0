Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D89738E5D3
	for <linux-openrisc@vger.kernel.org>; Tue, 13 Jan 2026 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307610; cv=none; b=HU73hL60CJrtRFgmyFja+bu14nQJFuly2UgFCW0VNOkku/z3Atq1UEW8wWkkLPNHskp6a5Ditw2FzcwXsBsaEA/ZvvVlL2yu+pXdO9GuHeQL5Ki91ZqTblCLrYNuZIE7gGVjmYJ+EjMeIZpzypHGcWXZ0tCq1PdeLVaH5qop/EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307610; c=relaxed/simple;
	bh=c2pQGNsmx4TXSTG4ks/OmiO2LMby6F7I6nhF1Yls93E=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=HZenKxVEGwtPIZUh5K9lNqSJ9Bj33kS0TMJJ4sjS0PxaGIjYUAOY/Ee+iWSMbOdEoUDWJRYUKugz+WhAUC4zGXt2SbUTdyjzKOg/Dh/f+j2iK2ifQN/8wpvg1ORh1dhow8RjmARw3WLM5vg2ruW/wu7pK+n+uA/gFKWe5jaEJ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCrBvpZe; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCrBvpZe"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c30f0f12eso4361774a91.1
        for <linux-openrisc@vger.kernel.org>; Tue, 13 Jan 2026 04:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768307607; x=1768912407; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=j4BCb4tuwUydlXX/lekB/MWAbo5xTWmBY98lhxIZgCk=;
        b=GCrBvpZeucBOdNpJseUbRKNa77J3jEjSKSr2rQltUiOSzioURb4448Kr9GVdc4A4M6
         EeRxRTsOfiRVNkUEGN4mkvBWr7+cqibFBBnbNCpse52V2sMsMNI9lEm95Cnlek63otZl
         syjrb7MRSUA4zfswNNSYnSNoKl7QdqKysebTzPHBsCeNlTTSfvgjmp0e0FuW/B95Alst
         oe/iuaWn7B8uGt+o/gTqlwZd0wTuqVGIQR6mFwzUCdAVrz2qHLtEl1u3M5lND7sa/YIo
         WJVxnqKjY+DdRZteDSadMj1yuf/MI2IqhwEjkDmLAD+876PYUwT4dDvY2csrpor9dpk1
         na4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768307607; x=1768912407;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4BCb4tuwUydlXX/lekB/MWAbo5xTWmBY98lhxIZgCk=;
        b=U7/7fZEOJCMIck/495fFgobpd4v0AUows7DcXW6UCiiEawmV0zP9QDnlK+2ewxQ0A7
         yBN022t5UhXLM223CEIx2DM/a18qL7z2zyl/b3s50uzhc0HN+GsJijfNjznChiRsbBsn
         GqN85kesCs/BOsODJa12p4kJ3dxcn/D0MW2jkhueDLbukZm8ItT4LK0z84YJNV/zbcRC
         L07r1xn16tPSi+YHHtk7RL+8A6Ofev6QgVTCknU1OhvszZjn/rnYxuKu1vidFMEphcdt
         IPVhpt2sAgra/aksaEi+k1t7BXqlK1bN45Xq+K1CtePoSp7196n2rzRv6hJ/roxBOJA1
         fo5A==
X-Forwarded-Encrypted: i=1; AJvYcCV2dGwEzjE4fL7UAwmgUdd/ZS34Hqe98ZjgJJAET1F1b/mf8IAd9aKlQrBe0HZktep6NXSyc4rjVQM98vCsBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnx0wokDMEL9MHVXl2e8WC1bxmqT9wl0xY+/DDwu4SqT2P3w+U
	Rd/v1XPHwjjjynfmaQDXrqZ80DDtbJ329ElUyIWKXqMOKaM4t40YV6rG
X-Gm-Gg: AY/fxX6vPvsaXwNFzFKGDAiFgWVC+oA2r47UlV+q+gAB8ysUqQoFYukPq5Ibpacv1xp
	JdD3E9KMuATnMjjL87W+4l3Fj8ZApI28VtzFZXEeNCfjJ22vRBoHF2h+HV2yJrz2z7DHFtq1ty8
	VOb95phGB4GUUXG/usdWqzxNUPt9Ar8UbaOtCs+3HoPNG2yp9BucaFOONrr0je6sfukDvVzrZvT
	hkSq+kIwYH/RNtHewpIbue5rc/kfVr17/Ai090MaelTj+csdhQmXnlA6i3bda8STqwDPnLH20mH
	KO6q1WDZ/5mvLqkU98003eeCAzZ5hy3PIiMh/Gut06xT+9OVgKs3xBz7Ro+/kyKDbKxxBy0vEhR
	3BA+RH4lHR2wwdcCI/jRNeALPzpxlL2pKGxMN4boIpA9DPkL0pfbSK+WXb2pq3LEzr/JdGBKdCr
	sl8TqK
X-Google-Smtp-Source: AGHT+IFw8NQUhXWsNFLNcy9VnhtaeqSccMp4bageDierszWlx1Kxyih6osyfD1+uAcqTN4o2oK4SYQ==
X-Received: by 2002:a17:90b:3ccc:b0:340:9ba6:8af4 with SMTP id 98e67ed59e1d1-34f68c47f0amr18570023a91.35.1768307607428;
        Tue, 13 Jan 2026 04:33:27 -0800 (PST)
Received: from dw-tp ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-350fd6e343bsm1428958a91.1.2026.01.13.04.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:33:26 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>, 
	Klara Modin <klarasmodin@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Magnus Lindholm <linmag7@gmail.com>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>, 
	Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 15/29] powerpc: introduce arch_zone_limits_init()
In-Reply-To: <20260111082105.290734-16-rppt@kernel.org>
Date: Tue, 13 Jan 2026 17:59:49 +0530
Message-ID: <87zf6hu24i.ritesh.list@gmail.com>
References: <20260111082105.290734-1-rppt@kernel.org> <20260111082105.290734-16-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mike Rapoport <rppt@kernel.org> writes:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Move calculations of zone limits to a dedicated arch_zone_limits_init()
> function.
>
> Later MM core will use this function as an architecture specific callback
> during nodes and zones initialization and thus there won't be a need to
> call free_area_init() from every architecture.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/powerpc/mm/mem.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

This v2 looks good to me. 
I have also done a basic bootup testing using Linux PPC CI.

Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
