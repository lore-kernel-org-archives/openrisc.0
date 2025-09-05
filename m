Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4AB31D75D;
	Fri,  5 Sep 2025 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093965; cv=none; b=s4wjeKPcu84lF+aJdvUy9H9XRtiQDCwyRemMT2xarGe5zHcIDeMWJzqDli0G3WFoU1eWa1APVDtYiGx1lr2dlaEyiKVYg/EziJjOEs57t2jWxkMZk9syu8Fry9wkkGdhiS4HCu0pT9JVBmQrfy6zjwheLSJwuOJ7fWGledWEVjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093965; c=relaxed/simple;
	bh=sygTjg+xYF19iQgUgJ0XxBJiqG9DyvEuu5T8d2Wis8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoZLau/aMtWeQeaDhaU1Eiw5ym2bM6qNcvWU8GZIj8jv0x/LTOT4XClDR3yAStKp/vilBrfGaXVpsWj0+Dg20n3QKgkkKqPMuMXCURrH85K/3n2MiPXesM/7tUmEw1HZEFjZTbB/c4XmJvfoI/2MRzU4gqscgYZza01MMK+6Hkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFSgjQJF; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFSgjQJF"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so790859a12.2;
        Fri, 05 Sep 2025 10:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757093959; x=1757698759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd7xiO5epa77zkbKpQHOLnvm7e/b4a42K8CAa4f18dA=;
        b=SFSgjQJFJoLkDnNsgWYgUIwhfapirqDh1C35YLbZZG6GnQQNpOUZEzR+1Uxa00n5lg
         2DtxRpje9A2e/kj2adFg6EDd2dAGeCNDT+6IOdIV8fXxWwOWbiU9HXz5LQ7JIoqy42Ah
         RLhVjL9fRM6xwpbStaqhid6MBEPeH8F4STTuDkkmx5WC6C9zW3vPI67g3T/8DKI+Nzah
         vNSVJHSwjgUFOeIS2Rwp1+NC0ouMFuyTX1DkllF1IvuTFqjZme9kNK/BpC3kewK4xz+f
         k97T7gtme3nJw8SxITY8/8vWGCpxVHxlsa6uUDH7PvnYvpIozL9+MsI3fILg/w6qSqAl
         dOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757093959; x=1757698759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qd7xiO5epa77zkbKpQHOLnvm7e/b4a42K8CAa4f18dA=;
        b=E9gGtNBCZ8akAuLrgSQ24O1jWMzY8LN/qgQNK1Ejo3N5bzRVobKPQUurvOgyH93K8s
         e32Qzrx+RuQ8dpxm+keTib1XPc0HWSgyFHsT6rEEgL0B0psMrJ0Ra3EMTVlc0sPAb19M
         1lX510PINL1iZGomYeLYcLF1olFupmL4kFk+2TdovNUimhYn5C3bqS0w3Np8xIQBo66t
         /sCri/kC+D1qi6C02hXZ4OgkFySDZ5SuSbA6Fo/ry3Px6FnuN2dm/kM+1/KeMdQySl16
         sze1azyuPBxVY2C9YyLfqq+UaDV2O6dBhAufZeaAZGMBOJUWselUcN9c2KnKFI+fXfwK
         3VYw==
X-Forwarded-Encrypted: i=1; AJvYcCVuTsZ/PBrQoJwAs4s1eus8/cIjv14bqDPTlz30BZsbu559DpW1xfkx5jmU5LVAzb7E9I720jF4GFibFVDAPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb5K9wqdW/YW87MOgBdL0dhYGSIMkianMubfJ5K6n1vA8R2p7b
	6iF+H/MRFA1IGatfNasmFZSBT/GjVFlyGPkNRLwSOlEK0a+/9VWnPH0Dt5ftaKe16JQtRNeT5Rg
	kujnqcFa99u8ducWHhK51iV1i94gpgEePcp/C8Xc=
X-Gm-Gg: ASbGncvN4kdX9pN7JB7MtDw89zNVA7QDAr1cg+Y8Nevs8TumWAfyzPzZWDic0t6O09e
	nX/PWm/wumRYAQpQ0fbqr/vRcpUJUCyzusAxnF87jH/xEGjJBRGaTxu4zC8aIijanfZejhom/bW
	LMzs0unytqSncg2QaB5VuNdjuh7dud8XXjcUXBDB6+7Qz1eqNspRZKhpxg+SApCVFUqeZ0a5nDx
	bbWzsb7
X-Google-Smtp-Source: AGHT+IFjgHxHeQUFor0LAwYMk9GfbcDTf+9RR/kaN9MorkKsO4NDMx3l/gVzWmrcCDMxzY9eJZnnniI5INiyqMVUc/U=
X-Received: by 2002:a17:906:6a20:b0:afe:90d2:b952 with SMTP id
 a640c23a62f3a-b045bc3622emr1370941366b.29.1757093958492; Fri, 05 Sep 2025
 10:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904100109.688033-1-chenmiao.ku@gmail.com> <aLsa_h00k8nOoZB8@antec>
In-Reply-To: <aLsa_h00k8nOoZB8@antec>
From: Chen Miao <chenmiao.ku@gmail.com>
Date: Sat, 6 Sep 2025 01:38:41 +0800
X-Gm-Features: Ac12FXzyRBY0S2vt9LwScp8v-w17LKIScNvcDuFXx4QTneqUlu7y3mkGl2atEHI
Message-ID: <CAKxVwgdGe59F=giPXsukmQDO=XY58BH2gAMCV6uCR=vmwkAyyQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] openrisc: Support basic trace mechanism
To: Stafford Horne <shorne@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, 
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

well, I'll send a new version later

Stafford Horne <shorne@gmail.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=886=E6=97=
=A5=E5=91=A8=E5=85=AD 01:16=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Sep 04, 2025 at 10:00:48AM +0000, ChenMiao wrote:
> > From: chenmiao <chenmiao.ku@gmail.com>
> >
> > Hello everyone,
> >
> > This implements a basic text patching mechanism and a complete jump_lab=
el
> > implementation for OpenRISC. It should be noted that the jump_label hav=
e
> > passed testing.
> >
> > 1. Implement the patch_map interface and the patch_insn_write single in=
sn
> > write API by providing FIX_TEXT_POKE0. And create a new insn-def.h to r=
ecord
> > openrisc's instruction macro definition which only have OPENRISC_INSN_S=
IZE
> > now.
> >
> > 2. Support for the R_OR1K_32_PCREL relocation type is added for module =
insertion,
> > enabling subsequent jump_label selftest module insertion.
> >
> > 3. Regenerate defconfigs for or1ksim_defconfig and virt_defconfig.
> >
> > 4. Based on the previously implemented patch_insn_write, achieve a comp=
lete
> > jump_label implementation, directly supporting arch_jump_label_transfor=
m_queue.
> > And add a new macro OPENRISC_INSN_NOP in insn-def.h.
>
> Thank, this is looking good.  I will queue this soon once the final items=
 are
> cleaned up.
>
> > Link: https://lore.kernel.org/openrisc/20250805084926.4125564-1-chenmia=
o.ku@gmail.com/T/#u
>
> > Thanks,
> >
> > Chen Miao
> >
> > ---
> > Changes in V4:
> >   - Added testing for jump_label
> >   - Split part of the jump_label patch content to form the third patch
> >   - Implemented R_OR1K_32_PCREL module support for jump_label testing
> >
> > Changes in V3:
> >   - Removed the is_exit_text used, added some necessary comments.
> >   - Modify some macro like __ASSEMBLY__ to __ASSEMBLER__ and ensure the
> >     defconfig by make savedefconfig.
> >
> > Changes in V2:
> >   - Add a new insn-def.h to record the insn macro.
> >   - Modify the patch_insn_write API from const void* to u32 insn.
> >   - Using the modified patch_insn_write API in
> >     arch_jump_label_transform_queue.
> >
> > chenmiao (4):
> >   openrisc: Add text patching API support
> >   openrisc: Add R_OR1K_32_PCREL relocation type module support
> >   openrisc: Regenerate defconfigs.
> >   openrisc: Add jump label support
> >
> >  .../core/jump-labels/arch-support.txt         |  2 +-
> >  arch/openrisc/Kconfig                         |  2 +
> >  arch/openrisc/configs/or1ksim_defconfig       | 19 ++---
> >  arch/openrisc/configs/virt_defconfig          |  2 +-
> >  arch/openrisc/include/asm/Kbuild              |  1 -
> >  arch/openrisc/include/asm/fixmap.h            |  1 +
> >  arch/openrisc/include/asm/insn-def.h          | 15 ++++
> >  arch/openrisc/include/asm/jump_label.h        | 72 +++++++++++++++++
> >  arch/openrisc/include/asm/text-patching.h     | 13 +++
> >  arch/openrisc/kernel/Makefile                 |  2 +
> >  arch/openrisc/kernel/jump_label.c             | 52 ++++++++++++
> >  arch/openrisc/kernel/module.c                 |  4 +
> >  arch/openrisc/kernel/patching.c               | 79 +++++++++++++++++++
> >  arch/openrisc/kernel/setup.c                  |  2 +
> >  arch/openrisc/mm/init.c                       |  6 +-
> >  15 files changed, 256 insertions(+), 16 deletions(-)
> >  create mode 100644 arch/openrisc/include/asm/insn-def.h
> >  create mode 100644 arch/openrisc/include/asm/jump_label.h
> >  create mode 100644 arch/openrisc/include/asm/text-patching.h
> >  create mode 100644 arch/openrisc/kernel/jump_label.c
> >  create mode 100644 arch/openrisc/kernel/patching.c
> >
> > --
> > 2.45.2
> >
> >
