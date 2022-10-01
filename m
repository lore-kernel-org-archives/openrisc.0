Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E502AC433F5
	for <openrisc@archiver.kernel.org>; Sat,  1 Oct 2022 11:36:00 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 16B6524B18;
	Sat,  1 Oct 2022 13:35:59 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by mail.librecores.org (Postfix) with ESMTPS id F383424B16
 for <openrisc@lists.librecores.org>; Sat,  1 Oct 2022 13:35:57 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id j7so5092076wrr.3
 for <openrisc@lists.librecores.org>; Sat, 01 Oct 2022 04:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=Wz4RRJY0pM1puy7PZmICr4TLt1AVOsJhnHvwVxqEGlE=;
 b=ZphsxuD8lHIQHZ/fKsTPvEWxQnO3Qrkv8GkN0g5jk+nULFzLG9mKHZN2BXZHTKukVr
 MXUZ2+c3XwFoJPWfXCm3iRsOIz0mJeVnPm4eOpkzeeMPU0ByBYQxtXsy3XtFIiZ97MkK
 TAac6gEW2xBGZtx5CNvd1zvHHgU1ameGIaGf4eg/PO6FjpE7CQAlehV60vElgM4W8J8i
 huL6wP/yunllXQE42rA6pQTvlvAdpm3ZyZkc9adSSHp/HtjbMo+CdBVY8k7lLM8SZYIZ
 LVfsaOy2gWVgL7PX8Yfp8Pclw8NBMy6Bcv3koa2gePsb9045rOLsL6VY8ZuIxYTdpGNB
 4pSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=Wz4RRJY0pM1puy7PZmICr4TLt1AVOsJhnHvwVxqEGlE=;
 b=mDMoIs5wfCJyDPgJSd8/SMfjsUJWAsGknCu/2vTWDJ4Uodg7RNa1xySfLykso2FPX+
 XGiLfOkA/B5FE/7wDrGdIxFM0yw6w7MSLthm4iMJabPmhGcfstl3EdVp/6sTg+1mK3qi
 GJEWpwNHibKagCEvzCg0sxXn9ve3IAERkCDizYTq0lngG0T9hKz7xwCFlsD34OkYqwuC
 Qi/AleICQyc/KaEGS0LHGjC4EDPodYpziFZ7bMZd7RkxHOxdv8hbtkIr2Nzi2La3tCVX
 2+kI5+9JhiGGYrnbSpLNqr4zW8JGESSBN1fQdZpu+LqtfSu0Nq79O29jGS1i6dPUHX4E
 VJJQ==
X-Gm-Message-State: ACrzQf1H4A/BqEH+8mdIRD/zSlZg9ldxzR+IhMvIO955b8ZVfm7/GGwL
 VTmqRfUuK/TsXS/nSYLUw/Y=
X-Google-Smtp-Source: AMsMyM64ctalizvFuDs0j3MfeBVVnHO15wJ2mtaQ322AH2hi2ofx1qwPGU/2g5WATQNwR2fqsGHjrw==
X-Received: by 2002:a5d:47a1:0:b0:22a:2979:4899 with SMTP id
 1-20020a5d47a1000000b0022a29794899mr7961356wrb.349.1664624157165; 
 Sat, 01 Oct 2022 04:35:57 -0700 (PDT)
Received: from localhost ([2a03:b0c0:1:d0::dee:c001])
 by smtp.gmail.com with ESMTPSA id
 w7-20020adfde87000000b0022afedf3c87sm4780898wrl.105.2022.10.01.04.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Oct 2022 04:35:56 -0700 (PDT)
Date: Sat, 1 Oct 2022 11:35:55 +0000
From: Stafford Horne <shorne@gmail.com>
To: gcc-patches@gcc.gnu.org
Subject: Re: [PATCH] or1k: Only define TARGET_HAVE_TLS when HAVE_AS_TLS
Message-ID: <YzgmG9Ihqt6xC7CA@oscomms1>
References: <20220929145740.4846-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929145740.4846-1-shorne@gmail.com>
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
Cc: openrisc@lists.librecores.org, Yann Morin <yann.morin@orange.com>,
 buildroot@buildroot.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Sep 29, 2022 at 03:57:40PM +0100, Stafford Horne wrote:
> This was found when testing buildroot with linuxthreads enabled.  In
> this case, the build passes --disable-tls to the toolchain during
> configuration.  After building the OpenRISC toolchain it was still
> generating TLS code sequences and causing linker failures such as:
> 
>  ..../or1k-buildroot-linux-uclibc-gcc -o gpsd-3.24/gpsctl .... -lusb-1.0 -lm -lrt -lnsl
>  ..../ld: ..../sysroot/usr/lib/libusb-1.0.so: undefined reference to `__tls_get_addr'
> 
> This patch fixes this by disabling tls for the OpenRISC target when requested
> via --disable-tls.
> 
> Tested-by: Yann E. MORIN <yann.morin@orange.com>
> 
> gcc/ChangeLog:
> 
> 	* config/or1k/or1k.cc (TARGET_HAVE_TLS): Only define if
> 	HAVE_AS_TLS is defined.

I have pushed this upstream now.  Adding buildroot patches should be easy to do
now.

-Stafford
