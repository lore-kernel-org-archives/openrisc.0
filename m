Received: from black.elm.relay.mailchannels.net (black.elm.relay.mailchannels.net [23.83.212.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F9D19DF81
	for <linux-openrisc@vger.kernel.org>; Wed,  8 Jan 2025 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364207; cv=pass; b=B8pviB+zGiDMkHA/NxITcuY4Jky5QTrc2Y9U5zw0/cEbcV3Kr8dnmiH+BENmLZ1lyVvxBilYPfhr85K7CQSemf3OhRkPr65z7lyFuRYu/OOxEux0ye0zhx9Z4uU2ixjyHHYqa81GBm0Mlr0bUtAapWZQ643QGgqiti+mnNXhpuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364207; c=relaxed/simple;
	bh=xSfNKk9RDSLv+t99gN9VOruGBnifF7r406i0neXW/jI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=uB2VnRqeN02kreDVoFMKihLxiKqz7EfwAP5ImA0RZLGp9Dr+dY7ma8sEwwSn7O/qrDDd6fG+Hb0++w7v/xzDg2COkosiSIE/VoJ+iR/qfnZZdsM26b3Lyepvdh2kPNM3Z3TPvY6REdN7/gOSmRbuaJHXIm9lUfiKCY/qiECkVMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=piGGjA/f; arc=pass smtp.client-ip=23.83.212.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="piGGjA/f"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A63541C1C30;
	Wed,  8 Jan 2025 16:23:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a309.dreamhost.com (100-110-108-165.trex-nlb.outbound.svc.cluster.local [100.110.108.165])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4722C1C1BBD;
	Wed,  8 Jan 2025 16:23:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736353405; a=rsa-sha256;
	cv=none;
	b=sFe1/rz5zPHx/Ovb/O6uC0tjPFVw+vMLPx7fM0x8j8xrM0KA58psHHRfWFqa3sTfEGT3OG
	IhtsdHvuPkEBNe8yO8GZnnMtvgd1bBVVvRiBrvwZ2dzc/n7c1dUS7Ykwd1qUltcs2YxiLQ
	x1w56oWFUwPUwcBbVzdv4OsVr6RxG8qGh9kyzds+RbxWlRLJp7taGna1L6DuR90BRGVrit
	xDNfsirJAkwITVygdU0hO4qf7uRIMZIPycSVENUhG+8cqEwyMH3So04wiRXmJRjC55sU5C
	JKAFMET56MBVdx9q4pUQwd4YNyi6iEQmYjx2haScpBsPHQ8045hq47f3j6MLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1736353405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CGDrVvdqW0s36dkkSTkRGhSab9TZ1A3vOMkxmNwyxfY=;
	b=5GE+3eGYZQjcYU7UrrpguAE2e6JTB6oUbOTDoHdjfLx25Y3HTLh+nyZPRMMIp915cGStze
	e8EYWucEhTP3Pr9NugBXoAoXhbmC3BiP5gIewJzxto49LMArRCS1uoWToF2+x6WesEOXOM
	BjqW7EIN1sorRz0ZFHxcbJxiNuvPJlfEWH+HKeaMNkILoVVhAVh0kv1cuJe44JXshddX42
	XwNMbrRL2mk3Y9RqmGjxWWJZIIINfcnIBy45oDMHPF4oUN1Y2w7ew0ZmWoDSJwq54hVEn4
	2iheEn+dbBySJv4w8hLDws9T0T1lCs9dtfiXy1zEvFM7lzBz9eAwcL7QWOazVQ==
ARC-Authentication-Results: i=1;
	rspamd-7df4dcbd86-r9vfz;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Whistle-Desert: 5add090e240d9555_1736353405538_3883757128
X-MC-Loop-Signature: 1736353405538:2201811337
X-MC-Ingress-Time: 1736353405538
Received: from pdx1-sub0-mail-a309.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.108.165 (trex/7.0.2);
	Wed, 08 Jan 2025 16:23:25 +0000
Received: from [172.16.32.88] (unknown [198.232.126.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a309.dreamhost.com (Postfix) with ESMTPSA id 4YStWc30sFz7l;
	Wed,  8 Jan 2025 08:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1736353404;
	bh=CGDrVvdqW0s36dkkSTkRGhSab9TZ1A3vOMkxmNwyxfY=;
	h=Content-Type:Date:Subject:To:Cc:From;
	b=piGGjA/fRIcNwcww47NaQXUjHStwDNTa5NyzcFrT124Guw1lktLNX4Z7I2S3aVHC3
	 O5M1VeeWhV9B71Y2AK9FP6yS4gKk5v4AjSn3kFaAOPwqKQJuNAOy7OjhnIdLi40j2M
	 6aVtp4SFAWHVccQ3yc5I3zPrlhXAWskvnh3NuwX32lItZlSDatvHfcXCS7j+oAK8L9
	 JZRjckM3AHi/uW0+b1Ke2MeWjKrUOXtyfIkgu7LepU+ZegZfdDO3Q4dabgozE0hHOm
	 WfrHZgPmRzPaZLj/ySj5tXAh7qCp4PWSHuvXX3rgxN2qBRYvDS9wodevlBrt0H4mmy
	 m+80ryw2eL6Nw==
Content-Type: multipart/mixed; boundary="------------P08yIc0OD1j4aRX9JfFOjnEj"
Message-ID: <ecdf9e8a-9886-43e6-bb02-bf04fc1e88a4@landley.net>
Date: Wed, 8 Jan 2025 10:23:23 -0600
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
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <CAMuHMdU2XT=xHr3D4kWVSU=h4jJSoQj1RAdeXDNGEDXdOaqBjQ@mail.gmail.com>

This is a multi-part message in MIME format.
--------------P08yIc0OD1j4aRX9JfFOjnEj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/8/25 02:24, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Tue, Jan 7, 2025 at 11:53 PM Rob Landley <rob@landley.net> wrote:
>> Microblaze has no /dev/?da (as in there's no device I could attach it to
>> even with the long option, I'd have to use NBD), sh4eb has -hda is
>> working but it's having some endianness hiccup with the network card
>> (works in sh4 but not sh4eb, I'm trying to track it down, I thought this
>> worked at one point), and the two "No kernel" ones legitimately have no
> 
> That's using sh_eth, right?

8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
8139cp 0000:00:02.0: enabling device (0000 -> 0003)
8139cp 0000:00:02.0 eth0: RTL-8139C+ at 0x(ptrval), 52:54:00:12:34:56, 
IRQ 128

Is there a different driver I should use? That one works on sh4 little 
endian with almost the same config.

> Last time I tried booting a big endian ARM kernel on Koelsch (R-Car
> M2-W), it booted fine until "unable to mount root" (I have no suitable
> userspace), except for broken Ethernet, so it failed to obtain a
> DHCP lease.

Miniconfig I'm using for 6.19 attached.

If you don't want to build mkroot's toybox+musl userspace yourself, the 
initramfs.cpio.gz in the last release from 
https://landley.net/bin/mkroot/0.8.11/sh4eb.tgz presumably still works, 
using the instructions in run-qemu.sh. (I'm trying to get a new release 
out, hence poking at targets that don't quite pass muster.)

You can also use the sh2eb fdpic userspace from the same directory, but 
you'll need the "fdpic with mmu for sh" patch from 
https://landley.net/bin/mkroot/0.8.11/linux-patches/0002-sh4-fdpic.patch 
to enable the fdpic loader in your kernel config. (That's the current sh 
big endian board I know people deploying today, but qemu doesn't emulate 
it directly, so I run its userspace under qemu-system-sh4eb...)

I think I've built a working static busybox defconfig with 
https://landley.net/bin/toolchains/25-03-2024/sh4eb-linux-musl-cross.tar.xz 
too, although not recently. Might need to switch a command or two off?

The boot says "8139cp 0000:00:02.0 eth0: link down" and then pauses for 
3 seconds while ntp fails to talk to time.google.com to set the clock 
newer than 1970 (sadly no battery backed up clock in the board qemu's 
emulating, there's config entries for one in the relevant kernel 
defconfig but nothing in qemu last I checked), and then I get a shell 
prompt that thinks it's 1970 and can't wget or scp with dropbear.

Rob

P.S: If you "./run-emulator.sh -hda file.img" the init script will try 
to mount /dev/?da on /mnt for you, and then run /mnt/init if it exists 
instead of a shell prompt. Easy automated testing.
--------------P08yIc0OD1j4aRX9JfFOjnEj
Content-Type: text/plain; charset=UTF-8; name="linux-miniconfig"
Content-Disposition: attachment; filename="linux-miniconfig"
Content-Transfer-Encoding: base64

IyBtYWtlIEFSQ0g9c2ggYWxsbm9jb25maWcgS0NPTkZJR19BTExDT05GSUc9bGludXgtbWlu
aWNvbmZpZwojIG1ha2UgQVJDSD1zaCAtaiAkKG5wcm9jKQojIGJvb3QgekltYWdlIGNvbnNv
bGU9dHR5U0MxIG5vaW90cmFwCgojIGFyY2hpdGVjdHVyZSBpbmRlcGVuZGVudApDT05GSUdf
UEFOSUNfVElNRU9VVD0xCkNPTkZJR19OT19IWl9JRExFPXkKQ09ORklHX0hJR0hfUkVTX1RJ
TUVSUz15CkNPTkZJR19SRF9HWklQPXkKQ09ORklHX0JJTkZNVF9FTEY9eQpDT05GSUdfQklO
Rk1UX1NDUklQVD15CkNPTkZJR19CTEtfREVWPXkKQ09ORklHX0JMS19ERVZfSU5JVFJEPXkK
Q09ORklHX0JMS19ERVZfTE9PUD15CkNPTkZJR19FWFQ0X0ZTPXkKQ09ORklHX0VYVDRfVVNF
X0ZPUl9FWFQyPXkKQ09ORklHX1ZGQVRfRlM9eQpDT05GSUdfRkFUX0RFRkFVTFRfVVRGOD15
CkNPTkZJR19NSVNDX0ZJTEVTWVNURU1TPXkKQ09ORklHX05MU19DT0RFUEFHRV80Mzc9eQpD
T05GSUdfTkxTX0lTTzg4NTlfMT15CkNPTkZJR19TUVVBU0hGUz15CkNPTkZJR19TUVVBU0hG
U19YQVRUUj15CkNPTkZJR19TUVVBU0hGU19aTElCPXkKQ09ORklHX1RNUEZTPXkKQ09ORklH
X1RNUEZTX1BPU0lYX0FDTD15CkNPTkZJR19ERVZUTVBGUz15CkNPTkZJR19ERVZUTVBGU19N
T1VOVD15CkNPTkZJR19ORVQ9eQpDT05GSUdfTkVUREVWSUNFUz15CkNPTkZJR19ORVRfQ09S
RT15CkNPTkZJR19ORVRDT05TT0xFPXkKQ09ORklHX1BBQ0tFVD15CkNPTkZJR19VTklYPXkK
Q09ORklHX0lORVQ9eQpDT05GSUdfSVBWNj15CkNPTkZJR19FVEhFUk5FVD15CkNPTkZJR19D
T01QQVRfMzJCSVRfVElNRT15CkNPTkZJR19FQVJMWV9QUklOVEs9eQpDT05GSUdfSUtDT05G
SUc9eQpDT05GSUdfSUtDT05GSUdfUFJPQz15CgojIGFyY2hpdGVjdHVyZSBzcGVjaWZpYwpD
T05GSUdfQ1BVX1NVQlRZUEVfU0g3NzUxUj15CkNPTkZJR19NTVU9eQpDT05GSUdfVlNZU0NB
TEw9eQpDT05GSUdfU0hfRlBVPXkKQ09ORklHX1NIX1JUUzc3NTFSMkQ9eQpDT05GSUdfUENJ
PXkKQ09ORklHX1JUUzc3NTFSMkRfUExVUz15CkNPTkZJR19TRVJJQUxfU0hfU0NJPXkKQ09O
RklHX1NFUklBTF9TSF9TQ0lfQ09OU09MRT15CkNPTkZJR19ORVRfVkVORE9SX1JFQUxURUs9
eQpDT05GSUdfODEzOUNQPXkKQ09ORklHX0JMS19ERVZfU0Q9eQpDT05GSUdfQVRBPXkKQ09O
RklHX0FUQV9TRkY9eQpDT05GSUdfQVRBX0JNRE1BPXkKQ09ORklHX1BBVEFfUExBVEZPUk09
eQpDT05GSUdfQklORk1UX0VMRl9GRFBJQz15CkNPTkZJR19DTURMSU5FX0ZST01fQk9PVExP
QURFUj15CkNPTkZJR19NRU1PUllfU1RBUlQ9MHgwYzAwMDAwMApDT05GSUdfQ1BVX0JJR19F
TkRJQU49eQoKIyBhcmNoaXRlY3R1cmUgZXh0cmEK

--------------P08yIc0OD1j4aRX9JfFOjnEj--
