Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670CBC7618A;
	Sun, 19 Mar 2023 06:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCSGsW (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Sun, 19 Mar 2023 02:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCSGsV (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Sun, 19 Mar 2023 02:48:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD80826B2
        for <linux-openrisc@vger.kernel.org>; Sat, 18 Mar 2023 23:48:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id az3-20020a05600c600300b003ed2920d585so7332674wmb.2
        for <linux-openrisc@vger.kernel.org>; Sat, 18 Mar 2023 23:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679208497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vrCwJyAjnXOUL7fxB2RzqLOWmMj1ldWUA1XLSFlUXDI=;
        b=MehsdtQu5+1DXxpGHySQZ9Dks6lbtlyXTqTeCsq0m0y1Z/bcC9G2za3TPPr38Sbn4H
         uipcG6Y9YyAN+MOWajdbvyslXOlw81YMr7XTyUm4fURZNUgcwJWaiMpuV31F4QnSypSH
         aNq7Q4yKHDVnppm2PogwSQzDRugJPKO+TT6SZPuNd6D3tEC2yaPHeiFGWaCl1xtz8pOu
         3NtuZMMzij+itTMs5LQDNJmHKVv5F2uRaSXshljvZuwXZeDkB0wXO2WwfeDseF0YJaHh
         P0Gvfqq9I69kW2gS7yzE8V3TmhnKbRALu09wDHGjwewyvdG/S9xbIFZmamWo9g+k1pEZ
         oZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679208497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrCwJyAjnXOUL7fxB2RzqLOWmMj1ldWUA1XLSFlUXDI=;
        b=VjsD9n1Mdwlkj34xXyHLYYmTe7lkWlhPD/HsEpD2Zdo1jEdjtGazB2YUe+ogS6VVc9
         DAsw/GWmGi6BT6Rc3TPuM+vf5T64DUmYRFcsI2cRcH9nxX6Oc+2T3FcNwa1Nj7d+ceta
         Jsn188DE2iVRWOOy0SrVMz5IgR10thhDChHgIXben+xQs31W3MnGNypwA94VydV1WlTm
         bX7Qs8EFciGDQoS2WLUgbp9txeAR0awoUw8S5ICixCzUf3sqcv+wHqj/sdluqdEZHX7K
         cWo4dg6cDc/gQO2A9nb9vKNjLwuX7nF0K7uHwdE28hmbNa258TNDUskNIuNyYf5n1y2m
         t2sQ==
X-Gm-Message-State: AO0yUKUcB0rK4QbDC4wVHw50BcrgScHiCAlNAAUJg7xzlFIBFNDuu+ic
        GKEO+M3duuU5Yg0ek6sbiUndRNayuW8=
X-Google-Smtp-Source: AK7set+G/9JLW4UhkC0nu1rr6ceeadDCdnDd+TdrbQyaD9Cr2F0jWBXKbnsEYA1lsCY8eLx8nsUtvQ==
X-Received: by 2002:a05:600c:3b16:b0:3ed:2eb5:c2dd with SMTP id m22-20020a05600c3b1600b003ed2eb5c2ddmr16084036wms.39.1679208497138;
        Sat, 18 Mar 2023 23:48:17 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id q8-20020a1cf308000000b003ed4f6c6234sm6714466wmq.23.2023.03.18.23.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 23:48:15 -0700 (PDT)
Date:   Sun, 19 Mar 2023 15:48:15 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     GCC patches <gcc-patches@gcc.gnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH] or1k: Do not clear existing FPU exceptions before
 updating
Message-ID: <ZBawLxQ2wI1yz5eg@antec>
References: <20230318080405.2799610-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318080405.2799610-1-shorne@gmail.com>
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

Hello,

I pushed this upstream.

On Sat, Mar 18, 2023 at 05:04:05PM +0900, Stafford Horne wrote:
> We should always carry the exceptions forward.  This bug was found when
> working on testing glibc math tests, many tests were failing with
> Overflow and Underflow flags not set.  This was traced to here.
> 
> libgcc/ChangeLog:
> 
> 	* config/or1k/sfp-machine.h (FP_HANDLE_EXCEPTIONS): Remove
> 	statement clearing existing exceptions.
> ---
>  libgcc/config/or1k/sfp-machine.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/libgcc/config/or1k/sfp-machine.h b/libgcc/config/or1k/sfp-machine.h
> index 162c6bc5326..c804270fb3c 100644
> --- a/libgcc/config/or1k/sfp-machine.h
> +++ b/libgcc/config/or1k/sfp-machine.h
> @@ -73,7 +73,6 @@ do {								\
>  do {								\
>    if (__builtin_expect (_fex, 0))				\
>      {								\
> -      _fpcsr &= ~FP_EX_ALL;					\
>        _fpcsr |= _fex;						\
>        __asm__ volatile ("l.mtspr r0,%0,20" : : "r" (_fpcsr));	\
>      }								\
> -- 
> 2.39.1
> 
