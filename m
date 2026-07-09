Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C363F9F22
	for <linux-openrisc@vger.kernel.org>; Thu,  9 Jul 2026 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595819; cv=none; b=eRbthAZ+BNdi8PwdS6ghpW5fcINMFr+BZPq/sviWS9Af10Voo1k0KgNDLNDF+0bp6aMlZHsWsUA0w/SW2g97RDAPigt//hTmjO/829kl9aBBzF4FQFg9p2aQkp2+dgN6tVf3RkO5WZxg5ejIARP4ABQp5OppLH86dZECf8jwof4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595819; c=relaxed/simple;
	bh=tutnNf9YAg3H/q95A7Iik+KRuKDbYTmWKhCV2b/wa50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UasgNTSLRO0wa5yD7604sZDKbrenvxkhud86Hzb/6dbUeY5Evx4gaL7oMLYxIajMnZwKBZslndFzctJh6vNAFwLg1CoGsBsWRNuJ0YfNq+23YIAKDl6G7uhNrRBwnIUfUynAqEWJBbU8a0DKG9McMumUA1KS9IRKJ+nyJS2upM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bZBcJAam; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VSW8VSNz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bZBcJAam";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VSW8VSNz"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669AxFmh1661845
	for <linux-openrisc@vger.kernel.org>; Thu, 9 Jul 2026 11:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OP+BLCmg7XOu9OIoY1nTg278DC95imbUOhUvbiFMd6M=; b=bZBcJAam+ibbXFwx
	fYme4cr8sBqjGZ8/bhY813m3zZdemgRcv+ZZn5hEkMKaS7vw0Lsk0C+lZaMW/4N7
	48Ti3b9W5djrMW6C6sRvr/fRMwvlr3Xwdk0O8mST92o98b2JRkz34WzfXmdlRdyc
	+GNzKHdNyJRx4XFA9Y/FW2dL+68kjj0jsC9rEzLvB9U2wtPREHvCZncHnjBH0nco
	DqfIf8EOVkC/PQXn3R9FFwNfO+c4fAiAxBDB9r3vKIUe0k0qjSg4thZ00H8jr+97
	7VzXtBysfy4u+kGoa711kKXXJoacuD/Fbabaj49b91/ZVeI4dz7AgvccLaeW9YDn
	oHnuIA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4vug1t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-openrisc@vger.kernel.org>; Thu, 09 Jul 2026 11:16:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1b4d961dso8967961cf.1
        for <linux-openrisc@vger.kernel.org>; Thu, 09 Jul 2026 04:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595816; x=1784200616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OP+BLCmg7XOu9OIoY1nTg278DC95imbUOhUvbiFMd6M=;
        b=VSW8VSNz0z/y41qH/VgzvwJBdqVhowunoibHb3jaSM+bX7g7V9zEH0ygaANE8jl8V9
         RednaI+86thljLOnpNDnLiKAQcMc2Rlh/xRSm61VMH2kSo0ndlp0i5+wJXv/mNBgIxwq
         vmRxvWP2xfMmUok5u5TrP/mcpolkDkVI+rh70ixsjpT01/vcC3qKJ2Z9UWY6AF+Er70u
         pgrWtlzueKsjuMoMLs6GlXvLRghqu4VBI3C9nli9nzcKZAWv90C8lmbk1eolq/tfYW55
         O1z+DVlO/UL9iAUgbclGKzqJ968Mc8LG64H6PGpqgm0JbwKKj1yBju1LHDTSFmF/IlKK
         goAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595816; x=1784200616;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OP+BLCmg7XOu9OIoY1nTg278DC95imbUOhUvbiFMd6M=;
        b=i8FrUCvbejmOM29tGb9ULYzj/e7I10gKorqfvzQkC0dZMY9oVIsTHaeKkrUgHMBF8V
         0B+ghSjKUedYnnkdnJcXQbS0QKzLaI0iE3YiwnvI9jLEHX49jMRCTl9jKexC2ouWKY9H
         h6/a32kVRJ6RGbSF/GBeen/F753NikQXafm3Q13SmdkM7zFFk3EHb/WfCMzk0uA1T6tK
         XSnoYuggV8NqmhKenaMuEZj/7ldWBr75voIpyExrd1IwEtuzhIFfFOPsQqnSsqfQEjmh
         NLgPmEN73RajUr/Cei2QqSDC6ErhU6mT5zamwp0Q+Fo0RlFSKxub8dJ2bBOf2HmEK+VS
         4fDQ==
X-Forwarded-Encrypted: i=1; AHgh+RqNZEpgbEJ/QLdzE3v9SISq1dHtfqLl1RQj47CReOtTsA77/u4feJqBTXMLhcV61zfojtFI8j06KbmFOZ1wvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSaKZSCHNP5ZCu5xyxRv+25iXSQvrvHFrtycTOBtm1qzC6MfTT
	X0EDUv6tJTsbNNQX1GJRIj5srf+kZatl3+S0fhgjWPLEzbciv5qwRpV2+Aq4COlcvbwP9xpWfSi
	zMUIadtL5ts6PVzXMTKlocUmRdJU4W6KjDwc0UGx68/rRkDpwDEVevcbJSiOIJaNfs8qF6w==
X-Gm-Gg: AfdE7cmnQ9h0dhMSTsdkWwRrARBZ0tzqGwk84B4iWjOT6fCEm2mYcKSozSbK4k9cYFs
	c7HnIfJsiuKseDbUr79EXUQMqXX85eksXEpJNqANpeyWRGkd5cwNkmjmqqLGjh1YIFaMTJy1p5o
	m8mv5yb4ho387QcAeuTkVV5m9O7dmT/SoMfM3OpB9hnUzsqskNjXttCP2tel6rItn4Z1S7KJKGt
	UkdGUHV/O0FJeepvOcC+r4kCRZMz460fi85Xu8J/B6naoM16YUtJZh1CTgex+FZf+3G88izOgfv
	gaD+YoaPzV2AmfLJ8GMskQ8ZmhezTiG27nCtcmV11HjcRxnW9aZIKg80OD43mzUYXfZ6NrzTfnO
	yVvGDHCFUuNNF+55SqJmy+kbr9afDlZGo/Kx4991v7rw5/hq9OawBdx2YX7mM8g==
X-Received: by 2002:a05:622a:1cce:b0:51c:558:cbbd with SMTP id d75a77b69052e-51c9ba21545mr21236611cf.41.1783595815672;
        Thu, 09 Jul 2026 04:16:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1cce:b0:51c:558:cbbd with SMTP id d75a77b69052e-51c9ba21545mr21236071cf.41.1783595815288;
        Thu, 09 Jul 2026 04:16:55 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm51612968f8f.15.2026.07.09.04.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:16:54 -0700 (PDT)
Message-ID: <b2ca1416-e2c1-46ac-8a26-ce671c76883f@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:16:51 +0200
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 06/18] riscv/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller
 <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
        Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260707181957.433213175@kernel.org>
 <20260707190253.974626922@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190253.974626922@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WEFnN76GRaziNLgO3L2MQJN9rSYTjdod
X-Proofpoint-ORIG-GUID: WEFnN76GRaziNLgO3L2MQJN9rSYTjdod
X-Authority-Analysis: v=2.4 cv=GIg41ONK c=1 sm=1 tr=0 ts=6a4f8328 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=_O3DOGVWAAAA:8 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8
 a=DoJJhcVa48uSEvU2-xUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=2TKV-7w1aU1AVAwN0oqT:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX+MyGi5DXecHo
 v+XlVKxKFvMrLXbsKxUwt3eIeREb9UxNacCZOKuou7/GXs27QoeZTiCAfUBkvuG9HFrfNwII9AB
 B/1fsv1wJDRz488RyRQmyF1YAtjvXlC6wfrDi0HMl2ge+uXlW516BRzUrUk+X/ZQSrsYorUiGA6
 T92RidhGC9JIvDJskzHNeswTsAcpcCsLBM9dOMJgONM3hYgN5zuwqGxLfLhW9QXV1q1WSwXhbLy
 08KWmKEpRq/Ch8pd7riQ5CeCmAKkKKERSoMz151VU3e4efdkW130TqjSTKUDchAbfYGpAiky5Fa
 5oIbvFbXT0bLX8xzeZA6QlyoMYJLpdpMC68wqXcJ9DB7eQ693A95c0VnDRklTwwDgpZfpG+we0I
 ssK7LqOmoJdb77HtyKIm0Uqha4OgHCiBYpZ/XObH5wdUFBqH48GiW8PStJR0ncXKWE2nkjzYh/A
 vvnNlj4A9PaoFE92rpw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfXxA2nd5HB5Wbg
 3XJFLDIKIsDFJdko0SpfD2+AJsRgofj01T16MAw314xt3MCXE0oui7GbhsJ7gsaLa4j+ZsOnfXe
 2IWH+nIN7HFIXEAqvilux0nndD0fl9M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 suspectscore=0 adultscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108

On 7/7/26 21:06, Thomas Gleixner wrote:
> syscall_enter_from_user_mode_randomize_stack() replaces
> syscall_enter_from_user_mode() and the subsequent invocation of
> add_random_kstack_offset().
> 
> The advantage is that it applies the stack randomization right after
> enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var()
> as that code is invoked with interrupts disabled.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: linux-riscv@lists.infradead.org
> ---
>   arch/riscv/kernel/traps.c |    5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
