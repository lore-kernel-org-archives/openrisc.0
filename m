Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169E02472AF
	for <linux-openrisc@vger.kernel.org>; Thu, 19 Jun 2025 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338881; cv=none; b=SfUlQFr1CkrMMz7RekEMtTlDj6JxpLameGkutIfssjfX1oVi3wzhxIXa3SX1LxI1J1LD2LtBkxID+if4hatxfMDbu7qTa9aclAP47R+LmdsVPjREUq9kvTYHRvwLtXI5qV0hVB/zakCebtXx12N72PlE+JqTXx9AhLdGMw9yDlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338881; c=relaxed/simple;
	bh=ROUE7T1PcOC3cgqR780jqGwdnbxBqU/WzEettQNy6AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwYHTW2eCLceRNTJdlOhQru8iLDhNjr6wS62qC6RBOIJNfA8GuWTjDKpbUkKK/U/CSBnhyDlUTl0/Av6dkdU6kEsxD0fOKcifgpcbpcf/GjYNNtC8DP8scXRoLZC1MUF0Z9DMwNilEO0MvmooAxeHDRkMKbIX3+Jyqo33whnv6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5eLegVp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5eLegVp"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-441ab63a415so9476475e9.3
        for <linux-openrisc@vger.kernel.org>; Thu, 19 Jun 2025 06:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750338878; x=1750943678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7HnNRhd5UThXTVTQG+g0GdO+AYmOTfR7jUl39sUd9A=;
        b=c5eLegVpbtTHS6vqYW9hMub7GNxwu5HbzNKZshH7ITVKCKJeMmifPOy16WNnXO1KTk
         QlEGMCKB0/Sbzu7y1EO62PVwNUzMN51NZGXM8ORSK1PUDqBhG1lPsn/afgBWWHlimp7F
         o1gSIRNqxjYZZEXiVPSeGzgBulPy5M8TyQbqgE5Nah7zM7NrKJxXOZ5GmA2Ng+YEsEsm
         hd18AvxI3EAvzixMx1QOPYxCYF2kweKL/Mrs1LzAjgoch1Q+IXsIa9PrAVpWixnnFtyK
         DlDXSTbbWyARoTp7zLpLSTtKzcN4vNH7gBqFUHRTimovzHcN/I02OJb4Kr9GfYSpKiwf
         7j4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750338878; x=1750943678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7HnNRhd5UThXTVTQG+g0GdO+AYmOTfR7jUl39sUd9A=;
        b=OSsAgrwGKKdr+Unbo/nt/0G0uoG2PB1wJ5soRpxLFWZZYcWT0e/iq/32WP7m0NWhN/
         M8KSzmGk295cJ+BX59U3k5aQboxXxjyZ1AsXZHVCAtNQh09IOwkkuWckoX8J4J3eQgJX
         aybrwCK+GhFHSr71MHH+cpwr3Pvu/WF9OGwK+EAUDrM3T3463WlGefkarMT0RlxTlJlj
         SXt3FKnZ5D/TtmD2y7TJxKUyB9UYIRaGdJNZEuFNfcKxcvY90wa0JIYkL1b7i+yRX/DC
         AnU3wlURCD+sc7rE1wIqRpwH5qw/YCBAD9igARK9BdLEUpypx6hXy/Eo4rn5mG3cPPqK
         FZsg==
X-Forwarded-Encrypted: i=1; AJvYcCWTXBhyljViz4LcXZ2OXExosepyNuSgiva7JbjR0vGqw6oHDP9p4GC/VCGCD+zxhTir3auoH7+9xCCIQzG0/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNRBhDdmlVOYe5ZnBN7syJ/TnJvX/KFc2/OCnocRlje+okTkPh
	N/HyEdsaTz+BkVKlzHMvyMXswnVZGWk3kZpS7E3oaRPnSl+HVuoZQBZS
X-Gm-Gg: ASbGncvoatNCH+oBVIDeVhDEQCSH5LEZyUciqNye9D0/3Y78lOwzIOAr+sd846/vAnW
	YR5k+Q4MrqZDhonySFsTeyLkkkYH/OsrMkaP4sy9vn9uC3nO3Xqb1XWbPvqtjTb2EfW3B76NhCk
	fnOVFZ3hvjMQPOC9affObMcB+jYMKmHizKVkwPSCDgr1tVyaSU3bkTgjnaGlkXhxDwZZpFUYTYl
	YJvfJ9tZ3wZG2E926HhJYZY1XGz4721un2W/ve2t8qx/AYuOIhDxI+oQZ3Yrxehy6aQUHpTXQ9n
	0ScAHo/ss0HakxbJhrtmdz/Al6g8V4CY3nY0vGklEvkhj3DGqctWv0WAtoGKAV7xVeDbfnCfwk9
	zZ1L9O0VjUvIemWEnz7dHX+w04A==
X-Google-Smtp-Source: AGHT+IH0TDRnVnJOghuTGOhKMRJ1JDvAR3jBP7KUKkRRTOf38F1xfK4sOkmGwGufaAQTk4+zm16GoA==
X-Received: by 2002:a05:600c:3513:b0:43c:ec0a:ddfd with SMTP id 5b1f17b1804b1-4533ca464a9mr214803335e9.6.1750338878085;
        Thu, 19 Jun 2025 06:14:38 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b087b4sm19940817f8f.51.2025.06.19.06.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 06:14:36 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GCC patches <gcc-patches@gcc.gnu.org>
Cc: Dimitar Dimitrov <dimitar@dinux.eu>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH 2/2] or1k: Improve If-Conversion by delaying cbranch splits
Date: Thu, 19 Jun 2025 14:14:26 +0100
Message-ID: <20250619131426.1292212-3-shorne@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131426.1292212-1-shorne@gmail.com>
References: <20250619131426.1292212-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When working on PR120587 I found that the ce1 pass was not able to
properly optimize branches on OpenRISC.  This is because of the early
splitting of "compare" and "branch" instructions during the expand pass.

Convert the cbranch* instructions from define_expand to
define_insn_and_split.  This dalays the instruction split until after
the ce1 pass is done giving ce1 the best opportunity to perform the
optimizations on the original form of cbranch<mode>4 instructions.

gcc/ChangeLog:

	* config/or1k/or1k.cc (or1k_noce_conversion_profitable_p): New
	function.
	(or1k_is_cmov_insn): New function.
	(TARGET_NOCE_CONVERSION_PROFITABLE_P): Define macro.
	* config/or1k/or1k.md (cbranchsi4): Convert to insn_and_split.
	(cbranch<mode>4): Convert to insn_and_split.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 gcc/config/or1k/or1k.cc | 54 +++++++++++++++++++++++++++++++++++++++++
 gcc/config/or1k/or1k.md | 32 ++++++++++++++++++++++--
 2 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/gcc/config/or1k/or1k.cc b/gcc/config/or1k/or1k.cc
index f1c92c6bf6c..36c16a51d44 100644
--- a/gcc/config/or1k/or1k.cc
+++ b/gcc/config/or1k/or1k.cc
@@ -1654,6 +1654,60 @@ or1k_rtx_costs (rtx x, machine_mode mode, int outer_code, int /* opno */,
 #undef TARGET_RTX_COSTS
 #define TARGET_RTX_COSTS or1k_rtx_costs
 
+static bool
+or1k_is_cmov_insn (rtx_insn *seq)
+{
+  rtx_insn *curr_insn = seq;
+  rtx set = NULL_RTX;
+
+  /* The pattern may start with a simple set with register operands.  Skip
+     through any of those.  */
+  while (curr_insn)
+    {
+      set = single_set (curr_insn);
+      if (!set
+	  || !REG_P (SET_DEST (set)))
+	return false;
+
+      /* If it's not a simple reg or immediate break.  */
+      if (REG_P (SET_SRC (set)) || CONST_INT_P (SET_SRC (set)))
+        curr_insn = NEXT_INSN (curr_insn);
+      else
+	break;
+    }
+
+  /* The next instruction should be a compare.  OpenRISC has many operators used
+     for comparison so skip and confirm the next is IF_THEN_ELSE.  */
+  curr_insn = NEXT_INSN (curr_insn);
+  if (!curr_insn)
+    return false;
+
+  /* And the last instruction should be an IF_THEN_ELSE.  */
+  set = single_set (curr_insn);
+  if (!set
+      || !REG_P (SET_DEST (set))
+      || GET_CODE (SET_SRC (set)) != IF_THEN_ELSE)
+    return false;
+
+  return !NEXT_INSN (curr_insn);
+}
+
+/* Implement TARGET_NOCE_CONVERSION_PROFITABLE_P.  We detect if the conversion
+   resulted in a l.cmov instruction and if so we consider it more profitable than
+   branch instructions.  */
+
+static bool
+or1k_noce_conversion_profitable_p (rtx_insn *seq,
+				    struct noce_if_info *if_info)
+{
+  if (TARGET_CMOV)
+    return or1k_is_cmov_insn (seq);
+
+  return default_noce_conversion_profitable_p (seq, if_info);
+}
+
+#undef TARGET_NOCE_CONVERSION_PROFITABLE_P
+#define TARGET_NOCE_CONVERSION_PROFITABLE_P or1k_noce_conversion_profitable_p
 
 /* A subroutine of the atomic operation splitters.  Jump to LABEL if
    COND is true.  Mark the jump as unlikely to be taken.  */
diff --git a/gcc/config/or1k/or1k.md b/gcc/config/or1k/or1k.md
index a30cc18892d..bf7125375ac 100644
--- a/gcc/config/or1k/or1k.md
+++ b/gcc/config/or1k/or1k.md
@@ -609,7 +609,7 @@
 ;; Branch instructions
 ;; -------------------------------------------------------------------------
 
-(define_expand "cbranchsi4"
+(define_insn_and_split "cbranchsi4"
   [(set (pc)
 	(if_then_else
 	  (match_operator 0 "comparison_operator"
@@ -618,13 +618,27 @@
 	  (label_ref (match_operand 3 "" ""))
 	  (pc)))]
   ""
+  "#"
+  "&& 1"
+  [(const_int 0)]
 {
+  rtx label;
+
+  /* Generate *scc */
   or1k_expand_compare (operands);
+  /* Generate *cbranch */
+  label = gen_rtx_LABEL_REF (VOIDmode, operands[3]);
+  emit_jump_insn (gen_rtx_SET (pc_rtx,
+			       gen_rtx_IF_THEN_ELSE (VOIDmode,
+						     operands[0],
+						     label,
+						     pc_rtx)));
+  DONE;
 })
 
 ;; Support FP branching
 
-(define_expand "cbranch<F:mode>4"
+(define_insn_and_split "cbranch<F:mode>4"
   [(set (pc)
 	(if_then_else
 	  (match_operator 0 "fp_comparison_operator"
@@ -633,8 +647,22 @@
 	  (label_ref (match_operand 3 "" ""))
 	  (pc)))]
   "TARGET_HARD_FLOAT"
+  "#"
+  "&& 1"
+  [(const_int 0)]
 {
+  rtx label;
+
+  /* Generate *scc */
   or1k_expand_compare (operands);
+  /* Generate *cbranch */
+  label = gen_rtx_LABEL_REF (VOIDmode, operands[3]);
+  emit_jump_insn (gen_rtx_SET (pc_rtx,
+			       gen_rtx_IF_THEN_ELSE (VOIDmode,
+						     operands[0],
+						     label,
+						     pc_rtx)));
+  DONE;
 })
 
 (define_insn "*cbranch"
-- 
2.49.0

