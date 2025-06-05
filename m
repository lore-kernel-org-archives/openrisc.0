Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4796199237
	for <linux-openrisc@vger.kernel.org>; Thu,  5 Jun 2025 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749151182; cv=none; b=izKoghXZg/R2II4SgYanlSBw7agZ2uoJjh+khyI+COPifAERbDZXHzf8TEgfJGzWcX+KsjZpYe4ykVBTfHBcjJh9EQQvC45hMPgMlruaBTHoj0QRUgCev3RtLuR94OMKc+c0HZUlQNfRBlrV3XwsNh+suqEruu+L81Nn1LFqG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749151182; c=relaxed/simple;
	bh=RbgPHeMZvQzL3m80JGIpPWf4bxoO1tcc6Q2HUvzFDuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpVTeCiNW3IbGZweWGbrV3sTp7RrTswz1TJppsdd0XJFnZDmMzkSoAImQdndbZ6MbQoxWzrNkaE4AQSVF+SbIoLoaYUgJ1tn2MIvyF8M9vM1NnZDNuPg9umBjsxFBSRKZmt6leCl12LZj5Ugg4qsWcqpoofxxj3NDO+Hy0mnG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eZh7kqjm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eZh7kqjm"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso53a12.1
        for <linux-openrisc@vger.kernel.org>; Thu, 05 Jun 2025 12:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749151179; x=1749755979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbgPHeMZvQzL3m80JGIpPWf4bxoO1tcc6Q2HUvzFDuI=;
        b=eZh7kqjmToUxTAe2TUNEQYUQfF5h5vQFI6qGAyt3JbuNxzCpGQM8HeTBN1W7JIdhVS
         ZYqONlAW5QoNJE8guhiH5T3E5CXs9GjvDnYMbOtgyrARR+uoFB3mt1sqnJpr52doh9Mh
         a7b3BP1873Y1AlBRC9Iq7BlXNSD5RywqXGRVMEqMBagJhMbLF4vLyLYkLgpBOEQa5d8L
         TPo4nKktLcNRxwso9BjuRCGg3g62F87T29DDR040ufd0zv8MpycKqAA/JjocJyTmS8Pm
         y+A/jiWW4qdDfOP1n3rmQs/SodD3jYXkMEwniNN6TygOniGUivuoIMJaAGsg5Y8kSImb
         Ho6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749151179; x=1749755979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbgPHeMZvQzL3m80JGIpPWf4bxoO1tcc6Q2HUvzFDuI=;
        b=NuDdsCInrTWR988NLYQG8/qVdKIyeNHDwMZoVAvX9U2re1bPNBPaidiytY3/hmPgxl
         9cgXHCLU+u5Jv8Oq6O7zK6Ws0cBF2buiA1KfEc6VzAtO/cP7kYvMeZxqTrKOSOFzKSrc
         nMoQ3Ejc/I+8rRaLvoBoTqF6S954n5K+1mMQDsMjBVgkWGYye7Tx9LsOPvt2nvN8A3Hi
         OyzmRatclJSo/WMGeX18MFiPWIdJN0W8xFdtuv35sB00yggvW3a5a8Z/KhH5txol/Ob9
         RYS1mcimni+gVzkBByojDAD7MG1Pe7n5PPBSuCuX5qMPjSL5kgomPPtn+UziJ4xDCbBJ
         d9/A==
X-Forwarded-Encrypted: i=1; AJvYcCUUm9T5jJVaLDqCGOF9hum9SliCfT9df40t+ZeA7tfY2VAnWl7f5gyAjtgLw52/3pH7N/5MV+annYB7HfxpYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6pJCuB5X14DrzlNTnblZT//5tYebmTtvrtTI/MDceEVPxmv6K
	Id5nM1Pik6Ow+ZaxxO+d4KbHFRBciRAQsbVE07sDcckj0NqhgahldvSuCWeFOaNF38M8ex8RBLJ
	J2IW+OqLtSPq25zyy75moxRUpxwRlAzwZhHe50AI1
X-Gm-Gg: ASbGncsncdgX0tGJArn1wbCHoLM8y9OKXO7UiH54AnbjLGEX0eXuawkOF5GdPl9cE62
	bLUEIImGVAJNrB6/Nl8JFXGdSVEOb1Rq3iZ7m4LmrUAM2xUfA5x5hkbkYEwIc/VGH3pzuwP+I8D
	QorBif7KihbyKev2sIC1OM2cYd2RdRtPhvHxOu/iVycXZ8zOxCI5rKSZq57WUB2+6F9fTWSaQ=
X-Google-Smtp-Source: AGHT+IE6xDvvoQteJJ/eDt9iDCFywxEWUs1nTALJvRPrcfNFm/URqn6kru8JdI2hpKXp5O/+usizGPrxFzABOYx39mY=
X-Received: by 2002:a50:aa88:0:b0:607:bd2:4757 with SMTP id
 4fb4d7f45d1cf-60774f7ea9dmr10567a12.1.1749151178729; Thu, 05 Jun 2025
 12:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604141958.111300-1-lorenzo.stoakes@oracle.com>
In-Reply-To: <20250604141958.111300-1-lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 5 Jun 2025 21:19:02 +0200
X-Gm-Features: AX0GCFsuwLolzPDsrZ1E3v9TrRqv1LcU4kqKEWMPeICbN8OYkLkFBNdY22dpC_A
Message-ID: <CAG48ez3hvPbfc2dapQQu9TKrjdi5mhZ4tAWi+m0tNZeEtSZBrQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/pagewalk: split walk_page_range_novma() into
 kernel/user parts
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>, 
	David Hildenbrand <david@redhat.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 4:21=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> The walk_page_range_novma() function is rather confusing - it supports tw=
o
> modes, one used often, the other used only for debugging.
>
> The first mode is the common case of traversal of kernel page tables, whi=
ch
> is what nearly all callers use this for.
>
> Secondly it provides an unusual debugging interface that allows for the
> traversal of page tables in a userland range of memory even for that memo=
ry
> which is not described by a VMA.
>
> It is far from certain that such page tables should even exist, but perha=
ps
> this is precisely why it is useful as a debugging mechanism.
>
> As a result, this is utilised by ptdump only. Historically, things were
> reversed - ptdump was the only user, and other parts of the kernel evolve=
d
> to use the kernel page table walking here.

Just for the record, copy-pasting my comment on v1 that was
accidentally sent off-list:
```
Sort of a tangential comment: I wonder if it would make sense to give
ptdump a different page table walker that uses roughly the same safety
contract as gup_fast() - turn off IRQs and then walk the page tables
locklessly. We'd need basically no locking and no special cases
(regarding userspace mappings at least), at the cost of having to
write the walker code such that we periodically restart the walk from
scratch and not being able to inspect referenced pages. (That might
also be nicer for debugging, since it wouldn't block on locks...)
```
