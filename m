Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813842FB2
	for <linux-openrisc@vger.kernel.org>; Sat, 12 Jul 2025 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752315261; cv=none; b=VL6dnWHJ2TUV2kF0weYDFExSKlcDYbzs8+JxkT1FAMy241PCG6ma2stjJ2t7INLiooSxTDarsnHSGrIAycZSI5idY9o2Pav9PK4REGF6F89meuUUsnnjJst8HPOFzWFXtGCu2IbzpbiGXj9wGKIAtzbTpOVgIBqoEpYDCFrmFt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752315261; c=relaxed/simple;
	bh=U7yGLRA6SMK/mLs9SptysOe7SeQxf2KLbLEfTYZk5Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sM4ykLOZ6fP6VxoqZ6ibhDNZKQ5hq6paL9j+V4hUltR5d9gjC/JB0KiFLp+BnkIwQAl4I7WD61KHpCcVp5c6SiFYe0/8vGls0OBhrAINal4yjGUTd5QJbODoUe9lEa9Jmyl3fPKJlJZakuBZy79lskYgbfaC2YEcW5QbP3h+3p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XC4FTC00; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XC4FTC00"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4538a2fc7ffso27394135e9.0
        for <linux-openrisc@vger.kernel.org>; Sat, 12 Jul 2025 03:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752315258; x=1752920058; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3HyE9FIAdPiOQJosATcvlejLiSCvif3zyFawd7GrHts=;
        b=XC4FTC00f5RVjBMipjImLWCSFUH5+JNPbLQTzQoakvN0c34dQGAnP1NYFbjp1fvXUW
         iVq3h35MwOFyVq9N7z+8D7MGL9s7WF7NJH0PpUQab8/2VrobnGqwzTiaUrBEkvbF9Q+c
         DskzzS6lZ7FdH0LwVibWdGkb30XvIXT1bahmqdA/qGgnJH2HJFKDxUh/64nEhi1jLOyy
         ES5LbPZRMRk6bLzgByNzkhuUBt+KJfT+IkUa00iAoaNi67Ynb8UBcu2Ec9KBXZaJ6A1I
         fTBDb4rGoXubGHWkMtn3jJPwRTxhH2xzZM/JKjiT5Hd27JyItOGia1M6yq2y6L6FQtc3
         BclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752315258; x=1752920058;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3HyE9FIAdPiOQJosATcvlejLiSCvif3zyFawd7GrHts=;
        b=nXJLoRGumeIi/LG2YljhL5OdqUZc4r0OlFChilEtV2lY/PMaSQ5tbaoe5eirw49+jJ
         6h8EOF8FkVwcLqaNmRxQG7YVppDXUq9vAw+iAdC3ow3fm/s/Xq55RC4E595PU6eHwYYW
         JgbrCoRnnqb0BaAFdrTb8WrRzS1kynsEYId2ZIBmsfcZtgNwo/RQRP16DcVJtAmo72mD
         r05t+gbnP0myN8kD7JiXMC35tiM/DEQb1jYLm0ISu08sgw+W8XNBeToOF+zRiWvhd/vK
         HPpT0oshTrSimLqAjYRJXCU6vEDDjrEZlFWf4qt7obwCBtfoNSGAXYY9fsoF7Dtk1oSL
         2T5A==
X-Gm-Message-State: AOJu0YwIkandXMCBKRiTtz6TkdfvUXDL+JMECdXHR+fe4nSq4I3YP8jS
	LpT0Jg9kQE/uKAyGOKL/al/Ms/BsIqVCoygalYLLb3XL7k4dUYR+2c0SAzrS/X/M
X-Gm-Gg: ASbGncvWR7BzAcYQMr6/igaW7E9L5C87TEAXZdK+m7/pzBtHqZxWwPLL3Qf28s+A7Ke
	TeY1n+hqlowjAZN+X6M1Jo70i3cImkwUHC3DxWzVwiLlMifCNIw91DNLA9a71UJhPSWTl1xWMEz
	X9a5cKJw5LZgaiMrTW0hI+XrBaqaXPjhnKS+QAjTGYGtq3Aq92KXN1c+h9fmBV03R0t58tigVMh
	jfdDOg0bAOK1YIZR4r553DFzHZcbb4QBHNmusSW7RbmJimHLI93A50SjVLEDKOiuRqG0D0wJj8+
	FMvR9ZEeAZCLtApCAk1lKngJQQ7LRnF6vyFz7jel7UuFw1bYdrH6Z6ezvd6KUHstTqcRaAKWQng
	gGvDaKrwzwLaP44Y3q+0VjrPnnUX0QRAbqAqUVpPW42W0e8mRsjD0BlxHCA55QEQoyCUJgExx
X-Google-Smtp-Source: AGHT+IER+grIAJ+wwfhq5Q0t5ikMK1yycKdKMamS7xOenhhLHkbtuOptqO9fyHttscC+eQqFlpTDxw==
X-Received: by 2002:a05:600c:a31b:b0:455:efd7:17dc with SMTP id 5b1f17b1804b1-455efd7194cmr35775905e9.11.1752315257227;
        Sat, 12 Jul 2025 03:14:17 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc91d8sm6834701f8f.42.2025.07.12.03.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 03:14:15 -0700 (PDT)
Date: Sat, 12 Jul 2025 11:14:14 +0100
From: Stafford Horne <shorne@gmail.com>
To: 48494605 <zgliu@foxmail.com>
Cc: linux-openrisc <linux-openrisc@vger.kernel.org>
Subject: Re: [QUESTION] Does or1k-elf-gcc handle OpenRISC 4B alignment
 requirement?
Message-ID: <aHI1dhsflDh2Ci1l@antec>
References: <tencent_9B9E72B11681621EC7FA7CBD636247D74F06@qq.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_9B9E72B11681621EC7FA7CBD636247D74F06@qq.com>

Hi zgliu,

On Fri, Jul 11, 2025 at 02:20:42PM +0800, 48494605 wrote:
> Hi OpenRISC maintainers,
> 
> I encountered an alignment issue with `or1k-elf-gcc` and would like to confirm
> if it handles OpenRISC's 4B alignment requirement correctly. Here's the
> problem:
> 
> When using a recent version of `or1k-elf-gcc`, the following code triggers an alignment exception:
>           Alignment 0x600: Load/store access to unaligned location.
> 
> The issue occurs in a `memcpy()` operation within an ELF image loader (code
> snippet below). Interestingly, the same code works fine with the older
> `or32-elf-gcc 4.2.2`.

Interesting.  After 5.4.x we rewrote the GCC backend to get around issues with
copyright, none of the old code was used in the rewwrite.  I didn't even look at
the old implementation, so this feature was not carried forward.

> --- Code snippet ---
> static unsigned long load_elf_image_phdr(unsigned long addr)
> {
>       Elf32_Ehdr *ehdr;       /* Elf header structure pointer     */
>       Elf32_Phdr *phdr;       /* Program header structure pointer */
>       int i;
> 
> 
>       ehdr = (Elf32_Ehdr *) addr;
>       phdr = (Elf32_Phdr *) (addr + ehdr->e_phoff);
>       
>       printf("## phdr at 0x%08lx ...\n", phdr);
> 
> 
>       /* Load each program header */
>       for (i = 0; i < ehdr->e_phnum; ++i) {
>             void *dst = (void *)(uintptr_t) phdr->p_paddr;
>             void *src = (void *) addr + phdr->p_offset;
>             printf("Loading phdr %i to %p (%i bytes)\n",
>                   i, dst, phdr->p_filesz);
>             if (phdr->p_filesz)
>                   memcpy(dst, src, phdr->p_filesz);
>             if (phdr->p_filesz != phdr->p_memsz)
>                   memset(dst + phdr->p_filesz, 0x00,
>                         phdr->p_memsz - phdr->p_filesz);
>             //flush_cache((unsigned long)dst, phdr->p_filesz);
>             ++phdr;
>       }
> 
> 
>       return ehdr->e_entry;
> }
> ---

Do you have a more simple program that can reproduce the issue?  From the above
I cannot easily reproduce as I don't have hage the details of elf program
headers you are laoding.  At least can you share the output of `or1k-elf-readelf
-l ELF_FILE`? i.e.

    $ or1k-elf-readelf -l ~/work/linux/vmlinux

    Elf file type is EXEC (Executable file)
    Entry point 0xc0000000
    There are 4 program headers, starting at offset 52

    Program Headers:
      Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
      LOAD           0x002000 0xc0000000 0x00000000 0x511598 0x511598 R E 0x2000
      LOAD           0x514000 0xc0512000 0x00512000 0x5dffcc 0x5f1b4c RWE 0x2000
      NOTE           0x513544 0xc0511544 0x00511544 0x00054 0x00054 R   0x4
      GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x10

Also, I see your program has some printf's what does it print before it crashes?
Note that the program headers have Alignment requirements.  It looks like your
program is not using those.

> Questions:
> 1. Should `or1k-elf-gcc` generate code that respects OpenRISC's 4B alignment by default?

It's posssible.  Getting a better test program and understand your ELF loader
inputs can help confirm where the exact issue is.

> 2. Is there a compiler flag (e.g., `-mstrict-align`) or workaround to enforce safe unaligned access?

We don't have it.

> 3. Could this be a regression compared to the older `or32-elf-gcc`?

  As its a rewrite with no shared code, its just a feature we didnt carry
forward, Doing memcpy with 4B reads is going to be faster.  Perhaps old code had
support for analigned memcpy reads.  This is something we can possibly fix.

But it has not been a problem that has come up until now and we have compiled
many programs with the toolchain.

> Any insights would be greatly appreciated!

You can read this?

   https://www.kernel.org/doc/Documentation/unaligned-memory-access.txt

In general we usually try to write code that works without performing unaligned
access.

-Stafford
