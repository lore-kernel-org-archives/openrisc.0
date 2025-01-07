Received: from caracal.ash.relay.mailchannels.net (caracal.ash.relay.mailchannels.net [23.83.222.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D41273F9
	for <linux-openrisc@vger.kernel.org>; Tue,  7 Jan 2025 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.222.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736292061; cv=fail; b=O+QimEvQfy9qunjreJnG7CU9qfOl6q44V091A9m9eK5varK4iHWV7bOu3gHs70VatRZGHcYLvYA4nRT+epq3ErDj3FysZl0rwTfcIaF3uQCCTaWX0pCh0oxW/5YFvxNMGiQsLosU2CwtnyChkFBZTZoXmSUZ7G7Gw/XA+OyRcBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736292061; c=relaxed/simple;
	bh=fN4U7E5OmPyLTfshmgr69REO8fvfnglNwUX4ROpgI2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBImkDRnA8CVkhGCwerLiiEK9t5piq2MLCkoB2pxssyWdvGdqAY6JpLFmesyDdVj6Kgw+uu7mWBvyLBZk99TQECKqIofobPq4k+38d6IyJ4PpIo8U7b8t3YpGKyzp4hZihiTaA5v3rVPYkcHBOghfVPLV+Rv3zBCT92Ry3iDOnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=YR+GRBwk; arc=fail smtp.client-ip=23.83.222.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="YR+GRBwk"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 340623237F6;
	Tue,  7 Jan 2025 23:20:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (trex-2.trex.outbound.svc.cluster.local [100.109.23.135])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A31233223F9;
	Tue,  7 Jan 2025 23:20:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736292057; a=rsa-sha256;
	cv=none;
	b=ERBS0oiVBk2Xb6JwdkcXLRqG1qX7KuXhDocNEsYsb7berQkUcbPhQEH/6D/IXXrC2iiojg
	n13YhgIRcXyjqRNJgF+vRLSOGlB2GLDh9DHwCzZgJAEDZT9Mu+iT0q+2ceo24hdxwL/lWa
	IoyiZ57aUt686Ss1yzBArk/v8lkWv2+XjAraOEZ7+lZX3EHiUdpvpEDvctPUpMTQwXFZ0C
	BWnzfZjAyilMfRzEKyrNEE8KP903zVTMzOLu0efBdgwwutfxgBQWICruWcqQUapamekaJx
	S1BFYVFnQbZG/lIkiX1y8TnZJDzY0I0rZT0e7wAKQsguuA0M0HD2AAOeC3scnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1736292057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=uTPIbz7LB+ULVOPIft/sMzfCsyOKg2ovifBBeDjlNiw=;
	b=avWeJe1ZAgNUlXujgh4KlD7R2WZ+5aACVdB7FOn5J9K4drrXClnT/m0Feo7B03T3COlTsN
	OccRu9HDc7N2tx/JHWy2g5ZZUB5Nw+rsWolwWxrA9Okesoe9rperpKIKuJ+GhanN2PnREV
	SHibX+dxZivQ8LYuDJ82wOODTCJdXxSrihTMkzJhZbHnUjQuAzV1zaIiJHH2S/YfN2VKCD
	gNK5+z0SKtPRldMuWJclrJp0ygIv8w9gMOrkygXSep/7LLktfEHLPM0yABD7E35/deovAG
	8jPU64/bHsomN4RPr5zIkmkRVrXI/f7gl0b41DwYu1gpV7J+BuT04r1XpOPm+A==
ARC-Authentication-Results: i=1;
	rspamd-7df4dcbd86-4qk5j;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Harbor-Cold: 2435848978ac12b9_1736292057917_4051586479
X-MC-Loop-Signature: 1736292057917:226697232
X-MC-Ingress-Time: 1736292057917
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.23.135 (trex/7.0.2);
	Tue, 07 Jan 2025 23:20:57 +0000
Received: from [172.16.32.88] (unknown [198.232.126.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4YSRqr6rBBz8S;
	Tue,  7 Jan 2025 15:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1736292057;
	bh=wWKlZUyNNVVj1YsXWkNsJDVvt0wHxvoYrtx+2KFO3gk=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=YR+GRBwk00tVJR+vSRWtil5ZHEyS92qt2LXmA8h5CoIA81O8dhLBi0OFXqI/k11/f
	 N9f3ZqRIa/QNMD4OhzxVxoIIXcZFMoJuHtsozN984BO0UzWTz36yw+3i/n5S1BI4Ov
	 hRxG8lqeHStDTmF9koToXZCcg2hQlaSs34lHsg/RsgqAA3eSLC4rxL3tjpd1kAvMR/
	 lUXv1+mWteYFXvL+0K4b4SIN4ppo8z9PToxWIPn7/vn+s0Ljy5puVD/Aasq9DCKaqc
	 wFcRAvIM5suj/M4ZrTS5sy9FSilqS3MdgZpqFnC9lwRyzKC9GWS9GiEQudrKkJ89lj
	 jp63iW5vmFgsw==
Message-ID: <e2f1c14c-f5d2-48f3-bb6e-d1db0ce6d1fa@landley.net>
Date: Tue, 7 Jan 2025 17:20:56 -0600
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: or1k -M virt -hda and net.
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>
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
 <87y0zmbita.fsf@draig.linaro.org>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <87y0zmbita.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/7/25 12:05, Alex Bennée wrote:
> Stafford Horne <shorne@gmail.com> writes:
>> I have not used -hda before, do you have it working with other targets?
>>
>> According to the qemu docs in qemu-options.hx. I see:
>>
>>      Use file as hard disk 0, 1, 2 or 3 image on the default bus of the
>>      emulated machine (this is for example the IDE bus on most x86 machines,
>>      but it can also be SCSI, virtio or something else on other target
>>      architectures). See also the :ref:`disk images` chapter in the System
>>      Emulation Users Guide.
>>
>> I think, since we don't have a "default" bus in openrisc this doesn't work so we
>> need to specify the -drive explictly.
>>
>> I checked the x86 machine code and confirm it seems to work like this.  There is
>> code in the system setup to look for hd* drives and wire them into IDE.  There
>> is no such code in openrisc.
> 
> Yeah don't use -hdX as they are legacy options with a lot of default
> assumptions. As the docs say: https://qemu.readthedocs.io/en/master/system/invocation.html#hxtool-1
> 
>    The QEMU block device handling options have a long history and have
>    gone through several iterations as the feature set and complexity of
>    the block layer have grown. Many online guides to QEMU often reference
>    older and deprecated options, which can lead to confusion.

I want "a block device from this file" in a generic way that works the 
same across multiple architectures regardless of the board being 
emulated, where I only have to specify the file not explicitly 
micromanage bus plumbing details, and which is easy for a human to type 
from when explained over a voice call.

What's the alternative to -hda you suggest for that?

Can I do "./run-qemu.sh -drive file=blah.img" without the rest? Perhaps 
specify all the details in the script and then optionally add an extra 
argument at the end? I couldn't get that to work:

$ root/or1k/run-qemu.sh -netdev user,id=net0 -device 
virtio-net-device,netdev=net0 -drive format=raw,id=hd0 -device 
virtio-blk-device,drive=hd0 -drive file=README
qemu-system-or1k: -drive format=raw,id=hd0: A block device must be 
specified for "file"

Also, if you say -device and -drive but do NOT specify a file, qemu 
refuses to start. So I can't set the defaults but only optionally use 
them, the way -hda has defaults built into the image that don't cause a 
problem if I DON'T add a -hda argument to the command line.

>    Older options like -hda are essentially macros which expand into -drive
>    options for various drive interfaces.

Where the knowledge of "what this board needs in order to do that" is 
built into qemu rather than provided by the caller, yes.

> The original forms bake in a lot
>    of assumptions from the days when QEMU was emulating a legacy PC, they
>    are not recommended for modern configurations.

I'm building a kernel. It finds /dev/?da so I can mount it. That is my 
desired outcome.

I am attempting to get generic behavior out of multiple architectures, 
among other reasons so I can cross-test and package up "it fails on X, 
here's a build and test" to point package maintainers at.

"It natively builds under the emulator" is the easiest way to make that 
work, which is why https://landley.net/bin/toolchains/latest/ has a 
native.sqf for each cross.tar.xz.

wget system-image-arch.txz
wget toolchain.sqf
wget test.img

./run-emulator.sh -hda test.img -hdb toolchain.sqf

If I have to explain "-drive virtio-potato-walrus,inkpot=striated 
-device collect=striated,burbank-potato,ireland" at somebody whose 
domain expertise is xfce or something, the barrier to getting them to 
reproduce the issue I'm seeing is noticeably higher. If I have to MAKE a 
bespoke wrapper shell script for them with every bug report, the 
likelihood that it works differently for them than when I tried it is 
noticeably nonzero, and the likelihood of the issue going on my todo 
heap and never getting pursued upstream is also noticeably higher. Which 
is why I try to make generic tools...

(Making a _test_ script to demonstrate the issue is normal. If it's 
their project, usually they can tell if I typoed it and fix it up 
themselves because they know what I MEANT. But if I typo the setup for 
the virtual environment, or are missing a prerequisite package install, 
or they hit qemu version skew, or I said /bin/sh and theirs points to 
dash... Brick wall. It either works or it doesn't.)

(And when I have to set up the long version for a nightly cron job, and 
then when the test fails 6 months later and I look at it and go "huh? 
salad?" that's a bad 3am digression as well. And which is more likely to 
break from version skew during qemu version upgrades: two lines of 
micromanaging --longopts or -hda that gets adjusted by the maintainers?)

Rob

P.S. For some reason -hda grew an "I'm going to make the first block 
read-only just like loopback devices do because you can't be trusted" 
nag a few years back, but it's mostly yet more boot spam. I can tell the 
kernel to be quiet during boot, but never figured out the equivalent for 
qemu-system...
