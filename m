Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE27E4EDCB6
	for <linux-openrisc@vger.kernel.org>; Tue, 13 Oct 2026 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894965; cv=none; b=GHhZC7T4P1niCsrnc8oSp+C0haAMTmoVXIVs9eVAfd6vCkS1W/xVkDHXseuO+9pABUtnu5iorUdVCByT1cu5F2rx8dsyzB0RiiX+UX6963do6LYU5vmklKkR1v3uxhTVDeakrEBRO3AN72Lf7vUHjlScaYFv0YalQOA16oKw5gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894965; c=relaxed/simple;
	bh=KJz0ljhpxQV0dxuLmyAZzCH6KN1a+1DHS+L2+lDvs9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TnVQko9QfJmpHmxuzdC2YgudwNtvpSTz55XN2bEk+IEyfOvgVDr9aOqlifsYw4qfbxmFCtyatZO7hjQE2THLkgoyznxL5y7/g/2xFmm8Y0OKMkrt8vtr7TH7fGT4cvXMqXb7X67kjhrK7PLh4HNzBN60t8cwb3rFP6L300Wjg1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dfwSn7zu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfwSn7zu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791894962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ooKLa1R3KGvywNv1R+3CFpG+InkWtGBVvbQRUtpRSf4=;
	b=dfwSn7zuZu81ewqBOOFI/l9xBxfYJhLUcFdAPbnSmoghiBOkFiERe/7H8aC8j/8PUFnFxh
	hUEDo/0FrspbXA/QllExBFUWPEDUX14/KIH1NCYfGCUalH8BbQhjiAXAvmcIhVnRttbg9R
	J1fIDjF29+kS3QGm0E5Cg8ZicDZJ6dY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-Z2p5G4AYOWe1u3IIYKVRlQ-1; Tue, 13 Oct 2026 12:36:01 +0000
X-MC-Unique: Z2p5G4AYOWe1u3IIYKVRlQ-1
X-Mimecast-MFC-AGG-ID: Z2p5G4AYOWe1u3IIYKVRlQ_1791894960
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2e71425f87so321546766b.2
        for <linux-openrisc@vger.kernel.org>; Tue, 13 Oct 2026 05:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791894960; x=1792499760;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ooKLa1R3KGvywNv1R+3CFpG+InkWtGBVvbQRUtpRSf4=;
        b=QaIAjh9XVNWbq3SxkP6f0hPG7g2XJLtXh7lqDx97UHELlhcJYF+8xlEiCs9x8cdQOc
         8kMOTLWdEbUc4JXfgpEwnyZjKJ5sWfYtx8nRcl4lBLvkPcUSZP9RHEp5JURQfyDt3upr
         0L8QHOIlhOoc6n+eeDmt05BcPBHSaR0M4TlGr+jzPJEntMZBn9oLKlrrdfIJswK8j6g8
         4yBy96+6kzWCXRURu/OPHcbP117L4qOok8sZM88xtdGs67R3SpM6/jw0X7F2rVBRJT++
         fSDjJbyG5oO+eGIyw4SZZlasXZRDPvtnFlYWlbEO8ZVfyrj2FMMlYlbqIz/GwF5fOPtt
         dtlg==
X-Forwarded-Encrypted: i=1; AKwUvBzDD6xIQDT9NulxBoztrj3QpS8fxvKPRQFkQe6BkLj1n3Dz3CBqkHwTJEjQyn5mH2MAbaPLhDSsSYZf37fqwA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKy9Q2QmN2CpX7Ir77n9krVLnMQY/Mllbk3HYMfoYdNDJ/WdYUB
	Hhrk+sIgM60K1cnGcJdP8pSGp/lLhSLz6NHbjvzEz4PEaEs38TfWRW5i2b+07evTfne/gmmywdw
	F3Lu+qTeXwUKtRrO7lXt41a1fpft8SDMGADFIzumPLBEfFr1FP0tH324nxos7k1dNPojhZjM0ER
	mWCZJMj8iXforO6/xf8ppDpNCI6khtzqIXnGHCp1IIBr8=
X-Gm-Gg: AYBFou1u85zPGIOGhJVd1gGoj6ajjcckIE5cYVuLvILDHilcI2lCtw4jSfOaK0iNdrg
	M5QXYM5ckOuK9/K0tc/s4RFIUyAd8y9WNBIKzVpN2ZhwCOJdAUy+iJvdjTg8NVCYpxDFRRTpYH0
	Pi62PdqwdGSt7623NcajgEYrWw9GvB5gneGdGJftFOlynJXpxZJau+4cXYiXj9ZVD0lvHeuM5tq
	HufoKF4lWbLxgJ+qJA+wOsShdaU6RbIZFRt7b2MsMkyxB0qsoPQ+HGkuToYp9yUTPNnGy+RKG9P
	qNM=
X-Received: by 2002:a17:907:7b8a:b0:c2e:1b4d:e9e9 with SMTP id a640c23a62f3a-c31a9f6ade4mr1135545966b.30.1791894960279;
        Tue, 13 Oct 2026 05:36:00 -0700 (PDT)
X-Received: by 2002:a17:907:7b8a:b0:c2e:1b4d:e9e9 with SMTP id
 a640c23a62f3a-c31a9f6ade4mr1135542366b.30.1791894959880; Tue, 13 Oct 2026
 05:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
In-Reply-To: <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 13 Oct 2026 09:35:48 -0300
X-Gm-Features: AclHuK-0QABZ6yrPwALI3VDGc1f2HfQWIB06SZ96BvTfEuUJkskwg4GU5NbIk1c
Message-ID: <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Paul Moore <paul@paul-moore.com>
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
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dGLtzIYLFTQ5VhwlTg2VFCfzrS2QwGNn5xIQ7-6shjo_1791894960
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> >
> > The SYSCALL record currently logs only four of the six syscall
> > arguments (a0-a3), silently discarding the remaining two. This
> > leads to the need for auxiliary records when audit-relevant
> > data lands in the 5th or 6th argument of a syscall.
> >
> > This series extends the SYSCALL record to log all six arguments,
> > by adding arguments a4 and a5 inline within the existing record.
>
> Thanks Ricardo, this looks great!

Thanks, Paul!

>
> There are a few things in some of the individual patches which I reply
> to in a minute, but there are a couple of "global" things that I
> wanted to mention:
>
> * As pointed out by Sashiko, when you were converting all of the
> arches, it looks like you missed alpha.  I took a quick look and it
> appears that it should be a pretty straightforward conversion like
> most of the others.

I've actually dropped the alpha patch as per Magnus's request [1].

[1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4BL=
WOvDTt92t5Eg@mail.gmail.com/

>
> * We need to get ACKs from all the various arch maintainers.  Aside
> from the parisc changes all of your arch specific patches are trivial
> (and cleaner than the existing code IMO) so I don't expect anyone to
> complain, but getting ACKs will likely take some time.  Even the
> parisc patches aren't that bad, and arguably they fix a problem for
> seccomp so that should make asking for ACKs easier :)
>
> Since I expect chasing down all the various maintainers for ACKs will
> take a little while, and I'd like to start getting this patchset some
> basic testing, I'm going to merge it into dev-staging now.  While the
> dev-staging branch doesn't feed into linux-next (this isn't likely to
> land in the next merge window) it is one of the branches that gets
> tested automatically and included in my kernel-secnext RPM builds.
> This also means you won't need to worry about keeping this patchset
> up-to-date with rebasing, as I rebase dev-staging as needed (it
> intentionally isn't a stable branch).  Going forward, if there are any
> minor changes to this patchset, e.g. a few line change in one of two
> patches, please just send a fixup patchset based against
> audit/dev-staging and I'll squash it into the relevant patch in the
> series.  However, in the unlikely event that a major rewrite is
> needed, just send a new patchset ... but I'll be very surprised if
> that happens here :)

Sounds good!

>
> --
> paul-moore.com
>

-Ricardo

