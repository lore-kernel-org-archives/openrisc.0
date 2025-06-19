Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09BE24293C
	for <linux-openrisc@vger.kernel.org>; Thu, 19 Jun 2025 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338879; cv=none; b=oXr0InfCgESRkJYNyB89rwS9DgOBTP0oNjr7HENolRICZll9zckaPO1yozHHQzyFx+fQ55sKF06lNVQhX7UI2sJ2gv/7FdBZ9nj6dGQ3hnqBpXXGpO+Q83jP1OaeqEvOhc/Xgw9UPVzBU4vHMygHwIgpkF8GvvLUac8jifth96k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338879; c=relaxed/simple;
	bh=JIg2wPEwNNTm+/o4r+umSSBbiq01Jxfs+NSqSayrqYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3NahCcjQGcPIehttdn/lhGqbRYKbo0hYU/9+Ze5r91uHAa5q56+QyWN8ECHoXc26C+UG7UcRUKBflq8Qb2+3/wLv2wS5Z0ELrNLMbrdbF28gT67wrnZSDXlYbWRjICOAzFF+wPKUT4HbEt9hFtWfHGqoBoxHiyzZZCauhb/Z54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RK7EPguL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK7EPguL"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so12569005e9.0
        for <linux-openrisc@vger.kernel.org>; Thu, 19 Jun 2025 06:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750338876; x=1750943676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ti0bGTHS9mRmu8LsGR/WqR6v7NECnCU+Wwe0vj9A8WA=;
        b=RK7EPguLeLIWM5X5PeHMy2f3+DABCDhd285D2zpatbU+WzKn5XDzTWuOuzwUoMvpNl
         K7hEtVKSC2QeALme4CtpfeHbp7zlzPn2e0Y0QOrU28nuO+z1chNob3Z/ouRLQL+M3Crb
         kD0OpKW8HXRG5AF8iPqtS37nw90hkYo46UsTSwHQRewqEGIJEgW4ZaMpJUsvs8Li1vdt
         3O/G9sAOlZ2L1P/i15URRWl8Wgp08pvOqCMrEfhJnZ5cheAm2o4j+7qvzFJf81zLMq1h
         MTZpZaA5hNNJ7msMQjx9EX0MwRf4MUvNwBOrRpHx1a2qSmLY9E1pXDDeKPzDcORe6Rxk
         vjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750338876; x=1750943676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ti0bGTHS9mRmu8LsGR/WqR6v7NECnCU+Wwe0vj9A8WA=;
        b=JKOdMCWRVCo/WiHCv1up4HJCep38VKdKKgEdnFapI5m46FKcI3uB8fBLVATIt3j0IQ
         Ch+pORWwWqJ1hTdMpghxlAZbU8cesmac4W8rUs4YRL/78sLVJvuBo/I8VhLsucZxPOJm
         UCBjkXsSAUPsKY43+9LddKsTBW+ZKNyDUZ2ZaKPOz5yh5ZT6FvJGmuVX7xzQ/kwO7QFR
         vScs+AbPMBJdIQE9hLDTGaxlLypwrn32C2uLWvS3BNTe3cHI9tHa2jkfJSJv34KnHsga
         hXVdRdOeLfcyETV0Qpnw1/QIp6aHl2GSB0MvEsycxm+UrK2FGTTT8uP+aeR3yFHTsISs
         LnfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/P9yx81Y41tN31rCUDpRL62CdwMDLNGqb43MhMsjJMbiw+wXiTgRt9HtM83D8B9IJcUGl73LhQYquzFLy/A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb7WKfy7ku4NTE+chYsQDs+Ga4JYwT1SD2joEeYOn7GLFmkKVK
	l8cUMEilS9OVZLukVyNNSFUYdaEdAP1TsqAeLZHKixiHqzclBMXf+o2q
X-Gm-Gg: ASbGnctJAA2c2vkn1kCfjpONatPtn/asaaXtSEHG4KkoTQcFq3ViSlzVzcTZC6wrDan
	CDRVk17ygEwUwmqGgbeQQ28gZpaPbvMdO18bCnn/5rKC3lE1chGNHinvdMl7/LlXdZSXXiAVU0h
	8nStsFOM9FoIXpZv6iXIzQjPppl7+x4yflXqFzJ08PbW/pcNAco/ZdwU9pMS9yRsE/aUrAVy61F
	LuazeE+Q1kWokeP8GyYr4F25eHNX+rX9BgKAOWiLqTktGJoHxvaoFGWJtxcicCbj5rH98NTCmRY
	/OQfl1uYKX1ErlaD4gVQqpevdDrNTz+N4Cbk70IqDV5wERKrmlvGrqIIQtmXRJCWFYLv71uqB00
	HWm86ldVIGl+0rfIcq0fhpepNtA==
X-Google-Smtp-Source: AGHT+IHDFIHDX1kKNgEIb4LO7xM2lh0C6Xym1RQ3JkQTOlDD8f1t7PVqdS1fZ/n9mSxBL3bI+XL/wg==
X-Received: by 2002:a05:600c:4899:b0:453:84a:e8d6 with SMTP id 5b1f17b1804b1-4535ec22773mr21175735e9.1.1750338875520;
        Thu, 19 Jun 2025 06:14:35 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535b683b49sm29419365e9.1.2025.06.19.06.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 06:14:33 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GCC patches <gcc-patches@gcc.gnu.org>
Cc: Dimitar Dimitrov <dimitar@dinux.eu>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH 1/2] or1k: Implement *extendbisi* to fix ICE in convert_mode_scalar [PR120587]
Date: Thu, 19 Jun 2025 14:14:25 +0100
Message-ID: <20250619131426.1292212-2-shorne@gmail.com>
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

After commit 2dcc6dbd8a0 ("emit-rtl: Use simplify_subreg_regno to
validate hardware subregs [PR119966]") the OpenRISC port is broken
again.

Add extend* iinstruction patterns for the SR_F pseudo registers to avoid
having to use the subreg conversions which no longer work.

gcc/ChangeLog:

	PR target/120587
	* config/or1k/or1k.md (zero_extendbisi2_sr_f): New expand.
	(extendbisi2_sr_f): New expand.
	* config/or1k/predicates.md (sr_f_reg_operand): New predicate.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 gcc/config/or1k/or1k.md       | 25 +++++++++++++++++++++++++
 gcc/config/or1k/predicates.md |  4 ++++
 2 files changed, 29 insertions(+)

diff --git a/gcc/config/or1k/or1k.md b/gcc/config/or1k/or1k.md
index 627e40084b3..a30cc18892d 100644
--- a/gcc/config/or1k/or1k.md
+++ b/gcc/config/or1k/or1k.md
@@ -515,6 +515,31 @@
 	(ne:SI (reg:BI SR_F_REGNUM) (const_int 0)))]
   "")
 
+;; Allowing "extending" the BImode SR_F to a general register
+;; avoids 'convert_mode_scalar' from trying to do subregging
+;; which we don't have support for.
+;; We require signed and unsigned extend instructions because
+;; signed comparisons require signed extention, but for SR_F
+;; it doesn't matter.
+
+(define_expand "zero_extendbisi2_sr_f"
+  [(set (match_operand:SI 0 "register_operand" "")
+	(zero_extend:SI (match_operand:BI 1 "sr_f_reg_operand" "")))]
+  ""
+{
+  emit_insn(gen_sne_sr_f (operands[0]));
+  DONE;
+})
+
+(define_expand "extendbisi2_sr_f"
+  [(set (match_operand:SI 0 "register_operand" "")
+	(sign_extend:SI (match_operand:BI 1 "sr_f_reg_operand" "")))]
+  ""
+{
+  emit_insn(gen_sne_sr_f (operands[0]));
+  DONE;
+})
+
 (define_insn_and_split "*scc"
   [(set (match_operand:SI 0 "register_operand" "=r")
 	(match_operator:SI 1 "equality_comparison_operator"
diff --git a/gcc/config/or1k/predicates.md b/gcc/config/or1k/predicates.md
index 144f4d7b577..7ccfd09985d 100644
--- a/gcc/config/or1k/predicates.md
+++ b/gcc/config/or1k/predicates.md
@@ -60,6 +60,10 @@
     (and (match_operand 0 "register_operand")
 	 (match_test "TARGET_ROR"))))
 
+(define_predicate "sr_f_reg_operand"
+  (and (match_operand 0 "register_operand")
+       (match_test "REGNO (op) == SR_F_REGNUM")))
+
 (define_predicate "call_insn_operand"
   (ior (and (match_code "symbol_ref")
 	    (match_test "!TARGET_CMODEL_LARGE"))
-- 
2.49.0

