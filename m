Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0EACCA47B
	for <openrisc@archiver.kernel.org>; Thu,  2 Jun 2022 19:59:25 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 84CC3248EA;
	Thu,  2 Jun 2022 21:59:24 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mail.librecores.org (Postfix) with ESMTPS id D5F08240E1
 for <openrisc@lists.librecores.org>; Thu,  2 Jun 2022 21:59:22 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id i1so5351713plg.7
 for <openrisc@lists.librecores.org>; Thu, 02 Jun 2022 12:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7yKMgUuv2zhj5/B8/Lj3TxnmVoVqtuLrhQVs7Z1bwLw=;
 b=AOoVxojcO1u0si+ygxmly+LdcTM0LMB/1hyJeBsgZXYurH/E1oNQIyfSaVaE2z4Tb8
 06HGaYd/qoomeYfNm0/guHsJ0EcORLAUR5qQHBEUjqtc4Fcl1Uf9ziF/hXyKdqv+rGO1
 XqjBAyv7MqIlH80PMiXnUUEusnEeJmkY4tTcxGlmbWevY5skcHt90LXFQRWAJ2iOdu+o
 b0qPs9ZnGb2++PQ8WXN6356AKWfqbDcnxua7miONnYmAgd4UXc8+feQmKHs0Xh7asGRr
 hPhz5hORFqk7a+P/q1D9LeFFeUiI+7V4CVW6uD/yCyqP9k/XNthH0fH2R1npKIEtcEMu
 rtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7yKMgUuv2zhj5/B8/Lj3TxnmVoVqtuLrhQVs7Z1bwLw=;
 b=d2OeSh43QOhKVJmelCM+EOtzmKEjpmQpU7CdWlwCso6iq7BWHG97A7lxesY2jRCRX2
 hs8nmEW741XJofQF4Cj+7yN2oL3ocDyWqjlDJMoGqQhoeH76SpGZX8KI7A/Bm5PEiAzj
 hBMxc5yn0Cz74IbbWwpH/xmsmmPqHu4Udo67HoN7s08m3gPjZ9LijuWV0vU+oSQ0tCkm
 BMyul2U/eFF42pEWoE6lf1IMUk4BhLHIgKeSH6/gTOBKZg0QvrXA7WFLpBQiqiBXTzFp
 Cr5IAjbgDr25+4wngxP7IcNYlXSWm4Q+Eto8436iyDGiih/aLrTYnEKwtbsh5+lz6hEE
 aoXw==
X-Gm-Message-State: AOAM533y2XnkhIev10DsGS+u4sICSohE9X88NvXKMJewADkCt5kDoefG
 NYZcDULd0UV1wE8a3RGL+9A=
X-Google-Smtp-Source: ABdhPJxryUHNx1hDhQijF9zn4kh6BNXKLWLJeX69qD/Er41RpoW3FAfZZrOTE1GHy1qTuJejVvRQaA==
X-Received: by 2002:a17:90b:1646:b0:1e3:15ef:2871 with SMTP id
 il6-20020a17090b164600b001e315ef2871mr21755373pjb.105.1654199961346; 
 Thu, 02 Jun 2022 12:59:21 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a17090a840c00b001dfffd861cbsm6225905pjn.21.2022.06.02.12.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jun 2022 12:59:20 -0700 (PDT)
Date: Fri, 3 Jun 2022 04:59:18 +0900
From: Stafford Horne <shorne@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 3/3] hw/openrisc: Add the OpenRISC virtual machine
Message-ID: <YpkWllpTFzb2HHY5@antec>
References: <20220527172731.1742837-1-shorne@gmail.com>
 <20220527172731.1742837-4-shorne@gmail.com>
 <CACPK8XexaTREY3Y-jp8urTAE+UmQWgygFx1MAss9KcJw5tGMtw@mail.gmail.com>
 <CAMuHMdWF_OwTMZZ=joRsnOAuB5UuKjACt3Ku4-o0--fR6xqQbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWF_OwTMZZ=joRsnOAuB5UuKjACt3Ku4-o0--fR6xqQbQ@mail.gmail.com>
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
 Openrisc <openrisc@lists.librecores.org>,
 QEMU Development <qemu-devel@nongnu.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Jun 02, 2022 at 09:08:52PM +0200, Geert Uytterhoeven wrote:
> Hi Joel,
> 
> On Thu, Jun 2, 2022 at 1:42 PM Joel Stanley <joel@jms.id.au> wrote:
> > On Fri, 27 May 2022 at 17:27, Stafford Horne <shorne@gmail.com> wrote:
> > > This patch add the OpenRISC virtual machine 'virt' for OpenRISC.  This
> > > platform allows for a convenient CI platform for toolchain, software
> > > ports and the OpenRISC linux kernel port.
> > >
> > > Much of this has been sourced from the m68k and riscv virt platforms.
> 
> > I enabled the options:
> >
> > CONFIG_RTC_CLASS=y
> > # CONFIG_RTC_SYSTOHC is not set
> > # CONFIG_RTC_NVMEM is not set
> > CONFIG_RTC_DRV_GOLDFISH=y
> >
> > But it didn't work. It seems the goldfish rtc model doesn't handle a
> > big endian guest running on my little endian host.
> >
> > Doing this fixes it:
> >
> > -    .endianness = DEVICE_NATIVE_ENDIAN,
> > +    .endianness = DEVICE_HOST_ENDIAN,
> >
> > [    0.190000] goldfish_rtc 96005000.rtc: registered as rtc0
> > [    0.190000] goldfish_rtc 96005000.rtc: setting system clock to
> > 2022-06-02T11:16:04 UTC (1654168564)
> >
> > But literally no other model in the tree does this, so I suspect it's
> > not the right fix.
> 
> Goldfish devices are supposed to be little endian.
> Unfortunately m68k got this wrong, cfr.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2e2ac4a3327479f7e2744cdd88a5c823f2057bad
> Please don't duplicate this bad behavior for new architectures

Thanks for the pointer, I just wired in the goldfish RTC because I wanted to
play with it.  I was not attached to it. I can either remove it our find another
RTC.

-Stafford
