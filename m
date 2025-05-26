Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6079341C64
	for <linux-openrisc@vger.kernel.org>; Mon, 26 May 2025 08:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748248031; cv=none; b=Qxwxkq3JnAAP40P2O96k9f0l9ICdngJkjzlHTnIY/whxwvTyBZ9+FueHjrHjbXZx0qHbq4MVjMSjhRyrElBE89u2SxomoWT+lXk6wPhIFLDQ1nLpnwswOXfFgijgJZ98RsJjOAQqFACzpM1QicHc54S5HsekhTTEE6kjS9cS4+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748248031; c=relaxed/simple;
	bh=9raJkyPYd/IVXT0D0h/HMYLHmv1zOqybe5mfOmJmoFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bysxJVFiI83KgGUiT1Poe4gG06PI+deABuarzGrtHshL4XqX7Ny+f2tno+AuVq1mLAgS7Odp4CVG2fRTWV/mZ5nqYq/2xvP0Xi3j7eD/MYBiEMASDbzIn3Ck9qlFZXxCyxRNH06yqplGYZcv09WNFA+k1IrDsFoUysPss4kq964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmJsSSda; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmJsSSda"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a375e72473so1196152f8f.0
        for <linux-openrisc@vger.kernel.org>; Mon, 26 May 2025 01:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748248028; x=1748852828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dJlAZ4aQYe6YL6ZRsjifSHKNHwCkAdXiqvugqt1ymMM=;
        b=DmJsSSdaRkuC3ofUpOysDC+gAhF35zjLI2g6UQSI6aPACY5HDHmZFCFfNnQA1/U1CE
         woeDWk4NlPH8buHnWFcQW4a2LsQbWJeafc2sw4GNXM4YvBNy4ULZ9SpiulQ5aacEEYp+
         lpu5sHLZRP43sSS72knA+xuyu6kckY/kGF6tIAdUWkcSjN+rmEqbY7yxJFtwXxHtTsFG
         1sr+VFJkZa1hyqXzaKrK59r7vAjS2gNMiLmTgwKImRIxR57lhc2/fL9ldlXoIgNZT6XQ
         BvupnLmPpgU/6OUo7Q+XUhE1ZrNHimRWJJ5QYToKXX+aVfUmv2SR2aFIZyfxVXCP4ZZj
         g3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748248028; x=1748852828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJlAZ4aQYe6YL6ZRsjifSHKNHwCkAdXiqvugqt1ymMM=;
        b=vjsnDjmdkh5r1MdIaN46TtmI+Tx7amSVqygL6nyoXxWY2laihHgPIUQLsOrJSCiQul
         NSYmbTkYImX3Y45SfQNiEMN+q2iLmg2RXkJRnWO65LOsXE7lOnZDsDADsR1ml9MHfR9s
         OPcLFtDN8hoS76Rwkyb+5MgW7UQHMkYTerg+XUiRDSmPAeULq5X67W9dmoUAnzfLoX6/
         463Ekg6aSwJ/4Njvckd73tbRpALQkfFg/BmKKuJKEwwpWUbM/M3AAkLlum4Bgjo4BhrI
         DZyRU7DxtwgB1LL3TmX6a/B2UW6mTpsSA6BpkXRVhewwFSHA0j8f/O1UAVWAJAv/g5ZW
         YrQQ==
X-Gm-Message-State: AOJu0Yz8sptzniPKOq9NAumSDivTc3PSERzLjj9PE0QeZun2kBJ/hGzM
	S/XIgfO+z3J+TKqh8OPRZgx1vhmMJ9tNAuCgDXk+RiL8AlCWZi6NcynAG6iqrayF
X-Gm-Gg: ASbGncuzWHkC7GoukPBwxm3I0BR54u5cEzm6CXKFmBX//munYQP0DpXiOdygnhAktlc
	qSXOhijNDigu9iR8r8GngWkUfcxZ2hMFEAB8CGM4hV2NQxdyNoWMERckAG8wN7Bbmfpme4Adcoy
	WPP1RZmrt/pBg/BQJzxqnV3ri8OfhZDY41uhO1cQwpJCcuC3bSexqc+bjtfnma/nppqJ0Uu7+zw
	fMHwntWEIhRD5mYgHtBDGIrcdiJubnJlFF1Q93kwY1GUxFJIh0U5LexBVInlG4JMwYXWgONb7Lp
	3ngezmr0SQ03EsU0L6dR51LZJm5anM7MQ8apbfEsH3qBZDsvPwKgyhl0/r7V2/x0h37i2dRPZMp
	Wai+cg0tOxoAk7vI=
X-Google-Smtp-Source: AGHT+IEXy0KCxEZ6KtkuP9mKxu9ifXBbf1g6g5cywMKVkuxTSKR6IkbofPCXqRrndw4l97jvuexg9Q==
X-Received: by 2002:a05:6000:3108:b0:3a3:76ff:a617 with SMTP id ffacd0b85a97d-3a4cb45e366mr5497687f8f.32.1748248027431;
        Mon, 26 May 2025 01:27:07 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4c90624cfsm7946217f8f.62.2025.05.26.01.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 01:27:05 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GCC patches <gcc-patches@gcc.gnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH] or1k: Support long jump offsets with -mcmodel=large
Date: Mon, 26 May 2025 09:27:02 +0100
Message-ID: <20250526082702.3319014-1-shorne@gmail.com>
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
---
If anyone is interested with the kernel patches I have them on this branch:

 https://github.com/stffrdhrn/linux/commits/or1k-allyesconfig-2/

 gcc/config/or1k/or1k.opt      | 4 ++--
 gcc/config/or1k/predicates.md | 3 ++-
 gcc/doc/invoke.texi           | 7 ++++---
 3 files changed, 8 insertions(+), 6 deletions(-)

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
-- 
2.49.0

