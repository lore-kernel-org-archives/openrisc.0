Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58543FE23
	for <linux-openrisc@vger.kernel.org>; Wed, 20 Mar 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941061; cv=none; b=B2usohtwWJ+z6Ti3ZpN22D9kw1oWICFgakp3O54cO5reqFaIkcmDwZTmdEI7TwBDvt4v/I2jWN6zPC0fTCETd+7o+dXlelrLWdho3odalGtKIY+BAfGsTr+/14DqyxS2BFJJtlXRfB1JB0KpCweJeP49X3SuJpOOmHUrqeysZdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941061; c=relaxed/simple;
	bh=tIGuFlzuH+I6zKulWem9xZoTSXub8cwCWsrCiqC7gBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byG92SBrWlsPhd+oycxT9pfldXi6OgwR6Cst+dfdrAdKNuwW5HKQls2GUblygjG5QRi93vS3EEbr3YFIUgZou06gTa93QJIGtMxOebcNsBDbvr1EQJ/9r4y3pmzj+B9C/6ulQEpB1H3dif0oVAjjVuQv4FHGOhaC8DnunlQwrHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y9Ahfh6m; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9Ahfh6m"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dff837d674so33511755ad.3
        for <linux-openrisc@vger.kernel.org>; Wed, 20 Mar 2024 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710941059; x=1711545859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sWf8n8MBg1LCUfGd9j671/BK6632DY85mQ+shl2OokY=;
        b=y9Ahfh6mxCtgA6Hme9FnckKu9G9fVa0XLRyVg2XdLWnjuQ6a3YVFGQnPO7qtUIR0O+
         7C9Z0RX6j6Oc4ORJfh0HeoH2UBhwyDumCXQAJ6zjsTUv3uBHH1w0Xy7HoYpS1pAlTOZq
         ymJZLusd6qbvmIlW2Kv5lFz4EeH8fN9VVX3VA6K5oEKSWYnf2XyYXh7fMujIzWV/8Tde
         3weWMRGlRozA6GeCw6eqIwm+4zvsO7Lb06wFeloVMAfrS+oLgrt0wILswCSlm+I0UyEv
         IY01XM4Ow2vJuGfU6Y7PtdBAst596ccCzeVvHzv1Jqj5mfahssnLmNYXSkUOAE/Ojv5x
         2zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710941059; x=1711545859;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWf8n8MBg1LCUfGd9j671/BK6632DY85mQ+shl2OokY=;
        b=fgHM/CvBidL1UeYxWMAImFEGpfiER222mdbqvxakVDWZta1d/BvIei0lpzXAbwIwzP
         pi0MV9GZkfRdIeytmoYDQEKyPVZj9BYQg/NDmSRNG5UmL+2eIV4O5dgKMsNivJpM2suE
         FrV0JqFl89404unlb8pogUsxikxKuOjgUYz2MbowDcfJe5QQn6yEZDZKwjyMw5exbRvf
         dXxdESTlVvnN9jjXqgeRulub3repMeOgYANT1ftPIljwiR+E0XSMdRKxEmkuXX4gnCT+
         xw4RLk8AUy+yerhSvPn6sDVKqWKr7JO0ja5LmbOxWJbP8v2CDRHkpqyDbkCEu4KxDVaE
         LReA==
X-Gm-Message-State: AOJu0YzPtDiJ3i8ymKm+DkV2LBqT5Wim7wWXBRYXE7n3oGTkdKZ63CJw
	UkzPx27jvZKhaJnfhSbwZnmZlqtRTTcWNnjwOuZ5EDjHX5VZopaHC7YACr8fWxA=
X-Google-Smtp-Source: AGHT+IHegDffOemMkZRr1z5clHHoRm+28+LcT/mSIGMlqusLmTlMetnOCFLFjbavGCGyLgXAe6Kozw==
X-Received: by 2002:a17:902:c3c6:b0:1dd:9da3:59ff with SMTP id j6-20020a170902c3c600b001dd9da359ffmr1727363plj.42.1710941059052;
        Wed, 20 Mar 2024 06:24:19 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c3:1d04:9481:20ec:563b:127c? ([2804:1b3:a7c3:1d04:9481:20ec:563b:127c])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b001dde2c3fea5sm13425741plg.50.2024.03.20.06.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 06:24:18 -0700 (PDT)
Message-ID: <d892782b-7959-4256-9b9f-6dadd5493dcb@linaro.org>
Date: Wed, 20 Mar 2024 10:24:15 -0300
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] or1k: Fix Linux user space signal ABI
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>,
 GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20240319214244.736981-1-shorne@gmail.com>
 <20240319214244.736981-2-shorne@gmail.com>
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <20240319214244.736981-2-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/03/24 18:42, Stafford Horne wrote:
> The OpenRISC sigcontext structure has always been defined as:
> 
>     struct user_regs_struct {
> 	    /* GPR R0-R31... */
> 	    unsigned long gpr[32];
> 	    unsigned long pc;
> 	    unsigned long sr;
>     };
> 
>     struct sigcontext {
> 	    struct user_regs_struct regs;  /* needs to be first */
> 	    unsigned long oldmask;	/* unused */
>     };
> 
> With Linux v6.8 we added FPU support and repurposed the oldmask
> to use for the FPCSR (floating point control status register).
> 
>     struct sigcontext {
> 	    struct user_regs_struct regs;  /* needs to be first */
> 	    union {
> 		    unsigned long fpcsr;
> 		    unsigned long oldmask;	/* unused */
> 	    };
>     };
> 
> The definition of mcontext_t was always missing the extra space for
> oldmask.  This patch adds the field __fpcsr to mcontext_t to fix the ABI
> mismatch between glibc and Linux.

This is strictly an ABI break, this won't make the swapcontext functions 
to fail (since they are not update to take in consideration the new field),
but it also means that the fpcsr won't be save/restore and the application
can potentially read uninitialized values.

But I take that the fpu support will be a new ABI, so I suggest to fix
when you add it (along with proper support to context functions).

> ---
>  sysdeps/unix/sysv/linux/or1k/sys/ucontext.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sysdeps/unix/sysv/linux/or1k/sys/ucontext.h b/sysdeps/unix/sysv/linux/or1k/sys/ucontext.h
> index b17e919154..1b428592ee 100644
> --- a/sysdeps/unix/sysv/linux/or1k/sys/ucontext.h
> +++ b/sysdeps/unix/sysv/linux/or1k/sys/ucontext.h
> @@ -38,6 +38,7 @@ typedef struct
>      unsigned long int __gprs[__NGREG];
>      unsigned long int __pc;
>      unsigned long int __sr;
> +    unsigned long int __fpcsr;
>    } mcontext_t;
>  
>  /* Userlevel context.  */
