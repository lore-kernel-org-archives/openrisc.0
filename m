Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793532015;
	b=eivQBrtTPiGHxYVdp/xaJiwkOnOgbbCZudvic+G/pL/BkXh7bJYdiALvMaN0KpN9ex2x
	 obnUt2pYOaQwi7U4g7o6mB1+nlHfvyivQjDcEc7b3ajz0kFa1Z/MboNXFV8ViHkCfWBpb
	 Sd7kMMueCyY14R156pZq7BLqueqSp6kwuocv6ixUdR6RUBcWSJXsDHi0KJKDbZG93drW5
	 QJ56sEZc5aMAYh8l7XJGWYUaIRUq38XOHSBDQeA7LK+OnGKzhciTqvaIo2dH52lXUb+P5
	 9aF+N9fVw7lTSfGXBsILNsikHXMpfxW5WzuPGBQlqDjIkYplAiE+KjwOOfS7yx8YP4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793532015;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=AR7KeiImAKAGT3RDLJDFL80BXJiLYwayh2zGhuN99is=;
	b=h691A3cEdY4/kp3Mm9JoEglcmr/DfSgk035wgV77YD7BDRmGhoJfzC/HoA2ENuYwrpO0
	 fzG7wJ9Cl0sz2Q33nXJ1ElzEzahxzUVaZBieOZHWrhkz7v27R2nPfEzc3YGQ7N4BX19Nt
	 MxeGgKsSMFL4SDuV7l2RXKZmHPEB+P5sypa8xwws94FCmr6AqmNdR/DRjxq2wn+Y8jK3N
	 G6zBI/A2dq8SvI9EZ9j/gAawcxndtMID/dWdbAS7TLaz7tkRNTJT4xz+Ja+p5k4it44Bp
	 afIIxbxXD5G+sLzodWfVKD28TbeLk8QfFMz3lMScBEnamnMkljuvufwL/argdL5jPkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=JP7risWM;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wqG4Mz8E;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1E3606A325
	for <linux-openrisc@vger.kernel.org>; Sun,  1 Nov 2026 11:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E1E3606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=JP7risWM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wqG4Mz8E
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9D23E140022B
	for <linux-openrisc@vger.kernel.org>; Sun,  1 Nov 2026 06:20:14 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Sun, 01 Nov 2026 06:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793532010;
	 x=1793618410; bh=AR7KeiImAKAGT3RDLJDFL80BXJiLYwayh2zGhuN99is=; b=
	JP7risWM7s9MnW3Or9CymgnEBFHHKx33AO6ub0Egl+9bYXYLoKEWaJIV4XsG+D69
	zAl/v4ezObtaIJ0GGR9oDOF2ULiCNfExwTe9ilo5EZC2fxIHnV1/wHlvTPMKuPHv
	1XjOE4xiPWozQ5BvbsxsTk8yQQq/pQ4G+IdcTgQAgaGghCkPOkFuGfH/WpavHRcH
	L/E+bZREdMarNtf3Cq8HXb5T0R2g9IJqiFvz0IR0EnraBo+t9JtpClOy5ED5gxmI
	mdkBSzb22GL6wkPP41h87J0R4iNhJe2/Hq3UV19axR/QVc6br2tUvyt8W6ej/K6R
	4suxBFjMxZ8c5hfgbeGLFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793532010; x=
	1793618410; bh=AR7KeiImAKAGT3RDLJDFL80BXJiLYwayh2zGhuN99is=; b=w
	qG4Mz8E1BsqlHQ7YpmTnVyAme4pUKy1G9pCZwIivw4tVSZsgvJzAZJo/5+19pA0r
	tdsXjSLAb6HqcuNOLNxjKKiz6uiaNw8Rh2eAPxcW15YuOHOF1r5REjjwNQ2MlrUB
	bASxkeYAHDD65ZsD1agpI+oAc32SUvaDF8V0MW3X+Jemb/iEQ1R1IhcAqNKrpPYs
	FbkkMsaIQfuxWsKbo198TlfQxhGPiBQSvEkBgQ7uaKOMLUnmguLiNJqFexTFnCxE
	B3e4pgvfoyr+OyYKMfTSFckuAgmGaTgcEYYizv/CHjbdotN2D7xgEhca7/NsapeS
	QzwqCARqoot3GqC0R7HyQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793532010; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LW9wZW5yaXNjQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:i4m6WrRQc6Bd6fAue+hjgTrJLFMMjnUKCdcfnhTSBd8Yiwx
	4Zeml7gw5fq1cznZqS+ys/BfWbgNba8svwXxeieQ0S2dSsaViQOkvCE1Iy6dT0Pg
	PYnCoWv9Kx93vjqaItUJlbfLc8Vtrg3gTqcSgyDryGkwnXZrJpIKrPH6x1JE04DH
	uo8KJ0enGaYUpa0Ax/x46qm7qTydOMPR15pb9cfk5EL5Mv7G50RAXMbUAs2KhsmQ
	5+48IXQMcRrbouEb6F3k/09ajw+jYYMtDgEZUfZ77ibgz7kWion86tlewZaEOT8G
	ZjXpRqtOj3JJYsiqG15rCb0kb4oiWzhrNXQOK0A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:xvWc2I2uWzxz9a+9OTFmKblJ1M8ZKEA+BnLF6s+JzKw=:DCU0XSxu0Cgb71JY/lQBbLj5A5ApBrrzZ4yZzi2QJx4=;
X-ME-Sender: <xms:ZiDnav1EgjBw1vmjlVMR8OBojQev_7I5SI7OAEc9ib4et0jFZgxkgQ>
    <xme:ZiDnao6BPYzg-vs7a5Sl4rIx7zTt8iTxYd_dQBkk_Puhc4I96r1MnXV8PdyzVI8d1
    OnsSOk1psHYHAexqLB3bfBiFpZp2BbKjPWGDO4d7TCZDqUXyyeCX2U>
X-ME-Proxy-Cause: dmFkZTGwXwjaijkdfwdLTDS1rJfoLQWQwx/OAGcc1wJWXzOV1LlplydKYfLs7sS3u2ic62
    CzmXdvRhZjRZGtDfGhtKARvLCtcOHzTxamYAY1vpeT9vjCt7kBSjW/vpGBUUmizvEJGKq6
    HkqF3xMdewiKgZlnnl159Lr7mHqRKTudhZbE10HWQVv9w5n7RlQsBFoq6w7bB+eewqatia
    yVvCxIbIwQoFkA0HtrFVYZqQFw9H0MbHp9asXu+PqBTYcgfs5J8p38Ocb45DoWEUi37MwQ
    ziM//GXR0xixs0EBHrvoPsgRCYRgU839aioly6QJeQyTomb68QuPIpfSity3TpmwqTfbaI
    2y+LmdhzM3COgeiwVX+NmpxPzJj+RhgZyOYhGXNVmou9eSv6fAShKmECpOkqi2xxvw5aED
    IoUMsdghLUhudH7svI8U1TIQNe0AH0XIB7qihGZmpGiLRr2x8mqP5BdD/QOoKyzu0t+44L
    epiU4YyDc/6XkrZ9asaxajrCZVp88aZL1BEdpGae9/m/6vjI1bO0qcZ4I1g21VwjAl075E
    QaWF93GgVAys865KPRuVkLZ5fqYnWVuwg+cA37f3+6MC2qRMaVYf5hbd/sYzMix+EtVlFv
    tgvydwvzd0deBidGeCtVKLwCKMmyiM2Zv1CAQEDJol5zA2r8BCOPFoJafibg
X-ME-Proxy: <xmx:aCDnamhQRRW-WDDutkfIUPCZQ745GOmpL73CXqDz-sWy-p-8HmF_dQ>
    <xmx:aCDnalQyGQfYGuTceXkZbnpyTZ8MQwN7AWil1l_HxjQCukF9_HHtVw>
    <xmx:aCDnanYpsN2BqzYLxyh0eeTaYWvKA-P15XCLiNPCto35y7DzJY1mfQ>
    <xmx:aCDnaiR-7ixKbfrozu8dLm6X-FjV1ykjEG6A3ZMF3hO_KhjsX66zkA>
    <xmx:aiDnap1ZTCnpGIGIlvPNOcPfDRyFa5joBTHsjpiOBEvtWZzjVcm0n1tA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id E548E32A0093; Sun,  1 Nov 2026 06:20:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Post: <mailto:linux-openrisc@vger.kernel.org>
List-Help: <mailto:linux-openrisc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-openrisc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: A2HaaWELKR9F
Date: Sun, 01 Nov 2026 12:19:34 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vineet Gupta" <vgupta@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Dinh Nguyen" <dinguyen@kernel.org>,
 "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>,
 "Ley Foon Tan" <lftan@altera.com>
Cc: linux-kernel@vger.kernel.org, "kernel test robot" <lkp@intel.com>,
 linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>
Message-Id: <cf2a83ea-5e5a-42c2-905b-199a43b6341a@app.fastmail.com>
In-Reply-To: <e9f9ac85-442a-4bcc-8ec6-a03a6519178d@kernel.org>
References: <20261019-nios2-mulsi3-v1-1-4fd75b1bacef@linutronix.de>
 <47eb6b48-d664-440f-84b6-ba09f34d5e08@app.fastmail.com>
 <3175caa0-9f49-465d-959e-6b6c9bbb4f01@kernel.org>
 <e9f9ac85-442a-4bcc-8ec6-a03a6519178d@kernel.org>
Subject: Re: [PATCH] nios2: ksyms: Declare __mulsi3 export
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026, at 01:26, Vineet Gupta wrote:
> On 10/31/26 16:57, Vineet Gupta wrote:

>>
>> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=90
>> =E2=94=82=C2=A0 routine=C2=A0 =E2=94=82 calls =E2=94=82 functions =E2=
=94=82
>> =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=A4
>> =E2=94=82 __udivsi3 =E2=94=82 415=C2=A0 =C2=A0=E2=94=82 238=C2=A0 =C2=
=A0 =C2=A0 =C2=A0=E2=94=82
>> =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=A4
>> =E2=94=82 __umodsi3 =E2=94=82 203=C2=A0 =C2=A0=E2=94=82 131=C2=A0 =C2=
=A0 =C2=A0 =C2=A0=E2=94=82
>> =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=A4
>> =E2=94=82 __divsi3=C2=A0 =E2=94=82 77=C2=A0 =C2=A0 =E2=94=82 57=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =E2=94=82
>> =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=A4
>> =E2=94=82 __modsi3=C2=A0 =E2=94=82 41=C2=A0 =C2=A0 =E2=94=82 33=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =E2=94=82
>> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=98
>>
>> I can take a stab at providing the generic libgcc implementation in
>> lib/* but I only expect the arches using libgcc version to switch.
>
> It seems there 4 are always needed together or not at all.
> Do we want 4 Kconfig gates or just one will suffice ?

Either way is fine for me. Simon did separate symbols in his
nios2 patch[1], and I don't mind staying with that version
unless someone else feels strongly about it.

I would however like to have separate patches to add lib/divmul.c
and lib/mulsi3.c, and then patches on top that start using these
from nios2 and arc.

     Arnd

[1] https://lore.kernel.org/all/20261030-nios2-remove-usage-of-libgcc-v1=
-3-4e341c66082e@siemens-energy.com/
