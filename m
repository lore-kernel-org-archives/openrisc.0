Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73F8239096;
	Mon, 17 Mar 2025 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212807; cv=none; b=BwhsQHqnPDwKoEr/jJMlAt7Vw6KBi+BcAju637w/6su9bWMBdUkyvtKB+0ljn234J/OiOPYuCeo9ByttMvtgUQLlviSMuA9qeXkjItOzi8dPJ9a6emza+PFErsmhgpBRfiUND3sx8LIqzPy5LwzVtO1TMWo730aKGXeSrPZxuGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212807; c=relaxed/simple;
	bh=/lAoAaVx4WxkYhZzgk4yiXRzsbO40tnfKcBRUZX11dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQeFdstRG8vAKODAJ87MbOo0mx4ChYidoGO6h4lE6E2OhnHpIS+0QyM0dDKoSJq/fZiWUhd2qaZa6R6M/9Do4EeXk43DKqesWZSvYkSQg5cH2z523nc/Vmx/QEhKAD3tGl1/0asEDgyz2qx2jHoo7pFwFzKmmS817WVWO7lnhto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sv/qVAbU; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sv/qVAbU"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-391211ea598so2301132f8f.1;
        Mon, 17 Mar 2025 05:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742212804; x=1742817604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NPfYFPQDBJXaI7i52Tj0TRgvPndnRJHENfvRIAbA7rQ=;
        b=Sv/qVAbUN5B7PBX754M3yNT6rEoTKNCEC/ck5QW944sI1W+3ZfDkIMtiKBF4A2iYOH
         vm3vVxzeI694LZkVvyBhCWYVM0eip0sSML1Wpn/Fv5IdxN0Tn3ZIJEymULahaRaWxapr
         vbLVttqRitQ0ZIF7kmir89+2FjHtiyUBHVuyD8+ikmjVPLxOM17vZpPGa8daqeZdke6g
         nCJcVQMIjuoct8v8P6NWURFyEwvkjV3mnGQ08EIiwKkHXq9BgTg0TtqOAVETCVRZwHit
         W7txq09htdQehsIcGzIEq0688+od9q9eO6bXhFwv+1VdZMjHYUguKBKl/9TmRs3097xK
         +iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742212804; x=1742817604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPfYFPQDBJXaI7i52Tj0TRgvPndnRJHENfvRIAbA7rQ=;
        b=BPuxS2XdKu5YQsKN4H4gJB3w/TJ6ClifJKFMllKxh/m94js21pv4Zf394eWcTPAC3+
         AlLnymBkgfQIU27aelinYsuWgH6s3y2v+Kg3kJLCZcR27nQ0ZDyxUbxuG7lMrilXuPPV
         tQ31D2oN0W45x1zk4+ZyERZED6GCO9NSwcW3NTZD0g0uhn3VpEdVhSmqbYQmcxUzevqf
         gioTkGsOZ6XTI7LO1VYaOcXPWwuJE1xRbnLAYSF2y/PPDhwZxE1F+jmwM7bOpNyils5m
         vV9BxwSfWxStkuv6rv7V+vhVVNa7sux0Qtr/J0HQTuuag3Fd88XJ7F3OXkAToP6Bn4CV
         /HKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu3kgexeKv7EzNCq3V/UX4YmbjTkRk96JyXqrP+SWm8kRxtEGOkOROM76Y7KH721h9Hr97xSu/28IKizo=@vger.kernel.org, AJvYcCXJq44Ckap3WfhoB5TUouR9o+rvFi2z3ZF2MgwG63bAqnMHEOXZNXVsBmrArxSMN+AtTMO9LkyJ0xJyuyQroYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC6f9pzw6eYXtjoqhtnidqkUrCheAX8hAUVN48T5CakfBjsh+m
	StwdrmzDu8TtzewusCsB0lamidI9zLmvYJUi8enY856tH5IoX93x
X-Gm-Gg: ASbGncs7cLvNklOK53m9zd88bVoDO9Zx2o6AxqeeiK/wKhR95JcHXKwaS6PTMngao5v
	qqN3IHfMgGbB8Jt5miuu0ohLSPrL4H3dOQRnBZN1UUo3ggLQVmq4SF010GwT68U1/eU5i5g5ovC
	eQfSpnvCQgF6M5sJeUT+A2a6Ncgqvw9n4J5ojfpwYJOzHNlX2D4/Ts9RSt/6foY+BBlLqgeVMOi
	S9cRyb17fLfV7bd7rIYhiTX9opdD54Cl3c0+cvV3UToVs44xu0MDCL45Q3TP9ebs0hC6s4H6V71
	/TXMiA2Kl/k1k/mg31B4NBSnUiuh05W4mILqWjGhp6OGWjd/Z7UdW+vaW+uvlJVIKIuGXSpM9qE
	KJ7GqJmkE
X-Google-Smtp-Source: AGHT+IFDxL0qCVe3e+njil/QVZMzz/LbKUbwYQ9tEHGz3vWaacWrbWMcyXYu1QeHoOHNVDK6ygNPaA==
X-Received: by 2002:a05:6000:2ab:b0:390:e5c6:920 with SMTP id ffacd0b85a97d-3971ddd6164mr13035498f8f.3.1742212803597;
        Mon, 17 Mar 2025 05:00:03 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebaa5sm14689092f8f.87.2025.03.17.05.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 05:00:02 -0700 (PDT)
Date: Mon, 17 Mar 2025 12:00:01 +0000
From: Stafford Horne <shorne@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sahil Siddiq <icegambit91@gmail.com>, jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi, linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [PATCH v2] openrisc: Add cacheinfo support
Message-ID: <Z9gOwYl6kmoPY9-C@antec>
References: <20250315203937.77017-1-sahilcdq@proton.me>
 <Z9Z2sjWQHKgGJyGo@antec>
 <CAMuHMdWh=oo6JykPGD3DNEL=GcfgyKw2UK7vb8XMbH19GcdrwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWh=oo6JykPGD3DNEL=GcfgyKw2UK7vb8XMbH19GcdrwA@mail.gmail.com>

Hi Geert,

On Mon, Mar 17, 2025 at 09:25:26AM +0100, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Sun, 16 Mar 2025 at 07:59, Stafford Horne <shorne@gmail.com> wrote:
> > On Sun, Mar 16, 2025 at 02:09:37AM +0530, Sahil Siddiq wrote:
> > > Add cacheinfo support for OpenRISC.
> > >
> > > Currently, a few CPU cache attributes pertaining to OpenRISC processors
> > > are exposed along with other unrelated CPU attributes in the procfs file
> > > system (/proc/cpuinfo). However, a few cache attributes remain unexposed.
> > > An attempt is also made to pull these CPU cache attributes without
> > > detecting if the relevant cache exists.
> > >
> > > This patch provides a mechanism that the generic cacheinfo infrastructure
> > > can employ to expose these attributes via the sysfs file system. These
> > > attributes are exposed in /sys/devices/system/cpu/cpuX/cache/indexN.
> > > Cache attributes are pulled only when the cache component is detected.
> > >
> > > The implementation to pull cache attributes from the processor's
> > > registers has been moved from arch/openrisc/kernel/setup.c with a few
> > > modifications.
> > >
> > > The patch also moves cache-related fields out of struct cpuinfo_or1k and
> > > into its own struct to keep the implementation straightforward. This
> > > reduces duplication of cache-related fields while keeping cpuinfo_or1k
> > > extensible in case more cache descriptors are added in the future.
> > >
> > > This implementation is based on similar work done for MIPS and LoongArch.
> > >
> > > Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> 
> > > --- a/arch/openrisc/include/asm/cpuinfo.h
> > > +++ b/arch/openrisc/include/asm/cpuinfo.h
> > > @@ -15,16 +15,18 @@
> > >  #ifndef __ASM_OPENRISC_CPUINFO_H
> > >  #define __ASM_OPENRISC_CPUINFO_H
> > >
> > > +struct cache_desc {
> > > +     u32 size;
> > > +     u32 sets;
> > > +     u32 block_size;
> > > +     u32 ways;
> >
> > Considering the changes below to add cache available checks, maybe we
> > want to add a field here, such as `bool present`.  Or a flags field like
> > is used in loongarch?
> 
> I assume cache_desc.size is zero when the cache is not present?

Yes, good point, would be clean too work too.  I was not too happy with using
cache_desc.ways as is done below.  Also there ended up bieng 2 different ways
that were used.

I am happy to use size too, but I think checking the SPR would be faster or just
as fast as using the struct.  I am not too fussed either way.

-Stafford

