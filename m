Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A103A22652A
	for <linux-openrisc@vger.kernel.org>; Thu, 12 Dec 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020591; cv=none; b=nvuorwMh2NygUv4iXmTXFC+MpwVkfE/6T0zZIuwR5vmKJ8bAdWCM3d58zO60u6+Hi8V4czpSAhVC9uo3AjZYvcv3kp7Ra1681NCST0xmEsTpsuNaGajJvzmm7EhVg+IeCpIF1t8cAzipR4I/ekfW1xXbJTXNNBKQPMphSUBAIe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020591; c=relaxed/simple;
	bh=36FxLdCssaEQSgMOs9RPUqNlxAPx+mn01Wrdf0athl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A7WgGU3fQSnbxD2jVb3vNMtO1abyt4+9YbNql0PiExij9GyAw1nGn2KOVjzwbP5bx1/HnWp3wxdalfzvcIPaGGOR/tcCvBhtaU3jzBi2zXRIGlW2PdasIq9i1wzJvvf4cKBJpepn2Os3pPBEaWa3vG0Np7c7IeedjYUirG7+f0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjHF/53o; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjHF/53o"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso868349f8f.2
        for <linux-openrisc@vger.kernel.org>; Thu, 12 Dec 2024 08:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734020588; x=1734625388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fzM/sUg/vilspFYDBoep5ao74/q7GF7Uv1pyzJwCLdE=;
        b=GjHF/53o7tAvtBGE7a1bmHfcrFNtUvUDHUXkr2cy6iNLQabfABZoi3NzaOgmQumipR
         JyjkCdRw1RmWMcUcAOiRzoVpN7OjlTamit+etf38O5wfJD/0HdJSAgj2eaeVrmXuQsKj
         XTEIFeGwLcKmjFboilUHPOL1fHwSZnO3yufcP8iyVqrHeZZripXMQKcx6R2BGD1ZOks6
         DV+CcWvtKF25anH2+UKoBinf4Sjv6QGQhfUHGLKNn7JKLUaOThbmF/V4M+JIBs4Ma/ev
         JRkIMxfDGUBBfd8q632ANdQzandGL4yLWKV1S5HUiiP9YH+Bwnnp0IdcQgyFhbyx2mAc
         pYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734020588; x=1734625388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzM/sUg/vilspFYDBoep5ao74/q7GF7Uv1pyzJwCLdE=;
        b=CecSBrw280Cdd9yQMrPVtMdnVSG9FhwB2zQSMw5om81narLlzk0j1BF+kVTSM/Axz9
         tqrmubeFdTVj2UBsShDf7QnJLB8Thoq2yBeiUK+spfko1clXwxLvSOJEqFRtAJMFIWdP
         l4w1R7B4m+/4/9lWWseIh0tv43MYjGBzAO3MVBqxK7H1LOtzNj9/X39/y9cFzCOOHGJp
         TyHVHa1r4foHQKTOadvnv6y3j6vbd1QOFmhA9RWM4uabcvuHUeo2joKEOZ/NHmccGV4R
         xsThPxmf2dkSbzE6i/uze6UkJIVkDJ89W+2Uw8pF0WIvIT1YagA8Mx2UiKcOCVCs8P6b
         h8fA==
X-Gm-Message-State: AOJu0Yz73PwQdpk1dhEbsobnKoXe0uN4ozevoZvkl+66xiQP6wJKaB5h
	2ZJ2yrcn9fGyY0GwMsl7pcuP1s4HVUfKNQEQk1HV+NqARrI1NbY9JuN2vg==
X-Gm-Gg: ASbGncuUqYr0uNsGWeimHSvS55TD1WQj7W3pXT708eHH/GcDas0QdLxA6JQQfin9/B1
	u+eoTRCxfV1DMd9cJI+1HzhZR7HhyVuPMyNj/AILbvoENKx2rvX72lTqXbNGwdOQVN05vRHZZGd
	88saAew8bgTU+n1m6n8/8HNP1Pzsn3SioVt9W0xDDj6AJB/yBPltT6raaVd7xO5hnybJGz8J92x
	E4ANVklzASGnHJ7YQw5nOgfWEZW/kSlqUP/6oCqjM7qRPKXW2EngF1Mq/xbkJR/6Ke0Y+DoKlJY
	g8Z5yo7E27z71+vdsbYf
X-Google-Smtp-Source: AGHT+IE3wJbndaMMjyh1q2Vl9kyRK0mHGi6dI+tVHhJZ5Ij6i2GMJ17APU8LGv3uF7sdySHOCBdL8g==
X-Received: by 2002:a5d:64aa:0:b0:386:3ba8:5326 with SMTP id ffacd0b85a97d-3864ce96dffmr7726792f8f.21.1734020587619;
        Thu, 12 Dec 2024 08:23:07 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824c50b7sm4370430f8f.57.2024.12.12.08.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:23:06 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: Newlib <newlib@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2] or1k: Fix compiler warnings
Date: Thu, 12 Dec 2024 16:23:03 +0000
Message-ID: <20241212162303.2099025-1-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In my build the below are treated as error now and causing failures.  I
have described the fixes of each warning below.

In newlib/libc/sys/or1k/mlock.c:

      CC       libc/sys/or1k/libc_a-mlock.o
    newlib/libc/sys/or1k/mlock.c: In function ‘__malloc_lock’:
    newlib/libc/sys/or1k/mlock.c:56:19: warning: implicit declaration of function ‘or1k_critical_begin’ [-Wimplicit-function-declaration]
       56 |         restore = or1k_critical_begin();
	  |                   ^~~~~~~~~~~~~~~~~~~
    newlib/libc/sys/or1k/mlock.c: In function ‘__malloc_unlock’:
    newlib/libc/sys/or1k/mlock.c:93:17: warning: implicit declaration of function ‘or1k_critical_end’ [-Wimplicit-function-declaration]
       93 |                 or1k_critical_end(restore);
	  |                 ^~~~~~~~~~~~~~~~~

This patch adds prototypes for functions or1k_critical_begin and
or1k_critical_end to suppress the warning, inline with what we do for
or1k_sync_cas.

In libgloss/or1k/or1k_uart.c:

    libgloss/or1k/or1k_uart.c: In function ‘or1k_uart_set_read_cb’:
    libgloss/or1k/or1k_uart.c:163:25: warning: passing argument 2 of ‘or1k_interrupt_handler_add’ from incompatible pointer type [-Wincompatible-pointer-types]
      163 |                         _or1k_uart_interrupt_handler, 0);
	  |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
	  |                         |
	  |                         void (*)(uint32_t) {aka void (*)(long unsigned int)}
    In file included from libgloss/or1k/or1k_uart.c:19:
    libgloss/or1k/include/or1k-support.h:97:45: note: expected ‘or1k_interrupt_handler_fptr’ {aka ‘void (*)(void *)’} but argument is of type ‘void (*)(uint32_t)’ {aka ‘void (*)(long unsigned int)’}
       97 |                 or1k_interrupt_handler_fptr handler,
	  |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~

The public API is ‘void (*)(void *)' for our interrupt handlers.  The
function _or1k_uart_interrupt_hander is the internal default
implementation of the uart IRQ handler and it doesn't use the data
argument.

This patch updates the _or1k_uart_interrupt_handler argument type from
uint32_t to void* allowing the function prototype to match the required
prototype.

If we did have a 64-bit implementation it would be an ABI issue. But,
there never has been one, or1k is only 32-bit.

In libgloss/or1k/interrupts.c:

    libgloss/or1k/interrupts.c: In function ‘or1k_interrupt_handler_add’:
    libgloss/or1k/interrupts.c:41:52: warning: assignment to ‘void *’ from ‘long unsigned int’ makes pointer from integer without a cast [-Wint-conversion]
       41 |         _or1k_interrupt_handler_data_ptr_table[id] = (uint32_t) data_ptr;
	  |                                                    ^

The table _or1k_interrupt_handler_data_ptr_table is an array of void*
and data_ptr is void*.  There is no need for the cast so remove it.

In libgloss/or1k/sbrk.c:

    libgloss/or1k/sbrk.c:23:29: warning: initialization of ‘uint32_t’ {aka ‘long unsigned int’} from ‘uint32_t *’ {aka ‘long unsigned int *’} makes integer from pointer without a cast [-Wint-conversion]
       23 | uint32_t _or1k_heap_start = &end;
	  |

This patch adds a cast, which is safe in or1k as the architecture in
32-bit only.  But this code would not be 64-compatible.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v1:
 - Update the commit message to explain the reasoning behind each warning fix.

 libgloss/or1k/interrupts.c   | 4 ++--
 libgloss/or1k/or1k_uart.c    | 2 +-
 libgloss/or1k/or1k_uart.h    | 2 +-
 libgloss/or1k/sbrk.c         | 2 +-
 newlib/libc/sys/or1k/mlock.c | 3 +++
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/libgloss/or1k/interrupts.c b/libgloss/or1k/interrupts.c
index 6badc497c..516d74be3 100644
--- a/libgloss/or1k/interrupts.c
+++ b/libgloss/or1k/interrupts.c
@@ -35,10 +35,10 @@ void or1k_interrupt_handler_add(uint32_t id,
 {
 #ifdef __OR1K_MULTICORE__
 	_or1k_interrupt_handler_table[or1k_coreid()][id] = handler;
-	_or1k_interrupt_handler_data_ptr_table[or1k_coreid()][id] = (uint32_t) data_ptr;
+	_or1k_interrupt_handler_data_ptr_table[or1k_coreid()][id] = data_ptr;
 #else
 	_or1k_interrupt_handler_table[id] = handler;
-	_or1k_interrupt_handler_data_ptr_table[id] = (uint32_t) data_ptr;
+	_or1k_interrupt_handler_data_ptr_table[id] = data_ptr;
 #endif
 }
 
diff --git a/libgloss/or1k/or1k_uart.c b/libgloss/or1k/or1k_uart.c
index 0a991e6ba..1391d565c 100644
--- a/libgloss/or1k/or1k_uart.c
+++ b/libgloss/or1k/or1k_uart.c
@@ -90,7 +90,7 @@ void (*_or1k_uart_read_cb)(char c);
  * This is the interrupt handler that is registered for the callback
  * function.
  */
-void _or1k_uart_interrupt_handler(uint32_t data)
+void _or1k_uart_interrupt_handler(void *data)
 {
 	uint8_t iir = REG8(IIR);
 
diff --git a/libgloss/or1k/or1k_uart.h b/libgloss/or1k/or1k_uart.h
index 4cbb68350..201b7749f 100644
--- a/libgloss/or1k/or1k_uart.h
+++ b/libgloss/or1k/or1k_uart.h
@@ -30,7 +30,7 @@ extern void (*_or1k_uart_read_cb)(char c);
 /**
  * The UART interrupt handler
  */
-void _or1k_uart_interrupt_handler(uint32_t data);
+void _or1k_uart_interrupt_handler(void *data);
 
 /**
  * Initialize UART
diff --git a/libgloss/or1k/sbrk.c b/libgloss/or1k/sbrk.c
index 0c3e66e87..ca196d228 100644
--- a/libgloss/or1k/sbrk.c
+++ b/libgloss/or1k/sbrk.c
@@ -20,7 +20,7 @@
 #include "include/or1k-support.h"
 
 extern uint32_t	end; /* Set by linker.  */
-uint32_t _or1k_heap_start = &end;
+uint32_t _or1k_heap_start = (uint32_t) &end;
 uint32_t _or1k_heap_end;
 
 void *
diff --git a/newlib/libc/sys/or1k/mlock.c b/newlib/libc/sys/or1k/mlock.c
index ccb840161..a0c038335 100644
--- a/newlib/libc/sys/or1k/mlock.c
+++ b/newlib/libc/sys/or1k/mlock.c
@@ -38,6 +38,9 @@ volatile uint32_t _or1k_malloc_lock_restore;
 
 extern uint32_t or1k_sync_cas(void *address, uint32_t compare, uint32_t swap);
 
+extern uint32_t or1k_critical_begin();
+extern void or1k_critical_end(uint32_t restore);
+
 /**
  * Recursive lock of the malloc
  */
-- 
2.47.0

