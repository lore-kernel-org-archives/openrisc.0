Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909072DB72
	for <linux-openrisc@vger.kernel.org>; Fri, 15 Dec 2023 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="FlTChbz0"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d9d2f2b25aso508195a34.1
        for <linux-openrisc@vger.kernel.org>; Fri, 15 Dec 2023 05:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1702646875; x=1703251675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BwF7xkAVljozsujeW9RiY1dJ8qFRhsc7axNVCA3oauQ=;
        b=FlTChbz0QVCjRjHUbvLONhCQG6+zYKeuQiysn/JqtNYiKZUheSuv1iSe/qKkFVtG4e
         VBr3j0zDdVmqMlKi+nVkM+fAkzmh2iKrwwHd+LubIl4d//Bj3Kgth30SzdsicM7VH+Pf
         2ABYDtsgNRZgp1upwfLkakSsF2qBvDS1DLqRpND4QxOBmFfLY4u84gID+kZ5ijZWxO3D
         /O6zaSBp/9Hs9dt5+21EvtXswrX9Q5MH/Mx+iUdI74WNqAuhVV6o/bItgMpMF9mzkRdQ
         K9/8VOP+BW5w3biXY2u6wx+phAH2yihCEjXZhK0P3RFVpnep2ooHi3/YD7ebBveusp7+
         JpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702646875; x=1703251675;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwF7xkAVljozsujeW9RiY1dJ8qFRhsc7axNVCA3oauQ=;
        b=Yk3I3suGf9t+rAJk+xjeL8cuw5djbtyMHF/9axZRolt8vOUqf0zX2/vX0M6zhN3P4p
         lN4cpDBpurCpYbBqfJP5JnEuz0B4MCB/xNtibr1X6DIGZt1zgsJKs2DagQYCplP7QUWU
         Y+ukdsilQNmNrIEMVV9YubvgBO6rmGdDn+eO1Ew8Vo2ZQ3YZRcodWgTyPkmK6BcPVn2G
         04Dwfyye/9Wkw+64C3zwqrmduaYQ+PcIyh+N4V29Syz8J6poEd47HjYX2Ejxa99or9r0
         pamQG8w65WHcxvTzlDqLysV0C7z1TeVLS6EbRYRBnuVoSsxe7nITzY5GSAXtJejEM6fo
         /nvQ==
X-Gm-Message-State: AOJu0YxjbpAI2sTT5XStK8silfuPxXfnnW28QLrGBgIrwFfWTGMGLqA5
	PpxAnfZS+Xw5BoSmDQjZyybkbCn2YtGn8WBwFho=
X-Google-Smtp-Source: AGHT+IEfLxl76+mI6YyJp++di2to77UnjeUR0KC9PNDC0nctrlMrjleAz6mwWNI9BVNQEy4VJ7vCDw==
X-Received: by 2002:a05:6830:148a:b0:6d9:f64e:ed5 with SMTP id s10-20020a056830148a00b006d9f64e0ed5mr11498533otq.2.1702646875574;
        Fri, 15 Dec 2023 05:27:55 -0800 (PST)
Received: from ?IPV6:2607:fb91:122d:80ad:20a7:99ff:fea6:ce55? ([2607:fb91:122d:80ad:20a7:99ff:fea6:ce55])
        by smtp.gmail.com with ESMTPSA id g19-20020a9d6a13000000b006d99e0667e4sm3617046otn.28.2023.12.15.05.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 05:27:55 -0800 (PST)
Message-ID: <95d45290-4b92-c189-beeb-b7e34dd298d8@landley.net>
Date: Fri, 15 Dec 2023 07:33:42 -0600
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Adding or1k support to mkroot.
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>
Cc: linux-openrisc@vger.kernel.org, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
References: <79b2561e-3167-9758-8196-f2470aec06f7@landley.net>
 <ZXtck05MRrk2e675@antec>
From: Rob Landley <rob@landley.net>
In-Reply-To: <ZXtck05MRrk2e675@antec>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/14/23 13:50, Stafford Horne wrote:
> Hi Rob,
> 
> It's been a while :)

Indeed. I didn't have questions for you in Tokyo, but do now. :)

> On Tue, Dec 12, 2023 at 04:16:15AM -0600, Rob Landley wrote:
>> Toybox has a tiny system builder in it, a ~300 line bash script that builds
>> Linux for a dozen targets (using musl-cross-make toolchains) and boots the
>> result to a shell prompt under QEMU:
>> 
>> https://github.com/landley/toybox/blob/master/mkroot/mkroot.sh
>> https://landley.net/bin/mkroot/latest/
>> 
>> And since musl and qemu both support openrisc (and I need an or1k toolchain
>> anyway for my orange pi 3b's power controller firmware, at least according to
>> u-boot's board/sunxi/README.sunxi64), I thought I'd try to make that target work.
> 
> Great.

I've more or less gotten it to work. The trick was statically linking in the
initramfs image:

  https://github.com/landley/toybox/commit/5647741f6687

I haven't added any of the OPENRISC_HAVE_INST_* symbols because it booted
without them, and presumably the toolchain will automatically do the right thing
for userspace:

  https://landley.net/notes-2023.html#10-12-2023

(I just specify an i486, i586, or i686 toolchain, or tell x86-64
"CFLAGS=-mtune=nocona", and so on. I don't need to micromanage stuff in
menuconfig to build for minor variations of a given target, I have no idea why
openrisc would work differently.)

Nor did I add JUMP_UPON_UNHANDLED_EXCEPTION because I honestly don't know what
that modifies or why you would ever NOT do it if it was at all useful? I err on
the side of fewer symbols when the benefit's not clear...

>> I built an or1k musl+gcc toolchain with my wrapper script around Rich Felker's
>> musl-cross-make project by adding "or1k::" to the TARGETS list in
>> https://github.com/landley/toybox/blob/master/scripts/mcm-buildall.sh#L34 and
>> that seems to have worked-ish. (Well, the kernel headers didn't install because
>> I have to add or1k->openrisc to musl-cross-make's TARGET_ARCH_MANGLED in
>> litecross/Makefile, but eh, close enough for the moment.)

I fixed that too, by the way:

  https://github.com/landley/toybox/commit/ab046139f9d8

>> 1) qemu's -append is ignored, the "Kernel command line: earlycon" is hardwired
>> into the device tree.
>> 
>> 2) Nothing I do seems to get qemu to exit instead of hanging,
>> CONFIG_PANIC_TIMEOUT=1 makes it _try_ to reboot but adding the CONFIG_POWER
>> symbols from arch/openrisc/configs/virt_defconfig doesn't seem to affect qemu,
>> and none of the other targets mention power. (If I can't exit the emulator at
>> the end then https://github.com/landley/toybox/blob/master/mkroot/testroot.sh
>> can't report success for the architecture.)
> 
> I use the virt_defconfig for my testing.

Ok.

>> 3) If I feed qemu-system-or1k an -initrd the same kernel does NOT give me boot
>> messages, it just hangs.
> 
> Maybe earlycon is not working?

Dunno. It's enabled in the resulting full config?

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_OF_PLATFORM=y

The way mkroot works is there's a platform-specific part for each target, and a
part shared by all platforms. In the case of or1k, once I had the toolchain
adding the new platform meant:

  elif [ "$CROSS" == or1k ]; then
    KARCH=openrisc QEMU="or1k -M or1k-sim" KARGS=FIXME VMLINUX=vmlinux BUILTIN=1

KCONF=OPENRISC_BUILTIN_DTB=\"or1ksim\",ETHOC,SERIO,SERIAL_8250,SERIAL_8250_CONSOLE,SERIAL_OF_PLATFORM

The KCONF= is CSV list of config symbols, the CONFIG_ prefix is added and the
ones without an = in them get =y appended, and then the symbols for all boards
get added:

https://github.com/landley/toybox/blob/master/mkroot/mkroot.sh#L275

Which includes EARLY_PRINTK. That expands it into a miniconfig, which is handled
in the usual way:

https://lwn.net/Articles/161086/

The resulting micro, mini, and full configs then wind up in the "docs" directory
of the resulting build. (root/or1k/docs/linux-fullconfig)

> This are my qemu arguments:
> 
> qemu-system-or1k -cpu or1200 -machine virt \
>   -no-reboot -kernel /home/shorne/work/linux/vmlinux \
>   -device virtio-net-pci,netdev=user \
>   -netdev user,id=user,net=10.9.0.1/24,host=10.9.0.100,hostfwd=tcp::2222-:22 \
>   -serial mon:stdio -nographic

If you're putting the monitor on stdio, where does the console go? (Is this
going to pop up a graphics window or something? Or do you talk to it entirely
through the virtual network?)

> -device virtio-blk-device,drive=d0 \
>   -drive file=/home/shorne/work/openrisc/or1k-utils/buildroot/output/qemu-fs-or1k.qcow2,id=d0,if=none,format=qcow2 \
>   -gdb tcp::10001 \
>   -accel tcg,thread=multi \
>   -smp cpus=4 -m 768 \

Do I need to micromanage -accel?

>   -append rootwait \
>   -append boot=/dev/vda2

Did they ever fix qemu's problem that "append" didn't and you could only have
one -append and it in fact completely replaced the existing command line on most
architectures?

https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03214.html

Hmmm, I've got:

qemu-system-or1k -M or1k-sim -m 256 "$@" -nographic -no-reboot -kernel
"$DIR"/linux-kernel -append "HOST=or1k console=FIXME $KARGS"

And it looks like the answer to "how do you enable a halt/reboot switch that can
exit qemu" is "don't use the or1k-sim board, use the virt board".

> With this and the virt kernel and qemu virt machine I am able to shut down the
> machine is setup with poweroff and reboot hardware (syscon-poweroff) from
> SiFive MMIO.
> 
> If I remove the `-drive` argument I do get boot messages.
> 
>> Well, SORT OF. If I feed -initrd 2 megabytes copied from /dev/null by dd, I get
>> boot messages. If I go "true | gz > blah.gz" to create the smallest (20 byte) gz
>> file and feed it that, no boot messages. Feed it System.map: boot messages. Feed
>> it vmlinux: no boot messages.
> 
> I use a root image I created with buildroot.  But you should be able to get boot
> messages before initrd is picked up.  I am not sure why your invalid initrd's
> are able to create boot messages or not.

It provides boot messages without any initrd at all. It eventually panics
because there's no init, but early in board bringup I'm just looking for proof
of life.

> Do you have a valid initrd that maybe I can try out?  I recently use qcow2
> images to build, but I did used to use initrd images and it did work fine.

Sure, just remove the BUILTIN=1 from the if or1k stanza, and... it's 582k, I'll
send it _not_ cc-ing the mailing list. :)

>> Any idea what's going on here? That last one's kind of a blocker...
> 
> Have you tried to debug where it's getting hung up?  Gdb remote debug should
> be working for or1k.

I have not yet tried to rustle up a gdb build that understands or1k machine
code, no. I'm more likely to try to either get EARLY_PRINTK less broken or
dredge up the 2 line spin-to-write-register version of 8250 output and cut and
paste it in various places if I need to debug this myself.

But I was hoping it was a known limitation or at least easily recognized...

> -Stafford

Rob
