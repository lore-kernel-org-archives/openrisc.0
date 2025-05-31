Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845742904
	for <linux-openrisc@vger.kernel.org>; Sat, 31 May 2025 05:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748670495; cv=none; b=qTTwYfml8WN7QkN1ASI9phHVJ/XuyEfHs4ha+mc2Zb8BfBefHXiEAfiQwlJKXqCJ6dD2pqj1ldR449g1QwGIh3Q66XwwkDzDhukQvrwLFKRq3o/NhbE9UOfFMGO+Ca8MTvD/rYvsqRsJcBNRzg+K8DwrlmOdS75KIRHVYs0HafI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748670495; c=relaxed/simple;
	bh=fgKuskuP/IEb3z96PRdncmSLJGKCEJ3RjLRpTi6Wz7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rqe6sGbu5c1/fYULVKW1YKLm6a2nhAJfMoZo9bLLTe+72QnIjISgKkAWMeA09QlGSPUjp7VheSUJ86qrCiE/T+WeLYj4YZXe+D960xs6QD9EWIGesF2OjD9g3F9/GayRHuFJ8TWXKahzy4VWM+c2YOOJgD0j7XPLWjkoKgesQS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLYo8O9s; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLYo8O9s"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450cfb6a794so15106015e9.1
        for <linux-openrisc@vger.kernel.org>; Fri, 30 May 2025 22:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748670492; x=1749275292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=74ld+xqUu2RuCdkCOwO2J4d49N0U+iIfAB2ddVkf85U=;
        b=VLYo8O9sFzcskKIEfXK+vTDwMSwaqQUzKzcnHup9+IkGgYtmE6DKP3dCfM/VLbmTJp
         zxl/0/VuUCloe7TEYMgn0aobWf9FfdHCM0HgF5aE8g2H6sVfPJTJDTq/MQx2uOqwa3mv
         2YV0Ddc2jaEgeXKhCnQ4tg0em2HPjoSs9lhb/3ciVhWFzkE+g5jLUuSoFdTVIvck2jed
         NPvm7N6XfJY1WoXmSn07FWWVarWcMfut6RIrIg7C273lU+BVyxH+nCY3fjWR5XIiuVjo
         AycVN7oU/Z/37v/ZYi2lXlMk8H1wMn4yokA35tPPXql92AVgMHS141356lHr5gq7UfIo
         /dlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748670492; x=1749275292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74ld+xqUu2RuCdkCOwO2J4d49N0U+iIfAB2ddVkf85U=;
        b=b6emGCRZ3EKtFUVN4G+xCjgbY9UbOHBxB0CZopt08kBTm6WXbRwAtdehVtiF4XuebR
         pw0EbEY4x+m6+pJ74FVyrxHRKEKqP3lwqIvpG37ATPTxm+V4hRuIH8rzDafIOhdLtpHt
         UDWEYWaotiEIBjGlU4lueTRjLgTgGqqEL9eUQbUAy6EvYtqVYqAZY2v2ROiXaeMg3hvR
         BCSiLWvbN3150R3ADZmUNKCPF+HUuFHdZwRIrTgUqNEFq/akpHjEfFskJXPrlHvM0KoB
         iQHDZo9NL8yuV6WrPSln7CUXCva81B3byBDdFq662MTZdeS1ahS/T2tG0S6yOpSrLTsU
         5sBg==
X-Gm-Message-State: AOJu0YwUzILGHParNNAfIzyAOvzIORqQYKiGR1VxFGtt46SK3R5MEgK8
	dOf2WoyJ1mzCNZTimP3Xxt/Gr5LWqNCrA++hgOKfelN9wT9iDlmYNovR
X-Gm-Gg: ASbGncutM4XqeDk5b2C6eUJqfwFnejKW8xm9zpH82YguxNU/KHM5Su1ZhBjGXlqbeq/
	gv3H0oxqCwf0cvIuiT1gR3lq62z+jVljq8gy14WgU9Mb2yrEXlGBCrljuVM3958/ozFtxZ6RjOY
	Actk+txL45Eu9HVXaeBPNZdKipwiknhCXPryCS1A7AzBwNHYyC622ieYscXs+Xoe5jYPfZbTPWi
	RtqTqtA5NEwICsI+2BSinJLU/7BHJ5elLdZ2TgIOsORpJSYWhzX/nEtmwUOuNKWM+ey2Iuvp42e
	vaSRi4HuJKPXd+MpeHl4CAEdhIHBWwgGzOlGumBPBI2f0rxNthenbitPfCAfia1OKMPqvIJwLTm
	9drHRl1PCZw30Zg0=
X-Google-Smtp-Source: AGHT+IFQtXi0E5/YGRNV2YMpKMMUqmZhIQtTyNTJjCArOzNUzhV/La/Z+3T9WZ16XGMf+Qs1+cDGVw==
X-Received: by 2002:a05:600c:4e0b:b0:442:f4d4:53a with SMTP id 5b1f17b1804b1-450d64c322amr66960885e9.2.1748670491432;
        Fri, 30 May 2025 22:48:11 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000e3esm37401155e9.22.2025.05.30.22.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 22:48:09 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GCC patches <gcc-patches@gcc.gnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2] or1k: Support long jump offsets with -mcmodel=large
Date: Sat, 31 May 2025 06:47:54 +0100
Message-ID: <20250531054754.3687519-1-shorne@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The -mcmodel=large option was originally added to handle generation of
large binaries with large PLTs.  However, when compiling the Linux
kernel with allyesconfig the output binary is so large that the jump
instruction 26-bit immediate is not large enough to store the jump
offset to some symbols when linking.  Example error:

  relocation truncated to fit: R_OR1K_INSN_REL_26 against symbol `do_fpe_trap' defined in .text section in arch/openrisc/kernel/traps.o

We fix this by forcing jump offsets to registers when -mcmodel=large.

Note, to get the Linux kernel allyesconfig config to work with OpenRISC,
this patch is needed along with some other patches to the Linux hand
coded assembly bits.

gcc/ChangeLog:

	* config/or1k/predicates.md (call_insn_operand): Add condition
	to not allow symbol_ref operands with TARGET_CMODEL_LARGE.
	* config/or1k/or1k.opt: Document new -mcmodel=large
	implications.
	* doc/invoke.texi: Likewise.

gcc/testsuite/ChangeLog:

	* gcc.target/or1k/call-1.c: New test.
	* gcc.target/or1k/got-1.c: New test.
---
Since v1:

 - Fix intentation in ChangeLog entries.
 - Add tests.

 gcc/config/or1k/or1k.opt               |  4 ++--
 gcc/config/or1k/predicates.md          |  3 ++-
 gcc/doc/invoke.texi                    |  7 ++++---
 gcc/testsuite/gcc.target/or1k/call-1.c | 22 ++++++++++++++++++++++
 gcc/testsuite/gcc.target/or1k/got-1.c  | 18 ++++++++++++++++++
 5 files changed, 48 insertions(+), 6 deletions(-)
 create mode 100644 gcc/testsuite/gcc.target/or1k/call-1.c
 create mode 100644 gcc/testsuite/gcc.target/or1k/got-1.c

diff --git a/gcc/config/or1k/or1k.opt b/gcc/config/or1k/or1k.opt
index 00c55603300..d252de08204 100644
--- a/gcc/config/or1k/or1k.opt
+++ b/gcc/config/or1k/or1k.opt
@@ -69,8 +69,8 @@ are used to perform unordered floating point compare and set flag operations.
 mcmodel=
 Target RejectNegative Joined Enum(or1k_cmodel_type) Var(or1k_code_model) Init(CMODEL_SMALL)
 Specify the code model used for accessing memory addresses.  Specifying large
-enables generating binaries with large global offset tables.  By default the
-value is small.
+enables generating binaries with large global offset tables and calling
+functions anywhere in an executable.  By default the value is small.
 
 Enum
 Name(or1k_cmodel_type) Type(enum or1k_cmodel_type)
diff --git a/gcc/config/or1k/predicates.md b/gcc/config/or1k/predicates.md
index 11bb5181436..144f4d7b577 100644
--- a/gcc/config/or1k/predicates.md
+++ b/gcc/config/or1k/predicates.md
@@ -61,7 +61,8 @@
 	 (match_test "TARGET_ROR"))))
 
 (define_predicate "call_insn_operand"
-  (ior (match_code "symbol_ref")
+  (ior (and (match_code "symbol_ref")
+	    (match_test "!TARGET_CMODEL_LARGE"))
        (match_operand 0 "register_operand")))
 
 (define_predicate "high_operand"
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index ab89686256d..cfbb9eda083 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -30879,12 +30879,13 @@ to store the immediate to a register first.
 @opindex mcmodel=
 @opindex mcmodel=small
 @item -mcmodel=small
-Generate OpenRISC code for the small model: The GOT is limited to 64k. This is
-the default model.
+Generate OpenRISC code for the small model: The GOT is limited to 64k and
+function call jumps are limited to 64M offsets. This is the default model.
 
 @opindex mcmodel=large
 @item -mcmodel=large
-Generate OpenRISC code for the large model: The GOT may grow up to 4G in size.
+Generate OpenRISC code for the large model: The GOT may grow up to 4G in size
+and function call jumps can target the full 4G address space.
 
 
 @end table
diff --git a/gcc/testsuite/gcc.target/or1k/call-1.c b/gcc/testsuite/gcc.target/or1k/call-1.c
new file mode 100644
index 00000000000..593e402d21c
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/call-1.c
@@ -0,0 +1,22 @@
+/* { dg-do compile } */
+/* { dg-options "-O2 -mcmodel=large" } */
+
+/* Generate local and global function calls. */
+
+extern int geti (void);
+
+__attribute__ ((noinline)) int
+calc (int a, int b)
+{
+  return a * b + 255;
+}
+
+int
+main (void)
+{
+  return geti () + calc (3, 4);
+}
+
+/* Ensure the 2 calls use register not immediate jumps.  */
+/* { dg-final { scan-assembler-times "l.movhi\\s+" 2 } } */
+/* { dg-final { scan-assembler-times "l.jalr\\s+" 2 } } */
diff --git a/gcc/testsuite/gcc.target/or1k/got-1.c b/gcc/testsuite/gcc.target/or1k/got-1.c
new file mode 100644
index 00000000000..5357096421d
--- /dev/null
+++ b/gcc/testsuite/gcc.target/or1k/got-1.c
@@ -0,0 +1,18 @@
+/* { dg-do compile } */
+/* { dg-options "-O2 -fPIC -mcmodel=large" } */
+
+/* Generate references to the GOT. */
+
+extern int geti (void);
+extern int j;
+
+int
+calc (int a)
+{
+  return a * j + geti ();
+}
+
+/* Ensure the 2 references use gotha relocations and that the function call does
+   not use an immediate jump instruction.  */
+/* { dg-final { scan-assembler-times "gotha" 2 } } */
+/* { dg-final { scan-assembler "l.jalr\\s+" } } */
-- 
2.49.0

