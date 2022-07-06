Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E1DCCA480
	for <openrisc@archiver.kernel.org>; Wed,  6 Jul 2022 10:03:53 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 35316247EA;
	Wed,  6 Jul 2022 12:03:52 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mail.librecores.org (Postfix) with ESMTPS id A894721069
 for <openrisc@lists.librecores.org>; Wed,  6 Jul 2022 12:03:50 +0200 (CEST)
Received: by mail-qt1-f174.google.com with SMTP id r2so17467303qta.0
 for <openrisc@lists.librecores.org>; Wed, 06 Jul 2022 03:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=moQR5LBdu+yLzctPNV/vOqPzvGKHHurzxQlNOu9l9Us=;
 b=Z3jIettSGoA+LZQ8NPKjDk8icxSXlQ1tvJ1gPJK91kchLGHKmLqxfxQ5XEfu9bwKX+
 mSPNP8GO7Pre81JgMSh8dxJebMwAq4VZH9crWFRBNAIeuA7Muw7D5vLBnUWsa4btSco8
 Z9psm3rAdlRWPp+qKMJcUGP2HUcNgQco+y8O4PuqGPFRg1VjvviWx1yiOK1n6vYaeaqj
 1mHP/1euTnz3s6MtvsoYlzWI1uuzocDBJZaENZ3O5RWh+VSMv3gkTUH3r4+BlnGIYJDz
 1QKt1zSOYMBX4GX/4YmFNxODBIPIWGzgbIaTsRZMeWGOx5TTTvpZSsnOcoDeawWtVW2c
 ZlXQ==
X-Gm-Message-State: AJIora9IAOlTG6KEBtBjdPfiW4ydMnZaCsdfSb40jMasQWTc+6q92izv
 f/mEzhGDPvQ4DSmUNhepctVFjctggj1wDQ==
X-Google-Smtp-Source: AGRyM1vZSEbrXFiV63GwVLlyZ+Y4gAoeuHm8mZgaRJNyjWr7JKce8KC2yM+Gsk8AX3UJ4AieECdLwg==
X-Received: by 2002:ad4:5dcb:0:b0:470:46eb:3a1c with SMTP id
 m11-20020ad45dcb000000b0047046eb3a1cmr37194613qvh.69.1657101829578; 
 Wed, 06 Jul 2022 03:03:49 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com.
 [209.85.128.180]) by smtp.gmail.com with ESMTPSA id
 u5-20020a37ab05000000b006b4748535a1sm5635506qke.16.2022.07.06.03.03.49
 for <openrisc@lists.librecores.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Jul 2022 03:03:49 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-3137316bb69so134419107b3.10
 for <openrisc@lists.librecores.org>; Wed, 06 Jul 2022 03:03:49 -0700 (PDT)
X-Received: by 2002:a0d:c787:0:b0:31b:a963:e1de with SMTP id
 j129-20020a0dc787000000b0031ba963e1demr44581975ywd.283.1657101828958; Wed, 06
 Jul 2022 03:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220630051630.1718927-1-anshuman.khandual@arm.com>
 <20220630051630.1718927-22-anshuman.khandual@arm.com>
In-Reply-To: <20220630051630.1718927-22-anshuman.khandual@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Jul 2022 12:03:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX_Ji7dCzzCc3xw5ic6J=0PaPkyzXKpOgUFjjEkR+yJOw@mail.gmail.com>
Message-ID: <CAMuHMdX_Ji7dCzzCc3xw5ic6J=0PaPkyzXKpOgUFjjEkR+yJOw@mail.gmail.com>
Subject: Re: [PATCH V6 21/26] m68k/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
To: Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>, linux-csky@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 arcml <linux-snps-arc@lists.infradead.org>,
 "open list:TENSILICA XTENSA PORT \(xtensa\)" <linux-xtensa@linux-xtensa.org>,
 linux-um <linux-um@lists.infradead.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Openrisc <openrisc@lists.librecores.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Hi Anshuman,

On Thu, Jun 30, 2022 at 7:19 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> This enables ARCH_HAS_VM_GET_PAGE_PROT on the platform and exports standard
> vm_get_page_prot() implementation via DECLARE_VM_GET_PAGE_PROT, which looks
> up a private and static protection_map[] array. Subsequently all __SXXX and
> __PXXX macros can be dropped which are no longer needed.
>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks for your patch!

> --- a/arch/m68k/include/asm/mcf_pgtable.h
> +++ b/arch/m68k/include/asm/mcf_pgtable.h
> @@ -91,60 +91,6 @@
>   * for use. In general, the bit positions are xwr, and P-items are
>   * private, the S-items are shared.
>   */

The comment above should be removed, too.

> -#define __P000         PAGE_NONE
> -#define __P001         __pgprot(CF_PAGE_VALID \
> -                                | CF_PAGE_ACCESSED \
> -                                | CF_PAGE_READABLE)

> --- a/arch/m68k/include/asm/motorola_pgtable.h
> +++ b/arch/m68k/include/asm/motorola_pgtable.h
> @@ -83,28 +83,6 @@ extern unsigned long mm_cachebits;
>  #define PAGE_COPY_C    __pgprot(_PAGE_PRESENT | _PAGE_RONLY | _PAGE_ACCESSED)
>  #define PAGE_READONLY_C        __pgprot(_PAGE_PRESENT | _PAGE_RONLY | _PAGE_ACCESSED)

You might move the *_C definitions above into arch/m68k/mm/motorola.c
as well, as they are only used in the latter.

>
> -/*
> - * The m68k can't do page protection for execute, and considers that the same are read.
> - * Also, write permissions imply read permissions. This is the closest we can get..
> - */
> -#define __P000 PAGE_NONE_C
> -#define __P001 PAGE_READONLY_C
> -#define __P010 PAGE_COPY_C
> -#define __P011 PAGE_COPY_C
> -#define __P100 PAGE_READONLY_C
> -#define __P101 PAGE_READONLY_C
> -#define __P110 PAGE_COPY_C
> -#define __P111 PAGE_COPY_C
> -
> -#define __S000 PAGE_NONE_C
> -#define __S001 PAGE_READONLY_C
> -#define __S010 PAGE_SHARED_C
> -#define __S011 PAGE_SHARED_C
> -#define __S100 PAGE_READONLY_C
> -#define __S101 PAGE_READONLY_C
> -#define __S110 PAGE_SHARED_C
> -#define __S111 PAGE_SHARED_C
> -
>  #define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
>
>  /*
> diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/sun3_pgtable.h
> index 5e4e753f0d24..9d919491765b 100644
> --- a/arch/m68k/include/asm/sun3_pgtable.h
> +++ b/arch/m68k/include/asm/sun3_pgtable.h
> @@ -71,23 +71,6 @@
>   * protection settings, valid (implying read and execute) and writeable. These
>   * are as close as we can get...
>   */

The comment above should be removed, too.

> -#define __P000 PAGE_NONE
> -#define __P001 PAGE_READONLY

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
