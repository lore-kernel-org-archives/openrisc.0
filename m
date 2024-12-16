Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F471B6D10
	for <linux-openrisc@vger.kernel.org>; Mon, 16 Dec 2024 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353833; cv=none; b=aqA8en9zy6ZnRl3td++glGybwz69JWhW4s3c/kzWrwszl5E5fM1BoOCpIQ9Jkv3QFSWLLrhfLNhPRgXBzX8qoRFySG2RdOxYUeHiccnM3sCES5zltVjgjblw05B0068pflArK8W2RIz9NsoRZ1nUG7ky15TfI2VOF2BOAkJvTn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353833; c=relaxed/simple;
	bh=Ty9+jbaNvgYywhK1/U1k0NcLjx0l6f5fECl6MI0TsDU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpsCf/t94NaZe2kqvOnG7AqTUHbnrvdD0IVfBSuuGkAQLs5l7gIXgs9CwKRG1UAmLwMP/8SRiKFxojekTA35FiJprue9SMnnOsgxlTuPnlezeN4q7G2TvwPdctwqbz9eRc1UyaFqBUJTq1CkYLSmwZUk+2dthENpukj50IzmDwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMH6cBGq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMH6cBGq"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361c705434so28862315e9.3
        for <linux-openrisc@vger.kernel.org>; Mon, 16 Dec 2024 04:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734353830; x=1734958630; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiAdinhBLBXIatkN7bB0RBKN255RZuUYD08gpCNkywM=;
        b=OMH6cBGq8V1o3mxEionyzNHUfu2OdyyalUD4mFe0G+En51n8WvCLrCnd/V0AMX6A5n
         kXnGiDorTeHBb/1Fh7p+vysB410Ec7j50rA34/fiKghXEWfhuRhiZ69yMHMzxItTxdY7
         sK2KMOl2cy7BSLpLwOCzFxITE5xMHUdyUdli8ykbnHLX/JfLWXcVyaL3KnwUJrWs7Nx6
         gh9ug38AevyPrGS2YZktLAB0/IP82y9itYGUaYaY3m0LkdbblVQn5gH8mguRa3u+7keR
         vBPmtVBhY+3vGDYFo/hceCu/sB7uL8Vfu3TqxgIcEEE4gONgSGH1qeK/fiWFbZ2XhyGa
         cImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734353830; x=1734958630;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiAdinhBLBXIatkN7bB0RBKN255RZuUYD08gpCNkywM=;
        b=FzcrjOJQ6HRjXc1L4PuGpSCQ3xLfJesvSqvxXSxKBUdysiw+Dqesks469AAgDLs8A3
         Z/zfTlU4laC5gdx/0m8DwrRQmhIZOHE2ol/WwELXyOrYXdq2+PU+rCatlbairXS/Lw3O
         WI3XihRxFzKbhy05IpX8NWH241oAX1x07KjsFCdN0uc6ZSEdypDAyinypWeu+EDWJK9y
         rW1XULlK+UJnt2YmCREtAaMDUhYRN7v87USsxqULO5ItjH+y6D2mw8adq+eVgRYc75sG
         1zUv2kwMUhj2LZze+C43ORkJ/zv4BirPD9eo4MEDvG+89Dyxv4hGGxC06EsezClTCifE
         yYYA==
X-Forwarded-Encrypted: i=1; AJvYcCVsmjGCU1FG0NKr3uPg0Q5ojgbEn3w7Wi0FI70yJ7Ukh60aoOAgfGymNKmrN+Q4sN0XCXySauiZugJZfkU2Jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRNf6KanuAHcJqA1pRphXe5oz6HZ2PjRmI2APdv8uCMCfQwpfa
	uPP8H/ZnHk6tQe24a3emkGt2tnVnCafwAHE/shtrFPNc06Ak7rOiMAcjUYQ2
X-Gm-Gg: ASbGncvrvgcaM0/42cyJCozduYmxnAXdc0sHfKxuCYcS648NjlPsJH+shm0lDeuFc8x
	dWCOhpnn+VU4YbzdbUHWwILGGZhvWejg+NLhqd1ztu+r2ie68SQZjww5ZJtb2FqGGvtfa6ASBDL
	L2RKE75xQ0o8f2Szt5X82G+u84MdIKkLrzvRA8hHUK0enqv3osuZnVlVMmLSlW8MYfHBZfxDVQD
	Ps0HD5wgmMUh5BEtl8BGPvN4Eu7JeepGixIFcng+wjO9O3RTokatlE+0EQcIjwNDwqwcwyxn+jS
	CZyzDCDqY9wA0ClaOX6g
X-Google-Smtp-Source: AGHT+IG4IBhEvETVzfUiiZtFhpzjE42FfxIXuqu77n4lyw1yE4VxtdIguIY1GkQhYOeTnf39OZ6qyQ==
X-Received: by 2002:a05:600c:1d86:b0:435:136:75f6 with SMTP id 5b1f17b1804b1-4362a98815cmr115550185e9.0.1734353829450;
        Mon, 16 Dec 2024 04:57:09 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625717c9fsm139399875e9.44.2024.12.16.04.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 04:57:07 -0800 (PST)
Date: Mon, 16 Dec 2024 12:57:06 +0000
From: Stafford Horne <shorne@gmail.com>
To: Newlib <newlib@sourceware.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH v2] or1k: Fix compiler warnings
Message-ID: <Z2AjopSyWJf2B2Xr@antec>
References: <20241212162303.2099025-1-shorne@gmail.com>
 <Z1_9IM-ya8DuQIl8@calimero.vinschen.de>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1_9IM-ya8DuQIl8@calimero.vinschen.de>

On Mon, Dec 16, 2024 at 11:12:48AM +0100, Corinna Vinschen wrote:
> Hi Stafford,
> 
> I pushed your patch, thank you.
> 
> However, assuming that 64 bit *might* be supported in future, I can't
> help noticing that or1k uses uint32_t as numerical replacement type for
> pointers.
> 
> As an example, take sbrk.c:
> 
> On Dec 12 16:23, Stafford Horne wrote:
> > In libgloss/or1k/sbrk.c:
> > 
> >     libgloss/or1k/sbrk.c:23:29: warning: initialization of ‘uint32_t’ {aka ‘long unsigned int’} from ‘uint32_t *’ {aka ‘long unsigned int *’} makes integer from pointer without a cast [-Wint-conversion]
> >        23 | uint32_t _or1k_heap_start = &end;
> > 	  |
> > 
> > This patch adds a cast, which is safe in or1k as the architecture in
> > 32-bit only.  But this code would not be 64-compatible.
> > [...]
> > diff --git a/libgloss/or1k/sbrk.c b/libgloss/or1k/sbrk.c
> > index 0c3e66e87..ca196d228 100644
> > --- a/libgloss/or1k/sbrk.c
> > +++ b/libgloss/or1k/sbrk.c
> > @@ -20,7 +20,7 @@
> >  #include "include/or1k-support.h"
> >  
> >  extern uint32_t	end; /* Set by linker.  */
> > -uint32_t _or1k_heap_start = &end;
> > +uint32_t _or1k_heap_start = (uint32_t) &end;
> >  uint32_t _or1k_heap_end;
> 
> Just adding the cast silences the compiler, ok, but the question is, if
> the code shouldn't use void * directly for actual pointer values, and
> uintptr_t as numerical type.  Not only to future-proof for 64 bit, but
> also for readability and correctness.
> 
> Also, even though all vars in the code are uint32_t anyway, the code
> recasts them to uint32_t a lot, for instance, line 44:
> 
>     } while (or1k_sync_cas((void*) &_or1k_heap_end,
> 		    (uint32_t) prev_heap_end,
> 		    (uint32_t) (prev_heap_end + incr)) != (uint32_t) prev_heap_end);
> 
> So, still using sbrk.c as an example, what about this?

I agree 100%, I mentioned this in the commit about fixing compiler warnings. I
mention:

       23 | uint32_t _or1k_heap_start = &end;

    This patch adds a cast, which is safe in or1k as the architecture in
    32-bit only.  But this code would not be 64-compatible.

I think in general the code is full of issues using int32_t for pointer
arithmatic.  But it will take a big patch to fix everything.

> ===== SNIP =====
> extern void *end;
> void *_or1k_heap_start = &end;
> void *_or1k_heap_end;
> 
> void *
> _sbrk_r (struct _reent * reent, ptrdiff_t incr)
> {
> 	void *	prev_heap_end;
> 
> 	// This needs to be atomic
> 
> 	// Disable interrupts on this core
> 	uint32_t sr_iee = or1k_interrupts_disable();
> 	uint32_t sr_tee = or1k_timer_disable();
> 
> 	// Initialize heap end to end if not initialized before
> 	or1k_sync_cas(&_or1k_heap_end, 0, (uintptr_t) _or1k_heap_start);
> 
> 	do {
> 		// Read previous heap end
> 		prev_heap_end = _or1k_heap_end;
> 		// and try to set it to the new value as long as it has changed
> 	} while (or1k_sync_cas(&_or1k_heap_end,
> 			(uintptr_t) prev_heap_end,
> 			(uintptr_t) (prev_heap_end + incr))
> 		 != (uintptr_t) prev_heap_end);
> 
> 	// Restore interrupts on this core
> 	or1k_timer_restore(sr_tee);
> 	or1k_interrupts_restore(sr_iee);
> 
> 	return prev_heap_end;
> }
> ===== SNAP =====
> 
> What do you think?

Thanks, I think this is good, the public signature of the or1k_sync_cas function
is:

  uint32_t or1k_sync_cas(void *address, uint32_t compare, uint32_t swap)

So we may get warnings about the mismatch between uintptr_t and uint32_t.  The
function is implemented in assembly and the instructions it uses are strictly
32-bit even according to the proposted 64-bit spec. If we were using 64-bit
pointers we will need to have a 64-bit CAS operation.  The signature should be:

  unsigned long or1k_sync_cas(void *address,
                              unsigned long compare, unsigned long swap)

Is it desired to use uintptr_t everywhere instead of void*?

Either way I think your patch is in the correct direction.  Maybe will need to
keep the casts when passing to or1k_sync_cas for now.

Would you like me to test this out and send a patch?

I also looked around other bits and found:

  libgloss/or1k/board.h - uint32_t uses for addresses
  libgloss/or1k/include/or1k-support.h
   void or1k_icache_flush(uint32_t entry) - it 64-bit this should be 64-bit
   void or1k_dcache_flush(unsigned long entry) - actually ok if 64-bit,
                                                 incosistent
  void or1k_mtspr (uint32_t spr, uint32_t value)
  uint32_t or1k_mfspr (uint32_t spr)
    - these two are related the MT (move to) and MF (move from) special purpose
      registers should use 64-bit ints (unsigned long) on 64-bit
      implementations.
    * Note the spec mentions mtspr in 64-bit will only move 32-bits which is
      wrong and the spec needs fixing.

I think many of these are fixable, though the signatures of public headers will
change, the ABI will be compatible though.  What do you think?

-Stafford
