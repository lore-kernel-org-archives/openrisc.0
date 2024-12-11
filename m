Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C22B246354
	for <linux-openrisc@vger.kernel.org>; Wed, 11 Dec 2024 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927969; cv=none; b=rshnPe3rZJH1Rz+SCi1CZnsqpuZ027TpnTKPbc6e7FDFjxsTNeq5WGgMX26baeAZhJ+8Xty8OXM6GPRTf/uCoJJQZOPSklqDZ/tfzXMFzeqlvHrLUeMuD3Y23gn7u2BdL5KAT7vQ6hbAvadusCoPYC1ykMD4V1+yPXNC7dEZgLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927969; c=relaxed/simple;
	bh=ktG/jWFFr4mBOhEvcU/3QP2ddAiIdel6UTfdxbeBLfY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ds5bofsrds2gWLjpTmCzsp9rBcroeRkRGjNDrCdDyspgcBl3npYi6cQu4rL21VT/Kk8qzngfkBS89vxKlvslBucQJZ3wac5Gs5P/QuybgldVfbBcMSI1Rvl2byvVc0uTFwO8vohriVE6OQAgsd2GcPKUxCH/KDAHhmdoh3r7C4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+U1dOWP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+U1dOWP"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso65149395e9.3
        for <linux-openrisc@vger.kernel.org>; Wed, 11 Dec 2024 06:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733927965; x=1734532765; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiE+M/GxG44yvXOOllBjslkutQ/2fiLnyMncBMQ667Q=;
        b=G+U1dOWP+0XB9bNWUZfaco3BTKNBL+GDTcf/fWqJCV7npEKzERkbVl/f35J47XFtEJ
         OW5vbQGdJXjdW71VGCKPxcJxnKUp/j9vd5bOA9/0vIKTQD/eJ8ka+T/3V5ubD8lu3/7A
         mHn7W7GqtR974IAsyS9tuVyxF27pZVOC0Q17J6TbmkxzvrIFQjfpNht8hDyIJXPoeUf+
         iFiOqSuk3G6obY/iT919WNpsuRG4u8gwLORL0+kwqLPyISX7pu8CcaADLcbt3vWFvxft
         IGblJkFQ2WU05yMuzEvZeJfrH1L2R/tKpfEBhJdj3iH+C2+FwK+V1jxtF6a1gMGzhPns
         Ru1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733927965; x=1734532765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JiE+M/GxG44yvXOOllBjslkutQ/2fiLnyMncBMQ667Q=;
        b=TaqcQ4boCH1BLDJQ2goeogeq0f/qHb7VdLZhAQ+9+rrpvtTR4tz35s7QnDdQYlGADY
         BY3y41VBEUhiIh5UQB4mlbor8aXlCKNZFqytjzqr7k1Nnbkx51JcHX3CpFhL4vAQf53B
         akLGNS7ouYDNRrdvuHkeZ5yL4TwcgxDbA2MgvT1eZrg+Fuv2QJt4jZKfBs8q+QO6BQP0
         l+9a2BLOr4Gwovo4C4GjgAl6MLa1fjyp+d8YyPcHgeqF+DmMl01YtZGoCk6eKeFW7gdW
         vZ/QTPXF9TJNGPHLcpqettcy0aBnUXbRwoO0rjP6zLLX8vOFqC+CBP9g/zYJudmb+vXd
         LXOA==
X-Gm-Message-State: AOJu0YwAV+ZPy/CN04Avb/YLlGa6MzbNLurlSZ7+lb20TSX4pcjD/diM
	qTG64uNfOAW5Pbr2ziXPy+KkYCVg4npiD3VYQXc/fY2FUC38KETUiGfEDQ==
X-Gm-Gg: ASbGncs8JMaXGtC3LViDsREXCQaf5jww3cbWkcF8ajsQIq386TOW6ZXl/bChV26DYlV
	+KDatZC1LAQQFukAVwaImlQ82P7anzSQYpwJTDZrus/FhtW207yvTRJ9mfxElIBlQ81NN3tr80y
	+1wNJ2xdJnJ6OCgx27f9LLZ9PuuUuqAwkR3du9y//QsV5upxpVe1YWu+8X/rQMfMoZgNXcw9QM+
	1wmWhKb6uVMYp6RGmDRsqG3dqPGowxUOYUFuvcOI4hVTivazNKq5xDQ9BdxS7lEY/5+26SGljrP
	BZxh52vKtMoec+N8JQ==
X-Google-Smtp-Source: AGHT+IEQNgj43x9mXQZ4jPZ4X/RJeuIRumvRs/EFi9TNdkrHAN5eaHkXhuQLZ2raJ3DqoELJgzgV2g==
X-Received: by 2002:a05:600c:3b94:b0:434:a94f:f8a9 with SMTP id 5b1f17b1804b1-4361c41972amr19255735e9.28.1733927964670;
        Wed, 11 Dec 2024 06:39:24 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4350066dd2dsm71052605e9.35.2024.12.11.06.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 06:39:22 -0800 (PST)
Date: Wed, 11 Dec 2024 14:39:22 +0000
From: Stafford Horne <shorne@gmail.com>
To: Linux OpenRISC <linux-openrisc@vger.kernel.org>, newlib@sourceware.org
Subject: Re: [PATCH] or1k: Fix compiler warnings
Message-ID: <Z1mkGubLCh8Rte7Z@antec>
References: <20241210125847.401222-1-shorne@gmail.com>
 <Z1mPY2CcYF_WaHEj@calimero.vinschen.de>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1mPY2CcYF_WaHEj@calimero.vinschen.de>

On Wed, Dec 11, 2024 at 02:10:59PM +0100, Corinna Vinschen wrote:
> Hi Stafford,
> 
> I'm not engaged in this stuff, so maybe this is dumb...
> 
> Changing the parameter from uint32_t to void* sounds like it would have
> been the right thing from the start, but it's also an ABI change on 64
> bit or1k.  I could imagine the uint32_t is just a pointer value from the
> lower 4G space on 64 bit.  Do we even support 64 bit or1k?

Hi Corinna,

I think it's a good conncern.  I put some comments on the patch below with my
thoughts.

If this is OK, I will send a v2 with a better description of each change.

See below:

> 
> On Dec 10 12:58, Stafford Horne wrote:
> > In my build the below are treated as error now and causing failures.
> > 
> >       CC       libc/sys/or1k/libc_a-mlock.o
> >     newlib/libc/sys/or1k/mlock.c: In function ‘__malloc_lock’:
> >     newlib/libc/sys/or1k/mlock.c:56:19: warning: implicit declaration of function ‘or1k_critical_begin’ [-Wimplicit-function-declaration]
> >        56 |         restore = or1k_critical_begin();
> > 	  |                   ^~~~~~~~~~~~~~~~~~~
> >     newlib/libc/sys/or1k/mlock.c: In function ‘__malloc_unlock’:
> >     newlib/libc/sys/or1k/mlock.c:93:17: warning: implicit declaration of function ‘or1k_critical_end’ [-Wimplicit-function-declaration]
> >        93 |                 or1k_critical_end(restore);
> > 	  |                 ^~~~~~~~~~~~~~~~~
> > 
> >     libgloss/or1k/or1k_uart.c: In function ‘or1k_uart_set_read_cb’:
> >     libgloss/or1k/or1k_uart.c:163:25: warning: passing argument 2 of ‘or1k_interrupt_handler_add’ from incompatible pointer type [-Wincompatible-pointer-types]
> >       163 |                         _or1k_uart_interrupt_handler, 0);
> > 	  |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 	  |                         |
> > 	  |                         void (*)(uint32_t) {aka void (*)(long unsigned int)}
> >     In file included from libgloss/or1k/or1k_uart.c:19:
> >     libgloss/or1k/include/or1k-support.h:97:45: note: expected ‘or1k_interrupt_handler_fptr’ {aka ‘void (*)(void *)’} but argument is of type ‘void (*)(uint32_t)’ {aka ‘void (*)(long unsigned int)’}
> >        97 |                 or1k_interrupt_handler_fptr handler,
> > 	  |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
> > 
> >     libgloss/or1k/interrupts.c: In function ‘or1k_interrupt_handler_add’:
> >     libgloss/or1k/interrupts.c:41:52: warning: assignment to ‘void *’ from ‘long unsigned int’ makes pointer from integer without a cast [-Wint-conversion]
> >        41 |         _or1k_interrupt_handler_data_ptr_table[id] = (uint32_t) data_ptr;
> > 	  |                                                    ^
> > 
> >     libgloss/or1k/sbrk.c:23:29: warning: initialization of ‘uint32_t’ {aka ‘long unsigned int’} from ‘uint32_t *’ {aka ‘long unsigned int *’} makes integer from pointer without a cast [-Wint-conversion]
> >        23 | uint32_t _or1k_heap_start = &end;
> > 	  |
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  libgloss/or1k/interrupts.c   | 4 ++--
> >  libgloss/or1k/or1k_uart.c    | 2 +-
> >  libgloss/or1k/or1k_uart.h    | 2 +-
> >  libgloss/or1k/sbrk.c         | 2 +-
> >  newlib/libc/sys/or1k/mlock.c | 3 +++
> >  5 files changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/libgloss/or1k/interrupts.c b/libgloss/or1k/interrupts.c
> > index 6badc497c..516d74be3 100644
> > --- a/libgloss/or1k/interrupts.c
> > +++ b/libgloss/or1k/interrupts.c
> > @@ -35,10 +35,10 @@ void or1k_interrupt_handler_add(uint32_t id,
> >  {
> >  #ifdef __OR1K_MULTICORE__
> >  	_or1k_interrupt_handler_table[or1k_coreid()][id] = handler;
> > -	_or1k_interrupt_handler_data_ptr_table[or1k_coreid()][id] = (uint32_t) data_ptr;
> > +	_or1k_interrupt_handler_data_ptr_table[or1k_coreid()][id] = data_ptr;
> >  #else
> >  	_or1k_interrupt_handler_table[id] = handler;
> > -	_or1k_interrupt_handler_data_ptr_table[id] = (uint32_t) data_ptr;
> > +	_or1k_interrupt_handler_data_ptr_table[id] = data_ptr;

Fix for:
 - warning: assignment to ‘void *’ from ‘long unsigned int’ makes pointer from integer without a cast [-Wint-conversion]

The table _or1k_interrupt_handler_data_ptr_table is an array of void* and
data_ptr is void*.  There is no need for the cast so remove it.

> >  #endif
> >  }
> >  
> > diff --git a/libgloss/or1k/or1k_uart.c b/libgloss/or1k/or1k_uart.c
> > index 0a991e6ba..1391d565c 100644
> > --- a/libgloss/or1k/or1k_uart.c
> > +++ b/libgloss/or1k/or1k_uart.c
> > @@ -90,7 +90,7 @@ void (*_or1k_uart_read_cb)(char c);
> >   * This is the interrupt handler that is registered for the callback
> >   * function.
> >   */
> > -void _or1k_uart_interrupt_handler(uint32_t data)
> > +void _or1k_uart_interrupt_handler(void *data)
> >  {
> >  	uint8_t iir = REG8(IIR);
> >  
> > diff --git a/libgloss/or1k/or1k_uart.h b/libgloss/or1k/or1k_uart.h
> > index 4cbb68350..201b7749f 100644
> > --- a/libgloss/or1k/or1k_uart.h
> > +++ b/libgloss/or1k/or1k_uart.h
> > @@ -30,7 +30,7 @@ extern void (*_or1k_uart_read_cb)(char c);
> >  /**
> >   * The UART interrupt handler
> >   */x
> > -void _or1k_uart_interrupt_handler(uint32_t data);
> > +void _or1k_uart_interrupt_handler(void *data);

These two are fixes for:
  - ‘or1k_interrupt_handler_fptr’ {aka ‘void (*)(void *)’} but argument is of type ‘void (*)(uint32_t)’ {aka ‘void (*)(long unsigned int)’}

The public API is ‘void (*)(void *)' for our interrupt handlers.  The symbol
_or1k_uart_interrupt_hander is the internal default implementation of the uart
IRQ handler and it doen't use the data argument.  _There already is an ABI
mismatch_ and when the handler is called in libgloss it will pass a void *.

   void or1k_interrupt_handler_add(uint32_t line,
                  or1k_interrupt_handler_fptr handler,
                  void* data);

I agree that if we did have a 64-bit implementation it may be an issue.  But
there never has been one, or1k is only 32-bit.  I think the ABI does not change
with this patch.

Maybe I am wrong, but I think this is safe because:

  - There is no ABI change as void* and uint32_t are the same in or1k
  - There is no API change as or1k_uart.h is not a public API

What do you think?

> >  /**
> >   * Initialize UART
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

Fix for:
 - warning: initialization of ‘uint32_t’ {aka ‘long unsigned int’} from ‘uint32_t *’ {aka ‘long unsigned int *’} makes integer from pointer without a cast [-Wint-conversion]

Add a cast, which is safe in or1k as the architecture in 32-bit only.  But this
code would not be 64-compatible.

I could try to convert these _start, _end symbols all to void*.  But I will
leave it as is for now.

> >  void *
> > diff --git a/newlib/libc/sys/or1k/mlock.c b/newlib/libc/sys/or1k/mlock.c
> > index ccb840161..a0c038335 100644
> > --- a/newlib/libc/sys/or1k/mlock.c
> > +++ b/newlib/libc/sys/or1k/mlock.c
> > @@ -38,6 +38,9 @@ volatile uint32_t _or1k_malloc_lock_restore;
> >  
> >  extern uint32_t or1k_sync_cas(void *address, uint32_t compare, uint32_t swap);
> >  
> > +extern uint32_t or1k_critical_begin();
> > +extern void or1k_critical_end(uint32_t restore);
> > +

Fixes for:
 - warning: implicit declaration of function ‘or1k_critical_begin’ [-Wimplicit-function-declaration]
 - warning: implicit declaration of function ‘or1k_critical_end’ [-Wimplicit-function-declaration]

Defining these as extern is inline with what we do for or1k_sync_cas.

-Stafford
