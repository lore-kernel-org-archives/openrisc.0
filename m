Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8323D561
	for <linux-openrisc@vger.kernel.org>; Sat, 10 May 2025 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746865119; cv=none; b=aJr3XCisZ0uoa4EuryUkMkxjzeK5EEv3rHjFxY8Tf0UoxZNZ8aEFt2tDbYfBBAcXhx+tVMcfKfy7U6tiXGkEa1UqMXKcNqC+I9sDPUgOtdR04YvDqx3u5i8WGO5ZFdGtQ2K42jNsHYyGYyMjHont+mUA8HSglLBhkqqgNbABYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746865119; c=relaxed/simple;
	bh=hnMK1vEZFUqIWLNjtf5VhIKw+JKLzNHiMITzW7SeVzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8rzltK2rRdYrrE+mT6jMLjcCI9F9wW2FTeSUI2mSpuTzwT9hsirJQvHkfSIa3Qu1QoJYokrrlODazd1AkJT8DZF9J3qQ7z6CXGmum6WNnXokynCNEW8EpimZMUHO/NZOZn8b5yJZJAmTg2nDdDoKU5MT2ozbrhZLygDZavzu4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WP/Zrp4l; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WP/Zrp4l"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7398d65476eso2454473b3a.1
        for <linux-openrisc@vger.kernel.org>; Sat, 10 May 2025 01:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746865117; x=1747469917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=115LGnGCQYMNN2xU4avNh59MR5eVrIxKWRWx2EwvjlY=;
        b=WP/Zrp4lp/wyo/de9tCUoEBvBi7mjDRkwreus3Tr2NXlKhUpBOvx9fCW42TiSqYxW6
         o0nGLlvKn9IC/eFMq8Agsu+A0wxiXaQsJOwy86WXRY45rXdDMQSOfsP+g1mBa6KbZkz9
         oVlvMPK63Bk3UeK479rsdHUwXWEyWtuoEv5dmhoRy5bm/Yh/j7a1iwQf2M9dGNKasjho
         D/8FXSzsXtPbJF8cDgOwJy0fmoUTGpo2bFo8lZVbGOFYlc6/oNnZuStobjroAs6yPRJu
         AOhZ7Kt9GSpaIKB3qUvb16A659avZiPWcn5eENoGJj+SyQCH7SNFySikk0GwJQaX2XIm
         jz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746865117; x=1747469917;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=115LGnGCQYMNN2xU4avNh59MR5eVrIxKWRWx2EwvjlY=;
        b=nMltWwfpKd3S1egQRLyhSoWReg29rxMRYNE1IhA3yWp8UViqLSmfsSqfLD6OLwjiMY
         Ba4Jgo/g1oPosNESMC362jFjymYUpuO4eO3W2yO1bK1lWbl2O5tLfx+dPr5FyF9HnMFs
         P3hKX6WJyqXYLuUYLZ8KpzK0fmjhHM7SzMXrWe5BmB/zsWVxHo2DOnJlT9nOV+yabDQg
         pI6CWw3SwG9SF94uQkk7EKuhe+CwauxI2Vbr977aEQad8zRDNTD4jIUAdS1wA5KFOYjk
         JygdflJBS8nm1DBogG8iLwtZht+q8m+1H48i76c9wtc4cM0hYrTAqJ6XoyqvzmS+P8Lv
         gCcQ==
X-Gm-Message-State: AOJu0YzZHLGiDgKHDqJPcIJgEM2nRSuv08JMG9M1kLmtQKkuOX5n6QEC
	UagwGuAEgRF+7NIkauG7WmKryOpx0gjtvdwzRo79rcZAFwcVWv09+odrLA==
X-Gm-Gg: ASbGncuuflxJAsK+OzCnmbufrYwOD3nq/wdeLXdm2XE039MNEh81RubREaOzCoOA1yH
	9G31gT38+1rNDWn2ghPrGrILxiDUNhuHKT7pcsPQoLdHK8voS+jZtcxpMjJ8SBZHVvSUIols3hu
	GgEJjbMMj99HxdPwNB/jB8/lB9pUUItA0Z8Q+Y19L3eu3yfuKu9AE8JdAtX8t7JPWPg80NAKica
	DBX0xHob/5mptiJHErRYCqO7F22GKYIdML1vFKXfvLDmzkP0pBklUK6LFfhxAnMhuupcKbafiQI
	3rxUR08dg3sRDb3tY8pIYPdqUPKB7T4q3IEwIN/gvI5JBzMlU1veRJbuSFX2aiQ5307WHjmwyN1
	KP3MzNf24pvn7yNcvQ+IB4Q==
X-Google-Smtp-Source: AGHT+IGfOB8K/LXXKqLbKm7W3rvVVYG/SnI2zCDJWqAZKWT9MB4KxVzr/FvtmjMuJvjjHyD9KdxmqQ==
X-Received: by 2002:a05:6a00:6383:b0:737:cd8:2484 with SMTP id d2e1a72fcca58-740a9318f65mr13000536b3a.6.1746865116668;
        Sat, 10 May 2025 01:18:36 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c7e:fd:dbd5:746f:e581:917? ([2401:4900:1c7e:fd:dbd5:746f:e581:917])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a0d007sm2928139b3a.96.2025.05.10.01.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 May 2025 01:18:36 -0700 (PDT)
Message-ID: <51b89c55-ee58-461d-a2a0-5c8dd8ba77e7@gmail.com>
Date: Sat, 10 May 2025 13:48:33 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Queries regarding ftrace's implementation for OpenRISC-linux
To: Stafford Horne <shorne@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 Miao Chen <chenmiao.ku@gmail.com>
References: <e9f74ae6-10f3-4585-b727-928bb5749dd9@gmail.com>
 <aBoks-Muf4CxQvhv@antec> <278be55b-49e8-41ae-a7d4-c0eec6f1d90c@gmail.com>
 <aB5Qe9EpVSYAf60G@antec>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <aB5Qe9EpVSYAf60G@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/10/25 12:29 AM, Stafford Horne wrote:
> On Fri, May 09, 2025 at 12:10:57AM +0530, Sahil Siddiq wrote:
>> Hi Stafford,
>>
>> Thank you for your response.
>>
>> On 5/6/25 8:33 PM, Stafford Horne wrote:
>>> On Sat, May 03, 2025 at 09:44:54PM +0530, Sahil Siddiq wrote:
>>>> Hi,
>>>>
>>>> I have been looking into implementing ftrace for OpenRISC-linux. Based on what I have
>>>> understood from the ftrace design document [1], mcount will have to be implemented in
>>>> the kernel for ftrace to work.
>>>
>>> Thats right.
>>>
>>>> While this document is outdated, I did come across an article in the Linux Journal [2]
>>>> that explains the use of fentry instead of mcount in the implementation of ftrace. It
>>>> states that fentry is a powerful alternative to mcount. To make use of fentry, GCC's
>>>> -pg flag needs to be used along with the -mfentry flag. Simply calling -pg results in
>>>> mcount being used.
>>>>
>>>> Should it be possible for ftrace to make use of either option (fentry and mcount) when
>>>> implementing it for OpenRISC? Or should it only use fentry (or mcount)? mcount still
>>>> seems to be used in other architectures (I have only checked MIPS, RISC-V, LoongArch
>>>> and ARM so far).
>>>
>>> I think we should stick to mcount for now.  As I understand fentry is mainly and x86
>>> feature now.  We should be able to get it done with mcount, as you say that is
>>> what is what is used by other architectures like riscv.
>>
>> Going ahead with mcount would be relatively simpler especially since mcount is already
>> supported in OpenRISC. I must point out, though, that I overlooked the following
>> developments that have been made for other architectures:
>>
>> 1. Ftrace with fentry for s390. [1]
>> 2. Optimizing function trace for RISC-V. [2]
>>
>>> Another point is that for ftrace to work it uses a kind live patching [1] to turn
>>> the mcount calls to NOPs when the kernel boots up.  Then when we turn on tracing
>>> the code is patched to enable the mcount call.
>>>
>>> This live patching covers:
>>>
>>>    - kprobes - adds single instruction break points into kernel code
>>>    - static keys - allows for static branches, i.e. the check for cache enabled can
>>>      be done once then code re-written to to make certain checks go away.  We
>>>      could use this for cache availability checks.
>>>    - jump_label - low level support for code patching
>>>
>>> I think before going to far with ftrace we should look more into OpenRISC's
>>> roadmap for all of these.
>>
>> Understood. As a first step, I think it should be possible to support some of the
>> features in the debug subsystem - k(ret)probes, u(ret)probes, optprobes. Jump_labels
>> and perf-related features (e.g. kprobes-event) can be built on top of them.
>>
>> What are your thoughts on this?
> 
> I think its good, we should start working on this.  Also, there is another
> person who is interested in working on these features.  I will ask him to reply
> on this with his thoughts and see if there is a way we can split up the work.
> 
> But please start your progress as you can.
> 

Sure. Based on what I have understood from the synopsis of the GSoC proposal [1],
the focus will initially be on jump_labels. So, I'll start going through kprobes
in the meantime.

Thanks,
Sahil

[1] https://summerofcode.withgoogle.com/programs/2025/projects/qYsJ8YEg

