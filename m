Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470F718CC13
	for <linux-openrisc@vger.kernel.org>; Thu,  4 Jun 2026 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596405; cv=none; b=dTjQ4BtkIDsiqJRJ0jHIHjOg6L4lKgRTSCDrNfHKrhPU+8LNG4hu2/3sGr+FeNVzerVTVggHmp04sRI443cLmzZruFERZpc83WZZzNvgnW2OhxL31KkPY7Ow+R2Ty/tgXdDJRizALT2l0uFHdR/KHtenXxnYEL8vXdF6F57nBqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596405; c=relaxed/simple;
	bh=dHIQ4vKY4d9EKYjURKC9YWdxfSaDwuegWVM7O7UKiDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dAh85FFaxXauD1xee2shZpbIa8FXWiMU8z5A6YWa2RiugT3XY/JRXPsZH2DKko6OEc4mjU/OQqwqkcSwcsF6NcsI6CM0zVDW5XCDUtMo3EiedwyVw1dVx+aoa+xN/ju6NBYoevlpy4jdTau/cPgvRRz/A1fioV6Pyzt9C1N1P4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dt9pG83f; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dt9pG83f"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so11812065e9.0
        for <linux-openrisc@vger.kernel.org>; Thu, 04 Jun 2026 11:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780596403; x=1781201203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UnI7mngI8KOXSiQXFx1508hrXwqre67mamzzkaCk+1E=;
        b=Dt9pG83fVH1v1CvAdovAoKwc7FQw9rcG2r3U7m2Gady4xfxvoUMzJj1Hy2uSEuqXTJ
         wdbLuM5dUdLxpvlsSio+LWlG2DHYs13r8hk+rsKfnf20AK6pVHl4HfpwN0LbIyBrF8zR
         1sOQ96AgvWKpumQP91fhb2Z9Tn7bHphMqD5Fv6542KpwgrPZbqSE5+h5c1go3MXdBSV0
         a93o9Zv8K+hc+HzIde9tqoXgX9VVa8k7ShNT5nGF2LKLFL5qC82Q19snZc96EohD+Kfb
         x+2Mra0ZUeZWtSDS01hUckVmiMu7lfF0/aZ8z7Xy+cyFe0AkafsMn0dpTyErZClY9SpU
         r4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780596403; x=1781201203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnI7mngI8KOXSiQXFx1508hrXwqre67mamzzkaCk+1E=;
        b=q7+1gMjf7DvsXc5nhV8tt3d41nWnRj+VYwriCMGN0t5VbTiKf+KWAvMrD1PwPUKxhf
         EjFJipFnMqEbYbkO+1VDygpyD9rYD6HRQcTBvpmqCJ1oS4HoRhL7JI3t13aNpn1BKOCM
         PrtpIC+bGzIg0Bm4FWWWkjpUJxGnOvl89URBs9d70Yz/GlN3Yq26femMzDVue5MwXjFL
         Ic4gTRfDpQ7K5h02p/OIWOJv56h/AWg9CFECWEvkc2RpzVP8Omhf7dZ3pC8UP3iIQfmp
         c330JXbtchwNZGTPrWaoxK+Hi4M5pgxdrcEknXcfygvIu0vgYVA57lEtrcY+4OG4Pw6E
         psiw==
X-Gm-Message-State: AOJu0YxHLZRl4ABJ4QsBXEmwTvgXT6ILEW5RJ85rfoU4hzomxGz1KwYS
	QQZCq0CRIpA/kLUeRks54Wgvwl6cMubPW5iXu+NIvdaThRq5dZPl62oX
X-Gm-Gg: Acq92OHHgChtitnPz0y1YxQAGXjxYnNPtTPMlnO/2gJVbjc42GRRQ2TH1s3K6c1IHNp
	YOiB8eeo3It7Pe7aP/js/0gsTDLQqoBzzv7rU6Paj4kGAyNH1kCUdUBSlMd26pyihpYoN1j4JF5
	8UCmOjjxeZcK+o7URF0xpTJcZMiI+iY0poIi+GJxyxlvLz3oL8eVGn72DJJPxVAwZ5fRjMG5QXh
	XRCIW8rgOvj+FSgMNlaxE1uL38stziawOW+o9mH7sodbI7qkoIbbUisQd2k6G43MDXh0DlZ9g8q
	VkBA4kYKYEcma0ZJofueQPV09+5W9isF+uDlWvA22hE94u36NDQzdOC42SiwxMej+iCfTLgHkCT
	VwQue3h16r/tUqR4td1iDywVQxed7Twdl8WLyex3x2hFq2DZ4hnIFSzN1B2jBYBhWyAdyqp6Dn2
	DreF3RF6UHzU2NQLjB85h7v8W/feBcGqv/DYQmOAltNE0ykImsrnyGdWYSU6GGFQNqi5YiohAou
	19T7Gn27n3x+7t2
X-Received: by 2002:a05:600c:8b76:b0:490:bb44:3f8b with SMTP id 5b1f17b1804b1-490bb4440a2mr97961345e9.17.1780596402538;
        Thu, 04 Jun 2026 11:06:42 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dce6sm9866288f8f.30.2026.06.04.11.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:06:41 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GCC patches <gcc-patches@gcc.gnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH] or1k: Fix 64-bit shifts on OpenRISC
Date: Thu,  4 Jun 2026 19:06:34 +0100
Message-ID: <20260604180634.1920890-1-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On OpenRISC, 64-bit shift tests shiftdi-2.c and vshift-1.c were failing
and it looks to always have been broken.

After investigation it was found that OpenRISC fails to define
SHIFT_COUNT_TRUNCATED which is needed as both register and immediate
shift amounts are unsigned and only use the low-order 5 bits.  Also,
the immediate used for 32-bit shifts is an unsigned 5-bit value not a
6-bit value; update the predicate.

After these changes the tests pass.

  $ make check-gcc RUNTESTFLAGS='dg.exp=vshift-1.c execute.exp=shiftdi-2.c'
  # of expected passes            14

gcc/ChangeLog:

	* config/or1k/or1k.h (SHIFT_COUNT_TRUNCATED): Define.
	* config/or1k/or1k.md (rotrsi3): Rename reg_or_u6_operand to
	reg_or_u5_operand.
	(<shift_op>si3): Ditto.
	* config/or1k/predicates.md (reg_or_u6_operand): Remove.
	(reg_or_u5_operand): New predicate.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 gcc/config/or1k/or1k.h        | 3 +++
 gcc/config/or1k/or1k.md       | 4 ++--
 gcc/config/or1k/predicates.md | 8 ++++----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/gcc/config/or1k/or1k.h b/gcc/config/or1k/or1k.h
index ee3a7814f09..af043f8c2d9 100644
--- a/gcc/config/or1k/or1k.h
+++ b/gcc/config/or1k/or1k.h
@@ -394,6 +394,9 @@ do {                                                    \
 /* All the work is done in PROFILE_HOOK, but this is still required.  */
 #define FUNCTION_PROFILER(STREAM, LABELNO) do { } while (0)
 
+/* Shift instructions ignore all but the low-order few bits.  */
+#define SHIFT_COUNT_TRUNCATED 1
+
 /* Dwarf 2 Support */
 #define DWARF2_DEBUGGING_INFO 1
 #define INCOMING_RETURN_ADDR_RTX gen_rtx_REG (Pmode, LR_REGNUM)
diff --git a/gcc/config/or1k/or1k.md b/gcc/config/or1k/or1k.md
index d3fbb209be7..6de0dc26511 100644
--- a/gcc/config/or1k/or1k.md
+++ b/gcc/config/or1k/or1k.md
@@ -217,7 +217,7 @@
 (define_insn "<shift_op>si3"
   [(set (match_operand:SI 0 "register_operand" "=r,r")
 	(SHIFT:SI (match_operand:SI 1 "register_operand"  "r,r")
-		  (match_operand:SI 2 "reg_or_u6_operand" "r,n")))]
+		  (match_operand:SI 2 "reg_or_u5_operand" "r,n")))]
   ""
   "@
    l.<shift_asm>\t%0, %1, %2
@@ -227,7 +227,7 @@
 (define_insn "rotrsi3"
   [(set (match_operand:SI 0 "register_operand" "=r,r")
 	(rotatert:SI (match_operand:SI 1 "register_operand"  "r,r")
-		     (match_operand:SI 2 "ror_reg_or_u6_operand" "r,n")))]
+		     (match_operand:SI 2 "ror_reg_or_u5_operand" "r,n")))]
   "TARGET_ROR || TARGET_RORI"
   "@
    l.ror\t%0, %1, %2
diff --git a/gcc/config/or1k/predicates.md b/gcc/config/or1k/predicates.md
index cde49a3754c..1f78e57366d 100644
--- a/gcc/config/or1k/predicates.md
+++ b/gcc/config/or1k/predicates.md
@@ -38,9 +38,9 @@
   (ior (match_operand 0 "register_operand")
        (match_operand 0 "const0_operand")))
 
-(define_predicate "reg_or_u6_operand"
+(define_predicate "reg_or_u5_operand"
   (if_then_else (match_code "const_int")
-    (match_test "INTVAL (op) >= 0 && INTVAL (op) <= 0x3f")
+    (match_test "INTVAL (op) >= 0 && INTVAL (op) <= 0x1f")
     (match_operand 0 "register_operand")))
 
 (define_predicate "reg_or_u16_operand"
@@ -53,9 +53,9 @@
     (match_test "INTVAL (op) >= -32768 && INTVAL (op) <= 32767")
     (match_operand 0 "register_operand")))
 
-(define_predicate "ror_reg_or_u6_operand"
+(define_predicate "ror_reg_or_u5_operand"
   (if_then_else (match_code "const_int")
-    (and (match_test "INTVAL (op) >= 0 && INTVAL (op) <= 0x3f")
+    (and (match_test "INTVAL (op) >= 0 && INTVAL (op) <= 0x1f")
 	 (match_test "TARGET_RORI"))
     (and (match_operand 0 "register_operand")
 	 (match_test "TARGET_ROR"))))
-- 
2.53.0

