Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7774D5AB
	for <linux-openrisc@vger.kernel.org>; Wed, 20 Mar 2024 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941307; cv=none; b=mFqnMu5myOCuiwTVe769F9odgvY0EcTwpRKq8J0KmqDPZA1fwS5IzO//oXCcz6z03XO2P/LuGMzGRjhb5xTXB31THKty+6iQmqf7oAO4ZNxWynYT68DpSdSKv7ufUqvPVPU46/kpfwR2n308IM1WpjHpRM2IwLaVA3pCNXZhUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941307; c=relaxed/simple;
	bh=JvYreo8Lxd0WU0NaMQ378qU+sjxUh98378fILnoP8y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOd1MYhrnKYk4UsQe26HBxF0ftKwBeFF6FB6yf50bEQHL24kpXhZfPR46xGtADga0VHgKPIO/PMPOQriI8njlZxjzWMfwzwaUloDKyz7nG5rlUoq6zzXpQviJvLaNPEcGioAadruPwdBsl4PmEOBmVx6izcRmWcymV0zUO6P/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z8my5zWD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8my5zWD"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-299b818d63aso696267a91.0
        for <linux-openrisc@vger.kernel.org>; Wed, 20 Mar 2024 06:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710941305; x=1711546105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JrA4OYSghLG3evtY7qUXeFWKhBNcsLnb97lB9uYa090=;
        b=Z8my5zWDePs5OjS8QNHOHcS42BnuASwyX5swjXuzprwpD0hQ+J9OFTuw3XZncFfkAN
         o9CVVsSkcQAugg1MGZXgpFo3yTytdH/ryf9hfu/VHSqZzkuMA+pQGE1yDELDPM/QWudO
         1t8X+SHcMj3tf+cyagMHkbZTmKE0/fu1JINu6Bs4fRUcl6suE6FC+mMGmqsVqaEdvMnH
         8mvzV0Qixrk1kumMZSbUSYnoQeC0KtALxfsIrHQ1ii2oyKQeSjIJiQMvItH4/ibi1RhJ
         Eb3f+olJNTrTJVlOHlIU6ETws5NIrPPvu37G7jmtrpe4dR0TSbw8n37k9ug89v3kaZb7
         w8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710941305; x=1711546105;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrA4OYSghLG3evtY7qUXeFWKhBNcsLnb97lB9uYa090=;
        b=bWCAnBAzX65sD3mLFDzRWerM90guHfGJC2b4nXbCM4alEC9ROknPlLC8hoBCpkfJrr
         7wwe2W+b14Yb9SXuW5dVNO4Bd/08Tnv7r0KausTPnZbDwp4uAWeAeMSuuOpq1ESgHXzn
         ppWmrFl8kYlvWnPP8cxr3N2Q57vrnjB8e1OEB5UPe09Ok8snM6FyKuRDlZY2hMHz9+OH
         15bhpmWsjWv8jFjvJsrjJm22Mmp9zjjntiod42YrtNnFOX6/IeY6nu5fTKjHDPqRMNte
         z9X+faHfhRIu5pEP/kW5d3KLzHBDqBUZ3XzDFRk3n1GyPa5PJIe/2Oy1KC0PqNW4I19P
         +4Tw==
X-Gm-Message-State: AOJu0YwWNrKreTqme1smRC424Ihey5vr+XsuGNl5zUso5bDMCpaW556J
	Cc068WwLfQtM7JnWIgGAvvqvNAC0vqJH5w3+hcHgkbF6B4A+FCXnpxD0+3ZfGnKTg7BxSqMk8ED
	m
X-Google-Smtp-Source: AGHT+IEfmICBBfqjx+GAlRT0M17qwbS78cnkUHEfs46RQiU6n8dzdgkKCS2TrKRUZb0UdtYZQvqF8A==
X-Received: by 2002:a17:90a:3482:b0:29b:a345:620a with SMTP id p2-20020a17090a348200b0029ba345620amr3382415pjb.20.1710941304932;
        Wed, 20 Mar 2024 06:28:24 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c3:1d04:9481:20ec:563b:127c? ([2804:1b3:a7c3:1d04:9481:20ec:563b:127c])
        by smtp.gmail.com with ESMTPSA id nr19-20020a17090b241300b0029beec8e86csm1578580pjb.36.2024.03.20.06.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 06:28:24 -0700 (PDT)
Message-ID: <21f682a2-60cf-4310-87dc-44fdb2df2702@linaro.org>
Date: Wed, 20 Mar 2024 10:28:21 -0300
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] or1k: Add prctl wrapper to unwrap variadic args
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>,
 GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20240319214244.736981-1-shorne@gmail.com>
 <20240319214244.736981-5-shorne@gmail.com>
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <20240319214244.736981-5-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/03/24 18:42, Stafford Horne wrote:
> On OpenRISC variadic functions and regular functions have different
> calling conventions so this wrapper is needed to translate.  This
> wrapper is copied from x86_64/x32.  I don't know the build system enough
> to find a cleaner way to share the code between x86_64/x32 and or1k
> (maybe Implies?), so I went with the straight copy.

It looks ok, the old way of cross-reference ABIs implementations only
add complications. 

> 
> This fixes test failures:
> 
>   misc/tst-prctl
>   nptl/tst-setgetname
> ---
>  sysdeps/unix/sysv/linux/or1k/prctl.c | 42 ++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 sysdeps/unix/sysv/linux/or1k/prctl.c
> 
> diff --git a/sysdeps/unix/sysv/linux/or1k/prctl.c b/sysdeps/unix/sysv/linux/or1k/prctl.c
> new file mode 100644
> index 0000000000..1aa707d175
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/or1k/prctl.c
> @@ -0,0 +1,42 @@
> +/* prctl - Linux specific syscall.  OpenRISC version.
> +   Copyright (C) 2024 Free Software Foundation, Inc.
> +   This file is part of the GNU C Library.
> +
> +   The GNU C Library is free software; you can redistribute it and/or
> +   modify it under the terms of the GNU Lesser General Public
> +   License as published by the Free Software Foundation; either
> +   version 2.1 of the License, or (at your option) any later version.
> +
> +   The GNU C Library is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +   Lesser General Public License for more details.
> +
> +   You should have received a copy of the GNU Lesser General Public
> +   License along with the GNU C Library; if not, see
> +   <https://www.gnu.org/licenses/>.  */
> +
> +#include <sysdep.h>
> +#include <stdarg.h>
> +#include <sys/prctl.h>
> +
> +/* Unconditionally read all potential arguments.  This may pass
> +   garbage values to the kernel, but avoids the need for teaching
> +   glibc the argument counts of individual options (including ones
> +   that are added to the kernel in the future).  */
> +
> +int
> +__prctl (int option, ...)
> +{
> +  va_list arg;
> +  va_start (arg, option);
> +  unsigned long int arg2 = va_arg (arg, unsigned long int);
> +  unsigned long int arg3 = va_arg (arg, unsigned long int);
> +  unsigned long int arg4 = va_arg (arg, unsigned long int);
> +  unsigned long int arg5 = va_arg (arg, unsigned long int);
> +  va_end (arg);
> +  return INLINE_SYSCALL_CALL (prctl, option, arg2, arg3, arg4, arg5);
> +}
> +
> +libc_hidden_def (__prctl)
> +weak_alias (__prctl, prctl)
