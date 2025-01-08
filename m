Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10AD202C5D
	for <linux-openrisc@vger.kernel.org>; Wed,  8 Jan 2025 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736376026; cv=pass; b=V8bF6wz7PzBJX22tpInBzGUcwRvAIy6Mtyckea2GOvGAJFTczpRXgr2HPuVFQa6bFyNz8H81f1npwTUgw2KHcBzQ6/p6dWxumfec0cRc9TjSxE6j3PxsxWB99vSg8xJpX/rTAYEcichI6pk2JVdXdg/RV0B3k3BTrLgtf/sXIUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736376026; c=relaxed/simple;
	bh=c6RBufcQrDuq8F5Vuw7bakf06obddWgcVnm4kHvt3Kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNG8+bAMso997pnIaw6B2qc6SrAlZgyrg9ICagQ+BQ3l47DfpZ7tFIIBk/xOLlcrMaTSEX7CylK/KhuuWXqydIPNNAr1qPP9tFzyEaG3DzVFFfdUVnrkTMXkjHJCFkjp5YT9SP8AbjnVtgRDeHTvgWTJW0hnPz6r6uFg66wjhq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=KQV3cwhI; arc=pass smtp.client-ip=23.83.212.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="KQV3cwhI"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 87C57782513;
	Wed,  8 Jan 2025 22:40:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a296.dreamhost.com (100-110-82-187.trex-nlb.outbound.svc.cluster.local [100.110.82.187])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D28EC782564;
	Wed,  8 Jan 2025 22:40:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736376017; a=rsa-sha256;
	cv=none;
	b=KLLGnNS07Aqs7ZDtHuNuETH6wJq1cr/3Yhpx2sBqXrPug2GUuT4OTegBmRzQyPzf59xdsV
	bhpChpq1uT9rw/Gvg+Md5tRohKMMPTurxOi9PN4hDKlrvimzIToNabvjJ/DeFRUVmVFldL
	8E1cE4x+Tp7ZMuYXDv0BTDgouNNJGQfKqwWgigSz92jYE/dnx16+sjyfPtiyu9ga+X7oaP
	ouBXd7EvOXbZvXibPLan+/NNsXfrFKIWeMBcr3WQi7rBDBKjf9u2uUgc7EL3txFy+TkZ5F
	e+gydDALBsZRC9itDfq8BnSOr+HuhrE26Vh+6y2qHEB1gzWSCPMJaFD2s7mrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1736376017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CiLLIGrXROWnUE+7dov8gx0OCX6f8LLsvrqwNCwkm5w=;
	b=U5RGvA3bV8m5O6K1/EOM6wGG9uxBNMamaKBkMsBWKCgYU7wEQZ42CmxPl1U8Q9hcKQOgXR
	281wwuTgLm0vmEQZ5VhiW9QyJdbbBmbc7OXH5BXmo9oP8HOLC801HOKTQw5hLPKnSE0hOJ
	cX0hFI2N0tOwTHetRVpoRzDcxME9tRRHaodyrMr9ew3nWWHyf9/jPHPr2B5mM3WhWGMXt+
	N5PXsJLUNf4FBNEaxey1xz3+WOHRMHWbsNUixtUa7epXsNwwwAT+o1jappqA8Qkj/VQPqn
	FtGsmI/pdUEV3Ae4UB6uHMu6NM6A3qjk4QqxrgpWIPNitIAIsnNvXlNC3QgilQ==
ARC-Authentication-Results: i=1;
	rspamd-7df4dcbd86-b2l9f;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Cellar-Lyrical: 45dd5af342f03663_1736376018112_2612468967
X-MC-Loop-Signature: 1736376018112:688906521
X-MC-Ingress-Time: 1736376018111
Received: from pdx1-sub0-mail-a296.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.82.187 (trex/7.0.2);
	Wed, 08 Jan 2025 22:40:18 +0000
Received: from [172.16.32.88] (unknown [198.232.126.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a296.dreamhost.com (Postfix) with ESMTPSA id 4YT2tT17Jfz7h;
	Wed,  8 Jan 2025 14:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1736376017;
	bh=CiLLIGrXROWnUE+7dov8gx0OCX6f8LLsvrqwNCwkm5w=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=KQV3cwhIBPD7cLyGxJKQLQHw+sr70u7NGM7Fo+OMG8MtRxDp93vTEOHG11NYsPEI+
	 utP83hPqE7821m6k3ThxXhyJfvYYk0iC38sg8I7zD4qw8MTX1AEk0Mdhy7ElwnPJ0R
	 XD/MLsx5glaO3+C8GMI7TGiybb80MyZzMs7Xkog8rbZJ7MBOivA1y/0spEnRODN99h
	 0qJ+2DgvQEz23k9NNM1N/8A15BWf+BtmdkqtHUoIndfqv1MIwF7tmyylVMLEHWA4hc
	 9pKT1iDtYv+lFHfY09FpkuIzONkI8yITaKykxC3mSS3q1tIxRVd5ResBTQXBQSyzNV
	 xc/+1je576RlA==
Message-ID: <4b9b20a0-ab3a-4ef5-9ae5-5a32a2eb6be7@landley.net>
Date: Wed, 8 Jan 2025 16:40:16 -0600
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: or1k -M virt -hda and net.
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stafford Horne <shorne@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec> <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec> <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
 <Z0LMqEqcdjkAxnN-@antec> <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>
 <Z2lgL31ZeSkO59MZ@antec> <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
 <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net> <Z31k3zNN3pOdGWWK@antec>
 <0d2df37a-a167-445f-aacf-714a29587511@landley.net>
 <CAMuHMdU2XT=xHr3D4kWVSU=h4jJSoQj1RAdeXDNGEDXdOaqBjQ@mail.gmail.com>
 <ecdf9e8a-9886-43e6-bb02-bf04fc1e88a4@landley.net>
 <CAMuHMdVDhdkLEc-YuDCXHaCpkdtj0QL6wudXDFi0E=PqXyJDtA@mail.gmail.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <CAMuHMdVDhdkLEc-YuDCXHaCpkdtj0QL6wudXDFi0E=PqXyJDtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/8/25 10:26, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Wed, Jan 8, 2025 at 5:23 PM Rob Landley <rob@landley.net> wrote:
>> On 1/8/25 02:24, Geert Uytterhoeven wrote:
>>> On Tue, Jan 7, 2025 at 11:53 PM Rob Landley <rob@landley.net> wrote:
>>>> Microblaze has no /dev/?da (as in there's no device I could attach it to
>>>> even with the long option, I'd have to use NBD), sh4eb has -hda is
>>>> working but it's having some endianness hiccup with the network card
>>>> (works in sh4 but not sh4eb, I'm trying to track it down, I thought this
>>>> worked at one point), and the two "No kernel" ones legitimately have no
>>>
>>> That's using sh_eth, right?
>>
>> 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
>> 8139cp 0000:00:02.0: enabling device (0000 -> 0003)
>> 8139cp 0000:00:02.0 eth0: RTL-8139C+ at 0x(ptrval), 52:54:00:12:34:56,
>> IRQ 128
>>
>> Is there a different driver I should use? That one works on sh4 little
>> endian with almost the same config.
> 
> Oh, you're using an SH4 SoC without internal Ethernet (sh7751 in landisk
> or rts7751r2d, I guess?). That indeed doesn't use sh_eth.

That's the driver used by qemu-system-sh4eb (I.E. -M r2d -cpu sh7751r) 
which has the advantage that it's _really_ easy to test. (Nightly cron 
job even, when I can get a proper server set up to run that...)

The sh2eb turtle board uses JCORE_EMAC which is still an out of tree 
driver. It's not secret, just too ugly to go upstream: done by a 
contractor and never cleaned up, full of half-finished IEEE-1588 support 
and so on. It used to be on 
https://web.archive.org/web/20200812035510/http://git.musl-libc.org/cgit/linux-sh/ 
but alas Rich purged his trees when he stopped being maintainer and 
archive.org didn't crawl that far down.

I have the patch locally if you care, but without the corresponding 
hardware, not much point attaching 1600 lines. (We sent several turtle 
boards to Glaubitz and his assistants last year, and at least one of the 
recipients asked for a copy of the ethernet driver patch, which I sent. 
Still applies and works as of the last kernel I updated on the board, 
6.18 I think? The update is a "pop the sd card, stick in laptop, copy 
files, move sd card back" kinda thing. I should do a linux image that 
can wget and kexec, but haven't yet... Anyway, doesn't help with this 
issue.)

All my other superh boards are A) little endian, B) still in storage 
from the move last may.

Rob
