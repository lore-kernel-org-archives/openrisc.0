Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F7148F85C
	for <linux-openrisc@vger.kernel.org>; Fri, 14 Aug 2026 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732668; cv=none; b=PrDt6QdxufUxXpih5rSRbT0BacGgVL46FO5cGvL9dP4zwHsNwjzyFU5abCxLROREiuhLt4KBuKFPix/FvWEyxTT4srC+1S09E5MlADXnUxPB250Yv30k+NpdBQk4F3Ca8lG5Vi5JNff3IUIz9Wzvk4UXUZpd9FmYFimQfGVR0O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732668; c=relaxed/simple;
	bh=+yTnC3qUCMhYF5izBj08k4AdSicm6irjFGKLdWdw5gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9dhAKMH9YHRZR7mh6QSapEOuwGfc/Tn5Fpg3zfatfwRTciIkpCJ08+m4OexpiOpGniBGoil47PYd2WT3MxgTYXZlnavb6TpD7wSAYN6ffNiuX2O3KWEEBYJ87BlL2TPomk8UzrdzebgGar6LdxFVR6mtiBI9ZzQWRwmChTPfX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dEjNr+kq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEjNr+kq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786732666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h3Bw7xg93wntK2DGSQ+p1dtb5GSU+jYFMAY4ihssDQ0=;
	b=dEjNr+kqcTQa4PanpFJwe29bl/HNlhQJOnyoF9JXiIL0h7v9LaWGUm+gIWEDp70ijzx/rh
	QaiSALCOTy5Bxp4ZH6bb2rYfI9QCpzAW8qwNzXN+EkiFA8ivqBm2zrIwTKd7CmbtY9Pd0V
	XugY+zbmWbjoNP5880LIpMxX73I6GYg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-qArM96KiPUSk6Wmik9miSg-1; Fri, 14 Aug 2026 14:37:42 -0400
X-MC-Unique: qArM96KiPUSk6Wmik9miSg-1
X-Mimecast-MFC-AGG-ID: qArM96KiPUSk6Wmik9miSg_1786732662
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15f4732dfaso111235566b.3
        for <linux-openrisc@vger.kernel.org>; Fri, 14 Aug 2026 11:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786732662; x=1787337462;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h3Bw7xg93wntK2DGSQ+p1dtb5GSU+jYFMAY4ihssDQ0=;
        b=ZDXVx5xAgU/DMSXmEVjmJEZSKWYfg231fX3we2fxAmmD09n+Sxrc53PkgvYEw+jVFJ
         7LUSXThrunGszIfgkXsb/mmDXgIBug1gRWjzZZSjaWtouHXq1ga77nU47IKboNVKJEdS
         nGaR/AkQyKUbgrtBUpYq4HWqwkiskTXWjs9ksucjagyBKRWNzCTxxasOumb0Wj8fAVYz
         ZLbnZrW6pKUtu+2gsXEtmap4BN5NnWcOqftEC/3mBHt4O5q8S4a6ME0oZgQACxzj3lr+
         CSb8U/KpcSPjXl+ajPhPA3sQbZsV+3u0Gfy8i/Yh2gAZCG6vwJCcqqWlH7cDQdZPzQ/k
         0PLw==
X-Forwarded-Encrypted: i=1; AHgh+RqkHMz0JOR05pmW2IWCy5YUQZ+H1vdLlXpCWdxPM48GE77OpNlhVo2gYCfY3wlVEi43Zb8s4JQ0S6VNU2o/ZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlhffjdWaCrcCWBS2mHmbyzg+Lh2hWNMmHzfMeFCpyoKt4n+x0
	SMrjAnNuEsmenwS/j4WgvyzLgvVWQ+VD/APXJqejrMRF/a8MQhA1I34RY7Ymv1SxBCJEpezWZ5D
	He/FqXugkQYMYnFpy24slDrZbN6pXCKUvJUUPU5O9+PU0Czqs5sSdHb0xRObyVGFpBxo3ZfJFWV
	vfhYr+CHdjIJc0nSdz2/72cH1JgAoBH3v+L4X3lPKHpwY=
X-Gm-Gg: AR+sD12UTV6bERb++LIThUdSypPUVbyK2lg0s6Cq/0VpkkbYfDlkBKsigZ+ZdUC3EyV
	B8zPmEc7lPbhiCoLYaGaoGRFnmiW4fjAdqILSs0poeEu3SxjsYdfI6Crne25tGLuYVMakMVzePY
	m52Y8QMgaWPxXgcEOsmxHBgvren0e4Wkbna6yQfCCr/yhUe0Aaj3GmvSCcTYEO5OOpIvqbxuqaM
	rWcD9N8PgQPbf4VMWLyGZuDOQrnOmwMHrMQorQH7tmYrQ==
X-Received: by 2002:a17:907:1c94:b0:c20:87f9:875a with SMTP id a640c23a62f3a-c212a23ba41mr343799266b.30.1786732661675;
        Fri, 14 Aug 2026 11:37:41 -0700 (PDT)
X-Received: by 2002:a17:907:1c94:b0:c20:87f9:875a with SMTP id
 a640c23a62f3a-c212a23ba41mr343797466b.30.1786732661284; Fri, 14 Aug 2026
 11:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786626275.git.rrobaina@redhat.com> <an7Udt-luZfJO71U@willie-the-truck>
In-Reply-To: <an7Udt-luZfJO71U@willie-the-truck>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 14 Aug 2026 15:37:30 -0300
X-Gm-Features: AUfX_mwn2tCHNr249W_00_JVZBPk2OAqZsqdPsMuBo2JtJrJsV0GhfYgrjHGFrM
Message-ID: <CAABTaaCcyTLV5TdmzZfpP6LMV+5GeCKqotPoJrb0u9n0h-TaHQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] audit: log all six syscall arguments in the SYSCALL record
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
X-Mimecast-MFC-PROC-ID: BCXeRHkvNcDviAtM6oSS-0iXqHor0PKEXSoLxjeKd7k_1786732662
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 5:40=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Thu, Aug 13, 2026 at 02:02:50PM -0300, Ricardo Robaina wrote:
> > The SYSCALL record currently logs only four of the six syscall
> > arguments (a0-a3), silently discarding the remaining two. This
> > leads to the need for auxiliary records when audit-relevant
> > data lands in the 5th or 6th argument of a syscall.
> >
> > This series extends the SYSCALL record to log all six arguments,
> > by adding arguments a4 and a5 inline within the existing record.
> >
> > The audit testsuite runs successfully:
> >
> >  # make test
> >  make -C tests test
> >  chmod +x */test
> >  Running as   user    root
> >         with context unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1=
023
> >         on   system  Fedora
> >
> >  amcast_joinpart/test ................. ok
> >  backlog_wait_time_actual_reset/test .. ok
> >  bpf/test ............................. ok
> >  coredump/test ........................ ok
> >  exec_execve/test ..................... ok
> >  exec_name/test ....................... ok
> >  fanotify/test ........................ ok
> >  field_compare/test ................... ok
> >  file_create/test ..................... ok
> >  file_delete/test ..................... ok
> >  file_permission/test ................. ok
> >  file_rename/test ..................... ok
> >  filter_device/test ................... ok
> >  filter_exclude/test .................. ok
> >  filter_exit/test ..................... ok
> >  filter_inode/test .................... ok
> >  filter_saddr_fam/test ................ ok
> >  filter_sessionid/test ................ ok
> >  io_uring/test ........................ ok
> >  login_tty/test ....................... ok
> >  lost_reset/test ...................... ok
> >  netfilter_pkt/test ................... ok
> >  signal/test .......................... ok
> >  syscalls_file/test ................... ok
> >  syscall_module/test .................. ok
> >  syscall_socketcall/test .............. ok
> >  time_change/test ..................... ok
> >  user_msg/test ........................ ok
> >  All tests successful.
> >  Result: PASS
> >
> > Ricardo Robaina (13):
> >   audit: log all six syscall arguments in the SYSCALL record
> >   alpha: pass all six syscall args to audit_syscall_entry()
> >   arm: pass all six syscall args to audit_syscall_entry()
> >   arm64: pass all six syscall args to audit_syscall_entry()
> >   csky: pass all six syscall args to audit_syscall_entry()
> >   microblaze: pass all six syscall args to audit_syscall_entry()
> >   mips: pass all six syscall args to audit_syscall_entry()
> >   openrisc: pass all six syscall args to audit_syscall_entry()
> >   parisc: pass all six syscall args to audit_syscall_entry()
> >   sh: pass all six syscall args to audit_syscall_entry()
> >   sparc64: pass all six syscall args to audit_syscall_entry()
> >   um: pass all six syscall args to audit_syscall_entry()
> >   xtensa: pass all six syscall args to audit_syscall_entry()
>
> Could audit make use of syscall_get_arguments() instead?
>
> Will
>

Hi Will,

Thanks for reviewing this patch. Yes, I think so. I'll fix that in the v2.

Thanks,
-Ricardo

