Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB66EC7EE22;
	Tue,  2 May 2023 18:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjEBS5v (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Tue, 2 May 2023 14:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjEBS5u (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Tue, 2 May 2023 14:57:50 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E9810C6
        for <linux-openrisc@vger.kernel.org>; Tue,  2 May 2023 11:57:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f19afc4f60so26309125e9.1
        for <linux-openrisc@vger.kernel.org>; Tue, 02 May 2023 11:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683053867; x=1685645867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHLwgqaFfJbWimQbiuWlGGZI0kG5aEUzX4kKjRiyuO8=;
        b=EZuAhLnyBylVYN9a+G9pgHu3j6G1qLEzbPIVQ4XDlRvcHVlevmUnfLm43c96lXed0J
         TvykgyRTP+mdVlKDnWahK9QzhXeCR6U79D3NlKU97ZmT9N3qw04dR1aqnAxr0SanusPG
         OtIbuJBedr88qQ54bHx+oqA0o7Oq9k+mnVXSfAS/cz407gY4zj04ybS2p4ZxQR+s+sLl
         cCU5jZGMeIFgZpFp4muGILY+OPGEa7rLeB3spj67tx7O2Qsa13+KAv9CzjKzebiDewEP
         +9tBatvbSeJI+T+24/54trYl6Y4rHR2n2frK2jJgNtKpTvUWKJwK2rkgzyf17dyXAB74
         uQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683053867; x=1685645867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHLwgqaFfJbWimQbiuWlGGZI0kG5aEUzX4kKjRiyuO8=;
        b=QNYjr6maOPIa7vcJlGTxbvvII8MxBBHLTW40srC4On/4ZkYufiJ8le3jo1+oq1WeLQ
         Tj4JtyMFz7KpIruVZOCTtSuAiBQkbwxLC7akmYtcNvyQMPgMBNjbwbHLt56a1R9RNonZ
         TUcbhQE6vXE1r+Wl435IYVYpdNEIWHVWToXdOoS6XwSu6/ua6ew0DbB94HEkw+mTELTU
         UO+I32OkcVG4Tm/k0YQqHaTEFYnas9cYh9WHSUJoUxVo4bPJ9YPdiygm4h6RJM/o+p7O
         AZXemtCZ5vb+7CtirMwYdBscNWn6SU2AK5l3hjZa8gTC/7lblig+mAZu9KihID5vbf6M
         Olrg==
X-Gm-Message-State: AC+VfDxYx3nF1RHfcyNHDU5w/PF4p3UXdPpl/PpLxMT1Mugfc+v6B1rg
        gHIxgWEBm07+lGhVRUORmCw=
X-Google-Smtp-Source: ACHHUZ7yHELrZtyyeqW/psiKxwMcyNkhRzA/R3thtp5kcKtGWbHR5umWaxTN4sOjFnLuISd2yX6ILg==
X-Received: by 2002:a05:600c:21cb:b0:3f1:6f37:c3cd with SMTP id x11-20020a05600c21cb00b003f16f37c3cdmr12582564wmj.12.1683053867201;
        Tue, 02 May 2023 11:57:47 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id j8-20020adff008000000b002f6176cc6desm31715295wro.110.2023.05.02.11.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 11:57:46 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     QEMU Development <qemu-devel@nongnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH 1/3] target/openrisc: Allow fpcsr access in user mode
Date:   Tue,  2 May 2023 19:57:29 +0100
Message-Id: <20230502185731.3543420-2-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230502185731.3543420-1-shorne@gmail.com>
References: <20230502185731.3543420-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

As per OpenRISC spec 1.4 FPCSR can be read and written in user mode.

Update mtspr and mfspr helpers to support this by moving the is_user
check into the helper.

There is a logic change here to no longer throw an illegal instruction
exception when executing mtspr/mfspr in user mode.  The illegal
instruction exception is not part of the spec, so this should be OK.

Link: https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.4-rev0.pdf
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/sys_helper.c | 45 +++++++++++++++++-----
 target/openrisc/translate.c  | 72 ++++++++++++++++--------------------
 2 files changed, 67 insertions(+), 50 deletions(-)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index ec145960e3..8a0259c710 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -29,17 +29,37 @@
 
 #define TO_SPR(group, number) (((group) << 11) + (number))
 
+static inline bool is_user(CPUOpenRISCState *env)
+{
+#ifdef CONFIG_USER_ONLY
+    return true;
+#else
+    return (env->sr & SR_SM) == 0;
+#endif
+}
+
 void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
 {
-#ifndef CONFIG_USER_ONLY
     OpenRISCCPU *cpu = env_archcpu(env);
+#ifndef CONFIG_USER_ONLY
     CPUState *cs = env_cpu(env);
     target_ulong mr;
     int idx;
 #endif
 
+    /* Handle user accessible SPRs first.  */
     switch (spr) {
+    case TO_SPR(0, 20): /* FPCSR */
+        cpu_set_fpcsr(env, rb);
+        return;
+    }
+
+    if (is_user(env)) {
+        raise_exception(cpu, EXCP_ILLEGAL);
+    }
+
 #ifndef CONFIG_USER_ONLY
+    switch (spr) {
     case TO_SPR(0, 11): /* EVBAR */
         env->evbar = rb;
         break;
@@ -187,12 +207,8 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
         cpu_openrisc_timer_update(cpu);
         qemu_mutex_unlock_iothread();
         break;
-#endif
-
-    case TO_SPR(0, 20): /* FPCSR */
-        cpu_set_fpcsr(env, rb);
-        break;
     }
+#endif
 }
 
 target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
@@ -204,10 +220,22 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
     OpenRISCCPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
     int idx;
+#else
+    OpenRISCCPU *cpu = env_archcpu(env);
 #endif
 
+    /* Handle user accessible SPRs first.  */
     switch (spr) {
+    case TO_SPR(0, 20): /* FPCSR */
+        return env->fpcsr;
+    }
+
+    if (is_user(env)) {
+        raise_exception(cpu, EXCP_ILLEGAL);
+    }
+
 #ifndef CONFIG_USER_ONLY
+    switch (spr) {
     case TO_SPR(0, 0): /* VR */
         return env->vr;
 
@@ -324,11 +352,8 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
         cpu_openrisc_count_update(cpu);
         qemu_mutex_unlock_iothread();
         return cpu_openrisc_count_get(cpu);
-#endif
-
-    case TO_SPR(0, 20): /* FPCSR */
-        return env->fpcsr;
     }
+#endif
 
     /* for rd is passed in, if rd unchanged, just keep it back.  */
     return rd;
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 76e53c78d4..43ba0cc1ad 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -819,45 +819,12 @@ static bool trans_l_xori(DisasContext *dc, arg_rri *a)
 
 static bool trans_l_mfspr(DisasContext *dc, arg_l_mfspr *a)
 {
-    check_r0_write(dc, a->d);
-
-    if (is_user(dc)) {
-        gen_illegal_exception(dc);
-    } else {
-        TCGv spr = tcg_temp_new();
-
-        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-            if (dc->delayed_branch) {
-                tcg_gen_mov_tl(cpu_pc, jmp_pc);
-                tcg_gen_discard_tl(jmp_pc);
-            } else {
-                tcg_gen_movi_tl(cpu_pc, dc->base.pc_next + 4);
-            }
-            dc->base.is_jmp = DISAS_EXIT;
-        }
+    TCGv spr = tcg_temp_new();
 
-        tcg_gen_ori_tl(spr, cpu_R(dc, a->a), a->k);
-        gen_helper_mfspr(cpu_R(dc, a->d), cpu_env, cpu_R(dc, a->d), spr);
-    }
-    return true;
-}
-
-static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a)
-{
-    if (is_user(dc)) {
-        gen_illegal_exception(dc);
-    } else {
-        TCGv spr;
+    check_r0_write(dc, a->d);
 
-        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-        }
-        /* For SR, we will need to exit the TB to recognize the new
-         * exception state.  For NPC, in theory this counts as a branch
-         * (although the SPR only exists for use by an ICE).  Save all
-         * of the cpu state first, allowing it to be overwritten.
-         */
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
         if (dc->delayed_branch) {
             tcg_gen_mov_tl(cpu_pc, jmp_pc);
             tcg_gen_discard_tl(jmp_pc);
@@ -865,11 +832,36 @@ static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a)
             tcg_gen_movi_tl(cpu_pc, dc->base.pc_next + 4);
         }
         dc->base.is_jmp = DISAS_EXIT;
+    }
+
+    tcg_gen_ori_tl(spr, cpu_R(dc, a->a), a->k);
+    gen_helper_mfspr(cpu_R(dc, a->d), cpu_env, cpu_R(dc, a->d), spr);
+    return true;
+}
+
+static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a)
+{
+    TCGv spr = tcg_temp_new();
 
-        spr = tcg_temp_new();
-        tcg_gen_ori_tl(spr, cpu_R(dc, a->a), a->k);
-        gen_helper_mtspr(cpu_env, spr, cpu_R(dc, a->b));
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
     }
+    /*
+     * For SR, we will need to exit the TB to recognize the new
+     * exception state.  For NPC, in theory this counts as a branch
+     * (although the SPR only exists for use by an ICE).  Save all
+     * of the cpu state first, allowing it to be overwritten.
+     */
+    if (dc->delayed_branch) {
+        tcg_gen_mov_tl(cpu_pc, jmp_pc);
+        tcg_gen_discard_tl(jmp_pc);
+    } else {
+        tcg_gen_movi_tl(cpu_pc, dc->base.pc_next + 4);
+    }
+    dc->base.is_jmp = DISAS_EXIT;
+
+    tcg_gen_ori_tl(spr, cpu_R(dc, a->a), a->k);
+    gen_helper_mtspr(cpu_env, spr, cpu_R(dc, a->b));
     return true;
 }
 
-- 
2.39.1

