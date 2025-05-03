Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1E1993B2
	for <linux-openrisc@vger.kernel.org>; Sat,  3 May 2025 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746288900; cv=none; b=j7OMiUutpzBHqEr9DF8uObsI1en6jKQ6TmNABDBxdsalwijMWngXhwd5Po/r/4MLdD364EKLfo95ay14666j1zQmF8rDHSiDWFGOo8wpWeBAMNN37YiMJIW7Ehm5H6z3P7UJegLAF1Ygwm0KFkgZfvONde+ulmdKutqVCZtskHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746288900; c=relaxed/simple;
	bh=hd5oFHPsUl69hiR0d5QdSq4zWwHKwTTnlgT6AQoTvhg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=gRNVuynx7q51W2w5fKI3/YbQi4ZERyaAffd9fEB+s4xnbOR7sCCEIRQlu0cAeAvrO0G9gh5iJUpXQF9rll02r4yEGs7lXHzhhBZqdORQMHXju2C2ZWJ/cQWXNP1ih7Pbtsyn2eRXkNz57EnBcNGAMRliJ5ANRBTPQmAU/sUDJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgMsC8zU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgMsC8zU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2254e0b4b79so47559025ad.2
        for <linux-openrisc@vger.kernel.org>; Sat, 03 May 2025 09:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746288897; x=1746893697; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:autocrypt:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hd5oFHPsUl69hiR0d5QdSq4zWwHKwTTnlgT6AQoTvhg=;
        b=TgMsC8zUhyfRwaBePeFvwa7i+JawCbp5PiA1zWm/mTXJtAXTmqEXk2vnUSCJza2ZOU
         +un0lOQd/EvDPEO85+CGUxyZSvnRF9cWRchsBUoQK3pEIf1KgrwIOeJksnGiKP8ZrjO+
         eJyd35T3tH1pDCz9ktqCNbRRnI8R5DnIeEWVbBqn+EQ5W2VYyjh/dDOxv/4QXGwmLuhz
         f75GzPDWPGGg1072AxIw64/6/nXIaP/xw0VD/dam9WYcgrPZI+UOKE14Q5pcuMn78p3S
         IDQtK2yCLrd4xgxGwe1EYcMks67OvHMh3ERwO4FDKeORE96GUx8VOh8pji3bunWVSvhc
         dleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746288897; x=1746893697;
        h=content-transfer-encoding:subject:autocrypt:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hd5oFHPsUl69hiR0d5QdSq4zWwHKwTTnlgT6AQoTvhg=;
        b=mKUo1oInbDBtfsGID0yZdg7LHHNKPGGszb+bdY4GGshXFgEJq4BypcEt/8nNEXwz1z
         Sli0hAMKkFXy+H9rSeOT2AmLJLR5KaQiVbYuLhs7Z5flIUqeSn4ZFeSzbT9AynSO753q
         IcpUA7CmNt6hLK9RQZ7wNciBXfWLIY0kuRuOHYMBqrRDqN9y8HfM/jT/Xcc9Cqi5tIJa
         W8U3vVN10XosWXuLQrGqj0qdKdOfjAZb4RekdONxl4Z1IKVE2b3VePqJtOeMQcprm0wf
         +rMVFls6f3hvI/tF2+6gspH9y5uhf+6BJ0cXufJLr3IrTwDnNx8X8TxtDgGipmymH26O
         QVIw==
X-Gm-Message-State: AOJu0Yzm9g8pNU8icB/qjDvzyCFiywF6ZDnvkfPcEI5DxpfYFBsZEkf0
	xtntYxW4VPmeEOCtCy/9YwOFVFke4oTYlZ7138hL32QPJU24O9CDKJ5Jrg==
X-Gm-Gg: ASbGncsB2Ub6H8Hl+OadO+P8Je+eXXwfvr4KmFD5TPhV2NWrpz4OGz3f++mZ/dBUHkR
	7q88qejBIKu9SNAl9hre9QvIVcOXeKBn6teB/vygp0o799JJ6Udss8sDSzLAhUU7/pohKiZkc7n
	JPbbnZUU1d+4NjXF0TP58neQ2zBbBPFdYlCVoFQRro0mc6joNb2g7EVorC/5Z+iPeXK/inFxYlc
	ZTfOlqBHkifgapDpDK2ZypmiEZMl9a6Tu67+l651NoFNsVRNiwzyPY/KrkC/mpADUuU8QRqAnvl
	E2mzuf+O2O7p
X-Google-Smtp-Source: AGHT+IExnpouzM1lscohuo4aytBZwEOOchU2OvSeBbvVFSEThLugL2S2ni0FWdnJxRuAoufZN3Bk2Q==
X-Received: by 2002:a17:902:fc8d:b0:224:1074:638e with SMTP id d9443c01a7336-22e1eb0aa26mr20112145ad.52.1746288897638;
        Sat, 03 May 2025 09:14:57 -0700 (PDT)
Received: from [192.168.0.106] ([182.48.215.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522936csm25520705ad.204.2025.05.03.09.14.56
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 May 2025 09:14:57 -0700 (PDT)
Message-ID: <e9f74ae6-10f3-4585-b727-928bb5749dd9@gmail.com>
Date: Sat, 3 May 2025 21:44:54 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux OpenRISC <linux-openrisc@vger.kernel.org>
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
Subject: Queries regarding ftrace's implementation for OpenRISC-linux
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have been looking into implementing ftrace for OpenRISC-linux. Based on what I have
understood from the ftrace design document [1], mcount will have to be implemented in
the kernel for ftrace to work.

While this document is outdated, I did come across an article in the Linux Journal [2]
that explains the use of fentry instead of mcount in the implementation of ftrace. It
states that fentry is a powerful alternative to mcount. To make use of fentry, GCC's
-pg flag needs to be used along with the -mfentry flag. Simply calling -pg results in
mcount being used.

Should it be possible for ftrace to make use of either option (fentry and mcount) when
implementing it for OpenRISC? Or should it only use fentry (or mcount)? mcount still
seems to be used in other architectures (I have only checked MIPS, RISC-V, LoongArch
and ARM so far).

Also, or1k-linux-gcc (version 13.3.0) does not support the -mfentry flag. So, if fentry
is to be supported for OpenRISC, this will also involve changes in GCC and glibc.

Thanks,
Sahil

[1] https://www.kernel.org/doc/html/latest/trace/ftrace-design.html
[2] https://web.archive.org/web/20250215201110/https://www.linuxjournal.com/content/simplifying-function-tracing-modern-gcc
