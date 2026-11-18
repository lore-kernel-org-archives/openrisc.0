Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795043040;
	b=NfYwwlMoYGRoaAvU8ZwXWtegDWeNlP8W53wGC3uW8zShNI9t5IRAGa6tmjR2OZJaTxLZ
	 ELxw8i7yxkVWva1n7nVd/qpji73a51StIGp29XtyCK5LxbHmoDj8FwsMBReAe0j5cV0M3
	 snWQUzgMJAupcTaoGHc7w27ci4cHirn6Q7+1qSzozsBj9v0WEdV1SG0BT8nG0oZfJwdEj
	 KwiwlIm/5S0gDmlQJEarULYzK0stCe0LKB2+ckS3qtGbnmEZuvXrSNzVqHdzNwwoFV8R7
	 pZmD10ToPS0WQifV6A0VUzMtrTa0gv/N0cm6/rYdV+7TiI4923kjZ99x1y6tPUjuHYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=i4iIo8Mq+sa6c0unlydNIobU5/d3a9Jv12oAlD0QbJE=;
	b=AQqugHTU99pkh6KvsmtoSN4TSUAkImF8SS1m5tTlbhUuTKIor1S8cH1jokVQWrxmEnwM
	 QgQbD3nN6rnl3CBcq6jElEjAyrObl84YasPIKdD0ykMD4zslK/HYy+oq/PU/+k5PXJGA5
	 nGY9WNyMfleWAaJ5sy+4yC5krTcaa+RqY8zj0eNCNwqjkJzIebdxNWB0TcMH93VGoqzQH
	 6ghI6FXOv3xjJMGIKqbE9vn82qstO9fuSEaNVutRPkbXJLcdUK3CELj5AG9A6dHm+gzRA
	 zU4sANu0RyCw5yaR3/7WV8C3yrvceqrDSCILthkpbqTcvE/ssWUHsh+kvxQtyXefcMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d7KqKanJ;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7905A60A2618
	for <linux-openrisc@vger.kernel.org>; Wed, 18 Nov 2026 23:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7905A60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d7KqKanJ
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb6057b333so8090135e9.3
        for <linux-openrisc@vger.kernel.org>; Wed, 18 Nov 2026 15:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795043039; x=1795647839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i4iIo8Mq+sa6c0unlydNIobU5/d3a9Jv12oAlD0QbJE=;
        b=d7KqKanJSoLFBZhFpVRvnvMHT8xNhQc0a4N+nuV1SxQaWe2yTGlEX8XNa4auyifYaX
         oUwe9LXuIEkSbq2es3uznEkZrp8gATdhncMWZw5Pp4bv4XTquDNXzSvtY3u5AsZ+vsPK
         65sZTwqDQTWe2//IbR0jx0ID9EHYrbYkqjy1K+0FKGa/cKvxK9Y1NoCeCqNSW2sXHQcc
         sZztzmu/U87B1aA/Gu8ywP7hZFMVdc0+IfQlCZUqUzRq6oluoqgWg0u3gZVlYYok3h9B
         SegA3MXMbAi9R95YKpXiJIJxqHm4jV4SO/7JhSJwZk6Ny4J53Cc7PsHOl6lY1CiisyWT
         zkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795043039; x=1795647839;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i4iIo8Mq+sa6c0unlydNIobU5/d3a9Jv12oAlD0QbJE=;
        b=Lc4mteAK5QetHTVZpl7vTHi/P85t3KM8Gp7JhRakgNLkPAcZ5g7qplXBuxtYsebiqn
         gXLNp7E24meCZBYqr6ZGB+iPCiJ7QiF+cPwkMJfZUoUNk0fvb5cKY6G8hgQmuSEZ8Kr4
         JCx6DcvHmLhn7jv9IuDe6qoZO0P6CYvyb7hwlKrn17T9RsFFmxfYFpT0F/dn5PxWwHzR
         V4yO+BMJPP5osyJv2aLX1zCx5l93wQYg+1OYyJoX2XSNoqnymSmNt0os1PacwjRuoMgg
         eTXCic2QWweE2yPDH3oO/0+Smmb/8ScN7i46La41PE8zTyYrtSk4cRjVy7tLCft7wzue
         vh/A==
X-Forwarded-Encrypted: i=1; AL+hErFpsHGCM4AB2Pb/N/gtSmTFmlGre08d93XWaqucrWTXAJ5vO4i0rzoikJwfjqN4fF6JeCG0J+2IRjwEn6N0Hg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Zm4H6Xu4gpcWmZQnl8Gbb8kB55IaVDoJIYHB1elAFyC3/9dsQ
	sahd8/C8ejqY1SODj7bBgwsiRRvggCvlbir2+v3b0ulwTIQLpB0JAV6F
X-Gm-Gg: AYBFou2X0GeIXxgKaxEB8ADQXFZ2UjnPpe1Ngm/3xpuAQgzpuU5MoEff7J/HoLRVil8
	SABlzTaloRuOuznlxI6uqNYGMexhxQVIbB8ql4kyVfrCP1n7XBDqDMhzPC7QHZR12/zby+PFzrm
	x2lx/dc5MbYItR1I9Kqapu15vzix7/UrNIqBb19lnu+DGQYxrxwkg7u5QepDNruZJmyPuCqDJHo
	PfPrE9aK2vdo51reYp16pqVvQ8kExBUWwLg2nt4YZJE0zBIIwS1a7rgbM7pMAdxggHY/XdZkv3M
	CCxdkIEjrwFlzOvS5HSrcK/bK1v8X7E8Fq7Ch+AtcJ0FicWhRHaHqOjBN38mOa8gs/6ZAMIbX6o
	LIbeUngofz0LA0b6iKO+uYS9D23zA60lJAswjPXgVyJyBu+ugE2uwtTsL/z1jj1VAdI+Ca5qg4O
	rALVLXynokqdjP8ww3sKOwZieedmjB0yJ877vHVg287M4byuhWem8lcQtXNdQHOA6UakNCD5wqi
	RFjhoiZZwfkjBgcUpXOydG/nBD94EX8PeA7M1scPLix0OsY/3HLOmyuA7asKUiRAayfzRqB6QPM
	IVKBdItPWpUHZlAZGWuD6r5lfvkGplP9tTvMHuZOCHUVOIuJNljDUME1HftfRljOZTpJfD5+R8C
	iGq09mN4=
X-Received: by 2002:a05:600c:5491:b0:4bb:5e6b:49e with SMTP id 5b1f17b1804b1-4bb7d9fb0e0mr80338115e9.6.1795043038706;
        Wed, 18 Nov 2026 15:03:58 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb842e93f6sm4886145e9.2.2026.11.18.15.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 15:03:56 -0800 (PST)
Date: Wed, 18 Nov 2026 23:03:55 +0000
From: Stafford Horne <shorne@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: soc@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	Vineet Gupta <vgupta@kernel.org>, linux-openrisc@vger.kernel.org
Subject: Re: [PATCH] openrisc: stop using libgcc
Message-ID: <av4u27rT4UqtnXUM@antec>
References: <20261118160820.2994933-1-arnd@kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Post: <mailto:linux-openrisc@vger.kernel.org>
List-Help: <mailto:linux-openrisc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-openrisc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118160820.2994933-1-arnd@kernel.org>

On Wed, Nov 18, 2026 at 05:08:20PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Based on the work for nios2 and arc, remove the inclusion of libgcc
> and instead use the kernel's own copy of the required functions.
> 
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Simon Schuster <schuster.simon@siemens-energy.com>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: linux-openrisc@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
> Hi Stafford,
> 
> I've based this on top of the branch at
> https://lore.kernel.org/all/20261118144652.3124085-1-dinguyen@kernel.org/
> which I've merged into the asm-generic tree. Vineet already
> has a similar patch for arch/arc, and I did the one for
> arch/openrisc after seeing that everything is there.
> 
> If this looks ok to you, please Ack so I can merge it in the 
> asm-generic tree as well.

Thanks,

This all looks good to me. Acked above.

-Stafford

> 
>  arch/openrisc/Kconfig             | 10 ++++++++++
>  arch/openrisc/Makefile            |  3 ---
>  arch/openrisc/kernel/or32_ksyms.c | 14 --------------
>  3 files changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index 6aaedc67a5e0..5be29befd86c 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -22,6 +22,16 @@ config OPENRISC
>  	select GENERIC_IRQ_CHIP
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_IRQ_SHOW
> +	select GENERIC_LIB_LSHRDI3
> +	select GENERIC_LIB_ASHLDI3
> +	select GENERIC_LIB_ASHRDI3
> +	select GENERIC_LIB_MULDI3
> +	select GENERIC_LIB_UCMPDI2
> +	select GENERIC_LIB_DIVSI3
> +	select GENERIC_LIB_MODSI3
> +	select GENERIC_LIB_UDIVSI3
> +	select GENERIC_LIB_UMODSI3
> +	select GENERIC_LIB_MULSI3
>  	select GENERIC_PCI_IOMAP
>  	select GENERIC_IOREMAP
>  	select GENERIC_CPU_DEVICES
> diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
> index 68249521db5a..38dc87bc6a3a 100644
> --- a/arch/openrisc/Makefile
> +++ b/arch/openrisc/Makefile
> @@ -18,7 +18,6 @@
>  KBUILD_DEFCONFIG := or1ksim_defconfig
>  
>  OBJCOPYFLAGS    := -O binary -R .note -R .comment -S
> -LIBGCC 		:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
>  
>  KBUILD_CFLAGS	+= -pipe -ffixed-r10 -D__linux__
>  KBUILD_CFLAGS	+= -msfimm -mshftimm
> @@ -55,8 +54,6 @@ ifeq ($(CONFIG_OPENRISC_HAVE_INST_SEXT),y)
>  	KBUILD_CFLAGS += $(call cc-option,-msext)
>  endif
>  
> -libs-y		+= $(LIBGCC)
> -
>  PHONY += vmlinux.bin
>  
>  vmlinux.bin: vmlinux
> diff --git a/arch/openrisc/kernel/or32_ksyms.c b/arch/openrisc/kernel/or32_ksyms.c
> index 5aabef30ca09..7ae38030a9d4 100644
> --- a/arch/openrisc/kernel/or32_ksyms.c
> +++ b/arch/openrisc/kernel/or32_ksyms.c
> @@ -27,20 +27,6 @@
>  #include <asm/hardirq.h>
>  #include <asm/delay.h>
>  
> -#define DECLARE_EXPORT(name) extern void name(void); EXPORT_SYMBOL(name)
> -
> -/* compiler generated symbols */
> -DECLARE_EXPORT(__udivsi3);
> -DECLARE_EXPORT(__divsi3);
> -DECLARE_EXPORT(__umodsi3);
> -DECLARE_EXPORT(__modsi3);
> -DECLARE_EXPORT(__muldi3);
> -DECLARE_EXPORT(__mulsi3);
> -DECLARE_EXPORT(__ashrdi3);
> -DECLARE_EXPORT(__ashldi3);
> -DECLARE_EXPORT(__lshrdi3);
> -DECLARE_EXPORT(__ucmpdi2);
> -
>  EXPORT_SYMBOL(__copy_tofrom_user);
>  EXPORT_SYMBOL(__clear_user);
>  EXPORT_SYMBOL(memset);
> -- 
> 2.53.0
> 
