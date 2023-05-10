Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9017BC77B7C;
	Wed, 10 May 2023 15:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbjEJPch (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Wed, 10 May 2023 11:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237531AbjEJPcg (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Wed, 10 May 2023 11:32:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F88530CD
        for <linux-openrisc@vger.kernel.org>; Wed, 10 May 2023 08:32:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f49bf0223cso7998605e9.1
        for <linux-openrisc@vger.kernel.org>; Wed, 10 May 2023 08:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683732753; x=1686324753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDPTs09PsI8EmAO4/Xss2kSkklk22rd5jb1ypAYGrnQ=;
        b=epEmcP0cKwkup7fXmkXlQGfN8nuYXmsLefruZRj/qA31GHjhg6koFg8oyPqenYf/3X
         Y4mTQO7hN0yWvtI/BAqo9vYStkQoY3K+ZB8CctsUEhCIvxk5NESfFftUEtix5OjGVLs0
         D185PCFgk1ldlAHXvLRj22R6cwssUMhKVmoIhXeQcVW4r0ONOqSyLWWANw8tj2sfmAve
         NynxWONKABBTR5vS3owwivmeWkyLZzNVE8/sAiwPwU97c+Kf/brrza/4HBIfto1l/S2C
         q2z1sAAC0c3SAHTWIyfTDsSMSTwGylW06tDL5UYraQV1LKGVBPzrd7Kc3yG1amVQSU+M
         v9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683732753; x=1686324753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDPTs09PsI8EmAO4/Xss2kSkklk22rd5jb1ypAYGrnQ=;
        b=Tl5ShOJhA1n85pckQGzH0D6V9ExEj+LK/XoYvuhl5yiHD58d9ltQet1PWXjDqYlIPA
         WX6sNUvkHsphfD+T+bzdZfW9FUoCsTZERjHmVs0OARZw/ZyqgyqBm0IDzJPOBYbhvSmC
         mmwVeEY3yRpZAL30YsxxwzpKEgm8Z8N0Qy3UyyTe8PZLO8adB82Z443UjLJywN8/pB7+
         /TqGNCD8FoojcwG9Tb/bpiFOXKrAbPNwqzqBDSVTMeSbb3DwiViUVMXpKi5KZ1uvTGAg
         lf2GU51WZnF8j6ZMope3EA+GAmPqvpHCvUufWSc5UmWAB/BU7fSJvrf0yv6YEtuvfkdq
         8qEw==
X-Gm-Message-State: AC+VfDwcKnz/6s8kO53LCC+dPHlikmKGYt6wWwfKB35lrw0E4FFoyHUF
        EW1WgB2czh7v5Ewsp2AgUfWofjOUb20=
X-Google-Smtp-Source: ACHHUZ4Xam3SROJR5VZbQtn2jANf9Bj4Px+G++RnPNS1xE4CRvH+0C4d12wTrmCd53ZDrQ8k5WTUuQ==
X-Received: by 2002:adf:f790:0:b0:2f2:7a0e:5cc9 with SMTP id q16-20020adff790000000b002f27a0e5cc9mr11228526wrp.19.1683732753620;
        Wed, 10 May 2023 08:32:33 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d4b8f000000b003064600cff9sm17660531wrt.38.2023.05.10.08.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 08:32:33 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     QEMU Development <qemu-devel@nongnu.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 1/3] target/openrisc: Allow fpcsr access in user mode
Date:   Wed, 10 May 2023 16:32:26 +0100
Message-Id: <20230510153228.264954-2-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230510153228.264954-1-shorne@gmail.com>
References: <20230510153228.264954-1-shorne@gmail.com>
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
---
Since v1:
 - Update commit message to remove text about no-existant logic change.

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

