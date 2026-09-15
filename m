Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E693A1683
	for <linux-openrisc@vger.kernel.org>; Tue, 15 Sep 2026 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513340; cv=none; b=ashiyWC0cFaupmGv+dVQ4BrrfNc26wnLVO4p+H/rGc/junu6ZKLmGab7hRLGyWf9No6Y/EFD9A5J0v8metQ612qOqBMcbPlFIorNr0eVKwHgBPeO69EyHa8ni+ifhxyNW2kBjmQxwvI8cbshimZUFJrM/Ez895lgN7qNxFzNjh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513340; c=relaxed/simple;
	bh=ITz7hBythv5OWTbmQ9c4e1mzRPysX2+YTMbCrseTj6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3xcsar8APemXROXqQ7GqNdsWfAoFg47SXhe41yUsnihW4SOg7xnVM7PITZobtf6UOmAfwdHDOZpizuV3tDvsvunANK+jXFdwzsPstyyEyjUG3UpWC10FCq3RN5qYhOx1b4UbYcWdgu+q3YGyIwE+57jNw+7NextjuFMRDcLrEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EEmPNcZ0; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EEmPNcZ0"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a47f740839so2894751fa.2
        for <linux-openrisc@vger.kernel.org>; Tue, 15 Sep 2026 16:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789513336; x=1790118136; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=EEmPNcZ07slgfqhm9UBsjxIGwW2LwchTl+FuKBG3uQXf2MuVdzxoWzB426lr4Ug1al
         F18LAron7THgVVPfooy58x8djvklyJDz0bdKbltsOWemvfvVnH6P/Zw2OciJ66z3Quz1
         vXwIh1ZcI0oKREhsW078gfBweYXrh+SU0tiAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789513336; x=1790118136;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=V6dItpjocTfkEUreVlmYtGRBtYOj7IVAJmCzaP3S2RJMVtwEqbJlUQWAalYFn3i5is
         dprMw9Op37HQ+iFxr/RBx23ZzczwTsapHizGrd5UjmUfS3w2LiXoWtfBzsDdhYBX00yF
         RBIE7BrnY79FeADchGMjrIvqvuIceo1MORMTmli1YOsIr2OECKJFxy2m7o0WdyzZthVF
         3MPLErmkH9ETeczKOsYadH381z8RjfhRjcyIWVbyYpv3YghYilOoDGYGMr+pA0z1kMzN
         WAPg9hVFTzpnD2F0JQMR3h76bl/loNFMU/E83h9J2bhk8ExNNWzjzLzz6ZdJfLs+68ok
         gNxg==
X-Forwarded-Encrypted: i=1; AKwUvBxz0bYbWZ5sVwStEqxAR8eSKk0SIS+dy9U3UO3yecWG91E/1kpeXMwjSlpwQ0GM6GM4qR8dBEjWOOTpB/cPZg==@vger.kernel.org
X-Gm-Message-State: AFuF++lK7DhQavBIwxHzCcF8FwjTl7guSEs1aNVPiIOMqcaDsJ9LOUto
	rBShu3wG0ZkP7iF4JpNaN3JY0o4JyMlRunoXbilgEv7usw6bJ8dy/mIwVEVvPsRP1itKU6RFTI9
	iGqE3xAMcrA==
X-Gm-Gg: AYBFou36bGmQ8C9FniDyNymQchwwgmSM4VUe7GcijBPngSeEM9wwk4Iv6FJNqk8z7fL
	FUC64stSkcOES76iFdpMe6B2kckN+KGPjkSfvVJSMGh9FwPCi/bWeotrz5DHEfQrGetR9m6a1+z
	YweFF7PvOS+eanWnnCYVJfpq1eUwyfBEp7OrUNV1YPSC/xXWEuqgcgYq79eGcBDR65dvvbjp5wb
	g6JeEBPNhDZ/mUeG+Rggids2x6ybajXYHhL4xfFVn1IefSNYc2/Y8ZxVRXUm9225kwcU1lsSb1k
	G819sGHD6SVgqoCCkuZDCDjdIg0aher5DZwtiIx0/E5IbuKQPXNcrHiT6Kcp6YcTHifPKHS9gjc
	E5oKeqZW3527I0CSecB69uWgLoqsTmBhZzZevrzeoal06VY3WBxo/HFnqmLZPurRQMO4Qo5cxZ2
	OQQHWTTTpjwy7bYpWZVoRBxvI4Yj0LLhIibQI9CARs1zIsgkRrIOlbGgbQHxQ8uwcC56mleHfnn
	m83fA+skFIn4O3KfIvC8yM4bE83e22ne4SJUyuF8wnCUo+s1A==
X-Received: by 2002:a05:6512:3b88:b0:5b8:b37f:164 with SMTP id 2adb3069b0e04-5b8b665047cmr36667e87.48.1789513336258;
        Tue, 15 Sep 2026 16:02:16 -0700 (PDT)
Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com. [74.125.229.205])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57d7cc4sm296674e87.53.2026.09.15.16.02.15
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 16:02:16 -0700 (PDT)
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f1744eso258726e87.1
        for <linux-openrisc@vger.kernel.org>; Tue, 15 Sep 2026 16:02:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwDT2OCyYQNL4fAPOZpiv7kL6W7dCCMaAESpB1FbrnqVsOkebD0AAi6T6yoD768qzlRozhM3+WgW6c09cepQA==@vger.kernel.org
X-Received: by 2002:a05:6402:5d1:b0:6a9:a6c0:e5ef with SMTP id
 4fb4d7f45d1cf-6aa2244ef06mr218172a12.37.1789512913950; Tue, 15 Sep 2026
 15:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com> <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
In-Reply-To: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 15:54:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
X-Gm-Features: AcwNN1Wx2MaYDtFtmeOlL6MnzYY7doY_FEPpziKatTBWbLOeKsjmritQ5JuAL3M
Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: rob.clark@oss.qualcomm.com
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
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

On Tue, 15 Sept 2026 at 15:21, Rob Clark <rob.clark@oss.qualcomm.com> wrote:
>
> With fd's it is more than just about error rollback.. exposing an fd
> to userspace mid-way thru an ioctl is an easy security bug to write..

That isn't very common code. It's something that is done by a few
strange cases, and yes, those cases should just do it right.

But "those few cases should do it right" does not mean "make a whole
new subsystem for this thing that makes a simple "open" actually be
slower and stranger".

             Linus
