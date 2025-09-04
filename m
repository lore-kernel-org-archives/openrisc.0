Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4502C08C4;
	Thu,  4 Sep 2025 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981226; cv=none; b=l8mlSVvCmGO/pSxGm1amGQF9W5Q2Z/Yiu6OMbWRliO/vguiTorNIV3EmcfjtkF8K1tJ4mRKZRLj7kkbtAhwB3WtlQ/C8Rsqg5rY2SIpb1R8VT2ly6RlvRNHJc+VpRCjpTwiUG3nqU2+mtDsyqF9YjG9JZWejh4n4URyZIGD88VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981226; c=relaxed/simple;
	bh=/7VZOfTjkqFrvQGO+VcQiK5v3pfWkJPpceRZup3kDMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHTYAzLskmalCKju7nRHkOy/+pYD5RaMXgkKli40lOtrtzxmX1ukWTY2iUFbqoMpRlq3ky2CKLiF7wJTYB8TbxgIy/MSs3G7NKU5AJBG1ieHLdMvZnpoe022PhrAD4B19X1qnRhvbm7ZCL5oWH9iViIqo7kWCWjDXebTlRovjUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P30s5mo3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P30s5mo3"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb78ead12so136297766b.1;
        Thu, 04 Sep 2025 03:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756981223; x=1757586023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLXNr6DcughxgQYHcpM6bNmvnj3ju0Z3KcU1SI8PI2I=;
        b=P30s5mo3/iHqdA5ftQ/mkLPKBJaN8RJ41Pgv82AIP7SXP4pl1Wx2CwgR7UCLm4hGKf
         btJh5yL7lsjHJ/NtogoYcFswCJQFWaxdX/qZexQWeWMrxWowZ9HIisfSTCeXg6teD5Mc
         MVTYm+0mkk7ge/DwYyosaKGoidII/Jjnrl9ddkSU7g9exs6VIGnxM0rl63LGSWzng6to
         mBeCsX46r7sEyvHwbcMVdNONGvG0d1I6oTiExHSPAuvh7VlLCudD9tVwio3pvgJ6/5BH
         cxD+BRlb/xPXRXrOMSXLjLYX9oaGJK89cvCWZg/Oiw4b33i4nFAWw7tbqev1S0jJfnL4
         punQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756981223; x=1757586023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLXNr6DcughxgQYHcpM6bNmvnj3ju0Z3KcU1SI8PI2I=;
        b=JP3HYDHJgj3/YtNRUCMc2Oo4Ya+gZ8VjrBRM2dIC0iy+PZ2CtHsGvkE9oUH3kJz+s8
         AKiQVkNwDzoMQwxjyiCMMw904QqO8DuOjFVm4Ipm9pbYdKNmj0tVCf1N/vsumrTjybHh
         1+AiywJm38P+ixebDkz1CkraQWWUidHnBOoDmqr2Fz/iqXXi3oIkHPTHWYnM+9UNyhRv
         nKu5UhCd6Qvk9ruz8iMRaPRkBUKlkaPQQO1NSfgkg+rBIfCE44EIHW7iiwBPufFNK5G4
         OUvjBD9cV1h2bXvjQU2Nc9NaEUVu7V+HVotr8uH0Ptl850f4clNbdEzlbvBBomNkqE6Y
         Sdbw==
X-Forwarded-Encrypted: i=1; AJvYcCU+vuM2RXJxbrLLfYF2vqSjh3LJCUCGqpnr9BQ3j1sgyxbk9VqrcelOGSfe2aeu/8RP8Hm4ail7QhH6T70L@vger.kernel.org, AJvYcCUnF26kskxnXievdydVzO84zCbv9c/phZXP27iXBs2eMOtslIenF7yOCzlHBs6eiIxUrkaqkERjVn1qG4ca3Fs=@vger.kernel.org, AJvYcCW1j7mBfmpX1oATNUn14uoH1COB4fgA/sEw3cdWaA6rH3aZlfgKH4Q22uGVZyJUGb5PTB/7T5Hok7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdzOyHFYVzpefBIzgvvuGdZdvGPpVq3LqFtIz1FJ17R2qV+WYR
	+0HK90/uqct/pBiI9zpDS3J0XbgtrfjlQjqgzgEClPil5hU+EF511jDDgHNrlO2m6T8vj1apmrk
	S/H9PayrmyQVzzPAYYsPbJDbnxOSyKVg=
X-Gm-Gg: ASbGncvJ8O+CUpkS4RfEyNH1B/362VZum1Zqc+Bhq8cDhNPbMGrua9i36OKAGE6/PYI
	waQbzTyjnqWOSb5oMG297fCmXx6g3abUvDw3GVZz/D03gyP3pHGBKQ9Py1fmVUUGLbH2iH/E2FM
	4zH8XpSQTMrwDmR0C3HEbjh7xFp/UxbwLsMhR8TVx82gsuQvg/iEU8Gghmp8pqExvzgGyh3Bc0R
	Aj7Qj/6dOs3rpMD2MedYpD3F3gJfQ==
X-Google-Smtp-Source: AGHT+IEk7fWOFV4Um68BMty3LJCedzVmGNzicP78ViMK98xsnWSZKOACZhVoOy6TZ05whSV1aXjHM0zLDjwGeDT7uuc=
X-Received: by 2002:a17:907:2d11:b0:b04:545d:8bd4 with SMTP id
 a640c23a62f3a-b04545d9dd2mr925400766b.11.1756981223174; Thu, 04 Sep 2025
 03:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904100109.688033-1-chenmiao.ku@gmail.com>
 <20250904100109.688033-5-chenmiao.ku@gmail.com> <c0a6f1960a39ca6cc84764614cfd8ccb0afc24f9.camel@sipsolutions.net>
In-Reply-To: <c0a6f1960a39ca6cc84764614cfd8ccb0afc24f9.camel@sipsolutions.net>
From: Miao Chen <chenmiao.ku@gmail.com>
Date: Thu, 4 Sep 2025 18:19:45 +0800
X-Gm-Features: Ac12FXwgBkz7B3VOBtSN4Pyb7wTQkRjVcUl3cS-VMuGvJjw9bpEUJyvhXhlLlAc
Message-ID: <CAKxVwgdPzbN4kc2rKxpdG7ONf4BxPCpaAsSQncDsyeW=034cpw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] openrisc: Add jump label support
To: Johannes Berg <johannes@sipsolutions.net>, Linux Kernel <linux-kernel@vger.kernel.org>, 
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Sahil Siddiq <sahilcdq0@gmail.com>, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your review, Johannes. You are absolutely right. I will
wait for other people's review comments and then make the changes
altogether.

Johannes Berg <johannes@sipsolutions.net> =E4=BA=8E2025=E5=B9=B49=E6=9C=884=
=E6=97=A5=E5=91=A8=E5=9B=9B 18:07=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> So I'm not quite sure why I'm CC'ed, nor do I really care much, but
> since I was idly reading through it anyway ...
>
> > +             if (unlikely(offset < -134217728 || offset > 134217724)) =
{
> > +                     WARN_ON_ONCE(true);
> > +             }
>
> Seems like that should just be
>
>         WARN_ON_ONCE(offset < -134217728 || offset > 134217724);
>
> since the unlikely is in there already.
>
> > +     if (early_boot_irqs_disabled) {
> > +             copy_to_kernel_nofault(addr, &insn, sizeof(insn));
> > +     } else {
> > +             patch_insn_write(addr, insn);
> > +     }
>
> (and maybe that doesn't need braces)
>
> johannes
