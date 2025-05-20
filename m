Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6947526561E
	for <linux-openrisc@vger.kernel.org>; Tue, 20 May 2025 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730926; cv=none; b=UdArRit81BMfYOiXH1i7u/KHebQBD7rca20Hxn1ZHIKW79t7Bi3R3WuZeokNrm/MqRMvBZDyvxOAao3Ta1OLyhH3FxijV5u9CB1S9twIQJNk6Qxh8Lqih2RyaErk0ULEteAZM376LQnkHtiZ8NpWXkJAQxPGu35Qs3SbEJsNnaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730926; c=relaxed/simple;
	bh=jI1LMCgvrH6JmNwQZQIEsPLqEEcC/RWogiNQjSZLrU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8RqCN+IFohz7psFw710uNYz3sedGyPuAPaFc5xl+CZyXk5IGkG/qFK9cB2c1NOK1t3W1U3K5bP00iGj9kDNMVpohiEfK5Ik69+ShCDcH7Do5z6Jn2dbZeiUlNz4+RtpN/LRgNQ9S2vyC/kXTPKtoYwi1lOT3UWWAQ423kmsEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMh1ylUf; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMh1ylUf"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30e7e46cb47so4172898a91.1
        for <linux-openrisc@vger.kernel.org>; Tue, 20 May 2025 01:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747730924; x=1748335724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sjs0tSBikmkyA8uYRGslt2i4EjnK2PdXpRReHpetyCo=;
        b=CMh1ylUfiMleoJN5sQqJvYZUqVnRxCmX7moSczmExEvo6ay9GCl3MXQKMVorprXPQ5
         AMNPvhDjQxXjr/9YPyGryKWjTps7295m4UvyWdZ3EJ3ISw4KcIc6/4TxZhjB+8ejNsRG
         1b1ecPCmBrEcIenxOTQHZxNYUfr6D3OtzK5Izt/IUksrzwBTEqYkQfnQU44xttqGXn+k
         if9x2T8ZX1C/fIjAEI9N+jQqhZaVRAPk57WZnMotYjJiALVbXPpZindI4sVEqiKSQMid
         IRQwvQ8x8jE7AY2sKVKMMPFaLy/4J2wvJxpqzrQIcM8bpRwzAfFb443U+ZE6KI2HpUSq
         x7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747730924; x=1748335724;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sjs0tSBikmkyA8uYRGslt2i4EjnK2PdXpRReHpetyCo=;
        b=f0BF9WhojprWcyPvPjxDMNsBriLipN/qsm5vfvF+iAN73c9sk1YomGVSvV5F12v8nm
         hFu3mks3mlv7wvJOki11XizpUvlgPmtgCWS76T+YXEyNuLVSQpafXGAaIyd9if4OVSfb
         mP8uYTNBXrsZTEtw7+0oaqh7EfylaRJMXs2wXW7ZwVdICrlo7Vgi+H89LoFkePdY3+vA
         lyg6nLAUbf9S17Qo+opmIVDNy6+yMXyFzo7Sz3sG2+BocW+5IGqOoB2qKfuBpKX37r2u
         6EVM3KICGonoRqthFjxY59Jz42gFUB1ca7e3djI3jD8lhgv5uYgGc3GSGnlWkIzo+6BP
         5JWg==
X-Forwarded-Encrypted: i=1; AJvYcCXCQAVavzW0dcwaFLHs+6x8xXFMNVCeXXssmVAxcOw30is7o+1ZNzEP03Gtiwoe7B2uYPpxFfX5j2dUe4uE1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAIyKBR6BF22q4hmsCfqW2rt5lRdOgjalKxmrz6wf9l65y5cJf
	aGH4/N5QkfO7YWcJ+32G7uffPCZxMND24HTlZO6Oab/JHCQ1heaG1z1W
X-Gm-Gg: ASbGncvOgfHvjfePIra3LqMSpyw97jbWDdkSxflkat8Mn+8rFifnL/rY2Cxc5Lshg0+
	So9F+85/rvRiLyY0LNLqocIBE+EI+t2fwYNF7dadyB25RqSIERkYSelfl7sTpxkNwFfoMyj7sZ3
	g5oXVAnzMFEiUq0FqdTE7aLGD+2N32MCH6aiQK9uOkKsN1ekf6I2yiC1ac+jAT1qFTo5s86orgz
	sgYndY34aRU36r/zI6Bw7djDAEgTTyQim/tGaPGluq1qUAn6dlmGqAG7hQUqPdYAyfg4Vw/R2gm
	6nd3OXWGykPICkB0IK29qd8sa0WqttqEoq4TgSf6jT56kb68vQg3/isbbzXuL7PF6ynRck9rXsm
	sJWtQUKHeAkibnWY8vw4=
X-Google-Smtp-Source: AGHT+IF25UwafSDFQlAoXMr4DbwtBty4M7Gdcd3pvRdT3qfpNq5OOXHgK4mGk0s8Ds/Ifh9zGmqSLw==
X-Received: by 2002:a17:90b:4f4c:b0:301:a0e9:66f with SMTP id 98e67ed59e1d1-30e830ebf11mr26107232a91.14.1747730924412;
        Tue, 20 May 2025 01:48:44 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c7e:d42c:ffd4:a013:6868:134b? ([2401:4900:1c7e:d42c:ffd4:a013:6868:134b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36364f9asm1163739a91.4.2025.05.20.01.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 01:48:44 -0700 (PDT)
Message-ID: <f5a0b134-f82b-4f97-8f31-4520055d4be2@gmail.com>
Date: Tue, 20 May 2025 14:18:41 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Need help implementing text_patch for JUMP_LABEL
To: Miao Chen <chenmiao.ku@gmail.com>
Cc: Stafford Horne <shorne@gmail.com>,
 Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <CAKxVwgfv8+wSHpEndr_RT3duU0U7dzNDRJROFtGnhpmVz1SBkA@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 xsDNBGcgaYEBDADpKUSKbchLCMdCuZGkuF50/7BiraKc8Ch+mk4T+2+E2/6qXAkalvCkFoqx
 3/sa35rconZAFzB/r19e7i3UajIQjATvENrGxqe/IFqcJxo2Jr1HQBwCrsmlQoUCilSC6nDi
 ejcEIAFytJORDkCcZwLXPjdf5/4pbqVAW5823LB5j5F0TqHAnGY1RhS2V1eBPdRqjAA3xecT
 zTmLHlkqAXgM2DOot1KbycedZSieCwEykTXMaLC0/3Gyo2Cp1WTWOIyD0hsXpLyFioV4FaX2
 Lm+z45Zc4PoNXeC6+l4PdDxixs+saAbadknP+9omwlb+PkMd3esq2wkowTwTJVJK8FCCNTo5
 2OArA/ddxcyXY25JHN7vzGooFNW6Bb9YV+lbX6y95ytE3KcAmid73tQrcjlebIpgNAvOMyyZ
 BgQJY0HSu3DGNZuKtbNM3iTl82TFj7MVgkEffgF83N6XyBqDztIz2lN47/q5wyRi3jda9NDt
 geI+Nv145HjulO7bI3NT048AEQEAAc0kU2FoaWwgU2lkZGlxIDxpY2VnYW1iaXQ5MUBnbWFp
 bC5jb20+wsENBBMBCAA3FiEERtYfQYWFu+uAZjYrrzGlXdb6f1cFAmcgaYEFCQWjmoACGwME
 CwkIBwUVCAkKCwUWAgMBAAAKCRCvMaVd1vp/V/nnC/9KnNIr4a3JW3E/snxv1+XIyUmHBDLn
 PKBmLDYxO9RJe1xKo/sNmLEno4c8G1F/y12TLV086cpBYGKkE8mPMBABqxuiPG8srwoKc2HW
 bvoC2Zfeu/WeQ0YqeI9ZEwRhsDGQZ7vc8PnKnEUaPZn6iWW4GeX7dXWeGNrK0wU2B04l2d+M
 FIKaoPHk8w5Ff++QNcn0YRkm//nYlukHUrMxhNcuc18jaLLftOh7BH/4EbKtTN75KAFePQBi
 I2CbuC41fchTt12QrPB3yz1GKfudsEMLFHBNeComJNnuolPOq0YSyuKdRO8Jubn5ZqWQeTwj
 XbG7wTonDc8xe46irOhz36VcjsjSY+PYhVZSeDWeDUZgpaJkBjQDDodIN2eoMwVEyUByos9H
 mKrqrpBMmylOspAZzqjb5FtOqM0BCxQINdKKiMwRelSb6pHYCrbS0XzpwDUEpp7RWCbHgg+6
 Ot72kQCEFxj2LzX9VxF24GGQy9inlUfN51IV04klSibtBuuz/NbOwM0EZyBpgQEMAJelVX4k
 CtCxD4Ji3FQ8LZs22z7VoUvqIb7Gj2lNvhPeijlqqBkSMIgnSCLxlH4ahqKnEV58IrfVriV0
 92zb94Az2nl0r+bZYfvev1qCcVIYxk+pYYcRl5qPXX8XGalrkcBBWmkgTSwzNK9rV4850iVI
 hsJNel49qen9JwiFYMSKa2MYgdYSbeuuwXwUp0ZHeVFc5RnPK2wxws1xcnsdb9hRXs2UeTEE
 0klG3HuXqJ96DzKrCieKHLjs330h+16gDWAFZSEoT7Mh3HFGI2dscVuBstQNgnwUMnsJv8jx
 c005CfLCjCBnJEhMd2/QFuLwCZv4IdoghKwYw18e61UbX2bFovo9dduD527pD4sFqi7U7ofv
 aO3yf+ulL6jiKypGvnbiBP3KY3aKxx6pHHH3aDc9eOqCUgrtS3+xt1du4+qxrYqEnrywFoJy
 5zqSzbnTTjFpdTbY5SS52fIOktLlAKzEg6V9hkg2r08hC3/L4NVj6I4tsGZlqb2neRlHFmCr
 bQARAQABwsD8BBgBCAAmFiEERtYfQYWFu+uAZjYrrzGlXdb6f1cFAmcgaYIFCQWjmoACGwwA
 CgkQrzGlXdb6f1fDIgwAmpB7eL3XNSx3F+gbmksOPMqCU5rEswRedjEt6tBzFTXhdNFfhZTb
 vCddUNePZnzddgxAnDBcTqI1jx6Go6Hkti/mxJqXSczMYBsImD/lEm47axsADvpnNaEM+tmu
 m/cMKfpILUpy2Ey7CKXUA1vpzYeUD29EQWi0fxM0arplrVt/uzUdFRFQRn2hCqeDLBLONX1F
 Adq+re6M0dhKl4a2+erzZRIXh3vIGiDmpJEGrajrhqEnMXFp6toSiMGian94m8H3NT6rB64E
 JmdHgyjXADFbn2G5Mb6Pwa8KnnK1kYcZ+Pwu9LfMXfgI01Sh/k01hjUVmnpYep4nHUfwXA8r
 kn6WekD80DYbAfKyFAXQCO/nclZ82RNmJbDRi3AeMFrxKi6KgdGCp1Izhj9USaMOVqcuV2p0
 Rsoq+sFqWOKaHWnQHCM9RkynQVqrgUaSawEbGlCP1KIhVmjfjVsmsCaKkUb9T6VeO+ZNe+Pn
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAKxVwgfv8+wSHpEndr_RT3duU0U7dzNDRJROFtGnhpmVz1SBkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/20/25 1:08 PM, Miao Chen wrote:
> As part of my participation in GSOC, I am currently working on
> implementing the jump_label mechanism for OpenRISC. I have already
> implemented the basic functionality of jump_label, but when working on
> the arch_jump_label_transform_queue function, I need to perform
> instruction replacement and writing. In the implementations for the
> ARM64 architecture [1] and RISC-V architecture [2], this is achieved
> using text_patch [3].
> 
> By the way, ftrace also relies on this functionality for writing
> instructions [4].
> 
> However, after reviewing the OpenRISC architecture code, I found that
> the text_patch functionality is missing. Since you previously worked
> on ftrace, I wanted to ask if you have already made progress on the
> text_patch part? If not, I might start working on it myself.
> 

I haven't started implementing ftrace for OpenRISC. In my previous email
thread [1] with Stafford, we had decided to focus on implementing data
sources (e.g. kprobes, uprobes, etc.) first before moving to data consumers
such as ftrace.

Feel free to start working on implementing text_patch.

Thanks,
Sahil

[1] https://lore.kernel.org/openrisc/51b89c55-ee58-461d-a2a0-5c8dd8ba77e7@gmail.com/T/#m196b35b073dc133522a49a7a31caa5dd16cc0187

