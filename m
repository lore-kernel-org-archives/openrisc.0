Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E3D14F79
	for <linux-openrisc@vger.kernel.org>; Tue, 19 Dec 2023 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="x+Zp5HcH"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6da5d410432so2706028a34.2
        for <linux-openrisc@vger.kernel.org>; Tue, 19 Dec 2023 03:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1702984419; x=1703589219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yc0xIBdysu+SuoqopeVGMmRd9zTIquCvGD+QJ8u3GQE=;
        b=x+Zp5HcHZr2Hv4eBSrylSYwdqPnjcyPdLtziD8jaN9e7JJNURs0hLX4xI2IrmlgHkv
         /rWrBWVTZvhG0/lTf4YgufNxsrNyIzSXKG7NfqD2S927sJ5hDdFcT0IqST1YSqjg3Pi3
         7d2LvukKnDSmZiNve62xIxKl0Mi4SbpOA6yFFvfUOPe/fqhZgLbyw56Pj9tXHUGSJXEK
         Jc1obIi/P61X4J8DG425+rU/tOySFqkyIUFxlCDFuwipei662KFfC/43v0moGhtAPY5p
         fabynoxfoLUJJT8gi1d13n75ITuQM+spl56vBRgU+8Oi5SP4IhT2gc93MoWRDcfkeLU8
         ETgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702984419; x=1703589219;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yc0xIBdysu+SuoqopeVGMmRd9zTIquCvGD+QJ8u3GQE=;
        b=JizrYYtJ1IIml7aYAmBYpmQ/iMZN2AIojY60nZocT86ZEL0MaxDa8tmA3UYWbWqk+A
         yrURNpCCUWsRJgz1EOyfRqaBPHZWoWocAt930+jehowei484lfVQDV5/8CliUm8+wz//
         2cZ4kXzEF1s+TpsodVbSufq7X2N0NyCWjORO90mLsxLNkvHG8hUJrI3ap5U9WOV666MI
         /PpA33YzoQV7yWYGZuuFUDvsJBeu0aMRtDxtHga/h4ld9EMuizAkOcXYi2zpw/c1HFBK
         0W8/SeDZZTLcXc6DNYu8VRQNYF9VzX+E1z2LgckrsvJoRf7SezFKQVUyfLIb+CbBopoP
         O3iw==
X-Gm-Message-State: AOJu0YxrDXntt3TbaPr+EpLknooKHrR05Ro1yKCekiBaD6TbARV5VgLt
	z89gbXO+ycp33lpIEe/ntqZKAuhUhjABp+BUK8vI/A==
X-Google-Smtp-Source: AGHT+IExkytN39GJNh5CPo0me5D63Mm0cgLEteXi4/xHtPTTf7FKTa8ekosLxr81ff3CuwI+VEjzQA==
X-Received: by 2002:a05:6830:1084:b0:6d9:e192:56a4 with SMTP id y4-20020a056830108400b006d9e19256a4mr17791603oto.17.1702984418783;
        Tue, 19 Dec 2023 03:13:38 -0800 (PST)
Received: from [192.168.1.4] ([136.62.51.249])
        by smtp.gmail.com with ESMTPSA id z11-20020a0568301dab00b006dba602a6dfsm1367oti.29.2023.12.19.03.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 03:13:38 -0800 (PST)
Message-ID: <8ad1fb73-2134-fd8d-0615-bfcc2816e568@landley.net>
Date: Tue, 19 Dec 2023 05:19:33 -0600
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
 <ZX1xbs_AGdgLgcx7@antec> <2e1d9f74-88fa-3f5a-7bc3-4fe7b726f2be@landley.net>
 <ZX658P7dEgqCezpi@antec>
From: Rob Landley <rob@landley.net>
In-Reply-To: <ZX658P7dEgqCezpi@antec>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/23 03:05, Stafford Horne wrote:
>> Can't you have #defines in your toolchain saying what architecture variant it
>> supports? And thus the code can #ifdef those without kconfig having to care?
> 
> Yes, the toolchain supports these, the kernel switches enable the toolchain
> flags when building the kernel (mostly).  For example:
> 
> $ or1k-elf-gcc --target-help
> The following options are target specific:
> ...
>   -mcmov                      Enable generation of conditional move (l.cmov)
>                               instructions.  By default the equivalent will
>                               be generated using set and branch.
> ..
>   -mhard-div                  Enable generation of hardware divide (l.div,
>                               l.divu) instructions.  This is the default; use
>                               -msoft-div to override.
>   -mhard-mul                  Enable generation of hardware multiply
>                               instructions (l.mul, l.muli) instructions. This
>                               is the default; use -msoft-mul to override.
> ..

And presumably have compile-time defaults settable in gcc's ./configure command
line. (Other architectures generally do.)

> The exception is where we use these flags to enable bitops. In:
> 
>  arch/openrisc/include/asm/bitops/ffs.h
>  arch/openrisc/include/asm/bitops/fls.h
> 
> Like other architectures the or1k toolchain doesn't expose which architecture is
> being built. While architectures such as m68k define tunes and export i.e.
> __mcfisaa__ to infer which instructions are enabled.
> 
> OpenRISC has no such architectures as within a softcpu architecture instructions
> can be enabled or disabled as required.  I know, its a bit crazy.

I like the "single point of truth" style where you specify something once and it
gets picked up from that one place by everything that uses it. On other
architectures, I setup mytoolchain to produce the right kind of binaries for the
target, and then the various programs take their cue from the toolchain.

The extra-confusing part here is if I run make menuconfig specifying ARCH= but
NOT specifying CROSS_COMPILE, that changes the config enough that when I build
vmlinux specifying CROSS_COMPILE again I get prompted to set symbols by "make
config". Specifically:

Enable register zeroing on function exit (ZERO_CALL_USED_REGS) [N/y/?] (NEW)

So this architecture IS querying the toolchain for some stuff (and then having
dangling dependencies when you change it out from under a build that it wants
manually fixed up), but other toolchain micromanagement has to be set manually
via menuconfig.

>> >> Hmmm, I've got:
>> >> 
>> >> qemu-system-or1k -M or1k-sim -m 256 "$@" -nographic -no-reboot -kernel
>> >> "$DIR"/linux-kernel -append "HOST=or1k console=FIXME $KARGS"
>> >> 
>> >> And it looks like the answer to "how do you enable a halt/reboot switch that can
>> >> exit qemu" is "don't use the or1k-sim board, use the virt board".
>> > 
>> > Yeah, virt board is the only one that supports halt/reboot.  The 'or1ksim'
>> > platform that we used as the model of qemu 'or1k-sim' supported reboot and halt
>> > via special 'nop' instructions.  The QEMU maintainers did not feel these special
>> > nop instructions should be supported in QEMU.
>> 
>> Sigh. Ok, I'll start the process over digesting the other config and trying to
>> get that one to work instead...

Still need to do this. (Holidays...)

>> >> It provides boot messages without any initrd at all. It eventually panics
>> >> because there's no init, but early in board bringup I'm just looking for proof
>> >> of life.
>> >> 
>> >> > Do you have a valid initrd that maybe I can try out?  I recently use qcow2
>> >> > images to build, but I did used to use initrd images and it did work fine.
>> >> 
>> >> Sure, just remove the BUILTIN=1 from the if or1k stanza, and... it's 582k, I'll
>> >> send it _not_ cc-ing the mailing list. :)
>> > 
>> > OK, I will try this out. But sorry busy this weekend I will probably not get
>> > time.
>> 
>> No rush, I think you've answered my question above. It would be nice to get the
>> bug fixed, but unless I can -device,poweroff or similar on the qemu command line
>> to insert whatever it's poking to halt (and then tell the kernel about it), the
>> sim board isn't useful to me for automation.
> 
> I tried to boot your initramfs with my virt_defconfig kernel, I just exchanged
> driver for -initrd.  It seems to work, but panics with the following:

Testing it in virt_defconfig doesn't reproduce the bug in or1k_sim, but I guess
the answer is "don't use or1k_sim".

> [    0.260000] 90000000.serial: ttyS0 at MMIO 0x90000000 (irq = 2, base_baud = 1250000) is a 16550A
> [    0.270000] printk: console [ttyS0] enabled
> ..
> [    0.420000] usbhid: USB HID core driver
> [    0.420000] NET: Registered PF_PACKET protocol family
> [    0.490000] clk: Disabling unused clocks
> [    0.490000] ALSA device list:
> [    0.490000]   No soundcards found.
> [    0.520000] Freeing unused kernel image (initmem) memory: 232K
> [    0.520000] This architecture does not have kernel memory protection.
> [    0.520000] Run /init as init process
> Type exit when done.
> oneit: /dev/ttyS0ttyS0: No such file or directory
> [    0.780000] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000100
> [    0.780000] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000100 ]---
> 
> I am not sure about /dev/ttyS0ttyS0.

Hmmm, looks like /sys/class/tty/console/active had something I hadn't
encountered before in it, so oneit bugged out trying to redirect the console.
(It can have multiple lines and present or missing /dev/ prefix on each line,
and I didn't have test cases for all the combinations...)

And the problem is, of course:

    memmove(toybuf+5, TT.c, strlen(TT.c));

Needs a +1 on the strlen to also move the null terminator. :P

Oneit runs a child process (with the console redirected to the ACTUAL console
device so it can do job control) and then waits for it to exit, reaping zombies
until then, and calling reboot() when its child process was the one exiting (or
halt, or restarting the child; there's command line flags). This lets you boot
to a shell prompt with working job control (ctrl-C and friends) and a clean
shutdown instead of a panic when it exits.

Thanks,

Rob

P.S. And of course I don't want to check the obvious-seeming oneit fix in until
I can _test_ it, meaning booting the virt board, meaning converting the kernel
config... Working on it.
