Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB87E4400
	for <linux-openrisc@vger.kernel.org>; Sat,  3 Jan 2026 06:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767420829; cv=none; b=lXNAYzUlgjJUbXGze9VAF2LjS0b1DYCbdLl5hCrkoYgt2uPME4gAWqc4uFPOmUn6e0625ecOrQX18ejQjQK6r6jNh12HsymLUkotqW8ekkcLxHEFAoicBYpozw4xsjQ0qbc6H7LcP93CfzGf0ZZobdOZcBgDZlo0Oax6aIY50r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767420829; c=relaxed/simple;
	bh=97zCHu7eDEq2wSCao5W99k8eHqOyXhfcBG8VjAc7L1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf6t+9Gb/VbrOIj8C0Ztd0Ioucwcwjefd835y4YLe40SH3lbvGjomlfTuxTPTmwkq1uhERVN/k/cNH+IvLMB5zjQpqAehxRZOOpEcaKCkm6KOsW5rQ87Hnp0F2zYSpdZOAnHViLNJpzWSD8yQlY7Z7s7OIwAW0yXX2fY14Lb32k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BC4sIwMt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BC4sIwMt"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so98076195e9.1
        for <linux-openrisc@vger.kernel.org>; Fri, 02 Jan 2026 22:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767420826; x=1768025626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f93gRcp6kFm4mZXOsyuiAcC5fulk1f6gnaxl8osZ7s4=;
        b=BC4sIwMtESo6+2cyWRqKp9te25YjJ1a/npPPPh2X6l2ix1dxsqgND/raQVNg357O/8
         uAMjw8Wx/NNZ3qBaCkVf2Bxtk8ewqkzOkwjzD9SxOkPDwFFU76DM/b17RGmtX/lQdhwl
         ETP7TczR+W8Yjkw8dN06+sGoKxJUxM5Brs2K5xFJO4NJBjqh0FGRSwMYN1JKQ9x9d/RA
         +3HQw0L4PYvzWrbOdennCuvR7p41KnORemt8v6loOl3YVP3ROjrtKSIpVH3cokRFWmHh
         QaRe6/rG9xdvHjghtyNy84hgmnQHDYrgN6QP2fzCCbQ+klKjWIc/GUq0BUkn14lUaeao
         021A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767420826; x=1768025626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f93gRcp6kFm4mZXOsyuiAcC5fulk1f6gnaxl8osZ7s4=;
        b=V2lFFEK5mKyKtOzrpeVmjLePiGdbRr8aIjLzf/em47EbGE8yxJGkLPbXIAEKe8Xn79
         BZJiu6ZaTEtMlqvQwN+LeEbOh0dSRLNgOCh636Y1vuCOqvYypC5vYgnLlLaksUKbHsKb
         Pvv+3N+Gnz5s3z4+ZWnE/Ztz6zZs2T7x4syWHexALMrDlZk2gMvLgstwb6lldRL098p1
         b0TRfVUl5aHSaVIwpnX3fli1qaFq58WuaSAVjuGA+NX7aSsJ0ni9K9uzNGPhQjQc7WeA
         DwNll0YUzFTysHCf5iv+vdOiYoS2VicpfCSrMt5v5ZuMBl5CGtycm5F5aAkMXLekFvRZ
         zr0g==
X-Forwarded-Encrypted: i=1; AJvYcCVQFyN62xuY9I1E1Gj9HjKO6edmP8B8Zm88GLFkFWs7Lbd5MPb2mBT4hmHL1FRfuA1almR7xFFOFXrCbFkGVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzM9S4UEq46DXY+eZNEMQLmwbzIlRs8YgLQ/0p+5Fem+OTpwxYs
	5caYd9X+BxlLQ0oo4u3QeTrlbtrAEr8mtwhvzETZltBzqFogmoETNN7rfSrJRw==
X-Gm-Gg: AY/fxX5mocV45Xf2UAXYicbfRlQXwm0o4C2f9EApGgdP+vE26x5O4In0Bg4MTRxg66H
	H6wgXafPKbuXiEIRGeN8EUH5g6goclXtvS6a0qtpnaWRu32NgmuYg6kHRA0W3C8c9njdX0IntzI
	3A3xkZOS0hZaT9VyBPjH1Xobqlpt5tjBhthNdZJSI/1CWqYM99n7BFGq3nH6PJgbBWU8fKSK2zW
	62DQwR0Mgl+y5ix51N8arkAjfdW3ZqQmXsSHvwZS11mI6r4S64GwzVjsdYnA2TptOJXYQi9P33i
	cqpAs69fZf5sDjcNe4suJNim2daezk1yHzhIa4I4qpip4dDaBH6E24zjgpwzY6q1nhu4qgCalOu
	tB7yZK4BrR5iFO8dGZEkEeEWL+wBnMwXcRiQI6dj35CRZVNFwhXLb6amY7WHU2TIXubzQB3ZTMu
	mXCmNjQbhFW8k3cPCVO3Er6VoYzhOwN/Fr8xaq4fVR9iph4cN56PDsg32hJCnVTauO
X-Google-Smtp-Source: AGHT+IEqhEgz23pqULZ0/FEYqnsvhRaMIkKcIDkLAcEj5jOi/WXFwnkZTsPfb8puSZIbrROIMKx2NQ==
X-Received: by 2002:a05:600c:4446:b0:475:e007:bae0 with SMTP id 5b1f17b1804b1-47d1956f896mr560090725e9.16.1767420826016;
        Fri, 02 Jan 2026 22:13:46 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea82f6asm89934101f8f.27.2026.01.02.22.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 22:13:44 -0800 (PST)
Date: Sat, 3 Jan 2026 06:13:44 +0000
From: Stafford Horne <shorne@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Masahiro Yamada <masahiroy@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/5] openrisc: dts: Split simple smp dts to dts and
 dtsi
Message-ID: <aVizmEcLSgD_Sgwj@antec>
References: <20251217080843.70621-1-shorne@gmail.com>
 <20251217080843.70621-5-shorne@gmail.com>
 <CAMuHMdXG2HQ8e+Hx1CUBus_VYKmx4fEeDRH+sDXmaQQANTraBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXG2HQ8e+Hx1CUBus_VYKmx4fEeDRH+sDXmaQQANTraBg@mail.gmail.com>

On Thu, Dec 18, 2025 at 07:37:43PM +0100, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Wed, 17 Dec 2025 at 09:23, Stafford Horne <shorne@gmail.com> wrote:
> > Split out the common memory, CPU and PIC definitions of the simple SMP
> > system to a DTSI file which we will later use for our De0 Nano multicore
> > board device tree.  We also take this opportunity to swich underscores
> > to dashes as that seems to be the more common convention for DTS files.
> >
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> Thanks for your patch!

Thanks for the review.  Sorry for the delay my home server (internet) went down
when I was out of the country and I didn't fix until I go back.

> > --- /dev/null
> > +++ b/arch/openrisc/boot/dts/simple-smp.dts
> > @@ -0,0 +1,25 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/dts-v1/;
> > +
> > +#include "simple-smp.dtsi"
> > +
> > +/ {
> > +       model = "Simple SMP Board";
> > +};
> > +
> > +&cpu0 {
> > +       clock-frequency = <20000000>;
> > +};
> > +
> > +&cpu1 {
> > +       clock-frequency = <20000000>;
> > +};
> > +
> > +&serial0 {
> > +       clock-frequency = <20000000>;
> > +};
> > +
> > +&enet0 {
> 
> Alphabetical sort order?

Sure, I'll fix, I didn't know all of the conventions, thanks for pointing out.

> > +       status = "okay";
> > +};
> > diff --git a/arch/openrisc/boot/dts/simple_smp.dts b/arch/openrisc/boot/dts/simple-smp.dtsi
> > similarity index 90%
> > rename from arch/openrisc/boot/dts/simple_smp.dts
> > rename to arch/openrisc/boot/dts/simple-smp.dtsi
> > index 71af0e117bfe..2013fd3e7a18 100644
> > --- a/arch/openrisc/boot/dts/simple_smp.dts
> > +++ b/arch/openrisc/boot/dts/simple-smp.dtsi
> > @@ -1,4 +1,3 @@
> > -/dts-v1/;
> >  / {
> >         compatible = "opencores,or1ksim";
> >         #address-cells = <1>;
> > @@ -22,15 +21,13 @@ memory@0 {
> >         cpus {
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> 
> Missing blank line.

OK.

> > -               cpu@0 {
> > +               cpu0: cpu@0 {
> >                         compatible = "opencores,or1200-rtlsvn481";
> >                         reg = <0>;
> > -                       clock-frequency = <20000000>;
> >                 };
> 
> Likewise.

OK.

> > -               cpu@1 {
> > +               cpu1: cpu@1 {
> >                         compatible = "opencores,or1200-rtlsvn481";
> >                         reg = <1>;
> > -                       clock-frequency = <20000000>;
> >                 };
> >         };
> >

Thanks,

 -Stafford
