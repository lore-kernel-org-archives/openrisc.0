Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F12225A51
	for <linux-openrisc@vger.kernel.org>; Wed, 11 Dec 2024 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922670; cv=none; b=lqAFKJjq9sikyHzgCWxdBBVfn5ZOOYbGdlvVj4EpUqsnk+rJ8cky7c7iIXF/SDqXZIoh04s0Zj+wcuftcwIT2ZCAatlDZaWtIpBLXBjykvghYR2L+KYMdDICD+5GmY2duWD1MSXPsBRr04GTJQeSX90gu5O4Ll38MA2IuICMUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922670; c=relaxed/simple;
	bh=RItvuvOGBcJHuogfax4IUb9LfjcXk+DpcEnc84FGqHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gNYcfpsw9DEpUhN8ofTQukM5Vqq60Os7PVTqydUNMnKdVUSlOT8sRfCa2KTmI4qTaFTnKGLx6DAWe3HyKfG2MXlyFbYlfcqvkSmWMp6bK3+IxXMXT4zxojDwyVsFhfC3yinS9PKAvjpooDfECGQzssMugWW2Dp2OBE7bVn9escY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QkeSaJOk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkeSaJOk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733922667;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mT8nk1DS1B8Yx/StAQB31khTN8yhf5WZHhThIsmlR9I=;
	b=QkeSaJOkbkM49br/QjtKSqw4zCXbLCqd6qjifsEy6j5ba7OSsG9mzK0Z9qzC0QIs6sf4hE
	ZCH6XIG02UIF5pVClzMqwy09MpHZahwPYMPy51C1K5Qg22p1z+OsmjjQ9ZUWXRMd6UgarL
	q7TQpIp4QcnNw+s/yC5hkw2b4T+FhXU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-7lyPmkd8P7WAv64oKRce5Q-1; Wed,
 11 Dec 2024 08:11:03 -0500
X-MC-Unique: 7lyPmkd8P7WAv64oKRce5Q-1
X-Mimecast-MFC-AGG-ID: 7lyPmkd8P7WAv64oKRce5Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08978195608C;
	Wed, 11 Dec 2024 13:11:03 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.194.37])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77B381956048;
	Wed, 11 Dec 2024 13:11:02 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9D179A807A1; Wed, 11 Dec 2024 14:10:59 +0100 (CET)
Date: Wed, 11 Dec 2024 14:10:59 +0100
From: Corinna Vinschen <vinschen@redhat.com>
To: Stafford Horne <shorne@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>, newlib@sourceware.org
Subject: Re: [PATCH] or1k: Fix compiler warnings
Message-ID: <Z1mPY2CcYF_WaHEj@calimero.vinschen.de>
Reply-To: newlib@sourceware.org
Mail-Followup-To: Stafford Horne <shorne@gmail.com>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	newlib@sourceware.org
References: <20241210125847.401222-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241210125847.401222-1-shorne@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f40RPIbHtijGaWl30hzTOfP3MbXK5Rkdyp6_dJMgByY_1733922663
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Stafford,

I'm not engaged in this stuff, so maybe this is dumb...

Changing the parameter from uint32_t to void* sounds like it would have
been the right thing from the start, but it's also an ABI change on 64
bit or1k.  I could imagine the uint32_t is just a pointer value from the
lower 4G space on 64 bit.  Do we even support 64 bit or1k?


Corinna



On Dec 10 12:58, Stafford Horne wrote:
> In my build the below are treated as error now and causing failures.
> 
>       CC       libc/sys/or1k/libc_a-mlock.o
>     newlib/libc/sys/or1k/mlock.c: In function ‘__malloc_lock’:
>     newlib/libc/sys/or1k/mlock.c:56:19: warning: implicit declaration of function ‘or1k_critical_begin’ [-Wimplicit-function-declaration]
>        56 |         restore = or1k_critical_begin();
> 	  |                   ^~~~~~~~~~~~~~~~~~~
>     newlib/libc/sys/or1k/mlock.c: In function ‘__malloc_unlock’:
>     newlib/libc/sys/or1k/mlock.c:93:17: warning: implicit declaration of function ‘or1k_critical_end’ [-Wimplicit-function-declaration]
>        93 |                 or1k_critical_end(restore);
> 	  |                 ^~~~~~~~~~~~~~~~~
> 
>     libgloss/or1k/or1k_uart.c: In function ‘or1k_uart_set_read_cb’:
>     libgloss/or1k/or1k_uart.c:163:25: warning: passing argument 2 of ‘or1k_interrupt_handler_add’ from incompatible pointer type [-Wincompatible-pointer-types]
>       163 |                         _or1k_uart_interrupt_handler, 0);
> 	  |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 	  |                         |
> 	  |                         void (*)(uint32_t) {aka void (*)(long unsigned int)}
>     In file included from libgloss/or1k/or1k_uart.c:19:
>     libgloss/or1k/include/or1k-support.h:97:45: note: expected ‘or1k_interrupt_handler_fptr’ {aka ‘void (*)(void *)’} but argument is of type ‘void (*)(uint32_t)’ {aka ‘void (*)(long unsigned int)’}
>        97 |                 or1k_interrupt_handler_fptr handler,
> 	  |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
> 
>     libgloss/or1k/interrupts.c: In function ‘or1k_interrupt_handler_add’:
>     libgloss/or1k/interrupts.c:41:52: warning: assignment to ‘void *’ from ‘long unsigned int’ makes pointer from integer without a cast [-Wint-conversion]
>        41 |         _or1k_interrupt_handler_data_ptr_table[id] = (uint32_t) data_ptr;
> 	  |                                                    ^
> 
>     libgloss/or1k/sbrk.c:23:29: warning: initialization of ‘uint32_t’ {aka ‘long unsigned int’} from ‘uint32_t *’ {aka ‘long unsigned int *’} makes integer from pointer without a cast [-Wint-conversion]
>        23 | uint32_t _or1k_heap_start = &end;
> 	  |
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  libgloss/or1k/interrupts.c   | 4 ++--
>  libgloss/or1k/or1k_uart.c    | 2 +-
>  libgloss/or1k/or1k_uart.h    | 2 +-
>  libgloss/or1k/sbrk.c         | 2 +-
>  newlib/libc/sys/or1k/mlock.c | 3 +++
>  5 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/libgloss/or1k/interrupts.c b/libgloss/or1k/interrupts.c
> index 6badc497c..516d74be3 100644
> --- a/libgloss/or1k/interrupts.c
> +++ b/libgloss/or1k/interrupts.c
> @@ -35,10 +35,10 @@ void or1k_interrupt_handler_add(uint32_t id,
>  {
>  #ifdef __OR1K_MULTICORE__
>  	_or1k_interrupt_handler_table[or1k_coreid()][id] = handler;
> -	_or1k_interrupt_handler_data_ptr_table[or1k_coreid()][id] = (uint32_t) data_ptr;
> +	_or1k_interrupt_handler_data_ptr_table[or1k_coreid()][id] = data_ptr;
>  #else
>  	_or1k_interrupt_handler_table[id] = handler;
> -	_or1k_interrupt_handler_data_ptr_table[id] = (uint32_t) data_ptr;
> +	_or1k_interrupt_handler_data_ptr_table[id] = data_ptr;
>  #endif
>  }
>  
> diff --git a/libgloss/or1k/or1k_uart.c b/libgloss/or1k/or1k_uart.c
> index 0a991e6ba..1391d565c 100644
> --- a/libgloss/or1k/or1k_uart.c
> +++ b/libgloss/or1k/or1k_uart.c
> @@ -90,7 +90,7 @@ void (*_or1k_uart_read_cb)(char c);
>   * This is the interrupt handler that is registered for the callback
>   * function.
>   */
> -void _or1k_uart_interrupt_handler(uint32_t data)
> +void _or1k_uart_interrupt_handler(void *data)
>  {
>  	uint8_t iir = REG8(IIR);
>  
> diff --git a/libgloss/or1k/or1k_uart.h b/libgloss/or1k/or1k_uart.h
> index 4cbb68350..201b7749f 100644
> --- a/libgloss/or1k/or1k_uart.h
> +++ b/libgloss/or1k/or1k_uart.h
> @@ -30,7 +30,7 @@ extern void (*_or1k_uart_read_cb)(char c);
>  /**
>   * The UART interrupt handler
>   */
> -void _or1k_uart_interrupt_handler(uint32_t data);
> +void _or1k_uart_interrupt_handler(void *data);
>  
>  /**
>   * Initialize UART
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
>  
>  void *
> diff --git a/newlib/libc/sys/or1k/mlock.c b/newlib/libc/sys/or1k/mlock.c
> index ccb840161..a0c038335 100644
> --- a/newlib/libc/sys/or1k/mlock.c
> +++ b/newlib/libc/sys/or1k/mlock.c
> @@ -38,6 +38,9 @@ volatile uint32_t _or1k_malloc_lock_restore;
>  
>  extern uint32_t or1k_sync_cas(void *address, uint32_t compare, uint32_t swap);
>  
> +extern uint32_t or1k_critical_begin();
> +extern void or1k_critical_end(uint32_t restore);
> +
>  /**
>   * Recursive lock of the malloc
>   */
> -- 
> 2.47.0

