Received: from zero.eik.bme.hu (zero.eik.bme.hu [152.66.115.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6485414A82
	for <linux-openrisc@vger.kernel.org>; Wed,  8 Jan 2025 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.66.115.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736341303; cv=none; b=bT+oz0gVgQrproc/HIOAPQZX3Jr4Mka6b9OEw1DhnpfLopK6GDQ/p8M1ZkNGKfAU4LgKFvnQRu4gOmPNl37bx8UHm9KB0gc4vPQdpgGupAd5+oh0kAVl/2g2Xo4PkszOcpYBizHnpgtISDrsSIUv8YYl6ePjb+wtHHZL9Je98xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736341303; c=relaxed/simple;
	bh=2P4RNRJkWfMsqE0bieVqSF/qo6oM88W9/A6h7lm/Wow=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IEx1Ln5PzcxXhi7FeRmHaRdl4P9BnzVULX+5Y2ueHEr34No1lCflb7GI1/0Smk1HxuWUtIsmilMNk9LtEyNuXqYKUuYGFkRCDqHVolEI3nmhxshnAeDAxUAMq+mypVoD8Ahz6tatPNThHpUc4BS1jH9vgLBs0TzUvHY3QzsO0eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu; spf=pass smtp.mailfrom=eik.bme.hu; arc=none smtp.client-ip=152.66.115.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eik.bme.hu
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 023A24E6036;
	Wed, 08 Jan 2025 14:01:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id NFbZeSGYkxhn; Wed,  8 Jan 2025 14:01:34 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
	id C9BE84E602F; Wed, 08 Jan 2025 14:01:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id C6EB3757B28;
	Wed, 08 Jan 2025 14:01:34 +0100 (CET)
Date: Wed, 8 Jan 2025 14:01:34 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Rob Landley <rob@landley.net>
cc: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
    Stafford Horne <shorne@gmail.com>, 
    Peter Maydell <peter.maydell@linaro.org>, 
    "Jason A. Donenfeld" <Jason@zx2c4.com>, 
    QEMU Developers <qemu-devel@nongnu.org>, 
    Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: or1k -M virt -hda and net.
In-Reply-To: <e2f1c14c-f5d2-48f3-bb6e-d1db0ce6d1fa@landley.net>
Message-ID: <6e5f24cf-02bf-1cf0-2d0d-e683866cc3d3@eik.bme.hu>
References: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net> <Z0Cyx3i3z7Zl7XPm@antec> <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net> <Z0GSETLeT5w8B2DX@antec> <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net> <Z0LMqEqcdjkAxnN-@antec>
 <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net> <Z2lgL31ZeSkO59MZ@antec> <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net> <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net> <Z31k3zNN3pOdGWWK@antec> <87y0zmbita.fsf@draig.linaro.org>
 <e2f1c14c-f5d2-48f3-bb6e-d1db0ce6d1fa@landley.net>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-1940010094-1736341294=:17456"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1940010094-1736341294=:17456
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 7 Jan 2025, Rob Landley wrote:
> On 1/7/25 12:05, Alex Bennée wrote:
>> Stafford Horne <shorne@gmail.com> writes:
>>> I have not used -hda before, do you have it working with other targets?
>>> 
>>> According to the qemu docs in qemu-options.hx. I see:
>>>
>>>      Use file as hard disk 0, 1, 2 or 3 image on the default bus of the
>>>      emulated machine (this is for example the IDE bus on most x86 
>>> machines,
>>>      but it can also be SCSI, virtio or something else on other target
>>>      architectures). See also the :ref:`disk images` chapter in the System
>>>      Emulation Users Guide.
>>> 
>>> I think, since we don't have a "default" bus in openrisc this doesn't work 
>>> so we
>>> need to specify the -drive explictly.
>>> 
>>> I checked the x86 machine code and confirm it seems to work like this. 
>>> There is
>>> code in the system setup to look for hd* drives and wire them into IDE. 
>>> There
>>> is no such code in openrisc.
>> 
>> Yeah don't use -hdX as they are legacy options with a lot of default
>> assumptions. As the docs say: 
>> https://qemu.readthedocs.io/en/master/system/invocation.html#hxtool-1
>>
>>    The QEMU block device handling options have a long history and have
>>    gone through several iterations as the feature set and complexity of
>>    the block layer have grown. Many online guides to QEMU often reference
>>    older and deprecated options, which can lead to confusion.
>
> I want "a block device from this file" in a generic way that works the same 
> across multiple architectures regardless of the board being emulated, where I 
> only have to specify the file not explicitly micromanage bus plumbing 
> details, and which is easy for a human to type from when explained over a 
> voice call.
>
> What's the alternative to -hda you suggest for that?
>
> Can I do "./run-qemu.sh -drive file=blah.img" without the rest? Perhaps 
> specify all the details in the script and then optionally add an extra 
> argument at the end? I couldn't get that to work:
>
> $ root/or1k/run-qemu.sh -netdev user,id=net0 -device 
> virtio-net-device,netdev=net0 -drive format=raw,id=hd0 -device 
> virtio-blk-device,drive=hd0 -drive file=README

You need '-drive if=none,id=hd0,format=raw,file=README' as a single option 
not split into two. With if=none -drive won't auto-create a device so you 
then also need a corresponding -device option for the drive that you seem 
to have already above. If you want -hda to work you may need something 
like commit d36b2f4e78 (hw/ppc/sam460ex: Support short options for adding 
drives) for the machine you use. In particular the MachineClass 
block_default_type field says what's the default interface that -drive and 
other short options should use (at least I think so, I'm no expert on this 
either but searching for it should at least point to where it's handled).

Regards,
BALATON Zoltan

> qemu-system-or1k: -drive format=raw,id=hd0: A block device must be specified 
> for "file"
>
> Also, if you say -device and -drive but do NOT specify a file, qemu refuses 
> to start. So I can't set the defaults but only optionally use them, the way 
> -hda has defaults built into the image that don't cause a problem if I DON'T 
> add a -hda argument to the command line.
>
>>    Older options like -hda are essentially macros which expand into -drive
>>    options for various drive interfaces.
>
> Where the knowledge of "what this board needs in order to do that" is built 
> into qemu rather than provided by the caller, yes.
>
>> The original forms bake in a lot
>>    of assumptions from the days when QEMU was emulating a legacy PC, they
>>    are not recommended for modern configurations.
>
> I'm building a kernel. It finds /dev/?da so I can mount it. That is my 
> desired outcome.
>
> I am attempting to get generic behavior out of multiple architectures, among 
> other reasons so I can cross-test and package up "it fails on X, here's a 
> build and test" to point package maintainers at.
>
> "It natively builds under the emulator" is the easiest way to make that work, 
> which is why https://landley.net/bin/toolchains/latest/ has a native.sqf for 
> each cross.tar.xz.
>
> wget system-image-arch.txz
> wget toolchain.sqf
> wget test.img
>
> ./run-emulator.sh -hda test.img -hdb toolchain.sqf
>
> If I have to explain "-drive virtio-potato-walrus,inkpot=striated -device 
> collect=striated,burbank-potato,ireland" at somebody whose domain expertise 
> is xfce or something, the barrier to getting them to reproduce the issue I'm 
> seeing is noticeably higher. If I have to MAKE a bespoke wrapper shell script 
> for them with every bug report, the likelihood that it works differently for 
> them than when I tried it is noticeably nonzero, and the likelihood of the 
> issue going on my todo heap and never getting pursued upstream is also 
> noticeably higher. Which is why I try to make generic tools...
>
> (Making a _test_ script to demonstrate the issue is normal. If it's their 
> project, usually they can tell if I typoed it and fix it up themselves 
> because they know what I MEANT. But if I typo the setup for the virtual 
> environment, or are missing a prerequisite package install, or they hit qemu 
> version skew, or I said /bin/sh and theirs points to dash... Brick wall. It 
> either works or it doesn't.)
>
> (And when I have to set up the long version for a nightly cron job, and then 
> when the test fails 6 months later and I look at it and go "huh? salad?" 
> that's a bad 3am digression as well. And which is more likely to break from 
> version skew during qemu version upgrades: two lines of micromanaging 
> --longopts or -hda that gets adjusted by the maintainers?)
>
> Rob
>
> P.S. For some reason -hda grew an "I'm going to make the first block 
> read-only just like loopback devices do because you can't be trusted" nag a 
> few years back, but it's mostly yet more boot spam. I can tell the kernel to 
> be quiet during boot, but never figured out the equivalent for qemu-system...
>
>
--3866299591-1940010094-1736341294=:17456--
