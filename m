Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9DB42DA4D
	for <linux-openrisc@vger.kernel.org>; Tue, 15 Sep 2026 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488572; cv=none; b=dpGqX9xUrO86f3kzxMCN3J9AXn7OlVVpIi3EkAEn8vXloPYXX9CmxNa8uKICWQ6vI7lFVKZbAM91qnoysw5jtppVnYWlX3mew3pIEbeDR/SR8XPmvfD0fge67joke2spsL/AIruG5BeFCdyR+tJTJEcqtJGeWWI3/cXCRnoJ/g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488572; c=relaxed/simple;
	bh=TaD3IKHcoZf0PQ+wUUh3mHvOgYZf6uXYuUZRFHNcE+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTWqFtx/QSbJrNEbW9THTYlF1fWV1/7GAeNgL+LQ4pXQrqL65UmSew9sWijetRoHq1MurwknmB3duHsbri8r9vmLXOA5RtgwzraSWYEbAKYjBMBWGpfQwp05xOgYUlkLxQrAJzt2LhE9XAC0otzTf5/0JHLbJIlbXeotkktY9aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dHwXSYuN; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dHwXSYuN"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2953a01240so569766b.0
        for <linux-openrisc@vger.kernel.org>; Tue, 15 Sep 2026 09:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789488568; x=1790093368; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=dHwXSYuNbljayVnwE50++fF318jtc7RMzlCFIH9/209Qy3TqLv/SQ8waKYTFJlSA0K
         1viJPmXckoQiEM12aX8kgeu+7dEjc2O0Je+/oul3cjS2Itz5qOjO3+gotO0z00spfmmD
         tHOnIO/SXUH2I8Mxdq+bnJFSuxfblW3NbBxO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488568; x=1790093368;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=n+ttY8OS3sF5S4ItKQ2wNb7/iNHScbYLxCE0SMFLUGbqZf2nT+GJrzm6IyqHsWbo59
         YNyHp/gjjQR6PlNeve57ngAEdemR1hvchTV+axjrTkYNwsBLuOCayD2eAjwL0naSVU7T
         tY9YmIUW5g5IaUK4pBZlwnpfitCFRPCUZSeGfBgljM6GxsYAmmxxKuqzVPjediBGfHqo
         djXYFgc+PjCmeaKfwCqG/VJBsVO6i6hFSSGrVESQT8dcG7ZAs8vQDkY3Ykwy4zLv5C6k
         JIzTjyBjjyFjuK6W6fQXkqpt7/a+FOPosdB5+xhxGsCAT6J8lWXLwbGqPhkCJLNc3S/u
         Xrgw==
X-Forwarded-Encrypted: i=1; AKwUvBzOci1BTwizl2+5/rMFkRMFvItrI6EgSy9ldTgmzIVVcQG3F3kjjWL6NXbc5+1OZcBOInpQh9YR5QNgPqkkaA==@vger.kernel.org
X-Gm-Message-State: AFuF++ln4nV9mcr3pV8ijSkDbd+6sRxxCHtrqm0EF21P35+Mv7A7h5jI
	UfOOBjOYw1UBzfb4KnjbvdN0dE4hxMN40Gjpgmob2+kknhs+Mu6ODtMYOG7KjORV/gYLE5EOgdw
	afgexNrY=
X-Gm-Gg: AYBFou1XdkgXZ3GlxdRGUYyo0n1IHnKfWz3kqDttGdA0PVRstwfc+n/h/esQX5K7BJO
	MnGa16G7yxx2+wdli8CCv3oktFR6753T0t/MilYIh8HmsBykJdwpfrjGzbrgSCKq1JvfH6dloDW
	x7WkRpWYrSTo/mM+Gt3IB/QTaPa5V5hQi/gN0Vj8Kg8w/MiaFVFmHY4kFXGGTREpsYWSQ2cJPHs
	gHL9NS4UkKCPjpvKlp4XUOQdCNgQbGoe+Wgml+Zwcs1WidnKaDXezoJkM44rEKfdQ87IwziLjTb
	EyFUTbrRqacFpx0qivgVSKURjVcl/rgeAoS2kP4IOhuRG/Fym8PIll6029Cq2JiHQMLCRCeN2z7
	V4CYgfi441M++UI+rRCTLfAkBxT8gbXYFz/qjVBseR9zIqQIlQsX5wsRSre0O21tU/VCKxukQBd
	VeOsyxN/92dFpk2FuW+vVhuRe2999C9kAnE433QyHdvBjoACM0habNbu66qUfeD62FZXmgv0b+0
	U2p2Yee502ydmDdxC3hQ2O8Q1I/4/iFFhO3zbXaALFAZvK5kQ==
X-Received: by 2002:a17:907:3d50:b0:c19:6104:e5e4 with SMTP id a640c23a62f3a-c29b86353c5mr516490466b.20.1789488567837;
        Tue, 15 Sep 2026 09:09:27 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de6933e3sm319466b.61.2026.09.15.09.09.27
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 09:09:27 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa4c24cso538425366b.2
        for <linux-openrisc@vger.kernel.org>; Tue, 15 Sep 2026 09:09:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByrma6umApVXx5+ULp5EJvMK7h+1ScBp572lrLirjkWu3wEiJ4ktlajfi7bO6IkP3x/5dHw9e2GPTUD7vd88Q==@vger.kernel.org
X-Received: by 2002:a17:907:cd0d:b0:c29:439b:d5c1 with SMTP id
 a640c23a62f3a-c29b86141b9mr553591866b.16.1789488168046; Tue, 15 Sep 2026
 09:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 09:02:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
X-Gm-Features: AcwNN1WK06t9f9BcKFBIanysXcyUXK4eRICuH4x14s60AdlpF6ijCATIYaYAAvQ
Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wrote:
>
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

Honestly, I am *not* a fan. At all.

I think this adds complexity rather than removing it.

The diffstat tells a story:

>  106 files changed, 962 insertions(+), 861 deletions(-)

in how this adds a hundred lines more than it deletes.

But to make things worse, it adds them in bad places: low-level
architecture assembly code.

Those extra lines are *not* making complicated code simpler. Quite the
reverse. They are taking fairly straightforward "just deal with errors
with normal cleanup in the place where it makes sense" and makes the
*straightforward* case simpler, while making the big picture more
complicated and subtle, and adding new code to places that are not
simple and just blindly do somethign that makes no sense in that
context.

IOW: it's more code, and it's more abstraction, and it DOES NOT HELP.

And yes, most of the well-maintained modern platforms (read: x86 and
arm64) use the generic infrastructure and they don't show that
low-level asm effect. So for those cases, it's mainly just  that added
conceptual complexity and a new odd rule - and makes a *successful*
system call go through that "extra work" and indirection phase that it
didn't use to go through.

So it just spreads out the work, and moves it to a less obvious place.

All for the very questionable advantage that you can now randomly add
a file descriptor without the few lines of fairly straightforward
rollback.

IOW, I do not see a single real upside to this, and I see immediate
downsides to it, and a more abstract complicated machinery.

I do *not* see why we woudl want to make this be a "every system call
exit" kind of thing. If there are places that think it's complicated
to do, they could have *their* local little stack of fd's pending. Why
force it onto the low-level system call entry for every system call
when there are only a small handful of actual real cases (the vfs
itself, and random ioctl's by odd driver subsystems).

              Linus
