Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5C3431E4
	for <linux-openrisc@vger.kernel.org>; Thu,  8 Jan 2026 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861719; cv=none; b=WmAwV5GWCzXakPYSVfR4Rn2LfmR989VfB00evn4yePrDkOY7R/vXdFmP+IXqL0WfGCMqeU3bIXcIZe9Vq7vPlHOgRrPCRoZALhb9Byry+kHFonevZJuSgr2jKm2EO5tFx7HFEwPO1nhR2jmMSEP+qptgPAx783QvcFbVNqPKclU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861719; c=relaxed/simple;
	bh=9X/r2vj38C7ckuEFNFkLLoQCe9ZxM5qmA8RkRgtPHu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUZyMR9tRaXd9sxkAVS92+1ViXtsFIlixytpEslcmlsblAXl4hSbGbr3p0haVZZ8H7w+qi2XVgsGsJ8iirT4ANBMXNTUkcmqjv9NdwnIqdH2IfvkhyCl0k7y4qKs01Hi7BXcFW3gQ1RhFst5JFcQ71464ZQKpESSH3Tb1AvO0TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-559966a86caso869062e0c.2
        for <linux-openrisc@vger.kernel.org>; Thu, 08 Jan 2026 00:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767861710; x=1768466510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xns/JPqML0qCztDyyCuldpapQdflbeNCjFZrnYmJiTY=;
        b=rICSq8+rMqeLPYv80RDeYphDTuF5zgNQiHm0oaE8Gioiq8A4bmqsPDmI6RK71Soscs
         iYnBvr0IRhZiDGsCfU5yNE7jgspK3hiVW3UN+fvaeQ+doGGSH22sRrtJcM8YdVsOVyiz
         Z0E7j0o7Hjurw+VPq0d40g+bIS6WD7OEKe3jpXEC7T+Y416LtMj5DJUoYfc5K0whp1Mc
         FAQ6FrrgpI5Oiwso74igr07FtWEm4QyEVLHMV//LTulNtFI5Y+vGEHZBoPqnfiACLd++
         5s4bKuO/bCS2zgwS3OUeePp7SGuGlQTBV4L8LDlDC2wJt7ayDpJPEZfJmTsFWigoLzBZ
         ZwWg==
X-Forwarded-Encrypted: i=1; AJvYcCXJFgmipXr/VNX7pxY25TmNfLWEPcgPtBZL3QFqL852HY87yx2oRZIOSctjB+7N796GCg984Ycmb9PtddgUfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGKoC5fd++YnGCgk/xBNhqoE8NowAlUEDW+/A0owj0azq5bt5w
	aEg/Zho03ngs1TJH7asvlsTRHoHuWsNhfzMDPLLhLOmdru+Kx9nDRIO4o7r5hZzR
X-Gm-Gg: AY/fxX7LIk44WssPk2QJwKGrNV1DFMQFr/pIU/p1qX/hmH99d3Y/39m6zMyVEABrhgf
	mQtOgU9kAUisyzfDoczHs5+thfv8LBixxWDYlARNn+VnxC+VfNCYyhz+563plwRlzpRMSIkqQGq
	wZUGzuIyMkgqzAE9dLkt+q++gFjZjiYrlqEi2kYUDx3P3Z88OrMfUbR1c8rBQ37GYIknanpfaZN
	9AAwPYtF4CCVTIAhPfhoLcVBa9FvVTiH4BzGPJVtzwZuBV1/MHov3xhS7srSwje0zFARgxU8un7
	JdHC+/Sn7+h1LwOjYqyM8pvJ3/5M3jFVeexW/7nviiPxSz5gwoI4P2cep7/KpdNlLYzkNX92anG
	fZDl+N3CHEm2XoFHmzCZmKH+J8EiF2r7fpHt/tsDpI5s3Ff/iBO1nZr4mk1qc63J97Fro63p9SA
	orHLyQxF+rHX9IPFyMWTHfNwZ6+MPqDMMux8/sqdPDdKrxrYrklJzWCDDISio=
X-Google-Smtp-Source: AGHT+IGTaY5EtfV3WCKjfOXq7j7ZW1OLvlgHImCSgy+Xz9KcJEjoHiV2zYxM5IjIPW85wU5FgFQyQA==
X-Received: by 2002:a05:6102:c08:b0:5e5:f9c:ddd5 with SMTP id ada2fe7eead31-5ecb68584ebmr1820274137.14.1767861709539;
        Thu, 08 Jan 2026 00:41:49 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944124c452asm5168053241.13.2026.01.08.00.41.49
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 00:41:49 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-93f5774571eso929135241.1
        for <linux-openrisc@vger.kernel.org>; Thu, 08 Jan 2026 00:41:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGyOxT9JSrI2q+H8BfDyMX7dIREKkKtNX5hPSovbHLAEwtfWnrYCdCOgBwKSt5ekf6fFKjKjbD4xWe+IS4FA==@vger.kernel.org
X-Received: by 2002:a05:6102:cc8:b0:5df:ac57:b0ea with SMTP id
 ada2fe7eead31-5ecb68565afmr1696181137.10.1767861708843; Thu, 08 Jan 2026
 00:41:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217080843.70621-1-shorne@gmail.com> <20251217080843.70621-2-shorne@gmail.com>
 <CAMuHMdUaO_PwWygW8qss47W_ErB4pm1Z2HQ+edvw1-x7ce7oKw@mail.gmail.com> <aV9o1LL0Ahip0O3-@antec>
In-Reply-To: <aV9o1LL0Ahip0O3-@antec>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 Jan 2026 09:41:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXYCNR0ANn152ghFExpWY_yZ5+kyFGGRwA+X-EFUvxZXw@mail.gmail.com>
X-Gm-Features: AQt7F2qP9J__FZqrZLV9_WL7FjGfkbxAjWs5PQwA8dHfLG4zYdATwoLKEBlozis
Message-ID: <CAMuHMdXYCNR0ANn152ghFExpWY_yZ5+kyFGGRwA+X-EFUvxZXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: Add compatible string opencores,gpio
 to gpio-mmio
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux OpenRISC <linux-openrisc@vger.kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Stafford,

(reviving linusw)

On Thu, 8 Jan 2026 at 09:20, Stafford Horne <shorne@gmail.com> wrote:
> On Wed, Jan 07, 2026 at 03:35:45PM +0100, Geert Uytterhoeven wrote:
> > On Wed, 17 Dec 2025 at 09:15, Stafford Horne <shorne@gmail.com> wrote:
> > > In FPGA Development boards with GPIOs we use the opencores gpio verilog
> > > rtl.  This is compatible with the gpio-mmio.  Add the compatible string
> > > to allow as below.
> > >
> > > Example:
> > >
> > >         gpio0: gpio@91000000 {
> > >                 compatible = "opencores,gpio", "brcm,bcm6345-gpio";
> > >                 reg = <0x91000000 0x1>, <0x91000001 0x1>;
> > >                 reg-names = "dat", "dirout";
> > >                 gpio-controller;
> > >                 #gpio-cells = <2>;
> > >                 status = "okay";
> > >         };
> > >
> > > Link: https://opencores.org/projects/gpio
> > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> >
> > Thanks for your patch, which is now commit f48b5e8bc2e1344f
> > ("dt-bindings: gpio-mmio: Add compatible string for opencores,gpio")
> > in gpio/gpio/for-next.
> >
> > > --- a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> > > +++ b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> > > @@ -18,11 +18,16 @@ description:
> > >
> > >  properties:
> > >    compatible:
> > > -    enum:
> > > -      - brcm,bcm6345-gpio
> > > -      - ni,169445-nand-gpio
> > > -      - wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
> > > -      - intel,ixp4xx-expansion-bus-mmio-gpio
> > > +    oneOf:
> > > +      - enum:
> > > +          - brcm,bcm6345-gpio
> > > +          - ni,169445-nand-gpio
> > > +          - wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
> > > +          - intel,ixp4xx-expansion-bus-mmio-gpio
> > > +      - items:
> > > +          - enum:
> > > +              - opencores,gpio
> > > +          - const: brcm,bcm6345-gpio
> >
> > What is the rationale behind using brcm,bcm6345-gpio?
> > Given brcm,bcm6345-gpio has 32-bit registers, while opencores,gpio
> > has 8-bit registers, I doubt the latter is compatible with the former...

> I was following what we did for uart, where we have
> "opencores,uart16550-rtlsvn105", "ns16550a".

I assume the former is a 100% compatible plug-in for the latter.

> I am using brcm,bcm6345-gpio to match the drivers/gpio/gpio-mmio.c driver.
> The opencores,gpio is compatible with the same driver as brcm,bcm6345-gpio but
> not 100% the same as the brcm,bcm6345-gpio.  Since the device tree allows
> configuring the gpio-mmio driver to make it compatible with opencore,gpio I
> thought this would be OK.
>
> I switch the size from 32-bit to 8-bit using the reg = <* 0x1>, <* 0x1> setting.
> Also the reg addresses of "dat" and "dirout" are different for the real
> brcm,bcm6345-gpio.
>
> brcm,bcm6345-gpio. Example:
>
>        /* GPIOs 192 .. 223 */
>        gpio6: gpio@518 {
>                compatible = "brcm,bcm6345-gpio";
>                reg = <0x518 0x04>, <0x538 0x04>;
>                reg-names = "dirout", "dat";
>                gpio-controller;
>                #gpio-cells = <2>;
>        };
>
> vs opencores,gpio Example:
>
>        gpio0: gpio@91000000 {
>                compatible = "opencores,gpio", "brcm,bcm6345-gpio";
>                reg = <0x91000000 0x1>, <0x91000001 0x1>;
>                reg-names = "dat", "dirout";
>                gpio-controller;
>                #gpio-cells = <2>;
>        };

Exactly, the register space and register widths are different

> The opencores,gpio setup does work.
>
> Now that I think about it, would it have been better to just add opencores,gpio
> to gpio-mmio.c compatible list?

I think that would be better.

> If so I will can revise this patch and add patch to gpio-mmio.c.

DT maintainers: Given gpio-mmio is that generic/simple, is there a
specific reason there is no generic "gpio-mmio" compatible value that
can be used as a fallback, avoiding the need to keep on adding new
entries to gpio_mmio_of_match[]?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
