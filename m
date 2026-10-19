Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15AF3EAC84
	for <linux-openrisc@vger.kernel.org>; Mon, 19 Oct 2026 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408625; cv=none; b=m9efpEWCNg3xs52kPB29IfN9bkXaSDt5fjaG4YPpcgkLvCSoZVkjns7uXe1ETZVISQE4meWXYdmaYesqneBtTx4NmnSql6lBArgNF6As8uF8uR2Dn/oju3NFq7tBMJ1fSVWXA7YRhqvs4kaQn7zZxerp0yhVrqA3W2n0AmqU3L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408625; c=relaxed/simple;
	bh=O+NWByob2gVZL0+tsbFgHWpFXaQuqITlhKc4tDqFErw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=o4RBcL2lYNmj3ajHZTnf88jVCOhqGsVX0ZexCBrSlIYjw3wnqe2edPwYARhgNpdH8GsKO8lyzGwZwpfhKUPz3sF+KcoVN1e73KKp5Bs4wzCzL7cEvGagMZ25SFbdRGeWYApwarltegZvnbkiwx65m7IuJhAOPgp0khpzXOmElOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=b9d7dDhE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rDB3KOnx; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="b9d7dDhE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rDB3KOnx"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9ED017A00B7
	for <linux-openrisc@vger.kernel.org>; Mon, 19 Oct 2026 07:17:00 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 19 Oct 2026 07:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792408615;
	 x=1792495015; bh=zgLYa/JnxT/8EIQ/TE2CX6B+wBarwWr0qwjQhA9dpNI=; b=
	b9d7dDhE9PatOGwZBYyfkXv3N3OjEFxIPcP3FItJP4pZeMhgK9InPcYIaBjpDOtq
	d+FKaldDcFyG6HsPEjdruPhwf/rhWdfenmcIQWxN2M7Qn/QKcI8AJNgw8nolYIsK
	DTGExytUlEnhp0xBt81fHxzcRUQ9oCHG8PuzUQexVOfVA4fjfkUuRksqs1admKbs
	nWP33JQCAWF1VOnM6wk2x0CzGkBRr+r4SVb9HkWvNtPmGYwfN/FphQzxzd0s++3A
	mFF1EdItiemGEvO0PN9jQm7KUeA7lA8kx2MneLi8J/VERryhqT5TgcdoOBSDYzaV
	6MaLNbD2m+VG+U0SyQkkEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792408615; x=
	1792495015; bh=zgLYa/JnxT/8EIQ/TE2CX6B+wBarwWr0qwjQhA9dpNI=; b=r
	DB3KOnxG8B8v7pIH2IVJwBK6wpdcjQl1Rr5eZjm2eVJrvU5Eel78XLQOP0QWnl5E
	VFct/6DAZOU7ozsnfU+nPmpi/4U7dOqcDpa2PGLigpf3dPKyKFb2sizoCJlzxZcA
	6638nm7LgI41Jp+ElTp6OxN/jc/Kbh8MMLGcY9k2/97fn3esDoMvy90+ZxS6w+Hx
	Z8uS2qNH1IBsLVryeS6ciLmyca0GOMJGu34urEui/ka1AgkUoM8l06jxVNhOh+Or
	AA9YfqAuZ1WOCOAGqL5n/TzJYcmxumjxhJYJn+iQKVmeNEGCrJgHJYdDHRt2AxRw
	9c53KgKiX/V700NJvz1IA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792408615; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LW9wZW5yaXNjQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:AxLY+kr7UjvFIcdZi8wKr4ndID7kNAk7rKSr/Di78zb1221
	zd9Dr2v41Hp0nbW9YrX9ePn7ur6N6YfrbsQOZAnCVZnwsiwmsL6TxYUMwc+24dqf
	mSP/MKhqMydHZOsu8pBAWtuuopZncIPt3j5mVUvzwR2+cmIDnrjF9lc2jXVZlMtU
	orvDlqux3XdBEmzcuU53yyjspntp9fKNdZ8Mn8LOn00CVlAFtChcpx4p2qIdpJAp
	0MWieVz6z69EM04XH1/yzMV3x9LdBDoNvfO8FIN4flqnIGSfY06nDkfpvYkgQZFK
	cs8rd17E8m+9VOqKu7vX6ycK8FPy90GZMcbk70w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zJKx6kBh4q2kkDyKsibzk02wNoyknxOpIXYcNiMoR90=:O+NWByob2gVZL0+tsbFgHWpFXaQuqITlhKc4tDqFErw=;
X-ME-Sender: <xms:I_zVarT5Lgv-2DoJUZgLQMZFY97RfuFlkPOeDxLbChcpwDkB2Qksvg>
    <xme:I_zVannd1hxnR8nmeYawmXognSuRkBoL3a_hs9rbym3hZQJt8IjFV1glt28N99gQY
    fu6w9bRmiYXB-nWDWe1G6hFJ-SghD1tmgYdCicUU8KWRLCeQT4tpufs>
X-ME-Proxy-Cause: dmFkZTEePN2YjTBxNqBq6SGh7R9IGsuxzB9KQLpmOmK8t2xw8fGIOVtNR0QZoXk1P/Q/g8
    OZkIR4pW2xOs+HI1XHcf+t3+iGN20YB/VTDRi4vrloTts1K8NgzN7aN5327SNIuAdTv0Q+
    5Ecv0zod5j88/5rvNstwTWrgPmUQCScJJlL6HsmGB9E4+Rn5sVUO3X32XsclpFyb50Vsmf
    MDGOrh8xHZmUqqduCMKeCeXdnrT2XpHr1ajdCNwUikRiFq8J+7h/2XWE5S/qFlSpZPUwBe
    o5UPjj51lL0iGsTrdo2NNCpri1PwEv6O2DvJpnWeqk2HX0AGUcLvuxKBmaeeuV7JCfy3Z7
    6NBS/rrbaeTm8NwGyEwtTfVp0wMI6Cuf5GhOq1BoBYD/8a1ZoTEJtGZcAYkueo0jSq/zzA
    Y9V6WDXeM6wQrG9B9vYcuphhepJHG4ekCh1ZGYTOetk22buwMQVjBMyT7CUsS/LwXo/+er
    /Df7BxOS2YRh2E+zDNem3o3CNOV0C9PEX7Jy3k33LXVU7hSMkZ3wopMqF3jeHmDEcFrNWM
    Mlj3yB6zOtWaruwSGlFZUK6WV66erjBVjCEyUskQ3owvfv9iiLHZAFfvWIoEvsuQ3AU+SD
    c0pGq6O1qaHeG3qT88Uu4eqisdG9ZLZhSAwYM8log1bxF8ZXMuAO3rMqC+DQ
X-ME-Proxy: <xmx:JfzValXUnZpTpDusRZV1vLvtQNbAWaxKSU_Ak8W6Lc_-sq4oelrcog>
    <xmx:JfzVai-ecXK3lnBb4vQ-CR1vgF378ComkXeXPHiPsaIpauZrZ1Bx-Q>
    <xmx:JfzVaosL1TyTy9XB4kT8GI18YvMZt0yb62eACVS7DlxHs2B85iIcDQ>
    <xmx:JfzVai01-RAq6QmJxGw7hgGwPqm4wTvrzdsD_gLN5rNWuOW874IkTg>
    <xmx:J_zVajy6JIXpwrovofzYrk4T4uBzCgl6TpTFIuJIaSYYt_YkaFgkYAtw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 6352A32A008E; Mon, 19 Oct 2026 07:16:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2HaaWELKR9F
Date: Mon, 19 Oct 2026 13:16:14 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Dinh Nguyen" <dinguyen@kernel.org>,
 "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>,
 "Ley Foon Tan" <lftan@altera.com>
Cc: linux-kernel@vger.kernel.org, "kernel test robot" <lkp@intel.com>,
 linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>
Message-Id: <47eb6b48-d664-440f-84b6-ba09f34d5e08@app.fastmail.com>
In-Reply-To: <20261019-nios2-mulsi3-v1-1-4fd75b1bacef@linutronix.de>
References: <20261019-nios2-mulsi3-v1-1-4fd75b1bacef@linutronix.de>
Subject: Re: [PATCH] nios2: ksyms: Declare __mulsi3 export
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026, at 11:49, Thomas Wei=C3=9Fschuh wrote:
> GCC may emit libcalls to __mulsi3(). As modpost is not aware that this
> function is provided through the linked in libgcc, it fails:
>
> ERROR: modpost: kernel/locking/test-ww_mutex.ko: symbol '__mulsi3' und=
efined!
> ERROR: modpost: kernel/time/test_udelay.ko: symbol '__mulsi3' undefine=
d!
> ERROR: modpost: kernel/resource_kunit.ko: symbol '__mulsi3' undefined!
> ERROR: modpost: fs/fuse/virtiofs.ko: symbol '__mulsi3' undefined!
> etc.
>
> Make sure modpost can see the symbol from libgcc.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:=20
> https://lore.kernel.org/oe-kbuild-all/202610171933.J4bFOfL8-lkp@intel.=
com/
> Fixes: 2fc8483fdcde ("nios2: Build infrastructure")
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

The patch looks correct to me, but it would also be nice to not use
libgcc at all. What I see is that only arc, nios2, openrisc and
parisc still link against the toolchain-provided libgcc, everything
else uses the kernel's own runtime.

It's probably not even that hard to do right, here is what I found
is imported from libgcc.

* Generic library helper exists, can be enabled through Kconfig:

=3D=3D=3D __lshrdi3 =3D=3D=3D
arch/arc/kernel/arcksyms.c
arch/nios2/kernel/nios2_ksyms.c
arch/openrisc/kernel/or32_ksyms.c
arch/parisc/kernel/parisc_ksyms.c
-> lib/lshrdi3.c
=3D=3D=3D __ashldi3 =3D=3D=3D
arch/arc/kernel/arcksyms.c
arch/nios2/kernel/nios2_ksyms.c
arch/openrisc/kernel/or32_ksyms.c
arch/parisc/kernel/parisc_ksyms.c
-> lib/ashldi3.c
=3D=3D=3D __ashrdi3 =3D=3D=3D
arch/arc/kernel/arcksyms.c
arch/nios2/kernel/nios2_ksyms.c
arch/openrisc/kernel/or32_ksyms.c
arch/parisc/kernel/parisc_ksyms.c
-> lib/ashrdi3.c
=3D=3D=3D __cmpdi2 =3D=3D=3D
arch/arc/kernel/arcksyms.c
-> lib/cmpdi2.c
=3D=3D=3D __muldi3 =3D=3D=3D
arch/arc/kernel/arcksyms.c
arch/nios2/kernel/nios2_ksyms.c
arch/openrisc/kernel/or32_ksyms.c
arch/parisc/kernel/parisc_ksyms.c
-> lib/muldi3.c
=3D=3D=3D __ucmpdi2 =3D=3D=3D
arch/arc/kernel/arcksyms.c
arch/nios2/kernel/nios2_ksyms.c
arch/openrisc/kernel/or32_ksyms.c
arch/parisc/kernel/parisc_ksyms.c
-> lib/ucmpdi2.c

* 64-bit division probably should not be provided on arc or
  nios2 (and sparc32, which has a private copy).
  parisc64 should get these from libgcc/libgcc2.c.

=3D=3D=3D __divdi3 =3D=3D=3D
arch/parisc/kernel/parisc_ksyms.c
=3D=3D=3D __udivmoddi4 =3D=3D=3D
arch/nios2/kernel/nios2_ksyms.c
=3D=3D=3D __udivdi3 =3D=3D=3D
arch/arc/kernel/arcksyms.c
arch/parisc/kernel/parisc_ksyms.c
=3D=3D=3D __umoddi3 =3D=3D=3D
arch/nios2/kernel/nios2_ksyms.c
arch/parisc/kernel/parisc_ksyms.c
=3D=3D=3D __moddi3 =3D=3D=3D
arch/nios2/kernel/nios2_ksyms.c
arch/parisc/kernel/parisc_ksyms.c

* floating-point math should not be provided by kernel:

=3D=3D=3D __divdf3 =3D=3D=3D
arch/arc/kernel/arcksyms.c
=3D=3D=3D __divsf3 =3D=3D=3D
arch/arc/kernel/arcksyms.c
=3D=3D=3D __fixunsdfsi =3D=3D=3D
arch/arc/kernel/arcksyms.c
=3D=3D=3D __floatunsidf =3D=3D=3D
arch/arc/kernel/arcksyms.c
=3D=3D=3D __floatunsisf =3D=3D=3D
arch/arc/kernel/arcksyms.c
=3D=3D=3D __muldf3 =3D=3D=3D
arch/arc/kernel/arcksyms.c

* no generic implementation in kernel, need to copy from
  libgcc/lib1funcs.S code:

=3D=3D=3D __divsi3 =3D=3D=3D
arch/arc/kernel/arcksyms.c
arch/nios2/kernel/nios2_ksyms.c
arch/openrisc/kernel/or32_ksyms.c
-> arch/arm/lib/lib1funcs.S
   arch/m68k/lib/divsi3.S
   arch/microblaze/lib/divsi3.S
   arch/xtensa/lib/divsi3.S
=3D=3D=3D __modsi3 =3D=3D=3D
arch/arc/kernel/arcksyms.c
arch/nios2/kernel/nios2_ksyms.c
arch/openrisc/kernel/or32_ksyms.c
-> arch/m68k/lib/modsi3.S
   arch/microblaze/lib/modsi3.S
   arch/xtensa/lib/modsi3.S
=3D=3D=3D __udivsi3 =3D=3D=3D
arch/arc/kernel/arcksyms.c
arch/nios2/kernel/nios2_ksyms.c
arch/openrisc/kernel/or32_ksyms.c
-> arch/arm/lib/lib1funcs.S
   arch/m68k/lib/udivsi3.S
   arch/microblaze/lib/udivsi3.S
   arch/sh/lib/udivsi3.S
   arch/xtensa/lib/udivsi3.S
=3D=3D=3D __umodsi3 =3D=3D=3D
arch/arc/kernel/arcksyms.c
arch/nios2/kernel/nios2_ksyms.c
arch/openrisc/kernel/or32_ksyms.c
-> arch/arm/lib/lib1funcs.S
   arch/m68k/lib/umodsi3.S
   arch/microblaze/lib/umodsi3.S
   arch/xtensa/lib/umodsi3.S
