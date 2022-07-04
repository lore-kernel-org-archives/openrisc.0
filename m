Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A80C433EF
	for <openrisc@archiver.kernel.org>; Mon,  4 Jul 2022 10:20:20 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 3033723F5F;
	Mon,  4 Jul 2022 12:20:20 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mail.librecores.org (Postfix) with ESMTPS id 37FAC20FF5
 for <openrisc@lists.librecores.org>; Mon,  4 Jul 2022 12:20:18 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id 145so8517567pga.12
 for <openrisc@lists.librecores.org>; Mon, 04 Jul 2022 03:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=IEpUPe6OelLAnFFUtEwqJArazfaJNRFBOBPI9yOWGjk=;
 b=trAeMPpfCNi7GO/3u3YDEE1xu3oKdssFJK7NlhqNKY+eVzTfotB28HMjLwnUynQU9r
 hb8vnG+WjkpMUDizWkXnhLjgTXL6Btj3mYJDSdvKzwUAMdkj0ZUnR1cZcMtiYsbzy7dc
 2ST3ZGBnIyU6QUtUmyNysMNba6+mboDBGWYJ7Iljm5VK8lfFC4/A2iHpsWodsVKAxWdO
 qNXxZ9kVPNQSm6eXGMd0OGqLZOomwOR9EO/Tq79yK1NDDLPA5SJMbpsWrEUpyvMdZJUq
 J8oKP31vW3smmimzQJKBH7Wh47oMC+nSJlsVIsmzhZIFGz8c95B2znM5MlwXwd/uwOS0
 nYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=IEpUPe6OelLAnFFUtEwqJArazfaJNRFBOBPI9yOWGjk=;
 b=xgCEBYzoraE//6VAPclml4Xc/mehH65HwcUzuuhvRlIKI916NumLM9zBvAGN17fQh6
 cD3J2jdBsf0DYPO2EWnyeWHejFFIb4fqUKFVmMcFQkzTdjc0hzphVwQwlXdKrCyX5RNt
 IvKNUQY/OAgrjQ5gPgDMiLCPRKNLJfcoh6Puz6FuV0jCs9SM9vn4Iz+J1Q7rNGQo1kyP
 qQOLHI9kgLzUeGsdMTSM6lxmO+KHuZGHWGzgbPesj7nO73nghGbykQJFOsBXJutHYU1K
 qDi6w08O7OEQ+5w09dE4jTEg0+xNdvw0enmc5bE8pMrQrE0o2+m7q6Qh6YFG5KVnoRpb
 423g==
X-Gm-Message-State: AJIora8E59OJEVwl7m05VNvieUicg5LfhE4E1Q3uxxJEXTH/5IxC/l4K
 Ef5ol5zvHWa/3uKYAnkXBeDZxg==
X-Google-Smtp-Source: AGRyM1tdsuw4a1j9gy33F5H6/1lCJNtmcoHDg3JPe0urArTe9CdfL96TXQkmJ0C4uBCkAT9O6q1zTg==
X-Received: by 2002:a63:2014:0:b0:411:90a4:6e9c with SMTP id
 g20-20020a632014000000b0041190a46e9cmr21751683pgg.500.1656930016820; 
 Mon, 04 Jul 2022 03:20:16 -0700 (PDT)
Received: from [192.168.138.227] ([122.255.60.245])
 by smtp.gmail.com with ESMTPSA id
 t19-20020a63dd13000000b00401a9bc0f33sm19926332pgg.85.2022.07.04.03.20.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Jul 2022 03:20:16 -0700 (PDT)
Message-ID: <73e221ba-4680-48bb-6472-95ea01fd9b37@linaro.org>
Date: Mon, 4 Jul 2022 15:50:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 09/11] target/openrisc: Interrupt handling fixes
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
References: <20220703212823.10067-1-shorne@gmail.com>
 <20220703212823.10067-10-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20220703212823.10067-10-shorne@gmail.com>
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
Cc: Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 7/4/22 02:58, Stafford Horne wrote:
> When running SMP systems we sometimes were seeing lockups where
> IPI interrupts were being raised by never handled.
> 
> This looks to be caused by 2 issues in the openrisc interrupt handling
> logic.
> 
>   1. After clearing an interrupt the openrisc_cpu_set_irq handler will
>      always clear PICSR.  This is not correct as masked interrupts
>      should still be visible in PICSR.
>   2. After setting PICMR (mask register) and exposed interrupts should
>      cause an interrupt to be raised.  This was not being done so add it.
> 
> This patch fixes both issues.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
