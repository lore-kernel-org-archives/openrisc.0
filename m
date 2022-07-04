Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83B4C43334
	for <openrisc@archiver.kernel.org>; Mon,  4 Jul 2022 10:22:41 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id DCD6F23F5F;
	Mon,  4 Jul 2022 12:22:40 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mail.librecores.org (Postfix) with ESMTPS id CFA4420857
 for <openrisc@lists.librecores.org>; Mon,  4 Jul 2022 12:22:38 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id c13so4439220pla.6
 for <openrisc@lists.librecores.org>; Mon, 04 Jul 2022 03:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=x1FQ4SD+T/q9LbUaiwrESLF9Dnc5gxA2nv+MxAUCQoU=;
 b=R3Pq/9xxOOVXbQiskSsSs0MPhtGP2cIX6vnHnmer3WePqEv8U2S9VIMJp4TDDU5TyP
 bjfWOnrLwn2XxDnYybLTozstgM3Wy5l7iwKTQz9qG5PojL/Y3REPf5dR1ZlXM3LwmOUM
 W0EuhhzD2MHkruJkiQCHDWCcsCTin8G0LLiKYSjfgoTNqiF4ExgfVEfzHUtyg6O/7Agj
 oPA09x9F8M6EWRJGmxqzg02RxiHscI0KHWzxgx5CFGUoWdBT9jz4wzYP7wfkNFZmEoYF
 LKdPam/yGvjSTcQRNhOU2QtxQLMmdHV8Z3DJ07t0PgXT+cIeAW+bSIRsIBX2g5QENtxc
 M8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=x1FQ4SD+T/q9LbUaiwrESLF9Dnc5gxA2nv+MxAUCQoU=;
 b=NHs/6eBDSfo7HZO15yNIswFBJR2zqJwV4WrbY8XKn5JPqgATqDX7m3Dl2SpbBZlDMg
 jh2E1vBIN10mLnTRp+xKrrEqMuHZJt5MnX5WAAIXhTwv4ncs/G8vYiM7XHc550A6jkzg
 60vx4pso6cTOb9ZL0SXbl755CZiLmXye54RQKjqZmHzLV5A7PXFLQC6kpy1XmqdslqnN
 /+Bvqb32hz90pDOq4LIbig/eEa/MTSdbatSeph1QPKVUpRY2z3rkhiOYVhXmCSenmNZY
 WlAPxmdfW138SS9OA/LyNQxCFzTGzrsdlA0Y4S5/aQI/0A1kSyAq8ncdDZFoFFszA8eG
 vLmg==
X-Gm-Message-State: AJIora9ChcDurzFfPePuiq64T/Rfr77rH+ZwD8VkHDqNa8qNXNWUtQcc
 sXTe939nfBV7frS0nJK3NP1nJg==
X-Google-Smtp-Source: AGRyM1vLsZDAaBBhO8tU+9cILnG4oDD0A62oKFn7i7fr67E9/mM2qmKXjrh9/bKzz6++2kqdNskFOQ==
X-Received: by 2002:a17:902:c792:b0:16b:e8d4:e13c with SMTP id
 w18-20020a170902c79200b0016be8d4e13cmr1912194pla.150.1656930157521; 
 Mon, 04 Jul 2022 03:22:37 -0700 (PDT)
Received: from [192.168.138.227] ([122.255.60.245])
 by smtp.gmail.com with ESMTPSA id
 a8-20020a656048000000b003db7de758besm20203117pgp.5.2022.07.04.03.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Jul 2022 03:22:37 -0700 (PDT)
Message-ID: <884cb096-dade-c11a-ff18-62935ef63d56@linaro.org>
Date: Mon, 4 Jul 2022 15:52:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 10/11] hw/openrisc: virt: pass random seed to fdt
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
References: <20220703212823.10067-1-shorne@gmail.com>
 <20220703212823.10067-11-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20220703212823.10067-11-shorne@gmail.com>
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 7/4/22 02:58, Stafford Horne wrote:
> From: "Jason A. Donenfeld" <Jason@zx2c4.com>
> 
> If the FDT contains /chosen/rng-seed, then the Linux RNG will use it to
> initialize early. Set this using the usual guest random number
> generation function. This is confirmed to successfully initialize the
> RNG on Linux 5.19-rc2.
> 
> Cc: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

You could remove yourself from cc now that you've signed it.  :-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
