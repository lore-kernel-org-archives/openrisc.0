Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5561A76AC
	for <linux-openrisc@vger.kernel.org>; Tue, 10 Dec 2024 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835576; cv=none; b=PEUUPocHqD2USlKEe/lppxN2zLqAXFOaFQTPCWZ7neZYImotEWpEhcG7xGEIDG5T1OtlAof1PYmhsxeziY4xK62+ggSiTBksglWQIJu5cZWRq2w3s1PJnS7bUBAeaGhY+Z/ikUReyJKUrapqdgMuYz8EPJgzfFSe0Pp4UajPSVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835576; c=relaxed/simple;
	bh=IGy2loM6B/fA1s5sf5I/qB3fKcJpD+yMgTf+jtcA30U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NwRcfqXDhTkaSCCqy3BEJOzPhP4ywKy9PvPFuKAp431E40ggG0PUBwNpbEtCDqCZr9AlfKgdNSH1Vkcm2tNG2qmPz2f+rEm/7g+3elcOWHC2jyKziRy5fFDFnzFWcI7D15ARcJtA50OKLfciCyRNLqAobDIsF+cR2c4StKcOxN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZshi8cu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZshi8cu"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385eed29d17so3775605f8f.0
        for <linux-openrisc@vger.kernel.org>; Tue, 10 Dec 2024 04:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733835573; x=1734440373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ll+hjXO4xHE8MVhZBs+LlMtEB7uG99+GgzEZxDtaqE=;
        b=QZshi8cukF3icNs2jH5oclrXPg19NAHBYBn2y44Os/iVMA4R/d7gdMJx6ftC95GLxs
         qYuwjr3Iu3KMjIXxXR9r2CAoiQ+GqhqRf4j1v+ws1T7Tr3QrJjoULA/dLf/2hK+xG9Hi
         gLTTpQh5vRnHuSD9GlNKLyy2bS9hi/jKkkQPJjSiAcy58IOPdeEDcrRam5uLDmrV8um9
         2QV0h77tF+gLHR0oat/rtnfgwXwKhoLPE5HVv9Nqm4VmtM9UDJn9gqnkEswQwibad1XY
         7Yv8ghb+dnWolT6YosL0bGyGa6oalyYnAHZuo2tGKk5EBuL7a/1wasZyUHuYM7Iv7o8G
         terw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733835573; x=1734440373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ll+hjXO4xHE8MVhZBs+LlMtEB7uG99+GgzEZxDtaqE=;
        b=oQvUcmkRriHpuxKJk3BVSB6dUOwgkHPF8m73d9nXQeIMh4uTYi4mQkkaZt/RZxj5Cd
         KLCRdoh6i94qjfl2hH0K9EXg+65CWJ5zYBzvyynffplE6dqjZlD2T+vbsQImSF9owURE
         Onf8JiKpchfQSb7h6G+tPuP3JwotFhH+dB1eFaB94TpeeYHFqvP2aeGxYZPCw1jn39eW
         ONBipob8Foya9EIR+FLbFxbj+nrSE/4qmI5q0J42ZPKDGMEcpgMPui5y8MJ8ROQBP6cF
         BTTwXXb2uBVieuJGPkfFGJvd0xHJ4FRft5O6meIoGnto3Ie8M4e9eD8zTme0g5LjghDP
         ll1Q==
X-Gm-Message-State: AOJu0YyOvdsx35hkKGnrFDUut1kySYDned+JGC2icmAIwNClKOANPuXG
	lR273M9Vigc/QAJJbHZjQlrPmK1OrKzu90TBDjyjekNGwHy81FDu
X-Gm-Gg: ASbGncsbIVWX1sjGE6iKLFjRpplMWf2safRsTqKJXgRF9v/l1k6KKgr/ULhSYnp9jkm
	A8KwGdxJF20ITsilc7rizYqHKjiB92yCQAcLJauGWC2CYkGug8BXm6RCmZ8EkxdtNGml7avDxEA
	uUHHfUCfkv/ZDO1QNw0kTyQTSC17ldNWk3BWRNEXFO9lBWkHDQsBwl1e0k/0d1vH8ktmK/8LX7/
	FtEC6fXis1Nfis+CVKWAlkhwfjQsYZ8BDf6Qxob1q+NesDPd//y/oxieBmv/X/HyDg9OmDiHaxK
	Ex1jLZk+jygNi4w+9A==
X-Google-Smtp-Source: AGHT+IHxrETMy8+Sk68WONyqE/eAmUrZLvHsnOj0ccd0tztGC8r8rNjjpjG0AdKBvYZ0iDCLZc1dnQ==
X-Received: by 2002:a5d:6da5:0:b0:385:f677:859b with SMTP id ffacd0b85a97d-3862b33e5d7mr12898059f8f.10.1733835573234;
        Tue, 10 Dec 2024 04:59:33 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38637072adasm10083392f8f.81.2024.12.10.04.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 04:59:31 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: Newlib <newlib@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH] or1k: Fix compiler warnings
Date: Tue, 10 Dec 2024 12:58:47 +0000
Message-ID: <20241210125847.401222-1-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In my build the below are treated as error now and causing failures.

      CC       libc/sys/or1k/libc_a-mlock.o
    newlib/libc/sys/or1k/mlock.c: In function ‘__malloc_lock’:
    newlib/libc/sys/or1k/mlock.c:56:19: warning: implicit declaration of function ‘or1k_critical_begin’ [-Wimplicit-function-declaration]
       56 |         restore = or1k_critical_begin();
	  |                   ^~~~~~~~~~~~~~~~~~~
    newlib/libc/sys/or1k/mlock.c: In function ‘__malloc_unlock’:
    newlib/libc/sys/or1k/mlock.c:93:17: warning: implicit declaration of function ‘or1k_critical_end’ [-Wimplicit-function-declaration]
       93 |                 or1k_critical_end(restore);
	  |                 ^~~~~~~~~~~~~~~~~

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

    libgloss/or1k/interrupts.c: In function ‘or1k_interrupt_handler_add’:
    libgloss/or1k/interrupts.c:41:52: warning: assignment to ‘void *’ from ‘long unsigned int’ makes pointer from integer without a cast [-Wint-conversion]
       41 |         _or1k_interrupt_handler_data_ptr_table[id] = (uint32_t) data_ptr;
	  |                                                    ^

    libgloss/or1k/sbrk.c:23:29: warning: initialization of ‘uint32_t’ {aka ‘long unsigned int’} from ‘uint32_t *’ {aka ‘long unsigned int *’} makes integer from pointer without a cast [-Wint-conversion]
       23 | uint32_t _or1k_heap_start = &end;
	  |

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
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

