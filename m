Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB508594B
	for <linux-openrisc@vger.kernel.org>; Wed, 20 Mar 2024 20:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965534; cv=none; b=kvjgOCg0R36hoXOO0v8nDwRPCkC26zGWrOgyQUKdUQbeIGD82897muVV1sXbcvwYD/0DqhY4DgtFvTZQEiNOZWdY3x4qcAGtXic5vaiV9gf7Fi6YjgUp7RnHPrp2snIRxt0gkVSbzzn8Au4aqw9Wy3gapp75rjmJcYs40mNkL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965534; c=relaxed/simple;
	bh=isxGIIBFWKOGvpv+awNXRVyeC7fF4cVZ0+nKP4TjxvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOFit0CJHH6jMcvNY75orOJhBJuENsLXtoX3mt5iExFCnTikOeGEsOTmNFDuxcvumx9cAyvsL51tOY1Agdb0DmAYr/bv2a3A+Jg4G1tQlF2UjoMSFjKEbaOwfyeY09OVN0zbBuyMFXgdULDlIER4zxfFQvFvNeiVFEqFcKfEFmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H42n77f3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H42n77f3"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e74bd85f26so269044b3a.1
        for <linux-openrisc@vger.kernel.org>; Wed, 20 Mar 2024 13:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710965531; x=1711570331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=79yiD/nVcrB9PgZTD4aN1xUp6D5ur+rU+JQqjgUH0YA=;
        b=H42n77f36+uTsRfoeMtVOTPxNYb6XGvFWtplGNpByRsSv7rwfuvEZlDizS/Oje/G9U
         kwxbZeDR8WQVmuBnUSkhJVXQ0CCVkb8lM/+A4up+1ECoznBPprDLzWko8Dm4BceW1Yj7
         mjbONfcQenN+gHAMPhL6qUL6HkSAjwvc6inR17+M34U8zQiimZeuLyfsaMz52iVVy9Jj
         to8Mnhpv2xqunZ70pSv+7TumsLgZuLrbZcp/oePlFTmfVG0QRJwrUUnv3OIDRkbyZAMF
         X23CCwiLU7uGQGpuuj918vMHdW52OC+hn1EjWsuFA3nuvZaRjLIF3nRcl+XWk+1QhrUJ
         Vvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710965531; x=1711570331;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79yiD/nVcrB9PgZTD4aN1xUp6D5ur+rU+JQqjgUH0YA=;
        b=xH89LcYAiD5GfB43jMteuUeL6HtbbMzBNz/8IZSofx9D7nAc9EOGIj0W4WEC2MsmmB
         eGtBSJwxmjilwYq4hqdFZJXlo2dKXq0Z8DvQV6vb/l9Cj+FJRsFbucIytVhCOmdqj1+2
         RkPdXkspI6v/mlcG8I07UiZ2NC9bSFsQBSTQCQCkciLlpF9bCRg9pfgdYd7Xe+e/q0xX
         S+DoPof9FTXwhzClyD0e3Du+fmOoT+N/uABxWMtzpXW/gEdsZc7xG/vvO2kQeKbaQYqK
         a2FDo3ZFbYVMCoVAWCOimauuOe6k/uY6qixJgYql7RwLA3DO8OkuVNZhIo768dApFXlC
         Bc7g==
X-Forwarded-Encrypted: i=1; AJvYcCW/tjK3vIXyfpdH5oebfnBwINUwy0dqagng8rnlFPqPApJybrOv75tVpBGtIutkai349XprNhMTumivFHpTU2iRcKvcMWGDNgeXyZAvUBw=
X-Gm-Message-State: AOJu0YwYkcH1PBVwAMJcoFdGsBq0bXTN99T8jEv9XLAN3sdAuTLdjm+b
	PJsNOmA/qFBmnDDoBtzLT6pTx11ob1Qu5bIAOo5qqKindKwrrwi5gsqzyuWGnME=
X-Google-Smtp-Source: AGHT+IG2M02hi/uYW0O+OOXx+D1HZtJ6CivhRAPfnbUEdn9z0AyIrZzZBHDqgdfHn7snn3S7Z7hk2Q==
X-Received: by 2002:a05:6a21:9211:b0:1a3:46fc:e89 with SMTP id tl17-20020a056a21921100b001a346fc0e89mr44544pzb.32.1710965531512;
        Wed, 20 Mar 2024 13:12:11 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c3:1d04:9481:20ec:563b:127c? ([2804:1b3:a7c3:1d04:9481:20ec:563b:127c])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902650b00b001d9aa663282sm13032375plk.266.2024.03.20.13.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 13:12:10 -0700 (PDT)
Message-ID: <907e694a-b3df-429c-acb1-28dfc2a7f211@linaro.org>
Date: Wed, 20 Mar 2024 17:12:08 -0300
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] or1k: Fix Linux user space signal ABI
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>
Cc: GLIBC patches <libc-alpha@sourceware.org>,
 Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20240319214244.736981-1-shorne@gmail.com>
 <20240319214244.736981-2-shorne@gmail.com>
 <d892782b-7959-4256-9b9f-6dadd5493dcb@linaro.org> <ZfrvHIfPjF2GHnXL@antec>
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <ZfrvHIfPjF2GHnXL@antec>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/03/24 11:13, Stafford Horne wrote:
> On Wed, Mar 20, 2024 at 10:24:15AM -0300, Adhemerval Zanella Netto wrote:
>>
>>
>> On 19/03/24 18:42, Stafford Horne wrote:
>>> The OpenRISC sigcontext structure has always been defined as:
>>>
>>>     struct user_regs_struct {
>>> 	    /* GPR R0-R31... */
>>> 	    unsigned long gpr[32];
>>> 	    unsigned long pc;
>>> 	    unsigned long sr;
>>>     };
>>>
>>>     struct sigcontext {
>>> 	    struct user_regs_struct regs;  /* needs to be first */
>>> 	    unsigned long oldmask;	/* unused */
>>>     };
>>>
>>> With Linux v6.8 we added FPU support and repurposed the oldmask
>>> to use for the FPCSR (floating point control status register).
>>>
>>>     struct sigcontext {
>>> 	    struct user_regs_struct regs;  /* needs to be first */
>>> 	    union {
>>> 		    unsigned long fpcsr;
>>> 		    unsigned long oldmask;	/* unused */
>>> 	    };
>>>     };
>>>
>>> The definition of mcontext_t was always missing the extra space for
>>> oldmask.  This patch adds the field __fpcsr to mcontext_t to fix the ABI
>>> mismatch between glibc and Linux.
>>
>> This is strictly an ABI break, this won't make the swapcontext functions 
>> to fail (since they are not update to take in consideration the new field),
>> but it also means that the fpcsr won't be save/restore and the application
>> can potentially read uninitialized values.
>>
>> But I take that the fpu support will be a new ABI, so I suggest to fix
>> when you add it (along with proper support to context functions).
> 
> OK, I got it.  I will post this when the hard float code is added and also fixup
> swapcontext etc to populated it correctly with or without hard float.
> 
> Note there is broken ABI already, as programs will not be able to access sigmask
> if needed due to:
> 
> Linux definition:
> 
>     struct ucontext {
> 	    unsigned long     uc_flags;
> 	    struct ucontext  *uc_link;
> 	    stack_t           uc_stack;
> 	    struct sigcontext uc_mcontext;  <-- size differs between glibc and linux
> 	    sigset_t          uc_sigmask;   <-- won't be able to access if needed
>     };
> > But still I will leave as is for now.  This hasn't cause any issues as far as I
> have seen so far.

But even changing the uc_sigmask offset on ucontext would require versioned
context functions.  Usually to access the signal frame ucontex_t, it is safer
to user the linux UAPI definition instead of the libc one.
