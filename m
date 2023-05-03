Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46F5C77B75;
	Wed,  3 May 2023 06:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjECG3R (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Wed, 3 May 2023 02:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjECG3R (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Wed, 3 May 2023 02:29:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A8A1FCF
        for <linux-openrisc@vger.kernel.org>; Tue,  2 May 2023 23:29:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f20215fa70so30798515e9.0
        for <linux-openrisc@vger.kernel.org>; Tue, 02 May 2023 23:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683095351; x=1685687351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnoIXpQi3eMt6bM9y9/uf+B8Q9us1gmaMG3KuNIjemw=;
        b=eUS/o5BVWweijI0W2LvIiJ3KG5emfzMcXrvgMH37FmWqWQo0Pjf7CVjzl1whWlZi9S
         ADco9sdHXflEF29AKCWz3l/PZsli1Duj9stetx6kgu6dJs0xjKK1OiCP6qM2hg2+m2fw
         Dmmj/juY3yp3KMEXBbxP/BybLi2ydip/tLAMejfbyNoazRpFmx82BLKGOZWpw7t1+DYa
         49bhox1xr89FPJLJ+us7ZJ78Co9iT9TOgMKERpCLHtUb47c0Ycy9SSWZ1bW+t992hpXM
         Q15LfxahZpkr7tLvcEjLmiVAN8XrAui3qhv3Ra350Sa0J+h0IMLs9bNIUc6WSm6dIobC
         GpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683095351; x=1685687351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnoIXpQi3eMt6bM9y9/uf+B8Q9us1gmaMG3KuNIjemw=;
        b=gTpXw2xqnZslsanLTfunbI1oD7w0H6Q2W5TuX3iMyrZ5nfyW+1gfUH1XEgTp7rZGZO
         3ygXjU4ows0/rcHMknT7Ljqa7eAPpowFq4JoP9r5vbBPT5ol0nMuOHyg+BieJo3v8N0A
         /bRa/aniwgHY/o21MMH/QLQ8xcww65ME1MOseiW6Vdz1EZ2bnnDjphT/9NaTBLSvpw75
         zkeDPjKCVYKcR7PKA4UJOfGHT8YiISvfmBwXS18+RLzCzjywu4KEMi++AltdQaQ0vhkZ
         OWCp6hiCWGK/VqOG+PqA/KtV0jhvRVtVIUzcqL5z5kTx87mlmIjoM3NI5FBg+bRcGIf9
         JUWg==
X-Gm-Message-State: AC+VfDyJMInBepGJcQJxQvdurnlddsm8OwYSiYPhbouRwQenH4KD2CTt
        i94hjPYyfm0Lsk91HkI3BBTYhD4DKKY=
X-Google-Smtp-Source: ACHHUZ4uVK0Y6NL+3GBmnEQUwOl48KHnTcXdC/UdhRS8j696XMrZepV64oqsrISe0EQa4yoJ8ddWkQ==
X-Received: by 2002:a1c:740f:0:b0:3f2:5641:3d4 with SMTP id p15-20020a1c740f000000b003f2564103d4mr13028027wmc.33.1683095350298;
        Tue, 02 May 2023 23:29:10 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id f23-20020a7bcd17000000b003ee443bf0c7sm827355wmj.16.2023.05.02.23.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 23:29:09 -0700 (PDT)
Date:   Wed, 3 May 2023 07:29:04 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     QEMU Development <qemu-devel@nongnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH 1/3] target/openrisc: Allow fpcsr access in user mode
Message-ID: <ZFH/ME9af8cQOeD6@antec>
References: <20230502185731.3543420-1-shorne@gmail.com>
 <20230502185731.3543420-2-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502185731.3543420-2-shorne@gmail.com>
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

On Tue, May 02, 2023 at 07:57:29PM +0100, Stafford Horne wrote:
> As per OpenRISC spec 1.4 FPCSR can be read and written in user mode.
> 
> Update mtspr and mfspr helpers to support this by moving the is_user
> check into the helper.
> 
> There is a logic change here to no longer throw an illegal instruction
> exception when executing mtspr/mfspr in user mode.  The illegal
> instruction exception is not part of the spec, so this should be OK.

This is wrong, I considered doing it but left the exception in (moved to the
helper).  I will remove this bit of the commit messages in the next version.
But it is something we could consider doing.

Conversely, the architecture pec should be more clear as to what happens when
mfspr/mtspr privileges are violated.

-Stafford

> Link: https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.4-rev0.pdf
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  target/openrisc/sys_helper.c | 45 +++++++++++++++++-----
>  target/openrisc/translate.c  | 72 ++++++++++++++++--------------------
>  2 files changed, 67 insertions(+), 50 deletions(-)
> 
> diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
> index ec145960e3..8a0259c710 100644
> --- a/target/openrisc/sys_helper.c
> +++ b/target/openrisc/sys_helper.c
> @@ -29,17 +29,37 @@
>  
>  #define TO_SPR(group, number) (((group) << 11) + (number))
>  
> +static inline bool is_user(CPUOpenRISCState *env)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    return true;
> +#else
> +    return (env->sr & SR_SM) == 0;
> +#endif
> +}
> +
>  void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
>  {
> -#ifndef CONFIG_USER_ONLY
>      OpenRISCCPU *cpu = env_archcpu(env);
> +#ifndef CONFIG_USER_ONLY
>      CPUState *cs = env_cpu(env);
>      target_ulong mr;
>      int idx;
>  #endif
>  
> +    /* Handle user accessible SPRs first.  */
>      switch (spr) {
> +    case TO_SPR(0, 20): /* FPCSR */
> +        cpu_set_fpcsr(env, rb);
> +        return;
> +    }
> +
> +    if (is_user(env)) {
> +        raise_exception(cpu, EXCP_ILLEGAL);
> +    }
> +
>  #ifndef CONFIG_USER_ONLY
> +    switch (spr) {
>      case TO_SPR(0, 11): /* EVBAR */
>          env->evbar = rb;
>          break;
> @@ -187,12 +207,8 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
>          cpu_openrisc_timer_update(cpu);
>          qemu_mutex_unlock_iothread();
>          break;
> -#endif
> -
> -    case TO_SPR(0, 20): /* FPCSR */
> -        cpu_set_fpcsr(env, rb);
> -        break;
>      }
> +#endif
>  }
>  
>  target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
> @@ -204,10 +220,22 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
>      OpenRISCCPU *cpu = env_archcpu(env);
>      CPUState *cs = env_cpu(env);
>      int idx;
> +#else
> +    OpenRISCCPU *cpu = env_archcpu(env);
>  #endif
>  
> +    /* Handle user accessible SPRs first.  */
>      switch (spr) {
> +    case TO_SPR(0, 20): /* FPCSR */
> +        return env->fpcsr;
> +    }
> +
> +    if (is_user(env)) {
> +        raise_exception(cpu, EXCP_ILLEGAL);
> +    }
> +
>  #ifndef CONFIG_USER_ONLY
> +    switch (spr) {
>      case TO_SPR(0, 0): /* VR */
>          return env->vr;
>  
> @@ -324,11 +352,8 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
>          cpu_openrisc_count_update(cpu);
>          qemu_mutex_unlock_iothread();
>          return cpu_openrisc_count_get(cpu);
> -#endif
> -
> -    case TO_SPR(0, 20): /* FPCSR */
> -        return env->fpcsr;
>      }
> +#endif
>  
>      /* for rd is passed in, if rd unchanged, just keep it back.  */
>      return rd;
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
> index 76e53c78d4..43ba0cc1ad 100644
> --- a/target/openrisc/translate.c
> +++ b/target/openrisc/translate.c
> @@ -819,45 +819,12 @@ static bool trans_l_xori(DisasContext *dc, arg_rri *a)
>  
>  static bool trans_l_mfspr(DisasContext *dc, arg_l_mfspr *a)
>  {
> -    check_r0_write(dc, a->d);
> -
> -    if (is_user(dc)) {
> -        gen_illegal_exception(dc);
> -    } else {
> -        TCGv spr = tcg_temp_new();
> -
> -        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
> -            gen_io_start();
> -            if (dc->delayed_branch) {
> -                tcg_gen_mov_tl(cpu_pc, jmp_pc);
> -                tcg_gen_discard_tl(jmp_pc);
> -            } else {
> -                tcg_gen_movi_tl(cpu_pc, dc->base.pc_next + 4);
> -            }
> -            dc->base.is_jmp = DISAS_EXIT;
> -        }
> +    TCGv spr = tcg_temp_new();
>  
> -        tcg_gen_ori_tl(spr, cpu_R(dc, a->a), a->k);
> -        gen_helper_mfspr(cpu_R(dc, a->d), cpu_env, cpu_R(dc, a->d), spr);
> -    }
> -    return true;
> -}
> -
> -static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a)
> -{
> -    if (is_user(dc)) {
> -        gen_illegal_exception(dc);
> -    } else {
> -        TCGv spr;
> +    check_r0_write(dc, a->d);
>  
> -        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
> -            gen_io_start();
> -        }
> -        /* For SR, we will need to exit the TB to recognize the new
> -         * exception state.  For NPC, in theory this counts as a branch
> -         * (although the SPR only exists for use by an ICE).  Save all
> -         * of the cpu state first, allowing it to be overwritten.
> -         */
> +    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
> +        gen_io_start();
>          if (dc->delayed_branch) {
>              tcg_gen_mov_tl(cpu_pc, jmp_pc);
>              tcg_gen_discard_tl(jmp_pc);
> @@ -865,11 +832,36 @@ static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a)
>              tcg_gen_movi_tl(cpu_pc, dc->base.pc_next + 4);
>          }
>          dc->base.is_jmp = DISAS_EXIT;
> +    }
> +
> +    tcg_gen_ori_tl(spr, cpu_R(dc, a->a), a->k);
> +    gen_helper_mfspr(cpu_R(dc, a->d), cpu_env, cpu_R(dc, a->d), spr);
> +    return true;
> +}
> +
> +static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a)
> +{
> +    TCGv spr = tcg_temp_new();
>  
> -        spr = tcg_temp_new();
> -        tcg_gen_ori_tl(spr, cpu_R(dc, a->a), a->k);
> -        gen_helper_mtspr(cpu_env, spr, cpu_R(dc, a->b));
> +    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
> +        gen_io_start();
>      }
> +    /*
> +     * For SR, we will need to exit the TB to recognize the new
> +     * exception state.  For NPC, in theory this counts as a branch
> +     * (although the SPR only exists for use by an ICE).  Save all
> +     * of the cpu state first, allowing it to be overwritten.
> +     */
> +    if (dc->delayed_branch) {
> +        tcg_gen_mov_tl(cpu_pc, jmp_pc);
> +        tcg_gen_discard_tl(jmp_pc);
> +    } else {
> +        tcg_gen_movi_tl(cpu_pc, dc->base.pc_next + 4);
> +    }
> +    dc->base.is_jmp = DISAS_EXIT;
> +
> +    tcg_gen_ori_tl(spr, cpu_R(dc, a->a), a->k);
> +    gen_helper_mtspr(cpu_env, spr, cpu_R(dc, a->b));
>      return true;
>  }
>  
> -- 
> 2.39.1
> 
