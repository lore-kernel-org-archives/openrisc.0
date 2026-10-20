Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489252;
	b=LB4/N6wB8ls+biN87hY1z/xQd+PevQbunFN3tnB8IXnonwLPqclJ+9YLmm3e6ll0V81C
	 GUz9dRn1X0H7EVrBLPx2UsPXHMxeFgztMWlgI5vWsWeM55mvcXso9ws4SYqTEh6+Yy8kL
	 lGmItRp43IhDd5YRDdUzBajhDWs27crQ9q5EQO7C+tVNKzUcvCvnimZo+knTC9l6Tgqf2
	 Bb2QhcifYlk5/wciAZwq9fqUaiE/jpbO1UC+drPDrCHTH7/PI+1nddFtFU3u+jW+fYqgD
	 ZlFuUrOhR957oMQR3WIKes5zDR8/KfYCB0kfP/F8h9c069/dM/z9aEk+KE0vClqOBSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A75WOahLsxv+hidbJl57jAQmkr4ntTiQuJfofCyvgAA=;
	b=1mgomONt2vDuqOK/v0AxHNYLmlGJ2Ct2weYPY48BcIKhZLvpjFGs6ejTLQalmXq+uV8p
	 STT0MhPL3X4Jcu7lLLQTHUpo1JJseSM9assYSxtWk9ZkIzKvB355x2vSZ6NV/dL1eJ8xr
	 ZZeryEiDZxmWfTQqsGyqm76vFieG/24mT7kvZYhd/GR7Ltzkzq5EvGK+bclrN2NH+ejtp
	 e73jCvOKfCC4rw8R2OUTGIFteleOUUC3T3NNB55sQCuQWYO/Hw1jg/KVIQqCf34k27PjY
	 LkYX3XIUFxZLGs76WLv8RVWKdkMQvY1EVyhviC98PANCk36bd1N7TKIYg2gImHOjZpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XV4Cvim9;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C572660A3810
	for <linux-openrisc@vger.kernel.org>; Tue, 20 Oct 2026 09:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C572660A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XV4Cvim9
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so17769435e9.0
        for <linux-openrisc@vger.kernel.org>; Tue, 20 Oct 2026 02:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792489250; x=1793094050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A75WOahLsxv+hidbJl57jAQmkr4ntTiQuJfofCyvgAA=;
        b=XV4Cvim9PGmRPYDYWPvQxtCfIVwqwnzysqMcwp5ZopGQIZiwPM2c/Blf4nJty23CBX
         MUoruMd6T9T63oEUmvZDXPd3ykx9ceI+H/n0o6nSaYrKuLSBL+A4r1koIYW8OJJCy08d
         ogtgHykli4AdY+EDDENGKkka9QeVdV+NA8+62bY2rUbUk7Mc4T++oXX5CZN1xWDiJP8D
         ceMCkm7yuea88WI9Ugb7ISrBk64f7qcNE6jvwRziPHMQwGdJ+Zq++ik8gGD3PUVZNgkp
         g6QyDPzCN8CfWcseqJAaXh7BiG+/dwz9S2vUmThYHmNrUxEZivkLhOZWN72QgpkyQDCn
         daDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792489250; x=1793094050;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A75WOahLsxv+hidbJl57jAQmkr4ntTiQuJfofCyvgAA=;
        b=q7KfdqJ/44nhUBHdXcnsHhrysaOmXaAuBEIPtbXzB8PuLPG3MHsg2YXDZ5ajfFxGsa
         IDVQ91Ll13KbcRYrjfh0oZkwqEEDm22r6fcTHZIa0kGLsEtpgUQrcGVyuS8un0Vlmf4f
         JFGx03S03PNxLmKlMxYyIraPjvaXEWQTH0h89Yc7BXBOdLhmJ6+YZ8nfRs8Hp8R4kIrr
         ivNryh1aWDOVAKYjyRANEcV8clrCUdhnTPd2pi1+Vr4K2OJnv5bG8PHDbRaXmXkooeNF
         a36hHMN//BlHDPOmjyQTzGJzoI4Hp8ycN/X7qXMtX0ebJiThpkHReRQDTEoNwc5vyfhX
         IDYA==
X-Forwarded-Encrypted: i=1; AKwUvBwCKONo926P+97IAQ55HrRIyNP+EWHErtkcTVfnhZPA9YeGShFT0RS/YQn/9PMysdyxun5LJ5zvpbbONB5zKg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKNHjkM1cCHSxPIMBc4W64fWCrfRQ/5JmMtqcMHnUGg9SzpMJ9K
	p5M0glTrviGNGzedouhRMMssWpWFVBU6MZNDK1zs7+xbpO8gtjbWLubf7jqGmsUa
X-Gm-Gg: AYBFou2LoivmRu1s1whAcojAeuzXlL+6q2g9i1zjuie6SjKr69lz+ZE6iQko5y224Bc
	oU3tBEZRacQHCvLlFVlZapxVz6bm24qgV4TreD8Co3CfN1/jcnq1UE0mKWcSPEUTYgixhVDo+VH
	AIKN3Tk2P5P6Nb6Vs4BI1MT7xWfkSL9oXX+/6UXcRJ+1O1ZjD7sscSEVGoNPTPypuB7rftwJ19A
	BDWqb2BL3A9T8Izt/EUCYHx30DNIEuU7dmI0mjvWwSvblF5OhggzcOyxJRTTZ8b/GG+rvReEFtJ
	fwgxjz+1xgAiybPzUT4jWds3eQHZICeYDdhY8ukBdJybPyJkNOtQ5Bqpwc49eSeQgh6vF/32oM5
	QQtGrJFGq9e3/82+5eJQhe5m8lz5KGN7RXXgQqiKC0Q2cpCPW/7pyRS2Im60KCYE3wqHPQq5FRf
	gu7I4s5jLG0R+alEJKwl00lAWf5OCN97QpG5QygiqKt65RmL3fQqtecL3XDmfLilk/1ixtsWEKs
	4tW81oq3w4iVz845Pt16QFRPDWyUAQ2Pys=
X-Received: by 2002:a05:600c:4e11:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a1d75f24b4mr211056285e9.9.1792489250061;
        Tue, 20 Oct 2026 02:40:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2cdc342sm64517275e9.13.2026.10.20.02.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:40:49 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:40:48 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas.weissschuh@linutronix.de>, "schuster.simon@siemens-energy.com"
 <schuster.simon@siemens-energy.com>, Ley Foon Tan <lftan@altera.com>,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH] nios2: ksyms: Declare __mulsi3 export
Message-ID: <20261020104048.7b038bdd@pumpkin>
In-Reply-To: <c32b7ed2-fa3f-4a58-9300-21efcc88f056@kernel.org>
References: <20261019-nios2-mulsi3-v1-1-4fd75b1bacef@linutronix.de>
	<47eb6b48-d664-440f-84b6-ba09f34d5e08@app.fastmail.com>
	<c32b7ed2-fa3f-4a58-9300-21efcc88f056@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Post: <mailto:linux-openrisc@vger.kernel.org>
List-Help: <mailto:linux-openrisc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-openrisc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Oct 2026 09:34:42 -0500
Dinh Nguyen <dinguyen@kernel.org> wrote:

> On 10/19/26 06:16, Arnd Bergmann wrote:
> > On Mon, Oct 19, 2026, at 11:49, Thomas Wei=C3=9Fschuh wrote: =20
> >> GCC may emit libcalls to __mulsi3(). As modpost is not aware that this
> >> function is provided through the linked in libgcc, it fails:
> >>
> >> ERROR: modpost: kernel/locking/test-ww_mutex.ko: symbol '__mulsi3' und=
efined!
> >> ERROR: modpost: kernel/time/test_udelay.ko: symbol '__mulsi3' undefine=
d!
> >> ERROR: modpost: kernel/resource_kunit.ko: symbol '__mulsi3' undefined!
> >> ERROR: modpost: fs/fuse/virtiofs.ko: symbol '__mulsi3' undefined!
> >> etc.
> >>
> >> Make sure modpost can see the symbol from libgcc.
> >>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Closes:
> >> https://lore.kernel.org/oe-kbuild-all/202610171933.J4bFOfL8-lkp@intel.=
com/
> >> Fixes: 2fc8483fdcde ("nios2: Build infrastructure")
> >> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>=
 =20
> >=20
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >=20
> > The patch looks correct to me, but it would also be nice to not use
> > libgcc at all. What I see is that only arc, nios2, openrisc and
> > parisc still link against the toolchain-provided libgcc, everything
> > else uses the kernel's own runtime.
> >=20
> > It's probably not even that hard to do right, here is what I found
> > is imported from libgcc.
> >  =20
> Patch applied!
>=20
> Thanks for the suggestion Arnd, I'll work to on the NIOS2.

Does the kernel support nios2 that don't have the optional multiply
instructions? (including the ones that generate the high 32 bits).

If the compiler knows they exist (it isn't the default) then it should
just use them.
The fpga almost certainly have plenty of 18x18 DSP multiplier blocks
than can be used - so the resources are there.
(The slow part of the multiply is actually the ripple adder that
generates the high 46 bits.)

David=20

>=20
> Dinh
>=20

