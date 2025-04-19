Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA134690;
	Sat, 19 Apr 2025 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745078116; cv=none; b=ECq5psNb/mnKWkOjcxycBuIgDIpEpJyj5WrHUMklbX8qYYemALoisoEmOegiVvVI2x7uO4nSnJqUVgzlwpPnQewt9RYok1F2bwcsSY7vjL2cwY3cSUR0sjbl0XMFcSwnduiZNURn4m2SMPnQ6J41hyFjPldMWMwK5kfrfZ144uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745078116; c=relaxed/simple;
	bh=pE/Q85OA1D/XFhJ4cmJvxxawoCjHK+f7evwvSJetiHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4WWTNyGsi+4rMQf0M8TMQHgQyJlMBf7jvj/gfAnEvmEh5PYx3HYN4O8R6+V4ejgZI9yI3+JSMg5KABptjIOlKPvkdVZ0D6QAS/VatDkA9H3FUkdckOBHXbk/fQQdnMcgXHbzP/s1rgwYk+TvG6JKeXciCb/9owPQpqnOdev/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1Vf/Hvi; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1Vf/Hvi"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso3517421b3a.2;
        Sat, 19 Apr 2025 08:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745078113; x=1745682913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=znomYM9m1Ugt/LBNh6+rSp8Js2/EX9Ujpz1Sp3XizdA=;
        b=Z1Vf/HviL1q3WmGGdQjb+tIX/Vie45RQMA+WbNxIvc/QSPKKkTEeZnBcDtJzg/Sv8H
         uWCfGfTRfiVbdXf3jCPgt6x2scvvLbkUC2gdj+dm1/kj1hgYo+ZMgi333WSRIqVuROir
         XRtGj8r2a5pSrVpYpbPF6/CmPXEamsMN/K2wSmfll0FdbOokl5fo4jKngKaeR6gGIw71
         4WyLgBLvHr80+Tg/TsEUEx8DBvpsCQEYjOlCYWgHPAewlJFFiJvnuoxM1QjHJY+PqZfM
         YLwevk6GJdCI8yaO+/B3Ara4+x+rgdCi8uayqX7oaSqEyOR9XjZc4MHoABSwvRcuG7w3
         SazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745078113; x=1745682913;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znomYM9m1Ugt/LBNh6+rSp8Js2/EX9Ujpz1Sp3XizdA=;
        b=Z2+k86Ors7ILWHqnsA9gzRXOZWzIX7vfFYbYrKP/OqHQZn/2BnA0aLeINfyerdeycv
         s2UFRp0A7kEUkZeiQZvaWJpdjnNiEj9LyeucUXQIQRKnICgi9ur8r5TINdnSHfC6qyzC
         G4zAN5APrDpahle6E3VGJGt20f24rXLeB3r/brD6egJ7mnOx7OjPhAccVj5xBsM/HLg6
         CsGK7bHXhDroXSx1M5/PWXl3Gkh7AUxzo3dHRXAiPlk9p+KsiedmQOh3f8Fdme2RJW7u
         kFGXi14aSuta7rHZFe+GfFCzZV+Mh0w+39fLlfwv/AumC7Ynp1P8lU1AskIBwM1cZ6It
         zALA==
X-Forwarded-Encrypted: i=1; AJvYcCWJY4S2LI6YJ8cLsmeiGPP/n4PuCK+lIIZ+9Uia//+xQQIa6Y+/PVSHSJur2wmcseCRGUPzXW5Yl6lUYno=@vger.kernel.org, AJvYcCX5mzrzR+EBDzFwNft9nbYdOErjuIynF2es/iQYpWo09aoE9uLMZtUrp9I8iQiA1e4gUBQJU2CvqhMg0/fiCu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Et0rUmjn6xjZmJZdVYQfopSq7ky6DybkiYqN0dq+Ss/0oWGr
	kbAIBOWRAJno53BVGOZvZGK+ebBCDi/blcUqFRtIWu0E3JG8NagD
X-Gm-Gg: ASbGncuHvp6NiJlFie73b7hUSKHhPqZDY++WJFO/WG8Egn3gohrJrqac6cbgMLoa575
	8vOmoEdNWwWbPEWB5MWQ91izzw4F6Wmbnx2BH+cJwh5QqgLub59avquvBAkbV27aO6KIwevub92
	3voFtUWLqBG4UiHnTThUJzizMdKuDAAnUVhg9V7r4LJ9gvs+LMqtBkptQMFIwOvcLzWeTUZMQ7Z
	M2klJm3cLpSYYsmwXDz+bJN7/lQjpejkPYo1fIKjWSctHrxS+wnDpBmYKWKxJlVuBSqOQMNhJIt
	R5GT/TL38pW0n0IaJvvslo9l7KwXHw9yg2a0JeLWqoWIG014HEsJ4CSWr6AvjNNcF0ABF121uhY
	Y/UXVi6srXe6esXPAGiw=
X-Google-Smtp-Source: AGHT+IE/ogYSCv6X8AjWJ6MbfCVRTYErkrIod4HI085LRvL9P0OX4WHg5/1zTcRkwXiVG6HEE8cENw==
X-Received: by 2002:aa7:88cc:0:b0:736:eb7e:df39 with SMTP id d2e1a72fcca58-73dc1604f0dmr8798128b3a.24.1745078113204;
        Sat, 19 Apr 2025 08:55:13 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c45:45a3:affe:4635:b6b6:1a76? ([2401:4900:1c45:45a3:affe:4635:b6b6:1a76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e4912sm3572952b3a.60.2025.04.19.08.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Apr 2025 08:55:12 -0700 (PDT)
Message-ID: <a6a154cd-ea98-4d27-a9a1-e8b39a5c77cc@gmail.com>
Date: Sat, 19 Apr 2025 21:25:09 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] openrisc: Fix build warning in cache.c
To: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
 sahilcdq@proton.me, linux-openrisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20250401200129.287769-1-sahilcdq@proton.me>
 <Z-6VyRhGdInVidsw@antec> <af85b465-13e5-44e5-a0af-c7c68af7d43e@gmail.com>
 <aAIDfcZ4XD5f6mA4@antec> <f6f4f410-4a0a-4ce3-bf41-413af39fd50e@gmail.com>
 <aAIivK7NDG-6_aIU@antec> <64beb3b4-a8fa-4acd-a139-6c19de0e37f4@gmail.com>
 <aAMwri9RK2oNuC_p@antec>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <aAMwri9RK2oNuC_p@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 4/19/25 10:42 AM, Stafford Horne wrote:
> On Fri, Apr 18, 2025 at 06:04:29PM +0530, Sahil Siddiq wrote:
>> On 4/18/25 3:30 PM, Stafford Horne wrote:
>>> On Fri, Apr 18, 2025 at 02:42:20PM +0530, Sahil Siddiq wrote:
>>> [...]
>>> Maybe using another email in signed-off-by would be better.  The current
>>> patches are on linux-next[2] where we can see the From/Signed-off-by mismatch.
>>> For example:
>>>
>>>       author	Sahil Siddiq <icegambit91@gmail.com>	2025-03-29 15:16:22 +0530
>>>       committer	Stafford Horne <shorne@gmail.com>	2025-03-29 10:22:21 +0000
>>>       commit	af83ece87a1ef5097434b7c3c1fc0e9e7b83b192 (patch)
>>>
>>>       ...
>>>
>>>       Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
>>>       Signed-off-by: Stafford Horne <shorne@gmail.com>
>>>
>>
>> I agree. I have another email id (sahilcdq0@gmail.com). I can configure git
>> to use this and this can also be used in the signed-off-by tag. So, this id
>> shouldn't cause an issue.
>>
>> Let me know if I should send the series using this email id.
> 
> Yes, please do this.

I have sent a new patch series. The email ids should match now. I have also
addressed the build warning that had appeared earlier so those changes won't
have to be made manually using "git fixup".

Thanks,
Sahil
