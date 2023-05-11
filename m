Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7335C7EE23;
	Thu, 11 May 2023 15:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbjEKPKJ (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Thu, 11 May 2023 11:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238169AbjEKPKI (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Thu, 11 May 2023 11:10:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25D72105
        for <linux-openrisc@vger.kernel.org>; Thu, 11 May 2023 08:10:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30771c68a9eso8011465f8f.2
        for <linux-openrisc@vger.kernel.org>; Thu, 11 May 2023 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683817805; x=1686409805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OT6i+7tCi6iezpIwGJmcpXv13tSv9fa3ejqVOJNCoI=;
        b=HzWSmtiB32/w4dfIwsO/+Bx3f6HnM40kTgM8WWVueVgTMq36OncOrlQUJoE4eCLXOi
         0M8rM8eMNvflDT8Qcyr/1TXWsgSMZfCmHguXckv3f6lhSXOzKgBDszEAIzQv6d701kiE
         lvy13N77pGY1sPlqn1p8wxK+OXTciGVfylj+9W0YS1p801feVTRG3QFhmmkd2o07hT/q
         dEgAz/dBdcohMIjivypIEGtd5rtHO/fLag2wOnGmMclHUnMES+3Xj8b/TNjtksdK21fd
         pkoiuhyZrjTQ25nYC9WW3KACCeI7o+Zk2e5PnJ8VIQvKJScEvCg+t3dQH0g1ZnzA6diC
         GGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683817805; x=1686409805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OT6i+7tCi6iezpIwGJmcpXv13tSv9fa3ejqVOJNCoI=;
        b=R9OGAiTfg3ANAolDmCLGmUZRFeqs/X0wFuLQL4a8iAIazytzICD1JUzOhVTJIUwH+W
         OtTyeHHzXu2qeT8GdkI62KwHgrciKKkxftO9oCn8SyGDtyXHVCRTI+4r3aW2eG3IKaFP
         mMg5Gq81nzupW2rxxcMVDEyDETHoE5u+fZUdpEfC/MsZZ+UPiNSAozf56d8x4oV6HQpb
         kYBCmLbhPj/Gq6W9o4L5v3OkblxwOH5qeBF8giKibD23wrvfPzT5bjagpYMdyg1M4k0m
         jxQhTkxcjAERXrBSbZlrT4LJQtngvMv7+s/tuJpR4hz3hrc0mhE3xv2VCBUyTpYYntZJ
         x3Hw==
X-Gm-Message-State: AC+VfDwoflnYl1hex+8AsnHsiGlY2G1147Mb2zz+QqbzsmUs3ZUAE7Sk
        d0bOmn3q4aZJJGm2zgvRBnQ=
X-Google-Smtp-Source: ACHHUZ4FHHmEhjQbG9pnuHKknc55z27ILls1GCUv0rX/obemng0C1c4+KLXvaGAHHKzJU8xud2NQoA==
X-Received: by 2002:adf:fd83:0:b0:305:f2d5:2a12 with SMTP id d3-20020adffd83000000b00305f2d52a12mr15175071wrr.21.1683817805023;
        Thu, 11 May 2023 08:10:05 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d65cd000000b0030789698eebsm17088387wrw.89.2023.05.11.08.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 08:10:04 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     QEMU Development <qemu-devel@nongnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 1/3] target/openrisc: Allow fpcsr access in user mode
Date:   Thu, 11 May 2023 16:09:57 +0100
Message-Id: <20230511151000.381911-2-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230511151000.381911-1-shorne@gmail.com>
References: <20230511151000.381911-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

As per OpenRISC spec 1.4 FPCSR can be read and written in user mode.

Update mtspr and mfspr helpers to support this by moving the is_user
check into the helper.

Link: https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.4-rev0.pdf
Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---

Since v2:
 - Add reviewed-by
 - In helper_mfspr bring cpu out of ifdef to avoid replicatig the definition.
   Originally I left it in the ifdef to avoid having to mix having pointers and
   the data array defined on the stack.  But that's overthinking.
Since v1:
 - Update commit message to remove text about no-existant logic change.

 target/openrisc/sys_helper.c | 45 ++++++++++++++++------
 target/openrisc/translate.c  | 72 ++++++++++++++++--------------------
 2 files changed, 66 insertions(+), 51 deletions(-)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index ec145960e3..ccdee3b8be 100644
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
@@ -187,27 +207,33 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
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
                            target_ulong spr)
 {
+    OpenRISCCPU *cpu = env_archcpu(env);
 #ifndef CONFIG_USER_ONLY
     uint64_t data[TARGET_INSN_START_WORDS];
     MachineState *ms = MACHINE(qdev_get_machine());
-    OpenRISCCPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
     int idx;
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
 
@@ -324,11 +350,8 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
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

