Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C269513AEF
	for <linux-openrisc@vger.kernel.org>; Sat, 16 Dec 2023 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE1XclPo"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c60dfa5bfso17210155e9.0
        for <linux-openrisc@vger.kernel.org>; Sat, 16 Dec 2023 01:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702719858; x=1703324658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EEScn0vwQjz3qZK7zgMe2MXufwMyheSXbVKQIMzLFaQ=;
        b=fE1XclPouk7a+DLgauoZy9nFltXs5EATzOca+C+l0va/tFNjAOUSt+kg2HvCeT2Psz
         0u8s4st6eWADKbBZffy7sEm8vVeFIZFPsig6cT5u5KNPhvI01EYlhiGyNMp5DMWWhv5a
         G3EQOZ2Mj1sm9ivsubBSgPyjkLmebDzZ66j3LnjHdlbx/NxoqC6KeKq8PlpgO8aNUBgv
         xYMoPkQGEGcbq0HCnQRVchpE5Y5o1GTM8OX49IZONJbvXQwLnvo6ECFeayBFboUiGuwZ
         e+6R5alxa4nOpo1Os/8JvnrTO1iGtbEZ1So5ql3Bq/P1QvGj23XByfYXVd9KsxrTPDuO
         ebog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702719858; x=1703324658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEScn0vwQjz3qZK7zgMe2MXufwMyheSXbVKQIMzLFaQ=;
        b=Ko0MwN6qe7H94sGYRZcpHRcDHEStL/l1GA9wmdbdnR3EhN5gddHr+UyrHCiA11OMIH
         v4N2TpzUK6KrYbAiBOAKxsaJGgMsNWNpH2nu2beLMjsbFq8OBUXF8eW3b29ObjZxiEpt
         qqBt6vGvEdEzUTLv+jAoYMGXCAIwZGu7C2fs6E9upq9w8lrW47CeltwvcFp8TF0hTkF9
         pFJQHdVfj+a22V3DQQ+JVjWAsZj8yUrIhswUYKyXznyvp2aS6/FlFDgQC5TU/7hkvlGk
         hiWR9wgIcz3ZHhImW5m5KHWlgReK1kaXT7vKCqCZxj5PdQ7qGNJJfsTjFKYmyaGnQrPk
         Fw2g==
X-Gm-Message-State: AOJu0Ywk7qx8DIgX1HYwNDuqou6OeLVMPhdWnoetKZsFFVhswnpRRjKF
	gEkC7Kd9in38VzbB7HkNo5o=
X-Google-Smtp-Source: AGHT+IGJFESueiZAH6+YYAxd+1v2lFpfcN3rFJ2+IyEHoXp6UcGcuFZfhhao2zO8ZMwUiRz/NUXSEQ==
X-Received: by 2002:a05:600c:444f:b0:40c:2411:80 with SMTP id v15-20020a05600c444f00b0040c24110080mr6985402wmn.121.1702719857491;
        Sat, 16 Dec 2023 01:44:17 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00405c7591b09sm32781049wmo.35.2023.12.16.01.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 01:44:15 -0800 (PST)
Date: Sat, 16 Dec 2023 09:44:14 +0000
From: Stafford Horne <shorne@gmail.com>
To: Rob Landley <rob@landley.net>
Cc: linux-openrisc@vger.kernel.org, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: Re: Adding or1k support to mkroot.
Message-ID: <ZX1xbs_AGdgLgcx7@antec>
References: <79b2561e-3167-9758-8196-f2470aec06f7@landley.net>
 <ZXtck05MRrk2e675@antec>
 <95d45290-4b92-c189-beeb-b7e34dd298d8@landley.net>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95d45290-4b92-c189-beeb-b7e34dd298d8@landley.net>

On Fri, Dec 15, 2023 at 07:33:42AM -0600, Rob Landley wrote:
> On 12/14/23 13:50, Stafford Horne wrote:
> > Hi Rob,
> > 
> > It's been a while :)
> 
> Indeed. I didn't have questions for you in Tokyo, but do now. :)
> 
> > On Tue, Dec 12, 2023 at 04:16:15AM -0600, Rob Landley wrote:
> >> Toybox has a tiny system builder in it, a ~300 line bash script that builds
> >> Linux for a dozen targets (using musl-cross-make toolchains) and boots the
> >> result to a shell prompt under QEMU:
> >> 
> >> https://github.com/landley/toybox/blob/master/mkroot/mkroot.sh
> >> https://landley.net/bin/mkroot/latest/
> >> 
> >> And since musl and qemu both support openrisc (and I need an or1k toolchain
> >> anyway for my orange pi 3b's power controller firmware, at least according to
> >> u-boot's board/sunxi/README.sunxi64), I thought I'd try to make that target work.
> > 
> > Great.
> 
> I've more or less gotten it to work. The trick was statically linking in the
> initramfs image:
> 
>   https://github.com/landley/toybox/commit/5647741f6687
> 
> I haven't added any of the OPENRISC_HAVE_INST_* symbols because it booted
> without them, and presumably the toolchain will automatically do the right thing
> for userspace:
> 
>   https://landley.net/notes-2023.html#10-12-2023
> 
> (I just specify an i486, i586, or i686 toolchain, or tell x86-64
> "CFLAGS=-mtune=nocona", and so on. I don't need to micromanage stuff in
> menuconfig to build for minor variations of a given target, I have no idea why
> openrisc would work differently.)
> 
> Nor did I add JUMP_UPON_UNHANDLED_EXCEPTION because I honestly don't know what
> that modifies or why you would ever NOT do it if it was at all useful? I err on
> the side of fewer symbols when the benefit's not clear...

I just use the defaults.  Those instruction specific switches will only be
helpful if you really want tune things.  Which may be fun for some people.

The OpenRISC kernel is not yet sophisticated enough to detect and replace,
emulate the missing instructions.  So we have these switches.  Some soft CPUs
may have these instructions enabled/or disabled and these switches help if you
know what you are doing.  Luckily QEMU has all the instruction enabled.

In terms of JUMP_UPON_UNHANDLED_EXCEPTION, this was added before my time.  We
probably could get rid of it and do a more graceful power based halt.

> >> I built an or1k musl+gcc toolchain with my wrapper script around Rich Felker's
> >> musl-cross-make project by adding "or1k::" to the TARGETS list in
> >> https://github.com/landley/toybox/blob/master/scripts/mcm-buildall.sh#L34 and
> >> that seems to have worked-ish. (Well, the kernel headers didn't install because
> >> I have to add or1k->openrisc to musl-cross-make's TARGET_ARCH_MANGLED in
> >> litecross/Makefile, but eh, close enough for the moment.)
> 
> I fixed that too, by the way:
> 
>   https://github.com/landley/toybox/commit/ab046139f9d8

OK.

 
> >> 1) qemu's -append is ignored, the "Kernel command line: earlycon" is hardwired
> >> into the device tree.
> >> 
> >> 2) Nothing I do seems to get qemu to exit instead of hanging,
> >> CONFIG_PANIC_TIMEOUT=1 makes it _try_ to reboot but adding the CONFIG_POWER
> >> symbols from arch/openrisc/configs/virt_defconfig doesn't seem to affect qemu,
> >> and none of the other targets mention power. (If I can't exit the emulator at
> >> the end then https://github.com/landley/toybox/blob/master/mkroot/testroot.sh
> >> can't report success for the architecture.)
> > 
> > I use the virt_defconfig for my testing.
> 
> Ok.
> 
> >> 3) If I feed qemu-system-or1k an -initrd the same kernel does NOT give me boot
> >> messages, it just hangs.
> > 
> > Maybe earlycon is not working?
> 
> Dunno. It's enabled in the resulting full config?
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> # CONFIG_SERIAL_8250_DW is not set
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_OF_PLATFORM=y
> 
> The way mkroot works is there's a platform-specific part for each target, and a
> part shared by all platforms. In the case of or1k, once I had the toolchain
> adding the new platform meant:
> 
>   elif [ "$CROSS" == or1k ]; then
>     KARCH=openrisc QEMU="or1k -M or1k-sim" KARGS=FIXME VMLINUX=vmlinux BUILTIN=1
> 
> KCONF=OPENRISC_BUILTIN_DTB=\"or1ksim\",ETHOC,SERIO,SERIAL_8250,SERIAL_8250_CONSOLE,SERIAL_OF_PLATFORM
> 
> The KCONF= is CSV list of config symbols, the CONFIG_ prefix is added and the
> ones without an = in them get =y appended, and then the symbols for all boards
> get added:
> 
> https://github.com/landley/toybox/blob/master/mkroot/mkroot.sh#L275
> 
> Which includes EARLY_PRINTK. That expands it into a miniconfig, which is handled
> in the usual way:
> 
> https://lwn.net/Articles/161086/
> 
> The resulting micro, mini, and full configs then wind up in the "docs" directory
> of the resulting build. (root/or1k/docs/linux-fullconfig)

OK.

> > This are my qemu arguments:
> > 
> > qemu-system-or1k -cpu or1200 -machine virt \
> >   -no-reboot -kernel /home/shorne/work/linux/vmlinux \
> >   -device virtio-net-pci,netdev=user \
> >   -netdev user,id=user,net=10.9.0.1/24,host=10.9.0.100,hostfwd=tcp::2222-:22 \
> >   -serial mon:stdio -nographic
> 
> If you're putting the monitor on stdio, where does the console go? (Is this
> going to pop up a graphics window or something? Or do you talk to it entirely
> through the virtual network?)

Console goes to stdio, I use ctrl-a C to drop into monitor which is also in
stdio.

> > -device virtio-blk-device,drive=d0 \
> >   -drive file=/home/shorne/work/openrisc/or1k-utils/buildroot/output/qemu-fs-or1k.qcow2,id=d0,if=none,format=qcow2 \
> >   -gdb tcp::10001 \
> >   -accel tcg,thread=multi \
> >   -smp cpus=4 -m 768 \
> 
> Do I need to micromanage -accel?

Probably not for your use cases.  I can not recall the defaults but I think it
was not multi threaded.  But I cannot be sure unless I go look.  You probably
can run with a single core and no SMP.

> >   -append rootwait \
> >   -append boot=/dev/vda2
> 
> Did they ever fix qemu's problem that "append" didn't and you could only have
> one -append and it in fact completely replaced the existing command line on most
> architectures?
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03214.html

After I sent this message I noticed this looked strange.  It doesn't work, so my
command line ends up being: 'boot=/dev/vda2'.  Which was enough to get it to
work.

> Hmmm, I've got:
> 
> qemu-system-or1k -M or1k-sim -m 256 "$@" -nographic -no-reboot -kernel
> "$DIR"/linux-kernel -append "HOST=or1k console=FIXME $KARGS"
> 
> And it looks like the answer to "how do you enable a halt/reboot switch that can
> exit qemu" is "don't use the or1k-sim board, use the virt board".

Yeah, virt board is the only one that supports halt/reboot.  The 'or1ksim'
platform that we used as the model of qemu 'or1k-sim' supported reboot and halt
via special 'nop' instructions.  The QEMU maintainers did not feel these special
nop instructions should be supported in QEMU.

You could see this in the kernel with:

arch/openrisc/kernel/process:

    /*
     * This is used if pm_power_off has not been set by a power management
     * driver, in this case we can assume we are on a simulator.  On
     * OpenRISC simulators l.nop 1 will trigger the simulator exit.
     */
    static void default_power_off(void)
    {
	    __asm__("l.nop 1");
    }

> > With this and the virt kernel and qemu virt machine I am able to shut down the
> > machine is setup with poweroff and reboot hardware (syscon-poweroff) from
> > SiFive MMIO.
> > 
> > If I remove the `-drive` argument I do get boot messages.
> > 
> >> Well, SORT OF. If I feed -initrd 2 megabytes copied from /dev/null by dd, I get
> >> boot messages. If I go "true | gz > blah.gz" to create the smallest (20 byte) gz
> >> file and feed it that, no boot messages. Feed it System.map: boot messages. Feed
> >> it vmlinux: no boot messages.
> > 
> > I use a root image I created with buildroot.  But you should be able to get boot
> > messages before initrd is picked up.  I am not sure why your invalid initrd's
> > are able to create boot messages or not.
> 
> It provides boot messages without any initrd at all. It eventually panics
> because there's no init, but early in board bringup I'm just looking for proof
> of life.
> 
> > Do you have a valid initrd that maybe I can try out?  I recently use qcow2
> > images to build, but I did used to use initrd images and it did work fine.
> 
> Sure, just remove the BUILTIN=1 from the if or1k stanza, and... it's 582k, I'll
> send it _not_ cc-ing the mailing list. :)

OK, I will try this out. But sorry busy this weekend I will probably not get
time.

> >> Any idea what's going on here? That last one's kind of a blocker...
> > 
> > Have you tried to debug where it's getting hung up?  Gdb remote debug should
> > be working for or1k.
> 
> I have not yet tried to rustle up a gdb build that understands or1k machine
> code, no. I'm more likely to try to either get EARLY_PRINTK less broken or
> dredge up the 2 line spin-to-write-register version of 8250 output and cut and
> paste it in various places if I need to debug this myself.

That's OK, I usually use the console too to help debug too.

> But I was hoping it was a known limitation or at least easily recognized...

OK, are things working for you now?  Or is the problem that the initrd still
does not work?

-Stafford
