Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com [209.85.221.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20F92E0914
	for <linux-openrisc@vger.kernel.org>; Sat, 10 Jan 2026 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768053818; cv=none; b=X0126/jmpUcoUOjU8qkHBpDnOBuBoan8K6elGRs1uAS5F96Z9CzYY5KylNP5HTx6EVTcud3g8m1gGQ1hnXh9chK7JWfe5FiES9fBOBDZMbOMRyzjWXiyrEcM9GDWVw0HJQE2Igau+MUXM1H19U1EwWbemqWF3ZjVtHQP8wjm+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768053818; c=relaxed/simple;
	bh=+hIKWxEFnKXhpOi0CDirFiYYoKezYuUhhk82dtboigg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njzobXt8RXDq8XEqPZS3qWVxdNPRCKdSokwgBGNcB+qfNaxO2tHQ8gEw8t7fwfcNMPJcKPVP44wUSsl+g+juA4ahp4C1JxflE3rbNwneoMuJXysBhMP/3QyE8JoxoDQnuBjEd44Is0P5sQCq3PfDPX6rnaKzhlpzxgWfUbC917I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f196.google.com with SMTP id 71dfb90a1353d-55999cc2a87so1427534e0c.0
        for <linux-openrisc@vger.kernel.org>; Sat, 10 Jan 2026 06:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768053816; x=1768658616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/+nQPBpahPuTRTHglEM863xOzb0uRGdbVA+VJIFHvc=;
        b=E3ujoisRciyj/XNOor/etRVYzpHfcEtELAT1YKIoqZ7rBTRhhnfUrTPkWEmKSqb3cf
         e0yy27gvtXvX2apqLz7I1mduXavaseXD3K2jqz5E/b0uSJmxVQFAbpufJvs7bdPkSZ22
         z0YLMfGU/u8Ju4q+dgE/1D2W3IkhvSaOr/ZPNxPtwviNXMPtVHJE1J4VraJGp5h9Py84
         BbJ7z6+qIRGrKOQKb4g3MNy4bpKAZkContDkMGH8CjTxKRDBfIea5mKmqarkyn+gxS3D
         rPAvf9oPizR33/iLpTsFO891RgRvL7bKg+Cw2WCimoQ7/r5USkGh/KtNekA68aX+voPC
         H80g==
X-Forwarded-Encrypted: i=1; AJvYcCVNAcmrCwDULghSoEHXN8WMQKt4LefI3iMs51ZOVJWuEDvZGvu1VTRvhe8VwwS1i34T/iI/Jz+2nwhR24gU7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/R1YIKMlAEoL/49L0R2XO0ekBxc/ZaQYhsm9ZPQYxOwcEatE
	VU5Wvuq5QRIaw7BWI4zXQiaBsaOoB8rx29uvx51zhd+hjUFu5cu2gRjwsYEJmRqZ
X-Gm-Gg: AY/fxX6/fnzQdVHRkmbMofHeSP19ubYjjv/6j/qUwCpLgsgI3AWmA3CeAbv+taFP2Yj
	F8sCPbGtqZF115RYibu9TtnLV4l3+rjKqt180VaqWCgZWyCMbZRCu2jpcVPYr2U5ulytyCE56xY
	grrPtQeDfx1/RNpRRLp+HEF6KBtLfm6eU1OPGzfSZ5Sp7cV/EJgAvw4hxovUlSdYOHY4UUwqNDg
	zrhA5/e0UznmCXgdNeNri5m/kJTW8WmALi/TtV/wqsgWiXcnc7m2FjrJ0ls5xnQpLNIJIqkl/hw
	2ZD7seO0d65zbxdSOloH9IUPq58yF1NY6P7nHLxC0twJy6PVL//Qim1P0z/hedA4wIoAVLIU58R
	Vlcll94YGp3Evr7v8GmJN+dh43p22Muat8LiPs7Hf0PpN370xY9zE6Vz8MrllIq9GebjfTJsMP5
	lL65RS5y+hZVhbzWWzIFeeqsPWxuGDgnJbGKrTec15WwxORF9CYqB8
X-Google-Smtp-Source: AGHT+IFtxFRXfPO11UEOFmhMpBg7hSro4g3/H4MbaS5gYK+ghCVjuFcoLzi0MFo+3vQuPacXqOv13g==
X-Received: by 2002:a05:6122:3c4f:b0:55f:e06c:442e with SMTP id 71dfb90a1353d-56347fad1f6mr4158857e0c.13.1768053815732;
        Sat, 10 Jan 2026 06:03:35 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5636dc36a20sm3388133e0c.13.2026.01.10.06.03.35
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 06:03:35 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5635e6b80easo752179e0c.2
        for <linux-openrisc@vger.kernel.org>; Sat, 10 Jan 2026 06:03:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3QirMA9X5LbqCI9Gi9AzCMrGfVYF2ysds3X3Loh1zuueYuCC+PocTAh17hKYHMUbWJEKbcqRkDtmuEHnDOw==@vger.kernel.org
X-Received: by 2002:a05:6122:3c4f:b0:55f:e06c:442e with SMTP id
 71dfb90a1353d-56347fad1f6mr4158743e0c.13.1768053814696; Sat, 10 Jan 2026
 06:03:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109134409.2153333-1-shorne@gmail.com> <20260109134409.2153333-3-shorne@gmail.com>
In-Reply-To: <20260109134409.2153333-3-shorne@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 10 Jan 2026 15:03:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUiFk7bVHh_034jPyBGkgDGnc-dXJDwOEnBD2iZ02uVng@mail.gmail.com>
X-Gm-Features: AZwV_Qj6z-YvX-ELAM615xI6NqQo7zoOHhnr178XasgXuOsQv6rk-nrDVdiPSh4
Message-ID: <CAMuHMdUiFk7bVHh_034jPyBGkgDGnc-dXJDwOEnBD2iZ02uVng@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] dt-bindings: gpio-mmio: Add opencores GPIO
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux OpenRISC <linux-openrisc@vger.kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Jan 2026 at 14:48, Stafford Horne <shorne@gmail.com> wrote:
> Add a device tree binding for the opencores GPIO controller.
>
> On FPGA Development boards with GPIOs the OpenRISC architecture uses the
> opencores gpio verilog rtl which is compatible with the MMIO GPIO driver.
>
> Link: https://opencores.org/projects/gpio
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
> Since v2:
>  - Fixup patch to simply add opencores,gpio and add an example.
> Since v1:
>  - Fix schema to actually match the example.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
