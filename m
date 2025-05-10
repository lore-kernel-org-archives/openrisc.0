Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450251A01C6
	for <linux-openrisc@vger.kernel.org>; Sat, 10 May 2025 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746869322; cv=none; b=BbloXM3822biGBEwExHUuDlfULYfkUBzO7s6BUK9Luy8IzaeUQjwFg5pIg/owNYF5PuQztxF3why8ofNEnPqA4Oje78BOledsgtP6L+1a/SDx4bgY8TCVuHgks3PitWxy2aJvi+qP9J1YkVfC0HbrzLWKxhBt5o/g+JIeJvkcRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746869322; c=relaxed/simple;
	bh=lx2It8yRphKlpWnH+MTk/ILsOp/CZgkYsWwny3rinLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eegsI8PaFbxMRUa39erdJxI4B957kE6p48GNw5rtDD3KPdyzTDaueGM8Lygrnex301dgY0c5crNn+VbrmjA7RdbV7MW7nGdNJ4ReAQCWrN+RIZ1Xa9B8CCeM4Myi5lEU1WA+vNZBoW9M+aSF+WXzWttelCHAICxGyvlxccGiXFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRsBkFtZ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRsBkFtZ"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac34257295dso476997066b.2
        for <linux-openrisc@vger.kernel.org>; Sat, 10 May 2025 02:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746869319; x=1747474119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCYB2XkgKWbvDnLzzE+z1Ocw4Sf+LZDwMmJwrJEvIIA=;
        b=NRsBkFtZtUKc/sag2qWZ9bIVQsiIRNs5Bwdxrbq7eN741oLIoVtfBMskyYJGw8L4eC
         oYsxTZ5sCTwzYSgEIZlm1tJHkn0vW32OHjUy7svOERjRwI1Hpaynu0KwVs6ccHNUF1vm
         qs71CCgWuAbCYmW2hOdKD2rQSZqBCh2yvuybOYNto3yNBnkUXXbMF8+YufyY5rm1jc6h
         lFBQ8DlF7broSj2dYn1EJ5ZwneyCF1AAYxe4rWjm4pubWWp9Ys9pvTwjYPXyzlbE3NkQ
         QrxB7L0X5W3yL5ItIiuYlZnS7XfBVXWULp4LpX1Z6PsiGuG6pRFejwHPtQvToQqBXjXV
         14WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746869319; x=1747474119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCYB2XkgKWbvDnLzzE+z1Ocw4Sf+LZDwMmJwrJEvIIA=;
        b=eYxsAMaWGPyZI5G8fp6UPVcRT1qWPpj30wsH3klfO9YRI+gnjdNhKR5nn9/MGfBC/A
         EYeu0I1JcJuZ8+MddiVKaeTFGcAe2Uu21uXmCbziEnpLC/vIODLFQmyyoMbaV3dHmC41
         MW4i3PxC3Xa3bjdNS6uGe1ekC55KS/QsCQibozWFq7yg/9RIjw2olsh8/3XFRx7vWj2l
         BTqiCJvNyNMpt/rcOXEr36TPBlnLSsIwPNiDN3t1wV26nkiLknkiN4kHgFei7+Zf+e6F
         Ry0WDekyIrCy4sJffcEOhtm4Y4+ISlNqlEdjFa1dBeXwSp9rDk9VVGe/0mmNgOGFKjye
         X8Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXVjsoZSvrrn+hDERn1dJCxpVnm+C41kEjD6jW6YbnGiu5yNnTPVqOKv0lg1d7xVbaS+2aANTlveejOloyXtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+YfgrVoRBYe1JvSK/BMqZDqwDYV/kvGwBypVItFl9f1BHh+WF
	kKJbOa1rW5ebk4Ht97xjm1Odjdj3dS6NwxKEP2znASihuaBZQtazw2dwWJZWjzzJY8Jdyf2YKV2
	VOohyOhMlI/4GQFcse2QsGv4Kf8Q=
X-Gm-Gg: ASbGncvGkqgG5tL0zrLwjXWVNbZwfmmMiJMXrA2eTVnzGK21LoqBYigAoEIWmq4okgM
	bOZ9ABXaroJG+MsZAbvwOh0Ka/Ul6fg8NEEulANhavn7mThqkalf9B+HMfyY7649vpnTbfW8MCx
	L1H3awlipwZD/nI3FZqb7FXekvNnVBv50=
X-Google-Smtp-Source: AGHT+IGbIKhqPYodiHKkAjlnCw5shVhPsHujLwWuaRBC/O6evNUVPVuOFpZ/tL8wtCysMxoiNkhIvghr0Z5QzCxIA+4=
X-Received: by 2002:a17:907:9810:b0:ad2:4144:2329 with SMTP id
 a640c23a62f3a-ad2414424e5mr29820666b.7.1746869319115; Sat, 10 May 2025
 02:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aB5fdVgEiVZ4XsLw@antec> <b476af9f-fd7d-4a86-ae9a-5be871d587fc@gmail.com>
In-Reply-To: <b476af9f-fd7d-4a86-ae9a-5be871d587fc@gmail.com>
From: Miao Chen <chenmiao.ku@gmail.com>
Date: Sat, 10 May 2025 17:28:02 +0800
X-Gm-Features: ATxdqUEGAzVap_gO0zFC0aLJp2T1XW6O1BQVnDB2wMIpCWy7cSDJavX7OJta6yk
Message-ID: <CAKxVwge1tqbd13jNC+C5YbDJgMhfw7Ph0sTS6pD_NktPmAyTCQ@mail.gmail.com>
Subject: Re: GSoC 2025 OpenRISC Linux Feature Development
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: Stafford Horne <shorne@gmail.com>, Linux OpenRISC <linux-openrisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm thrilled to be selected for GSoC and to join the OpenRISC
community. As a senior computer science student who has long been
passionate about Linux, I=E2=80=99m excited to finally contribute practical=
ly.
This marks my first formal open-source project participation, and I=E2=80=
=99m
fully committed to making it successful. Your guidance and patience
would be greatly appreciated!

Thank you for the warm welcome! I'm eager to contribute under the
community's mentorship.

Regards,
Chen Miao

Sahil Siddiq <icegambit91@gmail.com> =E4=BA=8E2025=E5=B9=B45=E6=9C=8810=E6=
=97=A5=E5=91=A8=E5=85=AD 14:27=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Chen Miao,
>
> On 5/10/25 1:33 AM, Stafford Horne wrote:
> > Hi All,
> >
> > Congratulations to Chen Miao for being selected as this year's google s=
ummer of
> > code [0] contributor under the OpenRISC project.
> >
> > This project will have the contributor developing, testing and sending =
patches up to
> > the Linux kernel.
> >
> > The OpenRISC Linux kernel support is under constant development but the=
re are
> > certain Linux facilities that are not yet used or available on the Open=
RISC
> > platform.
> >
> > The project will be to work on:
> >
> >   - Add tracing facilities to OpenRISC Linux including: jump_label, ftr=
ace,
> >     kprobes, eBPF etc.
> >
>
> Congratulations on being selected and welcome to the community!
>
> Regards,
> Sahil
