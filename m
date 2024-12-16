Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD007433B1
	for <linux-openrisc@vger.kernel.org>; Mon, 16 Dec 2024 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343981; cv=none; b=op6r4dbYx9sbBp7GF0XZQhPD4xefq8QNmSVRyuhndZ5bXfZZ+Mcn0m137uAChS7PfNcOGc+yEli5K4C0/3m/4456ku38pb92g6h66C4zUUTQyNyAPgcM6w5zLoopTlk8TJeQzO6h82PLBnLz3fqw9KEfJHb6ICAnbT9HtZq3/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343981; c=relaxed/simple;
	bh=S4Ff31i3SY8vLgPddEQpV067mS0/98TtKSTCy2g58dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gJo3I1DJ6LpuGrCMAzigNFVbu4xHSepyXjHimK/SHpndi8YPGRQHgbEC8GLD2yhQzyW9TuXEWm9QcbqKtky4+a2gjSlNCdYFTxOD832iA78SisdoX4+mGOaQSFGtaloXJVX8sADUMTbTivE78GY9HkZ0AgF+kMGHZynMdqm3cdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JrGR8AsK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrGR8AsK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734343977;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHM32heCVJfG3JOl1adj/cgqH9gzkHVFVrCM9byVCRs=;
	b=JrGR8AsKAOuYrsKNU1tB/LPge+2H2Wu4dgsiTVZW/ChOKaPRIit+vvVRbH6Pe9ECZibqkf
	w/NARZdSxk645vQvxIDPvY2hrbtihVFkkMUCPyqzV4go3DPiqC0b68cGbGWBL+NUvGxvcK
	2OcazRPKUgMqBTUTdIT20Mn7OJCK2mw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-yL_wZKSBNMivJ-t_I3Tm6Q-1; Mon,
 16 Dec 2024 05:12:52 -0500
X-MC-Unique: yL_wZKSBNMivJ-t_I3Tm6Q-1
X-Mimecast-MFC-AGG-ID: yL_wZKSBNMivJ-t_I3Tm6Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80D3519560AF;
	Mon, 16 Dec 2024 10:12:51 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.194.155])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F9F219560A3;
	Mon, 16 Dec 2024 10:12:51 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CDB34A8088D; Mon, 16 Dec 2024 11:12:48 +0100 (CET)
Date: Mon, 16 Dec 2024 11:12:48 +0100
From: Corinna Vinschen <vinschen@redhat.com>
To: Stafford Horne <shorne@gmail.com>
Cc: Newlib <newlib@sourceware.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH v2] or1k: Fix compiler warnings
Message-ID: <Z1_9IM-ya8DuQIl8@calimero.vinschen.de>
Reply-To: newlib@sourceware.org
Mail-Followup-To: Stafford Horne <shorne@gmail.com>,
	Newlib <newlib@sourceware.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20241212162303.2099025-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241212162303.2099025-1-shorne@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7ZUM_SSFu117DGVdE_431JV-1JNX_4QAlRtqwYT788o_1734343971
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Stafford,

I pushed your patch, thank you.

However, assuming that 64 bit *might* be supported in future, I can't
help noticing that or1k uses uint32_t as numerical replacement type for
pointers.

As an example, take sbrk.c:

On Dec 12 16:23, Stafford Horne wrote:
> In libgloss/or1k/sbrk.c:
> 
>     libgloss/or1k/sbrk.c:23:29: warning: initialization of ‘uint32_t’ {aka ‘long unsigned int’} from ‘uint32_t *’ {aka ‘long unsigned int *’} makes integer from pointer without a cast [-Wint-conversion]
>        23 | uint32_t _or1k_heap_start = &end;
> 	  |
> 
> This patch adds a cast, which is safe in or1k as the architecture in
> 32-bit only.  But this code would not be 64-compatible.
> [...]
> diff --git a/libgloss/or1k/sbrk.c b/libgloss/or1k/sbrk.c
> index 0c3e66e87..ca196d228 100644
> --- a/libgloss/or1k/sbrk.c
> +++ b/libgloss/or1k/sbrk.c
> @@ -20,7 +20,7 @@
>  #include "include/or1k-support.h"
>  
>  extern uint32_t	end; /* Set by linker.  */
> -uint32_t _or1k_heap_start = &end;
> +uint32_t _or1k_heap_start = (uint32_t) &end;
>  uint32_t _or1k_heap_end;

Just adding the cast silences the compiler, ok, but the question is, if
the code shouldn't use void * directly for actual pointer values, and
uintptr_t as numerical type.  Not only to future-proof for 64 bit, but
also for readability and correctness.

Also, even though all vars in the code are uint32_t anyway, the code
recasts them to uint32_t a lot, for instance, line 44:

    } while (or1k_sync_cas((void*) &_or1k_heap_end,
		    (uint32_t) prev_heap_end,
		    (uint32_t) (prev_heap_end + incr)) != (uint32_t) prev_heap_end);

So, still using sbrk.c as an example, what about this?

===== SNIP =====
extern void *end;
void *_or1k_heap_start = &end;
void *_or1k_heap_end;

void *
_sbrk_r (struct _reent * reent, ptrdiff_t incr)
{
	void *	prev_heap_end;

	// This needs to be atomic

	// Disable interrupts on this core
	uint32_t sr_iee = or1k_interrupts_disable();
	uint32_t sr_tee = or1k_timer_disable();

	// Initialize heap end to end if not initialized before
	or1k_sync_cas(&_or1k_heap_end, 0, (uintptr_t) _or1k_heap_start);

	do {
		// Read previous heap end
		prev_heap_end = _or1k_heap_end;
		// and try to set it to the new value as long as it has changed
	} while (or1k_sync_cas(&_or1k_heap_end,
			(uintptr_t) prev_heap_end,
			(uintptr_t) (prev_heap_end + incr))
		 != (uintptr_t) prev_heap_end);

	// Restore interrupts on this core
	or1k_timer_restore(sr_tee);
	or1k_interrupts_restore(sr_iee);

	return prev_heap_end;
}
===== SNAP =====

What do you think?

Thanks,
Corinna

