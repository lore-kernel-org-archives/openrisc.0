Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9491224DD0B
	for <linux-openrisc@vger.kernel.org>; Wed,  4 Jun 2025 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749024769; cv=none; b=DMgF31uR7rQQJSEU543tMYZ73wZAYc8JCogMsEli/T1ljXwW7i8lDWb7QmnBuoWExhSwrGzn0f9iWULQPe7vHmgbTnMhHFh5rhQhGfSfyalWG/s6Vzrr+Mj3UfWzsu56xgxJ60YCPZM1xx3dFe6tm9hyLSg/PlsFCH7BczG2Xdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749024769; c=relaxed/simple;
	bh=Ypq6eX9nIlsTs5MECKnoooKGIl+6jVwGnBOhyPBVB9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IpVa6zJ/DmVjsXFSFzFYHuxjEwTXY7ehWByjsr4PVmF9QhECBHxjsEAPiSnlqtGM+OJ5gX9Dom0vHOYOMbmVn0MR7sNHUTJe8xs67687c0A5xFisbVZDl6LdNLqhqAX8jFjHkvsejWIv0If4Ict517gHR/WslKJV3JdB/ZeN9/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWaHO4hw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWaHO4hw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749024766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wvgVOukUEEpNaUkwE3gsYqCFfAQ70mfdaWg/jB4/Ezc=;
	b=VWaHO4hws27QArKyeUeOQcLcHjWNqDbTisv5nj8YwADYIbgFH4hOdB8v10F7Z24xmSqLlH
	1EWwHkNb9KPuW0lTcR5NrLE0qd8nc6moDjLslZWOUFngPLgmt6ZG0khODxg+pQkoc4WsSE
	ZqGyDE4PcVdu4AtCqdxePP04dHkR4hw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-lfRzkQ1zPOW5LeqWZcRm2A-1; Wed, 04 Jun 2025 04:12:43 -0400
X-MC-Unique: lfRzkQ1zPOW5LeqWZcRm2A-1
X-Mimecast-MFC-AGG-ID: lfRzkQ1zPOW5LeqWZcRm2A_1749024763
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450d886b9d5so18329145e9.3
        for <linux-openrisc@vger.kernel.org>; Wed, 04 Jun 2025 01:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749024762; x=1749629562;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wvgVOukUEEpNaUkwE3gsYqCFfAQ70mfdaWg/jB4/Ezc=;
        b=hEt1I0i+dbADoxHMMh7VOL8HxsKFMGZHrTQcems+SE0no6yG3evZNKnr0G0pnd5CyC
         H8HVkaqWQmK21tPVBMrXqPbINlX897/UqMtcGvd/hHS15jPvFK0TQQwhmftrk8qjSXmb
         o/CdDk5KgDona9TkjkTCn9Lh4Xy0a/8crf6vqwjZUoaJEu1d3F+DC7jyLlf9l6t70DdW
         PUuBnPO03r1WvFRZSdr8cMow+3uANutxIib6hlCYarF9d36ZvDCKIlziDuYkwlvpv5LG
         m+1tQ5CuJTD2ydn4k6CSgS3oPByTCowL0iewFr1iOCKc1EUwqjUm3SfWjarJNC156fGL
         t8MA==
X-Forwarded-Encrypted: i=1; AJvYcCXUk9+A/9Ts6KxfyRU8KAMIgC57wpAXqZBuiuoRRjLjXGTpurzv+oFAGy8KIWSnhwwYT2FUp16Mo6++jpsgVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+1YSrAXpDvD0jNYG76kBgPYR05HVczRO6D/R85BxXJf9Z7t0
	dh9DgTEWFW8CIUWbGZA4CIvOa2T7MSfY0AZYOnVAIbi38404PoUu8bLhdCtcp8JBLArZ+tm1xKW
	D7pkCW1lSQ3fK2YKZrTEOI/86JbnMIVGcwcYbYtW8SRVdmceunORAHFucHnRLe6dBD6nl
X-Gm-Gg: ASbGncsR3FRSLGWgDwfJ6iyJ+zzHoarDlmFdi3DVY0L1SVOA85V309QK2M+e8Muhc5n
	jf8i9H2p3vAagCg0MtN8/XPAureQwZczX9gof7AV/3/snLYa0bovICg8I1vSQ+L/cCYRy4KB8O5
	5jnwyonjGbDAyyFzfPZnjo0wmcfDyeE9iWaMg8c4F4y1k1REXhKYCnGth1aKKMLS5GYoixx+bbw
	PUyndGmEt7ElRKv0kXvREzvHA++rTrDU0KFzEru6M+iTssYKs3IRhcwHUo9RuxwJxrQJ2Pz7XIf
	YDqNBpW8ypt3usRYc2Tj/1kJ6IvZ9m0L55f3WyasGE39lYmIiF5+d+gVyRJaEkA/1aOSXLcv/jm
	TuD1G/jvc/to2i2dfulVLpDZBxj9wRyOBUafbqRE=
X-Received: by 2002:a05:600c:1c9c:b0:43b:c0fa:f9dd with SMTP id 5b1f17b1804b1-451f0f9ed22mr12282535e9.25.1749024762581;
        Wed, 04 Jun 2025 01:12:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzb/FDz43e8wFgbzlacj4yn5C2qA7eJyJaco03PXI5pILsFZJQX31j60ijcZDaWL3tTDSZDQ==
X-Received: by 2002:a05:600c:1c9c:b0:43b:c0fa:f9dd with SMTP id 5b1f17b1804b1-451f0f9ed22mr12282135e9.25.1749024762069;
        Wed, 04 Jun 2025 01:12:42 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1b:b800:6fdb:1af2:4fbd:1fdf? (p200300d82f1bb8006fdb1af24fbd1fdf.dip0.t-ipconnect.de. [2003:d8:2f1b:b800:6fdb:1af2:4fbd:1fdf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8edebsm188022035e9.6.2025.06.04.01.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 01:12:41 -0700 (PDT)
Message-ID: <764d452d-446a-4b5e-aa03-e0d901126931@redhat.com>
Date: Wed, 4 Jun 2025 10:12:40 +0200
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] mm/pagewalk: split walk_page_range_novma() into
 kernel/user parts
To: Mike Rapoport <rppt@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Jann Horn <jannh@google.com>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mm@kvack.org
References: <20250603192213.182931-1-lorenzo.stoakes@oracle.com>
 <51ec4269-b132-4163-9cb5-766042a3769d@redhat.com>
 <aD_-qdg2OvKQIyRg@kernel.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aD_-qdg2OvKQIyRg@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tDUg9qvNPru8fBUAMcx1141lNHURUJ3OjjV0xVtGwls_1749024763
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.06.25 10:07, Mike Rapoport wrote:
> On Wed, Jun 04, 2025 at 09:39:30AM +0200, David Hildenbrand wrote:
>> On 03.06.25 21:22, Lorenzo Stoakes wrote:
>>> The walk_page_range_novma() function is rather confusing - it supports two
>>> modes, one used often, the other used only for debugging.
>>>
>>> The first mode is the common case of traversal of kernel page tables, which
>>> is what nearly all callers use this for.
>>
>> ... and what people should be using it for 🙂
>>
>>>
>>> Secondly it provides an unusual debugging interface that allows for the
>>> traversal of page tables in a userland range of memory even for that memory
>>> which is not described by a VMA.
>>>
>>> This is highly unusual and it is far from certain that such page tables
>>> should even exist, but perhaps this is precisely why it is useful as a
>>> debugging mechanism.
>>>
>>> As a result, this is utilised by ptdump only. Historically, things were
>>> reversed - ptdump was the only user, and other parts of the kernel evolved
>>> to use the kernel page table walking here.
>>>
>>> Since we have some complicated and confusing locking rules for the novma
>>> case, it makes sense to separate the two usages into their own functions.
>>>
>>> Doing this also provide self-documentation as to the intent of the caller -
>>> are they doing something rather unusual or are they simply doing a standard
>>> kernel page table walk?
>>>
>>> We therefore maintain walk_page_range_novma() for this single usage, and
>>> document the function as such.
>>
>> If we have to keep this dangerous interface, it should probably be
>>
>> walk_page_range_debug() or walk_page_range_dump()
> 
> We can also move it from include/linux/pagewalk.h to mm/internal.h

Agreed.

-- 
Cheers,

David / dhildenb

