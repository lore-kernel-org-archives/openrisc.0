Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076857;
	b=LditTuWO83HzNOg187/4PsDEczu41WHj0hnly2KMAj9lPam5lDbcxmF7uJguRklQkSIo
	 X6DflB265d3LqQv1XwgpCggm0MK16EVHAdsHAR8ytqxNcl62OPpMzw36XWri9ocYRSG72
	 UblnoAKScNDD6US4Nm0iuzMRHJDyDQ198oChyi0/smW9QzD1n+2UFoDV0Qpd0mL2PeUDt
	 D257N242tF+XX2iC/kISYm9yWhtTMx95IK3iMxhg+V965EUK1pXFsaq3kzu5JABC86rtk
	 0whYtFOVN6W0/jW5+5Tt7PGcPh7qoNQEi0YFgh5eMkUj84O0r7BdL74DUKZ9C6jiC5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076857;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=Dw2q8IL1wjmsTR+qJNvV5rMR+yLv2cKTTGNhz0woQiY=;
	b=HK8dfzo1nkffFajW+efebOqBi2Hlmpm2mxkA485SnXyZ/1mwDpLeQGgbUEo68mmOnnKI
	 pBmmzl3TQKTAwWo7s64F8EevCeZVnnxYdeqJ3wD4OnTKcfcv2obBHikOHAt/2mN1Q4Mcr
	 7eWn+6MaKX6TR0feAgyNh2fGRPXlJ2WykoJxu6u404iHVZOgc3VY3NqfxaaOHNh0v1Azp
	 APHlbSIzJAbnzk2OMjcV9P5wxmpzrBYtd0hey5XqzMQp1tE8/4jsrrFTgC2T/2+MDloDp
	 9qbko2jkzXd7lSDxRUrNfYW42w4k5QkZMTfI8mvtIhyjXREmsj4S+OH5U4p9768CdOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=EXNfnMsS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XKUR1bwe;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FCE606A325
	for <linux-openrisc@vger.kernel.org>; Thu, 19 Nov 2026 08:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79FCE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=EXNfnMsS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XKUR1bwe
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9A72C7A02C7
	for <linux-openrisc@vger.kernel.org>; Thu, 19 Nov 2026 03:27:36 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 19 Nov 2026 03:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795076850;
	 x=1795163250; bh=Dw2q8IL1wjmsTR+qJNvV5rMR+yLv2cKTTGNhz0woQiY=; b=
	EXNfnMsSpzenqbvEVHu1LMUvpFnuFy6rGLQqoC6MtNEIO71BanE4eCWjn9zwHd5O
	d+c3quKPpoWGGSt0rRVSFtp0OtEBj5Uz9sFxI8042yXyeaDmfXxBQEnariN4DGpe
	hKPsQ+c94IG3n685i5zkTIWFK3wttbKfVWIea8B3D60MvSvBPmF8SUKX6FAsQccu
	5R3Y1YRAPPwnRvmK/PAM9rLhtjfOg+ij7k5cW8O06GIwsYBDl2RHxKX5fSbKcYGT
	zZmBcBN+dOgnjMK1bifLgJa+NWB6TCYmqepevSVCnUN9zjrRvQ6xDsAxZo/+4sqr
	Ti7PKIKgQLzpzIbaj93jBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795076850; x=
	1795163250; bh=Dw2q8IL1wjmsTR+qJNvV5rMR+yLv2cKTTGNhz0woQiY=; b=X
	KUR1bwe5BwIlpkvGwgu5OnV0gkhh1BkJ2BzyLCqBQtwYuJbEvXo92OBHZuHY55ik
	tNUWu0YkAX2RSLVF4e1S/YdoHjRWhMVUa69VUrCHv0FxTRGA+mBzWri2W0k6ag9X
	cCGu7V3P2bnbKQWfNjkSxOnizipIToefdkekmtgSfVsYwSd0ABaxqNHQuft6uduM
	4YSX7V0i4BuRJzkrJA/8wXTL4LL7wJgaOq4Ccjq5EvmALVydjrHconGyEdKZAq+t
	ZR+RbOKwi6Kg9iM22d1EvIOK+230LpeUwNNksXg9Z67POlFrh4t00Zt/9kfmv2Lr
	hIaCuyGAg55cjGrssgXpw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795076850; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LW9wZW5yaXNjQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:PbYZi14f1AmdE7IWQUHtcTeFejhDuxvE/wJvKU6nD+sdcV1
	3nIuE9FYyQpxKSHKksTLd/JM7lx1kdfKSpEcS6mPAbyAXRH1h3ekAtUR/Wpaf4dU
	VZAIMjit4SE11RDK4ZMhXpczGb+eYi6Ed/+WtuO9hdfW6oW+UIHLzEnxjobYedVv
	pUJatBXpsXUUYIUxd1IAzofl3glowCkvJWhjByq6e4QFSguA/tgnGpPQZSUmWM9k
	I8kZjbtvZ36FXEitxAYDPGSllhoyMVm1m3JjAXh00RpgAkThqJfEJIZAHF9sRXPU
	c+YVuXAaowGsdzQHhIk1nN0CZAjMZAj6vFpODJQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:38katowk3PLIqYxjJq1fN31+3a5ifKQsxhh+W9e6f5Y=:v9sVWsIQ2Y6fKwJ6G5G1cEaPaE3lJadywxd83luirlM=;
X-ME-Sender: <xms:7rL-ap0vSKnWuKM5bV7d6plQysQ0Ar2iyQdJbaQxK45Yq96ozPGdwA>
    <xme:7rL-aq4nztQSHbCdhfjQcTcc_6-SL03MjkKfUKJ6ranIEf3BGYmG7rCOd81efkovf
    dbDjnmlbqw7sOFcwioxBgQndfuJkL13RvIeuehdo5rnP_qnYa7vbGwc>
X-ME-Proxy-Cause: dmFkZTFDzgM4lPuhyFyB7PYePOAsgiF+xpDNDzvQL5O6718m6tCxOdvKBqMnj2JpMYjRrq
    fnMlW0tja6vUkcykU86qOM2O+jOuIlZybqBKRRsEI2HziWVGJ5Cd0JK7yDW6S42yjI9BnU
    H9HI/lBFz87DW8LhV/72Jz2W/NKdh3Wg89z3YAutIKKYUSnwxDSlhQr4Yozvs6QR7YmVCC
    KrOlYOKPFrgDVzFecsqDl/bZbwo75708mEZyw92qBveOlk0HpXjFUDmfO4xQX5QlQ/N2xp
    L/reFtIezibP7xlq97dfMTSH2OZmkOcMFLSl6J0AvNbqBwIghNyYF0isD4fVzpMKLnjISM
    r9WEzSgBsmy+UVeV6ISdLSMKgNvAiHdcsXGwXmEgt/JBwHj2gUvhydGN9oYbmUmqKXHN82
    muUhPNr4mHGsDlo9hk4dLNCepJZgLiXzYl8sS8XblGD5A+rPvQbnLPMf4Igx2oPus5vdZJ
    +Kfx1icFSU7F51Wf5Pz8PvYowWpdaAIXgShokVu4zN9e8c0bjzNCRG05FHUbLFSzIH5+7p
    GstgA27kypP6qcmRACMGl1FEj5RMD22nW1aLWjCNhlZC0RWDqadjBJ8t7AzFYLGGCHwNNg
    teKBH/RJDeVlbu/aSGbUmgKoFAH7l/GQdj9aWsKyMjXGIVqldWKcwig3+4VQ
X-ME-Proxy: <xmx:8LL-auGbPSoCasRNthC0dMzMQ3pf6UmkgcGKqjhAAkFniXtKLG7_qg>
    <xmx:8LL-avw6VTnay3xdP7Male_1s-nJkTigBW0C6Ak8W7N6ZKrVnw9leQ>
    <xmx:8LL-ao2Bn62xiCFtFRnWxa5jVUzaABw8zuEdmyrA2yCtIfEbcLuowA>
    <xmx:8LL-avq9FmfrLpjEcbBKIkDhmxZIaDStXVdEZIf4yrGJjQBB3VtdkA>
    <xmx:8rL-at9-YqzTAFzI0o-fQA8HAuvbx6UhOzhGKmmMsfCFHduvLKsMveIX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 3A0AF32A009C; Thu, 19 Nov 2026 03:27:26 -0500 (EST)
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
X-ThreadId: A9y9RtHuK9Pc
Date: Thu, 19 Nov 2026 09:26:54 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Stafford Horne" <shorne@gmail.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: soc@lists.linux.dev, "Jonas Bonn" <jonas@southpole.se>,
 "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>,
 "Dinh Nguyen" <dinguyen@kernel.org>,
 "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>,
 "Vineet Gupta" <vgupta@kernel.org>,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>
Message-Id: <a3d2b50c-e3ef-43d8-b330-53bcc6b804e6@app.fastmail.com>
In-Reply-To: <av4u27rT4UqtnXUM@antec>
References: <20261118160820.2994933-1-arnd@kernel.org>
 <av4u27rT4UqtnXUM@antec>
Subject: Re: [PATCH] openrisc: stop using libgcc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 19, 2026, at 00:03, Stafford Horne wrote:
> On Wed, Nov 18, 2026 at 05:08:20PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> Based on the work for nios2 and arc, remove the inclusion of libgcc
>> and instead use the kernel's own copy of the required functions.
>> 
>> Cc: Jonas Bonn <jonas@southpole.se>
>> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
>> Cc: Stafford Horne <shorne@gmail.com>
>> Cc: Dinh Nguyen <dinguyen@kernel.org>
>> Cc: Simon Schuster <schuster.simon@siemens-energy.com>
>> Cc: Vineet Gupta <vgupta@kernel.org>
>> Cc: linux-openrisc@vger.kernel.org
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Stafford Horne <shorne@gmail.com>

Thanks, I've added this to the asm-generic tree, and now only arch/parisc
still uses libgcc.

    Arnd
