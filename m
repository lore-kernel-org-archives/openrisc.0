Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404801494B2
	for <linux-openrisc@vger.kernel.org>; Mon, 16 Dec 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364133; cv=none; b=LmBGBgPLHYFlOqA3J1i6Hlp+XFJh1IgE+fYd9cjN6k6OQgcE10tJqGq4coP9EQn8PRJWmSesjhduiL1udKDBOkDKndqqK0u/xwPeOVWoIQkLyKRtGlE4OlFRk0JWMWVn/sLlWwrnKvE/55Mk4vrifViuVoGxvYJcbjIqIquik+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364133; c=relaxed/simple;
	bh=V+wDFmwNRYd+m7wHy0D3er5sMV37cyOnjkIkvuz3Lac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=p1f2G+B4z1sOcHLVqfryl4b3qcfwFhv5stMUX1Rk61GPZM7PQOISfJTJD8D4Y8OPpisOntSbpyQ8uDHQR155NV67qHPdzK52+CN+umtRZjTlGmLl9ZtmOebqcnlDYvqFrwrB0SXDKDv/UGFgfffsCU6ANOLTKomPa9A5Ql0j5wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OinfGi+3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OinfGi+3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734364130;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=lFm5HpTsWESvNkWQYlTUFvGnaXfJpwRxg7eAGO97YfY=;
	b=OinfGi+3OULaSWQ/eOtN499MjFEHitsvn0CujnGr080hCNoL6TI37yLMMT+GRsJP/QLXhJ
	4Cjb8Tk2eagYOL61z+hJ+F16NLQlqRx0c3pMvbgYjm1xMq3ByLcAbNZ7p2Vs26BcFzp0+E
	QDgERZe5tUH2N0/98b3Lg1Z33sd4xlI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-R8rKRRwnN-KbkFIWeFE5fA-1; Mon,
 16 Dec 2024 10:48:48 -0500
X-MC-Unique: R8rKRRwnN-KbkFIWeFE5fA-1
X-Mimecast-MFC-AGG-ID: R8rKRRwnN-KbkFIWeFE5fA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8967B1944B16;
	Mon, 16 Dec 2024 15:48:47 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.194.155])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 362BF1956052;
	Mon, 16 Dec 2024 15:48:47 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D465AA8088D; Mon, 16 Dec 2024 16:48:44 +0100 (CET)
Date: Mon, 16 Dec 2024 16:48:44 +0100
From: Corinna Vinschen <vinschen@redhat.com>
To: Stafford Horne <shorne@gmail.com>
Cc: Newlib <newlib@sourceware.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH v2] or1k: Fix compiler warnings
Message-ID: <Z2BL3DQ_AFImEgm4@calimero.vinschen.de>
Reply-To: newlib@sourceware.org
Mail-Followup-To: Stafford Horne <shorne@gmail.com>,
	Newlib <newlib@sourceware.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20241212162303.2099025-1-shorne@gmail.com>
 <Z1_9IM-ya8DuQIl8@calimero.vinschen.de>
 <Z2AjopSyWJf2B2Xr@antec>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z2AjopSyWJf2B2Xr@antec>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9zJu3mCm5KnIfZVyWkgrs4oMEbTLg72rhR-VYFtozcw_1734364127
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Dec 16 12:57, Stafford Horne wrote:
> On Mon, Dec 16, 2024 at 11:12:48AM +0100, Corinna Vinschen wrote:
> > [...]
> > Just adding the cast silences the compiler, ok, but the question is, if
> > the code shouldn't use void * directly for actual pointer values, and
> > uintptr_t as numerical type.  Not only to future-proof for 64 bit, but
> > also for readability and correctness.
> > 
> > Also, even though all vars in the code are uint32_t anyway, the code
> > recasts them to uint32_t a lot, for instance, line 44:
> > 
> >     } while (or1k_sync_cas((void*) &_or1k_heap_end,
> > 		    (uint32_t) prev_heap_end,
> > 		    (uint32_t) (prev_heap_end + incr)) != (uint32_t) prev_heap_end);
> > 
> > So, still using sbrk.c as an example, what about this?
> 
> I agree 100%, I mentioned this in the commit about fixing compiler warnings. I
> mention:
> 
>        23 | uint32_t _or1k_heap_start = &end;
> 
>     This patch adds a cast, which is safe in or1k as the architecture in
>     32-bit only.  But this code would not be 64-compatible.
> 
> I think in general the code is full of issues using int32_t for pointer
> arithmatic.  But it will take a big patch to fix everything.
> 
> > ===== SNIP =====
> > [...]
> > ===== SNAP =====
> > 
> > What do you think?
> 
> Thanks, I think this is good, the public signature of the or1k_sync_cas function
> is:
> 
>   uint32_t or1k_sync_cas(void *address, uint32_t compare, uint32_t swap)
> 
> So we may get warnings about the mismatch between uintptr_t and uint32_t.  The
> function is implemented in assembly and the instructions it uses are strictly
> 32-bit even according to the proposted 64-bit spec. If we were using 64-bit
> pointers we will need to have a 64-bit CAS operation.  The signature should be:
> 
>   unsigned long or1k_sync_cas(void *address,
>                               unsigned long compare, unsigned long swap)
> 
> Is it desired to use uintptr_t everywhere instead of void*?
> 
> Either way I think your patch is in the correct direction.  Maybe will need to
> keep the casts when passing to or1k_sync_cas for now.
> 
> Would you like me to test this out and send a patch?
> 
> I also looked around other bits and found:
> 
>   libgloss/or1k/board.h - uint32_t uses for addresses
>   libgloss/or1k/include/or1k-support.h
>    void or1k_icache_flush(uint32_t entry) - it 64-bit this should be 64-bit
>    void or1k_dcache_flush(unsigned long entry) - actually ok if 64-bit,
>                                                  incosistent
>   void or1k_mtspr (uint32_t spr, uint32_t value)
>   uint32_t or1k_mfspr (uint32_t spr)
>     - these two are related the MT (move to) and MF (move from) special purpose
>       registers should use 64-bit ints (unsigned long) on 64-bit
>       implementations.
>     * Note the spec mentions mtspr in 64-bit will only move 32-bits which is
>       wrong and the spec needs fixing.
> 
> I think many of these are fixable, though the signatures of public headers will
> change, the ABI will be compatible though.  What do you think?

I just wanted to point it out, it's entirely your call if you want to
change this.  After all, it works, so there's no pressure.


Corinna

