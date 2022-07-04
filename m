Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEC5C43334
	for <openrisc@archiver.kernel.org>; Mon,  4 Jul 2022 20:32:47 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 747DE21052;
	Mon,  4 Jul 2022 22:32:46 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by mail.librecores.org (Postfix) with ESMTPS id 9880920C94
 for <openrisc@lists.librecores.org>; Mon,  4 Jul 2022 22:32:44 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id fz10so4171317pjb.2
 for <openrisc@lists.librecores.org>; Mon, 04 Jul 2022 13:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Nah4inMHP7Jt663zolAnZeMcm+3tMIIpWudIf33/EBE=;
 b=CmyUwRqNJaA5apLApg26JjA6Y7VDllco1ia5ydGeGYQQh7IxC0gJqoTpR9gZNHNjY7
 S1althdiFjK/sgjGCUURKC8gOfQD0GJ7rqljwlFk4xSH7gJs0negWgoCevAQpxmUOU2A
 1TrP627QpG2RcClBpyOB+/64UxkDCL9ntntNsxBIjGGUtRbeleHprilDZYC1zTyAfJsx
 Sck5RUP8u3J8m9mLaApAEUrFUFl5fOjZogzcJrI8+kqfBLWyc8vOAlFj29qY8LshNv7V
 Bf0tp4L1STo++s4hWwHAxe0n0l5AQhjK2ADFTHgWPvpZFz8k3CkwwmgdIoBwqx3476SW
 Jyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Nah4inMHP7Jt663zolAnZeMcm+3tMIIpWudIf33/EBE=;
 b=SeF41niZU09SRO7Zluq5Kn9dlwzmr2Cp1l/VQWG6ne/W5LsTq626cZsmdj0ELqmJP0
 r/4QlJujV1sWaNcQbW7TFTcz0/MaOD+iywPSYX7accYw7QOz2+ILVyaiajYMyNyN3LLj
 iFFFs0zr+PizHAFB9JvI0JqG8WE/1XnPY62o2KdtXOLTRseCBKGBtekhPMg0pFwgU3Uc
 p35mRP+njMITC7dZMKgrwef9iQgJKIqm8xnTYqRihgTcRhxvkQ8ZSTWvRuez8UccnGQr
 6VDQ+W7bOuxRRalixGXUJ9Vxa/134I6wWBP6PDPXAH+G8WbnN9WBUI03WeotCuBqr0c5
 gnYA==
X-Gm-Message-State: AJIora+O1GAy03o1nrskXa19A/gdYsJVDna1jOXI0wMxXyUTRiKN3Bcd
 K+QTkeTEDiWIUuVQP51kkLU=
X-Google-Smtp-Source: AGRyM1u43xujI+aV4hwz1MPCSz5TcrI1sHpMwoQKZZj5xMLZ2La76gTvZKm6vqj5UWQcGQ3f9lT1fA==
X-Received: by 2002:a17:90b:3842:b0:1ed:16aa:def6 with SMTP id
 nl2-20020a17090b384200b001ed16aadef6mr39974438pjb.130.1656966763303; 
 Mon, 04 Jul 2022 13:32:43 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 r5-20020a17090b050500b001ec85441515sm13011217pjz.24.2022.07.04.13.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jul 2022 13:32:42 -0700 (PDT)
Date: Tue, 5 Jul 2022 05:32:41 +0900
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 03/11] goldfish_rtc: Add endianness property
Message-ID: <YsNOaazY3HsxF+hj@antec>
References: <20220703212823.10067-1-shorne@gmail.com>
 <20220703212823.10067-4-shorne@gmail.com>
 <272f1e82-ff1b-9a7a-931b-91472dd244bf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <272f1e82-ff1b-9a7a-931b-91472dd244bf@linaro.org>
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 "open list:Goldfish RTC" <qemu-riscv@nongnu.org>,
 Anup Patel <anup.patel@wdc.com>, QEMU Development <qemu-devel@nongnu.org>,
 Openrisc <openrisc@lists.librecores.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Mon, Jul 04, 2022 at 03:29:57PM +0530, Richard Henderson wrote:
> On 7/4/22 02:58, Stafford Horne wrote:
> > -static const MemoryRegionOps goldfish_rtc_ops = {
> > -    .read = goldfish_rtc_read,
> > -    .write = goldfish_rtc_write,
> > -    .endianness = DEVICE_NATIVE_ENDIAN,
> > -    .valid = {
> > -        .min_access_size = 4,
> > -        .max_access_size = 4
> > -    }
> > +static const MemoryRegionOps goldfish_rtc_ops[3] = {
> > +    [DEVICE_NATIVE_ENDIAN] = {
> > +        .read = goldfish_rtc_read,
> > +        .write = goldfish_rtc_write,
> > +        .endianness = DEVICE_NATIVE_ENDIAN,
> > +        .valid = {
> > +            .min_access_size = 4,
> > +            .max_access_size = 4
> > +        }
> > +    },
> > +    [DEVICE_LITTLE_ENDIAN] = {
> > +        .read = goldfish_rtc_read,
> > +        .write = goldfish_rtc_write,
> > +        .endianness = DEVICE_LITTLE_ENDIAN,
> > +        .valid = {
> > +            .min_access_size = 4,
> > +            .max_access_size = 4
> > +        }
> > +    },
> > +    [DEVICE_BIG_ENDIAN] = {
> > +        .read = goldfish_rtc_read,
> > +        .write = goldfish_rtc_write,
> > +        .endianness = DEVICE_BIG_ENDIAN,
> > +        .valid = {
> > +            .min_access_size = 4,
> > +            .max_access_size = 4
> > +        }
> > +    },
> >   };
> 
> You don't need 3 copies, only big and little.
> 
> > +static Property goldfish_rtc_properties[] = {
> > +    DEFINE_PROP_UINT8("endianness", GoldfishRTCState, endianness,
> > +                      DEVICE_NATIVE_ENDIAN),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> 
> ... and I think the clear desire for default is little-endian.  I would make
> the property be bool, and add a comment that this is only for m68k
> compatibility, so don't use it in new code.

Yeah, that makes sense.

-Stafford
