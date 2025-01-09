Received: from zero.eik.bme.hu (zero.eik.bme.hu [152.66.115.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA871426C
	for <linux-openrisc@vger.kernel.org>; Thu,  9 Jan 2025 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.66.115.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736388345; cv=none; b=jkRMW+HHuHzD0DHJ+NUFOMmBbhYVKvsm3RZ/09bkshzR1b4fNe3vl8J100C4+Om9CR9I7dY4h+Q8Ucv9Wx2kg9a3AxS6GbJQx2CsVdrNm0c9SWb/q+fryArVgw9rUO1o3HW8Yb6oF0cEJtMZQii4SSGUWD7rljRbS1xKujHzGw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736388345; c=relaxed/simple;
	bh=44+kyed9uQMSnsSDRj/xhB7I2MVsM3WfscD2dDNP3O4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cZRpolYaHxPmbPYm+BEctRp8xJdlgTqQmFx/PFxXTQmksnv6Nznd91UIAceI/FxIKMEVhsyRlU1N2dr1hSNksPgIjQiLYU4wkFXrZee61LXnTWHXndsah8LmrMfcMT1KmWoFpwD91LsJYCHNCRQaS64Pm+BrRmOuwozR0aDYAGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu; spf=pass smtp.mailfrom=eik.bme.hu; arc=none smtp.client-ip=152.66.115.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eik.bme.hu
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id DE2A14E6004;
	Thu, 09 Jan 2025 03:05:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id VyD1wgEJoTw6; Thu,  9 Jan 2025 03:05:30 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
	id 9F0584E601D; Thu, 09 Jan 2025 03:05:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 9C6AC757B27;
	Thu, 09 Jan 2025 03:05:30 +0100 (CET)
Date: Thu, 9 Jan 2025 03:05:30 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Rob Landley <rob@landley.net>
cc: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
    Stafford Horne <shorne@gmail.com>, 
    Peter Maydell <peter.maydell@linaro.org>, 
    "Jason A. Donenfeld" <Jason@zx2c4.com>, 
    QEMU Developers <qemu-devel@nongnu.org>, 
    Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: or1k -M virt -hda and net.
In-Reply-To: <c5efb6af-5fef-4938-aac9-c9c8b75a9a69@landley.net>
Message-ID: <ef302909-d94d-4bec-2a2d-3c26898c089b@eik.bme.hu>
References: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net> <Z0Cyx3i3z7Zl7XPm@antec> <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net> <Z0GSETLeT5w8B2DX@antec> <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net> <Z0LMqEqcdjkAxnN-@antec>
 <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net> <Z2lgL31ZeSkO59MZ@antec> <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net> <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net> <Z31k3zNN3pOdGWWK@antec> <87y0zmbita.fsf@draig.linaro.org>
 <e2f1c14c-f5d2-48f3-bb6e-d1db0ce6d1fa@landley.net> <6e5f24cf-02bf-1cf0-2d0d-e683866cc3d3@eik.bme.hu> <c5efb6af-5fef-4938-aac9-c9c8b75a9a69@landley.net>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 8 Jan 2025, Rob Landley wrote:
> On 1/8/25 07:01, BALATON Zoltan wrote:
>> On Tue, 7 Jan 2025, Rob Landley wrote:
>>> What's the alternative to -hda you suggest for that?
>>> 
>>> Can I do "./run-qemu.sh -drive file=blah.img" without the rest? Perhaps 
>>> specify all the details in the script and then optionally add an extra 
>>> argument at the end? I couldn't get that to work:
>>> 
>>> $ root/or1k/run-qemu.sh -netdev user,id=net0 -device virtio-net- 
>>> device,netdev=net0 -drive format=raw,id=hd0 -device virtio-blk- 
>>> device,drive=hd0 -drive file=README
>> 
>> You need '-drive if=none,id=hd0,format=raw,file=README' as a single option 
>> not split into two.
>
> I'm not always specifying an -hda. Sometimes it does, and sometimes it runs 
> without it. I would like to have everything EXCEPT the media specified, so it 
> can be inserted into a ready drive or run without it.
>
> That's what -hda traditionally does.

I think you can't do that with -drive. You either do

-drive if=none,id=d,format=raw,file=raw.img -device whatever,drive=d

or try to have -drive create the device by specifying the type in if 
and hope it works such as

-drive if=virtio,format=raw,file=raw.img

and then you don't need corresponding device but this may not work for 
every machine. The -hda option should expand to such -drive option but it 
cannot if the machine does not define a default interface for block 
devices. So maybe just setting block_default_type in the MachineClass to 
IF_VIRTIO might be enough, otherwise you may need to implement handling 
for it in the machine. In the sam460ex I had to implement it because it 
uses SATA with only two ports which only takes one device per IDE bus 
while the default in QEMU expects PATA IDE that can have two devices per 
bus and two buses but for virtio maybe it works without additional 
handling of drives and only the default is missing which -hda would use.

>> With if=none -drive won't auto-create a  device
>
> $ root/or1k/run-qemu.sh -netdev user,id=net0 -device 
> virtio-net-device,netdev=net0 -drive if=none,id=hd0,format=raw
> qemu-system-or1k: -drive if=none,id=hd0,format=raw: A block device must be 
> specified for "file"
>
>> so you then also need a corresponding -device option for the drive that you 
>> seem to have already above.
>
> $ root/or1k/run-qemu.sh -netdev user,id=net0 -device 
> virtio-net-device,netdev=net0 -device virtio-blk-device
> qemu-system-or1k: -device virtio-blk-device: drive property not set
> $ root/or1k/run-qemu.sh -netdev user,id=net0 -device 
> virtio-net-device,netdev=net0 -device virtio-blk-device,drive=hd0
> qemu-system-or1k: -device virtio-blk-device,drive=hd0: Property 
> 'virtio-blk-device.drive' can't find value 'hd0'
> $ root/or1k/run-qemu.sh -netdev user,id=net0 -device 
> virtio-net-device,netdev=net0 -device virtio-blk-device,drive=hd0 -drive 
> id=hd0,if=none
> qemu-system-or1k: -device virtio-blk-device,drive=hd0: Device needs media, 
> but drive is empty
>
> That's as close as I can get. As far as I can tell, it's complaining that I 
> got it into the state I wanted, and it doesn't want to be in that state. The 
> "if=none" does not appear to help.

I think you can only have empty cdrom devices which can be created without 
a drive option but not devices that don't have removable media. You also 
can't define a drive without a file or some other backing store.

> I also don't know what drive=/id= pair "-hda" would be trying to populate, so 
> dunno what name to use there.

Maybe you can try 'info block' in QEMU monitor to see what drives are 
defined and 'info qtree' to see what devices are attached to them. But if 
-hda option does not work this won't help, you can only check on other 
machines what -hda defines.

Regards,
BALATON Zoltan

> Also, it requires -drive and its argument to be seperate:
>
>  qemu-system-or1k: -device=virtio-blk-device,drive=hda: invalid option
>
> Refusing to let them to be glued together with = (like most --longopt parsers 
> do, including the https://github.com/landley/toybox/blob/master/lib/args.c I 
> wrote) means I can't use bash's brace expansion to set up multiple at once 
> (to preload support for -hda, -hdb, -hdc, and -hdd), ala:
>
>  -drive=id=hd{0,1,2,3},if=none
>
> Not that the current script has a bash dependency... :P
>
>> If you want -hda to work you may need something like commit d36b2f4e78 
>> (hw/ppc/sam460ex: Support short options for adding drives) for the machine 
>> you use. In particular the MachineClass block_default_type field says 
>> what's the default interface that -drive and other short options should use 
>> (at least I think so, I'm no expert on this either but searching for it 
>> should at least point to where it's handled).
>
> Thanks for the pointer, I'll take a look.
>
> Rob
>
>
