Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F872AD20
	for <linux-openrisc@vger.kernel.org>; Fri, 12 Sep 2025 06:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757657455; cv=none; b=ip6OfOZSfcoAmaPtjPB8rTN+CHTqe08b/E6acK8V9RQg4rhyUEyRq61Jfbg/eyWPREYuND+P0/Nlws64PyFdPn1ElpzY32Fc0hADrKvFQXDOyw7vNmTfhKp4H4dlsAfDPppL6cUuTnQv+vNk6F8kZ0BjzgNF9Daof41hV1SLUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757657455; c=relaxed/simple;
	bh=tkQeY1fSriekvByW2kQsBRrTqAH3Pgp8gd0+r/tBA6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FagREgXaoQZ5G6eu+SBzvOYe1EQS3QdiRMGPCIitCDQv4iZT6CJrpq35Iq2kTBQ4+9W5FvZ4B6SUHehCK6mQ26MJzdzlzQUbBZf+IzhE34zEpkHTxtkG+nHtyOAN5PsFT8SOoE5Pndrv+sm0/hQSBpuTznenJYob6Gd9FMS+HYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0yA2YTY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0yA2YTY"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e7622483beso772204f8f.3
        for <linux-openrisc@vger.kernel.org>; Thu, 11 Sep 2025 23:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757657452; x=1758262252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xkcnkimq0914P3F1WhqHUu/ZQqNnkVGBME3u91cNVxM=;
        b=P0yA2YTY8MiqpphsgHm4Pjc+LWKPbV6I8PQ1cPbL9fhURGNoM2/rKZck0oWbmfTcW6
         NuXRxa38nVVD2gZvokES+kRvTAvNABPXDKcvMU6RyHDKeLwoRF/SJYa4DaoeIkxB4jb4
         Ilf7JMpkwvVnopV0ADaEDrMdvGjqR4rrFf9myE8ykB33BH3KBaW/vAYFQA60HOS5Jr9v
         EK765grzy0zpIjv2opqHQbKZiPR6yfr2qhQfAwgUxtlK0dK5hFMICg0NTBZCustw0Akl
         8hIm2gTV8aRZFlRWnDHmik/JcvpJ6SaqU9Pa9kV/aeYZKPTDmlYDyiQQjHH+eoSERBAK
         Hdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757657452; x=1758262252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xkcnkimq0914P3F1WhqHUu/ZQqNnkVGBME3u91cNVxM=;
        b=ZCdjrWGcpT4Nm5rgr8G40OFBXcIIT+NBRyRlYnFRVCXr7nQWH6aGgp0VP5eyLf9uCn
         88hJacQi6ZIrY3nxS1SiBrbZgzX39jp2dedbWaya5DqvbwSKABFP2wLNMN1743jwnxjk
         YGXMe4SWNaA4O16UUTD8zLMNIu7Y+1l+4jx1eeWBZYdbBrX6Olq1V/JFU/ST6xcz4mnf
         2FuAnhnYALcomVpgXHFDsdyxXWc7UyQPDz6pkjnuy9x7mO4ZqVItPJ7IogXX4pW9Ud07
         16gTktXRAkstoH8ezx68ByA8PnjGM8joJw0C5y5P0cOsrbh3ZuWqwtQSCwMk9tdBDoOk
         Hgaw==
X-Forwarded-Encrypted: i=1; AJvYcCV2zb3X0NeC7rpJ91p5tw9AxfgtUzvHKXoaerKUOSVHTM8fAK+u+3Mt/lyAdHNm9/Fx1d5Mv2ahHPK9FSPP1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXoOoIClpJv2jqsGlXl55tYSoQi6voRfg+jufmyT+rIlPuGZsR
	QA4Fbg92dT8bDkotMmA+v4GN1wrjhHkmGV0yqN02uSOmkKcFULfhb05n
X-Gm-Gg: ASbGncvPOmpHn9DaxMH53XqbONgITsngSD2mpCkpO6e5lsqt8WiPJBNDEjkzAp+z4SX
	jMwIxA/TUwEd1SE7GOHl2ZyFIXApX5tDNaLG3W53MQild9Mb2cV8JM0ZcKRDXAEk8g8VR6GiN0B
	Etc/kXNFQl42wMxHbdIvGx381SWx1FqeLsSVTeRHjjhdizURLeH5vKzi10RHTd+CihWJthnCR56
	dQ69mXdPp3NYWBu6Mkz2u3wYVhnF+ZRXU2yo7CPC1W9FFFTraEGua+ZoLgvBGKG/z/r660+oCSy
	9yv/TFulS+QnQ7+Z/b3fqQ7pOuAkMFVtoYBftf5fvd+vmGxy+7eBc0eQykf5Q0aehLrhzHSuKaa
	cHWRAsoERWD0IiAvP5u2gdJXHvSM0xLeDsIByoy8xkpSXYY+AreMAH+MGm046dg==
X-Google-Smtp-Source: AGHT+IH1FVKft+zZv4E3Bkd7VErYv120ayA/V4pOg6fBv9ezf+S/3RkIlorWf/a1Z5+AyjKuXhq1LA==
X-Received: by 2002:a05:6000:178b:b0:3e7:5f26:f1f3 with SMTP id ffacd0b85a97d-3e7658c0f20mr1529249f8f.25.1757657451930;
        Thu, 11 Sep 2025 23:10:51 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e766659ea0sm1874680f8f.43.2025.09.11.23.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:10:50 -0700 (PDT)
Date: Fri, 12 Sep 2025 07:10:50 +0100
From: Stafford Horne <shorne@gmail.com>
To: ChenMiao <chenmiao.ku@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] openrisc: Support basic trace mechanism
Message-ID: <aMO5ap21H455GbfQ@antec>
References: <20250905181258.9430-1-chenmiao.ku@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905181258.9430-1-chenmiao.ku@gmail.com>

I have queued this for 6.18 now.

-Stafford

On Fri, Sep 05, 2025 at 06:12:54PM +0000, ChenMiao wrote:
> From: chenmiao <chenmiao.ku@gmail.com>
> 
> Hello everyone,
> 
> This implements a basic text patching mechanism and a complete jump_label
> implementation for OpenRISC. It should be noted that the jump_label have
> passed testing.
> 
> 1. Implement the patch_map interface and the patch_insn_write single insn
> write API by providing FIX_TEXT_POKE0. And create a new insn-def.h to record
> openrisc's instruction macro definition which only have OPENRISC_INSN_SIZE
> now.
> 
> 2. Support for the R_OR1K_32_PCREL relocation type is added for module insertion,
> enabling subsequent jump_label selftest module insertion.
> 
> 3. Regenerate defconfigs for or1ksim_defconfig and virt_defconfig.
> 
> 4. Based on the previously implemented patch_insn_write, achieve a complete
> jump_label implementation, directly supporting arch_jump_label_transform_queue.
> And add a new macro OPENRISC_INSN_NOP in insn-def.h.
> 
> Link: https://lore.kernel.org/openrisc/CAKxVwgdGe59F=giPXsukmQDO=XY58BH2gAMCV6uCR=vmwkAyyQ@mail.gmail.com/T/#t
> 
> Thanks,
> 
> Chen Miao
> 
> ---
> Changes in V5:
>   - Simplified some code in the fourth patch and removed unnecessary braces.
> 
> Changes in V4:
>   - Added testing for jump_label
>   - Split part of the jump_label patch content to form the third patch
>   - Implemented R_OR1K_32_PCREL module support for jump_label testing
> 
> Changes in V3:
>   - Removed the is_exit_text used, added some necessary comments.
>   - Modify some macro like __ASSEMBLY__ to __ASSEMBLER__ and ensure the
>     defconfig by make savedefconfig.
> 
> Changes in V2:
>   - Add a new insn-def.h to record the insn macro.
>   - Modify the patch_insn_write API from const void* to u32 insn.
>   - Using the modified patch_insn_write API in 
>     arch_jump_label_transform_queue.
> 
> chenmiao (4):
>   openrisc: Add text patching API support
>   openrisc: Add R_OR1K_32_PCREL relocation type module support
>   openrisc: Regenerate defconfigs.
>   openrisc: Add jump label support
> 
>  .../core/jump-labels/arch-support.txt         |  2 +-
>  arch/openrisc/Kconfig                         |  2 +
>  arch/openrisc/configs/or1ksim_defconfig       | 19 ++---
>  arch/openrisc/configs/virt_defconfig          |  2 +-
>  arch/openrisc/include/asm/Kbuild              |  1 -
>  arch/openrisc/include/asm/fixmap.h            |  1 +
>  arch/openrisc/include/asm/insn-def.h          | 15 ++++
>  arch/openrisc/include/asm/jump_label.h        | 72 +++++++++++++++++
>  arch/openrisc/include/asm/text-patching.h     | 13 +++
>  arch/openrisc/kernel/Makefile                 |  2 +
>  arch/openrisc/kernel/jump_label.c             | 51 ++++++++++++
>  arch/openrisc/kernel/module.c                 |  4 +
>  arch/openrisc/kernel/patching.c               | 79 +++++++++++++++++++
>  arch/openrisc/kernel/setup.c                  |  2 +
>  arch/openrisc/mm/init.c                       |  6 +-
>  15 files changed, 255 insertions(+), 16 deletions(-)
>  create mode 100644 arch/openrisc/include/asm/insn-def.h
>  create mode 100644 arch/openrisc/include/asm/jump_label.h
>  create mode 100644 arch/openrisc/include/asm/text-patching.h
>  create mode 100644 arch/openrisc/kernel/jump_label.c
>  create mode 100644 arch/openrisc/kernel/patching.c
> 
> -- 
> 2.45.2
> 
