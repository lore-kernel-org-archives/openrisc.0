Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B052229B15
	for <linux-openrisc@vger.kernel.org>; Thu,  5 Dec 2024 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733423959; cv=none; b=ISuFuuTQ0xPnkanhDR1PqYndxpZyOY+kZ0brPHoh0xHRkGioFnh0UihmWhuMC4VfucopmSUTNztOCxI6E0FcsM432wxdwIIrr2punYPWNthe2Wej7fYm9nL4OhNm1y6diLTHAgf26dGEX4nh89j8wvmkiTyic/3EfzK8b3pP1RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733423959; c=relaxed/simple;
	bh=tSSOA98V1ooVvl6nFyragV0ng/5yQsplGLl4src2huw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1XBuowgrO7slPI/4KOHuBlBmHTgn5VY09H2BL3NCYk5O8n4yvdZCKh1PxWAtbZcS4SdMnCrwCF226PoQqHv7JwWBhvULjmBavZyoyfgY+HN/LWyd7hLZUf1Kc2uj0oznplD7WJVTSBU50xfvVQdo+lR8bDzqkmNRc4ebJkY3lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXLpzAH9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXLpzAH9"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso8984935e9.1
        for <linux-openrisc@vger.kernel.org>; Thu, 05 Dec 2024 10:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733423956; x=1734028756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bU34PUEcdS74+JaGWlUkw3oTRGmAJJj4DYgTUuiOwCU=;
        b=jXLpzAH9+SGQCH2NsC6BD9nqZyQHmh5VH8oPjII7paNUbZ19uRBlI7VdTkymEC6frf
         V09i+1F+ypdRbnPMUFIAi6ISQHesXiCik9LvrKxvgjzxCk/bPvCCchJiHQg6AgS9/DN+
         kkvbJZFGkl1ygWmy/5FLfE2qyZC4D/szZdckVPY5dV+eMeTFL/+2c1sw0iidazFjRyPt
         BT7s5NsxBFoqZW1mDYYQDUibFDvRTJ0KDm5Wh240DxTAGpbrJD6OyRxLRv2DgaUWZgCr
         PRNZswu+3D19zUxTmt+LJFqTH+1253+9pkw8I5auvE9iWYOvopf/9lco9gzhyFdyfClc
         pafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733423956; x=1734028756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bU34PUEcdS74+JaGWlUkw3oTRGmAJJj4DYgTUuiOwCU=;
        b=AKuyYAsNrVbgF5BEk8/qqMwJ3e96PzD+bwjDbQ5oQ5ZLYVxxAzAK1C+Ie7CzIN7z7k
         RmxNBZTOiYdtAsj53QJ//3yAMLeaVPtSJ1B/iSW8WEOpbgYaCbMX3tEVqFnQ60mmsVau
         8luIH5uCUf9zT6JcOSREbuayCogBsy8Qde0O2YmhnflBlv+v2bD5DlGB6P9cbukvEUPA
         R/wYeRgJNDiuAgxbYGpj/Bya0xD+TkYf79QMSdQXZRG7EWezLFbACX0JmhlUZI8MrOcN
         znTiZLaZuhTV74ImGiHYj4LFMWsbUGTtYuKlR4G7IBxjJwCSh6XoC1Mcftoxq2XrAAQl
         YsAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA2F9hFFkGhya9dHxUhrOtwL9coHggBhAVHbLNKpknJD32rBc0qykY2v1VkMU3uDkviwxFC61TLC5CFLjg1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl91ljHhdmFxlRJN6inUnXbS5/sExv12UbQoNXLw9rxZXwVKNB
	KHwJOipMAksav191qwxeCEF1JZIhY0CAzcax/IpOYeHEhFp5Dw0poUzBBA==
X-Gm-Gg: ASbGncvH58hPCxDNTLv9zfxAoPWyzT/4u2+bCzFVCiNdgBYlCZcvN/x5hNJjp9CIYb7
	yp0v0JA70Dmy4gpu+39IzZdwJbpQH2YRpc9gvnmOTp4JpiT3SuDKLrezeYBTDr6hUqWV8rfIzmw
	XZQNixmdUgpY7DyRSFrw71KF2OaBPwfcoJuYdjv8hYvIc/mwmBlTyoGbGIjyBpMB0XlYpW2+7hd
	PMhyGa4cC/g/92BRDInfqGjSviMeDS+5RBWqaJQ8JN6sxvZQeZheu1q7Wah9z1KoTOPHcvOJ0U5
	2lhBgzW6Z6TliA==
X-Google-Smtp-Source: AGHT+IEeDWFKr4JDOoEYQvrbsIBtDhx61QbI1L3A4Igjq8+H6tjrlffJos2XaA3QAAgkYSdi/7493w==
X-Received: by 2002:a5d:64ce:0:b0:385:edb7:69ba with SMTP id ffacd0b85a97d-3862b335324mr135568f8f.1.1733423955668;
        Thu, 05 Dec 2024 10:39:15 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386219098c8sm2678882f8f.77.2024.12.05.10.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 10:39:14 -0800 (PST)
Date: Thu, 5 Dec 2024 18:39:13 +0000
From: Stafford Horne <shorne@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	linux-openrisc@vger.kernel.org
Subject: Re: [PATCH] openrisc: Fix misalignments in head.S
Message-ID: <Z1HzUZJ9TzVj5LlB@antec>
References: <5bd42e2b9e50929f7a1df03655bbaebb78f167ba.1733403630.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bd42e2b9e50929f7a1df03655bbaebb78f167ba.1733403630.git.geert+renesas@glider.be>

On Thu, Dec 05, 2024 at 02:04:26PM +0100, Geert Uytterhoeven wrote:
> Align all line continuations and (sub)section headers in a consistent
> way.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/openrisc/kernel/head.S | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
> index 439e00f81e5dde18..b64ac73455ed3279 100644
> --- a/arch/openrisc/kernel/head.S
> +++ b/arch/openrisc/kernel/head.S
> @@ -26,15 +26,15 @@
>  #include <asm/asm-offsets.h>
>  #include <linux/of_fdt.h>
>  
> -#define tophys(rd,rs)				\
> -	l.movhi	rd,hi(-KERNELBASE)		;\
> +#define tophys(rd,rs)						\
> +	l.movhi	rd,hi(-KERNELBASE)				;\
>  	l.add	rd,rd,rs
>  
> -#define CLEAR_GPR(gpr)				\
> +#define CLEAR_GPR(gpr)						\
>  	l.movhi	gpr,0x0
>  
> -#define LOAD_SYMBOL_2_GPR(gpr,symbol)		\
> -	l.movhi gpr,hi(symbol)			;\
> +#define LOAD_SYMBOL_2_GPR(gpr,symbol)				\
> +	l.movhi gpr,hi(symbol)					;\
>  	l.ori   gpr,gpr,lo(symbol)
>  
>  
> @@ -326,21 +326,21 @@
>  	l.addi  r1,r1,-(INT_FRAME_SIZE)				;\
>  	/* r1 is KSP, r30 is __pa(KSP) */			;\
>  	tophys  (r30,r1)					;\
> -	l.sw    PT_GPR12(r30),r12					;\
> +	l.sw    PT_GPR12(r30),r12				;\
>  	l.mfspr r12,r0,SPR_EPCR_BASE				;\
>  	l.sw    PT_PC(r30),r12					;\
>  	l.mfspr r12,r0,SPR_ESR_BASE				;\
>  	l.sw    PT_SR(r30),r12					;\
>  	/* save r31 */						;\
>  	EXCEPTION_T_LOAD_GPR30(r12)				;\
> -	l.sw	PT_GPR30(r30),r12					;\
> +	l.sw	PT_GPR30(r30),r12				;\
>  	/* save r10 as was prior to exception */		;\
>  	EXCEPTION_T_LOAD_GPR10(r12)				;\
> -	l.sw	PT_GPR10(r30),r12					;\
> -	/* save PT_SP as was prior to exception */			;\
> +	l.sw	PT_GPR10(r30),r12				;\
> +	/* save PT_SP as was prior to exception */		;\
>  	EXCEPTION_T_LOAD_SP(r12)				;\
>  	l.sw	PT_SP(r30),r12					;\
> -	l.sw    PT_GPR13(r30),r13					;\
> +	l.sw    PT_GPR13(r30),r13				;\
>  	/* --> */						;\
>  	/* save exception r4, set r4 = EA */			;\
>  	l.sw	PT_GPR4(r30),r4					;\
> @@ -394,7 +394,7 @@ _dispatch_do_ipage_fault:
>      .org 0x500
>  	EXCEPTION_HANDLE(_timer_handler)
>  
> -/* ---[ 0x600: Alignment exception ]-------------------------------------- */
> +/* ---[ 0x600: Alignment exception ]------------------------------------- */
>      .org 0x600
>  	EXCEPTION_HANDLE(_alignment_handler)
>  
> @@ -424,7 +424,7 @@ _dispatch_do_ipage_fault:
>      .org 0xc00
>  	EXCEPTION_HANDLE(_sys_call_handler)
>  
> -/* ---[ 0xd00: Floating point exception ]--------------------------------- */
> +/* ---[ 0xd00: Floating point exception ]-------------------------------- */
>      .org 0xd00
>  	EXCEPTION_HANDLE(_fpe_trap_handler)
>  
> @@ -816,7 +816,7 @@ secondary_start:
>  
>  #endif
>  
> -/* ========================================[ cache ]=== */
> +/* ==========================================================[ cache ]=== */
>  
>  	/* alignment here so we don't change memory offsets with
>  	 * memory controller defined

Hi Geert,

This all looks fine to me.  Traditionally I haven't attempted to fix up these
formatting issues as early on the maintainer Jonas was agaist this due to it
being unncessasary churn in the git history.  Also, it makes git blame a bit
more difficult to use.

However, I am fine with this if there are more people than must me who feel the
formatting needs fixing.

I will queue this up.

Thanks,

-Stafford
