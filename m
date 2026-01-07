Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1E230CD91
	for <linux-openrisc@vger.kernel.org>; Wed,  7 Jan 2026 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796561; cv=none; b=tUEsfJlKkhFHgMXxDxwFtsgXh06NLCbmtV2Tf5kOvzqNXAU8ugQXTWcHH0n6nSAGBZNzxiYZfPcz/0siRra8Io+vdPb1eKvYsDlQKOcbRXRt4T18rSZJpX8GX7kMLPu948En/wrNrIaQDZO+u6WVZGgmXnMHIxxgKtWGeoaMxhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796561; c=relaxed/simple;
	bh=6lxm2yCRzymiJ3PB8Ax4dTtiSd5+d+ADW+gyDpHpCqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITlog6JHv59j/SPHPI4jyusb6+j/qK4Dw3x3+z9ff7ztC5HlxC2jw0LrzRMyiVPV/RiQeRnScZvZ9dRM0D8pQcpDh+Qz77VJGHl4sWGozmYGFwdQkxLRfHUrY3SI/3VeTlQrJQEuyw8pXtZuIjzOt8QDGg10zL11W1aSLnaxNDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-55982d04792so1453924e0c.1
        for <linux-openrisc@vger.kernel.org>; Wed, 07 Jan 2026 06:35:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796558; x=1768401358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCG+VCgfKP1d5FB1FIYpGKsmNdPDYa7lbTJ3VDOVxBg=;
        b=JW7wh/ce9uOEciAfP+xFoZK4lJ1agoAwei85HDo3jsIKw24gZ95RDP7iqT9xBYwJ0D
         L1TZkLF5VZ6g7fSORaZx3C5QqWFoNzCFeBa3jKhaYW/wjkRFR0rLH4rF/GaNSyB1Hn4o
         oybG3WuDhCpzSAXo+939hLTJ2oqq5DES7Nm8l3hA9UM1KTakZex2I4yJ7vscxw+PC44e
         WXlVHqqQ/glWCL7MB3xf9gtKio7yQz6uQ8o0DFyxLAGqUd2Kas9ZyqCxLJqt9pRb1x2S
         SD4H3kIwIR4wyZBqXnLbLxLPDXpZ77ipWvLA6ZxgY1pbF7g5uprmtT3b2i42vhmEmaMH
         BZDw==
X-Forwarded-Encrypted: i=1; AJvYcCVnipcgJ8rv7hXIFfTZnVUnwz6jlu/eN3gg0ftWilHgmvZUEt/UPyKule/B42fPIuF7iIUkuxTHNzR+XbNSVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxbmH2npLPHxLuYMvhMDfSzk7AkbbOQzn/sGJfA9YSw2OS2SYo
	IU9RMjc1dYE2w/GW3RtANLNqbHNvmJv6RDWfelq+BS38b/a+qf3qNC7NyYbb0+6k
X-Gm-Gg: AY/fxX6Z+h5bO9tTtbjCeqdQsPL7EDVk9Dd2vfllglttPMHX7KAhQKbYlHUcxO6niy4
	fMzO4PRnfwTtPKvTQNI0Qt1sVDto67uAecHvVBvlquALEPFYl7LodGIe2bQDxqm/Vjsv+4C/51D
	EfZzxDXSPtsZteo73RcXjssPgEmVLXjkP2cYZca/nRE8o+D0e5lKSzUek0QjkZlQvxaJVCbI3aG
	e+HbJtB9d5GsdA2omDY8OLDACBT+wwSZ8ShggjmB0xKQ0An98vHHRB7/gCAfuw2PfkZ61uLBPJT
	nzH4ARsZGLzHzHsnmQKKS7cnjNii2dbPv2e68bfZjZUm60I4LSVxRmM6X3xDSX2mf0wfp63a0eN
	1Wy/cux4nwgQd7xYRUEOfXIVJbGfeakrbBp7QWjAmPqtf4r1W6Ncpq6RAMuFZqDPUm9o+uOX0AS
	mVHXr1ViqVePEI0Q2rmUshDIcjRclWZHepdBrOGEfL5/NiDlAZaAhP46bQx+Y=
X-Google-Smtp-Source: AGHT+IEGUfr0AEfF1OgxzXXa8PO8qKbTUzY+vo9mJLV1x4KByroSjVHz/BT8V88SIp9p8pr3p+t6xw==
X-Received: by 2002:a05:6122:31a5:b0:55b:7494:177b with SMTP id 71dfb90a1353d-56347fcaa6cmr851463e0c.10.1767796557728;
        Wed, 07 Jan 2026 06:35:57 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944121ef3fcsm3000735241.0.2026.01.07.06.35.57
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 06:35:57 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94120e0acbeso1205491241.2
        for <linux-openrisc@vger.kernel.org>; Wed, 07 Jan 2026 06:35:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIc8LgrJFxUl4CwV4IFUTcmTRp8DicRMTRNi09Xa0Xaq715XclkbuhEs0dVPGil1NttXuzSD6pkyRUMXGdiw==@vger.kernel.org
X-Received: by 2002:a05:6102:5695:b0:5df:bddd:b590 with SMTP id
 ada2fe7eead31-5ecb6905a3emr1117507137.34.1767796557085; Wed, 07 Jan 2026
 06:35:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217080843.70621-1-shorne@gmail.com> <20251217080843.70621-2-shorne@gmail.com>
In-Reply-To: <20251217080843.70621-2-shorne@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Jan 2026 15:35:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUaO_PwWygW8qss47W_ErB4pm1Z2HQ+edvw1-x7ce7oKw@mail.gmail.com>
X-Gm-Features: AQt7F2qBJgoY9l-u0hf_v_IupX5oD1Vi4qcbhjbPDLtZk-LVqqhekrQVxBOS6ug
Message-ID: <CAMuHMdUaO_PwWygW8qss47W_ErB4pm1Z2HQ+edvw1-x7ce7oKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: Add compatible string opencores,gpio
 to gpio-mmio
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux OpenRISC <linux-openrisc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stafford,

On Wed, 17 Dec 2025 at 09:15, Stafford Horne <shorne@gmail.com> wrote:
> In FPGA Development boards with GPIOs we use the opencores gpio verilog
> rtl.  This is compatible with the gpio-mmio.  Add the compatible string
> to allow as below.
>
> Example:
>
>         gpio0: gpio@91000000 {
>                 compatible = "opencores,gpio", "brcm,bcm6345-gpio";
>                 reg = <0x91000000 0x1>, <0x91000001 0x1>;
>                 reg-names = "dat", "dirout";
>                 gpio-controller;
>                 #gpio-cells = <2>;
>                 status = "okay";
>         };
>
> Link: https://opencores.org/projects/gpio
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Thanks for your patch, which is now commit f48b5e8bc2e1344f
("dt-bindings: gpio-mmio: Add compatible string for opencores,gpio")
in gpio/gpio/for-next.

> --- a/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
> @@ -18,11 +18,16 @@ description:
>
>  properties:
>    compatible:
> -    enum:
> -      - brcm,bcm6345-gpio
> -      - ni,169445-nand-gpio
> -      - wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
> -      - intel,ixp4xx-expansion-bus-mmio-gpio
> +    oneOf:
> +      - enum:
> +          - brcm,bcm6345-gpio
> +          - ni,169445-nand-gpio
> +          - wd,mbl-gpio # Western Digital MyBook Live memory-mapped GPIO controller
> +          - intel,ixp4xx-expansion-bus-mmio-gpio
> +      - items:
> +          - enum:
> +              - opencores,gpio
> +          - const: brcm,bcm6345-gpio

What is the rationale behind using brcm,bcm6345-gpio?
Given brcm,bcm6345-gpio has 32-bit registers, while opencores,gpio
has 8-bit registers, I doubt the latter is compatible with the former...

>
>    big-endian: true
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
