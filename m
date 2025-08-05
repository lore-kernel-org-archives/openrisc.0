Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E426562D;
	Tue,  5 Aug 2025 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386702; cv=none; b=hFk/S3JL8X7/5Lectn+qTzCocM71bJdbD7S0LOANZcwS8Ipp6C4aYGwuleTmfsL56nrkMYJTZp6Ijg5fYJKxvivbMYm2s4kCTqdafw21RuTE/d5J1+Z7aBwjPsG7K691bzMR2cJckHyXfr2tz/sIRcol3DAcqD/asXheJIRDF6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386702; c=relaxed/simple;
	bh=CsHmQFsEgsts7bo3tK+ycQE+LE3QQd13m41IB/xx2Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzUNA+uJelbeluai6rVB+NQ4lSCXWyC0NB2E8mT1DehlAsxbC1efPHihQG0A+WtH3sp20u/Q535bOH1j+d3ShqudiSZBwuaaNziVpuLhciXxieQDKWYrmvkUTHI6kLkJAT5sA3T8wlB+X2qfqfNjRFeVLFyZz13MfXKkcjh7+/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5397d436dccso1125909e0c.0;
        Tue, 05 Aug 2025 02:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754386700; x=1754991500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79Sev+FddMWY4af3rPBzvmaRJ3mXxP5x7puvKCiTzUQ=;
        b=X996XLjQPD1X5N824m0NtEN16bHBICHLyD8EXJYuJO7R9EONEtfLADwOvPKZtf9rSz
         wGCf/OUizEvxxv1nb9K6bVoHVXy/S4/B+eBzj3THRJu8mhe5Nx698y80cFX3MCTptKrv
         ezZAsIEfs1rzYXyOC9ANkWxpBjVdioDOnSczrziqV4aEyPAl1K4yseoJN8bnGsQJ/bS1
         BS4nXeC71/UyNcJHxITaRd930hj1fg4oYok3qUOng5dKwzC+fIuHuVx9RcBZ9HSSBb/1
         mFtLQ3BuvFbwo3GoxusnqQerPkA5eXegPGa3H7TXjlSoPIw4krL+6HhutMxJmo7Ea2qf
         jDOg==
X-Forwarded-Encrypted: i=1; AJvYcCU/zwnyGZzvtL+uwkFusY7VbrnesTIHQGr/R9ppd0eODx58xiwRGjXaYZCE+bdsDcCLdyXkw2pjKtOyVwY=@vger.kernel.org, AJvYcCVEoHcIVvT5XpT/4Qv/HrZq4Ac4UlXZC3RUY1eBiY44rHoJLghZi5c2HOl4nSrl0fV+qxmVU8Lt3rJvKQt8Jo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvf5UjrXuXuWxrOxKbe/LEalIT25QFi+kPjSJc30o7SB8med4F
	/VPPmv2u95IasocqiZJqU9Svh9XGciBN2TapBfSFPWk777p8WHoZuGffbFuNrC+y
X-Gm-Gg: ASbGncuOzyNgaSn+oheA7x6kjUqryLkOtXKwoyDXNyRdNOzLEW1z9YtQDtK5xkNHfbU
	b+2YCE2af0beclY7oShG4FOi7LiQtBsYy/Kib0qhkDyCk/567tjZAfIXPqh3STr0ZszYIgwlM4N
	L8T6kZ2eGYBOV3lFtzDQub85QcyQVTcpzCSiy0lrpUKeZXGvkjTCXPSvoi3bkWKz/9U0n8uoUc4
	QNwgp/0AAl9yC0DCOjmRXwx6+9bNyUmfP8YVLNGt27q0tsXTOIJBuY2oonJ7K4ryGBNc75JoL4L
	ExDAtNR7U7epUyqTH1f4gok8vNawzKaR8IG0OSHJ/6A40anZAON1oa7Fe4WFtLvoOPV3bPv3VHl
	hLa2nuRG5ZoO3XfH92JyoDn1YBoSW9lJXN0GXE/HDWNq0ivD0+1Ru47aGMx1j0DISQ2cb5k0=
X-Google-Smtp-Source: AGHT+IGiAVxrYzV3bNydyAN1Kl9RxUYBHIou5jDmgprU0itO7KReDwpiKl9LlCEDg3P/Qg1yw9qCXg==
X-Received: by 2002:a05:6122:21a4:b0:539:4bf9:233a with SMTP id 71dfb90a1353d-5398f3794e2mr1324293e0c.5.1754386699656;
        Tue, 05 Aug 2025 02:38:19 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53936d11640sm3359146e0c.24.2025.08.05.02.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 02:38:19 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-88ba6bb90d6so3586217241.0;
        Tue, 05 Aug 2025 02:38:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJs5Gq0QfGqHl4RNmED/bAeFIU6m+HwtbDsfwyLSLEmKQCUQPbp0s8dj2x9HfYOrnwvibdMZNaWuyQAGt2gBw=@vger.kernel.org, AJvYcCWdVBzB53JZwGFHONCATGMwxKVlB1VFzHWgaSooTvLcD67Vgae7RMBaVBmFMAc7YuDrbjTU2Cb1iw6wie0=@vger.kernel.org
X-Received: by 2002:a67:f5d9:0:b0:4df:e510:242e with SMTP id
 ada2fe7eead31-501df5d3a6dmr1150909137.5.1754386698952; Tue, 05 Aug 2025
 02:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805084114.4125333-1-chenmiao.ku@gmail.com>
 <20250805084114.4125333-2-chenmiao.ku@gmail.com> <aJHLxmPk-5cPCnPA@antec>
In-Reply-To: <aJHLxmPk-5cPCnPA@antec>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Aug 2025 11:38:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX-hQ3XaQtTnbP50ngFB=wKG43m4cxFDUh++Hx7q_LnSw@mail.gmail.com>
X-Gm-Features: Ac12FXzRUM01SIDhF_ZhDuCMxt8maDs6G-ynYu_G6MZjpQyqy23qtgVMsp7zn64
Message-ID: <CAMuHMdX-hQ3XaQtTnbP50ngFB=wKG43m4cxFDUh++Hx7q_LnSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] openrisc: Add text patching API support
To: Stafford Horne <shorne@gmail.com>
Cc: ChenMiao <chenmiao.ku@gmail.com>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Arnd Bergmann <arnd@arndb.de>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Sahil Siddiq <sahilcdq0@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Masahiro Yamada <masahiroy@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"open list:OPENRISC ARCHITECTURE" <linux-openrisc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Stafford,

On Tue, 5 Aug 2025 at 11:15, Stafford Horne <shorne@gmail.com> wrote:
> On Tue, Aug 05, 2025 at 08:40:57AM +0000, ChenMiao wrote:
> > From: chenmiao <chenmiao.ku@gmail.com>
> >
> > We need a text patching mechanism to ensure that in the subsequent
> > implementation of jump_label, the code can be modified to the correct
> > location. Therefore, FIX_TEXT_POKE0 has been added as a mapping area.
> >
> > And, I create a new file named insn-def.h to define the or1k insn macro
> > size and more define in the future.
> >
> > Among these changes, we implement patch_map and support the
> > patch_insn_write API for single instruction writing.
> >
> > Signed-off-by: chenmiao <chenmiao.ku@gmail.com>

> > --- /dev/null
> > +++ b/arch/openrisc/include/asm/insn-def.h

> > +/* or1k instructions are always 32 bits. */
> > +#define      OPENRISC_INSN_SIZE              4

> > --- /dev/null
> > +++ b/arch/openrisc/kernel/patching.c

> > +static int __patch_insn_write(void *addr, const void *insn)
> > +{
> > +     void *waddr = addr;
> > +     unsigned long flags = 0;
> > +     int ret;
> > +
> > +     raw_spin_lock_irqsave(&patch_lock, flags);
> > +
> > +     waddr = patch_map(addr, FIX_TEXT_POKE0);
> > +
> > +     ret = copy_to_kernel_nofault(waddr, insn, OPENRISC_INSN_SIZE);
>
> If you change *insn to unsigned long insn, you can do:
>
>         ret = copy_to_kernel_nofault(waddr, &insn, iszeof(insn));

sizeof(*insn)?

>
> > +     local_icache_range_inv((unsigned long)waddr,
> > +                            (unsigned long)waddr + OPENRISC_INSN_SIZE);
> > +
> > +     patch_unmap(FIX_TEXT_POKE0);
> > +
> > +     raw_spin_unlock_irqrestore(&patch_lock, flags);
> > +
> > +     return ret;
> > +}
> > +
> > +int patch_insn_write(void *addr, const void *insn)
>
> Does insn need to be void *?  It think it could be just unsigned long. See
> comment above.

u32?

unsigned long would be 64-bit on 64-bit platforms.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
