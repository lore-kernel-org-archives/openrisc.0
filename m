Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F60FC4708E
	for <openrisc@archiver.kernel.org>; Mon,  5 Dec 2022 12:26:00 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id DC8602490E;
	Mon,  5 Dec 2022 13:25:59 +0100 (CET)
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
 by mail.librecores.org (Postfix) with ESMTPS id 1B4BD24994
 for <openrisc@lists.librecores.org>; Mon,  5 Dec 2022 13:25:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1670243157; x=1701779157;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=neMU4Ok0awO5Rq5skIsVHn5TxIHDupVu3e9O7MCpojQ=;
 b=PPYwHcrDcvXTxvd9VHCknCoDTTzZUIHapOSkV08n+u52owFPdCfnzLsE
 nyE3GjCaIoHlMZ1F+fhdilNyZzK+3ft6H2RvXsJrAkR20TtMoqnkgdJCF
 uDLo+xu1GmUod2+uXrxCu2sR+D3D++RixPSK7OH75fRWfz4Ylk7W04Vmn
 kyghL+CgFudEmPurJSzUlIHXiD3PBuWfNcp+FBB0tfTrp+2Z5+/ABKRkf
 cogpwWPJ6LPgB/XsaGZLTPQL+Ij9Ar8yOvDY+BS3DA+DSh+5KaDAOXmV7
 N7TOrYK2B+ac/Woau6QkMwPa3jehJUk2OJr7iQMkQLi7RvcnFw3kyMVqK w==;
X-IronPort-AV: E=Sophos;i="5.96,219,1665417600"; d="scan'208";a="330010012"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2022 20:25:56 +0800
IronPort-SDR: UnpaZVVfxHIOX77nTKTqTiJXvxqQSxEQmTwMAtlg4G4+YEsSeNaQ//nyYhrcGV+CMgdCfs95Nr
 zs7eoBAGpxIHeVuRxj7pOYZl16vsKsBru9p9+PCO1J1mCVkmQ6DFTpV5jk0C8offPzXRIslDpQ
 cBwJ5YxFuPiBsMTRNVbWmH8v5ChBFKDLNX/dcI31bjsHjMSi+I+PX+t5J2vULhA0ijHa51vSlp
 f+RFw4Qfcn+jPtsc62VUJm2PvwpxjNNAU6oFT2xzQhoPPt1/rbIyEM5OOA+VJLA0u9hQGzMfuS
 W8k=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 05 Dec 2022 03:44:29 -0800
IronPort-SDR: N9l3rnZqdSdn+AcQRtJFHgCXlLeeK2R6f7rTBo7Vr/dQWxpukrlaOx4zhnYVaDRWyCMicNvfPV
 08hkkExZiD4Vd77SDFQfzUvvUq3qHL8Z+Y+di3Vwx7dNRJCtBC83IdIXWqPgZQEhopyt0yebJa
 T4T6NrCYb+dw94q2zKSGIwfQRzw1I5J1nZPdv5BeL6OAIQ05FN57ySErv3RDpQ6/KnXGPRgLTS
 87kN+l3vawSIGv3EI3v75U6MYP9RNM7HC4qNLL6HIPhw3bi3QbqeJ70g0l5jRaI6bylmGXIeFh
 g7s=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 05 Dec 2022 04:25:56 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NQjSg72Rcz1RwtC
 for <openrisc@lists.librecores.org>; Mon,  5 Dec 2022 04:25:55 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:content-language:references:to
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1670243154; x=1672835155; bh=neMU4Ok0awO5Rq5skIsVHn5TxIHDupVu3e9
 O7MCpojQ=; b=gTyQiIEtSVqvwVxAB8CGYS4bn2kbh+onxccWNV2pvnEJ+s1MACa
 HasKpuudsHW2I0jpWQdI60uCpE7syCOp5DmV8WeF6T6GDyzSPOBIxbLb7JDtpHL5
 z5WMuG/3pXadnoyPHiZTHDyRqi/tbpww8Sg/bIzhlqIcBH2f6rEuO69h9qEgK0Il
 YwwhRbfChGSHLra69SncbFAS7Oz90ikKUlvaT+EUgBl6anL+lhhs3zTcrxrzs8j8
 bdXdPtuE1b0NNsUMqYgYuSIBtAeQCvvpiy0EXzJwyjPKIe9SCPH9nwmayNXQzf2K
 BYgRH3gvTis3DJ01W8qmCcKom9ZOBBUx1mw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id 4VQ_owYK75yC for <openrisc@lists.librecores.org>;
 Mon,  5 Dec 2022 04:25:54 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NQjSW6BW3z1RvLy;
 Mon,  5 Dec 2022 04:25:47 -0800 (PST)
Message-ID: <e62bc865-3b6f-2790-3dbf-6485cb233c4e@opensource.wdc.com>
Date: Mon, 5 Dec 2022 21:25:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 12/12] mm, slob: rename CONFIG_SLOB to
 CONFIG_SLOB_DEPRECATED
To: Palmer Dabbelt <palmer@dabbelt.com>, vbabka@suse.cz
References: <mhng-b0214281-7ee5-4698-a158-980427a97472@palmer-ri-x1c9a>
Content-Language: en-US
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <mhng-b0214281-7ee5-4698-a158-980427a97472@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: dalias@libc.org, linux-sh@vger.kernel.org, tony@atomide.com,
 roman.gushchin@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 christophe.leroy@csgroup.eu, 42.hyeyoo@gmail.com, cl@linux.com,
 linux-riscv@lists.infradead.org, jonas@southpole.se,
 ysato@users.sourceforge.jp, aaro.koskinen@iki.fi, jmkrzyszt@gmail.com,
 linux@armlinux.org.uk, willy@infradead.org, rientjes@google.com,
 Arnd Bergmann <arnd@arndb.de>, josh@joshtriplett.org,
 openrisc@lists.librecores.org, linux-omap@vger.kernel.org,
 iamjoonsoo.kim@lge.com, linux-arm-kernel@lists.infradead.org,
 patches@lists.linux.dev, Conor Dooley <conor@kernel.org>, penberg@kernel.org,
 akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 12/3/22 02:59, Palmer Dabbelt wrote:
[...]
>> diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
>> index 1a56eda5ce46..4cf0f297091e 100644
>> --- a/arch/riscv/configs/nommu_virt_defconfig
>> +++ b/arch/riscv/configs/nommu_virt_defconfig
>> @@ -22,7 +22,8 @@ CONFIG_EXPERT=y
>>  # CONFIG_KALLSYMS is not set
>>  # CONFIG_VM_EVENT_COUNTERS is not set
>>  # CONFIG_COMPAT_BRK is not set
>> -CONFIG_SLOB=y
>> +CONFIG_SLUB=y
>> +CONFIG_SLUB_TINY=y
>>  # CONFIG_MMU is not set
>>  CONFIG_SOC_VIRT=y
>>  CONFIG_NONPORTABLE=y
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> Though I don't have a K210 to test against, maybe Damien still does?

I did test and it is OK.

-- 
Damien Le Moal
Western Digital Research

