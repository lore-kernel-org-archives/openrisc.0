Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3243FC00144
	for <openrisc@archiver.kernel.org>; Fri, 29 Jul 2022 15:23:42 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 0080624A53;
	Fri, 29 Jul 2022 17:23:42 +0200 (CEST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by mail.librecores.org (Postfix) with ESMTPS id C438C248E4
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 17:23:40 +0200 (CEST)
Received: by mail-oi1-f172.google.com with SMTP id h125so6089060oif.8
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=4wO1MjeUsCDlwsXxvP/E1eIWCLhJk0oKRDyI5lcSaFI=;
 b=WgESSMakprr85bnAIQPsz93hHqlVj8N5EH6D+DWehMU4PB6BlOaHdBjAkTgO/LJ0Rt
 EEm6Rqosm6t46MPPgz5qOllPMZwC2TnrYVsdSK4VTAxsBocYtfk3hc7mR4iW+atazhhw
 uDDk3khZEOrUq+CH1dHeKhoH6+QSbkYBfTVb9pa3oQk5H6IDBMFv8JYTJF+UVTOvXVlJ
 +mnfFG1b5E682/EDOhbA7SF9QMgYcsFaT8f8u0gyAwfL6979t6yKtlvKATjgfhPgtAtw
 7AwV/iZnBQ7m2870ZxKq/WfbviEeLlfZCzjnt8JZ9T8m9JpnrovfgOvL71Y2P4bRRCgM
 wOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=4wO1MjeUsCDlwsXxvP/E1eIWCLhJk0oKRDyI5lcSaFI=;
 b=W4q0VhWjOmijvQTA1bv2WRz/CfcrxOGGEx6vEHGuko4ZaDkUa58uuObUYiCMSwFsrV
 2JNrIw7QLx0QK1zGyktV3VojXBc8Q0rTMwYEHZ3XBHSnKxh3L6iYw3yp03Mgam2D1k7u
 4iCKrPJufD8Tb4V1PlZGV0Fg69Y6njgoeErgzvCObkQjQ3e5/UFvDFyS9h0D0AsGRHku
 SqwzZdR11OkfRCkSUW72ZfBvDOpgnaEqjQvXO7/YHPKVkD0eF6hKuZ+/7duwvQGxF3w+
 RzvnjprhKhEi+c+p7fdyFUpcu1uNzOpLWwLr2DK2ruJZrvhD0wa32VUb3YB+4W5XpIMS
 +YJA==
X-Gm-Message-State: AJIora/ocH5xOIv245Mxa5Q2D/jpWNvw13R0dS39YR9mtDF1LSjVZuDL
 WlT7cVjjqDi+phNVIsBMXCs=
X-Google-Smtp-Source: AGRyM1s9mfSHeJiHkYhOkAbabMp3nfsDf8Y8VBHSW1TC3hP58L/6Rs9Y9EPWOom4qOR+6FOm1Op0PQ==
X-Received: by 2002:a05:6808:1201:b0:325:75e1:25a8 with SMTP id
 a1-20020a056808120100b0032575e125a8mr2048230oil.18.1659108219452; 
 Fri, 29 Jul 2022 08:23:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a9d6208000000b0061cbd18bd18sm1304415otj.45.2022.07.29.08.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jul 2022 08:23:37 -0700 (PDT)
Date: Fri, 29 Jul 2022 08:23:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH] openrisc: io: Define iounmap argument as volatile
Message-ID: <20220729152335.GA431060@roeck-us.net>
References: <20220729110726.3635262-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729110726.3635262-1-shorne@gmail.com>
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
Cc: Jonas Bonn <jonas@southpole.se>, openrisc@lists.librecores.org,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Fri, Jul 29, 2022 at 08:07:25PM +0900, Stafford Horne wrote:
> When OpenRISC enables PCI it allows for more drivers to be compiled
> resulting in exposing the following with -Werror.
> 
>     drivers/video/fbdev/riva/fbdev.c: In function 'rivafb_probe':
>     drivers/video/fbdev/riva/fbdev.c:2062:42: error:
> 	    passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type
> 
>     drivers/video/fbdev/nvidia/nvidia.c: In function 'nvidiafb_probe':
>     drivers/video/fbdev/nvidia/nvidia.c:1414:20: error:
> 	    passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type
> 
>     drivers/scsi/aic7xxx/aic7xxx_osm.c: In function 'ahc_platform_free':
>     drivers/scsi/aic7xxx/aic7xxx_osm.c:1231:41: error:
> 	    passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type
> 
> Most architectures define the iounmap argument to be volatile.  To fix this
> issue we do the same for OpenRISC.  This patch must go before PCI is enabled on
> OpenRISC to avoid any compile failures.
> 
> Link: https://lore.kernel.org/lkml/20220729033728.GA2195022@roeck-us.net/
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/openrisc/include/asm/io.h | 2 +-
>  arch/openrisc/mm/ioremap.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
> index 625ac6ad1205..ee6043a03173 100644
> --- a/arch/openrisc/include/asm/io.h
> +++ b/arch/openrisc/include/asm/io.h
> @@ -31,7 +31,7 @@
>  void __iomem *ioremap(phys_addr_t offset, unsigned long size);
>  
>  #define iounmap iounmap
> -extern void iounmap(void __iomem *addr);
> +extern void iounmap(volatile void __iomem *addr);
>  
>  #include <asm-generic/io.h>
>  
> diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
> index daae13a76743..8ec0dafecf25 100644
> --- a/arch/openrisc/mm/ioremap.c
> +++ b/arch/openrisc/mm/ioremap.c
> @@ -77,7 +77,7 @@ void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
>  }
>  EXPORT_SYMBOL(ioremap);
>  
> -void iounmap(void __iomem *addr)
> +void iounmap(volatile void __iomem *addr)
>  {
>  	/* If the page is from the fixmap pool then we just clear out
>  	 * the fixmap mapping.
> -- 
> 2.37.1
> 
