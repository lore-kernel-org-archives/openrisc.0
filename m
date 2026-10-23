Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759537;
	b=w56PdiIfEGjVWu4ivdU76m1vImJwxRF56vxZKVfe0FyEfnd+Lu20+exTZB8sS4pvkFSQ
	 pMqbnio8u5R4BjUv3ETrt+/jqZNfQwmVJ8cNkdKX0pbLctsl9U4pZBRz1nJnPnD4s3Rnl
	 SF+B/3zEpoyISEnbhdlVaMk8VNCjgMCTUOCpKvfMHpw9ATZswTH/R/s2ICjPRsMSM1Sy/
	 VSNrLBwxcS4qI9TSz3AJ1tKNb26QHPlYawFCN7djhmwTbBqLPqSKKifYekFxfdrozkcpd
	 iNS2MEUFm3kfYA7/WNrhWpDpMHeDgTwUF12QdWBj23CL08lh15XoTy1Dhv0PQaQ9rTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759537;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
	b=gCteeda4bh1TpK+B3dNC22qL2NolSedAsjbtqvhjutgEoVkXu6AYRFclJHjpJvDLXNHe
	 QQ9UMf6Z7anobPk/U4DfQ9ib6BSbb5kd7cR6fpvg1n9jYHAfPj2uQXK010luC3bKjwjgz
	 llWAG1jMFKVwXLfsx40Hs6iI6tckPPFVVdyOqza88m1rEELH2raDvFf0mjZ8YrdT9FzKQ
	 WCl9Tjw3+FqV+5z7Pa/etaUE03G3NSFEmooo+EeMRb9wvEWpSzTzm5xsh2UrYYZTmyO1A
	 l7kcsibZgiNdYkx74wlcoe/sttvnhtu/ae32QSma14z6f3N+udyp9hyk8fhH453yE/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZsGDya+h;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534E7606A324
	for <linux-openrisc@vger.kernel.org>; Fri, 23 Oct 2026 12:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 534E7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZsGDya+h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792759536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
	b=ZsGDya+hYia2e4bY1OdxHKVGFldHwRjTpwI37YzaR2476cLuMRa2mnhCCEUJAmgKu1AXJp
	guRCCWVb/xhrL/iwSnsD46Mx4o5cyc9ayYgms2Fd+SGagERK1AlnSrT+Q5j/AqkHCw6srv
	iD/s+Dkf6dUyMf8eSR+IhxAohgVNSD8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-b2zoaUGGOwe6nYiDGpugsg-1; Fri, 23 Oct 2026 08:45:33 -0400
X-MC-Unique: b2zoaUGGOwe6nYiDGpugsg-1
X-Mimecast-MFC-AGG-ID: b2zoaUGGOwe6nYiDGpugsg_1792759532
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c42394d1e41so70589566b.3
        for <linux-openrisc@vger.kernel.org>; Fri, 23 Oct 2026 05:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792759532; x=1793364332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dw7ixUsZNlBi2ggGvaFZwX+nWP7PGBtWcR/4kzMhp/c=;
        b=g0Jvmrw1IR9+YnWIHHVEgpp4KB1z//LND5AOD1CQUbe2/RlFDQvrnl8ATqMemlQ3Jx
         LuOJXXTU0iNQwaOsZC6JZXuTNYLFj5G9cZ+vd1nIgydPNOTC3FR3VLy/g6t0h+4WndEH
         Z1/ouf2fPXnj762OA7YNPRxnoUggFpPWhf6l3WRVQhPalK1Gf+JTQnInKaZ2p8BGR0+8
         pwsyyU94g93Ybct7F/ZwXluGrBL/mG08r824ARhTqI7NohGbzMS8se+wyIZmbjzLDbQT
         YOr7Lv7Ga4sxacCVEZy4I2lCCsoXeJ1DIV0Xw0GhgHbC6Q7+1Pu6B12THokt16WdPOj9
         LpUA==
X-Forwarded-Encrypted: i=1; AKwUvBxcJ9c/s6DgK3cd9iSyhPccWyA8zppD6h8u62UDTWS8x9jCIl8bE7VWE/EAqOJzvXCJnfWupAeGD9VJ4aW88A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKt5bptqTyikuvRw5gTBqfahL9Iqr5/uryetEsypp1pf3QJ/vjL
	lYWsKyWbyINaP+wlpZ0jwJvAqczGjb3DZw8Oac6CMCeKks7WgzUzxUdHyNx9Z6e969m3MJZPzPi
	v1LRXwofHdfHJWchfryAtzr0IECj384pPsXVi8eSTOuPAff09ayUoM2Mqd1Sp8sIdxqhkbO1t2D
	dSibTfoz2g3semH3ATnJIUm9JRAc6dvAKKob5FRp4y6NE=
X-Gm-Gg: AYBFou22RQgPIiEBV864B+ax1/BetXufRMunvCjbarkjJJdxdGUV1ONBkGo57TgkTRP
	z/Pxes6exBO8b9nNiWhJuZc+MzwAm9zqfllnlTj24pH7+wS233k6EktVWOmHORHpBPmn7yCUx2j
	20dRjpCN6v3S3bDpLls/ny38cX/EluBfPwxBsYfkpii4DnsgPxcxHqBihri9abP28d03HXn2aeX
	M0u8BMPZ+0F+8Qf2IhA3522CEz/xvYDChPfybD4eQ1gqgb3kHCxbG7CjXMe955XJSTDjBpVYunK
	8o8=
X-Received: by 2002:a17:907:fd8a:b0:c2e:46d0:b802 with SMTP id a640c23a62f3a-c46a92ae6c0mr328359866b.40.1792759531935;
        Fri, 23 Oct 2026 05:45:31 -0700 (PDT)
X-Received: by 2002:a17:907:fd8a:b0:c2e:46d0:b802 with SMTP id
 a640c23a62f3a-c46a92ae6c0mr328354266b.40.1792759531460; Fri, 23 Oct 2026
 05:45:31 -0700 (PDT)
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
 <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com> <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
In-Reply-To: <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 23 Oct 2026 09:45:20 -0300
X-Gm-Features: AclHuK-AKUESe6iHVc-VzwOYib6sgRKlK0BCnAtM6wg5S60Ozyo0oOLLHvDr8CI
Message-ID: <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: Jr5srUUaLSSaol9iQGLJO_qpP0T_LuklpsgS4d1wWoo_1792759532
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 1:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> > On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@red=
hat.com> wrote:
>
> ...
>
> > > * As pointed out by Sashiko, when you were converting all of the
> > > arches, it looks like you missed alpha.  I took a quick look and it
> > > appears that it should be a pretty straightforward conversion like
> > > most of the others.
> >
> > I've actually dropped the alpha patch as per Magnus's request [1].
> >
> > [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phdBK=
y4BLWOvDTt92t5Eg@mail.gmail.com/
>
> The problem is that as things stand, this patchset breaks the build on
> Alpha.  Perhaps this gets resolved during the current merge window,
> but as you know we can't break the kernel build ...
>
> https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel.com

Of course, you're absolutely right that we can't break the build. I
was afraid that this dependency might cause trouble.

I noticed Magnus posted a pull request a few days ago containing the
"alpha: enable GENERIC_ENTRY" series [1]. It seems this will get
resolved during the current merge window.

For future reference, what's the best way to handle dependencies on
other subsystem changes like this?

[1] https://lore.kernel.org/linux-alpha/ataJlL6L7TrS3gWs@z440.darklands.se/

>
> --
> paul-moore.com
>

-Ricardo

