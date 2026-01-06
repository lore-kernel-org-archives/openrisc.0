Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469E630ACE5
	for <linux-openrisc@vger.kernel.org>; Tue,  6 Jan 2026 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767693296; cv=none; b=lhL2kQAPrxLUQx0MTBjgKx/sZOvZAt0CSKbI27ZuW4MEZWoY+cPOtJEGh6OQbPXlVLzQJcS17cNG7zzDJzWbaTWk1TewkbJk8bZjVcIFYUU48BHuU/3Sqr23lqVN+KUS/fi3I6TrE5tFqq2owCTR5X6pEc7mAanvKzbdHuVcGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767693296; c=relaxed/simple;
	bh=5HyOBWBq82UrImMpRRqu650sPUIH25jx7IsXi5sJIxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thSHk+WMaARLS8I1+6+t8wz0/xVpz7TzPeylkRSHFu6U0EP7OkY7exfBc6WG8cTvJ40l4PQTwvbyf72YViXHRukpsdi5ePx/YyGsmXQoCYHF0xcFwWODS+TiFLWm8uFOZUR84ws5car6jQaJuGLYCVskasgkVJNakwrj8Z6j1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I086Xbre; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I086Xbre"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47774d3536dso7258545e9.0
        for <linux-openrisc@vger.kernel.org>; Tue, 06 Jan 2026 01:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767693292; x=1768298092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xtIuNs/eQByqyQaTUCgj2PyZmNyYspsThl1lmxuCUqU=;
        b=I086Xbref/Y3JoHRbK9OOQ6dw/93IpZ9IpkBkgCQVw8DeuLXFnmu6E518gW2tyCESi
         /7tXZR26DTYNoPjVI4Dj+xZ+rwU/+vEzXEHDJGZNpja8YF3fD2j7z6VMCvikrI++HX0y
         h+tcmMNIaWfWWk9vfmex21ItoSePhLNLT5OsyPCAD+786Wi1uxEVEU5v0AlzyMK/Ol0M
         Yf2MlZGHa8h2oHbuTAiLPSD03sCKWE3Bn2iP947eUF5elCVTLCOxyZNoxECu0fBMHNzm
         oXhAGoYZWFca6z/uK/pJGFtdNwCjuNelsiaopJSj49icIxam3puajinUFoUlCx0wW9xM
         bgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767693292; x=1768298092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtIuNs/eQByqyQaTUCgj2PyZmNyYspsThl1lmxuCUqU=;
        b=QrzlTdyVRy62Mc0RecXnXnvTjCZkkuD+F0Xt2JS54iT/SMpe4kDTBfbporYtR5p2P+
         U7lqhs/wfGa6drU8E0hd0sK9UCBr2aTx8R0Z6XbhHy6zb4F5IUWUWTeFXYprINaQ05cC
         qwj2sL8iJlcJuH/lJ4rl23MxcqtuzAa7yDorty2yakaWVetK6rXJom4Pn9nsIZUC3SLi
         PMsrJeCJWRy76kLksJ6UALk/9hqlwvCMbo2FJ4jt/sLADakqEgIEFu0/W0YYnee6rR+K
         z6bTg+EGEiOh7GohYXke3Br5MP69/TRlGaAGRe/Cmh8wLY3+vfGsXVDiMKQQkZ4GoMe7
         0GgA==
X-Forwarded-Encrypted: i=1; AJvYcCUMOd9F+rI+3HYJcJp1JiC2mxhQX9G0PDtH0yFEftaVrmstBFRVsmPmdG9YZWA59FY04AxjnAVsyRB11U/Y5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yys9w3yheAk2OI9MxQdcHiYW2dJD+v/ZB0hj1XJ8SSx1lxOz+Lk
	ZMfQjd3AyxgE2g9zlbMyr57gOsnP0BL1VAbbr+LtN896lLZMeR1MOzSi
X-Gm-Gg: AY/fxX7lvXYX8ckThTW8AaYSlQ2C6eTMtqZRM+7SMxTPcdWP2ApuROI9ZNLdOz63UPa
	9uBtvpI4vYorB0PATVl7gpHIv6+dUQ1UlcjQuDWKvhSXRRajoLV/uO1XO5i/IRTNWTJr72Kq49h
	qCSp0fQasHmDbMhD/wc3tnssT+CPv4YBgIc1ELO72SH1bjA7SUbOM9qfYhmDA9Ux1V3IoekPEyL
	U8oRl0M+sRcMvLGebuAswzW3Mz24wNIjhM1mF2MY5hW61MhlFDijpP77UWo100+OVYDcnCGFZdn
	FiK/JplsS7S2EmBWrRBm6Oqie0Ur5dFcQh9WpALpLJOhcCx2L4/ypdhbJOUxJ8UrQFZMK20yUso
	ZZW8yH9uNIPU+P7grkNi5jYYld2/hALg655RQ1VFCreLIgiK79k9A7GK9LcDMHVgT2vTB8Zldmq
	t+SSSJ4DkBiO1M0hhX2T00m/XbtqCAIcUR3knRtyiQ1LEyUSMQjoVubRmqsyrkyQG6
X-Google-Smtp-Source: AGHT+IGpM4zS6SYOiTIjdF/hysbLDFWHhIoANy7EIscVpkRt1VTLfT54CxmfhNblcCL9mNmLgsA0rw==
X-Received: by 2002:a05:600c:a4c:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-47d81589dfbmr14172545e9.4.1767693292340;
        Tue, 06 Jan 2026 01:54:52 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f390a69sm37018615e9.0.2026.01.06.01.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:54:51 -0800 (PST)
Date: Tue, 6 Jan 2026 09:54:50 +0000
From: Stafford Horne <shorne@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] openrisc: dts: Add de0 nano config and devicetree
Message-ID: <aVzb6pStdagr3IUX@antec>
References: <20251217080843.70621-1-shorne@gmail.com>
 <20251217080843.70621-3-shorne@gmail.com>
 <CAMuHMdVCY=5UypK65Ver6UZM_m6DZuw9mhfANMx4+Y6PgNAdmA@mail.gmail.com>
 <aVi0W6syzK6buL_v@antec>
 <CAMuHMdUP3z4Os=3XC6Nuzx8QAap=LTcuJrGZsy71GO=NFTOjZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUP3z4Os=3XC6Nuzx8QAap=LTcuJrGZsy71GO=NFTOjZg@mail.gmail.com>

On Mon, Jan 05, 2026 at 12:02:52PM +0100, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Sat, 3 Jan 2026 at 07:17, Stafford Horne <shorne@gmail.com> wrote:
> > On Thu, Dec 18, 2025 at 07:36:08PM +0100, Geert Uytterhoeven wrote:
> > > On Wed, 17 Dec 2025 at 09:23, Stafford Horne <shorne@gmail.com> wrote:
> > > > The de0 nano from Terasic is an FPGA board that we use in the OpenRISC
> > > > community to test OpenRISC configurations.  Add a base configuration for
> > > > the board that runs an OpenRISC CPU at 50Mhz with 32MB ram, UART for
> > > > console and some GPIOs for LEDs and switches.
> > > >
> > > > There is an older version of this floating around that defines all of
> > > > the hardware on the board including SPI's, flash devices, sram, ADCs
> > > > etc.  Eventually it would be good to get the full version upstream
> > > > but for now I think a minimal board is good to start with.
> > > >
> > > > Link: https://openrisc.io/tutorials/de0_nano/
> > > > Link: https://github.com/olofk/de0_nano
> > > >
> > > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> > > > --- /dev/null
> > > > +++ b/arch/openrisc/boot/dts/de0-nano.dts
> > > > @@ -0,0 +1,54 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include "de0-nano-common.dtsi"
> > > > +
> > > > +/ {
> > > > +       model = "Terasic DE0 Nano";
> > > > +       compatible = "opencores,or1ksim";
> > > > +       #address-cells = <1>;
> > > > +       #size-cells = <1>;
> > > > +       interrupt-parent = <&pic>;
> > > > +
> > > > +       aliases {
> > > > +               uart0 = &serial0;
> > > > +       };
> > > > +
> > > > +       chosen {
> > > > +               bootargs = "earlycon";
> > >
> > > Do you need this?
> >
> > What do you mean here? I want to keep "earlycon", and it is not supplied in
> > de0-nano-common.dtsi.
> 
> Why do you want to keep it? "earlycon" is a typical debug option,
> and should not be needed during normal use.

I see, I am always debugging so I leave it on.  But, good point for these
default configs.  I'll remove the debug defaults.

Just curious, Do you have a quick way to enable out of tree debug patches i.e.
to dts and defconfigs?

-Stafford
