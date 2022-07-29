Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A25C00144
	for <openrisc@archiver.kernel.org>; Fri, 29 Jul 2022 06:10:43 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 7A78B240E1;
	Fri, 29 Jul 2022 08:10:42 +0200 (CEST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by mail.librecores.org (Postfix) with ESMTPS id 82070240E1
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 08:10:41 +0200 (CEST)
Received: by mail-ot1-f47.google.com with SMTP id
 br15-20020a056830390f00b0061c9d73b8bdso2681300otb.6
 for <openrisc@lists.librecores.org>; Thu, 28 Jul 2022 23:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:message-id:date:mime-version:user-agent:content-language:to
 :cc:references:from:subject:in-reply-to:content-transfer-encoding;
 bh=77YdUV373K1Bwl63jTp/MrQuJqIC0+oOlc6XVxSF8wM=;
 b=hpwBKNYnMb+414dNW+3oM8vJwe0iIWzKeqn1ZONZS6zlo4nVsQeXOxNrLSHqUyRCaJ
 HT8+KHQhSrrAyYaXJCBvscrvgDsKTep0J74e+WPHQg8c+yey3CERvWk/p6P4WcDr/EwK
 eAbTYyEVjRYcOMV4Vvk/anLeqanp9zVDlg/kAFEVazFrFQ7LA9wwDdRHoXaM4iCUCIwg
 nv+Ub8Lj5eBKhR+qQ49XTYTF8r5shMUQbV0YiSw3gFyHXiIKz9yvJO0y18BQym+7qRve
 wO1Xvj5Va3bWCIsq1ZYcYVU+K7e4Fp5z++fGZLISmMz6Nk02oUwQBQ3sNulVepqnobpv
 IVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:subject:in-reply-to
 :content-transfer-encoding;
 bh=77YdUV373K1Bwl63jTp/MrQuJqIC0+oOlc6XVxSF8wM=;
 b=5L/OU4arxny8BbccZAcajKIYEsSnVSWSMn/MEfTeDqItkWh921jktUUba1RnBTQqSz
 fEBf6qQJPlNGhuoOwy8RjOlNZjWt8ieJriAzTZvxKMrfLua4DmAe6kmGNjXLTz0rvBAd
 IKBv8j7t2wx8O6GHlKtJqRJVVF23+RTvU+YdGEbFNaS2sJsz3vksrQVxMo1qyMxerV4D
 6P/8+9V0/Zv5zLlp0i5cZENyAzShFyPSHokFtDAPe3r+MXzyMuPWKoc5lmmDqqHvsAa+
 lRNZSTNrHWQVhw/qL+ZKAASYE9FzU+Y+YoMgOyzUNb5vTDUQ7h9D/RQoDXA/qffv0TsQ
 PbEA==
X-Gm-Message-State: AJIora/Gu5/22Uhr0kMcx1HEzr3gTlQD708KbDECNHEnsBjRTDKTIQ3/
 4Ge4NNDPThgY7yKdpv/IVMc=
X-Google-Smtp-Source: AGRyM1v85SRTE+GI3yRIc/Eqm/8xmsPl7/gkyzwLM0tdj3c3KCTjrFqh5ADMQ7uMaXvqeNZBwPHPXA==
X-Received: by 2002:a05:6830:4488:b0:61c:bee9:36bb with SMTP id
 r8-20020a056830448800b0061cbee936bbmr897885otv.148.1659075040142; 
 Thu, 28 Jul 2022 23:10:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 ay33-20020a056808302100b0032e548d96e0sm1053913oib.23.2022.07.28.23.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jul 2022 23:10:39 -0700 (PDT)
Message-ID: <ceb732ee-0ea1-b471-0b57-3cc3bcb80a2d@roeck-us.net>
Date: Thu, 28 Jul 2022 23:10:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>
References: <20220725020737.1221739-1-shorne@gmail.com>
 <20220725020737.1221739-3-shorne@gmail.com>
 <20220729033728.GA2195022@roeck-us.net> <YuN1PWcDukEPdtQy@antec>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/3] openrisc: Add pci bus support
In-Reply-To: <YuN1PWcDukEPdtQy@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Jonas Bonn <jonas@southpole.se>, Arnd Bergmann <arnd@arndb.de>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, openrisc@lists.librecores.org,
 Bjorn Helgaas <helgaas@kernel.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 7/28/22 22:50, Stafford Horne wrote:
> On Thu, Jul 28, 2022 at 08:37:28PM -0700, Guenter Roeck wrote:
>> On Mon, Jul 25, 2022 at 11:07:36AM +0900, Stafford Horne wrote:
>>> This patch adds required definitions to allow for PCI buses on OpenRISC.
>>> This is being tested on the OpenRISC QEMU virt platform which is in
>>> development.
>>>
>>> OpenRISC does not have IO ports so we keep the definition of
>>> IO_SPACE_LIMIT and PIO_RESERVED to be 0.
>>>
>>> Note, since commit 66bcd06099bb ("parport_pc: Also enable driver for PCI
>>> systems") all platforms that support PCI also need to support parallel
>>> port.  We add a generic header to support compiling parallel port
>>> drivers, though they generally will not work as they require IO ports.
>>>
>>> Signed-off-by: Stafford Horne <shorne@gmail.com>
>>
>> This patch results in
>>
>> Building openrisc:allmodconfig ... failed
>> --------------
>> Error log:
>> drivers/video/fbdev/riva/fbdev.c: In function 'rivafb_probe':
>> drivers/video/fbdev/riva/fbdev.c:2062:42: error:
>> 	passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type
>>
>> drivers/video/fbdev/nvidia/nvidia.c: In function 'nvidiafb_probe':
>> drivers/video/fbdev/nvidia/nvidia.c:1414:20: error:
>> 	passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type
>>
>> drivers/scsi/aic7xxx/aic7xxx_osm.c: In function 'ahc_platform_free':
>> drivers/scsi/aic7xxx/aic7xxx_osm.c:1231:41: error:
>> 	passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type
>>
>> ... and so on.
>>
>> Prior to this patch, the code was not enabled because it depends on PCI.
> 
> Hi Guenter,
> 
> Thanks for reporting this.
> 
> It's interesting, I don't get this on the openrisc/for-next branch.
> 

Hmm, weird. I see it all over the place. Complete log is at
https://kerneltests.org/builders/next-openrisc-next/builds/1880/steps/buildcommand/logs/stdio
if you are interested.

> BTW, do you turn off WERROR on the allmodconfig config?  I get many warnings
> such as the below, but I haven't looked into it much yet:
> 

No, I don't. Disabling it would defeat its purpose.

>      fs/exec.c: In function 'shift_arg_pages':
>      fs/exec.c:687:27: error: 'tlb' is used uninitialized [-Werror=uninitialized]
>        687 |         struct mmu_gather tlb;
> 	  |                           ^~~
> 

I don't see that in next-20220728. I tried with gcc-11.2 and 11.3.
Which compiler do you use ?

Thanks,
Guenter

> I will try to see what is going on in linux-next.
> 
> -Stafford
> 

