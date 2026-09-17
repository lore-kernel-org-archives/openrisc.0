Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2213D3D09
	for <linux-openrisc@vger.kernel.org>; Thu, 17 Sep 2026 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663592; cv=none; b=gbDkxmVmiVnv8nPuZq4NYxCLfX42Zyq7Vk1IvvLh+28iqBTThYJkzH8mZU27vtgq+lxGHAtn2wsMYzWvrHp5TJFRmffBWzD5fGpXjMYaMxl9WUp5hD6UudYK3HTt/INPICMr3JAjJLEpEQd5k1Q7dSvGepnuhruf5cmL+huHMmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663592; c=relaxed/simple;
	bh=eYYWM3K0Z9Uro9HwA9hQ8je2naly/JqA+zNhzp9DrpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwKGezJrfGx7NHm+JrjrjIQ884oXED92t/mtqJant55M9lFUPUl95atfq7muBtfIcTFO8/rGuO+ZzJqjx3lptk9lWn0Rd+i/G+KHve4xTiTmhweP9ZL1YooNWjA4jzPp6KW3Frb4K1ewILEyUjwFlporM54g5M+2JKO4SiBiRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTTX6g4m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTTX6g4m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789663588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJkyJ4XReVojvgclcE9i/BeATq3QWWN8a1a2t1DdhcM=;
	b=ZTTX6g4mYj0vlRM1lqShOllZvQyzIx2owUz//QT3uX3LDPwvQ13gLfFul3EjOEEnhQRL8+
	IgQ/7XdL20/z2P4kFnyzkp7ERWfZuLKKKkUCSaqJIXTrE/hkbCg/FbDPz+nqS3uMZjRKFl
	rRIN2A0cBVjwRsvMvG/YvP3IE3QaPqs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-P3whe7cNOF-VUHZpGCdD4w-1; Thu, 17 Sep 2026 12:46:26 -0400
X-MC-Unique: P3whe7cNOF-VUHZpGCdD4w-1
X-Mimecast-MFC-AGG-ID: P3whe7cNOF-VUHZpGCdD4w_1789663585
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c294ae16988so134588366b.0
        for <linux-openrisc@vger.kernel.org>; Thu, 17 Sep 2026 09:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663585; x=1790268385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJkyJ4XReVojvgclcE9i/BeATq3QWWN8a1a2t1DdhcM=;
        b=HTP2voY8V2wbftI/N5qhtAogVscBxIHfz9vqbv8JGzq8sgKsYzWQBV8DPck6iHMjme
         gNLTBpawiQjsPjC1xuFS2ucL/av1rnjQIbXxKFJJvfG/W5AreklKUwO40KWK7vKFjt1q
         NKZq/EcWSx8uohw52AiuTH6YvYvdfQxMv2Gkk3oSwkTUX3idR7Vfl46Ri2wGz0hCA/U9
         c32aBRyGxfZD/2IsPRXttlheJT/ZtJ+PvUcipMEMzGxBBx1+rJpj9Hg/lZkVvMmQAVR9
         mVqWyMSlV3tNy0F+BadD2P6y1yJOOT47YcVwD4lEjFj/N9fadbRi8xi2HZ+tTZJG2Aze
         bErQ==
X-Forwarded-Encrypted: i=1; AKwUvBxiTrPKecjzp37M7EQ7WPkagNv044gj3DAtzBtDW+ssp5GThZpbf7k86MtBPTMdCkmgT9c2bVIQZ48vRJNPPQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mLCPMq3bJz7OwMcpIPZSL32dLSSRC3YomVMwUhRuwPiIdPwbS0
	VHwdZ/kbkpxMrDMLAuOUm+omSHeeeFSzaDPxqzjPhYkknoiuUvi41FjHcZU5zmzNswdS0WC1OpO
	cbaKTg/M6w5haQDWhm3E6DS+cPbSE2BNj5aN+8bB3hyLXtU+G6VRK0qGko3N2mc92jixB/3qYPo
	fnDd/iaLExGCq8oODihwmMUOIyxkHbD3kTP1LpVjvDUuA=
X-Gm-Gg: AYBFou09orYELCA2FOwnd5czUu6kjik+BA3zvGtNXNFU2k8c9OuWB6lpT+qTo2i9OCe
	UUglRZlNfXyWOlH0K4YMp00O+lKCCiwKi1IVrJPWOQWnr6xvGNHLcqkzsj7JSCtKOb5pCsRAb3h
	KzQ6OvbUD2cGofJMirWNrdZvL7u9jMBTUX4P+ayLgJQycZj9mPWw9K/i28g/UG3FGyTzYykDPlN
	9fqNTXSeGPOiXaY1EJ9Bjy+SLoT38erFnbZQKlDCbY0aSFX5gr/sgSV8vjWi+L6+Pj4FL1wUzOS
	n6U=
X-Received: by 2002:a17:906:4fc5:b0:c26:19de:9ad2 with SMTP id a640c23a62f3a-c29e53184f0mr504525966b.42.1789663585468;
        Thu, 17 Sep 2026 09:46:25 -0700 (PDT)
X-Received: by 2002:a17:906:4fc5:b0:c26:19de:9ad2 with SMTP id
 a640c23a62f3a-c29e53184f0mr504523266b.42.1789663585091; Thu, 17 Sep 2026
 09:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788351089.git.rrobaina@redhat.com> <b4ab47d2551d090520b4fa81a884b5988b9655c7.1788351089.git.rrobaina@redhat.com>
 <apkuNj1paR_GO3x9@willie-the-truck>
In-Reply-To: <apkuNj1paR_GO3x9@willie-the-truck>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 17 Sep 2026 13:46:11 -0300
X-Gm-Features: AcwNN1UTQywdGW9xqj12KwNHAYLGfDNNso402GZvP3WcYYwXGdDJ7Oiz7qML_cg
Message-ID: <CAABTaaCoNztwDUA-HPp4LaikxL4dxk-1bvCCpoZEGD4rnds1oA@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] arm64: pass pt_regs to audit_syscall_entry()
To: Will Deacon <will@kernel.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, paul@paul-moore.com, 
	eparis@redhat.com, sgrubb@redhat.com, oleg@redhat.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, guoren@kernel.org, 
	monstr@monstr.eu, tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uBVZOCi8WkR-K67tfdiDqbiM2yGp_cm6ltMEiCmosHw_1789663585
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 5:22=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Sep 02, 2026 at 11:43:37AM -0300, Ricardo Robaina wrote:
> > audit_syscall_entry() now takes a pointer to pt_regs and extracts
> > the syscall arguments itself via syscall_get_arguments(). Drop the
> > individual argument registers from the call and pass regs instead.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  arch/arm64/kernel/ptrace.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > index f743cbec1c3a..65532b2a8cd4 100644
> > --- a/arch/arm64/kernel/ptrace.c
> > +++ b/arch/arm64/kernel/ptrace.c
> > @@ -2476,8 +2476,7 @@ int syscall_trace_enter(struct pt_regs *regs)
> >       if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> >               trace_sys_enter(regs, regs->syscallno);
> >
> > -     audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1]=
,
> > -                         regs->regs[2], regs->regs[3]);
> > +     audit_syscall_entry(regs->syscallno, regs);
>
> Acked-by: Will Deacon <will@kernel.org>
>
> Thanks for doing this.
>
> Will
>

Thanks, Will!

-Ricardo

