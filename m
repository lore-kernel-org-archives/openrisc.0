Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F30EB64C
	for <linux-openrisc@vger.kernel.org>; Wed, 17 Jul 2024 04:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721192297; cv=none; b=NvGBgqNWy5mqPCCqnNQEQ5dntB2uhENukyXCTZwJ1QR6lsR8JhmKbC9UX34rdxXEdZHf6mk6mvnj3ax7IMe1jD46rh/n9+G6O02/7wFMQIIHIF3k+pRi4uEBLiOgUlfPT88CAhEIi8pjr5ptOjiPMsYrHWzluUh3HXwYaO8BgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721192297; c=relaxed/simple;
	bh=vABRMnRmbUscNHZGwHRUTWrzrPZYmjEVucxlkyKGsgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Azbf0rdu5DEOAZpUSnhsdb4skk806a8G1eTnoVERPXBU5KJGaj7z3Uz7vqP4xB5o41LdXdq6Scl9rNRSh8cqteHpVHazTzVEV84kIfyrRcPBwyOZOzT9BH8QYbUYjBAIKUaBKP2yytT04Uf/Pp3Fvc6wIyzWfKORzgW+9YqClJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f8yPgeit; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f8yPgeit"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ea7d2a039so6634618e87.3
        for <linux-openrisc@vger.kernel.org>; Tue, 16 Jul 2024 21:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721192293; x=1721797093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EAXDs4QhymT5qdSIqwghPBIT7eGCMQME0KsEWD+9hyo=;
        b=f8yPgeit0trPzf158mBqmJrixK99hTAkVQWEJBF7IGRUhObT2moHckMFsWDXHW06qi
         pDj0PhhQGv/QgPVG86oQOs3G7msAs52ca66pnqSDSFcieSy0841w3J/H4vO4t9ZH6Upr
         /iwTO1Z07JhObsbU1W2dhBgmKuuWHrb6Et6q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721192293; x=1721797093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAXDs4QhymT5qdSIqwghPBIT7eGCMQME0KsEWD+9hyo=;
        b=unLD6a4AhyPJ2CcNP1H3hFr7/WVUzL+VXfQiXzFXsAkCwNzz8SEb8czIPEavFzEk1C
         DszMeHJWSKO5RSKVGMndp+KW7LnAgIU7POXS2hpK9O5iBpG6hn1z62TgBY9UcLZ6RtKl
         eMkw2VIZb6mMHUd+Q8YTejpw+B5Z5Q4rvr3/0nOkh9rfgScu4Ol/iXoDbTF8okv8waLJ
         tGFMm52SBL7Z8xehFtDVGMwGczdmUcxhgVRszLxAbqmi/5I0N/PldYvGIWN8RVbR9+uN
         0h7pvbRIPI4EHLIBZ1PkusMi8oB7T5IDK3M5cXuYThEgFnpfZQnTHU9VKpMStmwRVMTh
         ZC9w==
X-Forwarded-Encrypted: i=1; AJvYcCVo3RJ/FRZk0VUnczFGFntY3fWAqZWvroPKm/rhSWd1GTvrwYjWt7AocD9s5erdWENEAVLPaN6ulLNd+cZjczSusotmbosBRMqR+EBsJ+E=
X-Gm-Message-State: AOJu0YyV9XT/kFHYZPeLjCl5lJcwfbUdypL6XhLtl0ESDKnNiORKqJ3G
	X3cs4y03ZF76RLVNYDrqZvfujMAuZ2sbC150Oe/sZSnF0B/N912VpP3x+qTZa4DLQJl80eado6A
	8EyrsLg==
X-Google-Smtp-Source: AGHT+IFPtF4OPLvXzHUQPT8pq554jfRO8I9NnE3W/4wBpCtzfHdstEr0fmVi6wXtC50Ju5xoRcCRXg==
X-Received: by 2002:a05:6512:1294:b0:52c:dac3:392b with SMTP id 2adb3069b0e04-52ee53d3715mr382474e87.33.1721192293333;
        Tue, 16 Jul 2024 21:58:13 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc821650sm399286566b.195.2024.07.16.21.58.12
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 21:58:12 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-595712c49ebso7492924a12.0
        for <linux-openrisc@vger.kernel.org>; Tue, 16 Jul 2024 21:58:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOx9ZST/XP/aJsx/j68u0ndXjmbf7L01MLi/ItVRJCdvaANaN6HUN6KZIi8XDIH0REPWkAVi0aGZro9VoehKQoLvKKP2CW7+SPBIrBTYM=
X-Received: by 2002:a05:6402:5244:b0:57d:4d7:4c06 with SMTP id
 4fb4d7f45d1cf-5a05b7ee599mr504374a12.13.1721192292251; Tue, 16 Jul 2024
 21:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
 <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com> <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com>
In-Reply-To: <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 21:57:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
Message-ID: <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic updates for 6.11
To: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, 
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, linux-snps-arc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 21:44, Arnd Bergmann <arnd@arndb.de> wrote:
>
> I don't see those either (this is an x86 defconfig example):

Note, it really might be just 'allmodconfig'. We've had things that
depend on config entries in the past, eg the whole
CONFIG_HEADERS_INSTALL etc could affect things.

And yes, I build everything in the source tree, so $(obj) is $(src). I
find the whole "separate object tree" model incomprehensible, and
think it's a result of people using CVS or something like that where
having multiple source trees is hard.

              Linus
