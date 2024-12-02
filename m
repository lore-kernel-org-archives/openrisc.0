Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4A31DEFF9
	for <linux-openrisc@vger.kernel.org>; Mon,  2 Dec 2024 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733173182; cv=none; b=qp/aKw3RAFhuyS9Ehb8byOJkdN1WV5Ms+8F3wQUD3x1MF2UCB9zOaJ31111W6JKJAghqEBo5izZwLRRHTfJWuD9f4XarLTemrenZtdET9qxhQO2UQ6rRCWJK5lqaI18DVe5/bfM0uAtK1Xu3VR7qEL9dcw5BkDy3pEk24EE8dpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733173182; c=relaxed/simple;
	bh=bWUbsbYzAXpNGIx3FEeO/he6o43ml139S4/Re94zVhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J//5kCAFlo4dpaBiAOcDSlD2CbPvb25vGiY+lhI79GyWMK9q0LdkIJrWOBPKnRva4+e2LgREO/nnFazkoOEeiz9Z/Vp4oK44wew7V5iXKlkdFQ/jNk0pmVlPOmBBmZXqwrRQvSZrIVzoRCzxFLdTxmAo+O/9VNXrMg6a8V4bn1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WiSZQH47; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WiSZQH47"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46687f60b73so17221cf.0
        for <linux-openrisc@vger.kernel.org>; Mon, 02 Dec 2024 12:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733173179; x=1733777979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oVEWy2iyizmNbl2ITO+8ooVXprBB5JT3rcAZ9azxCo=;
        b=WiSZQH47AC9Nu2HsTtwxhUFddzssiZ8uNg7TUB1BQmN2BocA2zeR0CAm69YVPuQ9k2
         WNvB0KquFga8UKMDZ6CpRcPa5O+3StK/t41r/kW6WgQ6gXa80q0Hd1KryyCKc9CVLAM8
         i2KIQ5cvUSV3TCU+bVSTk8n88tv8KSrS5LlWN4YhxLDpYdvNZR90SdigUmfDWtZbZAGq
         5Bbwo8LHlBwTEiJaqXOrY4eshLc+gVU+qESfaayoswZnNytNpFXcwxplDiUkdLaVK5lI
         tw73BdP4Twgd7NZL+Kyn3IHn31s3PwNs3mLnNhU9H2zsEGwQDsNT0I038Fg0BBGz9Mqj
         eXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733173179; x=1733777979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oVEWy2iyizmNbl2ITO+8ooVXprBB5JT3rcAZ9azxCo=;
        b=kAavDzccj0kIAH/PG9taijM5rSO8IjrYufxoTjRZs9e/1L4uSvHF2YauGJ98oryFWz
         WZMD1YqWPO7X+ZRT7NaC50I46jfntaJKgZdMjgQwMK/tDlZmtqTSiRNkc0YT0N/vzJS7
         ubnAl7F3AH2BH0C/7/2RoYvP7NaidftGbbhG8By/qjkF9QnfCVpI3uAxWmLqixPaSyz1
         ycBqwb8PrR78HI8iab1TxA6z8A7q1sLykG1a4YrJZRym3Tksis0cGmGeUqi89R2i/vPA
         g7J+Qx6XJZvFHw5cTEuJLhgRbQzETeG46084bXXUL1A6Ib5ScocfyNZqQLxEbC2QhuOc
         M79g==
X-Forwarded-Encrypted: i=1; AJvYcCVyD58wwC1F1E4msjYjd8tXXyNSKYWn1WIcYB9KnQEkaJx+8G5Y2SbZCFG4rkBM5JFr0rd2+nEFaLifJXqAbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyboqG+dSZqhfsV0mpL4btEMdTEBRQHTAlz2DoxVYIRlwoufhQZ
	JN/yP+7PJrxt3VTLSr6ERZ9M0rWF33mB+2lk+OCVDOJ5nxP82sPCdOztJI2MedJp/rPpFGLPQKg
	HKKA2v7D//8N25CurL2ZX6ZPrx1sg/SmKvwmRs6CkET8hbVr0Is5N
X-Gm-Gg: ASbGncv8A33/k66SHRnQPZGsTxMGf0WVoAF6u6SJHU9Rz1qG6NHLwuEgT4/iX7H7l6Y
	m8CAJJFxM60CXuLfQgsxTggnviwGOa9oFst+EYddE1FN10zT4XPsTZIUlKrIYYA==
X-Google-Smtp-Source: AGHT+IHXajz9FjvZ5+7EyyCzVsXQCy9Z4GCJO1PItlq2H+4of7VPChdd4GL3fxrK7I1fkXmoDaG7ouG2iPSNtCOsmZw=
X-Received: by 2002:a05:622a:2516:b0:460:463d:78dd with SMTP id
 d75a77b69052e-4670abded03mr34641cf.4.1733173179359; Mon, 02 Dec 2024 12:59:39
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202062909.2194341-1-masahiroy@kernel.org> <07dcb646-d806-4767-b29d-77092f6819e4@roeck-us.net>
In-Reply-To: <07dcb646-d806-4767-b29d-77092f6819e4@roeck-us.net>
From: Rong Xu <xur@google.com>
Date: Mon, 2 Dec 2024 12:59:27 -0800
Message-ID: <CAF1bQ=R_VUDR9rGAWhjPa4jHuauftLg=A9Mp=thJaK8PdjM0Wg@mail.gmail.com>
Subject: Re: [PATCH] openrisc: place exception table at the head of vmlinux
To: Guenter Roeck <linux@roeck-us.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	linux-openrisc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Han Shen <shenhan@google.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This looks good to me.

Reviewed-by: Rong Xu <xur@google.com>

-Rong

On Mon, Dec 2, 2024 at 12:33=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Mon, Dec 02, 2024 at 03:28:22PM +0900, Masahiro Yamada wrote:
> > Since commit 0043ecea2399 ("vmlinux.lds.h: Adjust symbol ordering in
> > text output section"), the exception table in arch/openrisc/kernel/head=
.S
> > is no longer positioned at the very beginning of the kernel image, whic=
h
> > causes a boot failure.
> >
> > Currently, the exception table resides in the regular .text section.
> > Previously, it was placed at the head by relying on the linker receivin=
g
> > arch/openrisc/kernel/head.o as the first object. However, this behavior
> > has changed because sections like .text.{asan,unknown,unlikely,hot} now
> > precede the regular .text section.
> >
> > The .head.text section is intended for entry points requiring special
> > placement. However, in OpenRISC, this section has been misused: instead
> > of the entry points, it contains boot code meant to be discarded after
> > booting. This feature is typically handled by the .init.text section.
> >
> > This commit addresses the issue by replacing the current __HEAD marker
> > with __INIT and re-annotating the entry points with __HEAD. Additionall=
y,
> > it adds __REF to entry.S to suppress the following modpost warning:
> >
> >   WARNING: modpost: vmlinux: section mismatch in reference: _tng_kernel=
_start+0x70 (section: .text) -> _start (section: .init.text)
> >
> > Fixes: 0043ecea2399 ("vmlinux.lds.h: Adjust symbol ordering in text out=
put section")
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Closes: https://lore.kernel.org/all/5e032233-5b65-4ad5-ac50-d2eb6c00171=
c@roeck-us.net/#t
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
>
> Guenter
