Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF603C2788
	for <linux-openrisc@vger.kernel.org>; Sat, 11 Jul 2026 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772968; cv=pass; b=cpordc6PS8rnM9A6ssBti4gZdC7iQ5XZUHCT5i8AGW/f2dd53AeYWofM9cgLIZaxDg+yPPYYQvGaPWxIjuy+ocMsG/hONea3ozkynhK/Equ892Yyi0E21OPUBohIjiD+7kAM5pcPDmOTLuEAgHBwQpsiWmxF/E4e/FSaXYvB1pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772968; c=relaxed/simple;
	bh=lgplXt8OmmYK0O5s0vGlPCfavq5E5GB8C7ljQ3QichI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfjSMY4/cKeMDZ44GcXdaCdKqUAu2L6XiLewWQJHJhwGvRDmr39z7eqSc69sE6YIXOL/jO9SZrQAt7HaOM1zkKR8WxPBY/jzaSI3VZAydZvYvdkj6pXMSvN3JIu1zliH/M/wV6ViNxmLM/5/Y4tTzbbeWX+tKB1waXVnfzf1vyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhVAsJnP; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhVAsJnP"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-697cee2eb6dso1793270a12.0
        for <linux-openrisc@vger.kernel.org>; Sat, 11 Jul 2026 05:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783772964; cv=none;
        d=google.com; s=arc-20260327;
        b=hXIFVSnzsM3JvcyduMpFInoYQxmRsW2xwE5TiD1NW5UhzCXWFXwlThB2ql6dU0VY4w
         iDtaaIpUlD9n+MNKF+I1vROCoRNXvz8eXk4GIMlr3FESk1UhA0/XMHfs2vRWKHjRUITM
         s9dRTvU46Mx+uV7GfwD0W8GR+gv+8q/Uwrk0puDJs7Sx33cGP4MdqYRt04nx0XUdnXUx
         yOf1I4uq7LjdD6oSeNzuI+BOsI6YYibDC29+ll/O6V8KerWa7FiGUFRmhhHrnx5XOsqH
         +V/ecY2EwfNfAzov9VM2SUusOCumAOEeNezFxipvHW7OYWFIhblfBK2qwBda5smIx7Sw
         T41A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        fh=rSV0ib+lPVc9PZjtJKVXs8r/vXhy37AWG9jXra0IqFk=;
        b=ASkIbPqsNoLmq4RB8xjffUuYcoEMyQ79HkdQcvwuXWdHfd3tp4pOzrXLtrXdTqahJS
         TjTEnJQNLMdf4H230VSoESNKVW1MEpw6L7SFUIpdV5tBbn47s5GvafDxOOKShWlHe7lY
         2Muk2XZa0V6y3NfrZuWUBSmLyW6HGpYK1WlMO2UZZqpExwJxfL3iz51UjFNNGYYqIrHF
         OcEECkpXatlLx+1ow3JoI4szbGY6mJataHBuh0R5RW5FlJQfQQ0DEu5k4YYLfI7TuKaH
         PKcfkgkUvzK2Cvdv0G/d1QeCPdkUDYtuor22HyzxiwSU3ueeO/XpuhHNimUFkx5vhIZQ
         2GDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783772964; x=1784377764; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        b=KhVAsJnPccLQtlT6BW0pZOI6M33Kq5peNIi+brKc9mXt9N7FYBNxZiwumx0gXF4fIo
         sAO6rzobNlVEoIHs9Nr5Ud7Pqw06Wde6xz1P1K2kPK3YZyfFF/QcLy13zXrkpb8v6zCE
         wa1FryKea8CiALQ/FW+b66R5gxrKvaJKvQ5Z1BuPJv6JghHzUORCw6XB09TKL/k9s/1r
         i0N8avEwa/AHjCgBU1q0AZKoEW1/H84E5Jz1kEDp/nKMXzLRh+UDioLCoc7tRKEjgsZq
         3/2AvXjdSUp8fEKFVNQm320lqiCV3PxeKpLmb2suZXyxqugmSpsqzHjcuuYpicZfDTox
         leNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783772964; x=1784377764;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        b=UdWJMA+LA2MSmnr6LnwBmwx7gIiJlNfjv/ePwbL6O/1mc6YUg2JtMwTVjOyJGIM699
         rLK/7t+XTK6VndbubPD08CSel65rzKT0KG55ST0Hio1VrMrD/5f4nVxCbHr9emM8EO1l
         fDRAi+sTCgp9yXVMt3i7jLwAGljUCZL4nW7lHc4kF6lyRonzWKGmVCrha83ORboyiYSP
         BbBIHc0UqRWywulK7fM6ud+Oq+neI1wp0PQtBgQV67XXZMjh4fyhxm8zGfQ8cRHlYfBM
         W1fqTN/CKImdsE1OJkRxNIfxQW8PhXwUMdTKfdrQDv0/AhHtrQGOtu/7efxlgyk7TjCN
         Xmdw==
X-Forwarded-Encrypted: i=1; AHgh+RrhRUj9vrldt+qxpmCe1fWbSU+caGj/cLOcxHeu50Y56LowDny9SUrJKGWe7XrRXu3yvHxxq0qyAfoFtakj3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxG6j9QX4Y1sVMjlxMwaKq9blVl3wErToGp3UdMmlDb8vswo2xQ
	PimX+3WIEtDlCAYNCmN8X5Vui4PPhUCRkFJPfe3/qo3rTzQwSFPU50b/DLVtjgEzZB7r8BPClqu
	MOcTkYRUg/inbAFPqgFsgZGJoCW1VPP8=
X-Gm-Gg: AfdE7cl2n0FkYyc8Xs+ZsdSSFnodzjPwjHbnCZdjX2sJaQx/YqfxAf4k8zq3CaItkq3
	3YjFe4d8GlZALefxFkd3ezbBd/Xl5NWDpN33dXCgLwtVmLBE+tdrJ0UIyiob726hhmbmt9Omzg/
	XwZ/horzl1az3CDKs/nxtyNUrhntsGi1m94snVsttcllc2y8Z3AiyQD6Y2aHYxj0+BGx/WZHPX0
	kq5z2hwl65QpF7EWluQ4JddWYR2DGuYy8PpZg87vgctYiIQvUnsfiW4C238Pq3KjLVCgUBHxF4F
	4bo8Hr1WBZsmaGGU+TL6je9Ng+PZgLDDOI/x3weUVkwvKYVA04w6CPaWwZyibzI=
X-Received: by 2002:a05:6402:3512:b0:699:728e:48b9 with SMTP id
 4fb4d7f45d1cf-69c5edb9cb3mr1210325a12.0.1783772963919; Sat, 11 Jul 2026
 05:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org>
In-Reply-To: <20260707181957.433213175@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 11 Jul 2026 14:29:12 +0200
X-Gm-Features: AUfX_mzOlRB8ana7x7qPQc4frMU9J060tNH0Z2GPCNvL1LYqDKQBjM-XzHbrvno
Message-ID: <CA+=Fv5RpgQ-UeGAT+VcLufte2gAp0H=J5GqZEFR_SuQsmnzy=A@mail.gmail.com>
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

>
> With that all architectures using the generic syscall entry code follow the
> same scheme, apply stack randomization at the correct and earliest possible
> place and skip syscall processing depending on the boolean return value of
> syscall_enter_from_user_mode[_work]().
>
> There should be no functional changes, at least there are none intended.
>
> The resulting text size for the syscall entry code on x8664 is slightly
> smaller than before these changes.
>
> Testing syscall heavy workloads and micro benchmarks shows a small
> performance gain for the general rework, but the last patch, which changes
> the logic to be more understandable has no measurable impact in either
> direction.
>
> The series applies on Linus tree and is also available from git:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-rework-v1
>


Hi Thomas,

Thanks for the series.

I have an Alpha GENERIC_ENTRY series posted and planned for the next
merge window:

https://lore.kernel.org/linux-alpha/20260706170019.2941459-1-linmag7@gmail.com/T/#t

Only its final patch intersects with this work.

That patch removes Alpha's architecture-specific syscall_trace_enter()
and syscall_trace_leave() implementations, so the Alpha changes in
patches 11 and 12 will disappear once the GENERIC_ENTRY conversion is
applied.

It also currently uses syscall_enter_from_user_mode(), so I will need to
rebase it onto the new entry interface introduced by this series. I
expect the integration to be confined to the final GENERIC_ENTRY patch.

The Alpha-specific changes in patches 11 and 12 look correct to me.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
