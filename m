Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778C614AD11
	for <linux-openrisc@vger.kernel.org>; Fri,  2 Feb 2024 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895795; cv=none; b=UtQWPVvqW0KboB5qx6so/pKa+9yxrvX/ySgRIJuoRsOQ6DWyeILQWDmIrXo0GZ81iUYfdxEImT/mEXeY1ZSqR8Q8IY4QSokH2iKOGbqW9bwGOPlCx8X1I+HXBnenk3/bsp9yS6R1ic20b/RXBDR5ARq4yAnokYhxQ/hhfVlpmRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895795; c=relaxed/simple;
	bh=T+NxqikMqY8zMy1caHhysblQq9xG1f252fz6RtPoVcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4lX0Nr3UW1VOb3tztYNWly0BGDa0x61SXyIPzL/iScGpA+KHUN1CF31rgn4MXuptluEgaBqKx/Al8gti2wuJPtYLMz+YO9VML0bCDMl9IlDOLAiPGuY+yH8UHnU0Dl3q71Ktqi+QNHjndEkxsMNO2hlLDoDEJY0fRLNEPuV+D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SlVx6PbB; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlVx6PbB"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso2286080276.2
        for <linux-openrisc@vger.kernel.org>; Fri, 02 Feb 2024 09:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706895791; x=1707500591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+NxqikMqY8zMy1caHhysblQq9xG1f252fz6RtPoVcE=;
        b=SlVx6PbB7PYS11tWyXl1FRKQN9gJVKiolOghLgYliRP+lkaopifg6QQvJZOYzHj2RP
         qn7frcav8E4KPXfnOhzhwD0bxDEnRhD6MTvxMcwo+ZVoifkRppGPZdFuzySzyvut6js0
         5zV8CZ3pPYntE97AjeD4gOQzVeyY5Ipy02Qsq04dfWDRX//ylGr+L3smhB0L8SKU9TKx
         /ZlyAY47wVqCFy1kj40ntfbpw3MQe6ry/uZLoD5oXJqrD8ZOg/e0hTzdm0yN9Q23Gp7Z
         OHzNMhiuS9PNAiYfhrbhwkDKtj7stnQ45MmUKPWeIn0v/0mXl1o4vaiLutdSwM5unWkT
         0EGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895791; x=1707500591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+NxqikMqY8zMy1caHhysblQq9xG1f252fz6RtPoVcE=;
        b=s95k9dmna+PIluuvzIBuj1Y5z4UVEcUDdr+5/Zou98nCj0ATbcwa9cwCdUra/bglrh
         gXPeYppspKBmYdWYjqjOn21OGasWW0jjNM5aR36xfUF2REtVhAcKc/5+++7UyKlDDBqQ
         3FEuPwCD7zHctAjybg4rdd2bx2aclodXGZNc0Ap/zYfJ04n+x//Ni+N/js4g5SyxAY/B
         y+JY6kmCJ6i6tu/EtqlTnJC0WzK44vua1vn3BhbFfVGxVOf94voUhRiHdBRcWYXQM6C5
         Eps2EmTRcbuz+B9svhU3ve5Dc/pD9zl3QM2MJn/EHTU2emFwfDM0QjSNwH7HmMpby+X8
         cSsQ==
X-Gm-Message-State: AOJu0YywAcSZ2y61bLdtwivgvNH4PVAQHfTpRZnr5uI+y+iUCAs2DdQG
	hiBe95Pq8bMf0ATvgeik2CbRn3xCP6vRXGwkdvqa0ZB0A6aIYz+XGfkDy5cVWVubvtZmKLZ5J08
	Y/LC8i/+MpXeeGTlOwHI0RTB4kjdIkIbx2obtsQ==
X-Google-Smtp-Source: AGHT+IHTaFiLwtqyLg8kSKQCyZ9cLuPMVYmKAcJIt8eLghpONdnZGm3WBgei2TskaAhjfRZa6yT6FKg3E1ONuoiITUs=
X-Received: by 2002:a25:5f49:0:b0:dc6:af04:2e05 with SMTP id
 h9-20020a255f49000000b00dc6af042e05mr6356972ybm.7.1706895791304; Fri, 02 Feb
 2024 09:43:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202140550.9886-1-yan.y.zhao@intel.com>
In-Reply-To: <20240202140550.9886-1-yan.y.zhao@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Feb 2024 18:43:00 +0100
Message-ID: <CACRpkdarfWFhvJ8vrDZXOk-nhDkgfwOLB+EytVm1S=-dEFKy3A@mail.gmail.com>
Subject: Re: [PATCH] mm: Remove broken pfn_to_virt() on arch csky/hexagon/openrisc
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: arnd@arndb.de, guoren@kernel.org, bcain@quicinc.com, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 3:35=E2=80=AFPM Yan Zhao <yan.y.zhao@intel.com> wrot=
e:

> Remove the broken pfn_to_virt() on architectures csky/hexagon/openrisc.
>
> The pfn_to_virt() on those architectures takes PFN instead of PA as the
> input to macro __va(), with PAGE_SHIFT applying to the converted VA, whic=
h
> is not right, especially when there's a non-zero offset in __va(). [1]
>
> The broken pfn_to_virt() was noticed when checking how page_to_virt() is
> unfolded on x86. It turns out that the one in linux/mm.h instead of in
> asm-generic/page.h is compiled for x86. However, page_to_virt() in
> asm-generic/page.h is found out expanding to pfn_to_virt() with a bug
> described above. The pfn_to_virt() is found out not right as well on
> architectures csky/hexagon/openrisc.
>
> Since there's no single caller on csky/hexagon/openrisc to pfn_to_virt()
> and there are functions doing similar things as pfn_to_virt() --
> - pfn_to_kaddr() in asm/page.h for csky,
> - page_to_virt() in asm/page.h for hexagon, and
> - page_to_virt() in linux/mm.h for openrisc,
> just delete the pfn_to_virt() on those architectures.
>
> The pfn_to_virt() in asm-generic/page.h is not touched in this patch as
> it's referenced by page_to_virt() in that header while the whole header i=
s
> going to be removed as a whole due to no one including it.
>
> Link:https://lore.kernel.org/all/20240131055159.2506-1-yan.y.zhao@intel.c=
om [1]
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>

Thanks for making the kernel a better place!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
