Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7643CC433EF
	for <openrisc@archiver.kernel.org>; Mon,  4 Jul 2022 20:19:58 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 47ADF20C94;
	Mon,  4 Jul 2022 22:19:57 +0200 (CEST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by mail.librecores.org (Postfix) with ESMTPS id 5D53B2406B
 for <openrisc@lists.librecores.org>; Mon,  4 Jul 2022 04:50:14 +0200 (CEST)
Received: by mail-lf1-f52.google.com with SMTP id a13so13491402lfr.10
 for <openrisc@lists.librecores.org>; Sun, 03 Jul 2022 19:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cApzcqFSJGGr159Dn/wuU/Q6cCNx66DVHb7zVnm3mkc=;
 b=HstQickokC+hA8FgySGkQLY1IGgaBJ9Y+8D13cEHrORGYAhjmSKmXaOZaeuhGR6DDd
 U8dbOhb73ISsAunLr8uUvpVfOLqXeh3k3jb6kjiBxkxlaUWKV58nwo01epJi7dlGSz2N
 Jrds3i56/Nq5ZLdv5Z84zUvlPSkjBaem8BFg93YSJJRpVpBX1zvAPgZUOLthi+Vrv5mR
 jOt3Lb+DH0O7sBrvY0HWrQRNeOfevB2V0+rKN5g8JFa0Sf8SLDs1bmLgtVLNpVa5dWuW
 CLYkyXftauqGkX4k49ORY8vRQ+BNMGUAy0Q37RrHuUcYVt3j982PzuzwYH5wrdvU/6xd
 CEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cApzcqFSJGGr159Dn/wuU/Q6cCNx66DVHb7zVnm3mkc=;
 b=jRiUaOAhQd36rrebQd80RGpKLpYrsiznnCQpzJDozpraBV5eClGK1su55rHJ9piZ9n
 soeLr2XZ8xO6mNdSOZr7vlEN+qZgT8oyAlHIHkswra95qpWinEzSlSk9y5LEvQuq/90d
 DqDOfWefSJGL7Lp9U7Op3OOz3iw+h5wgcTWRlc05x60Ebsccya1gc5DyJK3JNmNPjLHh
 idVOTZN34FZ9/PQ9Ar7e21eJQpIefjNG58ahBzXYU0cxzsOnEvpUNIq2R8ERwvkzqpVA
 nYwddznUXGvKjlfcrIuRn2R2Wgg9+vbimJUxGRRwIACEEHZsRd0PmqL/5VGXy7o7c2cl
 RusA==
X-Gm-Message-State: AJIora+DANBIU5Uw+dPjp6LOrQov3Rri0P85KrGygaN6/sS7hIJHkDAF
 /UKwOkQegB++Y2i2VLeRvMPBuzY/OEQMOnZp5BXGxQ==
X-Google-Smtp-Source: AGRyM1tpgmtMM9w6THrPCFKjvSOkrSL0x3kTikBD160yKkEVsrehYx/Jo30fdR9FOozZDhY97/kBB0h8DDJarU72irM=
X-Received: by 2002:a05:6512:3b22:b0:47f:6756:143 with SMTP id
 f34-20020a0565123b2200b0047f67560143mr16954227lfv.419.1656903013611; Sun, 03
 Jul 2022 19:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220703212823.10067-1-shorne@gmail.com>
 <20220703212823.10067-4-shorne@gmail.com>
In-Reply-To: <20220703212823.10067-4-shorne@gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 4 Jul 2022 08:20:02 +0530
Message-ID: <CAK9=C2WxQkPqbVvy+9saLSzVRKy58099p8Wff_3VaN+Ee3oWkw@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] goldfish_rtc: Add endianness property
To: Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 04 Jul 2022 22:19:56 +0200
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

On Mon, Jul 4, 2022 at 2:59 AM Stafford Horne <shorne@gmail.com> wrote:
>
> Add an endianness property to allow configuring the RTC as either
> native, little or big endian.
>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  hw/rtc/goldfish_rtc.c         | 46 ++++++++++++++++++++++++++++-------
>  include/hw/rtc/goldfish_rtc.h |  2 ++
>  2 files changed, 39 insertions(+), 9 deletions(-)
>
> diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
> index 35e493be31..24f6587086 100644
> --- a/hw/rtc/goldfish_rtc.c
> +++ b/hw/rtc/goldfish_rtc.c
> @@ -216,14 +216,34 @@ static int goldfish_rtc_post_load(void *opaque, int version_id)
>      return 0;
>  }
>
> -static const MemoryRegionOps goldfish_rtc_ops = {
> -    .read = goldfish_rtc_read,
> -    .write = goldfish_rtc_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> -    .valid = {
> -        .min_access_size = 4,
> -        .max_access_size = 4
> -    }
> +static const MemoryRegionOps goldfish_rtc_ops[3] = {
> +    [DEVICE_NATIVE_ENDIAN] = {
> +        .read = goldfish_rtc_read,
> +        .write = goldfish_rtc_write,
> +        .endianness = DEVICE_NATIVE_ENDIAN,
> +        .valid = {
> +            .min_access_size = 4,
> +            .max_access_size = 4
> +        }
> +    },
> +    [DEVICE_LITTLE_ENDIAN] = {
> +        .read = goldfish_rtc_read,
> +        .write = goldfish_rtc_write,
> +        .endianness = DEVICE_LITTLE_ENDIAN,
> +        .valid = {
> +            .min_access_size = 4,
> +            .max_access_size = 4
> +        }
> +    },
> +    [DEVICE_BIG_ENDIAN] = {
> +        .read = goldfish_rtc_read,
> +        .write = goldfish_rtc_write,
> +        .endianness = DEVICE_BIG_ENDIAN,
> +        .valid = {
> +            .min_access_size = 4,
> +            .max_access_size = 4
> +        }
> +    },
>  };
>
>  static const VMStateDescription goldfish_rtc_vmstate = {
> @@ -265,7 +285,8 @@ static void goldfish_rtc_realize(DeviceState *d, Error **errp)
>      SysBusDevice *dev = SYS_BUS_DEVICE(d);
>      GoldfishRTCState *s = GOLDFISH_RTC(d);
>
> -    memory_region_init_io(&s->iomem, OBJECT(s), &goldfish_rtc_ops, s,
> +    memory_region_init_io(&s->iomem, OBJECT(s),
> +                          &goldfish_rtc_ops[s->endianness], s,
>                            "goldfish_rtc", 0x24);
>      sysbus_init_mmio(dev, &s->iomem);
>
> @@ -274,10 +295,17 @@ static void goldfish_rtc_realize(DeviceState *d, Error **errp)
>      s->timer = timer_new_ns(rtc_clock, goldfish_rtc_interrupt, s);
>  }
>
> +static Property goldfish_rtc_properties[] = {
> +    DEFINE_PROP_UINT8("endianness", GoldfishRTCState, endianness,
> +                      DEVICE_NATIVE_ENDIAN),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void goldfish_rtc_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>
> +    device_class_set_props(dc, goldfish_rtc_properties);
>      dc->realize = goldfish_rtc_realize;
>      dc->reset = goldfish_rtc_reset;
>      dc->vmsd = &goldfish_rtc_vmstate;
> diff --git a/include/hw/rtc/goldfish_rtc.h b/include/hw/rtc/goldfish_rtc.h
> index 79ca7daf5d..8e1aeb85e3 100644
> --- a/include/hw/rtc/goldfish_rtc.h
> +++ b/include/hw/rtc/goldfish_rtc.h
> @@ -42,6 +42,8 @@ struct GoldfishRTCState {
>      uint32_t irq_pending;
>      uint32_t irq_enabled;
>      uint32_t time_high;
> +
> +    uint8_t endianness;
>  };
>
>  #endif
> --
> 2.36.1
>
>
