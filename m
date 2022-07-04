Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52131C43334
	for <openrisc@archiver.kernel.org>; Mon,  4 Jul 2022 20:40:37 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 7BCFD211D5;
	Mon,  4 Jul 2022 22:40:36 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mail.librecores.org (Postfix) with ESMTPS id F1D3821052
 for <openrisc@lists.librecores.org>; Mon,  4 Jul 2022 22:40:34 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id d5so9344589plo.12
 for <openrisc@lists.librecores.org>; Mon, 04 Jul 2022 13:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=Be3C99dMG8I/iZmt56ebO++H26LE0Tt/O2nc5E40T3o=;
 b=DJtfHF0iKJK986V6cznPBjeMYjBVlCKEBdW4EqiCpXdr6I0rPkyJbsCtv4TdCvGFbN
 c1lEUBYpdTM7Dr6gCUxxkgYV92tPdFZtLKfwB6wBut6mDHCRiw7AawrClTvTEqSoGDhT
 z6RgkfExu+slpHkBUh95QoiEkqjOTcI8FtaFG6WYmS0KNvfCJWSIoCIBmMuJRYi51jij
 Yz0MvjAn3peIVyuh6v/CDCKjTA0B3x0g0hvu6P6Th0HodnY2mvZMaAvASPhrm5mz86T5
 58+rXY2HwfBDx7TgtBJEB8q3nVKohbFtknhUNZSlpTY4wLOpFGibLcNCUbSOd6r0I/Xw
 Fqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Be3C99dMG8I/iZmt56ebO++H26LE0Tt/O2nc5E40T3o=;
 b=rCcAYygGgazEa+gltLuZhUo3Glw4en/HbzySgibOoaOIZILaqVjFgw2FXmeGeMncqz
 sY7o3IMvuSguVfEJbYKyY/19SnCl4KTOsJAceJAAxQWk1UFQAFu4KjuXLICQoJ+cYSs3
 1jrLrLMY7XI8CvmxVyF33Wz+AdH8G8QZ5AzTnUmTiWuPx36j3uVQ/otQELUtZUAmgBhD
 ZKxHgf/uX26ZRME2ynA+rOjNdwpL3D84EyGamfitkGl8DB3tD0r5rIYY3t8XN0zhNgNL
 W51DYrEMZBn5J2vPgtvf3zZEP9C9+RT4ywKOzd+bfhn3ElBPTGItyNRmvTEBeY8YUklz
 6H/w==
X-Gm-Message-State: AJIora+bzDZQxYQzPzqOWc4Uye3/SXi5GJMsgSxoLm64OhojlG+lNG//
 q0q7lfIf0/ZoTJcKx6a7xxw=
X-Google-Smtp-Source: AGRyM1spEoZ2C94uM38fxaqDejYthsxCoKconaB98Z/hVAvpHq9MkUr4GWQUHm8lZT/gUAygyOvEpQ==
X-Received: by 2002:a17:90b:1e03:b0:1ef:967b:a9ac with SMTP id
 pg3-20020a17090b1e0300b001ef967ba9acmr587396pjb.97.1656967233502; 
 Mon, 04 Jul 2022 13:40:33 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a170903019100b00163de9e9342sm22065683plg.17.2022.07.04.13.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jul 2022 13:40:33 -0700 (PDT)
Date: Tue, 5 Jul 2022 05:40:31 +0900
From: Stafford Horne <shorne@gmail.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 03/11] goldfish_rtc: Add endianness property
Message-ID: <YsNQP9UJ5faHNguC@antec>
References: <20220703212823.10067-1-shorne@gmail.com>
 <20220703212823.10067-4-shorne@gmail.com>
 <272f1e82-ff1b-9a7a-931b-91472dd244bf@linaro.org>
 <b8d2595b-c86a-b1b8-8912-13fc9ba782d3@redhat.com>
 <31017a43-3ebb-0aa3-f6ce-d2df1b5dc177@linaro.org>
 <78ac87ee-e40b-8d18-3775-4417edb74fa3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78ac87ee-e40b-8d18-3775-4417edb74fa3@redhat.com>
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
Cc: "open list:Goldfish RTC" <qemu-riscv@nongnu.org>,
 Anup Patel <anup.patel@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Development <qemu-devel@nongnu.org>,
 Openrisc <openrisc@lists.librecores.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Mon, Jul 04, 2022 at 12:23:23PM +0200, Laurent Vivier wrote:
> On 04/07/2022 12:21, Richard Henderson wrote:
> > On 7/4/22 15:46, Laurent Vivier wrote:
> > > On 04/07/2022 11:59, Richard Henderson wrote:
> > > > On 7/4/22 02:58, Stafford Horne wrote:
> > > > > -static const MemoryRegionOps goldfish_rtc_ops = {
> > > > > -    .read = goldfish_rtc_read,
> > > > > -    .write = goldfish_rtc_write,
> > > > > -    .endianness = DEVICE_NATIVE_ENDIAN,
> > > > > -    .valid = {
> > > > > -        .min_access_size = 4,
> > > > > -        .max_access_size = 4
> > > > > -    }
> > > > > +static const MemoryRegionOps goldfish_rtc_ops[3] = {
> > > > > +    [DEVICE_NATIVE_ENDIAN] = {
> > > > > +        .read = goldfish_rtc_read,
> > > > > +        .write = goldfish_rtc_write,
> > > > > +        .endianness = DEVICE_NATIVE_ENDIAN,
> > > > > +        .valid = {
> > > > > +            .min_access_size = 4,
> > > > > +            .max_access_size = 4
> > > > > +        }
> > > > > +    },
> > > > > +    [DEVICE_LITTLE_ENDIAN] = {
> > > > > +        .read = goldfish_rtc_read,
> > > > > +        .write = goldfish_rtc_write,
> > > > > +        .endianness = DEVICE_LITTLE_ENDIAN,
> > > > > +        .valid = {
> > > > > +            .min_access_size = 4,
> > > > > +            .max_access_size = 4
> > > > > +        }
> > > > > +    },
> > > > > +    [DEVICE_BIG_ENDIAN] = {
> > > > > +        .read = goldfish_rtc_read,
> > > > > +        .write = goldfish_rtc_write,
> > > > > +        .endianness = DEVICE_BIG_ENDIAN,
> > > > > +        .valid = {
> > > > > +            .min_access_size = 4,
> > > > > +            .max_access_size = 4
> > > > > +        }
> > > > > +    },
> > > > >   };
> > > > 
> > > > You don't need 3 copies, only big and little.
> > > > 
> > > > > +static Property goldfish_rtc_properties[] = {
> > > > > +    DEFINE_PROP_UINT8("endianness", GoldfishRTCState, endianness,
> > > > > +                      DEVICE_NATIVE_ENDIAN),
> > > > > +    DEFINE_PROP_END_OF_LIST(),
> > > > > +};
> > > > 
> > > > ... and I think the clear desire for default is little-endian. 
> > > > I would make the property be bool, and add a comment that this
> > > > is only for m68k compatibility, so don't use it in new code.
> > > 
> > > m68k doesn't really need this.
> > > 
> > > kernel with the m68k virt machine and goldfish device supports
> > > "native" mode so I think it's not needed to add another layer of
> > > complexity for it.
> > 
> > "Another level"?  I'm talking about removing "native", and only having
> > "big" and "little", which is less complexity.
> 
> "Less complexity" is to keep only native. I'm not against the change, I'm
> just saying it's not needed by m68k.

Hi Laurent,

I would agree if we only had m68k.  But I am making this change so that OpenRISC
(another big-endian architecture) could use this.  In the OpenRISC case we want
to use this as little-endian so no kernel updates would be needed.

So in the end we will have the following qemu platforms:

  riscv{LE}--------------->goldfish_rtc{LE}
  mips-longsoon3{LE}------>goldfish_rtc{LE}
  openrisc{BE}------------>goldfish_rtc{LE} (LE to BE conversion done in driver)
  m68k{BE}---------------->goldfish_rtc{BE} (only big-endian user)

-Stafford
