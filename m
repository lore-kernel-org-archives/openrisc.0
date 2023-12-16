Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4ADDB9
	for <linux-openrisc@vger.kernel.org>; Sat, 16 Dec 2023 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="xeU36izN"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6d9dadc3dc0so1366613a34.1
        for <linux-openrisc@vger.kernel.org>; Sat, 16 Dec 2023 04:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1702731274; x=1703336074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKqWK+VTkbmLdjQ2SMb8CH8oHIGFKfRa4B+cxixmKQE=;
        b=xeU36izNumQ7k+uVPXXWz81BQXAgF0mh8rUm/cVhQndvvInD7t3X8UW4LCXstEMR4M
         hMHOAodZgvNv5xhZLLL8823U1PWzjctYgt8luzhtNxv4gcDatfyDTLeNoKpI1PLXlfs4
         XWUH8OxrZNY3TyWMO8082mcS3QcCU/7439dEiuF70tyEIxp0ifMqLpthpx9ofour0kiW
         4ZpUd58qKn7htSMsb4n4h/gyyTQt7lO0P6bsYJOqGalmwrL9pZutOA3Kver+9O9Ou4tL
         QJMDhCJuVHwPphaCn2zd4Uvp9dLvkE3RCzrNOQpRDJcoIRr1bO9F//Ehtomy56YKWsvY
         j8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702731274; x=1703336074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKqWK+VTkbmLdjQ2SMb8CH8oHIGFKfRa4B+cxixmKQE=;
        b=rJtggmveevfjkGXG8Ii9X2vf4d0XQVDwitx1gUQXCj1OJr6I7MP8W9R3ZjAFofWGEY
         5Zl8hapj8Y/zLiLV8y9N2vNE8RHkCGoj2qt6yCx8RItln+wS1kIcm5S87GkeHkJpSzvr
         XTFzrRxtzFShQZ/Ab180zRWEHasgsLXclgOcjcZ3A1j5PEwi8Sl4imSgKzmjKjcWqnUq
         MKatTfMvTfPIBkUVgyCC2IJc+oeDiLQVkm2ux02sUMGTH7bfObCC7JWicnJEID1FgV/q
         9MgPpDsGfnitZbQ0svTGLwqarjBE/qZHT6YVxb0MHvIwTjLA6VG60sbmYlvjqC7IA3HZ
         uM2A==
X-Gm-Message-State: AOJu0Yx7TW2hC7DyFEznOAkGfr32CrGVEYhR/W4lOmAtM4hijDZr4ICr
	4AWPQaqpHtys9UUQeM6Yrx0YbQ==
X-Google-Smtp-Source: AGHT+IHA5fB3ALRsPFN8zm4TetL4Z3YQ8go9djEu9BV0oIUdwFkSSZM4YdHSeCph1NWVLf5G6hYFng==
X-Received: by 2002:a9d:6d85:0:b0:6d8:74e2:7cd9 with SMTP id x5-20020a9d6d85000000b006d874e27cd9mr14254689otp.52.1702731274390;
        Sat, 16 Dec 2023 04:54:34 -0800 (PST)
Received: from ?IPV6:2607:fb91:1226:cee7:9cc5:e5ff:feb0:c341? ([2607:fb91:1226:cee7:9cc5:e5ff:feb0:c341])
        by smtp.gmail.com with ESMTPSA id r2-20020a056830120200b006b9848f8aa7sm4065496otp.45.2023.12.16.04.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 04:54:34 -0800 (PST)
Message-ID: <2e1d9f74-88fa-3f5a-7bc3-4fe7b726f2be@landley.net>
Date: Sat, 16 Dec 2023 07:00:23 -0600
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
 <ZXtck05MRrk2e675@antec> <95d45290-4b92-c189-beeb-b7e34dd298d8@landley.net>
 <ZX1xbs_AGdgLgcx7@antec>
From: Rob Landley <rob@landley.net>
In-Reply-To: <ZX1xbs_AGdgLgcx7@antec>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/23 03:44, Stafford Horne wrote:
> On Fri, Dec 15, 2023 at 07:33:42AM -0600, Rob Landley wrote:
>> I've more or less gotten it to work. The trick was statically linking in the
>> initramfs image:
>> 
>>   https://github.com/landley/toybox/commit/5647741f6687
>> 
>> I haven't added any of the OPENRISC_HAVE_INST_* symbols because it booted
>> without them, and presumably the toolchain will automatically do the right thing
>> for userspace:
>> 
>>   https://landley.net/notes-2023.html#10-12-2023
>> 
>> (I just specify an i486, i586, or i686 toolchain, or tell x86-64
>> "CFLAGS=-mtune=nocona", and so on. I don't need to micromanage stuff in
>> menuconfig to build for minor variations of a given target, I have no idea why
>> openrisc would work differently.)
>> 
>> Nor did I add JUMP_UPON_UNHANDLED_EXCEPTION because I honestly don't know what
>> that modifies or why you would ever NOT do it if it was at all useful? I err on
>> the side of fewer symbols when the benefit's not clear...
> 
> I just use the defaults.

Because of the way I'm doing it, the "default" for any symbol I don't select is
switched off. My config lists all the symbols I need that aren't in allnoconfig.
(Although "need" means a dependency won't switch it on when the other symbol
gets switched on.)

Conceptually it's the same as running "make allnoconfig" and then going through
the list of symbols and switching them on by hand in menuconfig. "This is what's
enabled in this kernel."

> Those instruction specific switches will only be
> helpful if you really want tune things.  Which may be fun for some people.
> 
> The OpenRISC kernel is not yet sophisticated enough to detect and replace,
> emulate the missing instructions.  So we have these switches.  Some soft CPUs
> may have these instructions enabled/or disabled and these switches help if you
> know what you are doing.  Luckily QEMU has all the instruction enabled.

Isn't that a toolchain issue, though? Your userspace gets built with the same
toolchain, "we have a multiply instruction" is kind of something it needs to
know. Which means:

$ :| or1k-linux-musl-cc -E -dM -
#define __DBL_MIN_EXP__ (-1021)
#define __UINT_LEAST16_MAX__ 0xffff
#define __ATOMIC_ACQUIRE 2
...
#define __UINT_FAST8_TYPE__ unsigned char
#define __ATOMIC_ACQ_REL 4
#define __ATOMIC_RELEASE 3

Can't you have #defines in your toolchain saying what architecture variant it
supports? And thus the code can #ifdef those without kconfig having to care?

> In terms of JUMP_UPON_UNHANDLED_EXCEPTION, this was added before my time.  We
> probably could get rid of it and do a more graceful power based halt.

I'm still not 100% clear on what it does, even after reading the help text. :)

>> >> I built an or1k musl+gcc toolchain with my wrapper script around Rich Felker's
>> >> musl-cross-make project by adding "or1k::" to the TARGETS list in
>> >> https://github.com/landley/toybox/blob/master/scripts/mcm-buildall.sh#L34 and
>> >> that seems to have worked-ish. (Well, the kernel headers didn't install because
>> >> I have to add or1k->openrisc to musl-cross-make's TARGET_ARCH_MANGLED in
>> >> litecross/Makefile, but eh, close enough for the moment.)
>> 
>> I fixed that too, by the way:
>> 
>>   https://github.com/landley/toybox/commit/ab046139f9d8
> 
> OK.

Some glorious day Rich might apply the backlog of patches I've sent him to
musl-cross-make (which last updated April 2022). Or I might scrape up the spoons
to write a new linux-from-scratch style toolchain builder script so my
mcm-buildall.sh isn't a wrapper around an external project. It's a toss-up which
happens first...

(Mostly when I have spare toolchain brain I wrestle with llvm stuff instead...)

>> > This are my qemu arguments:
>> > 
>> > qemu-system-or1k -cpu or1200 -machine virt \
>> >   -no-reboot -kernel /home/shorne/work/linux/vmlinux \
>> >   -device virtio-net-pci,netdev=user \
>> >   -netdev user,id=user,net=10.9.0.1/24,host=10.9.0.100,hostfwd=tcp::2222-:22 \
>> >   -serial mon:stdio -nographic
>> 
>> If you're putting the monitor on stdio, where does the console go? (Is this
>> going to pop up a graphics window or something? Or do you talk to it entirely
>> through the virtual network?)
> 
> Console goes to stdio, I use ctrl-a C to drop into monitor which is also in
> stdio.

Huh, I didn't know that was an option.

>> > -device virtio-blk-device,drive=d0 \
>> >   -drive file=/home/shorne/work/openrisc/or1k-utils/buildroot/output/qemu-fs-or1k.qcow2,id=d0,if=none,format=qcow2 \
>> >   -gdb tcp::10001 \
>> >   -accel tcg,thread=multi \
>> >   -smp cpus=4 -m 768 \
>> 
>> Do I need to micromanage -accel?
> 
> Probably not for your use cases.  I can not recall the defaults but I think it
> was not multi threaded.  But I cannot be sure unless I go look.  You probably
> can run with a single core and no SMP.

What I did years ago was set up distcc so qemu called out to the cross compiler
running on loopback through the 10.0.2.2 emulated interface, thus moving the
heavy lifting of compilation outside the emulator to where CPU was cheap without
reintroducing all the problems of cross compiling (two compilers to keep
straight, two sets of headers and two sets of libraries leaking into each other,
can't run the binaries you generate, configure keeps asking questions about the
host and applying the results to the target...)

It still maxed out around -j 3 because of the preprocessing, linking, network
transfer, and make figuring out what to do next, but was way better than purely
native single CPU builds.

No clue what the sweet spot is at today...

>> >   -append rootwait \
>> >   -append boot=/dev/vda2
>> 
>> Did they ever fix qemu's problem that "append" didn't and you could only have
>> one -append and it in fact completely replaced the existing command line on most
>> architectures?
>> 
>> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03214.html
> 
> After I sent this message I noticed this looked strange.  It doesn't work, so my
> command line ends up being: 'boot=/dev/vda2'.  Which was enough to get it to
> work.

It's a misleading name.

>> Hmmm, I've got:
>> 
>> qemu-system-or1k -M or1k-sim -m 256 "$@" -nographic -no-reboot -kernel
>> "$DIR"/linux-kernel -append "HOST=or1k console=FIXME $KARGS"
>> 
>> And it looks like the answer to "how do you enable a halt/reboot switch that can
>> exit qemu" is "don't use the or1k-sim board, use the virt board".
> 
> Yeah, virt board is the only one that supports halt/reboot.  The 'or1ksim'
> platform that we used as the model of qemu 'or1k-sim' supported reboot and halt
> via special 'nop' instructions.  The QEMU maintainers did not feel these special
> nop instructions should be supported in QEMU.

Sigh. Ok, I'll start the process over digesting the other config and trying to
get that one to work instead...

>> It provides boot messages without any initrd at all. It eventually panics
>> because there's no init, but early in board bringup I'm just looking for proof
>> of life.
>> 
>> > Do you have a valid initrd that maybe I can try out?  I recently use qcow2
>> > images to build, but I did used to use initrd images and it did work fine.
>> 
>> Sure, just remove the BUILTIN=1 from the if or1k stanza, and... it's 582k, I'll
>> send it _not_ cc-ing the mailing list. :)
> 
> OK, I will try this out. But sorry busy this weekend I will probably not get
> time.

No rush, I think you've answered my question above. It would be nice to get the
bug fixed, but unless I can -device,poweroff or similar on the qemu command line
to insert whatever it's poking to halt (and then tell the kernel about it), the
sim board isn't useful to me for automation.

>> >> Any idea what's going on here? That last one's kind of a blocker...
>> > 
>> > Have you tried to debug where it's getting hung up?  Gdb remote debug should
>> > be working for or1k.
>> 
>> I have not yet tried to rustle up a gdb build that understands or1k machine
>> code, no. I'm more likely to try to either get EARLY_PRINTK less broken or
>> dredge up the 2 line spin-to-write-register version of 8250 output and cut and
>> paste it in various places if I need to debug this myself.
> 
> That's OK, I usually use the console too to help debug too.

If I can reproduce it and stick a printf in it, I can generally debug it.

>> But I was hoping it was a known limitation or at least easily recognized...
> 
> OK, are things working for you now?  Or is the problem that the initrd still
> does not work?

I can use initrd built-in to the kernel. I cannot supply it externally via
qemu's -initrd. Which means I need to rebuild the kernel (7 minute clean
rebuild) to tweak the filesystem (30 second clean rebuild).

That said, if I can supply an external -initrd to the virt board, then it works
like the other targets. (It's a matter of workflow, I'm trying to regression
test stuff against as many architectures as I can, which means I want them to
work the same.)

One script I have doing this is my smoketest script at
https://github.com/landley/toybox/blob/master/mkroot/testroot.sh which runs all
the targets under qemu and makes sure they can get their clocks set (via ntp if
necessary) and access a block device and do basic networking.

Eventually I want to get that running the toybox test suite inside qemu on each
architecture, but that's still a ways off. (The shell isn't capable enough yet,
working on it...)

I also want to get an automated Linux From Scratch build to compile and run on
each target. I did that before with aboriginal linux years ago, but that was
making busybox into a development environment. (Other projects like Alpine Linux
and Adelie Linux took over from there when I stopped.) Now I'm trying to do it
again with toybox, with the extra difficulty that I can't use any existing GPL
code for anything because toybox is under a public domain equivalent license
(Zero Clause BSD).

(Yes, this would mean building Linux From Scratch on or1k, under qemu. That's
why I need I need a board with a working block device and at least 256 megs of
ram, although I can use a network block device and a swap file in a pinch on
systems with an MMU. I would someday LIKE to do a from-source debootstrap and
populate a musl-backed package repository via automated cluster build, but
there's still a certain amount of undocumented black magic in getting that to
work. The old "people who know have known so long they've forgotten how to
explain it" problem...)

> -Stafford

Rob
