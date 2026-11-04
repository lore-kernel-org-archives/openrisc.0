Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793752864;
	b=dgK/61SF0CGTn8FnR4zqh5D9x4W2oBFWo8h0B8pcygjJiLFyOa03hR+KkjK2Cm4lCZr1
	 8NovWCpRjomDr8gim9mN/P1hMzUcqeE9FhzG1Y35VbJ8vLnhLsxJnt3S1rryDjIryWt2t
	 QuCP59IM+xl7ddeO3Ma0C7YAidhUK5S5snrP28+6+wUA7UNofVgxUCKmir5T3CsK9+SQi
	 dyuXGAPIAsrj1oAfRNJOEz0Vv+7O44H/fyWv828zBikXASR5deZH+LBS8g8e9V+K8j/Cb
	 amW0TdR8qqUkLAjPu47A41rsQqD80WvJ5HWPugbOB72PJ+EEfs3bWgescEhJrcqj/CQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
	b=3Hq54+nktDd87EkjH2t+faMBlFWa3ppAu3gXe0/VGZhsod3ry2van8w41I+0e05wLtTc
	 7hc6dN6BsLnvSoFAq2WHgqblC4nFyakRdPZPl/iUKAwd9du0B538ERfBZ52U8LLjj0jl3
	 BDxWnyMoOfwfOMWJNhyioDSbWyxfqYv5ENEzSIoktr7jzCyWGhKeDkGRfheq1oCOXqOVb
	 Uqlh6X3/Jj767EUgS+gbI14oplsgc9r62H99nLpQcgKySwj+i3KFsP5/pyCb9pS0hl+yV
	 n5+KVXxE6yuG+1ShFxHUNLLCgjMCuH7vxgp2tXS+VfyNxCJU2F+4UT7JXlI1Khwd5Lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=PTPniKxw;
	arc=fail smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD411606A32D
	for <linux-openrisc@vger.kernel.org>; Wed,  4 Nov 2026 00:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD411606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=PTPniKxw
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso80819b3a.2
        for <linux-openrisc@vger.kernel.org>; Tue, 03 Nov 2026 16:41:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793752863; cv=none;
        d=google.com; s=arc-20260327;
        b=KKV8cehyp4kEwTM0j8zxaRhpOm1+K1s80h/3R15DPC/a9D5TPFhlyFe4Fr1jm1hXHH
         NvMuL7LmbpyPnKGxGsCdNpfQLWP1uYCYzrHO7W6yaPHwuJQ/tbAhq2e5PYC12kJ0rfx2
         FA2QKYXrpVmfxMQqLD+knbjB3t0YMQOM8MctsTCHpXj70PucuDGRSJK/udW+xaATWDl6
         efpoBjHzHGG0ui1JZi7XKnJgzgh1N4Z9qFbhooiUm6GA3b1cb5h+fIrt2aRFrFuzqH8t
         7XV+44ZhfHl4fexCiGDA0iSAxsHc7bGp6C0hwPQ7r17Piutu5eqnuQGePt8XJB+7YSvC
         KZ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
        fh=HtaBNLnOkuOFI2dHH2/W8O+Kv6+vUoQjEi56lq7x+rI=;
        b=BmUO8HxqnT9oX0PuZ8T795hgxUdeoly6ozww6fuokeAJMN3GS1K2bWjjkSNntbPpQn
         WzLdvvrnqQO8f++kdtZKykXBCV7jPThA1mAbN73wSIwx5kJqrHFWVzKUI8YebVpa3FsW
         htT9G44TXnkOOqY5Ouza2JxQK4YRJ2eEVc4BV3jP1m71lbJez31L1nncg9p4ideZffLs
         Fwq5116N4niSQ2QY0ngqe7msiWAG3eTvGFXeTiPO6Hp3a7DxQthisVdrckTL+R5rUEbG
         e6E/vI8ryezh2TV+SepPhDUHr1hRjgEXibGFxSPEIT4zWRPxsvrYNk/vZ3zkhTpxZs8i
         iaMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793752863; x=1794357663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
        b=PTPniKxw8lSLWSxMbmhmXVodXffwfFqC3M3cDEPYPvY1SsBjNOjXXv95CLFg3rVQFu
         x1tdyRAr0bqYQ6HVqsjHpfPPU10/1FhE3kd/CHXKlKRa2s8Jf9/RWGaRvSd9s3tWp3+h
         Tji6Btj/3XlTUrwGPe+aphN7moDM3Ujmyews2MtwEsOdhWo9d1B27IQnIAXxeCj/AgoF
         TwCZd9YYNW98ENSoBC4GvFAhash4XN0WeHulLfX/snYculqtKEVgWcaAWPf68LjYBfvq
         i5NzGzwAog4kKLckyYK3n2IY4tOHLEWiT5cJSG6dbW9SW1FZ4MjXmEMstZ0yw7BaSVW5
         5qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752863; x=1794357663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
        b=lbeyFdvcmw8JdIJ/wtz4NGCyn5SFHpQK/evC+YmxFuC58Uhud29klos++xws51z8LS
         Iyg6L52R1YGvps9agp9sFDy8anJZwnlAn+EhmXUk20mIqklgiXJ+7u38LLq9LdxjjbAs
         xmm67+hiYLywABbQvLtdYf/IiXOdgIwU/TqtY87Mj9zQeTAbKKdN2s2DD4vLqaKhMnf7
         oxFAkrB47QOQuO46Y4kbwxLdjjXqo5x35FicDj9fgnt7NV/cBjPab86LE6N3gNXxwyCQ
         Y/g6e44Lm3Uhm4DTq9tA7j8C93P+qj1iEulXYF5VggZceHUaejHNnI1zBN2u2nMOsLbq
         ngtg==
X-Forwarded-Encrypted: i=1; AKwUvBzT7/KkOTuOdqyuCtFc2qrpuzNfkkBu07U3zbaHlRiGneMl6XGkkRrQ/YDplI6WfF5F0uArldHkNylpSxNpqQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9PBMQl8pXc3svUTINpkfcoxMvDstd476oK6KdMSF0hAiHz3i9x
	YK+lAngfAwq2tPGJwES2NSuQ5C4Kr99a2Hh0i8Q70WINHSdmRz65JNgWN0EZGrkIVIoLFKFqYO+
	yPUXoXdFukZmJrWcp6Xam8tp9jbjWRbYr3FlpqBae
X-Gm-Gg: AYBFou1+OpCln+2n2Io2s6bVlN2oC3K/YlGbTNmf/WzyUxPgYeqObGpMl59oZzmioE4
	n6g+Z73bknBuwY5kMUUIzS94FdBCgFOt6S5HLB9gA93HQEj33LEIy7465Tu50sVCnisuUmkRi8w
	oyMss7kiOY+8nMmhkLcdYzUUzdpe3D/zSGDkYQ3UsPm61mStfvmuiMz04FezPSwmG93gODJWhxZ
	QKe/+XxXG1xeuitQ6zFKDY6nBOEwxjpctGezryA2I5S50MiAxOizuFSDoNezJ8uEyE1KoQxawB3
	YjP4XpxNSr44pQoPz9R8pfvOio4YC5B5J/hdHvumahyK3qJVogVOjbFFxZDPE8hc+fn3j3MQ4gb
	rhronycGNdQonwxjCudySKxhNozPPGmL6X1BJwqSVyW4lYFckB1Xv8q22csc//hVDUKa6
X-Received: by 2002:a05:6a00:2d96:b0:88d:4b30:1c11 with SMTP id
 d2e1a72fcca58-8a9ba703bc9mr11394030b3a.6.1793752863107; Tue, 03 Nov 2026
 16:41:03 -0800 (PST)
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Post: <mailto:linux-openrisc@vger.kernel.org>
List-Help: <mailto:linux-openrisc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-openrisc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
 <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
 <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com> <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com>
In-Reply-To: <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Nov 2026 19:40:51 -0500
X-Gm-Features: AclHuK_mzIhdjHPxjnkTYRthyfMgrzjS55JZuNf6mZPYYsQQvO81kKGlvJUv8_0
Message-ID: <CAHC9VhQ4U-Z2KkGurfMihJgzGgwD3miWSW4wWAjWvUdDxLpH7Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 8:45=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Tue, Oct 20, 2026 at 1:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redha=
t.com> wrote:
> > > On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@r=
edhat.com> wrote:
> >
> > ...
> >
> > > > * As pointed out by Sashiko, when you were converting all of the
> > > > arches, it looks like you missed alpha.  I took a quick look and it
> > > > appears that it should be a pretty straightforward conversion like
> > > > most of the others.
> > >
> > > I've actually dropped the alpha patch as per Magnus's request [1].
> > >
> > > [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phd=
BKy4BLWOvDTt92t5Eg@mail.gmail.com/
> >
> > The problem is that as things stand, this patchset breaks the build on
> > Alpha.  Perhaps this gets resolved during the current merge window,
> > but as you know we can't break the kernel build ...
> >
> > https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel.c=
om
>
> Of course, you're absolutely right that we can't break the build. I
> was afraid that this dependency might cause trouble.
>
> I noticed Magnus posted a pull request a few days ago containing the
> "alpha: enable GENERIC_ENTRY" series [1]. It seems this will get
> resolved during the current merge window.

... and it has, or at least it appears to me to be resolved.  I
rebased the audit/dev-staging branch against v7.4-rc1 and Alpha does
indeed appear to be using the generic syscall entry/exit code in v7.4.
I think we should be all set here wrt Alpha, thanks.

> For future reference, what's the best way to handle dependencies on
> other subsystem changes like this?

Generally speaking communication and coordination :)  Talk with the
subsystem devs/maintainers to understand what they are doing, let them
know what you want to do, and find the best way to order things so
that it all lands in Linus' tree without making a mess.  In this
particular case, with the syscall arg audit patchset not being ready
(missing maintainer ACKs) and the Alpha changes going into v7.4 it
turns out to be quite easy, which is an important lesson: sometimes it
is better to defer a new feature for a release just to ease the
coordination burden, enable better testing, etc.

--=20
paul-moore.com
