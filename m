Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2973EC43334
	for <openrisc@archiver.kernel.org>; Sun,  5 Jun 2022 06:07:19 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 0EE8E240E1;
	Sun,  5 Jun 2022 08:07:19 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mail.librecores.org (Postfix) with ESMTPS id 0E3C020C7C
 for <openrisc@lists.librecores.org>; Sun,  5 Jun 2022 08:07:17 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id 7so9652590pga.12
 for <openrisc@lists.librecores.org>; Sat, 04 Jun 2022 23:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ntiAGYWvOui4xB3cbO1kuW43WbW64QLsxlfvqLjsP00=;
 b=UNdwgXBqNRzek8pEr5Qw32/XwVITDA54mg7Kzlts/3Dok86B2ZXU7Lqr1Wdv51FkOu
 D+DjiX7VwRrTKbDe9kWrgm/TbkjVysKd4l5D7wVPorYtHyYfdyRppXHf4MZfzJ7QRI0G
 EC3BWN8KlO2/z7rWQ5i+BIzMbh+leiVDSOc8qAYViWptCWWG4Owq+H4XBnLjjs1xCcOz
 A8JCjb5m0d0MotydVY6eHW9GrrnezCP2hIrGtTB7iBJQaS8HSmbaubLLvbOEwEFd1AwU
 Y4nKLkkmEYL9atMXbUbAZFFBIXckKQRQLkBUUHtnrU17dM/sv/B9E0r1k5EpKBBHQfIF
 cZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ntiAGYWvOui4xB3cbO1kuW43WbW64QLsxlfvqLjsP00=;
 b=7NVgrYQxhjkKVzzBjLFK9skVVdu2Ko3GOuSjKIcWK5u1nXUqwLrhWe4ZQdnknzKV5z
 CcQ4PM+SUtqtmDswfEuS5bwWThbOkzYngNsL/smhLc67R9E4hY3fHJH8Gx4LaomT3Aqs
 MT+5OU4SWbtU03tsoS0MW+DG2AQlCZejCFzSW6Zj7JicxXjt17tyQxp0bEuRK/Ow260M
 B8mtONtplcRi9B8kRkqSsfRe6sJuR3W4YfxVMeM7NMNnYTwS4IqV0q/HR11+V1qwJj4W
 MVIO70u+6IiZsME+DzAd5Iw+DgJ+aVd7gvCM1al9H++Q/DV3j6zbFsW270CP69wIa9dJ
 D97A==
X-Gm-Message-State: AOAM530A6PnrPDX3GfaxmsXkMiHblenYyt4WQb0lsfOpXztqcYmMnSyp
 5gssaSZ1SSYFw9xdYe12jiU=
X-Google-Smtp-Source: ABdhPJyA1lhiKwlzudDECY/g6A/17Ban2AXmzmlCM0DNLWnaso1OtO7XN2+wdSLdJ6SJvCSQi3abLQ==
X-Received: by 2002:a05:6a00:1594:b0:51b:f4ec:4c02 with SMTP id
 u20-20020a056a00159400b0051bf4ec4c02mr5896399pfk.27.1654409235449; 
 Sat, 04 Jun 2022 23:07:15 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a1709026e0100b0015e8d4eb231sm8153260plk.123.2022.06.04.23.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jun 2022 23:07:14 -0700 (PDT)
Date: Sun, 5 Jun 2022 15:07:12 +0900
From: Stafford Horne <shorne@gmail.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 6/6] openrisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Message-ID: <YpxIENWD3gOkFiG2@antec>
References: <20220603101411.488970-1-anshuman.khandual@arm.com>
 <20220603101411.488970-7-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603101411.488970-7-anshuman.khandual@arm.com>
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, Will Deacon <will@kernel.org>,
 Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 openrisc@lists.librecores.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 Dinh Nguyen <dinguyen@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Fri, Jun 03, 2022 at 03:44:11PM +0530, Anshuman Khandual wrote:
> This defines and exports a platform specific custom vm_get_page_prot() via
> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> macros can be dropped which are no longer needed.
> 
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: openrisc@lists.librecores.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Is it possible to retract my Acked-by?  I was following the discussion of this
new function actually being sub optimal.  So as far as I am concerned all these
architecture patches should be nak'ed.

-Stafford
