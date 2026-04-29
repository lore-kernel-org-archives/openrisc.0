Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2292E3AF1
	for <linux-openrisc@vger.kernel.org>; Wed, 29 Apr 2026 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777488197; cv=none; b=kUKXP7pxGJiK0Vxs/5RNaVE+WIZOxjqh3Dya/W20w7eylnPkOAABLh3Lysx/0jAoQIrCvzGw4KYy/ewzMheMYya7eRonYUAs3WfK4/a4mZOTyGPbMp+jsAE3bIKOwsJ8k5Urb0N/mHrj0alufh+NNSycAdxxBgeYpsgB4p7nDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777488197; c=relaxed/simple;
	bh=zRnnuCwPIKgd93EyBgotvlVBZWjc8KTqJVJouVgt4VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhGjqQjRASSCI1nKJuansyl8vUkhLQcv66NeS/FzkO9YqIM1VLTEfQj/5x5Dl7YNDq7NeaIx1SMUx2ATzPUG6FyYdcvnZ52KNUZgxYBbALZd/8wJGh8S+2Mr41+AkfdT+fDAKPGw0TS4NA1XmjgvgWfDm25g4v5j2yM/4X4IB3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qpYP18ti; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpYP18ti"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ba840146so554595e9.1
        for <linux-openrisc@vger.kernel.org>; Wed, 29 Apr 2026 11:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777488191; x=1778092991; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5PvAyRmYOwCsutDs/3QlOwr6NBq1uwDuUAIM/H5aHAc=;
        b=qpYP18ti1VeRu0iCmtuAvTNUErgj/E+XbTWIVuiHogaTZBORMkWmN40D2aRZeY1Q9F
         Cvibs6Jqj+YdpcXTT58B/wQS2F3Sr7wa50qF+n8ETahisb6odyCFSYXrGdPFZ9z9MHcj
         +MxP4UjJHNSkADEYCY3BpYPG2CizNorTcfq6s5kc11EAW2Aq2aBQIhccvjy0pDQ4Ym/F
         l47i5cGrDsIM1MzA/VP/9qNkxUc6kS6LqbmCDnV1oJ1v+IFqVY4lFOEI+XJppQ5a51Nf
         Qtny6SJ8+e754mFHBDvAsh02gzbSCyRZqyMi0RYcMHB0E2YNLyfWOpmtsxIiB6W0kOm4
         Xl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777488191; x=1778092991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5PvAyRmYOwCsutDs/3QlOwr6NBq1uwDuUAIM/H5aHAc=;
        b=tA/Ncq5wBCbmssRkN+DwhtVlIlz9MnQfZvh3eCgWGl2E8YcopkQMPwHp153wFruMor
         Bq7cSbIdAnK7vBS+Ra0j7uh0khmVkhNN3/1B01u44vKKly8Hegdf/+qRo5nWmZPF8RjI
         /PbquAU5JqdRuInuskmra2WGjltaGAgFdSD2j0uioJ4KPEdGrJhrKaTxEMldRwzQMY0P
         YG20BaFfbvkmyejBhoeOvGdYZn4Rfj9jZEm4S+qgs/KyK5uXvMpjVnIkpqy2Zr4jI20h
         wL3mNmGQ/fA+Q2CN5Zo2GuQpZscbq291i5Z1KMw+uisuzlJaG7BAU97NJZHQTnsdt9B9
         Pdww==
X-Forwarded-Encrypted: i=1; AFNElJ9IDtYe47hyTJKK6lFfaaOiLVaf4Su1raJo5GGfyPTyw6jh2SYCCDOnwPv6c3OUaB+wJjpnqDq539Ue8oRD/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxS8dkUwfbwpY1aj87ZQpjWt9oiBgQnMzhq6QFmRgeVbq4U5gfm
	bJZsNWh+NWgsQoy+AJFmi1Hj8VVeOUlAO+oGV6TIKbut/UiDDVS+NDXm
X-Gm-Gg: AeBDievCOjV3tQNEt5OF5jEPqKQ7z6Hd7JPWVg+5By3kgCsI6h6X7AIJExV5OElGr3h
	pyaccMhWvNf3IY30smjunHxxnmakDSmKCXbed0xjvpwNho0lzP9i7KXpdoTaAeTLRqkApoR7Shk
	0DzfzYVJqz3WS7wfpv9EU51NQNxZuxM2EHlY9uQQHYu2K+xUwLkxyDRPoElv3SIHd25aHww6hx0
	HWO6gdxFKSyLFEZHsEghnJoQpjXQONTTT3OtZ4C9lWY0bHizaoxnJ4/vz6i212a/Y+oNYX+N3XH
	/vnE1SomAvRuHffkaC4YIr3nGi7xI86Tp1x3qGPV36eTaCzE/tYBaUCqEkIpm+RhlYwhcbtgDBz
	TnVp6ACuWvudTiI6dCTebmq+RlXgFVlCUMx+DPMQHOFhsU6rd9/oQ6xJqujAvW4GG/hOCzV503i
	CQ8CkeboNMt2hj/JWtWH07eBfM1hmgMoXluvgp8xW5+uVZsAehC3tPH/bqgobbeqQzEiEhUK5kK
	aMQiOmVCq5lJWhMWfW1mADDYLc=
X-Received: by 2002:a05:600c:4e86:b0:48a:5333:811e with SMTP id 5b1f17b1804b1-48a77b1da83mr136575675e9.15.1777488190383;
        Wed, 29 Apr 2026 11:43:10 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c1c2b37sm45817015e9.1.2026.04.29.11.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 11:43:09 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:43:08 +0100
From: Stafford Horne <shorne@gmail.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/nolibc: add support for OpenRISC / or1k
Message-ID: <afJRPLFAHt2aTmEr@antec>
References: <20260429-nolibc-openrisc-v2-1-8d7d7a2f3fec@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260429-nolibc-openrisc-v2-1-8d7d7a2f3fec@weissschuh.net>

On Wed, Apr 29, 2026 at 05:20:45PM +0200, Thomas Weiﬂschuh wrote:
> Add support for OpenRISC / or1k to nolibc.
> 
> _start() uses the same wrapper construct as in arch-sh.h.
> libgcc is necessary as OpenRISC is missing 64-bit multiplication.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Acked-by: Stafford Horne <shorne@gmail.com>

Do you want me to pick this up to send via the openrisc queue? Or do you prefer
it go via the selftests queue?

> ---
> Changes in v2:
> - Drop useless l.nop from __nolibc_syscallX().
> - Use the delay slot after l.jal _start_c.
> - Fix some typos.
> - Use a single register variable for system call number and return.
> - Use 'r1' register name over non-idiomatic 'sp' alias.
> - Link to v1: https://patch.msgid.link/20260428-nolibc-openrisc-v1-1-33b399054af6@weissschuh.net

Thanks, I am ok with these.  I didn't realize the 'sp' mnemonic worked.  I
don't have any opinion either way as to whether we should use it or not, as I
suspect we have supported it in binutils/gas for a while.  But I guess it's
safer to leave it out as I haven't seen it used before now.

-Stafford

> ---
>  tools/include/nolibc/Makefile                  |   2 +-
>  tools/include/nolibc/arch-openrisc.h           | 160 +++++++++++++++++++++++++
>  tools/include/nolibc/arch.h                    |   2 +
>  tools/testing/selftests/nolibc/Makefile.nolibc |   5 +
>  tools/testing/selftests/nolibc/run-tests.sh    |   4 +-
>  5 files changed, 171 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
> index 872c318f50d4..2cb4d610fe53 100644
> --- a/tools/include/nolibc/Makefile
> +++ b/tools/include/nolibc/Makefile
> @@ -17,7 +17,7 @@ endif
>  # it defaults to this nolibc directory.
>  OUTPUT ?= $(CURDIR)/
>  
> -architectures := arm arm64 loongarch m68k mips powerpc riscv s390 sh sparc x86
> +architectures := arm arm64 loongarch m68k mips openrisc powerpc riscv s390 sh sparc x86
>  arch_files := arch.h $(addsuffix .h, $(addprefix arch-, $(architectures)))
>  all_files := \
>  		alloca.h \
> diff --git a/tools/include/nolibc/arch-openrisc.h b/tools/include/nolibc/arch-openrisc.h
> new file mode 100644
> index 000000000000..5ef82fd9cc64
> --- /dev/null
> +++ b/tools/include/nolibc/arch-openrisc.h
> @@ -0,0 +1,160 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +/*
> + * OpenRISC specific definitions for NOLIBC
> + * Copyright (C) 2026 Thomas Weiﬂschuh <linux@weissschuh.net>
> + */
> +
> +#ifndef _NOLIBC_ARCH_OPENRISC_H
> +#define _NOLIBC_ARCH_OPENRISC_H
> +
> +#include "compiler.h"
> +#include "crt.h"
> +
> +/*
> + * Syscalls for OpenRISC:
> + *   - syscall number is passed in r11
> + *   - arguments are in r3, r4, r5, r6, r7, r8
> + *   - the system call is performed by calling l.sys 1
> + *   - syscall return value is in r11
> + */
> +
> +#define _NOLIBC_SYSCALL_CLOBBERLIST \
> +	"r12", "r13", "r15", "r17", "r19", "r21", "r23", "r25", "r27", "r29", "r31", "memory"
> +
> +#define __nolibc_syscall0(num)                                                \
> +({                                                                            \
> +	register long _num __asm__ ("r11") = (num);                           \
> +									      \
> +	__asm__ volatile (                                                    \
> +		"l.sys 1\n"                                                   \
> +		: "+r"(_num)                                                  \
> +		:                                                             \
> +		: "r3", "r4", "r5", "r6", "r7", "r8",                         \
> +		  _NOLIBC_SYSCALL_CLOBBERLIST                                 \
> +	);                                                                    \
> +	_num;                                                                 \
> +})
> +
> +#define __nolibc_syscall1(num, arg1)                                          \
> +({                                                                            \
> +	register long _num __asm__ ("r11") = (num);                           \
> +	register long _arg1 __asm__ ("r3") = (long)(arg1);                    \
> +									      \
> +	__asm__ volatile (                                                    \
> +		"l.sys 1\n"                                                   \
> +		: "+r"(_num)                                                  \
> +		: "r"(_arg1)                                                  \
> +		: "r4", "r5", "r6", "r7", "r8", _NOLIBC_SYSCALL_CLOBBERLIST   \
> +	);                                                                    \
> +	_num;                                                                 \
> +})
> +
> +#define __nolibc_syscall2(num, arg1, arg2)                                    \
> +({                                                                            \
> +	register long _num __asm__ ("r11") = (num);                           \
> +	register long _arg1 __asm__ ("r3") = (long)(arg1);                    \
> +	register long _arg2 __asm__ ("r4") = (long)(arg2);                    \
> +									      \
> +	__asm__ volatile (                                                    \
> +		"l.sys 1\n"                                                   \
> +		: "+r"(_num)                                                  \
> +		: "r"(_arg1), "r"(_arg2)                                      \
> +		: "r5", "r6", "r7", "r8", _NOLIBC_SYSCALL_CLOBBERLIST         \
> +	);                                                                    \
> +	_num;                                                                 \
> +})
> +
> +#define __nolibc_syscall3(num, arg1, arg2, arg3)                              \
> +({                                                                            \
> +	register long _num __asm__ ("r11") = (num);                           \
> +	register long _arg1 __asm__ ("r3") = (long)(arg1);                    \
> +	register long _arg2 __asm__ ("r4") = (long)(arg2);                    \
> +	register long _arg3 __asm__ ("r5") = (long)(arg3);                    \
> +									      \
> +	__asm__ volatile (                                                    \
> +		"l.sys 1\n"                                                   \
> +		: "+r"(_num)                                                  \
> +		: "r"(_arg1), "r"(_arg2), "r"(_arg3)                          \
> +		: "r6", "r7", "r8", _NOLIBC_SYSCALL_CLOBBERLIST               \
> +	);                                                                    \
> +	_num;                                                                 \
> +})
> +
> +#define __nolibc_syscall4(num, arg1, arg2, arg3, arg4)                        \
> +({                                                                            \
> +	register long _num __asm__ ("r11") = (num);                           \
> +	register long _arg1 __asm__ ("r3") = (long)(arg1);                    \
> +	register long _arg2 __asm__ ("r4") = (long)(arg2);                    \
> +	register long _arg3 __asm__ ("r5") = (long)(arg3);                    \
> +	register long _arg4 __asm__ ("r6") = (long)(arg4);                    \
> +									      \
> +	__asm__ volatile (                                                    \
> +		"l.sys 1\n"                                                   \
> +		: "+r"(_num)                                                  \
> +		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4)              \
> +		: "r7", "r8", _NOLIBC_SYSCALL_CLOBBERLIST                     \
> +	);                                                                    \
> +	_num;                                                                 \
> +})
> +
> +#define __nolibc_syscall5(num, arg1, arg2, arg3, arg4, arg5)                  \
> +({                                                                            \
> +	register long _num __asm__ ("r11") = (num);                           \
> +	register long _arg1 __asm__ ("r3") = (long)(arg1);                    \
> +	register long _arg2 __asm__ ("r4") = (long)(arg2);                    \
> +	register long _arg3 __asm__ ("r5") = (long)(arg3);                    \
> +	register long _arg4 __asm__ ("r6") = (long)(arg4);                    \
> +	register long _arg5 __asm__ ("r7") = (long)(arg5);                    \
> +									      \
> +	__asm__ volatile (                                                    \
> +		"l.sys 1\n"                                                   \
> +		: "+r"(_num)                                                  \
> +		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5)  \
> +		: "r8", _NOLIBC_SYSCALL_CLOBBERLIST                           \
> +	);                                                                    \
> +	_num;                                                                 \
> +})
> +
> +#define __nolibc_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)            \
> +({                                                                            \
> +	register long _num __asm__ ("r11") = (num);                           \
> +	register long _arg1 __asm__ ("r3") = (long)(arg1);                    \
> +	register long _arg2 __asm__ ("r4") = (long)(arg2);                    \
> +	register long _arg3 __asm__ ("r5") = (long)(arg3);                    \
> +	register long _arg4 __asm__ ("r6") = (long)(arg4);                    \
> +	register long _arg5 __asm__ ("r7") = (long)(arg5);                    \
> +	register long _arg6 __asm__ ("r8") = (long)(arg6);                    \
> +									      \
> +	__asm__ volatile (                                                    \
> +		"l.sys 1\n"                                                   \
> +		: "+r"(_num)                                                  \
> +		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
> +		  "r"(_arg6)                                                  \
> +		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
> +	);                                                                    \
> +	_num;                                                                 \
> +})
> +
> +#ifndef NOLIBC_NO_RUNTIME
> +/* startup code */
> +void _start_wrapper(void);
> +void __attribute__((weak,noreturn))
> +__nolibc_entrypoint __nolibc_no_stack_protector
> +_start_wrapper(void)
> +{
> +	__asm__ volatile (
> +		".global _start\n"           /* The C function will have a prologue,         */
> +		".type _start, @function\n"  /* corrupting "sp/r1"                           */
> +		".weak _start\n"
> +		"_start:\n"
> +
> +		"l.jal _start_c\n"           /* transfer to c runtime                        */
> +		"l.or r3,r1,r1\n"            /* save stack pointer to r3, as arg1 of _start_c */
> +
> +		".size _start, .-_start\n"
> +	);
> +	__nolibc_entrypoint_epilogue();
> +}
> +#endif /* NOLIBC_NO_RUNTIME */
> +
> +#endif /* _NOLIBC_ARCH_OPENRISC_H */
> diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
> index a3adaf433f2c..55009dcafe9e 100644
> --- a/tools/include/nolibc/arch.h
> +++ b/tools/include/nolibc/arch.h
> @@ -28,6 +28,8 @@
>  #include "arch-m68k.h"
>  #elif defined(__sh__)
>  #include "arch-sh.h"
> +#elif defined(__or1k__)
> +#include "arch-openrisc.h"
>  #else
>  #error Unsupported Architecture
>  #endif
> diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
> index f30bc68470cc..91f5a284f4e6 100644
> --- a/tools/testing/selftests/nolibc/Makefile.nolibc
> +++ b/tools/testing/selftests/nolibc/Makefile.nolibc
> @@ -92,6 +92,7 @@ IMAGE_sparc32    = arch/sparc/boot/image
>  IMAGE_sparc64    = arch/sparc/boot/image
>  IMAGE_m68k       = vmlinux
>  IMAGE_sh4        = arch/sh/boot/zImage
> +IMAGE_openrisc   = vmlinux
>  IMAGE            = $(objtree)/$(IMAGE_$(XARCH))
>  IMAGE_NAME       = $(notdir $(IMAGE))
>  
> @@ -121,6 +122,7 @@ DEFCONFIG_sparc32    = sparc32_defconfig
>  DEFCONFIG_sparc64    = sparc64_defconfig
>  DEFCONFIG_m68k       = virt_defconfig
>  DEFCONFIG_sh4        = rts7751r2dplus_defconfig
> +DEFCONFIG_openrisc   = virt_defconfig
>  DEFCONFIG            = $(DEFCONFIG_$(XARCH))
>  
>  EXTRACONFIG_x32       = -e CONFIG_X86_X32_ABI
> @@ -159,6 +161,7 @@ QEMU_ARCH_sparc32    = sparc
>  QEMU_ARCH_sparc64    = sparc64
>  QEMU_ARCH_m68k       = m68k
>  QEMU_ARCH_sh4        = sh4
> +QEMU_ARCH_openrisc   = or1k
>  QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
>  
>  QEMU_ARCH_USER_ppc64le = ppc64le
> @@ -199,6 +202,7 @@ QEMU_ARGS_sparc32    = -M SS-5 -m 256M -append "console=ttyS0,115200 panic=-1 $(
>  QEMU_ARGS_sparc64    = -M sun4u -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_m68k       = -M virt -append "console=ttyGF0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_sh4        = -M r2d -serial file:/dev/stdout -append "console=ttySC1,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> +QEMU_ARGS_openrisc   = -M virt -m 512M -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS            = -m 1G $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
>  
>  # OUTPUT is only set when run from the main makefile, otherwise
> @@ -233,6 +237,7 @@ CFLAGS_XARCH = $(CFLAGS_$(XARCH))
>  endif
>  
>  LDLIBS_ppc = $(if $(LLVM),,-lgcc)
> +LDLIBS_openrisc = $(if $(LLVM),,-lgcc)
>  LDLIBS = $(LDLIBS_$(XARCH))
>  
>  include Makefile.include
> diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
> index cd439096fdf3..c25ee4be2df4 100755
> --- a/tools/testing/selftests/nolibc/run-tests.sh
> +++ b/tools/testing/selftests/nolibc/run-tests.sh
> @@ -21,6 +21,7 @@ all_archs=(
>  	i386 x86_64 x32
>  	arm64 arm armthumb
>  	mips32le mips32be mipsn32le mipsn32be mips64le mips64be
> +	openrisc
>  	ppc ppc64 ppc64le
>  	riscv32 riscv64
>  	s390x
> @@ -107,6 +108,7 @@ crosstool_arch() {
>  	case "$1" in
>  	arm64) echo aarch64;;
>  	armthumb) echo arm;;
> +	openrisc) echo or1k;;
>  	ppc) echo powerpc;;
>  	ppc64) echo powerpc64;;
>  	ppc64le) echo powerpc64;;
> @@ -185,7 +187,7 @@ test_arch() {
>  			exit 1
>  	esac
>  	printf '%-15s' "$arch:"
> -	if [ "$arch" = "m68k" -o "$arch" = "sh4" ] && [ "$llvm" = "1" ]; then
> +	if [ "$arch" = "m68k" -o "$arch" = "sh4" -o "$arch" = "openrisc" ] && [ "$llvm" = "1" ]; then
>  		echo "Unsupported configuration"
>  		return
>  	fi
> 
> ---
> base-commit: 8bf37d924968cf26ab95f644c981a28086e372af
> change-id: 20260415-nolibc-openrisc-a1ab91c41fe5
> 
> Best regards,
> --  
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 
