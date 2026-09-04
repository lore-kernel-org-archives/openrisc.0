Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF61509F09
	for <linux-openrisc@vger.kernel.org>; Fri,  4 Sep 2026 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542483; cv=pass; b=kF1gaKN8ExAknGYrQj/Pe2mtAcxfL620LoZkNWWUJW7/U/aTs3tjGM+44Fa1y/CnPOWP42pMM2pTbTnHXlrzYdvngaqPH2oXc/KY8zIjPAW2X5jcdN8Crds01h4HF8D7V3DMfx8RdgXBwK43yGpeAFbrcR5dA5TiM1BuOPK80V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542483; c=relaxed/simple;
	bh=AFNBiWCRpUcEoXNChHss1VconiHm4hB8qaeZxdrK+Dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoKadHeCu3dKqD0o1ySfBucVLfF/z0EJkj7vSmKFgEEUZVD7Luvz+XzDa32V4TH16lZf1eP8GYy+wjY9lJf0HPRKmaZq8AMKgitn78gJpSu0P+mmQkLzYxaI9vi4P+Vmw6sY/HRXMLcRa82lDtjEy9RwBA/Un5ZWm4qdjm78L14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+5ZMHHh; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+5ZMHHh"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a68aaf4840so2892870a12.0
        for <linux-openrisc@vger.kernel.org>; Fri, 04 Sep 2026 10:21:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788542480; cv=none;
        d=google.com; s=arc-20260327;
        b=Sn0yns3fagWDoVR98X6n7dIi34UUm1HGPMqcnN6/Kk4iPRmZZtDVvQcC0vOgKnVhaI
         pgMWHEUYHGycZ9EIC0rC5nhK+4w8edlsXCS0pt3OxQfXwxbE9fQCcDqjCm7hBxOzHL5H
         cxdk1Ej5C7cMwwHL2uS44qD17xP6/SLAQjvi/xiGPvEvvb+Y91uU68cGKBC2RM6VIUFT
         lYVpegoR+EEskUA2CrbUZjgaTNsjUjeIGL9KWJhepzVOmV6UlWNEtiaeNzQjerUcOXKF
         11+dWljQLlKILc1vkZSYcAt98HpW7spXVSom+to5steqxYKizwdGBrsWWJdKW72eG8rI
         elig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xbP84TB5YSyUcPTlSRXVzwOJ5KiLCluO2L3qZFE4rqU=;
        fh=YzVXMbVJhbJcBBlIMBV4CynCogN149OZ6lsE4Ye1Qug=;
        b=oSEN1bU9ryF27XyqzacTgmUyeEeGHDRo6rvGQgU7w+B7eFtRaTZEfzfEkhcbURfHxr
         td0/FWz/uMAFR7uk/bTrLaHkgsIFLD8Q7G0zfgqSJF3cKRvzUTnSybtHC8KsyATvPfb0
         Su2fV5KCJOrsg/W/xm/RGwohuGEMi2TsPw3qb0OW2tDa26dFAiwo0kiH5yriOvz1IH5P
         WK1vQkgMJ2fkw7zVQLSrL4SBfZplkWWajBsJCkL4a2AbVdN0Rz3U7AhXk1YhTt6uIIro
         cukedD9Jo4fBg5ERfFnqEYMCB7mYIANMCcYvEXQQmi6kMdVbgFi1J9fJq0oUhch24C3e
         DYjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788542480; x=1789147280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xbP84TB5YSyUcPTlSRXVzwOJ5KiLCluO2L3qZFE4rqU=;
        b=S+5ZMHHhfGjA+IdWmeugDDHgBwHG5bBYSPYfCEow+5chkn8MQle82UmWyVbxLiEN7d
         ijcv6053WNTu2RqyJ6VR+Q1MSk4Vxz4n7ZKFRrjYrPqEbaWeUeae4OgCiLykWRLNUDRA
         ZH/X93kZSKA1/wbKpcmxavHteq0Ow+JKUXYEkMsejbWI7AKmmLzp7rDEpD05dDMzdu05
         qx2RS3AgstzLvoN8v5AUqAPOvMKc+nz/J8n2Lte3Wf5wq5bPQVeGs2cRbGv15hnp0TgY
         EW5NlkkUE9iLPQcY1GiopKTuEm/IxQzvNCCThYHaycwvH5N4Y2kyLdCZ7Tyzs3tF5f6h
         EH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788542480; x=1789147280;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xbP84TB5YSyUcPTlSRXVzwOJ5KiLCluO2L3qZFE4rqU=;
        b=ouFTFAhGeiKRlYxeqZLHpoG7x8u9cQkQbr86lxPHvIptTmRoLcM+Tpscdc2tYycjC9
         zNB1Ssu5cPtk1HClhta3vXKWGRoAfaWOCMug638hdElfN6lQx4F7Z8E1tP6Dir6o+muM
         0zLCue5jWj63tUc0VyFDfnDVusFt+wrmhUoW6LEi1HtuaGItMgI8m/wu+7apXVSHHIOq
         N+NXAwUgl4agAqiavgCskfdqk7cgFmZbolf8sPp36vZTltM7ihq80zQZmglGOwV3+OKB
         yqCzIHT0qaswsYJSE64g9bkSAXXfBvN45oeV/ypcwXhzirvEVvQSxUcKOHpfVOas3vzi
         gycg==
X-Forwarded-Encrypted: i=1; AKwUvBydvpxD2kzxLQ+wRjbzGqi7trB5nBcsBuZYUvLiw+WAe9VNU4MrpaAKuj4XfW4XsGNpfMbM0qlCEeSZXgAlaA==@vger.kernel.org
X-Gm-Message-State: AFuF++kNug/wtwVGK55CZ3HWzke9T6GVzgoem0VjuX4J/likjx9G8Puq
	zaMFBkKUcfIL/+cIjjNNstMw17Qhmflg9oXO3Wce1lvz6JkDosoiOUC2pYSqAPM1Fx0D7pZGMbe
	81z6iIIVSH9fX2Po7pdl4hKdK6moeFs0=
X-Gm-Gg: AYBFou1IT1kBumhuoCp69YOQ6wPXlECHLI6+xTsZNa55IE+lWGBgnthwwF3uukmmWbp
	BB7qBCoi6NH0Y4PEs4NWrtxrpYjR7s1nG5TJlcUFmA5d16rgT09qra4BO1phhE+kb7yF3kN2yzJ
	kI2mmVoHy7ks3zegjet+VRIx50A1ioFEjSCez4jtEhROmZ9KtH5BNRjc4zM3LUTcHM1J/cmcQLc
	bq9lxGWNvAOjw9wgop+Ouy9J5C9ig59Kmo+OrYIgg0lKwE4ovwVW3WiX7P2LSbEUpowkvJxoL/f
	JdLj9VknanfO53Fv21h0qZLdJFuGDgNnSVU5vdTcCztWeHeUXhlKZceqPAAn8n4FIjmyosivGKI
	JT+DVZ0J27dnagw+1mUPtj0bEgrW875I=
X-Received: by 2002:a05:6402:a252:20b0:6a6:9368:73a0 with SMTP id
 4fb4d7f45d1cf-6a696a73aa1mr4363499a12.6.1788542479338; Fri, 04 Sep 2026
 10:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788351089.git.rrobaina@redhat.com> <4ada9fcbb93af8d5c1c9bfe2c83d94fc10bfe327.1788351089.git.rrobaina@redhat.com>
In-Reply-To: <4ada9fcbb93af8d5c1c9bfe2c83d94fc10bfe327.1788351089.git.rrobaina@redhat.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 4 Sep 2026 19:21:07 +0200
X-Gm-Features: AcwNN1WpEQ0Y6eKbtA6wNzDHeYOBs1Tconhq7C15XjRhFKDXvjk4jMYrR9OFExk
Message-ID: <CA+=Fv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4BLWOvDTt92t5Eg@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] alpha: pass pt_regs to audit_syscall_entry()
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, paul@paul-moore.com, 
	eparis@redhat.com, sgrubb@redhat.com, oleg@redhat.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linux@armlinux.org.uk, 
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

Hi Ricardo,

On Wed, Sep 2, 2026 at 4:44=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.com=
> wrote:
>
> audit_syscall_entry() now takes a pointer to pt_regs and extracts
> the syscall arguments itself via syscall_get_arguments(). Drop the
> individual argument registers from the call and pass regs instead.
>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  arch/alpha/kernel/ptrace.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
> index fc8f6cedbb28..8a39c0473297 100644
> --- a/arch/alpha/kernel/ptrace.c
> +++ b/arch/alpha/kernel/ptrace.c
> @@ -496,8 +496,7 @@ asmlinkage unsigned long syscall_trace_enter(void)
>         }
>
>  #ifdef CONFIG_AUDITSYSCALL
> -       audit_syscall_entry(syscall_get_nr(current, regs),
> -               regs->r16, regs->r17, regs->r18, regs->r19);
> +       audit_syscall_entry(syscall_get_nr(current, regs), regs);
>  #endif
>         return syscall_get_nr(current, regs);
>  }
> --
> 2.55.0
>
This doesn't apply on top of my "alpha: enable GENERIC_ENTRY" series

https://lore.kernel.org/linux-alpha/20260902184058.198679-1-linmag7@gmail.c=
om/T/#t

That series moves alpha's syscall entry onto the generic entry
framework and removes syscall_trace_enter() and its direct
audit_syscall_entry() call entirely - verified with git am against
GENERIC_ENTRY applied, it fails at exactly this hunk.
You don't need a replacement alpha patch, though. Once GENERIC_ENTRY
lands, alpha's syscall entry goes through
syscall_enter_from_user_mode_randomize_stack(), which already calls
syscall_enter_audit() as part of the shared entry helpers
(include/linux/entry-common.h). I applied patch 1/13 alone on top of
GENERIC_ENTRY and confirmed alpha's entry path already routes through
the updated __audit_syscall_entry() - no alpha-specific code needed.
So for alpha, you can drop this patch in the next revision rather
than rebase it.

Regards
Magnus
