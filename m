Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C34C433EF
	for <openrisc@archiver.kernel.org>; Wed,  6 Jul 2022 10:04:39 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 64CA3247EA;
	Wed,  6 Jul 2022 12:04:38 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mail.librecores.org (Postfix) with ESMTPS id 1E67121052
 for <openrisc@lists.librecores.org>; Wed,  6 Jul 2022 12:04:37 +0200 (CEST)
Received: by mail-qk1-f176.google.com with SMTP id k20so10664065qkj.1
 for <openrisc@lists.librecores.org>; Wed, 06 Jul 2022 03:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Bj57DZQxAwyQ5rJJj/iE7VR9xSo/KE2P6unWd/aXevs=;
 b=hg7YZfNUxxLRl/sx9K/sfhr+5nEOpM7fnLmg+nZzl5Cm6+Zy6sRpWdLHdidP+Py2sr
 /V5DZY9lf/m2eqqpIO8p1xKksNwTnb3ov1yjiLppBCPHUkD6JSJ6njFLhuGf/TfG83/3
 Bfn27PRFqca103OcPVYCwe0lX8BN+9An9NrkbrXCzu+t+7DW65HbRN4QydtpD7aKWICS
 rm7hCxgfEDE+FKwQC6CvSVYlfoeTl8mg+H2THnJ48jySkDNUhOat7RYEuoTGSHm9fK/K
 yK3yVhVnDF6B0uX/bAi7PtNi33dEwzYlCeRnIu6jpEOfRJukija4hurrtaUK7puQEwsN
 AOfQ==
X-Gm-Message-State: AJIora/RVn3ATqi3DC06phZ1v7pF2V87JaPr0uRGjcaHBM3rbIQbteB8
 Uoy7E2M1RDxEGcmTM0Ud6gSoCnQDAqVjV8cm
X-Google-Smtp-Source: AGRyM1tMMHTjuw3kMR4yj5e+iHgA09hnQBO8AR9Ffy0l3Ud7c9z4z64eu7RdnHpEoi19wA4dXb0epA==
X-Received: by 2002:a05:620a:2a15:b0:6af:4404:99ce with SMTP id
 o21-20020a05620a2a1500b006af440499cemr26634941qkp.226.1657101875836; 
 Wed, 06 Jul 2022 03:04:35 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com.
 [209.85.219.179]) by smtp.gmail.com with ESMTPSA id
 br31-20020a05620a461f00b006af290182c8sm24681220qkb.86.2022.07.06.03.04.35
 for <openrisc@lists.librecores.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Jul 2022 03:04:35 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id l144so13983039ybl.5
 for <openrisc@lists.librecores.org>; Wed, 06 Jul 2022 03:04:35 -0700 (PDT)
X-Received: by 2002:a25:2b48:0:b0:668:3b7d:326c with SMTP id
 r69-20020a252b48000000b006683b7d326cmr41431788ybr.380.1657101874906; Wed, 06
 Jul 2022 03:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220630051630.1718927-1-anshuman.khandual@arm.com>
 <20220630051630.1718927-27-anshuman.khandual@arm.com>
In-Reply-To: <20220630051630.1718927-27-anshuman.khandual@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Jul 2022 12:04:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVJiS6vm2td-PBH3zpsNZJeeoudS4+yu4JG08sOi+XFdA@mail.gmail.com>
Message-ID: <CAMuHMdVJiS6vm2td-PBH3zpsNZJeeoudS4+yu4JG08sOi+XFdA@mail.gmail.com>
Subject: Re: [PATCH V6 26/26] mm/mmap: Drop ARCH_HAS_VM_GET_PAGE_PROT
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
 linux-riscv <linux-riscv@lists.infradead.org>, Christoph Hellwig <hch@lst.de>,
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
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Jun 30, 2022 at 7:20 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> Now all the platforms enable ARCH_HAS_GET_PAGE_PROT. They define and export
> own vm_get_page_prot() whether custom or standard DECLARE_VM_GET_PAGE_PROT.
> Hence there is no need for default generic fallback for vm_get_page_prot().
> Just drop this fallback and also ARCH_HAS_GET_PAGE_PROT mechanism.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  arch/m68k/Kconfig       |  1 -

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
