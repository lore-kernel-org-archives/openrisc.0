Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60AA3A6416
	for <linux-openrisc@vger.kernel.org>; Tue, 28 Apr 2026 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368778; cv=none; b=qWLhbzfN674D1bb8sHhM3IBCTUpZgOhNbP4DLzNRTQ78HVSIJHlp3GN2VeD9b6GkYwQyLA464wWBXY20PGhu8bzjXIsgclL70DKt6H0f77KpFBaJG51VwmWlQSAop9sH5ZAbdGOtAPYX5gou6jCcyxFUIniWp4ZcK6Kmnew50Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368778; c=relaxed/simple;
	bh=WZ0dv++aH+AeLwkvbNXxLqu7wJ3mA6GpS63WG1N27Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUAkrK4pB+epqtAiQGEzCOaupMOYSJk4PePGA62hK5kIkANHDWHJk6n0n/ZpMV/+vsj6pM0wTOAE6CQdFNhBFYFPhHKbDD2J+1ihSHYZ0K6LS6WWxh3Kfg39GCP4xVXbUpqKJLTvVYFLe94HvKNUyJp7nqwypMzIJZx7Q1lF8fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9c01854477so766510166b.0
        for <linux-openrisc@vger.kernel.org>; Tue, 28 Apr 2026 02:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368775; x=1777973575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al22kA6RCf7FSEzj29cZLSkjdM9EgXxihmBX7/SeSVI=;
        b=sE3/5mKIQcNQFEpinfLoJlxOOWW8cXGQdZEwP3ovJx+ZA4VnUM5A30UejhBnRiaE3U
         TO5mslc2aw36DK1qFH2fnrUMAXwSMzoC6SHMo33Cb/jQSPVExQgYDNIUOQDfJ/xMrrLt
         C3ldyJ5k3pPNhag2YjAnV0kRMwlN2dp3UMiW6W7OBZdp7panHAWrFnmepRxwBvBlotI4
         xi9ilS2Aog4rFo0RE+7l8aZQEyJWKN+IEgkaXMTrYnOuGMC7DkF3Atx4z2d7hf4xruSd
         IJr74D47NoENba3gZNJDDxikeiNT6RayGzNX6Idij7HqL6Ozq9x4UZR/frV7H7hniwL+
         Hkig==
X-Forwarded-Encrypted: i=1; AFNElJ94hFnZ93zSmSGOgT/2hg2REFp6cm+NpRWtC29zosrUTU+48w5o3p1bOtogZTvbnq4QNQ5viB3NuObQvUCbRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy84SjwrWNjQNkb9sTyyGhCy1lds78xoQm1bpT1TiYRHnubGHfj
	Lv70V6/ali2PfmZyeOphyKm4i//DMc2rdfxO9UpMO0L811US/uHuX9nD6LDQu8EqIXM=
X-Gm-Gg: AeBDievoK45FxFBWSpTWUp6lzpbJY4Ao3SxJsqgz0957eZYJFyGlN82bjP4EsuOGpYl
	BSFj5qwnUN91MtbKKBxzUOKI41qyzfwrKMI5Mlc5PEjY1+n+1bUAE32A9ErK4ZtsSIKUSMBsvnW
	axPQ+qe7Gi2DgVat/2/61R6TJMtb6rmSuDJoaj9VGv0gnrqfoi2oqulPyKhsPxvUCWeh5Y5YaJk
	B9dchSOYaZNXr1hIrlj6kYxhJP+dIEvL34PyxC9+6BZ3MLkdFevzFjRc+Oi65oxQ9N5EkKtDIqI
	fGU+r1pP5IvY9fbNhIvfSSM6tFp6Yw1ScKs2yNBTVp4JW6W3U90UUi9ivnGcn9EG4OTDjmKYxg5
	pMlN6HLhyY0LSfiWsPbh+ai3yXA8QoaoQPcmF2cMCpIXTeeyuVuvCC2REjOxbU3Hek3H1SZsoNg
	3nJnxz1Y1/KDnD+XHWpdg931tm1Q5yvMq9jyW5Qz3pZeXFKVMcTV9py1C4B0Dt7snIL5JKZiY=
X-Received: by 2002:a17:907:e145:20b0:ba8:7211:58c with SMTP id a640c23a62f3a-bb802cb218amr103863166b.18.1777368774916;
        Tue, 28 Apr 2026 02:32:54 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb808f2dcdfsm73236266b.22.2026.04.28.02.32.54
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:32:54 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso15352781a12.1
        for <linux-openrisc@vger.kernel.org>; Tue, 28 Apr 2026 02:32:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ80L1ye/MwDPRM79w/ObPf/NR5mUw/M1aSapEGSxOm/u+NOUDPUU7MwWKVB/aKlQjxzN7IiPJ5KeQFzzp65hg==@vger.kernel.org
X-Received: by 2002:a05:6402:5056:b0:676:d8a1:7a04 with SMTP id
 4fb4d7f45d1cf-679bb09a4admr915149a12.23.1777368324094; Tue, 28 Apr 2026
 02:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
In-Reply-To: <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 11:25:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
X-Gm-Features: AVHnY4JEWBVPw4tSjHgbQTia8gZd2WGJ1sv6qLdKJbtvs4hms1blpvc35yb0VWw
Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] uaccess: Introduce copy_{to/from}_user_partial()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight.linux@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christophe,

Thanks for your patch!

On Mon, 27 Apr 2026 at 19:18, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Today there are approximately 3000 calls for copy_to_user() and
> 3000 calls to copy_from_user().
>
> The majority of callers of copy_{to/from}_user() don't care about the
> return value, they only check whether it is 0 or not, and when it is
> not 0 they handle it as a -EACCES.

I think the "a" can be dropped.

> In order to allow better optimisation of copy_{to/from}_user() when
> the size of the copy is known at build time, create new fonctions

functions

> named copy_{to/from}_user_partial() to be used by the few callers
> that are interested in partial copies and need to now how many

know

> bytes remain at the end of the copy.
>
> For the time being it is just the same as copy_{to/from}_user().
>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
