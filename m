Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08F8CCA47F
	for <openrisc@archiver.kernel.org>; Tue, 28 Jun 2022 00:37:52 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 842902492D;
	Tue, 28 Jun 2022 02:37:51 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mail.librecores.org (Postfix) with ESMTPS id 64C77248B4
 for <openrisc@lists.librecores.org>; Tue, 28 Jun 2022 02:37:50 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id 9so10618885pgd.7
 for <openrisc@lists.librecores.org>; Mon, 27 Jun 2022 17:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=WTNG3z1MrUyxvL7UAQDTN+O62H0agMHqunU14S/ptwM=;
 b=hhocxqSdC6zt/X72YVNhrC4Izpj6zT6NwuR7oH5SWCdKYj3vDTIaTq/73pUv4nIZCk
 1nVvOmCmFxtMMMZWie2lc3OEVmqDBfSFW7ysYt1t8mvElbtw4mIHfHmnyNcoTGkHJiSV
 YCEyT/tfECs4lK3RXhcIfgZ1hS6cuLCbyVqatszIJe7idcDlEYp5x+Q5XBWyhiNraMku
 QKtgu5MbvZFC5g3ZcElmT/i1PDlMxe12u85pSuSuUVoJg4KTWTu5JX8jY2wsFadZXYjR
 r3XVwm0OaoiP4beB3MfX4+h/2K7v/Hsq4fZ/qQaU8lS2I8JNganG3ZAU2CNrIK62CQbx
 ZHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WTNG3z1MrUyxvL7UAQDTN+O62H0agMHqunU14S/ptwM=;
 b=EK6TmveP+YokRLqTQiMlmXqVe3+Qzle/Ya+boRBBw0rbrXnp0FN1pSYlv8NEwRbK5S
 ZaM4pX04EUub3hko3dYsTUANj79xbb1SS6TvpFcExAUAEYyeoW3La7hAJEdh3dMJudlZ
 T68Av/rH42MEt/GAPvaGEwS+/sQAJwRNdp1627IHc15RYiiBg0zPCcvolkUawsWZTVx/
 pKeaVkdSd9qYvDYg/RaEFXMcQagDYpLehXaePezUAfYuj/fUMz6j1x/6s1p8cqvaEBgL
 wdW1FjBf8lroTEJY1Ws6DnaxuUh4ngS337j/N+5Tdfy5yp/LAj5uK32UP0ojZF+UCkEo
 ky9w==
X-Gm-Message-State: AJIora+1OVbOLMEnhqTUaRgkkYMdLvIoApjkHDI7pJrByswbPrCuM54O
 sOM/+gVO5aextW6zhKKlgLQ=
X-Google-Smtp-Source: AGRyM1tXLWLExWaF3rho6vquGXKFaLiWxx+kW8N1Jw5PU6QD2iuAv2WMGy5jKkMrvusmVrYLCgiIzA==
X-Received: by 2002:a05:6a00:b43:b0:525:2a02:8bdc with SMTP id
 p3-20020a056a000b4300b005252a028bdcmr641976pfo.28.1656376668788; 
 Mon, 27 Jun 2022 17:37:48 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a631f0a000000b003fbb455040dsm7670803pgf.84.2022.06.27.17.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 17:37:47 -0700 (PDT)
Date: Tue, 28 Jun 2022 09:37:46 +0900
From: Stafford Horne <shorne@gmail.com>
To: Xiang wangx <wangxiang@cdjrlc.com>
Subject: Re: [PATCH] openrisc: Fix syntax errors in comments
Message-ID: <YrpNWjLqHZrcrhl6@antec>
References: <20220602085350.12741-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602085350.12741-1-wangxiang@cdjrlc.com>
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
Cc: jonas@southpole.se, openrisc@lists.librecores.org,
 linux-kernel@vger.kernel.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Jun 02, 2022 at 04:53:50PM +0800, Xiang wangx wrote:
> Delete the redundant word 'the'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  arch/openrisc/kernel/unwinder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/openrisc/kernel/unwinder.c b/arch/openrisc/kernel/unwinder.c
> index 8ae15c2c1845..c6ad6f867a6a 100644
> --- a/arch/openrisc/kernel/unwinder.c
> +++ b/arch/openrisc/kernel/unwinder.c
> @@ -25,7 +25,7 @@ struct or1k_frameinfo {
>  /*
>   * Verify a frameinfo structure.  The return address should be a valid text
>   * address.  The frame pointer may be null if its the last frame, otherwise
> - * the frame pointer should point to a location in the stack after the the
> + * the frame pointer should point to a location in the stack after the
>   * top of the next frame up.
>   */
>  static inline int or1k_frameinfo_valid(struct or1k_frameinfo *frameinfo)
> -- 
> 2.36.1

This looks good to me, I will queue with 5.19 fixes.

-Stafford
