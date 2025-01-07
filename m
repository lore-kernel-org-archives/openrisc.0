Received: from seashell.cherry.relay.mailchannels.net (seashell.cherry.relay.mailchannels.net [23.83.223.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE5F1EB9E7
	for <linux-openrisc@vger.kernel.org>; Tue,  7 Jan 2025 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.223.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251607; cv=fail; b=PrE2Ju3k8eZwu6/26L4L/RrdDnK8DZ2QJ7vhBIQ906FWrNNlLCsSfstP3nUDIKS1n+Ix+wOvCV8B3yz4nelc6ZMwV/uPPX2Drjq8ovpo3CkmDGEIpRZRUhUbIlehIg1NYjY64JAubV2D6FOTIs1+jkeMe4hyi/Gk2oXxCVmWwxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251607; c=relaxed/simple;
	bh=CU0ysfjSpwtSTmiEEi3n0n6rs5yX23ZcR79W4tAZKOM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eU2CqjZsPNQDaVo8LO9PBCTVQ6B6kgjoO5FJ/idJOrR7CLdDJjGiEr+B9Rqnd7fxG2q0eBGo0RQSeXUvkj0YStx0ccGq1YXfXZoWE3kuT7R89oBjwI+wJ7qdIvhazFk4vzchj+8OXjPpXrzsF012547jyl2cYsc5Spb48/7Ooo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=pv1cd20M; arc=fail smtp.client-ip=23.83.223.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="pv1cd20M"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C43902308E;
	Tue,  7 Jan 2025 11:56:53 +0000 (UTC)
Received: from pdx1-sub0-mail-a264.dreamhost.com (trex-0.trex.outbound.svc.cluster.local [100.109.200.96])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5FAAA221B2;
	Tue,  7 Jan 2025 11:56:53 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736251013; a=rsa-sha256;
	cv=none;
	b=TXX1ymFTJIYIu447Py4TQN/9feshXZqzfXBdphXy/bxj3KEbPuY24yP3mCibTtPEQxUpge
	LxzVGtyA7M6vlQhV/SmuGXkQIudhgeWx9f7sYPfscDPD92MPvJ2bibeIoNC5yGCpzJVcQa
	Iibprfyas99NYa0AcQUkRqHRbFx6MdM4mUVV/9GEqAIJcunmy/tErk+6Dnj3kyJQqEvmGh
	4DUFlNFy200+s4l52fBspC2BbOWpHUrKqcdJk7edTlt/4nbHFrUYgimjt9/eijbODdAGji
	LuYQS2p8RQRb+YB6GfXm5fcoTbWKMo0lxx8k0Ixsy/u1XZtnuJbUvlPC/mKa4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1736251013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=duMUvX3UNp0veUQogtJaVfQVHfwtVm56e34BJZWojcM=;
	b=DWuz7T2XVGd8aOr8C93LqlmCY7jnjocivdTSVLG+4W1UaDjN4n8C70xdhOb1DSeirll/tO
	GQWbqzOIeIGIiXU3DLYPUZFfyRmqxB9MuntlO5M1wWpWweAvbJNBt9Gj3xq4cnYvUOfkR9
	KrDzUgl4DLDZMJXZSEtpYXbZ2n7dQTPNt55kKXnA92T5DLKL9R1GO9NYOOkOJ7RFHtEcxs
	QxyGwdwwOhPu6QFoH6xKspz+LG+Adh4CYilyGKB+BydIgKbK2GUmxZ9G5aRSVl8xdDZq94
	BZ7zR9T9+B+uJaw7PnM0HAH3i0BbyXwa227zhOL77ChgjuOrbcrHUU1rD+1YHA==
ARC-Authentication-Results: i=1;
	rspamd-78747dd9f8-lwggx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Obese-Duck: 076470374949171f_1736251013622_767715808
X-MC-Loop-Signature: 1736251013622:4167575820
X-MC-Ingress-Time: 1736251013622
Received: from pdx1-sub0-mail-a264.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.200.96 (trex/7.0.2);
	Tue, 07 Jan 2025 11:56:53 +0000
Received: from [172.16.32.88] (unknown [198.232.126.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a264.dreamhost.com (Postfix) with ESMTPSA id 4YS8fX5WyzzFZ;
	Tue,  7 Jan 2025 03:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1736251013;
	bh=hAa+Wut4rNka3epnxinp2FbGd5RGhLNRtZ/OEEaCMnU=;
	h=Date:Subject:From:To:Cc:Content-Type:Content-Transfer-Encoding;
	b=pv1cd20MmKIjnTgcMXaB9gfkfL/s2OyhyPupHdObPC/nDIZS3+HMElLv5fws8womu
	 Z9UTn7GLrT9P/r/BFlGgWwMvj5+eWHMUNge6pPmMcO8bSTLG8cLsOWmBWemmepkQbf
	 3Ab6cq8F0azBjl8280S2M8gX68pLtoeC79T7NxZva25v0Xsr6iWV8Sa2tExOGKdwx8
	 RxFfGTs06JVhDfXAGiy/gh2ZaidJzv4RhrNHoiVblGj3GfF3Qoy0s8oFsexe98woUH
	 aADI+iwjpgFkX9vMvfdR0YzcdB754xguTQM0sbnpRaguR6Es8wSyUqMZ6A3o/bqhC+
	 FWywujou0z+Ow==
Message-ID: <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net>
Date: Tue, 7 Jan 2025 05:56:52 -0600
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: or1k -M virt -hda and net.
From: Rob Landley <rob@landley.net>
To: Stafford Horne <shorne@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <afac091f-08cb-0f6d-4c01-bfa4421e7a47@landley.net>
 <Zufcf4iAqosZ7VBf@antec> <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec> <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec> <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
 <Z0LMqEqcdjkAxnN-@antec> <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>
 <Z2lgL31ZeSkO59MZ@antec> <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
Content-Language: en-US
In-Reply-To: <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/31/24 19:19, Rob Landley wrote:
> On 12/23/24 07:05, Stafford Horne wrote:
>>> The kernel config looks like it should have virt block device 
>>> support, but
...
>>    -device virtio-blk-device,drive=d0 -drive 
>> file=${DISK},id=d0,if=none,format=qcow2
> 
> -drive file=file.img,format=raw,id=hd0 -device virtio-blk-device,drive=hd0
> 
> My -device looks similar but -drive is file=file.img,format=raw,id=hd0
> 
> No idea what if= does? I haven't seemed to need it...
...
> Thanks, I think this target is good for release. Now to figure out why 
> sh2eb network isn't working after the restore (it used to!). Nor is 
> microblaze's network...

My test harness appends -hda filename.img to the qemu command line, 
which works for all the other targets, and is awkward to turn into
-device lots-of-stuff,file-filename.img,more-stuff inside a shell 
script. (At best it's a special case parsing and rewriting qemu command 
line plumbing to turn "generic" into an architecture-specific workaround.)

In THEORY I should be able to do something like:

root/or1k/run-qemu.sh -netdev user,id=net0 -device 
virtio-net-device,netdev=net0 -device virtio-blk-device,drive=sd0 -hda 
README

And just have extra arch setup that then accepts the generic appended to 
it. But in practice that says:

qemu-system-or1k: -device virtio-blk-device,drive=sd0: Device needs 
media, but drive is empty

Putting the -hda before the -device doesn't help. (And even if it did, 
the result would barf if run _without_ -hda, which should also work.)

Having -hda by itself is accepted by qemu, but I don't know what 
bus/driver gets added as a result (or1k kernel does not find it).

Rob
