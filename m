Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9A82F28
	for <linux-openrisc@vger.kernel.org>; Tue, 11 Mar 2025 22:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741731440; cv=none; b=a4JHcAHuYRCIK71N5R9f1DJxq3qcnqRyTjRWpq0EqVhcRl1hgc//oJXkJMdn3lJFvMcKEnSNVpxemQkwIE7Q52sCr5rXXxX3NEtSSbtMVgP7ogrqjnJmqk1r3j6oltW7GwEsGUznaMbWfcz0ovLsbSUxPYwb4mVqFETN4yETVkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741731440; c=relaxed/simple;
	bh=NQ/n7zpRQaCuYQsZZPiur/Rq0wkra2uLhIQkcWcIsVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaRN3FCUC5wQCcCw93w6Wp4auUD08iioNdMPK+nCrkTWMgh9HSNmrYEiNu7dRoHRHXPHgm0s19caC5CN4OnYe+ZrzEAt2dgrJjdV9lyDW6r6abj9hpQ8XZY/5x0asZD1elpAlGpKZhnGtxIn7g2ojs8YSWAOY60XuM7/oysikPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBQAQieo; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBQAQieo"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-391211ea598so3353308f8f.1
        for <linux-openrisc@vger.kernel.org>; Tue, 11 Mar 2025 15:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741731433; x=1742336233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4tRH4QCT5VzCl3Ci5EmpPIkejrzDkyp4mIn3x3FjVKw=;
        b=MBQAQieo6TAXwhYT0CxHOKI6jphfxHF7GmU0rfcxZxFQPknvWqalqZdpECXl8DMPbC
         y80H/imkQ0vMKdM0wLnAfQ9X+vKZu22iDV93fs5u/xRZ/NEX44AOSuAcNNj8erUiNML3
         9Xzq3Z5diThGvwNKsj2O5VdUhUtra5BYb+mikLKjUe7YAhOt9dIdOvCrYZD3vGveRwcj
         HxKewqzqgg2yjSBbnvnZJ0Tz6MYFsyvaB2ELsJbm/E4dk9eFO6H/nGSoUVKxjAPofJLx
         E/U4dIsb+oSs0rXpnCgszFx1C+8D8ihpKuwnHnRhBpAEgeWi1In8F/bHCC5hNnbOgWn5
         pxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741731433; x=1742336233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tRH4QCT5VzCl3Ci5EmpPIkejrzDkyp4mIn3x3FjVKw=;
        b=VvTEMvWXerAvpj0+LoBbnNkpKcJBzOKz5ZEd/Apv/6q3viRZj5IgZ8yU5i6HZy0tWs
         j5JE93EmVNSgUXZOIhUbXVl1nSZpSeooRtWzamieOQjo4/GVv0JqQScAhfmNHXWfdHII
         lO9M8rTbc7jB/Z1DoTpEP9WaOLPgSekSEWAp9EuJH+7gckdrOaGNQ/zwn6fEhdT4VWXP
         RQXWjuSX6R+U96dTUJv8znSMueI/tK8fZoXSC3j1FX74oRFNAiDdHc4yGw8yz7MiDmuW
         SXPkw0fKim28GzZdOe04cYxJAgcqXAiAUYwAEA8ce+cURj25A/K2d2Y8N/372ZkAh9+k
         bElQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxYKU5f6C+fkA/U3V2WDh+JL9J4wh4A7WU2x4XhKIDRN6/eaZrXlOmzxGn2Lhw/vuo1R4sAF3kqo3/whgGoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo5MtgE9PIpDgn5oqc8cAtKE58dhBKZfV0svgIc/K5yo9fGXbK
	uYD8dskCI981jNa+rnONCrw7JtmTDeR+Pib7vuQJVntYUE5Va6yJ
X-Gm-Gg: ASbGnctJigX7l2I/szyXi4lZBPm8bHrLNulmv2t4I7LwzsZmArDxtppVvNFIozXloZz
	1WMkR5oeenDbxqvgRC9A3w1hqv3xiEneSbKFdX0IBsewlzljV5ZyPDBgx1wb1qyvaBy8/C9CeR5
	dVrUMfUVasFMT+zfqu0BHe0BFS/yEwzX5+gLMxIIx2EGSWFm0zL9OZgFGu/UTNijTNWLc/s3qDV
	T+IxWsGruXZaJdo9fEuPGVelgssp9ifHqTO2zVuleHTnLFUpJVkT/vkFD9PFdE+N2TW6CgoAf9b
	3JSJ5PA+kLEOnT0OkrqVYZnh/iyxOvky42R+cVA/8esB4Vf8K9nsOD7P/9r6iRMjYI+7RH7iCpE
	3HxvTtOZF
X-Google-Smtp-Source: AGHT+IFDGx+qRfXzE/Utu4mV4xZAgW8xNh6JDWZcH58KTwh7DAVjrP8oCMSiBRv5uL9P97myjcltNg==
X-Received: by 2002:a5d:5987:0:b0:391:2bab:d2fd with SMTP id ffacd0b85a97d-39132da96c9mr15704207f8f.37.1741731433246;
        Tue, 11 Mar 2025 15:17:13 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2b6asm19534642f8f.66.2025.03.11.15.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 15:17:10 -0700 (PDT)
Date: Tue, 11 Mar 2025 22:17:09 +0000
From: Stafford Horne <shorne@gmail.com>
To: el 01 <quantumleo78@gmail.com>
Cc: Idzwan Nizam <idzwan.nizam@yahoo.com>, linux-openrisc@vger.kernel.org
Subject: Re: Performance improvements of Marocchino implementation
Message-ID: <Z9C2ZSpretIpZ2DL@antec>
References: <810295975.3514440.1740967866807.ref@mail.yahoo.com>
 <810295975.3514440.1740967866807@mail.yahoo.com>
 <917f2fb4-adf1-4c1a-a268-8229a90161db@gmail.com>
 <4da2a6d4-bd1b-4043-92fe-4c16d2313a31@yahoo.com>
 <7084228c-23a1-45f9-bb58-8c85c1ae13f0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7084228c-23a1-45f9-bb58-8c85c1ae13f0@gmail.com>

Hi Idzwan,

I noticed you reached out on IRC, if you want to join OTFC/#openrisc
we could chat there too.  I am not around much there as it has been really quiet
recently but its also available.

On Tue, Mar 11, 2025 at 04:00:23PM -0400, el 01 wrote:
> I defer to Stafford's judgement, but please don't feel an obligation to
> continue exactly where I left off. If you want to work with FuseSoC only,
> that should be fine.

I thimk using fusesoc is a good option.  But ideally both fusesoc and litex
would both work.  I think whatever you are more familiar with is best.

-Stafford

> A bit of advice in advance -- I didn't write a script to batch run tests on
> FuseSoC. I instead ran each of the binaries individually by invoking
> ``fusesoc run``.
> 
> On 10/03/2025 06:09, Idzwan Nizam wrote:
> > Would it be OK and consider a progress if only FuseSoC were used?
> > 
> > On 10/3/2025 1:02 am, el 01 wrote:
> > > Hello,
> > > 
> > > Hopefully this makes its way onto the mailing list, my previous
> > > email didn't.
> > > 
> > > Stafford's previous email basically covered what I did last summer.
> > > I've been dealing with some health issues and haven't been able to
> > > consistently document my progress; really sorry about the lack of
> > > documentation.
> > > 
> > > I left off at trying to figure out some (perhaps superficial)
> > > differences between measured cycle counts when running a benchmark
> > > on LiteX and FuseSoC, two different 'build systems' for the HDL
> > > design. This doesn't directly address the discrepancy between
> > > marocchino and mor1kx, but was a step along the way.
> > > 
> > > The build systems bundle the OpenRISC core with some other necessary
> > > hardware (e.g. simulated memory, peripherals, etc.) and build either
> > > a binary for simulation on your computer, or something which can be
> > > put on an FPGA.
> > > 
> > > When running binaries from the Embench benchmarking suite on the
> > > same processor core / simulation engine (and only changing the build
> > > system), there are some tests which have substantially different
> > > cycle counts.
> > > 
> > > Some initial data I gathered will be attached, it seems like there
> > > are some substantial differences in the cycles required to execute
> > > some instructions on LiteX.
> > > 
> > > I'm also not 100% on whether the measured cycle counts are
> > > completely accurate, as the debug / trace parts of the LiteX and
> > > FuseSoC are somewhat different.
> > > 
> > > Another minor thing that I wanted to address was some inefficiency
> > > in running LiteX simulations. Because of the way that the Embench
> > > testing script for LiteX works (see
> > > https://github.com/hhe07/litex-esp/blob/ main/sim.py -- from what I
> > > remember this is stuff that you can copy into your Embench install
> > > folder to enable compatibility), I think the CPU and some of the
> > > supporting software is rebuilt every time a different benchmark is
> > > run, which wastes a lot of time.
> > > 
> > > As for where this fits into the larger issue of the performance
> > > discrepancy between mor1kx and marocchino, (in my opinion /
> > > experience) I spent a lot of time trying to figure out the tools and
> > > determining if what I wanted to do was a feature of a tool or
> > > something I needed to figure out. So, I'd recommend trying to
> > > understand the tooling and perhaps doing some practice tasks around
> > > it. YMMV, though.
> > > 
> > > I know I haven't really made this problem better due to poor
> > > documentation on my part, so please email if you're unsure about
> > > something that I did. I'll try to reply ASAP.
> > > 
> > > As for the attached files:
> > > - profile.ods includes analysis on cycle counts per instruction for
> > > one test, I think nettle_sha256. This is for the mor1kx CPU.
> > > - results.ods includes cycle counts for all Embench tests run on
> > > both FuseSoC and LiteX, and calculated percent differences between
> > > the two.
> > > - nettle-mor1kx-{fusesoc, litex}-trace-prof include the outputs of
> > > cycle counts from the analysis scripts I wrote (basically same as
> > > profile.ods), as well as some additional information on the PCs of
> > > the start/end of critical sections in the code, and how many cycles
> > > they took to execute.
> > > 
> > > 
> > > ~ Leo
> > > 
> > > On 02/03/2025 21:11, Idzwan Nizam Jamal Abdul Nasir wrote:
> > > > Hi,
> > > > 
> > > > I am interested in OpenRISC Benchmarking and Performance
> > > > improvements task listed as one of the project ideas in Google
> > > > Summer of Code. I am unable to participate in GSOC but I would
> > > > like to contribute to the task gradually as I acquire skills in
> > > > digital logic and computer architecture.
> > > > 
> > > > Is the task still open? I would be glad if you could point me to
> > > > the right direction such as documentation I should read or tools
> > > > I have to be familiar with. Any guidance is welcome and greatly
> > > > appreciated. Thank you.
> > > > 
> > 
> 
> 
