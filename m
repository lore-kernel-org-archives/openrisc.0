Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849243A1A55
	for <linux-openrisc@vger.kernel.org>; Tue, 15 Sep 2026 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494731; cv=pass; b=p04KjIHwWMLwjgjBx9Eeu7eJzT7dSvd7daDhIxYGO2b7/5ICqGA5kLql6L8bdwdy2GMd9J6j/kDAfPxfu/48N66fOuZ+F7eJpnptz8eNIvB48vHmmT/wkGeRUhtbfCeu7pLWPHLWpKGLe68/CffzD61m7Ta7Z3a95Cf7lJAKAFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494731; c=relaxed/simple;
	bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQjsuqpLuh89DLGq0UIMVPqGWaFF7rDlCTyx+a0nDGp7IqOWW2qfh3YyQ83QxS3k9IvJ3cTdARVbHTU8OOdLNI5Ybjk0JFhGNkFzKC6DSd2iVE/X5F3WLjqsGHnjR4PplrrS6HCXX8jNj9nNST/1Wo426slVDHB+ySEqGQIQXZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPgx9Wh6; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPgx9Wh6"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db425c9050so12195ad.0
        for <linux-openrisc@vger.kernel.org>; Tue, 15 Sep 2026 10:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494727; cv=none;
        d=google.com; s=arc-20260327;
        b=l+56xEcLRVvSJUSVIreFTzFZG4m7IHnhvlj4maP8qW3cHblmOeMM+XgKXZY0cPApZM
         s+sMWl6GEarZ8rIpGDQBnDLi9o1lJNB4h0kCVpAs13AUwLMBMbDzddBbcvedFGWpLgAD
         OYuZctAgB6m4eUgN0vfF7hPg9KrdnPLqoc7zxaCk1w+OTh4xhNRxY1lBXSZUs984PbYR
         jXv1f1MqmRnaP3wTGcSV5vAGH3g+FGLxS5xVXPX91JkFBu0LRP1R5jlQ+NeHhh0VOoEN
         hXaDA7yl9qBuu2+Fn3rhgHakbDWQWLDuS+1PtXEL2coWkuH9eMKtTMvQn44pwOt/hSJg
         s7Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        fh=MBe4i3gMkjt960XxzkL3tZSg0LhIpo4xqg5GigUxMIY=;
        b=OE/nUjC5KSr4EMH3Y5ULhhtPZfO4hfSn9ipJxiTMlC9qm00mGKmWzFhzk7PJbEOmKb
         2p3opbaRsy+DMWD+MpSq6SMo3LjDsxMpBMWP0NNiCzYRDTa/CEqbrzxWiFyy8U9emnF0
         Pw35j/3vn5GA+AxzeymTOGMcjWc6qBWlNn6hzDwU4wCeblCvtv44/c9+iR2RHFg+A8kP
         ORnDDXCVhpA7qToEAG/8tY+BdLuiE6/hQIjb1iuOwKgSUXeAlA6qNYX1YVZ2ckEyVshM
         VSJhJXW6nNInCagLlp70jyz0NON7WEyBbPvOFNqo+LxwpagYHoXUJ4HwxYiBPTdEzfBr
         5ZPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494727; x=1790099527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=WPgx9Wh6g8ehXMOaZf8ZSNtevHb9fzr3lXk5INKsJirqC99dpiARLSwTsIwHA4pbMW
         JbWx8MvBxDUFu6opqA60njTwuSet+XjH0Wga4OKXeEmVhOXoy61UWc3rqiL6EU8/l428
         EjMY1UqvowxmFEZiD+cpXVE0I3gM0Ssco82ZH8FSIs0h6jzSdSLoGG2b/9Ga+W+7Aup7
         R3Y2jKX2VRyqaVjVjF8po02JGQLWYioBTM31SQGX//CGOHsZjgwuKy0KaaC3tSzQflwo
         ISJi8sLOMT0xayOGlmIx3TnuUJAs8/tTEps0xY78QDJPw7a+XDrg4k1OSruo0M4Rr9uE
         eRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494727; x=1790099527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=Ntana4U26RAjfcqmk3Gy6r9qQfZ3hF9Z6RrWTh2v/9hCwjIcwftxj0mvyC3X3IbcIe
         vFqqr32GkyR6PEhdUODGUvULlGz9CbLwyOiZt/IZSOg0LA6PFRtmEkmTBmtEz3YLI4aK
         EzPUVgsQfoAz833lBxdt1F04LNlvZiZrAWbjjRp7ftIhin18s68vtNvdRGKc5m7V9vzP
         QqWluSLCgYM3cYGQTOpVQBVgQC+0u3qjLc7ZI0WsWM9Jc4/ff2U7hrTmtU8eTk/KWmuy
         hkty6GAYLyaNazFTrUplbQHamTnCdaTKhYDihD4d5IfHZpS+xemc+05kdfShrGjajDTp
         Yxew==
X-Forwarded-Encrypted: i=1; AKwUvBxEGEBpAmOIEr9TMAae8n49I9uvKamXQ5G0Lssrmjr/uOFctNqEcBr0T5QzUCO5SjGSEcl0AYLRcLxukcdaJA==@vger.kernel.org
X-Gm-Message-State: AFuF++lgrfjGKjpuP8z7Y7E4G374lgCltliP8b+QTPvNYZxKD3yrgfNj
	llU4+D4F4/ErJwCTN5Ykth8JFYLrUTplqK7s3uj0ej+2E/oPyk8fu++SrH2BzcvbdFN3zqJoY7W
	03pxEEqWN8+9pUeZvh8osSZElq9sTr9W4x3rM6UGp
X-Gm-Gg: AYBFou37pacnKX+ybFb1jc3XXhUSNvUyQltGqMRFBNhdbQYOA0udMy1cDx/iPQtWL9q
	ZH4yKY9yCzjNlmgdwzPbfdcuBNvIRPvHcVsE14P98HKMV7zr9QShwAIsK+bdbQetXR86zbDhwY8
	u8b91KtZm+viWRTh/y3zNIFR4tiHPpfHIyxzgyQHZVlbLH8O5viswXdIUGTU/5CDTd8GySHE/YT
	lcNGxBHDmmWw1DtAfJ446YtGdpPQSqa6WRThqDYQkCyblRhkmqNYplrPbwqS+68QXCPQSO2II4y
	FRptEa8+ExaiC8umKbjYYTq4ffh+iPYPdpi/s1WX4Fp8MI/XK4AqGEzqb/n3xQVKc9WEm/zgflr
	NDDlUy0pxn5HkxK/PpGB/ywqDuGTn48mfdUfi9xtUAw2/BCZmRTw=
X-Received: by 2002:a17:902:f612:b0:2dd:5363:31ec with SMTP id
 d9443c01a7336-2dd89c0c38amr177395ad.14.1789494726332; Tue, 15 Sep 2026
 10:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Sep 2026 19:51:27 +0200
X-Gm-Features: AcwNN1Vhgv53PI2-XyXtJBbVzCNkGiiWjtvOE2b-8zHim7-UybJ3H2xniPj1VUE
Message-ID: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
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
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:31=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

I'm not really a fan but I feel like if you want to do this, you
should be using task_work so you don't have to touch the entry/exit
paths directly? (And if task_work is too inefficient somehow, you
could tinker with the task_work implementation.)

> When the syscall returns success the exit path installs every staged
> file. When it returns an error it drops the descriptors and the files.

Is this mainly about stuff like "we installed a file descriptor and
then the following put_user() failed"? Because if so, I think a nicer
fix would be to have a policy of "if userspace provides unwritable
memory to a syscall, just keep going and pretend the access worked",
and maybe have a sysctl that kills the process when this happens to
emphasize that userspace should not be doing this.
