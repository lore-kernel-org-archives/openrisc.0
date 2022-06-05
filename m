Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3165EC433EF
	for <openrisc@archiver.kernel.org>; Sun,  5 Jun 2022 00:57:26 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id E109F2491C;
	Sun,  5 Jun 2022 02:57:25 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mail.librecores.org (Postfix) with ESMTPS id 016992491C
 for <openrisc@lists.librecores.org>; Sun,  5 Jun 2022 02:57:23 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id s68so10126638pgs.10
 for <openrisc@lists.librecores.org>; Sat, 04 Jun 2022 17:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=704nB+LTYV6mHO90K6jxpvGVqEdboKazXJjjeT2atxg=;
 b=cTXUd0yaVk2IGSKrzT/K+q0K4mvfFIx5mPu37hZEVkIRQQDGwCnFinRgYC3AgayHLM
 sEvAOlMrKjCV+7dizCX5ctL6Nt+Lm4Up5bwoblcC2mrwfDsu4CUATJPP5tKUQgXOsLf4
 KOa9ED9mJtCfCtG5GhGQPiTZeqIpWjwEGwqTSnk/Zk0qKnXk7x5pPjlPMCt1vAwIC6Ne
 eb54LVXCm2Zv9JxbNqu/+REW/RvvuMqNEdyKE+x6sfbWCWOtYX7ftQ2SD8KPBcjtYP6x
 lK7rqnK/MGUm1MYCkbQLmGwZ9XaEbT8ehtW1tb+mdvePL63WWi9UOeIB8jCk4IOcb4hW
 tEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=704nB+LTYV6mHO90K6jxpvGVqEdboKazXJjjeT2atxg=;
 b=3NFqljJt4V4DhtgfHF6Q+LF17B4p3yxVH6OwaD6O0o+B/sXp3es69CBA4Jse1cll1W
 xTa6ZgMnNvhNK5PS9JzlEjLZC/4kSOiAqbXhjr/tJIFwHMM/5fSWE8xCyjE/wzYiGHim
 rapGb9nqTEwD1gCzuVEJxP30rW2SsZ2UPG1y5zta+sYqAbnJIyzD61K/u9gYDYl1TopR
 iLZiUnuWvob6lsMQXeEfg4DHP9i8FGwWn9iZtjZKRgH31g8t0hgO6vX55+61WP5dGPXS
 Vb3duf58v+0PQs3szJtyMji1C2ZhjXmV2UsbPK/wUlKBMGmIV373MwGVsLx4To8Z8vnM
 He+A==
X-Gm-Message-State: AOAM532wI/LeWas+q7opn8uUpDeruccP/aKYf4effPxznS+NJCSggELG
 Idx8+fZsPVLwIKRP6crsrko=
X-Google-Smtp-Source: ABdhPJwbi/Ggmw0TKeZ1YTcpF2V0NncSKz/ipKsbpNX6cmT1YkXlw0NoIwdTDIUrFmdQ57wU7XggTA==
X-Received: by 2002:a62:1553:0:b0:51b:e0fe:ea34 with SMTP id
 80-20020a621553000000b0051be0feea34mr10126216pfv.23.1654390642293; 
 Sat, 04 Jun 2022 17:57:22 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a1709029a8600b0016760c06b76sm2008234plp.194.2022.06.04.17.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jun 2022 17:57:21 -0700 (PDT)
Date: Sun, 5 Jun 2022 09:57:20 +0900
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH 1/3] target/openrisc: Add basic support for semihosting
Message-ID: <Ypv/cBqa5CUeXoaj@antec>
References: <20220527172731.1742837-1-shorne@gmail.com>
 <20220527172731.1742837-2-shorne@gmail.com>
 <0a1051aa-f2f5-02de-693c-2c8b5e002998@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a1051aa-f2f5-02de-693c-2c8b5e002998@linaro.org>
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Openrisc <openrisc@lists.librecores.org>,
 QEMU Development <qemu-devel@nongnu.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Jun 02, 2022 at 08:39:21AM -0700, Richard Henderson wrote:
> On 5/27/22 10:27, Stafford Horne wrote:
> > +void do_or1k_semihosting(CPUOpenRISCState *env, uint32_t k);
> ...
> > +DEF_HELPER_FLAGS_2(nop, 0, void, env, i32)
> 
> Just call the helper "semihosting" and be done with it.
> And the helper wants an ifdef for system mode.
> 
> > @@ -10,6 +10,7 @@ openrisc_ss.add(files(
> >     'fpu_helper.c',
> >     'gdbstub.c',
> >     'interrupt_helper.c',
> > +  'openrisc-semi.c',
> >     'sys_helper.c',
> >     'translate.c',
> >   ))
> 
> You want to add the new file for system mode only.
> Or, now that I think of it, conditional on CONFIG_SEMIHOSTING itself.

That's right, I'll update it.

> > +static void or1k_semi_return_u32(CPUOpenRISCState *env, uint32_t ret)
> > +{
> > +    cpu_set_gpr(env, 11, ret);
> > +}
> 
> Let's drop this until you actually use it.  This appears to be attempting to
> mirror other, more complete semihosting, but missing the third "error"
> argument

Sure, I did mention I kept these here for future (real) semihosting support.
But I don't think that will happen.  So I can remove.

> > +void do_or1k_semihosting(CPUOpenRISCState *env, uint32_t k)
> > +{
> > +    uint32_t result;
> > +
> > +    switch (k) {
> > +    case HOSTED_EXIT:
> > +        gdb_exit(cpu_get_gpr(env, 3));
> > +        exit(cpu_get_gpr(env, 3));
> > +    case HOSTED_RESET:
> > +#ifndef CONFIG_USER_ONLY
> > +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> > +        return;
> > +#endif
> 
> Do you in fact want to exit to the main loop after asking for reset?
> That's the only way that "no return value" makes sense to me...

OK. I'll look at this more.
 
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "or1k-semihosting: unsupported "
> > +                      "semihosting syscall %d\n", k);
> 
> %u.

OK.

> >   static bool trans_l_nop(DisasContext *dc, arg_l_nop *a)
> >   {
> > +    if (semihosting_enabled() &&
> > +        a->k != 0) {
> > +        gen_helper_nop(cpu_env, tcg_constant_i32(a->k));
> > +    }
> 
> Perhaps cleaner to move the semihosting dispatch switch here, instead of
> leaving it to the runtime?  The reason we have a runtime switch for other
> guests is that the semihosting syscall number is in a register.  This would
> then be
> 
>     if (semihosting_enabled()) {
>         switch (a->k) {
>         case 0:
>             break; /* normal nop */
>         case HOSTED_EXIT:
>             gen_helper_semihost_exit(cpu_R(dc, 3));
>             break;
>         case HOSTED_RESET:
>             gen_helper_semihost_reset();
>             tcg_gen_movi_tl(cpu_pc, dc->base.pc_next + 4);
> 
>             dc->base.is_jmp = DISAS_EXIT;
>             break;
>         ...
>         }
>     }

Yeah, that makes sense. I had written it in a way that would allow expanding for
real semi-hosting.  But I don't think we will do that with OpenRISC, so this is
good enough.

I am not sure if you saw the cover letter. I sent this RFC series to help
illustrate two options for providing OpenRISC targets that support poweroff and
reset.

One option being using these NOP's, the second is to create a virt target with
reset/poweroff hardware.

I am kind of leaning towards dropping the semi-hosting patches and only moving
forward with the virt patches.  The reason being that 1. we would not need to
expand the architecture spec to support the qemu virt platform, and we would
need to document the NOP's formally, and 2. OpenRISC doesn't really support the
full "semihosting" facilities for file open/close/write etc.

Any thoughts?  I guess this "semihosting" patch is pretty trivial.  But, maybe
it causes more confusion compared to just going with the virt route.  Also, if
we have virt I can't imagine anyone using the semihosting much.

-Stafford
