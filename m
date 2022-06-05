Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B098C433EF
	for <openrisc@archiver.kernel.org>; Sun,  5 Jun 2022 02:36:29 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 67DA824953;
	Sun,  5 Jun 2022 04:36:28 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mail.librecores.org (Postfix) with ESMTPS id C73D424945
 for <openrisc@lists.librecores.org>; Sun,  5 Jun 2022 04:36:26 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 hv24-20020a17090ae41800b001e33eebdb5dso9569716pjb.0
 for <openrisc@lists.librecores.org>; Sat, 04 Jun 2022 19:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=uJ1zOTL1wOn/rNpj6eR5rWvOMwV79LKxVRcBqz8TgJQ=;
 b=O68A06G2OdVYZzKIL1Je/VSiBRIqlMZIS7HC8d4tZpODFiFAw3dZyjCz0uFZXFQTe7
 cnMJp3cjocFO//rQTIcWq2nY/mFt2sTKcSaDGO1pDcDfS2vm4jRHDWeDH5f8gBY2WNY3
 xfkd3s0qlnnlHLiyh0YxnFwlP4Jqb5z5LpUo1YZ3pBytrQJyb9yd/ZhYi0fnDfmC3aRt
 RvAnG+iSf+SG+lQOEU8dHP2yAWtPQOp19xQA6KHSRi2g9bWgHahtcjr9OA0wpM05iZCF
 sL3KONkVsctlAM6wNfH54Wku7DllrbSRUMUqzZRf77GK6IRCLRyEzaYrSndvYMQtFThO
 KRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uJ1zOTL1wOn/rNpj6eR5rWvOMwV79LKxVRcBqz8TgJQ=;
 b=mFLsrzKF76wPAHwaAjIGLvX2FqBKRy5MLhNIVvt2l5eDthWSG1vycjfxJkiRnhx9i7
 C1dKnUwz5ZcdROHf2dY8dgTBvJeb3dqjO/jq+KZstfzAwot/1wnb/FlohuWMl4+pygAT
 x2shqYesbJLeqkpVGfNbVeu39GKJ9auRoqx4haJRmW/swfiZSDH1yP48LPqhzz3eqGM3
 MI5V6K9pLgtY7QtDnHTtOxP4GQcOmydmILc/PaS49qi91iRj4iRXARX+G5xEzxnz4fhx
 tSAUO8zXHfAm7iKQtNryLK4hzg7jASYqxaH/GO21uvpH7KxksHAHdx51APi95BuWWnJd
 hZVQ==
X-Gm-Message-State: AOAM531ZFpts9CR5qZZlIoNCHvJ7zhqCqs8xb3s/1Nlfzp7R4tlqcCBO
 B2AFzwCmv4lJ43U1A7w3gCvGMtAvVzg=
X-Google-Smtp-Source: ABdhPJzFziDi2AN+BZtCxPXcEjoqKYFNl4nCNtSjKhBP/C2J/YquvfJiGHf0YCQ/fRaqff2n36W2oQ==
X-Received: by 2002:a17:902:b215:b0:165:7bdd:a9f1 with SMTP id
 t21-20020a170902b21500b001657bdda9f1mr17686654plr.41.1654396585199; 
 Sat, 04 Jun 2022 19:36:25 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 x25-20020aa78f19000000b0051bfd13809fsm1393944pfr.119.2022.06.04.19.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jun 2022 19:36:24 -0700 (PDT)
Date: Sun, 5 Jun 2022 11:36:22 +0900
From: Stafford Horne <shorne@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: [RFC PATCH 3/3] hw/openrisc: Add the OpenRISC virtual machine
Message-ID: <YpwWpifmE4vvDJjn@antec>
References: <20220527172731.1742837-1-shorne@gmail.com>
 <20220527172731.1742837-4-shorne@gmail.com>
 <CACPK8XexaTREY3Y-jp8urTAE+UmQWgygFx1MAss9KcJw5tGMtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XexaTREY3Y-jp8urTAE+UmQWgygFx1MAss9KcJw5tGMtw@mail.gmail.com>
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

On Thu, Jun 02, 2022 at 11:42:30AM +0000, Joel Stanley wrote:
> Hi Stafford,
> 
> On Fri, 27 May 2022 at 17:27, Stafford Horne <shorne@gmail.com> wrote:
> >
> > This patch add the OpenRISC virtual machine 'virt' for OpenRISC.  This
> > platform allows for a convenient CI platform for toolchain, software
> > ports and the OpenRISC linux kernel port.
> >
> > Much of this has been sourced from the m68k and riscv virt platforms.
> 
> It's a good idea! I did some playing around with your patch today.
> 
> I'd suggest adding something to docs/system/target-openrsic.rst,
> including an example command lines.

Yeah, good idea, this is the command I am using:

qemu-system-or1k -cpu or1200 -M virt \
  -kernel /home/shorne/work/linux/vmlinux \
  -initrd /home/shorne/work/linux/initramfs.cpio.gz \
  -device virtio-net-device,netdev=user -netdev user,id=user,net=10.9.0.1/24,host=10.9.0.100 \
  -serial mon:stdio -nographic \
  -device virtio-blk-device,drive=d0 -drive file=/home/shorne/work/linux/virt.qcow2,id=d0,if=none,format=qcow2 \
  -gdb tcp::10001 -smp cpus=2 -m 64

I should have mentioned it but the config I am using is here:

  https://github.com/stffrdhrn/linux/commits/or1k-virt

> >
> > The platform provides:
> >  - OpenRISC SMP with up to 8 cpus
> 
> You have this:
> 
> #define VIRT_CPUS_MAX 4
> i
> I tried booting with -smp 4 and it locked up when starting userspace
> (or I stopped getting serial output?):
> 
> [    0.060000] smp: Brought up 1 node, 4 CPUs
> ...
> [    0.960000] Run /init as init process
> 
> Running with -smp 2 and 3 worked. It does make booting much much slower.

Right, it should be 4, I just write 8 from memory.  You are also, right I have
issues with running 4 CPU's.  I will try richard's suggestion.  I have some old
patches to configure MTTCG also, but it had some limitations.  I will dig those
up and get this fixed for this series.

> >  - Generated RTC to automatically configure the guest kernel
> 
> Did you mean device tree?

Yeah, thats what I meant.

> >
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  configs/devices/or1k-softmmu/default.mak |   1 +
> >  hw/openrisc/Kconfig                      |   9 +
> >  hw/openrisc/meson.build                  |   1 +
> >  hw/openrisc/virt.c                       | 429 +++++++++++++++++++++++
> >  4 files changed, 440 insertions(+)
> >  create mode 100644 hw/openrisc/virt.c
> >
> > diff --git a/configs/devices/or1k-softmmu/default.mak b/configs/devices/or1k-softmmu/default.mak
> > index 5b3ac89491..f3bf816067 100644
> > --- a/configs/devices/or1k-softmmu/default.mak
> > +++ b/configs/devices/or1k-softmmu/default.mak
> > @@ -5,3 +5,4 @@ CONFIG_SEMIHOSTING=y
> >  # Boards:
> >  #
> >  CONFIG_OR1K_SIM=y
> > +CONFIG_OR1K_VIRT=y
> > diff --git a/hw/openrisc/Kconfig b/hw/openrisc/Kconfig
> > index 8f284f3ba0..202134668e 100644
> > --- a/hw/openrisc/Kconfig
> > +++ b/hw/openrisc/Kconfig
> > @@ -4,3 +4,12 @@ config OR1K_SIM
> >      select OPENCORES_ETH
> >      select OMPIC
> >      select SPLIT_IRQ
> > +
> > +config OR1K_VIRT
> > +    bool
> > +    imply VIRTIO_VGA
> > +    imply TEST_DEVICES
> > +    select GOLDFISH_RTC
> > +    select SERIAL
> > +    select SIFIVE_TEST
> > +    select VIRTIO_MMIO
> 
> You could include the liteeth device too if we merged that.

I think we could add that with a litex machine.  For that we would need at least
the litex UART and SoC for reset.

> > diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
> > new file mode 100644
> > index 0000000000..147196fda3
> > --- /dev/null
> > +++ b/hw/openrisc/virt.c
> > @@ -0,0 +1,429 @@
> > +/*
> > + * OpenRISC QEMU virtual machine.
> > + *
> > + * Copyright (c) 2022 Stafford Horne <shorne@gmail.com>
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2.1 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> 
> I think you can use the SPDX tag here instead of writing out the text.

Right.

> > +static void openrisc_virt_init(MachineState *machine)
> > +{
> > +    ram_addr_t ram_size = machine->ram_size;
> > +    const char *kernel_filename = machine->kernel_filename;
> > +    OpenRISCCPU *cpus[VIRT_CPUS_MAX] = {};
> > +    OR1KVirtState *state = VIRT_MACHINE(machine);
> > +    MemoryRegion *ram;
> > +    hwaddr load_addr;
> > +    int n;
> > +    unsigned int smp_cpus = machine->smp.cpus;
> > +
> 
> > +    openrisc_virt_rtc_init(state, virt_memmap[VIRT_RTC].base,
> > +                           virt_memmap[VIRT_RTC].size, smp_cpus, cpus,
> > +                           VIRT_RTC_IRQ);
> > +
> > +    for (n = 0; n < VIRTIO_COUNT; n++) {
> 
> This would make more sense to me if you constructed the IRQ and base
> here, and then passed the actual base and irq number to your
> _virtio_init:
> 
>         size_t size = virt_memmap[VIRT_VIRTIO].size;
>         openrisc_virt_virtio_init(state, virt_memmap[VIRT_VIRTIO].base
> + size * n,
>                                   size, smp_cpus, cpus, VIRT_VIRTIO_IRQ + n);
> 

OK, yes that is better.

> > +        openrisc_virt_virtio_init(state, virt_memmap[VIRT_VIRTIO].base,
> > +                                  virt_memmap[VIRT_VIRTIO].size,
> > +                                  smp_cpus, cpus, VIRT_VIRTIO_IRQ, n);
> > +    }
> > +

Thanks a lot for the review.

-Stafford
