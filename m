Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE27C43334
	for <openrisc@archiver.kernel.org>; Thu,  9 Jun 2022 11:29:38 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id EF8FF242D4;
	Thu,  9 Jun 2022 13:29:37 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mail.librecores.org (Postfix) with ESMTPS id B211620E4E
 for <openrisc@lists.librecores.org>; Thu,  9 Jun 2022 13:29:36 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id j7so21096966pjn.4
 for <openrisc@lists.librecores.org>; Thu, 09 Jun 2022 04:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rPbNZAvxoxinrsT0YAYNcWPM5l+kDGVkaMGJNCnII0A=;
 b=Yl3RDUKkXhEaBTl3CojytukOajM0vAhpREsZG2uhaei/FIv4Scpc+AB5/AWIgAOtid
 iiFCAw1ZHOYtTqSghvooiSkTDQQA3bKZnBvpb85hWCsid4btEkebcM7yXX67hYt2UlZ2
 oUiUCZ3cPXSOv6PImiXN90C4IOlcOJyrgdW/IWaF1U/5MRqSuSw1kFG2JEgvhGBa3ZlY
 T41EcvH7bWyjQ+zbEn/a5y2A3mgMIF+tp0/3jpVr4BfSN3juiBTX+Ql6AGwA7TdbH7hO
 Zb2bio+uaXpFeWRNfRmmGz1E0x88V2gHO1VTgzZV/8guid6oZA18wkTykb+LyghsLlZc
 HYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rPbNZAvxoxinrsT0YAYNcWPM5l+kDGVkaMGJNCnII0A=;
 b=sc9XZtHTqgdbx2y9peYXPyAiyYKNsjZUCBHnojV5Bj7sZFLOKNCti2nf1dYEDG7bgw
 5Ca/u5Sq1Q4rDk6FQgvAWKZUui3F/XcB5i7qK+B2WPQRUg6Z1vp2rO/MV1ZJ4aY/NiXg
 rmDtU22o8s4ziPPf0Al39lIohKu5Ih8IavOqpxDq+0IUNblPlG4K4kmANBMu2y4ZLqtt
 +w7JKTMOJnv3QFI3F8VWFkwpZL6XE0mSQ5XFzWDYkkY5tQP3j67Vq6lqRPgwdPu34UFS
 SF+6Aqqp+xpH6kotvY35RHVm8KxdlPfXIWlV1vsshvCFo63SJnO7zLxK+myC8R4aNL5Z
 D+UQ==
X-Gm-Message-State: AOAM530BLYfQgJimvdGxlsyd79hwZyAPY8h/x6xtrTjcGf/E6myQ/PVx
 1Sw+pNndaqHYBceYfG2ZL+A=
X-Google-Smtp-Source: ABdhPJzj3OLtQNr93xT9qh38O7aTpxsQSQS7x452dR+92+5+5c0j7ZxoPev76UXcAEKU2GaGbR/oTw==
X-Received: by 2002:a17:90b:4c8a:b0:1e3:60f:58c3 with SMTP id
 my10-20020a17090b4c8a00b001e3060f58c3mr2985427pjb.230.1654774175082; 
 Thu, 09 Jun 2022 04:29:35 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 oj17-20020a17090b4d9100b001e2608203d4sm18420129pjb.5.2022.06.09.04.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jun 2022 04:29:34 -0700 (PDT)
Date: Thu, 9 Jun 2022 20:29:32 +0900
From: Stafford Horne <shorne@gmail.com>
To: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] or1k: Add support for a little-endian target variant
Message-ID: <YqHZnGBh6ty6MiJp@antec>
References: <20220609060357.26436-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609060357.26436-1-samuel@sholland.org>
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
Cc: openrisc@lists.librecores.org, gcc-patches@gcc.gnu.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

> diff --git a/gcc/config.gcc b/gcc/config.gcc
> index c5064dd37666..0c3a09dfe810 100644
> --- a/gcc/config.gcc
> +++ b/gcc/config.gcc
> @@ -2866,6 +2866,11 @@ or1k*-*-*)
>  	done
>  	TM_MULTILIB_CONFIG=`echo $TM_MULTILIB_CONFIG | sed 's/^,//'`
>  
> +	case ${target} in
> +	or1k*le*-*)

Should this be just or1kle*-*?

> +		tm_defines="${tm_defines} TARGET_LITTLE_ENDIAN_DEFAULT=1"
> +		;;
> +	esac
>  	case ${target} in
>  	or1k*-*-linux*)
>  		tm_file="${tm_file} gnu-user.h linux.h glibc-stdint.h"


> diff --git a/gcc/config/or1k/or1k.opt b/gcc/config/or1k/or1k.opt
> index 8a66832a99b1..497f259faae9 100644
> --- a/gcc/config/or1k/or1k.opt
> +++ b/gcc/config/or1k/or1k.opt
> @@ -24,6 +24,14 @@
>  HeaderInclude
>  config/or1k/or1k-opts.h
>  
> +mbig-endian
> +Target Report RejectNegative Mask(BIG_ENDIAN)
> +Use big-endian byte order.
> +
> +mlittle-endian
> +Target Report RejectNegative InverseMask(BIG_ENDIAN, LITTLE_ENDIAN)
> +Use little-endian byte order.
> +

We should explain what is the default int he doc's.

Can you also document in: gcc/doc/invoke.texi

This looks good, thank you.

-Stafford
