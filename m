Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF5C333427
	for <linux-openrisc@vger.kernel.org>; Fri,  9 Jan 2026 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767953974; cv=none; b=aQZ9BN/Q2V1zv/H9JJDWSwl9kgKLVPQpcaNH6wa0BbjTbJs7qrs1X5vkWnazDGqDWbjLWxACXfhAx1urFelz5KBTmzkB1BI9vI/GmCVs6wMppKtTUkR3Od272k102/25dEUsBScbNHH2Q55gnATlMS4cjnw50nw6lewdb4VXaWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767953974; c=relaxed/simple;
	bh=iBgJn4Oei4MSF7wX/YOhYnpZ1nzYzLulaCt82baVuLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IY8DLGxznr0hl20QRLi/WbzfLHFixd9hrDJzipd7V3Jd7JpB3GDrTUrWw6u9roIhqu2vGWE5yz9evfC6MiF0yrnJZlG5XMfHCsBxHCJrWpByHB79iAM9suEUQzXIHOgUgWCU/+Ok1xKBE5y3haVkwWLv7Hbv+CQDz/j4fGNjrx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5636274b338so685954e0c.1
        for <linux-openrisc@vger.kernel.org>; Fri, 09 Jan 2026 02:19:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767953971; x=1768558771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=68fD+2d6dtiuvezPQdm8X6562nqf1sN2gN86wHzPt+o=;
        b=D6++xzPfcLEq+9Ny47EwKMRqghq7SbWWCxyVNvZxapm3D6z3hUEfZ/BwDh78LqniRZ
         81Tymfa+cCeS6fZ2FhRlcw2jwXmY0jbHW+pyxskC8gFVNkQ2+oXXA7DZ4ewM3JJaJiHW
         30SCfuPzedv2YXs5uNeHyrez756gMLXf6tSKwxttBhmLK2cnnI5/ItIc1mwd5k9IIawo
         wIQFMNpCwwvzk4cUMLtnXMCC+DnzDO7OPrnLmxeQoV1rjD6FpK8L4ZfYonwcFIwcsffW
         y2ZjL+GLEfCx+EG1/KoSGNEjywqHbliINExfQEojErIf2ptjT/s3teiukyEtbK30hkE+
         qjuw==
X-Forwarded-Encrypted: i=1; AJvYcCW0FmShsob/IfPJZniyJ0qyXM8QBXXNmEc5vhVQED1gjhIcFXpG/TLKpWXKUkp93xrtJ1tYldLslo8iBBq6aQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhfdpjMQ4hOo+gtAm/SMTqh6tL9P7XpxmJIO45lHONFIWfbFHg
	DxHHmqLvOQRlKXizrrGZpIQXFWutWKcZ1+l7Zjh/0MsUh8Ry21CToVBs7SNnrtVo
X-Gm-Gg: AY/fxX5nQgNErRVUt5xbRtB0t7797PtPaP1Ucy4O9aRUd8ICWUT1r/9irs8IY+/EkqQ
	RlsZovDZEb+ND4wcXjrD8eUb/QMQ1fqv9Cp84UDSTcme4T2WiTlfgYP6fZrQDvKY3ADwgiocRZ2
	1B+ayBesE+yxHW3jVqnbTnAHyDeu/nwEIO1+wxDwnq2+lVdGba1PT72ow/66qQlVd3iOXlMlUYe
	JXuR8hEkW/pVL9XFbzFUEgqAYIwrTwcT6d9j6OnwmKKVLwaRIHghD7v//FUjukMEIGazzc666j0
	1nxHS8Ur/RBdEjN9/UWEjCZ1DP4I/GiJpFwBPjNi9uxW5OLuzTYvEN1vlTijw4/4bjtvYEM2PpW
	T/bZX68XNya2QTPK2ztRfnnGdEiRiXrQm/Ec+tdVBcv3+efkT+BLkXziXnJpeH8QzD9hYOaRHve
	IyO/r84GD7ZUo3EGG3DS/HeyDVp8HHwpfJxWpVJm1GG3pISWrv
X-Google-Smtp-Source: AGHT+IG801vRQSPn7cQnJFVDlpC6RJAJ/T5/chW7wmahwpGr+UKIv+NEmky4Gq2dP/Ic+gnLeOAU4g==
X-Received: by 2002:a05:6122:68e:b0:563:62ce:b28a with SMTP id 71dfb90a1353d-56362cec8a5mr962454e0c.5.1767953971239;
        Fri, 09 Jan 2026 02:19:31 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a1ea48bsm8700603e0c.3.2026.01.09.02.19.30
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 02:19:30 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5ecddf73062so1938191137.1
        for <linux-openrisc@vger.kernel.org>; Fri, 09 Jan 2026 02:19:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUn8HaX6R4c1rXkI58MHgg2+gg47Okc2LUSHHeXo8T3M4dQ8Fmj/SP/ZklVBqcsDzsPhlaObm/m6drN63JVMw==@vger.kernel.org
X-Received: by 2002:a05:6102:5490:b0:584:7aa3:a329 with SMTP id
 ada2fe7eead31-5ec7556654emr5715287137.4.1767953970208; Fri, 09 Jan 2026
 02:19:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217080843.70621-1-shorne@gmail.com> <20251217080843.70621-2-shorne@gmail.com>
 <CAMuHMdUaO_PwWygW8qss47W_ErB4pm1Z2HQ+edvw1-x7ce7oKw@mail.gmail.com>
 <aV9o1LL0Ahip0O3-@antec> <CAMuHMdXYCNR0ANn152ghFExpWY_yZ5+kyFGGRwA+X-EFUvxZXw@mail.gmail.com>
 <CAD++jLm1u9ChqsftwvbOptiG3Qo2KWxPjqN2snOVuZDYuVST5Q@mail.gmail.com>
In-Reply-To: <CAD++jLm1u9ChqsftwvbOptiG3Qo2KWxPjqN2snOVuZDYuVST5Q@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 9 Jan 2026 11:19:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW_DUyo=uarCpceKcEq9Hx+q+DHgfHW-m2DOjgAQ5R79Q@mail.gmail.com>
X-Gm-Features: AZwV_QjdcUI-7Z-N_pZ99To6fYeZb0GuLnE25cbH9PblaUhBL8UbvvWFR6RVNjc
Message-ID: <CAMuHMdW_DUyo=uarCpceKcEq9Hx+q+DHgfHW-m2DOjgAQ5R79Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: Add compatible string opencores,gpio
 to gpio-mmio
To: Linus Walleij <linusw@kernel.org>
Cc: Stafford Horne <shorne@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux OpenRISC <linux-openrisc@vger.kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Fri, 9 Jan 2026 at 11:07, Linus Walleij <linusw@kernel.org> wrote:
> On Thu, Jan 8, 2026 at 9:41=E2=80=AFAM Geert Uytterhoeven <geert@linux-m6=
8k.org> wrote:
> > > > What is the rationale behind using brcm,bcm6345-gpio?
> > > > Given brcm,bcm6345-gpio has 32-bit registers, while opencores,gpio
> > > > has 8-bit registers, I doubt the latter is compatible with the form=
er...
>
> Yeah this needs to be fixed/reverted pronto :/
>
> > > I switch the size from 32-bit to 8-bit using the reg =3D <* 0x1>, <* =
0x1> setting.
> > > Also the reg addresses of "dat" and "dirout" are different for the re=
al
> > > brcm,bcm6345-gpio.
> > >
> > > brcm,bcm6345-gpio. Example:
> > >
> > >        /* GPIOs 192 .. 223 */
> > >        gpio6: gpio@518 {
> > >                compatible =3D "brcm,bcm6345-gpio";
> > >                reg =3D <0x518 0x04>, <0x538 0x04>;
> > >                reg-names =3D "dirout", "dat";
> > >                gpio-controller;
> > >                #gpio-cells =3D <2>;
> > >        };
> > >
> > > vs opencores,gpio Example:
> > >
> > >        gpio0: gpio@91000000 {
> > >                compatible =3D "opencores,gpio", "brcm,bcm6345-gpio";
> > >                reg =3D <0x91000000 0x1>, <0x91000001 0x1>;
> > >                reg-names =3D "dat", "dirout";
> > >                gpio-controller;
> > >                #gpio-cells =3D <2>;
> > >        };
> >
> > Exactly, the register space and register widths are different
>
> ...as proved here.
>
> Stafford can you send a fixup or revert patch?
> (Only need to revert if you can't make a fix quick enough, which I
> think you can.)
>
> > > The opencores,gpio setup does work.
> > >
> > > Now that I think about it, would it have been better to just add open=
cores,gpio
> > > to gpio-mmio.c compatible list?
> >
> > I think that would be better.
>
> Yes this is better.
>
> I should have seen this, I guess I was sloppy :(
>
> > > If so I will can revise this patch and add patch to gpio-mmio.c.
> >
> > DT maintainers: Given gpio-mmio is that generic/simple, is there a
> > specific reason there is no generic "gpio-mmio" compatible value that
> > can be used as a fallback, avoiding the need to keep on adding new
> > entries to gpio_mmio_of_match[]?
>
> I think "gpio-mmio" combined with compulsory property of
> bus-width =3D <nn> (as used by multiple bindings) would be
> generic enough. So a schema that accepts "gpio-mmio" if and
> only if bus-width =3D 8|16|32|64 would be acceptable.

Each register is described individually, and the width is derived
from the register's size, so no bus-width is needed"

  reg:
    minItems: 1
    description:
      A list of registers in the controller. The width of each register is
      determined by its size. All registers must have the same width. The n=
umber
      of GPIOs is set by the width, with bit 0 corresponding to GPIO 0, unl=
ess
      the ngpios property further restricts the number of used lines.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
