Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B93C433EF
	for <openrisc@archiver.kernel.org>; Sun, 10 Jul 2022 21:22:32 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id DCF8924807;
	Sun, 10 Jul 2022 23:22:31 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mail.librecores.org (Postfix) with ESMTPS id 679F320D93
 for <openrisc@lists.librecores.org>; Sun, 10 Jul 2022 23:22:29 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id r6so483854plg.3
 for <openrisc@lists.librecores.org>; Sun, 10 Jul 2022 14:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/3Levsfw6LIMCbRxqktEi2reG0/qjlmvH+w7aAlSmdQ=;
 b=oLoJ9m6gLkrWpmwDhevTP4Lanm9YsSml/B7z3qiRlVE833P2ZZ3Y5SiZ9urJqTJTZX
 ZFS2GcEmPq0bWE1V6Phq1cI0c/qNpYLh3VsR7ANRzlMgH1xQqSL1HWYMZUD1XMF0hLSS
 pmcFDIlxPDMEylv3u38YXFb6psCs7nX/BOpSD0Ovk9Q/A5R+gpcEyV63u+eOtckuQ37a
 cYlV+3HhWz7fq12spQqTzH9337RQ5R77Ojq2R54XMsyiagievBsmu/GHyqPkTdtzvbH3
 x7hZsuyOz422y6/i083SoEjcPGByEmbTQ3IzfWx0TfqKLYYaUUyUt17z55g50n2I+q2N
 vJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/3Levsfw6LIMCbRxqktEi2reG0/qjlmvH+w7aAlSmdQ=;
 b=0iR18MYVAuyWNaSXrh5eo7vC47TKxQb473vBy2V+Ek3hfMmiptGTWIau6Y28gUAY3q
 3wyPM7vjXihCVk6p5zLnegE6X59rtqnFJyHuw7s60O5jNfzZWPs4fZHCERAN2OUOI2sx
 Ts1xhuPbUyKZVtX6hMldZLwouKCXw2u38TMbcrvIsGRiyW/mLrJl5Yf0rgfLtlhlkgXS
 wifaNyLdrgW/gEXEcpyY0eGVCiYjGDnh5O/GClP9UPXZmBWBCvAyqoGstMt3UNb7l8iL
 CqMaZ8YR4+zDVk0m38wwOYOMJnIeTgZrPX489Ti8svFcOAAZ+SmvzukYTgixX2fd96Zr
 55bw==
X-Gm-Message-State: AJIora8U/IXpy3grdNO5kOl9BnRTgjSY7VO/Hu+tAlPoUMeOhz2Ap3Pt
 Yob8BFL/fmww/B7S+13+6Qg=
X-Google-Smtp-Source: AGRyM1vMqaM/EJyjGdtD9cIKE8AIgpk7yw38zaY2CA4Y1uh5UF5JsX+gOuF00xlxIRM4O06+hvXr6Q==
X-Received: by 2002:a17:90a:f48a:b0:1ed:5ec:f890 with SMTP id
 bx10-20020a17090af48a00b001ed05ecf890mr13982041pjb.40.1657488147615; 
 Sun, 10 Jul 2022 14:22:27 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a170902e85000b001678dcb4c5asm3145580plg.100.2022.07.10.14.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Jul 2022 14:22:27 -0700 (PDT)
Date: Mon, 11 Jul 2022 06:22:25 +0900
From: Stafford Horne <shorne@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] openrisc: Add pci bus support
Message-ID: <YstDEargBYwjN2Yp@antec>
References: <20220709211549.1163327-1-shorne@gmail.com>
 <20220709211549.1163327-2-shorne@gmail.com>
 <CAK8P3a0Mw0Q9_W+xawMe=7UfiQiJT98wybygqg8E8gEuurZCuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0Mw0Q9_W+xawMe=7UfiQiJT98wybygqg8E8gEuurZCuw@mail.gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, Peter Zijlstra <peterz@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>,
 Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Sun, Jul 10, 2022 at 05:54:22PM +0200, Arnd Bergmann wrote:
> On Sat, Jul 9, 2022 at 11:15 PM Stafford Horne <shorne@gmail.com> wrote:
> >
> > This patch adds required definitions to allow for PCI buses on OpenRISC.
> > This is being in the QEMU virt platform.
> >
> > OpenRISC does not have IO ports so this defines PCI IO to be allowed in
> > any range.  Keeping PIO_RESERVED defined as 0 allows OpenRISC to use
> > MMIO for all IO.
> 
> >
> >  /*
> > - * PCI: can we really do 0 here if we have no port IO?
> > + * PCI: All address space can be used for IO
> >   */
> > -#define IO_SPACE_LIMIT         0
> > +#define IO_SPACE_LIMIT ~(0UL)
> 
> I think '0' is the correct limit here if you don't support PCI controllers
> that can map their I/O ports into MMIO space. If you don't define
> PCI_IOBASE to a meaningful value and set IO_SPACE_LIMIT as you
> do here, every virtual address is treated as an I/O port, so accessing
> a low port through /dev/ioport or a PCI driver results in an access to
> a NULL pointer, which is either a userspace address or low kernel
> memory, both of which are bad.

OK, I see, but I think IO_SPACE_LIMIT needs to be defined as something other
than 0.  It is used to define kernel/resource.c's ioport_resource. For example
on risc-v they set it to 16MB.

I will setup a LIMIT smaller than 4GB and add a PCI_IOBASE.

> Most PCI controller are however able to map I/O ports into the
> physical address space of the CPU, and in that case you can just
> define an otherwise unused address as PCI_IOBASE and map the
> ports there from the PCI host bridge driver.

OK, understood, do you think this needs to be documented in a architecture
manual?  Maybe it's fine for it to be linux specific.

-Stafford
