Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548EBC43334
	for <openrisc@archiver.kernel.org>; Mon,  4 Jul 2022 10:05:00 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 6458A248CC;
	Mon,  4 Jul 2022 12:04:59 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by mail.librecores.org (Postfix) with ESMTPS id DAE5320C94
 for <openrisc@lists.librecores.org>; Mon,  4 Jul 2022 12:04:57 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id w24so8873882pjg.5
 for <openrisc@lists.librecores.org>; Mon, 04 Jul 2022 03:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Y2UdUSLsrWZRupU3Wg8brz+hYQL1lV6lQs/rPmy49Yc=;
 b=rRUmS78cGBqe2OprnH7Legf3kUSa2LkbMa3RXYJlDSLj1AGI5xCRn5DDqWyb6NR2Fz
 q4idxeRFcE+BSdDIA5hpqYz+yaTHJT8CWUH9OM3eOe2rowUGhWWT523d8drsJCeBG/tc
 Rh4e1ZWnUTM5j8keGNCjqEwyDLMD6pyiHqsu8RT404TNtr5bo2G8yUVNSrMYRd3uK0Po
 THpca3aantqWfd3NS/H3F0jYSReAX5wRjCc46BDcU0Zcn+oZrffp3IW8+RcnJ08LZ7W/
 WFV5dnk8zmelrlUMpPtSD8BWmp+34EU/OOPMk1bxMp+aMIRUqJUtsEIa0X83zXl+dYbz
 jQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Y2UdUSLsrWZRupU3Wg8brz+hYQL1lV6lQs/rPmy49Yc=;
 b=WspHuVG15T/iugIJ84ITLD0n2HjZYyjbPpg/5TxqchNEGsm9Q3gYPkO34oHDuiT/jy
 mWVHW4Z2yD+ciaCgBEk6y2jg3B2zl7GENO/BkYb4ifhxsV325rv2Eqg1wX5Lpg8U8MO9
 +JPjm0xn2npJ8tUSchk47CtxJy8sAyXgwxiuC8xxF77XzWUI7NS7bkt741f6JPU6jGEn
 BspqT2z/YT3qKHM/0j+rcSwgLeaLk7T+/K8hO/enkFhXkyRpburYDt561ZSkrIKUwY/u
 NX1TrmA+0h3X+7UDW4Ujj5cBp6bFnSZ6983eeP4u8VdXm1dswClgUzJnMFxyuX3a9EEX
 +8cQ==
X-Gm-Message-State: AJIora8TOJlCvZb01DVZayRJCAII1P+khRuVH9wWiKnPpmY2Iocze5Vs
 Ys+kIGivZD1QkFaSIOpyUZ/9kQ==
X-Google-Smtp-Source: AGRyM1ueMpQnDlOZuFGfNvjlMipzfsSyp0NnDoXHepwjv8r3jtIl7Ltnhvmw1wd4FL+fdOVEToHUjA==
X-Received: by 2002:a17:90b:4ac6:b0:1ed:1811:5009 with SMTP id
 mh6-20020a17090b4ac600b001ed18115009mr35821354pjb.47.1656929096570; 
 Mon, 04 Jul 2022 03:04:56 -0700 (PDT)
Received: from [192.168.138.227] ([122.255.60.245])
 by smtp.gmail.com with ESMTPSA id
 w17-20020aa78591000000b0051b9ac5a377sm20618763pfn.213.2022.07.04.03.04.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Jul 2022 03:04:56 -0700 (PDT)
Message-ID: <4bfc20ec-962b-2017-f2ba-26cd65bd3d9f@linaro.org>
Date: Mon, 4 Jul 2022 15:34:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 07/11] target/openrisc: Add interrupted CPU to log
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
References: <20220703212823.10067-1-shorne@gmail.com>
 <20220703212823.10067-8-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20220703212823.10067-8-shorne@gmail.com>
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
> When we are tracing it's helpful to know which CPU's are getting
> interrupted, att that detail to the log line.

"at".

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>   target/openrisc/interrupt.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
> index e5724f5371..c31c6f12c4 100644
> --- a/target/openrisc/interrupt.c
> +++ b/target/openrisc/interrupt.c
> @@ -83,7 +83,9 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
>               [EXCP_TRAP]     = "TRAP",
>           };
>   
> -        qemu_log_mask(CPU_LOG_INT, "INT: %s\n", int_name[exception]);
> +        qemu_log_mask(CPU_LOG_INT, "CPU: %d INT: %s\n",
> +                      cs->cpu_index,
> +                      int_name[exception]);
>   
>           hwaddr vect_pc = exception << 8;
>           if (env->cpucfgr & CPUCFGR_EVBARP) {

