Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C013B27F3
	for <linux-openrisc@vger.kernel.org>; Mon,  6 Jul 2026 05:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317201; cv=none; b=TFo82xCEPGuZyFeJaCXnJ4xwJNBou020YexrFkExJBvjkiXZjlbInBpcjGn/ZNfi/v2iGjO/p53kyeTdLV4qTVfzAfHqXcUjc+qERFTBCOzinIxJzlGe1PtqSCWNQ5umYCNWgnET9FzrhpPpxc7Ygg6GTN7AWwVjVmEID2uL4f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317201; c=relaxed/simple;
	bh=vBzM7d2GTGtCSLhMGD1oQ8S0dpHAGRgOZ2axbesKWkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBeeOi6m/GAkxPTs41+8TC3Yxdzrlul0ctpm17kxmzDkMh/P1QETG3nV5/8oUSUEIQ1eGTHOjkh6c9pGfiB1QJnpC7mrnVa9BkG+qmOlZb5L6MM6vSLsHW1ZfM9QZxv5YMLipBKrP4HvXlgib8Z6tAFpzhuZ9zjVS552N06fm7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpo+sUXN; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpo+sUXN"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-476d8e647e9so2184740f8f.0
        for <linux-openrisc@vger.kernel.org>; Sun, 05 Jul 2026 22:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783317198; x=1783921998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VcIZKV4zH0BrlrRcemQRYOKRxsSCmsQ/ZwjvzvgAF6c=;
        b=lpo+sUXNSbNy+n6DO576Rja2nDpm+/Q0xbI3GP938UGbFn3NvBKOqwaNIoJuVnqGDX
         LocImFaibIDxGdUwiCsYHaVsgyWyAVKaNzXhT7OGoVaYFM5JbJxmHuZ56qphSz0GF+lT
         6QdjrXvcHXzKShfMQyOBXV/KAzKH9oo2gshwxJ8/4IDItJEAu44k17f8sGx+mmUkNWQb
         0Nu6UVBSfS0N5/4TnU69jADczUo1URaMEfR5DT0qPkR/S78Z4UjGbdBy04CZGvDfe+BD
         G+qe1jKDLzcv1B/UHUxUtsWkKWnmmcUUVpuTElMHgj3+4dHKMQ85en9gXRddBfJ6JPDY
         QQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783317198; x=1783921998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcIZKV4zH0BrlrRcemQRYOKRxsSCmsQ/ZwjvzvgAF6c=;
        b=etiOJQPJUWe2IrHiKu2mELeWJOce+hhO8YKT3rbr+F9so3Jo7XlY3pgFm4V+fTiHSl
         MSFlcYRtIFweWRIJwrtTfTUwsqFyzTnS4Sn4hKcJDuYfXYXOJ6DgH/SaA066dSYL+RP1
         1UecJ5mb0t0p8c1CUrkRZmOnLlR0Pe7zDCzjCoRnp6IQMEBc3VPGw7bY3QvkbzuXoM5o
         WnvnTP5Tm827nK0wZUdZvGOZ+53TO7dSV8ZkTTkEAe09Ock5gOgAh8c7Y/DBl1mV6L2L
         oBQA4D/mN8BGTKk4Jwu8N03n0KtS6rjyEvaHxAil+vdhFUB88uQWkwfMD5jgcXXPnBQW
         uSYQ==
X-Gm-Message-State: AOJu0YyqgqTvHPFhOPHaZftG2krc3aLOHekZBGPWKJgekFTH0a4VLv6m
	fKsm9OaiOYOUsIqZFyTWWNy9NHz7U6xCDvKVPBxgt4m2dVIYHO33ddOt/0HVJq0hL0U=
X-Gm-Gg: AfdE7ckKPuvPU1F+hv1+j0g9kXgtftlKJzmmGwaB7vdKcw/ZSUhYA7twLWefwR6PIMY
	9JAOUkTN2W8NhS/ojHW+hLwVNgxUdYIrgJQJxDyFIKN6UQnf6ghTCQvtAUE1m/QxkZtm4cztWij
	0F5Jyv3l0UX6E1AFW6QM7eRL5US04GeIaNIllaWe84UnL+uDCqjx/OLm1IxuWWatWoVHYJpNte2
	88Uxg3n1Qv7FLsli4L9R5uMsCcrM/yVzQAxclair7u3eduCMP83Lt25cScHJBC4OjJiWJYzyrEx
	TpA/uWe6ZlJqNevcLDfcu1MmSc/8vywCWtA6kuKGiYob/yw8g5ddH5EWnBxgb1tV5exyy1Oi4I+
	YQCbplPl3Io8MMEa7j2UINU29jPZSbamHvxgswkiG1AM1zbEdgn1QQUohlL3TcGxJtYp0RGfZfK
	iZJIyOSrV8Tq1eSDL/H5ZZCm1OGjoQCcxRJJQaL0iJ3zZDwusJCDTei2uB0bPLoEODkVX2d45A8
	ZBBMw==
X-Received: by 2002:a5d:588b:0:b0:471:2631:9d7e with SMTP id ffacd0b85a97d-47aacab5251mr10555631f8f.27.1783317197859;
        Sun, 05 Jul 2026 22:53:17 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b0cesm21356154f8f.22.2026.07.05.22.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 22:53:17 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GCC patches <gcc-patches@gcc.gnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH] or1k: Stop allowing referring to SR_F in SImode and fix cmov
Date: Mon,  6 Jul 2026 06:53:14 +0100
Message-ID: <20260706055314.1428104-1-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We were seeing compiler errors such as:

    x.c:8:1: error: insn does not satisfy its constraints:
	8 | }
	  | ^
    (insn 33 28 35 2 (set (reg:SI 34 ?sr_f)
	    (reg:SI 16 r17 [52])) "x.c":6:7 discrim 1 28 {*movsi_internal}
	 (nil))
    during RTL pass: postreload

This was being caused by previous commit c0694f95f59 ("or1k: Fix ICE in
libgcc caused by recent validate_subreg changes") and commit 710581c80b2
("or1k: Allow SImode for condition flag register") which allow
referecing SR_F in SImode to avoid errors during if conversion.

We can completely avoid this by reverting the changes to allow
referencing SR_F in SImode and fixing the
or1k_noce_conversion_profitable_p function to allow cmov expansion even
when TARGET_CMOV is not enabled.  The *cmov split logic can take care of
lowering the *cmov instructions if l.cmov is not supported during the
later split passes.

gcc/

	PR target/126081
	* config/or1k/or1k.cc (or1k_hard_regno_mode_ok): Stop allowing
	SImode for FLAG_REGS.
	(or1k_can_change_mode_class): Stop allowing SImode for
	FLAG_REGS.
	(or1k_noce_conversion_profitable_p): Always check
	or1k_is_cmov_insn.

gcc/testsuite/

	PR target/126081
	* gcc.target/or1k/pr126081.c: New test.
---
THis has been tested with toolchain and rootfs builds as well as the GCC
testsuite with no regressions.  After message reviews I will push.

 gcc/config/or1k/or1k.cc                  | 14 ++++++++------
 gcc/testsuite/gcc.target/or1k/pr126081.c |  8 ++++++++
 2 files changed, 16 insertions(+), 6 deletions(-)
 create mode 100644 gcc/testsuite/gcc.target/or1k/pr126081.c

diff --git a/gcc/config/or1k/or1k.cc b/gcc/config/or1k/or1k.cc
index f1ecf21c6e2..89076ae02fc 100644
--- a/gcc/config/or1k/or1k.cc
+++ b/gcc/config/or1k/or1k.cc
@@ -1393,7 +1393,7 @@ or1k_hard_regno_mode_ok (unsigned int regno, machine_mode mode)
      really single bits within SP[SR].  Also allow condition flag register
      in SImode to match or1k_can_change_mode_class.  */
   if (REGNO_REG_CLASS (regno) == FLAG_REGS)
-    return mode == BImode || mode == SImode;
+    return mode == BImode;
   return true;
 }
 
@@ -1411,7 +1411,7 @@ or1k_can_change_mode_class (machine_mode from, machine_mode to,
 {
   /* Allow cnoverting special flags to SI mode subregs.  */
   if (rclass == FLAG_REGS)
-    return from == to || (from == BImode && to == SImode);
+    return from == to;
   return true;
 }
 
@@ -1697,15 +1697,17 @@ or1k_is_cmov_insn (rtx_insn *seq)
 }
 
 /* Implement TARGET_NOCE_CONVERSION_PROFITABLE_P.  We detect if the conversion
-   resulted in a l.cmov instruction and if so we consider it more profitable than
-   branch instructions.  */
+   resulted in a l.cmov like instruction and if so we consider it more
+   profitable than branch instructions.  Even if we do not support l.cmov this
+   allows the *cmov instruction sequnce to be expanded and then later lowered
+   with the *cmov split logic.  */
 
 static bool
 or1k_noce_conversion_profitable_p (rtx_insn *seq,
 				    struct noce_if_info *if_info)
 {
-  if (TARGET_CMOV)
-    return or1k_is_cmov_insn (seq);
+  if (or1k_is_cmov_insn (seq))
+    return true;
 
   return default_noce_conversion_profitable_p (seq, if_info);
 }
diff --git a/gcc/testsuite/gcc.target/or1k/pr126081.c b/gcc/testsuite/gcc.target/or1k/pr126081.c
new file mode 100644
index 00000000000..b5cce62f3e9
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/pr126081.c
@@ -0,0 +1,8 @@
+int option_mask32;
+void xsocket(int);
+enum { OPT_u = 1 << 3 };
+
+void nc_main() {
+  int x = option_mask32 & OPT_u ? 2 : 1;
+  xsocket(x);
+}
-- 
2.53.0

