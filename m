Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F57697B2
	for <linux-openrisc@vger.kernel.org>; Thu, 14 Dec 2023 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmaNuwnZ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so80898675e9.0
        for <linux-openrisc@vger.kernel.org>; Thu, 14 Dec 2023 11:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702583447; x=1703188247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dDGqsASuRBo+vMQuMLJogMvkiwixBPYDI7s1FZt0vng=;
        b=lmaNuwnZaKGFiYCzQWFRwxNSYKXO6rxo33UpnCrMpHpdZtFy22+aYMog6xYIV7XPI0
         JglMBW2kgai4X+wJhUDFJhQl7TtzFX5RFaAjQFloB9bxKxYMon7q3clgGNC9uj3gzeBV
         7kA+T7yvovuOJyLuj3ZeIk6Tlbvde5yrk6idrRCSfvg4NrtnftOnowgLcNeTMZRRgJXk
         lCsiuMGKXsBSVzv6xiZncGIUEFKlKXucImdY0kmwUxNSX8hc4p7j+sdKdazxZG2Nz7lm
         8VVeFRjDp9R2cDD0ztY56pxRD+cGBWz6fys3etLhLITZJZxJsnCVmakW6q/mmPzFSc/h
         J4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702583447; x=1703188247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDGqsASuRBo+vMQuMLJogMvkiwixBPYDI7s1FZt0vng=;
        b=tDwW9BXOTc2i/dvsklfRaOT/qtm0gK136rsC9f3IGSiySmYS1NSf/3UW96L/dPK7Oz
         FSPoHzpikDUkreiCQPWP+0+sZGakNI4xZf3rLsqq/vg1cPha6XxcOi2EzIAkeK4sEV5V
         YlCix8XG1KqqF3wkGIo/hmki4u6EaISv6MFzsm0hH1zvmo4eHL7ZKMHUyEG8/HHkJlaj
         0XIu84Fryf60UNjwgHtNgKV27VV8GIK4DobFNm/SD8wSS3xL6yQajqC6KZnQR0Io3rEm
         McuRVQTKWfbxdoB2lZJcGOWt91ItLr7mnQzfa7fRO7gX5xHMrsjpLMCN7qRhMkLlARXX
         Dh4g==
X-Gm-Message-State: AOJu0YyHo1I+RmBBh1gdjkdY2x7N/0O7mYH7yCI2ZGVYlWZMbJVY0unP
	bL+LTkZ6bFIrdkGT+aNN/sA=
X-Google-Smtp-Source: AGHT+IFSQxWIqulyrOa5GQmCtkzw+ifBPMDvAKSdMXwB6eBTOPXIrCudpQNDt1VRpCFFyNOvEFhxmA==
X-Received: by 2002:a7b:cb10:0:b0:40c:2787:570e with SMTP id u16-20020a7bcb10000000b0040c2787570emr4237194wmj.168.1702583446749;
        Thu, 14 Dec 2023 11:50:46 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id az27-20020a05600c601b00b0040c34e763ecsm25106268wmb.44.2023.12.14.11.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:50:44 -0800 (PST)
Date: Thu, 14 Dec 2023 19:50:43 +0000
From: Stafford Horne <shorne@gmail.com>
To: Rob Landley <rob@landley.net>
Cc: linux-openrisc@vger.kernel.org, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: Re: Adding or1k support to mkroot.
Message-ID: <ZXtck05MRrk2e675@antec>
References: <79b2561e-3167-9758-8196-f2470aec06f7@landley.net>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79b2561e-3167-9758-8196-f2470aec06f7@landley.net>

Hi Rob,

It's been a while :)

On Tue, Dec 12, 2023 at 04:16:15AM -0600, Rob Landley wrote:
> Toybox has a tiny system builder in it, a ~300 line bash script that builds
> Linux for a dozen targets (using musl-cross-make toolchains) and boots the
> result to a shell prompt under QEMU:
> 
> https://github.com/landley/toybox/blob/master/mkroot/mkroot.sh
> https://landley.net/bin/mkroot/latest/
> 
> And since musl and qemu both support openrisc (and I need an or1k toolchain
> anyway for my orange pi 3b's power controller firmware, at least according to
> u-boot's board/sunxi/README.sunxi64), I thought I'd try to make that target work.

Great.

> I built an or1k musl+gcc toolchain with my wrapper script around Rich Felker's
> musl-cross-make project by adding "or1k::" to the TARGETS list in
> https://github.com/landley/toybox/blob/master/scripts/mcm-buildall.sh#L34 and
> that seems to have worked-ish. (Well, the kernel headers didn't install because
> I have to add or1k->openrisc to musl-cross-make's TARGET_ARCH_MANGLED in
> litecross/Makefile, but eh, close enough for the moment.)
> 
> With the resulting toolchain, I can build an or1ksim_defconfig kernel (using
> v6.6 source) that "qemu-system-or1k -nographic -kernel vmlinux" gives boot
> messages for! Woo! (And then panics because no init, but that's standard for
> board bringup.)
> 
> Some immediately obvious problems are:
> 
> 1) qemu's -append is ignored, the "Kernel command line: earlycon" is hardwired
> into the device tree.
> 
> 2) Nothing I do seems to get qemu to exit instead of hanging,
> CONFIG_PANIC_TIMEOUT=1 makes it _try_ to reboot but adding the CONFIG_POWER
> symbols from arch/openrisc/configs/virt_defconfig doesn't seem to affect qemu,
> and none of the other targets mention power. (If I can't exit the emulator at
> the end then https://github.com/landley/toybox/blob/master/mkroot/testroot.sh
> can't report success for the architecture.)

I use the virt_defconfig for my testing.

> 3) If I feed qemu-system-or1k an -initrd the same kernel does NOT give me boot
> messages, it just hangs.

Maybe earlycon is not working?

This are my qemu arguments:

qemu-system-or1k -cpu or1200 -machine virt \
  -no-reboot -kernel /home/shorne/work/linux/vmlinux \
  -device virtio-net-pci,netdev=user \
  -netdev user,id=user,net=10.9.0.1/24,host=10.9.0.100,hostfwd=tcp::2222-:22 \
  -serial mon:stdio -nographic -device virtio-blk-device,drive=d0 \
  -drive file=/home/shorne/work/openrisc/or1k-utils/buildroot/output/qemu-fs-or1k.qcow2,id=d0,if=none,format=qcow2 \
  -gdb tcp::10001 \
  -accel tcg,thread=multi \
  -smp cpus=4 -m 768 \
  -append rootwait \
  -append boot=/dev/vda2

With this and the virt kernel and qemu virt machine I am able to shut down the
machine is setup with poweroff and reboot hardware (syscon-poweroff) from
SiFive MMIO.

If I remove the `-drive` argument I do get boot messages.

> Well, SORT OF. If I feed -initrd 2 megabytes copied from /dev/null by dd, I get
> boot messages. If I go "true | gz > blah.gz" to create the smallest (20 byte) gz
> file and feed it that, no boot messages. Feed it System.map: boot messages. Feed
> it vmlinux: no boot messages.

I use a root image I created with buildroot.  But you should be able to get boot
messages before initrd is picked up.  I am not sure why your invalid initrd's
are able to create boot messages or not.

Do you have a valid initrd that maybe I can try out?  I recently use qcow2
images to build, but I did used to use initrd images and it did work fine.

> Any idea what's going on here? That last one's kind of a blocker...

Have you tried to debug where it's getting hung up?  Gdb remote debug should
be working for or1k.

-Stafford
