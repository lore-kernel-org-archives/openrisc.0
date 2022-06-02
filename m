Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242B8C43334
	for <openrisc@archiver.kernel.org>; Thu,  2 Jun 2022 11:42:45 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id D01192480A;
	Thu,  2 Jun 2022 13:42:44 +0200 (CEST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mail.librecores.org (Postfix) with ESMTPS id B5E7C240E1
 for <openrisc@lists.librecores.org>; Thu,  2 Jun 2022 13:42:43 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id x17so6109341wrg.6
 for <openrisc@lists.librecores.org>; Thu, 02 Jun 2022 04:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FEp9beiefvRaVBrOt/ntscjwiQ2tI8ugnnCH+ZhXlY8=;
 b=bkABMwmXVOXZQKVGjW/bMKSLoL2hcIybVRF9kZih+tQd3Eeye4X9irDVvIR5QRqIhh
 yyg+PULd435pRDEV0ElUMJJeXpgMUNPx5VWzakGS0GPsqxzjUUxx572KJRUJkw5Dxahb
 R4+Zs02H+DvYlehGxhQznybGyL0a6mZ6ag6n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FEp9beiefvRaVBrOt/ntscjwiQ2tI8ugnnCH+ZhXlY8=;
 b=WjDAnQqIaKPcWLRZ/oBInEdobf6IFJ7KK8S4m5mRSeTZUsFJ4gegQEHjgcS+lCmGAp
 +bYbWGcD2sIHmxjt6WWMsSEFoPuR7JpG7NrXMPGgUCWCD67KfDIInseppUqCLsvgR6LG
 CsCqLRC/qjKgK5VX4PFsYFznPn5J8HuHKc4y9jiqWboxaWB8WF4u3aj1QMJxueFMeeg6
 j3e5e0gSfHjZj0hhPzSwAkDuhUy85gxyCqoxLHjKIj/gzrORDf92Z52RRR5RpP2vDez4
 /Zs0GmO7EksQOMusBFbx//PLOBjT8s+a4/f0kSHVaPtL/F8ID18EbylJybEuLpMnBlLB
 joSQ==
X-Gm-Message-State: AOAM53324BzARwQKm1ZYXzd3v+o6Ya++d6dACdIqKg04wTsRnYn6Kypc
 1qvI/zfgyee8FAjdMBzxmyRvhX2qwgxbL1XQtRI=
X-Google-Smtp-Source: ABdhPJzGeeXhBHcR26JRZu0XlouhaTx4wQB6ctw+pwVatBQcOGMc3esOArfWm3ZY2c5SYayOlVnLPJ3lFWaZUYJ6oHQ=
X-Received: by 2002:a5d:428f:0:b0:210:30cd:3753 with SMTP id
 k15-20020a5d428f000000b0021030cd3753mr3284678wrq.549.1654170163078; Thu, 02
 Jun 2022 04:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220527172731.1742837-1-shorne@gmail.com>
 <20220527172731.1742837-4-shorne@gmail.com>
In-Reply-To: <20220527172731.1742837-4-shorne@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 2 Jun 2022 11:42:30 +0000
Message-ID: <CACPK8XexaTREY3Y-jp8urTAE+UmQWgygFx1MAss9KcJw5tGMtw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] hw/openrisc: Add the OpenRISC virtual machine
To: Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Stafford,

On Fri, 27 May 2022 at 17:27, Stafford Horne <shorne@gmail.com> wrote:
>
> This patch add the OpenRISC virtual machine 'virt' for OpenRISC.  This
> platform allows for a convenient CI platform for toolchain, software
> ports and the OpenRISC linux kernel port.
>
> Much of this has been sourced from the m68k and riscv virt platforms.

It's a good idea! I did some playing around with your patch today.

I'd suggest adding something to docs/system/target-openrsic.rst,
including an example command lines.

>
> The platform provides:
>  - OpenRISC SMP with up to 8 cpus

You have this:

#define VIRT_CPUS_MAX 4

I tried booting with -smp 4 and it locked up when starting userspace
(or I stopped getting serial output?):

[    0.060000] smp: Brought up 1 node, 4 CPUs
...
[    0.960000] Run /init as init process

Running with -smp 2 and 3 worked. It does make booting much much slower.

>  - A virtio bus with up to 8 devices

How do we go about adding a virtio-net-device to this bus?

I tried this:

$ ./qemu-system-or1k -M virt  -nographic -kernel
~/dev/kernels/shenki/or1ksim/vmlinux -initrd
~/dev/buildroot/openrisc/images/rootfs.cpio -device
virtio-net-device,netdev=net0 -netdev user,id=net0

I thought it wasn't working, but I just needed to enable the drivers,
and from there it worked:

CONFIG_VIRTIO_NET=y
CONFIG_VIRTIO_MMIO=y

I also tested the virtio rng device which appeared to work.

# CONFIG_HW_RANDOM is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_VIRTIO=y

>  - Standard ns16550a serial
>  - Goldfish RTC

-device virtio-rng-device,rng=rng0 -object rng-builtin,id=rng0

I enabled the options:

CONFIG_RTC_CLASS=y
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_NVMEM is not set
CONFIG_RTC_DRV_GOLDFISH=y

But it didn't work. It seems the goldfish rtc model doesn't handle a
big endian guest running on my little endian host.

Doing this fixes it:

-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_HOST_ENDIAN,

[    0.190000] goldfish_rtc 96005000.rtc: registered as rtc0
[    0.190000] goldfish_rtc 96005000.rtc: setting system clock to
2022-06-02T11:16:04 UTC (1654168564)

But literally no other model in the tree does this, so I suspect it's
not the right fix.

>  - SiFive TEST device for poweroff and reboot

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_SYSCON=y
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_SYSCON_REBOOT_MODE=y

Adding the syscon/mfd cruft to the kernel adds about 43KB just for
rebooting. I guess that's okay as we're only dealing with a virtual
platform.

>  - Generated RTC to automatically configure the guest kernel

Did you mean device tree?

>
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  configs/devices/or1k-softmmu/default.mak |   1 +
>  hw/openrisc/Kconfig                      |   9 +
>  hw/openrisc/meson.build                  |   1 +
>  hw/openrisc/virt.c                       | 429 +++++++++++++++++++++++
>  4 files changed, 440 insertions(+)
>  create mode 100644 hw/openrisc/virt.c
>
> diff --git a/configs/devices/or1k-softmmu/default.mak b/configs/devices/or1k-softmmu/default.mak
> index 5b3ac89491..f3bf816067 100644
> --- a/configs/devices/or1k-softmmu/default.mak
> +++ b/configs/devices/or1k-softmmu/default.mak
> @@ -5,3 +5,4 @@ CONFIG_SEMIHOSTING=y
>  # Boards:
>  #
>  CONFIG_OR1K_SIM=y
> +CONFIG_OR1K_VIRT=y
> diff --git a/hw/openrisc/Kconfig b/hw/openrisc/Kconfig
> index 8f284f3ba0..202134668e 100644
> --- a/hw/openrisc/Kconfig
> +++ b/hw/openrisc/Kconfig
> @@ -4,3 +4,12 @@ config OR1K_SIM
>      select OPENCORES_ETH
>      select OMPIC
>      select SPLIT_IRQ
> +
> +config OR1K_VIRT
> +    bool
> +    imply VIRTIO_VGA
> +    imply TEST_DEVICES
> +    select GOLDFISH_RTC
> +    select SERIAL
> +    select SIFIVE_TEST
> +    select VIRTIO_MMIO

You could include the liteeth device too if we merged that.

> diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
> new file mode 100644
> index 0000000000..147196fda3
> --- /dev/null
> +++ b/hw/openrisc/virt.c
> @@ -0,0 +1,429 @@
> +/*
> + * OpenRISC QEMU virtual machine.
> + *
> + * Copyright (c) 2022 Stafford Horne <shorne@gmail.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.

I think you can use the SPDX tag here instead of writing out the text.

> +static void openrisc_virt_init(MachineState *machine)
> +{
> +    ram_addr_t ram_size = machine->ram_size;
> +    const char *kernel_filename = machine->kernel_filename;
> +    OpenRISCCPU *cpus[VIRT_CPUS_MAX] = {};
> +    OR1KVirtState *state = VIRT_MACHINE(machine);
> +    MemoryRegion *ram;
> +    hwaddr load_addr;
> +    int n;
> +    unsigned int smp_cpus = machine->smp.cpus;
> +

> +    openrisc_virt_rtc_init(state, virt_memmap[VIRT_RTC].base,
> +                           virt_memmap[VIRT_RTC].size, smp_cpus, cpus,
> +                           VIRT_RTC_IRQ);
> +
> +    for (n = 0; n < VIRTIO_COUNT; n++) {

This would make more sense to me if you constructed the IRQ and base
here, and then passed the actual base and irq number to your
_virtio_init:

        size_t size = virt_memmap[VIRT_VIRTIO].size;
        openrisc_virt_virtio_init(state, virt_memmap[VIRT_VIRTIO].base
+ size * n,
                                  size, smp_cpus, cpus, VIRT_VIRTIO_IRQ + n);


> +        openrisc_virt_virtio_init(state, virt_memmap[VIRT_VIRTIO].base,
> +                                  virt_memmap[VIRT_VIRTIO].size,
> +                                  smp_cpus, cpus, VIRT_VIRTIO_IRQ, n);
> +    }
> +
