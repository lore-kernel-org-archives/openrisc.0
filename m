Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58371271A9A;
	Tue,  5 Aug 2025 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399480; cv=none; b=kHZkDbcTe1KgUZJVXjvT98GYODX1UPzPK/2kJCkXyX6YkvZrFQjjFdUzw1e7SkotouJf38mMQrm/Odyv2sUj0NIua+/srLsu3Pvuu0v5aPdLrWbO7xZAcbIyKvG0MqN+XByK+GMF56D1SQ8mXB8EXXCgNlXTjHKKz380yldjT6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399480; c=relaxed/simple;
	bh=8U47cS8M0ega3JyH0Yo9BlwG6duqLp0+XcCDukm0GSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/f2zyMn57fjZMqTyQ2BsDKeuz6Qpu7wp1aRtUW39Xq9KN9s01RqxG3U30wdf7lswm0mbJhgeDmV/UgrORLaLJlscfmOMg4XChHSWD2I7Hdj7RuOzNHT/I7PaTu2oYx5n7D8LR0qMX9VQjc1/U9DlXR1OA8Lwcq5UA+6YkaywWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RK2tctLX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK2tctLX"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-458b2d9dba5so23606335e9.1;
        Tue, 05 Aug 2025 06:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754399477; x=1755004277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5AkrgU4Qr/mp1srzuYumnT3vjFuy8QJEZxbccvGb4VI=;
        b=RK2tctLX9Ata0AacdzBrSTrGhGAfLux4VajxgAEHANzDN2XqTBcaYrPlScrnKq44WG
         dCQ6KTVaIsMJyjyA3/M+sjSKK81atn/Dejq8a5moLpo7Re9LKsKRthsLvBQs9uoaRgVP
         uR2JZDOEickwm7ePMtYfTSrvvhdibL6o4lzgN4H4EGKqTKDCFUJ6q00+mtHEFM4L+MLH
         BnRAEOKRZdVCKBr9bss515E615DunTnypF8Jvt/Dnxa9XDR+6pR3YEqHAwP8GwLrffyP
         Xs6pGhWbkoN+dT3cx52eS/L8CVdW9mCOr4CN3DkxqkJgd/GJeKHYjaqK3YqIifZU3JS0
         fjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754399477; x=1755004277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AkrgU4Qr/mp1srzuYumnT3vjFuy8QJEZxbccvGb4VI=;
        b=PwYkfzhJ0RKT9XMe8mHu0VZ2VHHssw7l20ZjcYzTozPNkyoLVR7TTxkyslSunnMpug
         SSIP+DP9SucZkqfCdCds5Uy3sDL0po+fi8MxRLT9uM3hwd45aSTNsYIWkhN8+7cUhg1s
         81HSh9gEkCc/c3a9GI7DbDMLN7aX2I78ur1vWJba1nevKubefYWeLvVrnT7yNFEQ0a05
         shb2KJhPxq5fhiYspogjzLgstPDHHj4fGLD4+UjsUOPu7s9dFLaSNgXm6It/Y4JkGnrn
         qcHUHY3BDjwfuMHv6xH/RX5RXgrtZjuArexeJg2eN5xOE1Cz4AaDMoQj5PadusaBjmcx
         qIHg==
X-Forwarded-Encrypted: i=1; AJvYcCVaBOiNFoxyIrRCmWYhrvJOGMTBVmlgWdZQWftX5xXqiufYI+7/xZzDgubWy1qAAFOmy/MfaQuKJehQRIU=@vger.kernel.org, AJvYcCX6YeqcigIcq8zPMq7TNDpbnli4NfO6GHiJxarTSCFXHHjc783fmBLQqjzscNeJfqLXj4VVuw1vcSRR8nh0z+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzqr1iwnmh/YWNr/S+wNaDib3j/4+cr78REaOSeUo0/NGxEDE1
	uZyyMN/KMg7sBLGce6wT+NdghgkLI/HgJuZ4bOqRuW/VtMkepuOpiI5W
X-Gm-Gg: ASbGncuRe7FUYh3LsOAue8KXTAJAmEwvareQ6Dfc87aiy3Zv0GfhtBZihH+oGq0r2a/
	sWIkT0kCP6XlkO0rXG/8kY8eE9mS4zoRhQ7s+2Yrul1EfhNu9RD631ah8GgC9ms2YBQmh0URRuw
	xL2rEvW3toJ3ue/lXMVwMKrsy1jDG17fj45Co0/ZX3MphUZfnZLGkjIb17ZNdw5ishKknyYnZKj
	a6gvBy+m281Hl1/EV5wQONZ4dZW6qF4zMlfn8HHW5kD+d7Glhseg5Kv7gptlmn59UIRLzrzA87K
	vqyhjt8HE82OfGpK2xKOUMyhjYT49DMAaOpq763efB6CqbV2MEmym4tfOK1fm8ngbwLjzBKPaSX
	F45Wcgm7ZwJ0sLRSCPkK689raJHVjOOGQVMvMGC9DSxlAeAGq/rzSbNS3qZhskg==
X-Google-Smtp-Source: AGHT+IHbXCw4RVSetbK6YNwmG6sT806SwSmGa7Dhml3YfvSWegT5tnRgzznI79Idd6F3osM/IClmJw==
X-Received: by 2002:a05:600c:4fc6:b0:458:bfe1:4a8a with SMTP id 5b1f17b1804b1-458bfe14efcmr96562855e9.14.1754399476396;
        Tue, 05 Aug 2025 06:11:16 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e0683045sm9539723f8f.41.2025.08.05.06.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 06:11:15 -0700 (PDT)
Date: Tue, 5 Aug 2025 14:11:14 +0100
From: Stafford Horne <shorne@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: ChenMiao <chenmiao.ku@gmail.com>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Arnd Bergmann <arnd@arndb.de>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sahil Siddiq <sahilcdq0@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"open list:OPENRISC ARCHITECTURE" <linux-openrisc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] openrisc: Add text patching API support
Message-ID: <aJIC8o1WmVHol9RY@antec>
References: <20250805084114.4125333-1-chenmiao.ku@gmail.com>
 <20250805084114.4125333-2-chenmiao.ku@gmail.com>
 <aJHLxmPk-5cPCnPA@antec>
 <CAMuHMdX-hQ3XaQtTnbP50ngFB=wKG43m4cxFDUh++Hx7q_LnSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX-hQ3XaQtTnbP50ngFB=wKG43m4cxFDUh++Hx7q_LnSw@mail.gmail.com>

On Tue, Aug 05, 2025 at 11:38:07AM +0200, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Tue, 5 Aug 2025 at 11:15, Stafford Horne <shorne@gmail.com> wrote:
> > On Tue, Aug 05, 2025 at 08:40:57AM +0000, ChenMiao wrote:
> > > From: chenmiao <chenmiao.ku@gmail.com>
> > >
> > > We need a text patching mechanism to ensure that in the subsequent
> > > implementation of jump_label, the code can be modified to the correct
> > > location. Therefore, FIX_TEXT_POKE0 has been added as a mapping area.
> > >
> > > And, I create a new file named insn-def.h to define the or1k insn macro
> > > size and more define in the future.
> > >
> > > Among these changes, we implement patch_map and support the
> > > patch_insn_write API for single instruction writing.
> > >
> > > Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
> 
> > > --- /dev/null
> > > +++ b/arch/openrisc/include/asm/insn-def.h
> 
> > > +/* or1k instructions are always 32 bits. */
> > > +#define      OPENRISC_INSN_SIZE              4
> 
> > > --- /dev/null
> > > +++ b/arch/openrisc/kernel/patching.c
> 
> > > +static int __patch_insn_write(void *addr, const void *insn)
> > > +{
> > > +     void *waddr = addr;
> > > +     unsigned long flags = 0;
> > > +     int ret;
> > > +
> > > +     raw_spin_lock_irqsave(&patch_lock, flags);
> > > +
> > > +     waddr = patch_map(addr, FIX_TEXT_POKE0);
> > > +
> > > +     ret = copy_to_kernel_nofault(waddr, insn, OPENRISC_INSN_SIZE);
> >
> > If you change *insn to unsigned long insn, you can do:
> >
> >         ret = copy_to_kernel_nofault(waddr, &insn, iszeof(insn));
> 
> sizeof(*insn)?

Yes, typo, thanks.

> >
> > > +     local_icache_range_inv((unsigned long)waddr,
> > > +                            (unsigned long)waddr + OPENRISC_INSN_SIZE);
> > > +
> > > +     patch_unmap(FIX_TEXT_POKE0);
> > > +
> > > +     raw_spin_unlock_irqrestore(&patch_lock, flags);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +int patch_insn_write(void *addr, const void *insn)
> >
> > Does insn need to be void *?  It think it could be just unsigned long. See
> > comment above.
> 
> u32?
> 
> unsigned long would be 64-bit on 64-bit platforms.

Thanks, yes for us it's more correct to use u32.  I always thing unsigned long is
OK in openrisc as we have no 64-bit implementations.  But might as well have it
correct in case we ever add the 64-bit implementation.

-Stafford
