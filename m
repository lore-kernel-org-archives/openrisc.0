Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF5F1990A7
	for <linux-openrisc@vger.kernel.org>; Thu,  8 May 2025 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746729663; cv=none; b=i15x6lPQjWkFsNxuz2MwRvNfk+21B5cim0u256TM5sujOPai5PjAZV2bTDafi0UeVWMbQsF7dXmxnGBO63v5YrcuBP+baKeQvy2XiIJB15fyPx89PBsDjCb9ktfcChRdPxoF+EaVtcywPW9twWPLaKQdETWp1T5hZAFCXWztMZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746729663; c=relaxed/simple;
	bh=FaOMaZ/2OKt2wTk6z7R7BugvogGy7+d9wGfIkRHz5Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dd09DnRj/U+ToMrOvjowtjZLOKSAHq9gjpGwfvxJVlNYLCBEzIppVzrb8Qd/V7T2CYTdfc1oMUcqZewk4UZ1/Cgx52FRc1F0qVFJVs6YfxVnG/xQXLYHSsiIty1LkJ2kk9hQdgsSAKWwmFXA3xfeYGJg3loq7n2XXsryxHobDSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P49C2WXX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P49C2WXX"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7394945d37eso1225609b3a.3
        for <linux-openrisc@vger.kernel.org>; Thu, 08 May 2025 11:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746729661; x=1747334461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ocaxeaUlKUveWZY515nunX9hHX5Z4FVhkwNeRqKlF8w=;
        b=P49C2WXXlRIM12aB1rcDgvNLOekGo2ZjjlNOIr4RA//3r1USLaUoL6jdeDE/S/rHBY
         1IkzPN+rYLMpgsQb/f418MmwYsufrCq0fTv5CG3EOUXskgnzt1EC+8WuMvf1CJPpDXVA
         lXg5fm+FxaOy5Jpq79C+gZmku77Q48MjM5uETpqK/prlLMLfZMI1Le4eiQGq9NCGaDDi
         XvPUsY/MXIR+agFiAUZgpoLch6fEzRsPAvrkPedJHnN+mK2RfXWypTqL7VD5kc8Z55vF
         rIw7x3rDPTtrMq/9UY0hHBRiBqeW6gkiJOqxl5Wx65gn64oAw+pUhYbI78azueggABzT
         3oNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746729661; x=1747334461;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocaxeaUlKUveWZY515nunX9hHX5Z4FVhkwNeRqKlF8w=;
        b=k3aqjmm8ybdlwPXP+WzbKzQulCBB0zJruQSMrfQ6w+4ArlKuVQrUWTQnqqPU8co/oN
         EnzpPjrsiawmpqZhPx4y9lY0WtzXwV3zzPy2SNOZiuh8o8XHw+UojZXMtR5MyEYe+KZE
         52xrVtNhXYGr+IBquOANOQBAQxHZT2gOMWFDZdR3SkUUJIrRHGU9iaRaN1xvW/O5TwWQ
         hVJ5wjDWtyQtq3D23MvXMl/v3a+hDW4Amv3f8DTbtRhhXLD9PCmc+CiZAZi/TtK47Pmy
         c4vAkHepBm2HjqSI0z7Q8t3nPSMZNkpRukfWyC7H42GwjbvicxWPWgYEHbHZUgXHTAnH
         cgfQ==
X-Gm-Message-State: AOJu0YyS/uTBFbnYoBF1sBCMiRPURWqrm62cxGgKQRo0q1Qnn2iWzo1t
	JKDdZcSAc8r5ZXsjqZJEHqBmqoA6MJyx4eYJBWPcMN+ipZFK/VTM
X-Gm-Gg: ASbGnctw1NF1MopIMVMCe1HylopW0vA24VNNyNkOlutez1nZTVHznl4XL+9ucIZWjyu
	DOD+qeqFroQNlM5YJL8ItVXmHTS+v/00gFPj7s3N4Y+9oaP0NB3D86S2jQoURrcDq769pvpESrc
	6J1dsBKGAqsaBvriQJjRgFSQOU5zMic2Xf/uVGUUdmjRzML/5THIL/q6cM5nDtCorXc1R98BKSs
	4V8CvzZ49HpUUotPGuLlIKxgmBEVvecARUBiodgNUesb3iXIu/w/ALOUE16kk+5uNbpDEQY92Sy
	XdPMyVcohV3B+XSFnv/p0fLW8Fu1+qmYyYQTneZwEDke/0JYs9NhTs4V3VFGIMdAb/SnxxhxlzE
	eh7g/kyqp
X-Google-Smtp-Source: AGHT+IGnU7efhIpUfhNGsDcoysE/0VD9CNWz0pm7PvqDtQtXZK266jdVASNzZDdm4Vt7soKv5vzblQ==
X-Received: by 2002:a05:6a00:a83:b0:736:50d1:fc84 with SMTP id d2e1a72fcca58-7423c075fa4mr420263b3a.21.1746729661010;
        Thu, 08 May 2025 11:41:01 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c44:36f7:ca41:f096:f228:c06a? ([2401:4900:1c44:36f7:ca41:f096:f228:c06a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a0ffc2sm345715b3a.102.2025.05.08.11.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 11:41:00 -0700 (PDT)
Message-ID: <278be55b-49e8-41ae-a7d4-c0eec6f1d90c@gmail.com>
Date: Fri, 9 May 2025 00:10:57 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Queries regarding ftrace's implementation for OpenRISC-linux
To: Stafford Horne <shorne@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <e9f74ae6-10f3-4585-b727-928bb5749dd9@gmail.com>
 <aBoks-Muf4CxQvhv@antec>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <aBoks-Muf4CxQvhv@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stafford,

Thank you for your response.

On 5/6/25 8:33 PM, Stafford Horne wrote:
> On Sat, May 03, 2025 at 09:44:54PM +0530, Sahil Siddiq wrote:
>> Hi,
>>
>> I have been looking into implementing ftrace for OpenRISC-linux. Based on what I have
>> understood from the ftrace design document [1], mcount will have to be implemented in
>> the kernel for ftrace to work.
> 
> Thats right.
> 
>> While this document is outdated, I did come across an article in the Linux Journal [2]
>> that explains the use of fentry instead of mcount in the implementation of ftrace. It
>> states that fentry is a powerful alternative to mcount. To make use of fentry, GCC's
>> -pg flag needs to be used along with the -mfentry flag. Simply calling -pg results in
>> mcount being used.
>>
>> Should it be possible for ftrace to make use of either option (fentry and mcount) when
>> implementing it for OpenRISC? Or should it only use fentry (or mcount)? mcount still
>> seems to be used in other architectures (I have only checked MIPS, RISC-V, LoongArch
>> and ARM so far).
> 
> I think we should stick to mcount for now.  As I understand fentry is mainly and x86
> feature now.  We should be able to get it done with mcount, as you say that is
> what is what is used by other architectures like riscv.

Going ahead with mcount would be relatively simpler especially since mcount is already
supported in OpenRISC. I must point out, though, that I overlooked the following
developments that have been made for other architectures:

1. Ftrace with fentry for s390. [1]
2. Optimizing function trace for RISC-V. [2]

> Another point is that for ftrace to work it uses a kind live patching [1] to turn
> the mcount calls to NOPs when the kernel boots up.  Then when we turn on tracing
> the code is patched to enable the mcount call.
> 
> This live patching covers:
> 
>   - kprobes - adds single instruction break points into kernel code
>   - static keys - allows for static branches, i.e. the check for cache enabled can
>     be done once then code re-written to to make certain checks go away.  We
>     could use this for cache availability checks.
>   - jump_label - low level support for code patching
> 
> I think before going to far with ftrace we should look more into OpenRISC's
> roadmap for all of these.

Understood. As a first step, I think it should be possible to support some of the
features in the debug subsystem - k(ret)probes, u(ret)probes, optprobes. Jump_labels
and perf-related features (e.g. kprobes-event) can be built on top of them.

What are your thoughts on this?

Thanks,
Sahil

[1] https://patchwork.kernel.org/project/linux-kbuild/cover/cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours/
[2] https://lwn.net/ml/linux-kernel/20230511093234.3123181-1-suagrfillet@gmail.com/
