Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE90174EF4
	for <linux-openrisc@vger.kernel.org>; Thu,  2 May 2024 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714675590; cv=none; b=RODC1ZARoAaROHikbNgwulxPZ5vysB/BkKLpWHxC+8J/cMMH+N7EBqZ8TPHflD1yeFNELjYJo/6oqqCfYU/rFmZ0iAJQ3VTPMd1XsvR/4Dl6Zt79Fhp0UwWtQyXUwtul07c6K3H0uz4poJXrfTxpSvG0Q+QANweRk0zk2mf8H2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714675590; c=relaxed/simple;
	bh=+POL00u4iIQMXkJWQDY+Tn/WsQozNPVc6nsLI7/y+fU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDUNBjibu2aag9fXu5vpflf4pAQROt8h67ph6My6OUaLaYvbEZ7U19gjPKTpbTm0GlK0NnBeDWfku6ceMh7zPeWbguknSxy1HyvBn5zmwHdVQs+xCIJDlkLVzJaXaNp/aImazbam4DjNpnsOf3i3vUty8qdqll+yu/forKxN21A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NWOUCsIV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NWOUCsIV"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e65a1370b7so77219965ad.3
        for <linux-openrisc@vger.kernel.org>; Thu, 02 May 2024 11:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714675588; x=1715280388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jGzacPVWZmtZuQysPZ8mbguMq0G9LqJL5wBI9mAMaqw=;
        b=NWOUCsIV3dGYOkE0pv7fEQvDl5CWLr7QDmt+6DhsDaDYcOA9Zw+DKS5PAU546nZGJJ
         LjTfvxOAVOk0zME608TGb9/tjXH9dgbA7AmP4hyhTxSyuxh4U/gcCqy8/e1NFhd+zpOG
         s4e+HkuwzqZ6OR/AT45d0LNLdw56emLc8qwEHZ/C2zegvlGMEkKzTL4zyHfw04x2qmUx
         tddO+ZPWOlH3DFMBWO0tr6QMYpPfm1PCoCiQrtFVt5JsDZT/KR+Grn/I+96o4P7byTj1
         ZlZQfSjsK6pXmGVc5bEQEpPputzZ9G/Be5IDOXg34zFI7RaTAFb8SgojIfqafIbongpC
         reCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714675588; x=1715280388;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGzacPVWZmtZuQysPZ8mbguMq0G9LqJL5wBI9mAMaqw=;
        b=i8XmXf3Fu5DxgPbbN+Hya9CEHtt0549Weu2g/001XnqqVJDAc1aTLJrBio6PFtOYs+
         80O9YzdyAQ+2WU/dwXWmE/KbwyVc/i77OYNMDLVncYKccf8mqKq7DiqNTMxex3eYX1QQ
         iUJ7m+bLBaJmKCTLvZT2jugSeHW4XllbINnTKTLhdtkmWSmo0ZmwkulldcGbAWSOvPKq
         PJHiZFGA21oTCK86onLJgomImpCpWuQ7H9soUDREIdVLo7G3IBwnQYP1HqV7N37G9+B6
         +z10ZatVx62Hp4xbPs/ab/t61qby8Gmvg8ypfdDKaFlPH6QdFAw3b2jZfd4+7J3TV84n
         m0HQ==
X-Gm-Message-State: AOJu0YzLhK1awNo0GZZunvqGCv1Y800ZyQUow0ToGa2l3X52FIbGF5S1
	yzqpIkTK3FKXW7zLxxHSC4DVyh6fhA1wrkDxVvZJBIXif15NBn8Lh6IqZBjeZ3I=
X-Google-Smtp-Source: AGHT+IFBYVjKmktI/+YQczYffDs0tx5d/SW/MDzTyLo0H8Xy1WanK3cjVPyBHGQa2Z3dExpXSvx5IQ==
X-Received: by 2002:a17:902:8d87:b0:1ec:3019:c72c with SMTP id v7-20020a1709028d8700b001ec3019c72cmr499660plo.68.1714675587878;
        Thu, 02 May 2024 11:46:27 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c1:e3c5:bdc0:8ed:f45:eff6? ([2804:1b3:a7c1:e3c5:bdc0:8ed:f45:eff6])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902c40c00b001e289130862sm1649924plk.308.2024.05.02.11.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 11:46:27 -0700 (PDT)
Message-ID: <c13cdf86-fa3b-40b5-882d-710984653fc5@linaro.org>
Date: Thu, 2 May 2024 15:46:25 -0300
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] build-many-glibcs.py: Add openrisc hard float
 glibc variant
To: Stafford Horne <shorne@gmail.com>,
 GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20240429054735.2467433-1-shorne@gmail.com>
 <20240429054735.2467433-4-shorne@gmail.com>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <20240429054735.2467433-4-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/04/24 02:47, Stafford Horne wrote:
> This adds the OpenRISC hard float glibc variant to the build many
> script.  We update the compiler for glibc to support hard-float
> multilibs to allow us to use a single generic compiler for all glibc
> variants, this requires updating the compiler name.
> 
> Tested and all builds are passing.

LGTM, thanks.

Reviewed-by: Adhemerval Zanella  <adhemerval.zanella@linaro.org>

> ---
> Since v1:
>  - No change
> 
>  scripts/build-many-glibcs.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/build-many-glibcs.py b/scripts/build-many-glibcs.py
> index 35dac538e5..38eb9f2dd2 100755
> --- a/scripts/build-many-glibcs.py
> +++ b/scripts/build-many-glibcs.py
> @@ -362,8 +362,9 @@ class Context(object):
>                          gcc_cfg=['--enable-obsolete'])
>          self.add_config(arch='or1k',
>                          os_name='linux-gnu',
> -                        variant='soft',
> -                        gcc_cfg=['--with-multilib-list=mcmov'])
> +                        gcc_cfg=['--with-multilib-list=mcmov,mhard-float'],
> +                        glibcs=[{'variant': 'soft'},
> +                                {'variant': 'hard', 'ccopts': '-mhard-float'}])
>          self.add_config(arch='powerpc',
>                          os_name='linux-gnu',
>                          gcc_cfg=['--disable-multilib', '--enable-secureplt'],
