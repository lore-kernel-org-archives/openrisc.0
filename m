Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B0613D504
	for <linux-openrisc@vger.kernel.org>; Mon, 13 Jan 2025 06:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736748735; cv=none; b=K1aaVe7WeY0e6MfhbuFj9bhlUye4xDQRrEm1pWB0rjc8+dbe245HBXdaZmESJnogMMc1C85fIvzjWxG0PYV4wxjTGA7dKKw4xw9RCVAuYym5SN6UQx7IC4AN4Uh/rKfWXvyL9m95MM/Gcxbu9JFKXfwz+8H0fx+okYngpp9tHY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736748735; c=relaxed/simple;
	bh=LQg0fZd7KSXvaVzW3BtZ58EogbfXVm72YH9Bj2g+cpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zxzgs/P3rJXteAWaJg5lqlyzSLoOhdIBPpf7ICW5UeXbTOJAWBfBMvHq8hwjf6E3C7iXgcVh8+VuwCu6NTaU1vika8fVmRgMCWwU46HTbnpn/Z+OunUdrpRtchBkQCU4AB0dHDSGYvPyygenr2Ylgs7loxiNV2ojZW+cVKfm09Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQMTPlzA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQMTPlzA"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21644aca3a0so84822705ad.3
        for <linux-openrisc@vger.kernel.org>; Sun, 12 Jan 2025 22:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736748733; x=1737353533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1ekBqqECCwet+iw5zYPbRUkLq7yhXDrWyhqnzRkK1c=;
        b=NQMTPlzA8MVyDDXhrV/L5UdSwy/IaSLg5kU10PX+ahJbC/PxhYPCVA8pnu0QEqUxvB
         HH2CkjOvCFhhGnQQ03MNa5eisgOG7QP9SyDhGUssOn2YoST4nzuasnBZl+SLOnN6Y9w/
         zaPtoPzpVGOhjTcFNKmF2I2SyUT9/KfYQ1y98O3hyi8NSCBe8VeVMWaZSRP6g/zZCY9p
         b0w7UlQBMRjNrbwYFbeVWpBtNkySSNi0ALQvfY7KnnJEBFrI2YkPxTvUZAO540a0DTFl
         pGnqgFYp9olBtRblVLZEr9yDhphj7lMDQQG0B3Uurz7vAQlHmxtzp8zBk1kPro1fmx1b
         tvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736748733; x=1737353533;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1ekBqqECCwet+iw5zYPbRUkLq7yhXDrWyhqnzRkK1c=;
        b=naxa6Ddj5I/SNxcEyjF4Zk3CFnFJtvry9aaehxeHB0mFUOB/DCGGIO0wMBKpfJySJy
         jpjRR49etxPITIg/OmS1ixRZgDycfe84HN8UsS1p+LpE7lP1xurwbBPeRVeDB5cTh014
         Ta3qWoQsygitq9VRgd4GJeH2akkWRcG+HNyk6Z+TGs/g7feYctZNsI0zA0arApJT3Huj
         2wIJPXkX3WsogSeCc9HOPwDHub0GQYTN2ry/9DqarWcUkkzJ3UmhuI1/V2ZCHX8fJyd0
         cC66PPja0MVRR8KeiynNy3kFbtsX9j0kA0Qa19SFnXiN1nRTjNdsGAkCRS1WHGbd+kzg
         d2NQ==
X-Gm-Message-State: AOJu0Yz60aVJan+4gJtmsLw1nVvCH8VdYkWhqCt9aUFdZ+YGxEppAiV+
	PcTPUnFQD/DlCyE39wrSdts/NXhOZDJrNbKh+wV2n+QNc2h8D1e/5NHFLA==
X-Gm-Gg: ASbGnct5C/wNkzcwx4j+mJb9MD+m7bcIes6IrQF3SZKKpZVGwQ565++evjjPs00YgMf
	EOB0MCv/qu0aaS9gNUNzKWu00ORqDsX7DxH8jGERWvahCcEiVJohM+6mbvrtvOUir/9DfQ6ghK1
	UzfjVuQvS90ovcO/7DhKpDsROkcbBef88yWRXv+JlQ0In3oEZINW8y7UYlcOaAX+V3j0bOx1AKd
	NXWF9q0uBfVUYXkpuE2Pb362g==
X-Google-Smtp-Source: AGHT+IFo4nrbge8bmDoLgkebKOO87aUeP3zQLdYsj0/NdAC+xJajgVpx5F5vg7IdPOGckkjKi6UMfQ==
X-Received: by 2002:a17:902:dac8:b0:215:773a:c168 with SMTP id d9443c01a7336-21a83f48cf9mr309642965ad.1.1736748733172;
        Sun, 12 Jan 2025 22:12:13 -0800 (PST)
Received: from [192.168.1.18] ([223.233.85.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f217b38sm46320655ad.145.2025.01.12.22.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 22:12:12 -0800 (PST)
Message-ID: <d7c3ecb8-1838-4271-be90-fa7b344356fe@gmail.com>
Date: Mon, 13 Jan 2025 11:42:08 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Contributing to OpenRISC Linux
To: Stafford Horne <shorne@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <2613c1c6-2a2f-4ceb-8adb-f819961ec61f@gmail.com>
 <Z4NvBPYCkz12k0-1@antec>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <Z4NvBPYCkz12k0-1@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Thank you for your reply.

On 1/12/25 12:58 PM, Stafford Horne wrote:
> Hi Sunil,
> 
> +CC List
> 
> yes, the cacheinfo task is still open.  There are many things that are still not
> implemented in OpenRISC, you can always just look under the kernel
> Documentation/features.
> 
> For example:
> 
>      < shorne@antec ~/work/linux > grep -r -e openrisc.*TODO Documentation/features | column -t
>      Documentation/features/vm/huge-vmap/arch-support.txt:                |  openrisc:  |  TODO  |
>      Documentation/features/vm/ELF-ASLR/arch-support.txt:                 |  openrisc:  |  TODO  |
>      Documentation/features/vm/ioremap_prot/arch-support.txt:             |  openrisc:  |  TODO  |
>      Documentation/features/vm/pte_special/arch-support.txt:              |  openrisc:  |  TODO  |
>      Documentation/features/perf/kprobes-event/arch-support.txt:          |  openrisc:  |  TODO  |
>      ...

Got it. I did find this list in the online documentation [1] but I couldn't find
the cacheinfo task listed there.

> How far have you come with OpenRISC so far?  If you haven't already I suggest
> working through:
> 
>   - Get a simulator, I use QEMU for most development as it's faster and supports
>     more memory than most FPGA.  Final verification can be done on an FPGA.
>   - Get a working compiler toolchain.
>   - Compile and boot the openrisc kernel.
>   - Build a userspace environment, either buildroot, toybox or busybox.
> 
> I have some tools to help with this in or1k-utils [1], also there are prebuilt
> environments and docs in the linux kernel [2] and qemu [3].

I don't have an environment set up yet. I'll start with the steps above. I'll use
QEMU for development. I don't have an FPGA with me currently.

> At the momoment, I am also thinking of what to work on next for OpenRISC, there is:
> 
>    - kexec
>    - jump_label
>    - kprobes
>    - perf_events
>    - ftrace

Is the virtio task [2] also still a part of the roadmap? I can't find that either
in the TODO list.

> [1] https://github.com/stffrdhrn/or1k-utils
> [2] https://docs.kernel.org/arch/openrisc/openrisc_port.html
> [3] https://wiki.qemu.org/Documentation/Platforms/OpenRISC.
> [...]

Thanks,
Sahil

[1] https://docs.kernel.org/arch/openrisc/features.html
[2] https://fossi-foundation.org/gsoc/gsoc24-ideas#openrisc-linux-feature-development

