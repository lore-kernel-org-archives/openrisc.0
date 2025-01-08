Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B01FCF44
	for <linux-openrisc@vger.kernel.org>; Wed,  8 Jan 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348352; cv=none; b=WVrWpbNVx6HobI9b6Wr9oujCwY4DFJS5Hn7vSUTo6+xEr1GcmJpmEOPAw8nvdVH8t1zcFr9YDHC1QqWmqi0bbABuAllG1c8qeVKdC7onnT9t/m+YZmvnwdrBbgP0dyzAQRdoeXtKqoKvNvdTh3OBksNufIlyLJ24BoM+A2I1SPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348352; c=relaxed/simple;
	bh=RpBpd/66757kM5UiYVXkUkAuU6PvSF3U9kK0WTyO94g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DEswivvV984eUqTtH473kex8TniPgdlWfBCtpdn6jGUHblSd2Whe8IiQma9POvmGvbMPm5Iqf1Zo5Stwexc0AACH2rAM1VeyV8y9wa+JXsl2NksYwqIhapkJPSE5VbsQZBENBxM5KrJIAu6pIb1xkmw/Y7g6lvvDSQ+ptvpWFGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iXGHJ4U/; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iXGHJ4U/"
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-aaeef97ff02so2178843466b.1
        for <linux-openrisc@vger.kernel.org>; Wed, 08 Jan 2025 06:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736348349; x=1736953149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4yl5M7j04HVGwyU3KVHNQ62ypgg9hQ+++6O70p3+fs=;
        b=iXGHJ4U/c/PHYXLEcH7mPjsg3x1Fu26buT5a38xVSKmNFxpcfUiNEenLNZ8myYlhp4
         M6fU3UsEwlRounwzmgIp2YZux12ErU5WwzgjkJwI4BVUQJX38Ka3lbWSaklNhFwNGqj0
         ZMsCasbVUuOgRwE7E2UYhE53KYlgzBLnvQJ9YPj+JOPQo4h49DaOvHv2nuXw4R1h1jb7
         GY1D2nXE9h7AE9qOd/lFP0KOu3q2PpW8URorRvDHdYhrZufLR58jxapq7qDyOhsErjxK
         /R8QqYyHKTA8M8Ba5+eB7hDaT1w1/yMyW7LgInm3i8dtnkWckUwFWVEVZBiqAJiKhCEE
         SjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736348349; x=1736953149;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o4yl5M7j04HVGwyU3KVHNQ62ypgg9hQ+++6O70p3+fs=;
        b=jXnUVP1xbTtAo2GE6CzvG50SzsPDHsQGuDE5CCIy0vhXH/r79RlY/yXzBrqHkdHPD4
         wnb7BJr1PGzIsWp4uhqLu5H0BnraCKJYGyYtP2aynyUhjGxODxfT5QLCGTkG3o+Rpz61
         BwyhKzF6GLpCLDveOG6c4hcWCuRtAA/h2ZKNZt7hAabHjaV1HGw1AUXFchIpGGzDmJgU
         mDLRX0+1063batmv9KnI1TcEmgeai2Kwrg27MwiwO5xOsiKjTVy8atpiA1GmOuBEKkNh
         e/t0qpzp6dV38x0F1Oe2Ubw4B18IKrBf5X792W82pdVFrtcftSLIAkZxfKvmBSoGweCg
         pDRg==
X-Forwarded-Encrypted: i=1; AJvYcCVi/zDnj8iGGcx1Irf3vqAPIWztevRT0i34DBwdrlfjHoB2uCT8NIg2tdnmJXLYDS48lThpr/nsY9Jb2q343A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyeZk6OXOJC1hm6ZplN9WKxOlJci2UsXUoDyll9OA7f2eoq00L
	7OfF6qWyg6Uzg77+hPOCgyK0ZzS0Gqw18jOHs08jRBfhVuzygIsHN/ddr87oTG4=
X-Gm-Gg: ASbGncumuq5vWdQfRsieYrgHvJ4Jr4dMMuhvsQnxEJqqkUdhLgJXtVQEFeUmMzGR3ju
	lzXW8gFbuTEJv5KdGgvHZTJdaEvSv+ac6lebEU+cb9xGvv8NPQhSCDd8uWAj/gBnLjggeu0ruw9
	fX55MdppwpRdfVit7vJ4Pw0E7eEJFou7Yr5ViMoy3NrPZfA9Cgi9aFFWdAjYLFYvAEIVpKcRau5
	V6nA07NFuOpN6HA0LYKS3FzZS71G9tedcQdPANOBR2v4Toc+jxqrgA=
X-Google-Smtp-Source: AGHT+IHMX80FhNjkGXpVv7j7y3oqFGJIvGQDPL4Q9BMCi3FKYlAIX4AIY6K85lPBkXJKZNNByPmyig==
X-Received: by 2002:a17:907:9690:b0:aa6:738c:2ddc with SMTP id a640c23a62f3a-ab2ab67714amr229325066b.4.1736348348745;
        Wed, 08 Jan 2025 06:59:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe467esm2513775966b.104.2025.01.08.06.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:59:08 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 585645F8AC;
	Wed,  8 Jan 2025 14:59:07 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Rob Landley <rob@landley.net>
Cc: Stafford Horne <shorne@gmail.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  "Jason A. Donenfeld" <Jason@zx2c4.com>,  QEMU
 Developers <qemu-devel@nongnu.org>,  Linux OpenRISC
 <linux-openrisc@vger.kernel.org>
Subject: Re: or1k -M virt -hda and net.
In-Reply-To: <e2f1c14c-f5d2-48f3-bb6e-d1db0ce6d1fa@landley.net> (Rob Landley's
	message of "Tue, 7 Jan 2025 17:20:56 -0600")
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
	<Z31k3zNN3pOdGWWK@antec> <87y0zmbita.fsf@draig.linaro.org>
	<e2f1c14c-f5d2-48f3-bb6e-d1db0ce6d1fa@landley.net>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 08 Jan 2025 14:59:07 +0000
Message-ID: <87msg1bbd0.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rob Landley <rob@landley.net> writes:

> On 1/7/25 12:05, Alex Benn=C3=A9e wrote:
>> Stafford Horne <shorne@gmail.com> writes:
>>> I have not used -hda before, do you have it working with other targets?
>>>
>>> According to the qemu docs in qemu-options.hx. I see:
>>>
>>>      Use file as hard disk 0, 1, 2 or 3 image on the default bus of the
>>>      emulated machine (this is for example the IDE bus on most x86 mach=
ines,
>>>      but it can also be SCSI, virtio or something else on other target
>>>      architectures). See also the :ref:`disk images` chapter in the Sys=
tem
>>>      Emulation Users Guide.
>>>
>>> I think, since we don't have a "default" bus in openrisc this doesn't w=
ork so we
>>> need to specify the -drive explictly.

Well if you want a simple drive command you need something. For example
on -M virt for aarch64:

  -drive  driver=3Draw,file.driver=3Dhost_device,file.filename=3D/dev/zen-s=
sd2/trixie-arm64,discard=3Dunmap

only really contains backend options. By default this will attach the
block device to the virtio-pci bus, see virt.c:

  mc->block_default_type =3D IF_VIRTIO;

The backend options might look a bit much, a simpler case with qcow2
would be:

  -drive driver=3Dqcow2,file=3Dtrixie-x86_64.qcow2=20

However if you don't have any default bus for your block devices you
must use -device/-blockdev pairs. It doesn't add much:

 -device virtio-scsi-pci \
 -device scsi-hd,drive=3Dhd \
 -blockdev driver=3Draw,node-name=3Dhd,file.driver=3Dhost_device,file.filen=
ame=3D/dev/zen-ssd2/trixie-arm64,discard=3Dunmap \

So all I've added is the bus, a device and then linked them with the
drive/node-name ids.

>>>
>>> I checked the x86 machine code and confirm it seems to work like this. =
 There is
>>> code in the system setup to look for hd* drives and wire them into IDE.=
  There
>>> is no such code in openrisc.
>> Yeah don't use -hdX as they are legacy options with a lot of default
>> assumptions. As the docs say: https://qemu.readthedocs.io/en/master/syst=
em/invocation.html#hxtool-1
>>    The QEMU block device handling options have a long history and
>> have
>>    gone through several iterations as the feature set and complexity of
>>    the block layer have grown. Many online guides to QEMU often reference
>>    older and deprecated options, which can lead to confusion.
>
> I want "a block device from this file" in a generic way that works the
> same across multiple architectures regardless of the board being
> emulated, where I only have to specify the file not explicitly
> micromanage bus plumbing details, and which is easy for a human to
> type from when explained over a voice call.

You shouldn't need to micro manage bus details, you just need to link
the device to the backend via an id.

> What's the alternative to -hda you suggest for that?
>
> Can I do "./run-qemu.sh -drive file=3Dblah.img" without the rest?
> Perhaps specify all the details in the script and then optionally add
> an extra argument at the end? I couldn't get that to work:
>
> $ root/or1k/run-qemu.sh -netdev user,id=3Dnet0 -device
> virtio-net-device,netdev=3Dnet0 -drive format=3Draw,id=3Dhd0 -device
> virtio-blk-device,drive=3Dhd0 -drive file=3DREADME
> qemu-system-or1k: -drive format=3Draw,id=3Dhd0: A block device must be
> specified for "file"
>
> Also, if you say -device and -drive but do NOT specify a file, qemu
> refuses to start. So I can't set the defaults but only optionally use
> them, the way -hda has defaults built into the image that don't cause
> a problem if I DON'T add a -hda argument to the command line.

device and blockdev pairs are required. -drive attempts to do both in
one command line option.

>>    Older options like -hda are essentially macros which expand into -dri=
ve
>>    options for various drive interfaces.
>
> Where the knowledge of "what this board needs in order to do that" is
> built into qemu rather than provided by the caller, yes.
>
>> The original forms bake in a lot
>>    of assumptions from the days when QEMU was emulating a legacy PC, they
>>    are not recommended for modern configurations.
>
> I'm building a kernel. It finds /dev/?da so I can mount it. That is my
> desired outcome.
>
> I am attempting to get generic behavior out of multiple architectures,
> among other reasons so I can cross-test and package up "it fails on X,
> here's a build and test" to point package maintainers at.

We support a wide variety of boards some with fixed block device buses
and some with the ability to add stuff dynamically. While we certainly
could do better documenting the edge cases (patches welcome ;-) I'm not
sure its possible to come up with a generic command line that works
across all boards. That said any of the VirtIO enabled platforms (often
called virt) will have fairly similar command lines for adding devices
(modulo PCI/MMIO support).

> "It natively builds under the emulator" is the easiest way to make
> that work, which is why https://landley.net/bin/toolchains/latest/ has
> a native.sqf for each cross.tar.xz.
>
> wget system-image-arch.txz
> wget toolchain.sqf
> wget test.img
>
> ./run-emulator.sh -hda test.img -hdb toolchain.sqf
>
> If I have to explain "-drive virtio-potato-walrus,inkpot=3Dstriated
> -device collect=3Dstriated,burbank-potato,ireland" at somebody whose
> domain expertise is xfce or something, the barrier to getting them to
> reproduce the issue I'm seeing is noticeably higher. If I have to MAKE
> a bespoke wrapper shell script for them with every bug report, the
> likelihood that it works differently for them than when I tried it is
> noticeably nonzero, and the likelihood of the issue going on my todo
> heap and never getting pursued upstream is also noticeably higher.
> Which is why I try to make generic tools...

Just put it in a script then.=20

> (Making a _test_ script to demonstrate the issue is normal. If it's
> their project, usually they can tell if I typoed it and fix it up
> themselves because they know what I MEANT. But if I typo the setup for
> the virtual environment, or are missing a prerequisite package
> install, or they hit qemu version skew, or I said /bin/sh and theirs
> points to dash... Brick wall. It either works or it doesn't.)
>
> (And when I have to set up the long version for a nightly cron job,
> and then when the test fails 6 months later and I look at it and go
> "huh? salad?" that's a bad 3am digression as well. And which is more
> likely to break from version skew during qemu version upgrades: two
> lines of micromanaging --longopts or -hda that gets adjusted by the
> maintainers?)

QEMU's command line reputation is not undeserved but it is at least
consistent with the modern composable options. If we can improve the
documentation then let us know:

  https://qemu.readthedocs.io/en/master/system/device-emulation.html

But expanding the use of automagical options is not really a long term
solution.

> Rob
>
> P.S. For some reason -hda grew an "I'm going to make the first block
> read-only just like loopback devices do because you can't be trusted"
> nag a few years back, but it's mostly yet more boot spam. I can tell
> the kernel to be quiet during boot, but never figured out the
> equivalent for qemu-system...

-append passes options to the kernel command line if you are doing a
direct kernel boot or your firmware supports direct kernel booting.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
