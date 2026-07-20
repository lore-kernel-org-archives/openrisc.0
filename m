Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071D4439349
	for <linux-openrisc@vger.kernel.org>; Mon, 20 Jul 2026 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584879; cv=pass; b=OGGOoOAJtBVVoUQF9cH4WbdJCH/mB7KgP/LWCtxoHPmYUKsc1qtebjB9s948oAIH4QfLo8c29ZiCT08ynSEaP06zrjmgIPnxbWlpn4TMYCVjQN8ej9c9oMRK+zQGWNiI1j21fp5F8zwo9nNVN7Q9q6zfXDJMEd7ym6HVv5ElXpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584879; c=relaxed/simple;
	bh=j/7Pu0goIzrDPISYd7UGXNeACZWMCvQbsT7AmxUh2RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7fkT10uo8fQfVOzj+v4+GU4sdVC1rhfoFUs56ELFFldLuQ3LEGw4xwrtqdXITmSZbHzbkCr/VBufMVNXSfQlecAsCtgz4IVxjqg/b2HVOLmjP4ItjxvtO5PitEjHZ7XMgDtrbTV09mBQDmhpvjPSGjqDhHDs72k1tWu1zZMnXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMey3lva; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMey3lva"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-698bf053053so11991055a12.3
        for <linux-openrisc@vger.kernel.org>; Mon, 20 Jul 2026 15:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784584875; cv=none;
        d=google.com; s=arc-20260327;
        b=Y7VQ1sPqep3j3IfiZcM9haYZhDK1vF1787uyOPLUiMKt3/TaXlGDW1yjW4l7FHiWwV
         q1icMWTyMnCpR/eo4D1We+z2hDj40/HaSvJDB8Alp3yn65UDJdmAFkuoXpJx1OSH+6HR
         nbY47yYxH5D9sTfTh/0szoMbaPuYN7voUuhh/YRT36DcmQSyuyHAmpGUzqMtroIWBfG0
         hJU8U//IbynWZktXYT9x/yNLZ2aJtl3bwnqk6w5HGNccd2yBDdgsKqGc/tUJm6Hlnfc9
         MAbJlOjrAkjCI8tDuxe3ujOUBuqNnjnhJmnitCz7pRSpPq1GwWXN0YwojqZ4RxIdti4C
         xlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=;
        fh=JoXh0xRDr3yfDpTXo/C+S75Ms4+B5SWQKY6Mq3//C7o=;
        b=M0G5RMkB0Db1xYklMnLu59ajgHtCnXf6AbI05h0h22W1NKDx+Zds/3aqaAsoGlNVVW
         8qOK0qrf/Qj2f5QfVMRrxCFFh8ttIRXh8PZVhfMKI3BdtVKQGviIDl8CS9EMMKhCibTD
         gLXGJz4xcHI8ibXWjLUHGJzJy5y+7Ysun8UCN2go3frtQdJNbcDvR/bKl147rcohNeeS
         +dD+Keh4NtbZuqDLdM5wbUNFga79Lj0oRuqAuqbKnLMExxFLvtOY+mV5RJMwZegU/nNq
         Lr+fRlKY4JVWdtkw+9lFbLPOdPBsmA/1NA+MxLviFwWOkvQtxKSYfZp9/U2jz4KUW+pf
         e0gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784584875; x=1785189675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=;
        b=ZMey3lvahqP+YPW9LamnWQzczRxQiZ4wg9gw2Nu7P3y1v17JUAuMM/AR3JTiQFFKU8
         d9noasqw2G++q5S+mCeWeywDA5kpg8MuVxJjECyua9/y3jlOjzMIOYlRYZqO13STHgxR
         WQ87V1/rMYJN18KwPy7Kt1f4oO1hp7OTlSg/lmBFsB1gkADDpu+GAYd81uYxtDWFgDYj
         g7E/fCVHIhWUawA3wQ30Wot0eYDovRLDP5gkADBspVyzhS4siR8fFKxsvW3/xg6aPXXq
         4tTUNL4YjCh2lps4QkQgZ6MAQbSDaAHnlH759VBDRh1kPBksK3QYu64fJW2a6dhpi8jy
         qpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784584875; x=1785189675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=;
        b=sDsuhS6Mo0CXd3rq3531FMnsKdobBdsGVkwHMADZEFi+f2tcQ51QWjmYH7kiQSzvtJ
         rgcRnS8RcHPdJLMvmSyeEJ/YgFtW+PklxjBoXXPqEhUu6YtlcEdLzhBtYTp0eFc3/dnw
         Xq1stuHsm1CxdFGBwsVWMK3B1pFJ0U+Roqcyvnx0jP5PPld67W8yYvh96z740IyJZ3j7
         3zR60nBvXkOMgI2Kj47bhWmGuTcyIqrYovgRzUXHXJtT1C48UM6w8Glwtbx9r20r672P
         qCAyn8fqzIyKvyc74BZzT1duiJdlIwpo0qQBMoVRXbgg+ARs2g1RJorKbClqrQlZMMCI
         zlqQ==
X-Forwarded-Encrypted: i=1; AHgh+RqabThJRfwQmt/uFeKdooiD6kNPPHaSljl6KeXd5R+IN1REQ/p8E2RWck/xqysKy7NOI0qjX3KIxSIHs7UyyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuHR1SwHfrAIprOli/IMR7129+9oK3OsBPaiQRvfqJUYq/n4Yt
	5c45twpB1xwmw81FrZIkbv1vDWyBPbpPBo/4dIHC4maHpIJiK/VLBbJoeYPQGNwahqp15iR9Y0U
	C4kGJhJrmchIk5D2th+iMQcRfIQE5UQQ=
X-Gm-Gg: AR+sD10bTlO7r7RXHCE2btAI8Kh3zeyRbnsyltk3v0oQl57kM4OIAeFWIotyxzWqXNv
	i5RaC3IAEbzKV535i+cFmd9gBD0wurNboQeQXTve0Fk7oZxkIVOT74V5W+UoFKLB9V+oNbeoTf9
	jjVbwSbg8f9kaxj+UqG/KQUQ4ftPxr1CGNnTwc+pyk6VZgvRtQqtEIsLLzOv2XD7teY7DrhGsM5
	tXDC7bO0w+jDBtxzhAk47qOP2Arv1UQTcbV/PnJpxGf6CgnYddBN58wGgnQZsXzQZfsGCmV4Dc4
	6hYgUA3ixDTJuVz786DhcbzhdBN1Qug=
X-Received: by 2002:a05:6402:2356:b0:674:5b2c:d42c with SMTP id
 4fb4d7f45d1cf-69e6525c770mr6536246a12.3.1784584875096; Mon, 20 Jul 2026
 15:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org> <CA+=Fv5TDNH8+JAojV9_W36kUkEE68uiA00FQ7i0vJunebqs1sA@mail.gmail.com>
 <87wluplb6k.ffs@fw13>
In-Reply-To: <87wluplb6k.ffs@fw13>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 21 Jul 2026 00:01:03 +0200
X-Gm-Features: AUfX_mw5696pn_wiz_LjCaJHiFU9IchwhNNUbBWmuIdhtqSFIK3TJnj9-atYCBw
Message-ID: <CA+=Fv5Sd5+-K3-MOiEc2N8z_5CoLQPVPUwjiugSj3u8cBWJXXQ@mail.gmail.com>
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry handling
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thomas,

On Mon, Jul 20, 2026 at 9:21=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> w=
rote:
>
>
> Similar to what Peter and me suggested in the related discussion
> vs. s390 which has a similar issue, you can just have a dedicated
> syscall_return member in your pt_regs struct, which is preset to -ENOSYS
> and operate on that. You have an unused padding entry there which means
> it won't even change the size.
>

Thanks, that makes sense in principle.

One complication is that my Alpha GENERIC_ENTRY branch already reuses that
former pt_regs padding slot, while keeping the pt_regs size and stack
alignment unchanged. The extra syscall-entry bookkeeping I needed so far li=
ves
in thread_info rather than adding more fields to pt_regs.

So the padding slot is not free in my current branch. I can still look at
whether a dedicated syscall_return scratch value would be cleaner, but the
tested version currently handles this by setting the default -ENOSYS result
only on the no-dispatch path, after generic entry processing, and only if
ptrace/seccomp/BPF did not already provide a return value.

>
> You were on CC for the V2, no?
>

Sorry, I must have missed that.

> The whole pile including Jinjie's seccomp bypass fix is in
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
>
> and is targeted for the 7.3 merge window.
>

Great!

> If you want to base your stuff on that for 7.3, I can add a tag which
> makes it immutable so it can be pulled into the alpha tree.
>

Yes, please. There is still some ongoing testing/review of my Alpha
GENERIC_ENTRY series, but assuming it is ready in time for the 7.3 merge
window, an immutable tag would be very helpful.

Magnus
