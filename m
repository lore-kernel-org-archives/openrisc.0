Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D07182D2
	for <linux-openrisc@vger.kernel.org>; Mon,  6 Jan 2025 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174283; cv=none; b=k3pZ7gawGBX7vOcKbmox8SwNHkoiRx7chZivK4DQ1YHnHxAXQ1/a8gFXbs4Yp0YO7nDJy/S5bsnr+JxHCEYYkWTB5EURRuoQVA8LxNqpUJB5u8K8WkmBvsmSr3fPueKsuVeul5WoBySyh8pMNjGV8T4eAtjHmMV5C+K6cCakvQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174283; c=relaxed/simple;
	bh=KR7/p1tWxV+V8Hoc8wqEDEMtvUVw4Ke8M85MSQiUmMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0So9A8mZ5jKITiVOkGAQYIroznnj/+n43STSQ0Kb2jZ4wmijQrdM5xQmozXrD2baH8Npwb4oLfYxlqnlR2m0nnfwWHSN+90AFyGS+d/EBSO1bh94NM4HmvPUOBQEKcqWPHRHUGdBB04kVClbrQlaz4scbzQu7Pq33s2dWk28os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+KANoby; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+KANoby"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21654fdd5daso193413705ad.1
        for <linux-openrisc@vger.kernel.org>; Mon, 06 Jan 2025 06:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736174281; x=1736779081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pSJC2s0MA1gDBlI7x+jEWzXg3kOxe4ocHpmZdFBU2TM=;
        b=k+KANobyM5YuyoDasGjtF3goOajEU7sTDUffqWnrYLCTPepSXnLNRPPMB28+FZdIM+
         ladBLWg5qcL4cc36iwqmg9lRBVyTPK1vhg56GKs89wMkzrOxwSWljjuH5uRoJfkFOkW9
         Hk2nhQk50LronuZCmiiE4OSprFMfEV67C3LcdLEIbXOS7YB0iRmmXK89kbTjPMMzKIzM
         fdpaLGe4JSw+s5hXtwTzLGQ8BFj9S7DpVG9hOGsqwTSdGlZeQerHSR/msSlcKSbz37BC
         Wiv9z9bxljbzKiwJiLfO65rrGB6tn5M/JfwMRPwe8VxF3A8UIJuLNhsWyvwy+3bq3UNX
         j1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736174281; x=1736779081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSJC2s0MA1gDBlI7x+jEWzXg3kOxe4ocHpmZdFBU2TM=;
        b=nUJ6poqjezVlPWDvMkMCL9rFomn8g7sPO6y0DI4p+QyMf19c5+0TtOpGhnwMC0oQ1A
         NYRTETMWdXbyDf0O22OZ9ZYNK8wkOtMVTg01huEgAXcOsK7QrBYX8gCKnHvD7WqOwHtz
         PqQSgzcpzRTTP9oZVMrXaiILVBhFzNEPpS6zfd8FIQhxPCWu8pe5pcpkqWkGNYfpI8vK
         WSU+xJSHPq0BZpq6Qgznnf5jqeqeHJHhPSKRaokDEclGC3Awb/BM18Ya3ygMaZ+cMSOz
         8jD3D0xYk4G6wXUffTb81K1AhygaXPfeP8zkJCbjd+tscrDSMCAXKxwzGSEM6Ase1lf7
         wcbg==
X-Gm-Message-State: AOJu0YxBmLOfnr6rRkFj6fDkUsvx8WPXFDXCS6zA5IdJoW4eanpQknD6
	aeMs9chhrOEl7DTxJ5GF9ga/8+YtXN8uTVvXm3avhXGTnje8GYzvJWIFGPeZ
X-Gm-Gg: ASbGncs5Sd3aDmrPf/+3XedyixvUKdLJ3qE7wMrlOrgPshCzOd3bLwEeIl1bE+fYFUI
	FJgdPkG2rTbpCbkuEcGQG+xCDFLQXJO/JhAgrxeCmvJmxE0T6odyftL/kHpfbXeHR3t+Ymk27l7
	/M9KzPXfsFfenbPomLmD3L+vo453nWxy0pgXp7C51HyliRQTmW4D96DkYDRD23HC8ZUoqT8ycwu
	fhaKSfXZZWFFo3oy1Z+79TtKQO7R0nqEuT9vLmRdklDoXBzHA+eD4GVV8nY
X-Google-Smtp-Source: AGHT+IGIVg9qJDfK+au2ttG+ROuSwzzEyTPtaNJ0mHyhukLKMR6TrMFK2kZYgkajdXqyY3bccqUZnQ==
X-Received: by 2002:a05:6a00:23c1:b0:72a:bc54:be9e with SMTP id d2e1a72fcca58-72abde30d9dmr74968264b3a.15.1736174281084;
        Mon, 06 Jan 2025 06:38:01 -0800 (PST)
Received: from [172.31.0.17] ([136.60.141.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad816312sm31618711b3a.1.2025.01.06.06.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 06:38:00 -0800 (PST)
Message-ID: <3335b1e7-5488-4e4d-a313-3e989b2abd9f@gmail.com>
Date: Mon, 6 Jan 2025 07:37:56 -0700
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] or1k: add .note.GNU-stack section on linux
To: Stafford Horne <shorne@gmail.com>, GCC patches <gcc-patches@gcc.gnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20250106130117.1230925-1-shorne@gmail.com>
Content-Language: en-US
From: Jeff Law <jeffreyalaw@gmail.com>
In-Reply-To: <20250106130117.1230925-1-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/6/25 6:01 AM, Stafford Horne wrote:
> In the OpenRISC build we get the following warning:
> 
>      ld: warning: __modsi3_s.o: missing .note.GNU-stack section implies executable stack
>      ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> 
> Fix this by adding a .note.GNU-stack to indicate the stack does not need to be
> executable for the lib1funcs.
> 
> Note, this is also needed for the upcoming glibc 2.41.
> 
> libgcc/
> 	* config/or1k/lib1funcs.S: Add .note.GNU-stack section on linux.
OK for the trunk.  You've got write privs, correct?

jeff

