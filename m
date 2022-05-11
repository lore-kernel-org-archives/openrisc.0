Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A093C433EF
	for <openrisc@archiver.kernel.org>; Wed, 11 May 2022 20:54:26 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 23CE324911;
	Wed, 11 May 2022 22:54:25 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by mail.librecores.org (Postfix) with ESMTPS id CA1582490B
 for <openrisc@lists.librecores.org>; Wed, 11 May 2022 22:54:22 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 c1-20020a17090a558100b001dca2694f23so3102842pji.3
 for <openrisc@lists.librecores.org>; Wed, 11 May 2022 13:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QOBEiygmzdOccRJ2xs/t/iC85JI6XVGlts/kvxY1hCw=;
 b=g7FCdtcxf55q/ZSL4+jYR8X7GelzKz9XVwAEJyuojZG7N7IJOlQf1EwPdzlyNNLOBR
 ytkV4tRtc2Vfdq+2up8FXugivmqJUkJ1NKbO+VIhJONrOIaIBOCtGutSjprYv8muoWM/
 xFpAg+nEc1XkGMAScGvgPkXkOKukcm1Nhy9P+wg0vv+d2iwwxhvkJhTlsCNFlRTPLHgg
 dG4yDir/XFNlNGLFtp0GAO2V+yxH+QS6zoYwCATlABLFCKae72ZFEItTpiTF4fCtRQIQ
 r0N8HwLBIinDuXVL44RtEa6CL1WHQkl67HbwxwdGdBmypEV8jVq/yh8yGtuj5NyJFdg+
 7qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QOBEiygmzdOccRJ2xs/t/iC85JI6XVGlts/kvxY1hCw=;
 b=P6U+uxtJRqyVIDa3qYjAr56GexomC+9c1sL7ce+oJrAgIgh6BAwrdQS4dVmEXwM1WW
 AryG3m2Z+BFHxghl3vZYM9ZQuNcb2VumLhP/YeoW3Ajk8oWtZ8Z4Ip7FamCTKxX94ujs
 DwizWSCEkTSEnn91V0tQstaLUmBuBqs9P/thkuLHZj6cB9XjjOLghBB8VChfcBK+2lul
 qk+4er+ruKfCHIe2qJoL2iFDWKOPNWHkHw31nHQycSuA65uHmRIAUwW5Ybtbm9BEJ131
 hpREtXo1oi5S/xUwI1Wzof4NdNZkVp8MbD1VR+ImqszUtKRQuy1eK6jBb4O94NbRrbu3
 Yb4w==
X-Gm-Message-State: AOAM530bi5LHkhD+C8wlmSmZSJffpqAtHajhtsnrMI82ZSPbc6tyHZYa
 SrARe3q2C8FsPbV0Q8m/vGRx3YX+AjKDvg==
X-Google-Smtp-Source: ABdhPJwFu3ioJfSmYXGPxbC910Um6QR1JHzZzbjU+5wF3DCe4WFHNxpq4TDRRrij4g4Df0VGqvDlJQ==
X-Received: by 2002:a17:902:bd81:b0:15f:2f8f:ea99 with SMTP id
 q1-20020a170902bd8100b0015f2f8fea99mr6287215pls.7.1652302461242; 
 Wed, 11 May 2022 13:54:21 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 y23-20020a17090a8b1700b001d954837197sm373921pjn.22.2022.05.11.13.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 May 2022 13:54:20 -0700 (PDT)
Date: Thu, 12 May 2022 05:54:18 +0900
From: Stafford Horne <shorne@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v2] openrisc: remove bogus nops and shutdowns
Message-ID: <YnwiepO0tBvt4hMe@antec>
References: <YnMKHdRy/GkAB+9e@zx2c4.com>
 <20220511133550.143236-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511133550.143236-1-Jason@zx2c4.com>
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
Cc: openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Wed, May 11, 2022 at 03:35:50PM +0200, Jason A. Donenfeld wrote:
> Nop 42 is some leftover debugging thing by the looks of it. Nop 1 will
> shut down the simulator, which isn't what we want, since it makes it
> impossible to handle errors.
> 
> Cc: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Thanks, this looks good now. I will queue it.
