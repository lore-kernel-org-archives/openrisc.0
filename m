Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A84531D72F;
	Fri,  5 Sep 2025 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092451; cv=none; b=gDJNTJmNiaKIQHNz/jcj7awGhYYR7tFzhPyXvrEUaar81zxyObYaMMw5vmreqgQq2dg7VYEp78n3cakB3do9E8pUqrbB26YpzQOf/BcWCrzZEYtSgSkZUev/gSFm9puTbwcHAmczxehMlntfrLXihrl+TTrkA16VEtFVURkMPuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092451; c=relaxed/simple;
	bh=GpBY8vc//5uqE/qlc/2rlMOJguRJMBKJ4p4+rtcdDcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qr0CaUBDP+HmGPpv5qoWlGiuyhyDPdW9xpMBNvgfNwqTrpKROn4gvfge0Uvhl4hh3KXJQLuaGsArPMCwJbQp9e6MIFs39vQubFYgsodHD7oYWNzDUhcp9JnsRUN/jg19pT4fCu6jHJHyag7CX0CXilShmQ5gEVdosO0mv//z9jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bxcx9jj0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bxcx9jj0"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3d1bf79d758so2166225f8f.1;
        Fri, 05 Sep 2025 10:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757092448; x=1757697248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N9Xfg2BUF/gh2KLz5+D7HO9fdg9svugjbMMPqJu7fj4=;
        b=Bxcx9jj0Fm3tcaMlpuBojN5DLLqsryV9CbIfG/MCRvshR6NEHPr0ADytkQ5Hu90HMq
         JpzqBKvCcsodlc3kZ7M0mp6yDbupJZf3wWcQOiwS34HYvHevJdwz6WY9lqy+D0bSYp1F
         lNpUJC2BNtsvKwpvjJJPw+2fwhPkmeIUyKift6Ecbuko8DAsP5iOH4ArWCp4OJDnq+P3
         Z6HUVOK2dUj8OD1t8H4EvyjDMcsZ02fCC3yjoZ/q+VJydwKB7M88GaRUzxgrAsX738vR
         Tx6ovUYGT7iFQj2Dzibe37Q473QjAvUQSpbgK249m/QQ1UR2NDnNGLsFF6eAxlc9b0AA
         woLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092448; x=1757697248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9Xfg2BUF/gh2KLz5+D7HO9fdg9svugjbMMPqJu7fj4=;
        b=KAxmgkMnCPzvK8/jPSNHg/LgkhDVMYNfAS4DtKtZcUcWBQ/z52tgCysku+FkgEjO4p
         dLwYA+SsP1UzKn2DJOmEdwIdtaAtVF4Hz3Muqwr9D3hNZGRfD+ZN7ZdYIBK52CgmkEHl
         SOF+P1bqiimu4OxRVaVkG7EgquDva0CyR4kvFKVOZjO25rNUtYJpfrGa7LepUY/BubiO
         aTf8Kb/5Pp2LQzgbUUyNgAwNXFg+d7Cj/aThdUbLLZXnrMQyAGjLd8dxnzpFGmgDFqAs
         nOSMXXxIN/3wstXdQnIaxNAHdx1X3HOoyoYl6reLbXeEAKlFWIcUFHPjeE+S4OdEqGli
         JpqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbOkEWGLZWqq45yReCcLnRteJGvxyXfb6SgdzyooYa8qyKAJ+uAJNrt0BYk1tWzSSN5TzpN2nujO81sVuTWg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1WofUsvFz7VkCVgcNRm+Xh7JDmSCqyxKfZABdJ+j0kmOBe3kJ
	8jqNLX74InoxJ09QNBg4kMXNDRR1VB+o/6oVQT2MHGBQ5BgKbNS192E+
X-Gm-Gg: ASbGncvfx3Yg+oYw0Upa4B3elKgwA53uXJUjZ6DOuATLwwnyYWZTeE5Z5zOkBn59a7E
	JlGYHO4THZXNIl50dE/TOrBKJ7KNgRwIiI/ZPlk3sTDv0VV6wP1VuXYV9+R3izyhj8bgpU5OX86
	kySBJUVAVTCgslqkopTV47L8odi46+/I+/+BVuWADfKf8gMJQd4ZsUsx6KQXWFAN+l7AWR7Zy31
	onxdGw0dGXreAPWI3pDP/S4LCO63tlCnmka2VX/vMgAnW7X6KQRqNEVpVtxafMpuXKba94VBdCp
	wTlHJIpFzpkRAx++AcBGjnOKPuj+WZvFaupu2A9pyZRg6GWenkK8UxvzuE8uuqCigpyE7plpka6
	35iW/DV/x1OQHWceCj1TuxspJLqYbaboBxW/M5zh3Cxoyfv40WInl2RfygwEQT88GHPhLPXRu
X-Google-Smtp-Source: AGHT+IGVyFl1LH6GZDYFJUGQO864DVRHfuuOMbniNh1XSMbnQZipp5Oja/Fx1IgLXrShn81Yhevmbw==
X-Received: by 2002:a05:6000:2408:b0:3e0:e23f:c6d9 with SMTP id ffacd0b85a97d-3e0e23fc781mr4191856f8f.17.1757092448236;
        Fri, 05 Sep 2025 10:14:08 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e4e2c3fe44sm1595644f8f.0.2025.09.05.10.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:14:07 -0700 (PDT)
Date: Fri, 5 Sep 2025 18:14:06 +0100
From: Stafford Horne <shorne@gmail.com>
To: ChenMiao <chenmiao.ku@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: Re: [PATCH v4 2/4] openrisc: Add R_OR1K_32_PCREL relocation type
 module support
Message-ID: <aLsaXgZCycFI5yid@antec>
References: <20250904100109.688033-1-chenmiao.ku@gmail.com>
 <20250904100109.688033-3-chenmiao.ku@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904100109.688033-3-chenmiao.ku@gmail.com>

On Thu, Sep 04, 2025 at 10:00:50AM +0000, ChenMiao wrote:
> From: chenmiao <chenmiao.ku@gmail.com>
> 
> To ensure the proper functioning of the jump_label test module, this patch
> adds support for the R_OR1K_32_PCREL relocation type. The implementation
> calculates the PC-relative offset by subtracting the instruction location
> from the target value and stores the result at the specified location.

OK, thanks, really this is needed any modules that use jump_label, not just the
test module.

> Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
> ---
>  arch/openrisc/kernel/module.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/openrisc/kernel/module.c b/arch/openrisc/kernel/module.c
> index c9ff4c4a0b29..4ac4fbaa827c 100644
> --- a/arch/openrisc/kernel/module.c
> +++ b/arch/openrisc/kernel/module.c
> @@ -55,6 +55,10 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
>  			value |= *location & 0xfc000000;
>  			*location = value;
>  			break;
> +		case R_OR1K_32_PCREL:
> +			value -= (uint32_t)location;
> +			*location = value;
> +			break;
>  		case R_OR1K_AHI16:
>  			/* Adjust the operand to match with a signed LO16.  */
>  			value += 0x8000;
> -- 
> 2.45.2
> 
