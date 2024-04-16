Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07BC1E876
	for <linux-openrisc@vger.kernel.org>; Tue, 16 Apr 2024 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713297375; cv=none; b=oYj4XyTwMsg/5KZxm8tEnYdgOHHsK70SR0+8vzUOHShFVw510MjHlY/h0Vq+rHCajjGBKJzNa3IummOfVFEoe3KwGit7rx3fpRIdacV+rEITlyIeJABBIZd6fZGzhcpxiFrC1X6txFzA7j7YvLECabtPhuUDkdHVRKA00Pq67CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713297375; c=relaxed/simple;
	bh=7fYNHK8M1oovRK2Q1L1YkAblGak0UdiKzimaEZYAXbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bphwwZHaxEzb+qoaJ52EamKl4ah38M3EQezk7QOmSdOI2s6DJJE2UT3iDugPdnL7ga3ZRzVvydAuXX72vLIfwtrsCVKJkIIq0ylTkxMjSvGRbdFwwvsa0TBhm5vhMTt1XcbNTXS8xwbb0nFAmZX+tbGRbXiS9hQMIrysXVbHoS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nn77D4ca; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nn77D4ca"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so2779200a12.0
        for <linux-openrisc@vger.kernel.org>; Tue, 16 Apr 2024 12:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713297373; x=1713902173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAnCmcN6xnVhrd4CSIkkePsiImJt3DDntYqU0n+R3Tc=;
        b=nn77D4caVioEpy2fGB83mrn0bDBXW/qNxCBLPhc9gm17VnCJDRZkWFv47CvN3WT9HU
         iUBNZ3eRH4qqBl/zfGRZvZ3WjGbDsvtHb3sVZw52W7WWvqB0WnL+tLEIeWFp3AnJvoxa
         GGs2Npnb3OHc60fSRJ+Gf8eG/BXCTr78l0sJlKMeCQc96AJ4Zo7nFw7482jweHjDZGag
         wEP93eIh+x01jgAjoSshQ50tzy0ga+oz/12nXbp2jwgSGSLGOVA2gH3HMcR4F6oCsrUZ
         PfEk1UppZE91++hW/5gpTew1NjQQ4GuJz/WNyFBJzYRWohO9CfXMKDcXLDM2ozlLbiaM
         8n0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713297373; x=1713902173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAnCmcN6xnVhrd4CSIkkePsiImJt3DDntYqU0n+R3Tc=;
        b=rtiA2ahHIl/UO4/fD4tBtEJzSXTIY/i8SwKupvsvbNgzjmNjnZlYgkkQidOXybv0C6
         fnOt3aSYPNLMsvv7bRf4geTT3bjKxeXHJhJx7q1CsBjCMuS5zBigy/crMGmkcFBV9H5m
         5HebdFdYwBw/G8fkzhgtOvAxHcdbGFYUzdJsZ6qbDExssyQGvb8kFAxOuC0WyJByMsj1
         w15RzWknqnQldQZDeIG8ZqHoEyz7pPZUB1ffqBzgVXS3DbpfUi3g/VBPlgnx5fZNt7qw
         r7ErjvslT49QOkrnSKUk/yMxhGKaSpkEwbNCkgj4MydmLfu4eBgoLV5RYrfeh4YIjfSx
         KrFA==
X-Gm-Message-State: AOJu0YyS3k3rGAO33saqYD5jJ2wJDR4v2+RExR+f3aqX6+ES27kiVT+P
	1t7j+ITwPTowgZsMo4vbS5xlsSh0bEFBDg6fPlcqNQs3FpkWRcqeKY7myNxQU/1FRAKjRePBuJ/
	g
X-Google-Smtp-Source: AGHT+IH8sGlGQiD7ag78va8IEy1E7PrW9oM5vYkDWinbSXmXmVQWx59T3i2LyAt5bRFwCtj9RGh2dQ==
X-Received: by 2002:a17:903:40c7:b0:1e7:7853:5262 with SMTP id t7-20020a17090340c700b001e778535262mr7270014pld.56.1713297373196;
        Tue, 16 Apr 2024 12:56:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f54b00b001ddddc8c41fsm10113224plf.157.2024.04.16.12.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 12:56:12 -0700 (PDT)
Message-ID: <1cd9db5c-fd3a-45d8-96d5-227ea720dab3@linaro.org>
Date: Tue, 16 Apr 2024 12:56:11 -0700
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] or1k: Add hard float support
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Stafford Horne <shorne@gmail.com>, GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20240329074044.1961252-1-shorne@gmail.com>
 <20240329074044.1961252-2-shorne@gmail.com>
 <4fca2ce2-2a45-4021-b91c-3e0c9dd8f6e2@linaro.org>
 <b3bf9676-ddc2-48eb-9c94-7512281155a3@linaro.org>
 <9870848e-0b2e-423f-8dd1-4bed6968aeda@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9870848e-0b2e-423f-8dd1-4bed6968aeda@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/24 09:20, Adhemerval Zanella Netto wrote:
> Right, it was not clear from patch without dig into the ABI documen
> itself.  So the only thing I am not sure is the mcontext_t change.
> Other ABIs added a symbol version to proper handle it, so maybe
> OpenRISC would need something similar.

Yes, I think some compat symbols are needed for getcontext et al, since the size of 
ucontext_t changes.

I think softfloat glibc should populate the same field (with zero, since neither 
exceptions nor rounding are supported).


r~
