Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D10A86330
	for <linux-openrisc@vger.kernel.org>; Tue,  7 Jan 2025 22:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736290404; cv=fail; b=pthVClKadHcRVTvcfi1tifzDw81+lEZEjm5nsUvt619zLZPEa4+ufmjlK5A06Y9BRcYNC5UrUaWSydLk1DWS6Gucp476t4X6uTbuoUh7aptpG0DBWYkAZ2IjvphhPIsluVLxkKxSSGqWrJR8PSPm9orYDZZcc9wpTT2mT1lRcFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736290404; c=relaxed/simple;
	bh=cjn77s4nz7BTq7cvRfuPxUHM6mdgigi94htBroY3Qjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxTJDLNvTkhN/1MrqKB3UCpFVfenR3z2wvuYfHZBfycJpLiMTb5obsQ+AXuJyrG+eljQijLwBAZmYFed53mGeOp6Vz57NNCuXn5EDaSJoHNTYEPSGAJdDOZ2xrxqmp2TvCFztLyCMGkW8LGqCu/B8hGyG+RbVQ/iePG/Cljaw4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=SJHfx3V8; arc=fail smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="SJHfx3V8"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2E38090164B;
	Tue,  7 Jan 2025 22:45:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (trex-3.trex.outbound.svc.cluster.local [100.110.108.105])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C6A08902825;
	Tue,  7 Jan 2025 22:44:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736289899; a=rsa-sha256;
	cv=none;
	b=I0v8xYKKyrUnAHvRtQBSfsXAVpiGqaM45tGz3goahmM2/9pC7E9qW4uDbaZ1Guur3n9bmh
	8aeSb5y2tdlHy7WknrteVANdsI5Fk//16/v2GYjHZHaF/VifzwxNVhmmTGcDTTgdt27WHR
	8QoY1A7CZMUbDVRGR8aB7RKQL1eTPIuADnS9s/mF1dYHAwBAQWharu3B1DfYK/qfy5JI2m
	Tt2ZmYsPZGJWNafQaSvEved9p3k29uK5rWEeuZUHAAoTUEE0tUubJCwfr44dJkM9S7zs45
	Zms9uTZdTAnOyzHSnCZeOlXmlAvKt2TKVD135XwRdk2GypMhu1wlfKrmZunRNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1736289899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=19rQuYKWdj3WspfAlwQyaeO9hXQfsHX9zoPqxvDrcFk=;
	b=2RWX1lRGvG8iOJPpM6nlC+wbFqyrRTDtfIOWqMfiWhAMxgX8wzAkGqSqLbbpqUaaYXuq7u
	8e+rKGaF8vpORCBijdFK1Ata8xXoi/IuvHpuW81bl1OS1eL5lmo4VsvcHYc/R09j0X5W4Y
	wPgETxJNaxsZbcJrW2kJgxIVCDU68iwkL+Yh4ln/uVhTWf4ce0mQfazbFs71kfSrOA2eVn
	pD7gAILJoV3jRT5bWXio4bvtHcTy+KSxwX4Z5lz5GzPgl9VRzHAa4PWcpkxn2CSv2inu+k
	MCoQ5IWnoIzmtHOkM0yGMZx1E8A+UuVKYvg6zw3Y0JpFRYb80oqVHF9nMsUBag==
ARC-Authentication-Results: i=1;
	rspamd-7df4dcbd86-wm5wb;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Abiding-Tart: 4a4d30337d091ca1_1736289900076_3419067299
X-MC-Loop-Signature: 1736289900076:880936782
X-MC-Ingress-Time: 1736289900075
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.108.105 (trex/7.0.2);
	Tue, 07 Jan 2025 22:45:00 +0000
Received: from [172.16.32.88] (unknown [198.232.126.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4YSR2M1RTkz63;
	Tue,  7 Jan 2025 14:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1736289899;
	bh=NXORyqlvwbFeXwzA2tF3x3Nq6v4lGRTmOfEkvZMREus=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=SJHfx3V8WFBTGluNacGlXyvcAPJlh+rhNWI6bWydWV0lBJyu2xETg1pC+9tRa7iHQ
	 2hRzF8TEbO3QEWCKaQu1qqxmwR9kByfxSLGw0WEVravGHFYgytbQqQiU6lg13p584z
	 8pK6flpuRG3BSYE1Q4aeFNowA+TUCPwkB7fdz53xzYdX1kOO/BCf2CZZYw1VZxWHDW
	 /dTcrU7etf7NMfB2OsaTVMWMdAey14ynSmAoI57+DRtd98WC1vrIs3LZ1i2gDLhRaJ
	 5lxPw3UE4nPjesrkGCbUe0fdvT2RE5RAale3j/7KTYeVOdjwtNyF76QYT/c3+5BtNq
	 gJxHhmsYbnQxQ==
Message-ID: <0d2df37a-a167-445f-aacf-714a29587511@landley.net>
Date: Tue, 7 Jan 2025 16:44:58 -0600
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: or1k -M virt -hda and net.
To: Stafford Horne <shorne@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec> <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec> <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
 <Z0LMqEqcdjkAxnN-@antec> <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>
 <Z2lgL31ZeSkO59MZ@antec> <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
 <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net> <Z31k3zNN3pOdGWWK@antec>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <Z31k3zNN3pOdGWWK@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/7/25 11:31, Stafford Horne wrote:
> On Tue, Jan 07, 2025 at 05:56:52AM -0600, Rob Landley wrote:
>> On 12/31/24 19:19, Rob Landley wrote:
>>> On 12/23/24 07:05, Stafford Horne wrote:
>>>>> The kernel config looks like it should have virt block device
>>>>> support, but
>> ...
>>>>     -device virtio-blk-device,drive=d0 -drive
>>>> file=${DISK},id=d0,if=none,format=qcow2
>>>
>>> -drive file=file.img,format=raw,id=hd0 -device virtio-blk-device,drive=hd0
>>>
>>> My -device looks similar but -drive is file=file.img,format=raw,id=hd0
>>>
>>> No idea what if= does? I haven't seemed to need it...
>> ...
>>> Thanks, I think this target is good for release. Now to figure out why
>>> sh2eb network isn't working after the restore (it used to!). Nor is
>>> microblaze's network...
>>
>> My test harness appends -hda filename.img to the qemu command line, which
>> works for all the other targets, and is awkward to turn into
>> -device lots-of-stuff,file-filename.img,more-stuff inside a shell script.
>> (At best it's a special case parsing and rewriting qemu command line
>> plumbing to turn "generic" into an architecture-specific workaround.)
> 
> Hi Rob,
> 
> Sorry, from the laat email I was under the impression that you had everything
> working as expected.

I have it all working by hand, but not in the automated test harness. 
See the comment at the start of:

https://github.com/landley/toybox/blob/master/mkroot/testroot.sh

>> In THEORY I should be able to do something like:
>>
>> root/or1k/run-qemu.sh -netdev user,id=net0 -device
>> virtio-net-device,netdev=net0 -device virtio-blk-device,drive=sd0 -hda
>> README
>>
>> And just have extra arch setup that then accepts the generic appended to it.
>> But in practice that says:
>>
>> qemu-system-or1k: -device virtio-blk-device,drive=sd0: Device needs media,
>> but drive is empty
>>
>> Putting the -hda before the -device doesn't help. (And even if it did, the
>> result would barf if run _without_ -hda, which should also work.)
>>
>> Having -hda by itself is accepted by qemu, but I don't know what bus/driver
>> gets added as a result (or1k kernel does not find it).
> 
> I am having a hard time understanding the use case.

I have a script (above) that creates a test.sqf squashfs image and 
attaches it to the emulator's first hard drive. My init script tries to
mount /dev/?da /mnt and then if /mnt/init exists it runs that instead of 
launching an interactive shell prompt.

The wildcard works for /dev/hda, /dev/sda, and /dev/vda, so no matter 
which type of block device this architecture is using, the codepath to 
invoke it and to use it is generic as long as qemu can populate the bus 
and the associated kernel driver can find the device. This way I can 
test many different architectures with the same code.

Here, maybe this will help:

$ for i in root/*/run-qemu.sh
 > do echo -n "$i:"
 > KARGS='HANDOFF="find /dev -name ?da"' setsid -d timeout -i 10 
/bin/bash $i -hda README 2>/dev/null | grep ^/dev/
 > done
root/aarch64/run-qemu.sh:/dev/vda
root/armv4l/run-qemu.sh:/dev/sda
root/armv5l/run-qemu.sh:/dev/sda
root/armv7l/run-qemu.sh:/dev/vda
root/i486/run-qemu.sh:/dev/sda
root/i686/run-qemu.sh:/dev/sda
root/m68k/run-qemu.sh:/dev/sda
root/microblaze/run-qemu.sh:root/mips64/run-qemu.sh:/dev/sda
root/mipsel/run-qemu.sh:/dev/sda
root/mips/run-qemu.sh:/dev/sda
root/or1k/run-qemu.sh:root/powerpc64le/run-qemu.sh:/dev/sda
root/powerpc64/run-qemu.sh:/dev/sda
root/powerpc/run-qemu.sh:/dev/sda
root/riscv32/run-qemu.sh:/dev/vda
root/riscv64/run-qemu.sh:/dev/vda
root/s390x/run-qemu.sh:/dev/vda
root/sh2eb/run-qemu.sh:root/sh4eb/run-qemu.sh:/dev/sda
root/sh4/run-qemu.sh:/dev/sda
root/x86_64/run-qemu.sh:/dev/sda

The three hiccups above are sh2eb (which is building for a physical 
board so can't run that kernel under qemu), microblaze (which I 
mentioned hasn't got a working block device at all), and or1k. All the 
other architectures accept the same:

   run-qemu -hda filename

And the hardware details aren't the caller's problem. The loop calling 
each board invocation script knows nothing about the board, and doesn't 
have to. This means many different architectures can be regression 
tested in a generic fashion using a human-friendly UI option.

(The "setsid -d" is needed because otherwise if you redirect or pipe 
stdout qemu-system hangs before launching the kernel. Longstanding bug 
of many years, my notes say the hang is because qemu casts SIGTTOU on 
itself and winds up as a frog, 
https://landley.net/notes-2017.html#16-06-2017 and I thought I'd poked 
qemu-devel about it at the time...)

> As you know I use the following to wire in the buildroot image which I turned
> into a qcow2 disk using my tool:
> 
>    https://github.com/stffrdhrn/or1k-utils/blob/master/scripts/qemu-or1k-mkimg
> 
>    -device virtio-blk-device,drive=d0 -drive file=${DISK},id=d0,format=qcow2
> 
> But I think you want to use:
> 
>    -device virtio-blk-device,drive=sd0 -hda XYZ

Yes. I want to just use -hda XYZ which for most targets "just works" 
already because the board knows where to put -hda. Unfortunately, when I 
pass -hda to qemu-system-or1k it accepts it but I can't find the 
resulting block device. (I don't know what driver I'd need to install to 
talk to wherever -hda went on or1k. I've tried tracing the code but it's 
callbacks from callbacks, like reading a choose your own adventure novel.)

Your instructions showed me how to use virtio-block-device which in 
theory should create a /dev/vda and thus work fine with the existing 
code, so I tried to supplement the existing or1k behavior to tell it 
that -hda should go to virtio. I'd be happy to change my kernel config 
to add whatever driver -hda is currently attaching the block device to 
instead, but either way I had to try to figure out how the data 
structures were initialized to, and softmmu/vl.c has:

             case QEMU_OPTION_hda:
             case QEMU_OPTION_hdb:
             case QEMU_OPTION_hdc:
             case QEMU_OPTION_hdd:
                 drive_add(IF_DEFAULT, popt->index - QEMU_OPTION_hda, 
optarg, HD_OPTS);

Which is in blockdev.c doing:

QemuOpts *drive_add(BlockInterfaceType type, int index, const char 
*file, const char *optstr)
{
     QemuOpts *opts = qemu_opts_parse_noisily(qemu_find_opts("drive"), 
optstr, false);
...
     if (type != IF_DEFAULT) {
         qemu_opt_set(opts, "if", if_name[type], &error_abort);

And figuring out where THAT's initialized (or interrogating it at 
runtime) got me as far as:

   grep -r '"device"' qapi/block-core.json

And I think I'd need to be able to use the "monitor" mode which isn't 
really compatible with my normal "serial console on stdin/stdout" use 
cases so I've never quite picked up the knack...

At that point I asked on the list, before sticking 8 zillion printf()s 
into qemu to try to figure out what it's doing.

(The OTHER hiccup is I'd like to be able to NOT use -hda and not have 
qemu abort because -device isn't consumed. I don't mind a warning, it's 
not like qemu-system isn't ridiculously chatty already, but refusing to 
start is a blocker. The guts of the scripts currently look like:

$ cat root/mips/run-qemu.sh
DIR="$(dirname $0)"; qemu-system-mips -M malta -m 256 "$@" -nographic 
-no-reboot -kernel "$DIR"/linux-kernel -initrd "$DIR"/initramfs.cpio.gz 
-append "HOST=mips console=ttyS0 $KARGS"
echo -e '\e[?7h'

So adding a couple -device potato=aardvark,micromanagement=extreme isn't 
a big change, but trying to PARSE the command line arguments and rewrite 
them is brittle and icky. (My old linux from scratch build used -hda for 
a build control image and -hdb for writeable scratch space. There was 
even the occasional -hdc...)

The $DIR shenanigans are so "subdir/run-qemu.sh -hda file" can find 
"file" out of the current directory but find the initramfs and kernel 
image out of the subdir.

The echo -e is because more than one qemu bios bootup spew (which you 
CANNOT SUPPRESS, I've tried) disables wordwrap in the terminal and 
leaves it like that on exit, and then bash's command line 
editing/history goes nuts until you type "reset". man 4 console_codes 
search for DECAWM.

> I have not used -hda before, do you have it working with other targets?

Almost all of them, yes.

In a previous life, I used this same trick to do automated native builds 
of Linux From Scratch 6.x under the emulator. I even had the emulated 
build configured to call out through the virtual network to distcc 
running on loopback on the host (which let me do an SMP build at about 
make -j3 from a single threaded host).

https://speakerdeck.com/landley/developing-for-non-x86-targets-using-qemu

Back when I maintained busybox I taught it to build Linux From Scratch, 
which allowed distros like Alpine Linux to rebase on it, and that was my 
project doing that:

https://landley.net/aboriginal/about.html
https://landley.net/aboriginal/control-images/
https://github.com/landley/control-images/tree/master/images/lfs-bootstrap
https://landley.net/aboriginal/downloads/old/binaries/1.3.0/extras/

This mkroot stuff is my successor project 
(https://landley.net/aboriginal/news.html), which I hope to get natively 
building Linux From Scratch under qemu using a toybox host someday, as 
part of my ongoing plan to turn android into a native self-hosting OS:

https://landley.net/toybox/about.html
http://lists.landley.net/pipermail/toybox-landley.net/2020-July/011898.html

Bit older and slower than I used to be. That much caffeine just gives me 
a migraine these days.

> According to the qemu docs in qemu-options.hx. I see:
> 
>      Use file as hard disk 0, 1, 2 or 3 image on the default bus of the
>      emulated machine (this is for example the IDE bus on most x86 machines,
>      but it can also be SCSI, virtio or something else on other target
>      architectures). See also the :ref:`disk images` chapter in the System
>      Emulation Users Guide.
> 
> I think, since we don't have a "default" bus in openrisc this doesn't work so we
> need to specify the -drive explictly.

Exactly. Patching qemu to have virto be the default bus would also be 
great, you'll notice half the above targets already have -hda slot into 
/dev/vda. There used to be several actual /dev/hda in there too but Greg 
KH hates IDE the same way he hates my Pixel 3's USB tethering driver, so 
now those pretend to be scsi.

> I checked the x86 machine code and confirm it seems to work like this.  There is
> code in the system setup to look for hd* drives and wire them into IDE.  There
> is no such code in openrisc.

Which is why I was trying to redirect it. I dunno how to add the 
relevant code to the system setup, and it wouldn't work with the 
existing release anyway..

If "or1k can't work with -hda" I can document it as broken this release, 
but ALMOST all my targets are passing the basic smoketest! I'm so close!

$ mkroot/testroot.sh
.....................
PASS=aarch64 armv4l armv5l armv7l i486 i686 m68k mips64 mipsel mips 
powerpc64le powerpc64 powerpc riscv32 riscv64 s390x sh4 x86_64
NOPASS=microblaze or1k sh4eb
No kernel: armv7m sh2eb

Microblaze has no /dev/?da (as in there's no device I could attach it to 
even with the long option, I'd have to use NBD), sh4eb has -hda is 
working but it's having some endianness hiccup with the network card 
(works in sh4 but not sh4eb, I'm trying to track it down, I thought this 
worked at one point), and the two "No kernel" ones legitimately have no 
qemu kernel config because sh2eb is producing a kernel for a physical 
board qemu doesn't emulate (j-core turtle, I should signal that somehow 
so it doesn't show up as an error, adding a qemu-system-jcore target 
would be great but I just did 
https://landley.net/bin/mkroot/latest/linux-patches/0002-sh4-fdpic.patch 
so I can test its nommu fdpic userspace under sh4eb instead. Not perfect 
but for basic smoketests...)

And of course armv7m is a whole SAGA... 
https://landley.net/notes-2023.html#23-02-2023 and 
https://www.spinics.net/lists/linux-sh/msg64491.html and... ahem. 
Tangent. Haven't got that one working yet. In theory the toolchain 
FINALLY has fdpic support, musl I'm not sure about (the toolchain I'm 
building is static pie), and I couldn't find a good kernel config that 
lined up with a qemu -M last I checked. (I've looked around for 
examples, but there's a bit of a gap between buildroot's 
configs/stm32f429_disco_xip_defconfig and configs/qemu_arm_ebbr_defconfig).

> -Stafford

Thanks,

Rob
