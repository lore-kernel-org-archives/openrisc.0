Received: from zero.eik.bme.hu (zero.eik.bme.hu [152.66.115.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AA9847C
	for <linux-openrisc@vger.kernel.org>; Thu,  9 Jan 2025 02:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.66.115.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736390932; cv=none; b=bE6hVLJzvhqSOgI/c8mwMq2F9DEit72is2saSVVZLuEJ/BDO4UHE1MhZ2V8eUOMNK1Q3cS+dSv7Ob+eQdrqsK6SGzQABVjewY3kHHwgwMCbxCwGmweK1oKR/M2nRK6EeSUCv124WcooBh+UPAwEOor+PgIdhGM9dR3pc0IpA5CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736390932; c=relaxed/simple;
	bh=sZ2Jc2W8V2PPB2zVJ6TqvJoo8iVnKMW6U0eHJ4BOohM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oWAPFUdVhlUbmYIfIwvgDpW9kbwv+JYhNG+OkGO51f9XJ3MsyKKxJn8zT05W6RRwQEsOpzINcUX/R+CEYw02yFILwXucT2eo2fIBh3F/YXLXIsnXAJjse8Q7imGtId8YunuSn3jN8Vh9rXC3k1KF9UfBk7BDVaROGL5NZmAyqcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu; spf=pass smtp.mailfrom=eik.bme.hu; arc=none smtp.client-ip=152.66.115.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eik.bme.hu
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 7BABB4E601D;
	Thu, 09 Jan 2025 03:48:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id wUIt-3s1gMnq; Thu,  9 Jan 2025 03:48:44 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
	id 403274E6004; Thu, 09 Jan 2025 03:48:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 3DE8B746F60;
	Thu, 09 Jan 2025 03:48:44 +0100 (CET)
Date: Thu, 9 Jan 2025 03:48:44 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Rob Landley <rob@landley.net>
cc: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
    Stafford Horne <shorne@gmail.com>, 
    Peter Maydell <peter.maydell@linaro.org>, 
    "Jason A. Donenfeld" <Jason@zx2c4.com>, 
    QEMU Developers <qemu-devel@nongnu.org>, 
    Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: or1k -M virt -hda and net.
In-Reply-To: <fe70397e-671b-4c7e-b73b-bc45cd376b15@landley.net>
Message-ID: <27a425df-a9f4-29cc-8200-60285c49368d@eik.bme.hu>
References: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net> <Z0Cyx3i3z7Zl7XPm@antec> <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net> <Z0GSETLeT5w8B2DX@antec> <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net> <Z0LMqEqcdjkAxnN-@antec>
 <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net> <Z2lgL31ZeSkO59MZ@antec> <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net> <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net> <Z31k3zNN3pOdGWWK@antec> <87y0zmbita.fsf@draig.linaro.org>
 <e2f1c14c-f5d2-48f3-bb6e-d1db0ce6d1fa@landley.net> <87msg1bbd0.fsf@draig.linaro.org> <fe70397e-671b-4c7e-b73b-bc45cd376b15@landley.net>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-339921134-1736390924=:30386"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-339921134-1736390924=:30386
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 8 Jan 2025, Rob Landley wrote:
> On 1/8/25 08:59, Alex Bennée wrote:
>> Rob Landley <rob@landley.net> writes:
>> 
>>> On 1/7/25 12:05, Alex Bennée wrote:
>>>> Stafford Horne <shorne@gmail.com> writes:
>>>>> I have not used -hda before, do you have it working with other targets?
>>>>> 
>>>>> According to the qemu docs in qemu-options.hx. I see:
>>>>>
>>>>>       Use file as hard disk 0, 1, 2 or 3 image on the default bus of the
>>>>>       emulated machine (this is for example the IDE bus on most x86 
>>>>> machines,
>>>>>       but it can also be SCSI, virtio or something else on other target
>>>>>       architectures). See also the :ref:`disk images` chapter in the 
>>>>> System
>>>>>       Emulation Users Guide.
>>>>> 
>>>>> I think, since we don't have a "default" bus in openrisc this doesn't 
>>>>> work so we
>>>>> need to specify the -drive explictly.
>> 
>> Well if you want a simple drive command you need something. For example
>> on -M virt for aarch64:
>>
>>    -drive 
>> driver=raw,file.driver=host_device,file.filename=/dev/zen-ssd2/trixie-arm64,discard=unmap
>
> echo "We've replaced the dilithium they normally use with Folger's Crystals." 
>> file.img
> qemu-system-aarch64 -M virt -cpu cortex-a57 -m 256 -nographic \
>  -no-reboot -kernel linux-kernel -initrd initramfs.cpio.gz \
>  -append "HOST=aarch64 console=ttyAMA0" -hda README
> ...
> Type exit when done.
> $ cat /dev/vda
> We've replaced the dilithium they normally use with Folger's Crystals.
> $ exit
> reboot: Restarting system
>
> Seems like a sane default is already there. (And on most other boards.)
>
> I also note that 90% of the above qemu invocation is the same for all 
> targets. My build system's entire configuration for the m68k architecture is 
> just:
>
>>   elif [ "$CROSS" == m68k ]; then
>>     QEMU_M=q800 KARCH=m68k
>>     KCONF="$(be2csv MMU M68040 M68KFPU_EMU MAC BLK_DEV_SD MACINTOSH_DRIVERS 
>> \
>>       NET_VENDOR_NATSEMI MACSONIC SCSI{,_LOWLEVEL,_MAC_ESP} \
>>       SERIAL_PMACZILOG{,_TTYS,_CONSOLE})"
>
> And here's the or1k target under discussion:
>
>>   elif [ "$CROSS" == or1k ]; then
>>     KARCH=openrisc QEMU_M=virt KARGS=ttyS0
>>     KCONF="$(be2csv ETHOC SERIO SERIAL_OF_PLATFORM SERIAL_8250{,_CONSOLE} \
>>       VIRTIO_{MENU,NET,BLK,PCI,MMIO} POWER_RESET{,_SYSCON{,_POWEROFF}} 
>> SYSCON_REBOOT_MODE)"
>
> There are some targets I have to poke harder, armv5l and armv4tl have
> "qemu-system-arm -M versatilepb -net nic,model=rtl8139 -net user" for some 
> reason... Huh, apparently I've been doing that since 2007?
>
> https://github.com/landley/aboriginal/commit/5a51e551568a
>
> Why did I do that... https://landley.net/notes-2007.html#04-07-2007 says 
> "switch to using the rtl8139 driver because PIO doesn't work on
> the qemu-system-arm PCI controller yet so I need something with mmio." Maybe 
> that's fixed by now and I can go back to the default network card there? 
> Hmmm, hw/arm/versatilepb.c says the default is smc91c111, the kernel driver 
> for that is CONFIG_SMC91X... which needs GPIOLIB for some reason (why is that 
> a depends not a selects?) And yes, the board's default network card works if 
> I flip on the right driver and remove the --micromanagement.
>
> Ok, fixed: https://github.com/landley/toybox/commit/65887c2f3cd8
>
> But the point was it _can_ do that. Just seldom needs to. I was asking for a 
> "that" prefix which let me use -hda on or1k (and still worked when I didn't 
> supply one). I don't mind supplementing or overriding an unworkable default 
> in the wrapper script, I've done it before. But what I was asking for was 
> something to make -hda work when $@ expanded to it.
>
>> only really contains backend options. By default this will attach the
>> block device to the virtio-pci bus, see virt.c:
>>
>>    mc->block_default_type = IF_VIRTIO;
>> 
>> The backend options might look a bit much, a simpler case with qcow2
>> would be:
>>
>>    -drive driver=qcow2,file=trixie-x86_64.qcow2
>
> A raw block device can be loopback mounted on the host and mounted within 
> qemu in the same way. (Qemu doesn't even mind if they're sparse, although 
> loopback still did last I checked.)
>
> The block device isn't even always a filesystem, sometimes it's a tarball. 
> And when it is a filesystem, half the time it's squashfs. Why wrap it in a 
> ubifs-style block remapping layer? Extra step, more tools, can't look at the 
> data in hexedit (which comes up)... It may be nice to have a more complicated 
> option, but "raw image" is the generic version.
>
>> However if you don't have any default bus for your block devices you
>> must use -device/-blockdev pairs. It doesn't add much:
>>
>>   -device virtio-scsi-pci \
>>   -device scsi-hd,drive=hd \
>>   -blockdev 
>> driver=raw,node-name=hd,file.driver=host_device,file.filename=/dev/zen-ssd2/trixie-arm64,discard=unmap 
>> \
>
> Where "you don't" means "the board doesn't"? So the user of the board has to 
> manually tell the board emulation what bus type it has available? (And guess 
> right, because I can't add arbitrary types, the board will only ACCEPT 
> certain ones...)
>
>> So all I've added is the bus, a device and then linked them with the
>> drive/node-name ids.
>
> With hda I'm saying "here's the filename for your block device", and I'm 
> usually externally supplying it to an existing board setup. When comparing 
> the m68k behavior with the arm behavior of the same piece of software, I 
> don't need to tell each system how to be itself. (It already knows.)
>
> With your suggested API, specifying the filename as its own argument separate 
> from the rest doesn't seem to have occurred to the designers.
>
> If I don't provide an -hda then there isn't one. Cleanly drops out. If I 
> specify -device without a filename, qemu tends to get upset and refuse to 
> start.
>
> You jumped into the thread to encouraging a move from -hda to -drive. In what 
> way is -drive the superior option from a user perspective?
>
>>>>> I checked the x86 machine code and confirm it seems to work like this. 
>>>>> There is
>>>>> code in the system setup to look for hd* drives and wire them into IDE. 
>>>>> There
>>>>> is no such code in openrisc.
>>>> Yeah don't use -hdX as they are legacy options with a lot of default
>>>> assumptions. As the docs say: 
>>>> https://qemu.readthedocs.io/en/master/system/invocation.html#hxtool-1
>>>>     The QEMU block device handling options have a long history and
>>>> have
>>>>     gone through several iterations as the feature set and complexity of
>>>>     the block layer have grown. Many online guides to QEMU often 
>>>> reference
>>>>     older and deprecated options, which can lead to confusion.
>>> 
>>> I want "a block device from this file" in a generic way that works the
>>> same across multiple architectures regardless of the board being
>>> emulated, where I only have to specify the file not explicitly
>>> micromanage bus plumbing details, and which is easy for a human to
>>> type from when explained over a voice call.
>> 
>> You shouldn't need to micro manage bus details, you just need to link
>> the device to the backend via an id.
>
> By "shouldn't need to micro manage the bus details", are you saying I can 
> link the device to the backend without ever having manually specified the bus 
> type on the command line?
>
> Inside the VM, my init script does something like:
>
>  [ -e /dev/?da ] && mount /dev/?da /mnt
>  [ -x /mnt/init ] && exec /mnt/init
>
> So it doesn't care if it's sda or vda and "just works" as long as the device 
> shows up in /dev. And it just works if it's _not_ there either. (And used to 
> work with /dev/hda before they made everything pretend to be scsi.)
>
> To trigger it, I go "./run-qemu.sh -hda filename.img" because my run script 
> has "$@" in the qemu command line, so I don't need to know how it will be 
> used. (This isn't the ONLY thing they can add, another common thing is to set 
> up port forwarding so a server in the emulator can appear on a host loopback 
> port.) It's a generic tool like a hammer. It works the same whether 
> ./run-qemu.sh is in the m68k directory, sh4eb, powerpc, etc.
>
>>> What's the alternative to -hda you suggest for that?
>>> 
>>> Can I do "./run-qemu.sh -drive file=blah.img" without the rest?
>>> Perhaps specify all the details in the script and then optionally add
>>> an extra argument at the end? I couldn't get that to work:
>>> 
>>> $ root/or1k/run-qemu.sh -netdev user,id=net0 -device
>>> virtio-net-device,netdev=net0 -drive format=raw,id=hd0 -device
>>> virtio-blk-device,drive=hd0 -drive file=README
>>> qemu-system-or1k: -drive format=raw,id=hd0: A block device must be
>>> specified for "file"
>>> 
>>> Also, if you say -device and -drive but do NOT specify a file, qemu
>>> refuses to start. So I can't set the defaults but only optionally use
>>> them, the way -hda has defaults built into the image that don't cause
>>> a problem if I DON'T add a -hda argument to the command line.
>> 
>> device and blockdev pairs are required.
>
> Required when -hda doesn't work.
>
>> -drive attempts to do both in one command line option
>
> If I can -drive setup,setup,setup and then -hda filename.img (or not) later, 
> then the details can get hidden in run-qemu.sh, which is what I was asking 
> how to do earlier in this thread.
>
> Or does -drive still require I know what filename to attach, and whether or 
> not to do it? So if I wanted to support -hda command.sqf -hdb workspace.ext3 
> -hdc toolchain.iso that got intercepted and turned into
> -drive by a shell script I would need... I dunno, some sort of loop?
>
> Do you want my wrapper script to include a regex to notice one of its 
> arguments was "-hda", find the argument after that and convert it into a 
> -drive line, with error handling for "there wasn't another argument" or , and 
> = in the filename? Plus it needs to know -hdb and -hdc and -hdd as well to 
> keep parity with what was previously there...
>
> Or do you want the users to have to externally specify the -drive line to the 
> script, with target-specific bus type they didn't need to know before in 
> order to attach a disk to a VM?
>
> Which of these is the improvement that makes a move from -hda to -drive 
> better for the user?
>
>>> I am attempting to get generic behavior out of multiple architectures,
>>> among other reasons so I can cross-test and package up "it fails on X,
>>> here's a build and test" to point package maintainers at.
>> 
>> We support a wide variety of boards some with fixed block device buses
>> and some with the ability to add stuff dynamically. While we certainly
>> could do better documenting the edge cases (patches welcome ;-) I'm not
>> sure its possible to come up with a generic command line that works
>> across all boards.
>
> I have one already. The qemu devs deprecated it for some reason, and made it 
> spit warnings and break fdisk when using "raw" images. (If you can wipe 
> everything _except_ the first few blocks, what exactly have you improved? 
> Never understood that part...)
>
>> That said any of the VirtIO enabled platforms (often
>> called virt) will have fairly similar command lines for adding devices
>> (modulo PCI/MMIO support).
>
> The test I ran upthread said that aarch64, armv7l, riscv32, riscv64, and 
> s390x were all using /dev/vda for -hda.
>
> And armv4l, armv5l, i486, i686, m68k, mips, mips64, mipsel, powerpc, 
> powerpc64, powerpc64le, sh4, sh4eb, and x86_64 weren't.
>
> And the caller didn't need to know the difference.
>
>>> If I have to explain "-drive virtio-potato-walrus,inkpot=striated
>>> -device collect=striated,burbank-potato,ireland" at somebody whose
>>> domain expertise is xfce or something, the barrier to getting them to
>>> reproduce the issue I'm seeing is noticeably higher. If I have to MAKE
>>> a bespoke wrapper shell script for them with every bug report, the
>>> likelihood that it works differently for them than when I tried it is
>>> noticeably nonzero, and the likelihood of the issue going on my todo
>>> heap and never getting pursued upstream is also noticeably higher.
>>> Which is why I try to make generic tools...
>> 
>> Just put it in a script then.
>
> Which is why my question upthread was if there was a way to use the 
> micromanaging --longopts to tell qemu what plumbing -hda (and -hdb, etc) 
> should attach to, without actually requiring there to _be_ one.
>
> The answer seems to be "no, it needs a patch and rebuild".
>
> If I have to agglutinate a supplied filename into a -drive thing,thing,thing 
> list, how do you suggest I do that without #!/bin/bash having to be present 
> because I wrote shell plumbing to make elaborate command line option parsing 
> decisions that were never tested on "fish" or "zsh" or "dash" or busybox ash 
> or...

Sometimes sed can do wonders (or break completely) but maybe it can turn a 
-hda filename option into -drive if=virtio,file=filename if you can't fix 
hda for some machines.

> Keep in mind the current shell plumbing is literally "$@" from posix.
>
>>> (And when I have to set up the long version for a nightly cron job,
>>> and then when the test fails 6 months later and I look at it and go
>>> "huh? salad?" that's a bad 3am digression as well. And which is more
>>> likely to break from version skew during qemu version upgrades: two
>>> lines of micromanaging --longopts or -hda that gets adjusted by the
>>> maintainers?)
>> 
>> QEMU's command line reputation is not undeserved but it is at least
>> consistent with the modern composable options. If we can improve the
>> documentation then let us know:
>>
>>    https://qemu.readthedocs.io/en/master/system/device-emulation.html
>> 
>> But expanding the use of automagical options is not really a long term
>> solution.
>
> Do you plan to replace "-m 256" with a longopt that requires you to specify 
> the physical address range of the new memory using multiple name=value comma 
> separated arguments?
>
> Or is "-m 256" a useful control knob indicating a thing a user wants to have 
> happen without needing to know all the board-specific implementation details 
> to invoke it?
>
>>> Rob
>>> 
>>> P.S. For some reason -hda grew an "I'm going to make the first block
>>> read-only just like loopback devices do because you can't be trusted"
>>> nag a few years back, but it's mostly yet more boot spam. I can tell
>>> the kernel to be quiet during boot, but never figured out the
>>> equivalent for qemu-system...
>> 
>> -append passes options to the kernel command line if you are doing a
>> direct kernel boot or your firmware supports direct kernel booting.
>
> I asked why append doesn't 8 years ago:
>
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03127.html

I think this originates from lilo which had an append option to specify 
options to append to kernel command line and then had addappend to append 
more options to that... QEMU only took the append which like in lilo 
overrides earlier instances despite what its name might suggest.

> I'm not sure how your response relates to "-hda complains about raw images". 
> The commit in question that broke it (38f3ef574b48) preserved the probe for 
> image types, instead of having -hda just default to "raw" always, and

The commit explains why this was a security issue. Making -hda only accept 
raw would also less inconvenient and would have changed how it worked 
before so I think this solution was chose to preserve as much 
functionality as possible.

> requiring the --longopt version to specify the types. That's the part I never 
> understood, THAT seemed a really weird decision. "The qcow image format is 
> insecure, because qcow can always #include arbitrary external files so if you 
> run qemu as root it can read /etc/shadow which is apparently a thing people 
> do". There is indeed a problem, but it's not raw?
>
> For that matter, why not do what qemu did for:
>
> -m [size=]megs[,slots=n,maxmem=size]
>
> You _can_ have a short option do a sane thing by default but add _optional_ 
> compostable csv nonsense to it, where "in order to use an image file with an 
> = or , in it you need -hda name=thing,thing and name= will always eat the 
> rest of its argument", possibly with an informative error message when -hda 
> file,name or -hda file=name doesn't understand what it was given.

Patches are welcome, I guess. Originally QEMU had a less options and they 
were simple. If you look at -help it still says:

usage: qemu-system-x86_64 [options] [disk_image]

'disk_image' is a raw hard disk image for IDE hard disk 0

So in the simplest form you can just pass a disk image to boot without any 
options but not sure it still works.

But later QEMU got more complex and this needed more complex options. Then 
a lot of the mess in the command line came from that it needs to serve 
both users and management apps which require low level control for 
everything and these apps took over QEMU for a while, that's how a lot of 
non-user friendly options crept in and then user friendly options were 
changed to be high level wrappers on those low level ones to avoid having 
two independent set of options for the same thing but maybe this was not 
always done and there's still room to improve. Also having those 
management apps meant less people cared about user friendly options and 
just used those apps instead.

Regards,
BALATON Zoltan

> The UI decisions here struck me as very strange, and deprecating the way -hda 
> has worked since 2005 seemed odd to me. (Possibly earlier but 
> https://landley.net/notes-2005.html#02-12-2005 is when I first got an -hda of 
> a partitioned disk image with LILO installed on it to boot under qemu. That 
> was before even aboriginal linux, that was 
> https://landley.net/aboriginal/old/ and most of the progress reports about 
> _that_ were on livejournal. I switched from User Mode Linux _to_ qemu.)
>
> Rob
>
>
--3866299591-339921134-1736390924=:30386--
