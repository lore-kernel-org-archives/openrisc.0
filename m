Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1189B33EAFE
	for <linux-openrisc@vger.kernel.org>; Wed,  7 Jan 2026 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795442; cv=none; b=Q0LISeT5WGgzXp4ldMrhJ1CGglhpsL1Uf77vcYObjRpsn5T1ISXtQUXTTCRJ17tUo2uVNs6DWTw01ySwe5siDWruB1eu6AsdAXtizR+z3KYWxyZeF/6aEgicA//gvZEaLH0VuRkb2tERiO9dlQH55Nbv85+8sodAHovpaEjTXzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795442; c=relaxed/simple;
	bh=YA+mxCm0xEj7DarLlUtNQJH0h/2IACD4TmnFXSGRqJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5nYm6k7u4xjN/KSBEIbmOs6T0ECQ+xNR46+QfUagV6h2X/yqZKqbeF/a1gEUTkZkBlVNX9p8WYRJBt5mjy4+CLsuou/+WnRIp9XIJUKtj7UMxUQN3pp4btHflAjZ2nWq4jUP+vRqHak5UCuwNkG5I8SlCdiVhJ9tpc9CHRYGHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rs/fuIn4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rs/fuIn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E793EC4CEF1
	for <linux-openrisc@vger.kernel.org>; Wed,  7 Jan 2026 14:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767795441;
	bh=YA+mxCm0xEj7DarLlUtNQJH0h/2IACD4TmnFXSGRqJY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rs/fuIn4nJKS9FchGAh9oY+0yBAv72/Lt2vMdIzl8dp+qz8D02PZ0XMMW1We3VxAN
	 Oucn3nTB6GDFJ8NCnqc0ugIFBA46n6PwK4r55nCQKKvCbxwlK3H4S4iUKRGwEV4Uak
	 LmrJR9XjpxBqOxAjMOb8FgB+Zypt4UUiJS89xsWDv7gx3bLd5h+ovdL0A5sTQOdbHq
	 Om3rZgeOg+7qN7L6oBEWcSYpGmI2L+syogZHGo0PJ4ViBS71LkBSqxcBYA11IfK96B
	 OUPXBbhkR+i3SXooA5glFem9BtcYAP9pI54i39+m3h9Jo2k4Uw8HuqD5geqyzymffa
	 db+P0fYptoziQ==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-790ac42fd00so16368147b3.3
        for <linux-openrisc@vger.kernel.org>; Wed, 07 Jan 2026 06:17:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXoMvPbqHbZkl4EjZsQZ/uoqT/qv0Kjv5pZrLUlq/etE0NGnMOoc84HxTeW47s9OGsanrESvfBDKrP+b7AWhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRouJ5sJnqzD5N8b7tsV3CdL/fO00jyHfTFO75Gh3Z1U1Sby6a
	/Llg+uFzLRfBGdV7ug8bZCh9u5Me8etnYc8Ezkqx0xiiTGCO3sIrJNtjeNKc1qSXT5w6qg5MB9s
	3oIlWWQsKb5m6C1f8/1u9FpMddLBSMYw=
X-Google-Smtp-Source: AGHT+IFWz8BRlceis+tRl/aW/9vd79KfmxBq1oamU+LQ9mQvDSyStZFHgNip5biPn+LgYnAn/tyKFWHR9JxLOnciWJg=
X-Received: by 2002:a05:690c:2902:b0:78c:655d:f7ba with SMTP id
 00721157ae682-790b5800890mr55036157b3.38.1767795441238; Wed, 07 Jan 2026
 06:17:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217080843.70621-1-shorne@gmail.com> <20251217080843.70621-2-shorne@gmail.com>
In-Reply-To: <20251217080843.70621-2-shorne@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 7 Jan 2026 15:17:09 +0100
X-Gmail-Original-Message-ID: <CAD++jLn6FrJ4ZsMMQxiKkYZ5k-ekEXw8B8+1FXUYycqN4Cm-Hg@mail.gmail.com>
X-Gm-Features: AQt7F2r3cLS6QJSNoZCGwNenwmrF23J-ho2AOyeoy5pSDo7ehWmWTffX64bsUso
Message-ID: <CAD++jLn6FrJ4ZsMMQxiKkYZ5k-ekEXw8B8+1FXUYycqN4Cm-Hg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: Add compatible string opencores,gpio
 to gpio-mmio
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux OpenRISC <linux-openrisc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 9:09=E2=80=AFAM Stafford Horne <shorne@gmail.com> w=
rote:

> In FPGA Development boards with GPIOs we use the opencores gpio verilog
> rtl.  This is compatible with the gpio-mmio.  Add the compatible string
> to allow as below.
>
> Example:
>
>         gpio0: gpio@91000000 {
>                 compatible =3D "opencores,gpio", "brcm,bcm6345-gpio";
>                 reg =3D <0x91000000 0x1>, <0x91000001 0x1>;
>                 reg-names =3D "dat", "dirout";
>                 gpio-controller;
>                 #gpio-cells =3D <2>;
>                 status =3D "okay";
>         };
>
> Link: https://opencores.org/projects/gpio
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Looks reasonable,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
