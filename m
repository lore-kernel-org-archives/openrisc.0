Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28D231E11C
	for <linux-openrisc@vger.kernel.org>; Fri,  9 Jan 2026 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768000824; cv=none; b=sJTJJUPmcm6IROkP0Lp/lpwBVBn2rJyeBlvQfLdgz6sWrlLMUO7oR3gmlyCmG1gKdpq8MjV0oS3sxQapmWQL7Ec7xJHLkiOYc3GaC3efHo8UeZpiFhaKVJ7pCqi0vhZ1t7LNTQ19G1nTkL/21wmKgCEURmvDa8RGlYIjInBx2lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768000824; c=relaxed/simple;
	bh=UEFmpbJ2edxEryf00hesy2e0i0TCUGkwxcgiHFzpIH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0SNnKBPZvggQm2+U2UFym3DFeucNXpq7dYWJ2c5QFcqm5cj8lGH8oenY3bGBFm6UeCH5/b2OxCjUqLzZdlW1DXx/hiJDp3tPXAm49UrTsRdN1C5DczHFXFXEp77i4TsNmTsIUi49RJNB4LYUEH4i1M4Vi6o4aK4bITnKPzUfSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXluR52K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXluR52K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9221CC4CEF1
	for <linux-openrisc@vger.kernel.org>; Fri,  9 Jan 2026 23:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768000823;
	bh=UEFmpbJ2edxEryf00hesy2e0i0TCUGkwxcgiHFzpIH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tXluR52Kv4h4n/90pNtCFAodqBRQ9GgjaWWRRV3Y3zn1HQaSaRMidGSIWLY5+17sS
	 ciU2fjj7JNIqCqB3uwqLt+aQivsKuXLshta9Whcz8EAgC6jDvx5uSO0wH0h5tARCj7
	 NKp+FcSurc8JYX+kyno4r63dVcDizMfW8lHl5Rxckkhk+taDSlQ8VEGF1NUXMTLTJZ
	 fg/rBDZkntcZcb6N2rPJeEcQmw31lfmbRkHX+1Yit/bPzlytPfec5sGKNXk4umn6x5
	 8rK+3oWeoV1cecEaAc68ZFda0q+IdbXJ/YAgc7AVYeY6W0H7u8/Xeas69aVm1ygqe/
	 XDcqRVJl2ou5g==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78d6a3c3b77so40313687b3.0
        for <linux-openrisc@vger.kernel.org>; Fri, 09 Jan 2026 15:20:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXxmrFVOUY6/N0Nwj52/ioHs0ZJSaYMDlNimoot/OYy5Du5i6Jd0N7pBT6Jpk0FsTtxmJSVuJJEOZ5tsPA4JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd87wNVy3mCK/C71Msi0RAepatzNOXMP0SazytiKXAVeMKcygS
	6Pb/N0GDH+9nF4zQoIPbpAVHwTyuKglxxY/zurQA/8Z2YM8vJoPyTX0+0L3uuT0nTuI5Z9Phq2Y
	AfwvuKPq64SLpdT+rYlZbwiaMUrT0V3k=
X-Google-Smtp-Source: AGHT+IHDEjwDQ95soDuK9jRUwdWv6z1EXnCUlSAsvigiR58FDpIMEDcwMe+juahC+2NynDkXlqTRsSUeh/snyZLv7/0=
X-Received: by 2002:a05:690e:11cb:b0:645:591a:cb5c with SMTP id
 956f58d0204a3-6470d2dfd08mr12466670d50.23.1768000822975; Fri, 09 Jan 2026
 15:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109134409.2153333-1-shorne@gmail.com> <20260109134409.2153333-3-shorne@gmail.com>
In-Reply-To: <20260109134409.2153333-3-shorne@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 10 Jan 2026 00:20:11 +0100
X-Gmail-Original-Message-ID: <CAD++jLk22r1uYDmugJGqyTOW2mpOG9jc61xbmfFQ7HoJJB9zPg@mail.gmail.com>
X-Gm-Features: AZwV_QjMeOrgU1fjNS0IKJRxC9krJTx88MoI5W0UBISf2Q-_vQedrRG7paPaSDE
Message-ID: <CAD++jLk22r1uYDmugJGqyTOW2mpOG9jc61xbmfFQ7HoJJB9zPg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] dt-bindings: gpio-mmio: Add opencores GPIO
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux OpenRISC <linux-openrisc@vger.kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 2:44=E2=80=AFPM Stafford Horne <shorne@gmail.com> wr=
ote:

> Add a device tree binding for the opencores GPIO controller.
>
> On FPGA Development boards with GPIOs the OpenRISC architecture uses the
> opencores gpio verilog rtl which is compatible with the MMIO GPIO driver.
>
> Link: https://opencores.org/projects/gpio
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
