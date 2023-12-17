Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293421FBB
	for <linux-openrisc@vger.kernel.org>; Sun, 17 Dec 2023 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMZC4lw1"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33666fb9318so87595f8f.2
        for <linux-openrisc@vger.kernel.org>; Sun, 17 Dec 2023 01:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702803955; x=1703408755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3caAuK1LKSq6NySgfm+yklvpXuZa7EIMaR0awlizHlI=;
        b=lMZC4lw1hIDGMfWXrPcm05m4XHikfWUG3NC0alVWaOfhHi3pT16TpLRexM43fYKBsa
         qJEJNYXJesmlQngcij2nc82k6XdW+hzF9t1h2+ukscLKrmoL4o6DQO3P6zQfCxy6hV1l
         AFCW3kp2ubQ1rYFSoRvloPX4LVimhHJqrIsKNu8Nxssyit/Xsy3uLtA/p3CAwQwhWDNz
         d8qtKlwG559drXHIBySWj8jBp0Uq5CheKOanvg02fV+mTo6JbEMpEdXHvvLgP+72wV7f
         M7s0l3eKtj6L6WP/9Nv673FALZlz/dQcYqft0EeSq7bjwlsWHD1iEHar6454JZvbR2Lb
         4elQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702803955; x=1703408755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3caAuK1LKSq6NySgfm+yklvpXuZa7EIMaR0awlizHlI=;
        b=lT23vJ1NJJNh6GIvsF5fEZPxyyL/s7wN23n8mVeOmiFJVgGZdRIHlIHLIYD4hemYin
         OCQnpdkugzmNrVsC+l5xRqV/kal8rQOz8tdpUfCjvExY+txW90JOma64/C0JWucJ1SZI
         WNpQ7/0NVxAvaeXiEGH7fv9vL9bldMqPfqT9P0TIDkIN9cBa4fV4YcCPIcqnFJAKVgiT
         ecWxYcxWqw5tiRrS587TKwvo07xB6N7p7EfZOMD5oiAtuC5pYmq6b2O7f0fcJesA45nN
         BehgJkHistHkyVxWsqE4Rd+6FNBQG8sF97xy+0GBwvGhMoBM7CIVM1Z8IMOA70OOEpFK
         lXUw==
X-Gm-Message-State: AOJu0YxdiuuPa6Sp5NLrI8sR4Qy2KKK5jlu7pRfGknvq+4hDusEaGq/3
	vTCpbO9Zs+sny/UOXjrsED0=
X-Google-Smtp-Source: AGHT+IHYQBcl6tnSp8LEmB73iclqce88PWApdEWtONJ6beIiYPzgLxQnFA5UXFUJRDHSDGgZG4r3Pg==
X-Received: by 2002:a5d:6c6e:0:b0:336:66fc:6791 with SMTP id r14-20020a5d6c6e000000b0033666fc6791mr195610wrz.107.1702803954848;
        Sun, 17 Dec 2023 01:05:54 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id j27-20020adfb31b000000b003366779ebe8sm31097wrd.97.2023.12.17.01.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 01:05:53 -0800 (PST)
Date: Sun, 17 Dec 2023 09:05:52 +0000
From: Stafford Horne <shorne@gmail.com>
To: Rob Landley <rob@landley.net>
Cc: linux-openrisc@vger.kernel.org, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: Re: Adding or1k support to mkroot.
Message-ID: <ZX658P7dEgqCezpi@antec>
References: <79b2561e-3167-9758-8196-f2470aec06f7@landley.net>
 <ZXtck05MRrk2e675@antec>
 <95d45290-4b92-c189-beeb-b7e34dd298d8@landley.net>
 <ZX1xbs_AGdgLgcx7@antec>
 <2e1d9f74-88fa-3f5a-7bc3-4fe7b726f2be@landley.net>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e1d9f74-88fa-3f5a-7bc3-4fe7b726f2be@landley.net>

On Sat, Dec 16, 2023 at 07:00:23AM -0600, Rob Landley wrote:
> On 12/16/23 03:44, Stafford Horne wrote:
> > On Fri, Dec 15, 2023 at 07:33:42AM -0600, Rob Landley wrote:
> >> I've more or less gotten it to work. The trick was statically linking in the
> >> initramfs image:
> >> 
> >>   https://github.com/landley/toybox/commit/5647741f6687
> >> 
> >> I haven't added any of the OPENRISC_HAVE_INST_* symbols because it booted
> >> without them, and presumably the toolchain will automatically do the right thing
> >> for userspace:
> >> 
> >>   https://landley.net/notes-2023.html#10-12-2023
> >> 
> >> (I just specify an i486, i586, or i686 toolchain, or tell x86-64
> >> "CFLAGS=-mtune=nocona", and so on. I don't need to micromanage stuff in
> >> menuconfig to build for minor variations of a given target, I have no idea why
> >> openrisc would work differently.)
> >> 
> >> Nor did I add JUMP_UPON_UNHANDLED_EXCEPTION because I honestly don't know what
> >> that modifies or why you would ever NOT do it if it was at all useful? I err on
> >> the side of fewer symbols when the benefit's not clear...
> > 
> > I just use the defaults.
> 
> Because of the way I'm doing it, the "default" for any symbol I don't select is
> switched off. My config lists all the symbols I need that aren't in allnoconfig.
> (Although "need" means a dependency won't switch it on when the other symbol
> gets switched on.)
> 
> Conceptually it's the same as running "make allnoconfig" and then going through
> the list of symbols and switching them on by hand in menuconfig. "This is what's
> enabled in this kernel."

OK.

> > Those instruction specific switches will only be
> > helpful if you really want tune things.  Which may be fun for some people.
> > 
> > The OpenRISC kernel is not yet sophisticated enough to detect and replace,
> > emulate the missing instructions.  So we have these switches.  Some soft CPUs
> > may have these instructions enabled/or disabled and these switches help if you
> > know what you are doing.  Luckily QEMU has all the instruction enabled.
> 
> Isn't that a toolchain issue, though? Your userspace gets built with the same
> toolchain, "we have a multiply instruction" is kind of something it needs to
> know. Which means:
> 
> $ :| or1k-linux-musl-cc -E -dM -
> #define __DBL_MIN_EXP__ (-1021)
> #define __UINT_LEAST16_MAX__ 0xffff
> #define __ATOMIC_ACQUIRE 2
> ...
> #define __UINT_FAST8_TYPE__ unsigned char
> #define __ATOMIC_ACQ_REL 4
> #define __ATOMIC_RELEASE 3
> 
> Can't you have #defines in your toolchain saying what architecture variant it
> supports? And thus the code can #ifdef those without kconfig having to care?

Yes, the toolchain supports these, the kernel switches enable the toolchain
flags when building the kernel (mostly).  For example:

$ or1k-elf-gcc --target-help
The following options are target specific:
...
  -mcmov                      Enable generation of conditional move (l.cmov)
                              instructions.  By default the equivalent will
                              be generated using set and branch.
..
  -mhard-div                  Enable generation of hardware divide (l.div,
                              l.divu) instructions.  This is the default; use
                              -msoft-div to override.
  -mhard-mul                  Enable generation of hardware multiply
                              instructions (l.mul, l.muli) instructions. This
                              is the default; use -msoft-mul to override.
..

The exception is where we use these flags to enable bitops. In:

 arch/openrisc/include/asm/bitops/ffs.h
 arch/openrisc/include/asm/bitops/fls.h

Like other architectures the or1k toolchain doesn't expose which architecture is
being built. While architectures such as m68k define tunes and export i.e.
__mcfisaa__ to infer which instructions are enabled.

OpenRISC has no such architectures as within a softcpu architecture instructions
can be enabled or disabled as required.  I know, its a bit crazy.

However, you should be safe disabling everything.

> > In terms of JUMP_UPON_UNHANDLED_EXCEPTION, this was added before my time.  We
> > probably could get rid of it and do a more graceful power based halt.
> 
> I'm still not 100% clear on what it does, even after reading the help text. :)

This set's up an infinite loop on panic, rather than performing the default
kernel operation.

> >> >> I built an or1k musl+gcc toolchain with my wrapper script around Rich Felker's
> >> >> musl-cross-make project by adding "or1k::" to the TARGETS list in
> >> >> https://github.com/landley/toybox/blob/master/scripts/mcm-buildall.sh#L34 and
> >> >> that seems to have worked-ish. (Well, the kernel headers didn't install because
> >> >> I have to add or1k->openrisc to musl-cross-make's TARGET_ARCH_MANGLED in
> >> >> litecross/Makefile, but eh, close enough for the moment.)
> >> 
> >> I fixed that too, by the way:
> >> 
> >>   https://github.com/landley/toybox/commit/ab046139f9d8
> > 
> > OK.
> 
> Some glorious day Rich might apply the backlog of patches I've sent him to
> musl-cross-make (which last updated April 2022). Or I might scrape up the spoons
> to write a new linux-from-scratch style toolchain builder script so my
> mcm-buildall.sh isn't a wrapper around an external project. It's a toss-up which
> happens first...
> 
> (Mostly when I have spare toolchain brain I wrestle with llvm stuff instead...)
> 
> >> > This are my qemu arguments:
> >> > 
> >> > qemu-system-or1k -cpu or1200 -machine virt \
> >> >   -no-reboot -kernel /home/shorne/work/linux/vmlinux \
> >> >   -device virtio-net-pci,netdev=user \
> >> >   -netdev user,id=user,net=10.9.0.1/24,host=10.9.0.100,hostfwd=tcp::2222-:22 \
> >> >   -serial mon:stdio -nographic
> >> 
> >> If you're putting the monitor on stdio, where does the console go? (Is this
> >> going to pop up a graphics window or something? Or do you talk to it entirely
> >> through the virtual network?)
> > 
> > Console goes to stdio, I use ctrl-a C to drop into monitor which is also in
> > stdio.
> 
> Huh, I didn't know that was an option.

There are soo many options in QEMU.

> >> > -device virtio-blk-device,drive=d0 \
> >> >   -drive file=/home/shorne/work/openrisc/or1k-utils/buildroot/output/qemu-fs-or1k.qcow2,id=d0,if=none,format=qcow2 \
> >> >   -gdb tcp::10001 \
> >> >   -accel tcg,thread=multi \
> >> >   -smp cpus=4 -m 768 \
> >> 
> >> Do I need to micromanage -accel?
> > 
> > Probably not for your use cases.  I can not recall the defaults but I think it
> > was not multi threaded.  But I cannot be sure unless I go look.  You probably
> > can run with a single core and no SMP.
> 
> What I did years ago was set up distcc so qemu called out to the cross compiler
> running on loopback through the 10.0.2.2 emulated interface, thus moving the
> heavy lifting of compilation outside the emulator to where CPU was cheap without
> reintroducing all the problems of cross compiling (two compilers to keep
> straight, two sets of headers and two sets of libraries leaking into each other,
> can't run the binaries you generate, configure keeps asking questions about the
> host and applying the results to the target...)
> 
> It still maxed out around -j 3 because of the preprocessing, linking, network
> transfer, and make figuring out what to do next, but was way better than purely
> native single CPU builds.
> 
> No clue what the sweet spot is at today...
> 
> >> >   -append rootwait \
> >> >   -append boot=/dev/vda2
> >> 
> >> Did they ever fix qemu's problem that "append" didn't and you could only have
> >> one -append and it in fact completely replaced the existing command line on most
> >> architectures?
> >> 
> >> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03214.html
> > 
> > After I sent this message I noticed this looked strange.  It doesn't work, so my
> > command line ends up being: 'boot=/dev/vda2'.  Which was enough to get it to
> > work.
> 
> It's a misleading name.
> 
> >> Hmmm, I've got:
> >> 
> >> qemu-system-or1k -M or1k-sim -m 256 "$@" -nographic -no-reboot -kernel
> >> "$DIR"/linux-kernel -append "HOST=or1k console=FIXME $KARGS"
> >> 
> >> And it looks like the answer to "how do you enable a halt/reboot switch that can
> >> exit qemu" is "don't use the or1k-sim board, use the virt board".
> > 
> > Yeah, virt board is the only one that supports halt/reboot.  The 'or1ksim'
> > platform that we used as the model of qemu 'or1k-sim' supported reboot and halt
> > via special 'nop' instructions.  The QEMU maintainers did not feel these special
> > nop instructions should be supported in QEMU.
> 
> Sigh. Ok, I'll start the process over digesting the other config and trying to
> get that one to work instead...
> 
> >> It provides boot messages without any initrd at all. It eventually panics
> >> because there's no init, but early in board bringup I'm just looking for proof
> >> of life.
> >> 
> >> > Do you have a valid initrd that maybe I can try out?  I recently use qcow2
> >> > images to build, but I did used to use initrd images and it did work fine.
> >> 
> >> Sure, just remove the BUILTIN=1 from the if or1k stanza, and... it's 582k, I'll
> >> send it _not_ cc-ing the mailing list. :)
> > 
> > OK, I will try this out. But sorry busy this weekend I will probably not get
> > time.
> 
> No rush, I think you've answered my question above. It would be nice to get the
> bug fixed, but unless I can -device,poweroff or similar on the qemu command line
> to insert whatever it's poking to halt (and then tell the kernel about it), the
> sim board isn't useful to me for automation.

I tried to boot your initramfs with my virt_defconfig kernel, I just exchanged
driver for -initrd.  It seems to work, but panics with the following:

[    0.260000] 90000000.serial: ttyS0 at MMIO 0x90000000 (irq = 2, base_baud = 1250000) is a 16550A
[    0.270000] printk: console [ttyS0] enabled
..
[    0.420000] usbhid: USB HID core driver
[    0.420000] NET: Registered PF_PACKET protocol family
[    0.490000] clk: Disabling unused clocks
[    0.490000] ALSA device list:
[    0.490000]   No soundcards found.
[    0.520000] Freeing unused kernel image (initmem) memory: 232K
[    0.520000] This architecture does not have kernel memory protection.
[    0.520000] Run /init as init process
Type exit when done.
oneit: /dev/ttyS0ttyS0: No such file or directory
[    0.780000] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000100
[    0.780000] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000100 ]---

I am not sure about /dev/ttyS0ttyS0.

-Stafford

> >> >> Any idea what's going on here? That last one's kind of a blocker...
> >> > 
> >> > Have you tried to debug where it's getting hung up?  Gdb remote debug should
> >> > be working for or1k.
> >> 
> >> I have not yet tried to rustle up a gdb build that understands or1k machine
> >> code, no. I'm more likely to try to either get EARLY_PRINTK less broken or
> >> dredge up the 2 line spin-to-write-register version of 8250 output and cut and
> >> paste it in various places if I need to debug this myself.
> > 
> > That's OK, I usually use the console too to help debug too.
> 
> If I can reproduce it and stick a printf in it, I can generally debug it.
> 
> >> But I was hoping it was a known limitation or at least easily recognized...
> > 
> > OK, are things working for you now?  Or is the problem that the initrd still
> > does not work?
> 
> I can use initrd built-in to the kernel. I cannot supply it externally via
> qemu's -initrd. Which means I need to rebuild the kernel (7 minute clean
> rebuild) to tweak the filesystem (30 second clean rebuild).
> 
> That said, if I can supply an external -initrd to the virt board, then it works
> like the other targets. (It's a matter of workflow, I'm trying to regression
> test stuff against as many architectures as I can, which means I want them to
> work the same.)
> 
> One script I have doing this is my smoketest script at
> https://github.com/landley/toybox/blob/master/mkroot/testroot.sh which runs all
> the targets under qemu and makes sure they can get their clocks set (via ntp if
> necessary) and access a block device and do basic networking.
> 
> Eventually I want to get that running the toybox test suite inside qemu on each
> architecture, but that's still a ways off. (The shell isn't capable enough yet,
> working on it...)
> 
> I also want to get an automated Linux From Scratch build to compile and run on
> each target. I did that before with aboriginal linux years ago, but that was
> making busybox into a development environment. (Other projects like Alpine Linux
> and Adelie Linux took over from there when I stopped.) Now I'm trying to do it
> again with toybox, with the extra difficulty that I can't use any existing GPL
> code for anything because toybox is under a public domain equivalent license
> (Zero Clause BSD).
> 
> (Yes, this would mean building Linux From Scratch on or1k, under qemu. That's
> why I need I need a board with a working block device and at least 256 megs of
> ram, although I can use a network block device and a swap file in a pinch on
> systems with an MMU. I would someday LIKE to do a from-source debootstrap and
> populate a musl-backed package repository via automated cluster build, but
> there's still a certain amount of undocumented black magic in getting that to
> work. The old "people who know have known so long they've forgotten how to
> explain it" problem...)
> 
> > -Stafford
> 
> Rob
