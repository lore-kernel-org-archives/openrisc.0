Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F13CCA479
	for <openrisc@archiver.kernel.org>; Sat, 25 Jun 2022 04:05:02 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 582EC249DD;
	Sat, 25 Jun 2022 06:05:01 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mail.librecores.org (Postfix) with ESMTPS id 89811249DB
 for <openrisc@lists.librecores.org>; Sat, 25 Jun 2022 06:04:59 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id x4so4181489pfq.2
 for <openrisc@lists.librecores.org>; Fri, 24 Jun 2022 21:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=WBt/btUb8fidp7Od3hgblEREGwTCWyy1gmQjOCfY3fU=;
 b=U/9jOhfyin/xPm7/lhb3QQD5hUeqWoso3ZUE4nrDpj+uCxrVZoUa6Nd3Ck/My6d0yi
 uppYCT29YGR4+ED265rzl5CvHaPa9jAGrevS8NrjQCL2swa/6jIuJFW7ijxN5Kwk3kBm
 JV3zRaXX17ljjVxLWEmEYneBMjkOzcbgPwAATblJGSLPQW9zrru3NcHlbevjvxhjXf2X
 4fZUXrqKoxs5SGRwhMih22jCYG6mLHxDBQ9QA+V/Ap/ZmZMWhJBLgf3cIDLH/WvFpZqO
 6XUFzNOC5pd+9LH1sxuFUCYfWolIKgEMvYZ3auh92ECWjOyrr+qjV1d2Dawwr5UE8zHy
 fSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WBt/btUb8fidp7Od3hgblEREGwTCWyy1gmQjOCfY3fU=;
 b=dMWSMxFtBvd0BLbFHJXBsRUaSBnXNjYq2ER+tn6fMkW8y9QqQeuQgmzAhCCCanQuQB
 vTFn4xIBoOvTdYgU+ywHdXvsHqt3OXESqRtOlNlageRrOUCUXsgumQG5LcUf7MnfPSbU
 IioqA1S+zP86p9uSls9Dd9GyWnSogTqS3UMwt+j+tdTBo6KdIzCq1vKyL1wp+31QqTGg
 XahYhXLQvDd/oJ/rUrdpPb8HU1J1okqp4RGZ5xoiM4+bXbCthWxAZH6AUH/+Ha9wqijr
 1hknQhpi2/9eIe4xageIlBEy37cTTp7THrwr7KJ89Dgy3UAI34lg2yt6AnOXvlU1opuW
 Qsqw==
X-Gm-Message-State: AJIora+Rw0tRr7C/eDc4I8O1yA7bfexKdw5SHOeLR3BJRh1c3gWBhWpM
 r0Y+8evr0gUSh6iZGitwF2M=
X-Google-Smtp-Source: AGRyM1vLmqY6wDucr+TwoJMOmf3PJcPGDXbsAVQaOC2Ok2+1xpNGLbPuxQdolETx+44LH2D87vYqmw==
X-Received: by 2002:a63:44:0:b0:40c:9f98:a172 with SMTP id
 65-20020a630044000000b0040c9f98a172mr1947422pga.65.1656129897973; 
 Fri, 24 Jun 2022 21:04:57 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 n1-20020a170902e54100b00168adae4eb2sm2579898plf.262.2022.06.24.21.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jun 2022 21:04:57 -0700 (PDT)
Date: Sat, 25 Jun 2022 13:04:55 +0900
From: Stafford Horne <shorne@gmail.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V4 10/26] openrisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Message-ID: <YraJZ7OahapN5Y6z@antec>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
 <20220624044339.1533882-11-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624044339.1533882-11-anshuman.khandual@arm.com>
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, christophe.leroy@csgroup.eu,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
 linux-hexagon@vger.kernel.org, x86@kernel.org, linux-csky@vger.kernel.org,
 hch@infradead.org, linux-snps-arc@lists.infradead.org,
 linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Fri, Jun 24, 2022 at 10:13:23AM +0530, Anshuman Khandual wrote:
> This enables ARCH_HAS_VM_GET_PAGE_PROT on the platform and exports standard
> vm_get_page_prot() implementation via DECLARE_VM_GET_PAGE_PROT, which looks
> up a private and static protection_map[] array. Subsequently all __SXXX and
> __PXXX macros can be dropped which are no longer needed.
> 
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: openrisc@lists.librecores.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/openrisc/Kconfig               |  1 +
>  arch/openrisc/include/asm/pgtable.h | 18 ------------------
>  arch/openrisc/mm/init.c             | 20 ++++++++++++++++++++
>  3 files changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index e814df4c483c..fe0dfb50eb86 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -10,6 +10,7 @@ config OPENRISC
>  	select ARCH_HAS_DMA_SET_UNCACHED
>  	select ARCH_HAS_DMA_CLEAR_UNCACHED
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> +	select ARCH_HAS_VM_GET_PAGE_PROT
>  	select COMMON_CLK
>  	select OF
>  	select OF_EARLY_FLATTREE
> diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
> index c3abbf71e09f..dcae8aea132f 100644
> --- a/arch/openrisc/include/asm/pgtable.h
> +++ b/arch/openrisc/include/asm/pgtable.h
> @@ -176,24 +176,6 @@ extern void paging_init(void);
>  	__pgprot(_PAGE_ALL | _PAGE_SRE | _PAGE_SWE \
>  		 | _PAGE_SHARED | _PAGE_DIRTY | _PAGE_EXEC | _PAGE_CI)
>  
> -#define __P000	PAGE_NONE
> -#define __P001	PAGE_READONLY_X
> -#define __P010	PAGE_COPY
> -#define __P011	PAGE_COPY_X
> -#define __P100	PAGE_READONLY
> -#define __P101	PAGE_READONLY_X
> -#define __P110	PAGE_COPY
> -#define __P111	PAGE_COPY_X
> -
> -#define __S000	PAGE_NONE
> -#define __S001	PAGE_READONLY_X
> -#define __S010	PAGE_SHARED
> -#define __S011	PAGE_SHARED_X
> -#define __S100	PAGE_READONLY
> -#define __S101	PAGE_READONLY_X
> -#define __S110	PAGE_SHARED
> -#define __S111	PAGE_SHARED_X
> -
>  /* zero page used for uninitialized stuff */
>  extern unsigned long empty_zero_page[2048];
>  #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> index 3a021ab6f1ae..a654b9dcba91 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -208,3 +208,23 @@ void __init mem_init(void)
>  	mem_init_done = 1;
>  	return;
>  }
> +
> +static pgprot_t protection_map[16] __ro_after_init = {
> +	[VM_NONE]					= PAGE_NONE,
> +	[VM_READ]					= PAGE_READONLY_X,
> +	[VM_WRITE]					= PAGE_COPY,
> +	[VM_WRITE | VM_READ]				= PAGE_COPY_X,
> +	[VM_EXEC]					= PAGE_READONLY,
> +	[VM_EXEC | VM_READ]				= PAGE_READONLY_X,
> +	[VM_EXEC | VM_WRITE]				= PAGE_COPY,
> +	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY_X,
> +	[VM_SHARED]					= PAGE_NONE,
> +	[VM_SHARED | VM_READ]				= PAGE_READONLY_X,
> +	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
> +	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED_X,
> +	[VM_SHARED | VM_EXEC]				= PAGE_READONLY,
> +	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READONLY_X,
> +	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED,
> +	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED_X
> +};
> +DECLARE_VM_GET_PAGE_PROT

Looks good.

Acked-by: Stafford Horne <shorne@gmail.com>

