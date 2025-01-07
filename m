Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F4617B50A
	for <linux-openrisc@vger.kernel.org>; Tue,  7 Jan 2025 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273160; cv=none; b=Nc+lQSU4NUHShF4obgRxlXw2TL+yy2GIORx5tBZqDuR3gU3FqHLMyXj47ga6G8YV+n2BdXi1bRHEmKL/AFjL6FPKsCI0S8yOAbDVmcBDFnnY6a9VoPBWZ8EJCvt/zD3MjgoCKsEHpE+qNBKmQ9Js55+WFfUVKB9BERFV9EkWdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273160; c=relaxed/simple;
	bh=j4R43zn9Ml+OlATCgs/qAiW9sCiam/gQwK0zFLVkWJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GIjWgvhxcqiIyX1AbG813T75m5HIuSyTUc+IRb+4olpH9V+cGQ+otb6Cnw//An7DwY+k7P6c23tTvkPmG53DBv4MnZHp57tYgqBgRjbGP4zwo4K6Nfpl0YuMLkLZg9grpL0zUVYIIABR01JWTC1j2pRM7tUqrEBvJ4GjS9EJ4cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uSiC3SYJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uSiC3SYJ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43690d4605dso73025935e9.0
        for <linux-openrisc@vger.kernel.org>; Tue, 07 Jan 2025 10:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736273155; x=1736877955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB4okT009rU8j6+qdrOZKtR9cK4WM7WBxut5Gl1Vaq4=;
        b=uSiC3SYJOhFaUmTqrVeKJfoZm0jvDVLoimb0+CKVRav0GmK72/6GfyWDr7ZfqYry5K
         Z+1UG71l5zYz00OPJJiAzA9PX6IMEHoqtymjqfHBPEpNnz9sd/97xrvtBcf2ob/VoZ5L
         vXbk/yQXVKLUax1H1c77ppABAExV6iS30vG/6M+6+bzfmjyYUUPtxrGDv/UI5HUuVGBY
         d7eSMhRgZd/7xGmniZxMWblka5+xPWJ5gSrPfDkqeAfWfznqVyqVYOAAzglxcO5BwyCA
         igro7+XbFGCfPC4isCSUUSpy+Fqwwp7Ocj8t8G3QVOGZO/fePJeF8kHznHYNSDdrJan9
         eLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736273155; x=1736877955;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JB4okT009rU8j6+qdrOZKtR9cK4WM7WBxut5Gl1Vaq4=;
        b=PV8nPJ+7Cv2EKHvLV2kBR6uyw13ifHMTVqKebjypnF8J4HDNzjGgWN5TNAqVXpRgzE
         3Som6BHEIjeP5LcqHqg8d8TwOleYNOi1g3Af1M8J0x++CmToG3pDKq/aNquo56rfSqs4
         HYjf8+wWHApy1js4Mqf3hYTWyfuwWDDnk5ohkTspDs2glQPxLAaCs/9m2qHXi+o8udms
         LXb5V48zvKg1SA5H6lA1Nw9dZ65+KahIENZ4slblQssbjU7SpC2nfTW+899s0b8d0uwM
         RBgCanW8fXmMyg2/O0qDqQ2g5j4xYiXl4tDELFYErvjelvSpd+g2Zasx6WuNBupEhl2C
         j15A==
X-Forwarded-Encrypted: i=1; AJvYcCVcGzekkZGvivhrxb8f+WF6kBNmE3gXah+GGENFgW5vDEg17p1+R2uOv9wRcCioztE4myeNOmMDJG63Xu/wuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3AwjfGE2POFMgqMPJ+/r1pxcIms5QPNKdkc1p2IrBqQqbPofl
	f1PDSSqW9nL2CeXVnfJ0Q2KHyPOTCZg/ipwDEvXiesOpGzs5lUDogZKTPiIWgoUT/QF2mwrMapL
	JWeY=
X-Gm-Gg: ASbGncv64hhDYVo094jGwURQUt/pyDk1ko+h4rBrxcU61Fn64u0YYvPGuL9qJ4NqCZ/
	PHK3d9EN3/TkcCEaJIV0kAy2bnpvlad4SZ0Q+c5cBoefn9+aa64EXjZdSyxGEG3/QYqxDWwywSl
	8s4hWXl4g4UJ6rrTNBmI7Ic/ispBphlFTZbXnhX2IZOlNwmhErLs6HAkVil66fIR4KVrUUGfWOR
	2BNIjYl57bDWmJ06HH1VYX61XYeIvT1mDuj+g1wst/jfOoh7Eo7LiA=
X-Google-Smtp-Source: AGHT+IEv6cEbPMSWMXY2Sz5nFztpSautdpf55Jb1ubZGzwB4OVyQmyWZWdodSYiO70vtn9ZNIwLTZg==
X-Received: by 2002:a05:600c:468d:b0:436:346a:fa9b with SMTP id 5b1f17b1804b1-43668b499aamr459800365e9.20.1736273154848;
        Tue, 07 Jan 2025 10:05:54 -0800 (PST)
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436dcceb8c6sm14950545e9.0.2025.01.07.10.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 10:05:54 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 652E35F869;
	Tue,  7 Jan 2025 18:05:53 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stafford Horne <shorne@gmail.com>
Cc: Rob Landley <rob@landley.net>,  Peter Maydell
 <peter.maydell@linaro.org>,  "Jason A. Donenfeld" <Jason@zx2c4.com>,  QEMU
 Developers <qemu-devel@nongnu.org>,  Linux OpenRISC
 <linux-openrisc@vger.kernel.org>
Subject: Re: or1k -M virt -hda and net.
In-Reply-To: <Z31k3zNN3pOdGWWK@antec> (Stafford Horne's message of "Tue, 7 Jan
	2025 17:31:11 +0000")
References: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
	<Z0Cyx3i3z7Zl7XPm@antec>
	<31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
	<Z0GSETLeT5w8B2DX@antec>
	<87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
	<Z0LMqEqcdjkAxnN-@antec>
	<57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>
	<Z2lgL31ZeSkO59MZ@antec>
	<8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
	<39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net>
	<Z31k3zNN3pOdGWWK@antec>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 07 Jan 2025 18:05:53 +0000
Message-ID: <87y0zmbita.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stafford Horne <shorne@gmail.com> writes:

> On Tue, Jan 07, 2025 at 05:56:52AM -0600, Rob Landley wrote:
>> On 12/31/24 19:19, Rob Landley wrote:
>> > On 12/23/24 07:05, Stafford Horne wrote:
>> > > > The kernel config looks like it should have virt block device
>> > > > support, but
>> ...
>> > > =C2=A0=C2=A0 -device virtio-blk-device,drive=3Dd0 -drive
>> > > file=3D${DISK},id=3Dd0,if=3Dnone,format=3Dqcow2
>> >=20
>> > -drive file=3Dfile.img,format=3Draw,id=3Dhd0 -device virtio-blk-device=
,drive=3Dhd0
>> >=20
>> > My -device looks similar but -drive is file=3Dfile.img,format=3Draw,id=
=3Dhd0
>> >=20
>> > No idea what if=3D does? I haven't seemed to need it...
>> ...
>> > Thanks, I think this target is good for release. Now to figure out why
>> > sh2eb network isn't working after the restore (it used to!). Nor is
>> > microblaze's network...
>>=20
>> My test harness appends -hda filename.img to the qemu command line, which
>> works for all the other targets, and is awkward to turn into
>> -device lots-of-stuff,file-filename.img,more-stuff inside a shell script.
>> (At best it's a special case parsing and rewriting qemu command line
>> plumbing to turn "generic" into an architecture-specific workaround.)
>
> Hi Rob,
>
> Sorry, from the laat email I was under the impression that you had everyt=
hing
> working as expected.
>
>> In THEORY I should be able to do something like:
>>=20
>> root/or1k/run-qemu.sh -netdev user,id=3Dnet0 -device
>> virtio-net-device,netdev=3Dnet0 -device virtio-blk-device,drive=3Dsd0 -h=
da
>> README
>>=20
>> And just have extra arch setup that then accepts the generic appended to=
 it.
>> But in practice that says:
>>=20
>> qemu-system-or1k: -device virtio-blk-device,drive=3Dsd0: Device needs me=
dia,
>> but drive is empty
>>=20
>> Putting the -hda before the -device doesn't help. (And even if it did, t=
he
>> result would barf if run _without_ -hda, which should also work.)
>>=20
>> Having -hda by itself is accepted by qemu, but I don't know what bus/dri=
ver
>> gets added as a result (or1k kernel does not find it).
>
> I am having a hard time understanding the use case.
>
> As you know I use the following to wire in the buildroot image which I tu=
rned
> into a qcow2 disk using my tool:
>
>   https://github.com/stffrdhrn/or1k-utils/blob/master/scripts/qemu-or1k-m=
kimg
>
>   -device virtio-blk-device,drive=3Dd0 -drive file=3D${DISK},id=3Dd0,form=
at=3Dqcow2
>
> But I think you want to use:
>
>   -device virtio-blk-device,drive=3Dsd0 -hda XYZ
>
> I have not used -hda before, do you have it working with other targets?
>
> According to the qemu docs in qemu-options.hx. I see:
>
>     Use file as hard disk 0, 1, 2 or 3 image on the default bus of the
>     emulated machine (this is for example the IDE bus on most x86 machine=
s,
>     but it can also be SCSI, virtio or something else on other target
>     architectures). See also the :ref:`disk images` chapter in the System
>     Emulation Users Guide.
>
> I think, since we don't have a "default" bus in openrisc this doesn't wor=
k so we
> need to specify the -drive explictly.
>
> I checked the x86 machine code and confirm it seems to work like this.  T=
here is
> code in the system setup to look for hd* drives and wire them into IDE.  =
There
> is no such code in openrisc.

Yeah don't use -hdX as they are legacy options with a lot of default
assumptions. As the docs say: https://qemu.readthedocs.io/en/master/system/=
invocation.html#hxtool-1

  The QEMU block device handling options have a long history and have
  gone through several iterations as the feature set and complexity of
  the block layer have grown. Many online guides to QEMU often reference
  older and deprecated options, which can lead to confusion.

  The most explicit way to describe disks is to use a combination of
  -device to specify the hardware device and -blockdev to describe the
  backend. The device defines what the guest sees and the backend
  describes how QEMU handles the data. It is the only guaranteed stable
  interface for describing block devices and as such is recommended for
  management tools and scripting.

  The -drive option combines the device and backend into a single
  command line option which is a more human friendly. There is however
  no interface stability guarantee although some older board models
  still need updating to work with the modern blockdev forms.

  Older options like -hda are essentially macros which expand into -drive
  options for various drive interfaces. The original forms bake in a lot
  of assumptions from the days when QEMU was emulating a legacy PC, they
  are not recommended for modern configurations.

>
> -Stafford

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
