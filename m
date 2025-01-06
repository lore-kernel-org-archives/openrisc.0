Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C071B3597B
	for <linux-openrisc@vger.kernel.org>; Mon,  6 Jan 2025 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183038; cv=none; b=BBYW1dLVlZIiUbFqLHrJQs1GUFxg9xztLRQRuvbx33jGJ45vBtf3gMZNWTWwp5qKYYrEgym9tvGY9+TNHsw70swu3pv/2y2QM0By0m9h+iYVW2juB44r8dPQq/3co6upHzHGS4Gx0BCGZlb1OJHyJFdfPoeA3PZpqINuve8kyKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183038; c=relaxed/simple;
	bh=Nwstv/+1C8fHAc0u1oy2XeuSbAYqRUVost0XZEqPkHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UeRil5ubKcw8KSvdBNmyC8SSlCIOyptyt7MUNDBawWSe8bDKnkimOIo0WyZjB8nCS9ASsHkLOQKjqyHyZyxjrSui5mJMmsMkRdX90I7QP77NaYMSvrpz7o+/qRtwoCAWAT/QfRedVVSce7BP4TN5kc+xDweGiT5dBV/Ov7bSllY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vhq6Bu3/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vhq6Bu3/"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso16632555a91.2
        for <linux-openrisc@vger.kernel.org>; Mon, 06 Jan 2025 09:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736183036; x=1736787836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNRlY6BLYSR/LALzJBHdqLgOJHbN1MMkmJfLjQQg7Rk=;
        b=Vhq6Bu3/vfXEpvmBaaOQtp/4k6yDHzuEBYla9WjVY4kXhAXuq2bMDZ8R5fpaAupuhM
         dWa2BMnnpmqOOcWH3nUpkPeDNvxAsZwjLiW7WXJpxHcZkU8DsKSp3f+BjNH7BSG+wuKk
         owiO1TJ7pBfPNsQhKaq8np8XUxdjQ6lX5T3LCcPLghAHoi1V1N7cp1ODWmJWjAmMMS2m
         vRsXR87iwkQ1qub0BuryJnAkoBTyVMad/1TCUnZamccr+Ir2ctmt65RZAMrZMGrGpIQs
         SoBM4r1OMHhbZidFofcUJl6Z1/Bfk/Q2R4NhS0oX8ivTfoVFzWw9rFXTI5oxkOsaxVW7
         +XsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736183036; x=1736787836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNRlY6BLYSR/LALzJBHdqLgOJHbN1MMkmJfLjQQg7Rk=;
        b=jZyynCqP5Hbwa8Wj6TTO1byDqjR20Vv8vCDmFZtSmVDTjoJDNSTz2ydW8C1RvAB6Cz
         /plpSJzFXxrpWPKk635i00IU9c828Ne5vzIL9qo1QDCUmhOFnS6qfgAiieQRhdrkVy3q
         uE2N0fYCj1dsNn7SeeFYnlmPtGF3NnXSuqSvuvoC9tYHAkQyoWuc+oyANTAgGCOS/hNl
         2/k7qTOMf2/jyP27kTKfxUNHNgJqq7k0SAoJB+CoaqnOmjwJZzq8x7xtxuUnrd16rg58
         uFjMnJzFIcI1JN1zhfcuWT4CsWNsM1xGIydJ6MS+AnIWP0a4jv+GCH4JA61curdMVTVO
         ikCg==
X-Forwarded-Encrypted: i=1; AJvYcCUwl5Z2ZjDKIW1bLfm2ZHRQ73v5xQX8Qv2un8rpFNrQ6ldXH6s4dP8YZ79Dmwn2uanwaVzEJrnyfuzR56gtcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/+n/Hwjm4CrX2VDmluTtQzyUgUMHnMTvpc1EyHQGMZEsLECpY
	2nw5vUB35e6zJ/ta4rC0mJubbOug7SAHKi3nP2zpz4Zx+fOpdUrz
X-Gm-Gg: ASbGncudid/JWw+fb9unljP07NzHje4Ftt5L/744s4YDTIYOY6cwNyQBqF9AJVLEDpj
	D9E4s46aKR5xWtVUzdomrvSwNQot+UOBcYn1bDqF0hz5tkh1IhgA2TUF9ndOLsquwtC/6kDIStt
	advhD08pE+m2eKpA/2bx6S57Ie3ADnzlBvBU5kFV1G+11If6pZzpIFXtTp4KzZaPQObCF3BQVUu
	6QiXTWsiYdEd0qY106j6uuL/FTPXJs8WXWFEQ2lC5q5vka6WLA7p+eNtGY/
X-Google-Smtp-Source: AGHT+IE5MUMDWBhZMRtmeNGr0Oram8Wwgry+KG7GvleBdBrVdfOQ/TVCKrcnFLJiQKO70x9iKvrfQA==
X-Received: by 2002:a17:90b:3cd0:b0:2ee:a76a:830 with SMTP id 98e67ed59e1d1-2f452eb3279mr90853116a91.24.1736183035922;
        Mon, 06 Jan 2025 09:03:55 -0800 (PST)
Received: from [172.31.0.17] ([136.60.141.45])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed52cdc3sm35871662a91.3.2025.01.06.09.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 09:03:55 -0800 (PST)
Message-ID: <cbc35acb-968b-4c98-902b-fea85a175808@gmail.com>
Date: Mon, 6 Jan 2025 10:03:50 -0700
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] or1k: add .note.GNU-stack section on linux
To: Stafford Horne <shorne@gmail.com>
Cc: GCC patches <gcc-patches@gcc.gnu.org>,
 Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20250106130117.1230925-1-shorne@gmail.com>
 <3335b1e7-5488-4e4d-a313-3e989b2abd9f@gmail.com> <Z3wMiWSBG7BJyYSv@antec>
Content-Language: en-US
From: Jeff Law <jeffreyalaw@gmail.com>
In-Reply-To: <Z3wMiWSBG7BJyYSv@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/6/25 10:02 AM, Stafford Horne wrote:
> On Mon, Jan 06, 2025 at 07:37:56AM -0700, Jeff Law wrote:
>>
>>
>> On 1/6/25 6:01 AM, Stafford Horne wrote:
>>> In the OpenRISC build we get the following warning:
>>>
>>>       ld: warning: __modsi3_s.o: missing .note.GNU-stack section implies executable stack
>>>       ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
>>>
>>> Fix this by adding a .note.GNU-stack to indicate the stack does not need to be
>>> executable for the lib1funcs.
>>>
>>> Note, this is also needed for the upcoming glibc 2.41.
>>>
>>> libgcc/
>>> 	* config/or1k/lib1funcs.S: Add .note.GNU-stack section on linux.
>> OK for the trunk.  You've got write privs, correct?
> 
> Thanks,
> 
> Yes I should still have access.  Also, I would like to add to the release-14
> branch.  Is there anything special I need to do to add the patch there?
Nothing really special on the release branches.

jeff
