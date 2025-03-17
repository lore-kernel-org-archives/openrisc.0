Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C170664C6;
	Mon, 17 Mar 2025 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199943; cv=none; b=PnBASBW1xK0XPjUHXZ7NjtRse3tSzmuMT+ogTF26rSunuRsM01nA7CQkQRzwfR0bBd45LH8qZS9u4RQkyNVcyRTi6kSODopVGFUSfA1VK4gn5O0vGlbOyRAJfhJMrS5o4k4O4gU5b8MwmjHmwGrVG7AH+SQN0PpHq6p9f8MjWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199943; c=relaxed/simple;
	bh=kVW/MV6dUV63B0iRH5b+vhs9+OeINTzn8vCjGyUd0go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IW6hPKeVYYFt4R3WlBgaWR7/l3ptzgsLvFtnF2LMFTKrfwiAKpRtObDA1mUAfkaxI8aN5GydR6jkH7VzJ7eWaswYx3rw/bb0BiuR7Hk8iPaQw3Oq9i8H3GxW/07EENUAhm+y8JQG2UV2mjP1j8N4hF4Xn5Nw46ZbklOJqOel/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86b9d1f729eso1626362241.3;
        Mon, 17 Mar 2025 01:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742199940; x=1742804740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAP4wT3KAbxvAG1pjCowNTM2gsMSibcHnaVmmOIurLg=;
        b=sU69MOXzLCXOaiH2DR/NYznxSlHp7f8vw0vDttOexip4EQ9NLsnYQjxjaJnxvjyVWU
         I1Wm9knOmPxc6Ot67N2pzeIaiYZpOXJ/s7pM7ZwIq/rjcxu558A9nCPZiio8Zfmf9oRy
         LDIwNKJ5CgWYrl5aIRh37JSXF/aiZS2UHD3cZm9/8hW5ckSYDBK5mRg2Js+vGAqeSzXf
         iEUNpCnFAdWA52h3UeWbY7SL5tP0yPRBs368WwycQHgdnf4rIzLuTacJKEgrRw9xcPhs
         gY4ixJx6cqqj0US68HY667J7lbWWLVPBjwzfjzC7QMKaaXetcYXaEsZ89shPBBTiIB10
         ZpZg==
X-Forwarded-Encrypted: i=1; AJvYcCWE5f4mi6S4eIV3HU5ICulYQYURHQ+7wHdXlVtzDHv1032Wb5cUV82OQeBHMmBDu+PZq2T8/IU4VPYiUL5N/Qg=@vger.kernel.org, AJvYcCX8Qq0UMPMDi3Zuyhf2+pKWi2xLjvdnLpMfyeR2w2h5xklBQI8jX04GjzSH3r29ifMYW3g7rcRYHcMrIXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkNCueKeaMGzcI0DjbolzTJSvUUyQmkQE4+c3XD/c57VCu9OX5
	cdGWDxjATJL6p2PrSrzYlEX68kLpMt++2nr2U+dERPcA3tHuYRw03HTZouEn
X-Gm-Gg: ASbGncvXe2Xs9ra5JXZR1Nmz7GQvK6mv18boKCXiA1h05bQ0BxLHnC+6e8X/8QZ4EBF
	XinXE99j173iq2W+/QDs1ez9lXP0Ovxls4nMRpzmQgLh1spmZyjy0ZhE+Fx9dKiF6DPui2Pp+Tu
	GQhbm1S0QWF1lAReIMrJx91RALazTbre0rY8g7Ytsi41eqg5Rb/kpG59xsiQaDOphVlOen2dvWp
	WXKeVDJCNNvvDZuyEjszgTDK4t2rdXnSWpqGWqwNWopis3fLGWVYm53jqQN+E40g6RkjbUvNIP3
	M28dS2MGdEQUpa1FPJ6s6umFfHQcKJe0LRMMppk64lK1d0t0RV9M/rqavIC1Me5crGfhz5zXAQw
	R8hATrI4=
X-Google-Smtp-Source: AGHT+IEqYou1/K0XlSfTD/M77OLoi9/3rdfl3pB+6A8ylbzP19vhwl4ji/UJvcA8/0bpReIzkWTNnA==
X-Received: by 2002:a05:6102:442c:b0:4bb:db41:3b6c with SMTP id ada2fe7eead31-4c383165298mr6551602137.12.1742199939614;
        Mon, 17 Mar 2025 01:25:39 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c374f5b988sm1390236137.13.2025.03.17.01.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 01:25:39 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86cce5dac90so1735958241.0;
        Mon, 17 Mar 2025 01:25:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6ToFhJKNEgIcaR/reFgdVw7F6cv5P9chCMTz4bAbLQKemY3U0uEIeBOOw7nW5qNWr2oWvcgx89ELEw90=@vger.kernel.org, AJvYcCXt6altgXDT1LOO/UviJZsTJgIuceQR4QTpYeEXCRJE2xDHkPwBG26UnPzMDt20IreIbMnZY0dR5XptmJ9fXxI=@vger.kernel.org
X-Received: by 2002:a05:6102:c08:b0:4c3:577:a8e7 with SMTP id
 ada2fe7eead31-4c383201fd7mr6871445137.16.1742199938943; Mon, 17 Mar 2025
 01:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315203937.77017-1-sahilcdq@proton.me> <Z9Z2sjWQHKgGJyGo@antec>
In-Reply-To: <Z9Z2sjWQHKgGJyGo@antec>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Mar 2025 09:25:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWh=oo6JykPGD3DNEL=GcfgyKw2UK7vb8XMbH19GcdrwA@mail.gmail.com>
X-Gm-Features: AQ5f1JrYhoTwRipqDAPS7e9Nqyxba02OtyaULWdsQFq8eBnJoiGYz10iD2mY_CA
Message-ID: <CAMuHMdWh=oo6JykPGD3DNEL=GcfgyKw2UK7vb8XMbH19GcdrwA@mail.gmail.com>
Subject: Re: [PATCH v2] openrisc: Add cacheinfo support
To: Stafford Horne <shorne@gmail.com>
Cc: Sahil Siddiq <icegambit91@gmail.com>, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, linux-openrisc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"

Hi Stafford,

On Sun, 16 Mar 2025 at 07:59, Stafford Horne <shorne@gmail.com> wrote:
> On Sun, Mar 16, 2025 at 02:09:37AM +0530, Sahil Siddiq wrote:
> > Add cacheinfo support for OpenRISC.
> >
> > Currently, a few CPU cache attributes pertaining to OpenRISC processors
> > are exposed along with other unrelated CPU attributes in the procfs file
> > system (/proc/cpuinfo). However, a few cache attributes remain unexposed.
> > An attempt is also made to pull these CPU cache attributes without
> > detecting if the relevant cache exists.
> >
> > This patch provides a mechanism that the generic cacheinfo infrastructure
> > can employ to expose these attributes via the sysfs file system. These
> > attributes are exposed in /sys/devices/system/cpu/cpuX/cache/indexN.
> > Cache attributes are pulled only when the cache component is detected.
> >
> > The implementation to pull cache attributes from the processor's
> > registers has been moved from arch/openrisc/kernel/setup.c with a few
> > modifications.
> >
> > The patch also moves cache-related fields out of struct cpuinfo_or1k and
> > into its own struct to keep the implementation straightforward. This
> > reduces duplication of cache-related fields while keeping cpuinfo_or1k
> > extensible in case more cache descriptors are added in the future.
> >
> > This implementation is based on similar work done for MIPS and LoongArch.
> >
> > Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>

> > --- a/arch/openrisc/include/asm/cpuinfo.h
> > +++ b/arch/openrisc/include/asm/cpuinfo.h
> > @@ -15,16 +15,18 @@
> >  #ifndef __ASM_OPENRISC_CPUINFO_H
> >  #define __ASM_OPENRISC_CPUINFO_H
> >
> > +struct cache_desc {
> > +     u32 size;
> > +     u32 sets;
> > +     u32 block_size;
> > +     u32 ways;
>
> Considering the changes below to add cache available checks, maybe we
> want to add a field here, such as `bool present`.  Or a flags field like
> is used in loongarch?

I assume cache_desc.size is zero when the cache is not present?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
