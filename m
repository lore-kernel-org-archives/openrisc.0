Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0602BC19F2B
	for <openrisc@archiver.kernel.org>; Fri, 29 Jul 2022 05:51:00 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id B73C120FF5;
	Fri, 29 Jul 2022 07:50:59 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mail.librecores.org (Postfix) with ESMTPS id 634C8242D7
 for <openrisc@lists.librecores.org>; Fri, 29 Jul 2022 07:50:57 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 w63-20020a17090a6bc500b001f3160a6011so5498467pjj.5
 for <openrisc@lists.librecores.org>; Thu, 28 Jul 2022 22:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=hooXzavq61OdyVwoEg3NJ7Ka9aB9gcxnUcMNvrkkRcI=;
 b=iMgD4NGv+2uIl/fjBfL2BN4KrO0PvbxewwctglR5ywpPU1nqsajLaHJpNmCJ1EMPqw
 iINEDLWgJJAX9HhGMOyRQZLHpLMCZk8p0MUgRS/QVVWyykG9ubjZI5LICP1B17yp0ie8
 HB9XPkOySDkJ+tFA6qqGaMvC2PS2SS2TUm5npGVO7PpQXD8NLyTcqyi1N9YxsjE9Q/6y
 Na84lACy3H1pQJj9yqcsVYuIR9OEHo7/mERPRdOQ56Bp6xSijnPqo9DxQ4NcWstvup16
 c0aBlTa3NGg6her7sVQI+m7j4uBcp6IPMndixEUrPda5OMr0dbRjXpD5fsFSwg9BFzuh
 Wv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hooXzavq61OdyVwoEg3NJ7Ka9aB9gcxnUcMNvrkkRcI=;
 b=Er34aULGhnpI6LN5zyhPsc5B8yO6MDEK2dxN725LE8kVMy3qnGDzuN6zIaQggAFTrj
 8O6orNNxunf+ApSRa4RTEUCn5/l3VOjTJR1drXj/xUugJbQdvzD2SrVAJg4UD4OJzmBM
 YBwLyi2xh42ThEmUYgNAsVShqSYg4L3YvRBPFl1hsuHPbebWVfpCGU0BzVEcp4ocr5xO
 rkw0vPyY3kVI7vil61I5U/KWygSLmASJ7MaBBz/IsY6dx3BwGFd1O4xQh+GmWMXsyCq6
 P1kcn9Hujd9PIHEn1DBN2l7pkzuFcOOQdC7ZeKnupYcBF/GPTTx7MWcqkh7VkwE1JrJQ
 S0lQ==
X-Gm-Message-State: ACgBeo1HKD1F7z54IoOrKdGdU1DGv9OWNTbMZU52rhgpJJwBgelThlV4
 WjazSMycli8BTAVwJ4GTkb0=
X-Google-Smtp-Source: AA6agR7GcbuMOAjWweWH8vNuHQGGnZ6wC0D9a0qyNyE89WFYthYxlpKly4dFc2cbaFH5+NglJmAr+w==
X-Received: by 2002:a17:902:eac2:b0:16d:cce2:e5c6 with SMTP id
 p2-20020a170902eac200b0016dcce2e5c6mr2230262pld.149.1659073855479; 
 Thu, 28 Jul 2022 22:50:55 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 o6-20020a625a06000000b005259578e8fcsm1800443pfb.181.2022.07.28.22.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Jul 2022 22:50:55 -0700 (PDT)
Date: Fri, 29 Jul 2022 14:50:53 +0900
From: Stafford Horne <shorne@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/3] openrisc: Add pci bus support
Message-ID: <YuN1PWcDukEPdtQy@antec>
References: <20220725020737.1221739-1-shorne@gmail.com>
 <20220725020737.1221739-3-shorne@gmail.com>
 <20220729033728.GA2195022@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729033728.GA2195022@roeck-us.net>
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
Cc: Jonas Bonn <jonas@southpole.se>, Arnd Bergmann <arnd@arndb.de>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, openrisc@lists.librecores.org,
 Bjorn Helgaas <helgaas@kernel.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Jul 28, 2022 at 08:37:28PM -0700, Guenter Roeck wrote:
> On Mon, Jul 25, 2022 at 11:07:36AM +0900, Stafford Horne wrote:
> > This patch adds required definitions to allow for PCI buses on OpenRISC.
> > This is being tested on the OpenRISC QEMU virt platform which is in
> > development.
> > 
> > OpenRISC does not have IO ports so we keep the definition of
> > IO_SPACE_LIMIT and PIO_RESERVED to be 0.
> > 
> > Note, since commit 66bcd06099bb ("parport_pc: Also enable driver for PCI
> > systems") all platforms that support PCI also need to support parallel
> > port.  We add a generic header to support compiling parallel port
> > drivers, though they generally will not work as they require IO ports.
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> This patch results in
> 
> Building openrisc:allmodconfig ... failed
> --------------
> Error log:
> drivers/video/fbdev/riva/fbdev.c: In function 'rivafb_probe':
> drivers/video/fbdev/riva/fbdev.c:2062:42: error:
> 	passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type
> 
> drivers/video/fbdev/nvidia/nvidia.c: In function 'nvidiafb_probe':
> drivers/video/fbdev/nvidia/nvidia.c:1414:20: error:
> 	passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type
> 
> drivers/scsi/aic7xxx/aic7xxx_osm.c: In function 'ahc_platform_free':
> drivers/scsi/aic7xxx/aic7xxx_osm.c:1231:41: error:
> 	passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type
> 
> ... and so on.
> 
> Prior to this patch, the code was not enabled because it depends on PCI.

Hi Guenter,

Thanks for reporting this.

It's interesting, I don't get this on the openrisc/for-next branch.

BTW, do you turn off WERROR on the allmodconfig config?  I get many warnings
such as the below, but I haven't looked into it much yet:

    fs/exec.c: In function 'shift_arg_pages':
    fs/exec.c:687:27: error: 'tlb' is used uninitialized [-Werror=uninitialized]
      687 |         struct mmu_gather tlb;
	  |                           ^~~

I will try to see what is going on in linux-next.

-Stafford

