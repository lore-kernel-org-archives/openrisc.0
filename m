Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E0647D443
	for <linux-openrisc@vger.kernel.org>; Fri,  4 Sep 2026 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523045; cv=none; b=B6k5Qw0PQ3pFJ7Vnoh8ShcvMlvivfAzfSW1gMsHd1MQmHO9/vbdbX/6t8mjDjfUpfz5i7PeHiiLh48GVVECqpRoinKOIDlNzxOcE6Tq6XELV36myJW5YtYwAj3JMbPkkewQ3QAwmT4nKCxjnnx1JGhEKBwKI2zfBxa6GZvsHtrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523045; c=relaxed/simple;
	bh=9XE7MtBezDD7RF7tQaS1cUQR7zn517/cayzMz7N9jmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HaoDj7X8X3+TDBqf5VqbgHDbsXd8XhRw73qosnFtqT4OC44zenKkzn3pi8ZVkR+hc9F9Mu2/KAJfzrluQfqrUbtTO49XxKp+f2UGo3yTKavTabAYDOT2c3e2Ip4kieJoK5U8f4FscsqxTXxH/EiJtxVYKOijehCuBJ+C0z1OdMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpU18QDP; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpU18QDP"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so748307a91.0
        for <linux-openrisc@vger.kernel.org>; Fri, 04 Sep 2026 04:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788523043; x=1789127843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5U9NwUkHLw0SJAox3eKL7/V/fAViTXe0elbVOgVNB8s=;
        b=PpU18QDPE0DNWL6NdEkYOblEuF6RHSNqkM0pE1tutA3QxE3ciUy3sg0acwEot0f66X
         HJjqmj2SH6Ifg05jLVlEenEay6vnufHsUMrOb3Y9zQf/Iov3mn8k/XenAP2b7w3or4vO
         GXWkNhC2ToRbhTyTJS1J0Xi+qWqzBnUXgipTPuAr+S/7P07C8SpeFteeQ47xZ4obuyqD
         ZYVWkrWNJXgZ2yXhX6QIU4yGynneuKUYJm8fH5faEt2oLfbm6rWzpJcFcHO9Ok88XLTz
         wdgpM5tTNOfxN4hhFc/toD2ufbhi0VPlPGzNVDGF6z/3YxiK+67rp/uU4FAO/ai2OZrR
         p2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788523043; x=1789127843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5U9NwUkHLw0SJAox3eKL7/V/fAViTXe0elbVOgVNB8s=;
        b=sF5tSeBCg4eQPNI5qVblgca6ltDNRujsdcB6Z6EouJFX+WZs15cZlI2CeqrcD49VzO
         eNvS25+a8Ks+lPkwd+U7xkpPVndMP4JHVR2rPSZFuJOCExqFS+5IRhRASHBx07EyPp0E
         N2x1gDh2efjajkF4GclllDnyRlaw8ZPHtHAutztmT5Cn0H5DQzrI2KX3N92sjlaKqSTe
         sqMdFTxWVGrwRiqkOO78ZQTTf97Is4kn2T8pVEbVTdzjI6OwS6/1nkuaZUiZQSJu+8Dm
         Kl1wXsp0+NjBkzYEBoe7cW+06OahHSCcX/fS875uf+gPmFroOX4MgvII79xYhvCHAnTC
         le5A==
X-Forwarded-Encrypted: i=1; AKwUvBy8yPtK58pEnfS76UoaSGJTUAWyoHb1hfWmTGyOeYkPnf51kCWbFWi57cwEg2sLphAiXdsAcSKyjCYKo5JX/g==@vger.kernel.org
X-Gm-Message-State: AFuF++n2o+HGp1RuIvIBN7+Lt0jOXTbN4DeWvIn2DnBNBbk0Wogtjr4V
	jGHMVc3YFE1SLB3oVu7qg/cTVVNwvAzBGAv2nWwCx2UQiGAUQ0yuwgSlveVH/Kmhmfk=
X-Gm-Gg: AYBFou1kKOFKvr4JqETTBcnDqK/40ky5X83P/OXLQQSPAj7YIfHENct6FpgiQrzaI0q
	vPAfsPAL/kicbVLpwhHD9qTOFqfkJEvzT1JBUzYmjKjqJnPUQPDTzXWh/U0pu1uL/IFiVFS2CcS
	WMTZhirIbL9ng8ht2mP8u50QeFsn/T3Ll88sS9L6XtT05ik6DNK+u+ZvIlwzythOGT2Rd4UXHiQ
	BCP0UIE2AjArVLQuDmiUraC+XKtJBTxzZAT6gQdYLNKXUUAazYBt0U6VE77jdphilsSxEWQ9+35
	hNM2l+0uAgF2oh9voEgQBf8WryF3vwvwUXKvi2Y91sWOUSM49QxEBx8u/3f+/E6B8fm2N/XEgvT
	uPQ/OwE6ydYNRF+GP2RHhXZs57ls4C2gZCMeGvs+IHmVkT3PRK9Uufmza4XEall0IFGOo+1IqpU
	l9tTmz7Z9pjEHuiNSeyWxofnQ2FB0gIoATgFdFxA5VCvNFk9yVr/g3tZPo5MSJUYijy/I0kuBOu
	LVYyDKvdDTtuPA=
X-Received: by 2002:a17:90b:578c:b0:398:e6b6:acc2 with SMTP id 98e67ed59e1d1-39b261e7649mr9495153a91.12.1788523043295;
        Fri, 04 Sep 2026 04:57:23 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b8f787esm5733398eec.23.2026.09.04.04.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:57:22 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-openrisc@vger.kernel.org
Subject: [PATCH] openrisc: fix typos in comments
Date: Fri,  4 Sep 2026 17:27:17 +0530
Message-ID: <20260904115718.12338-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/openrisc/kernel/entry.S | 6 +++---
 arch/openrisc/kernel/head.S  | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index 18e68680471e..0aade79e796a 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -231,7 +231,7 @@ handler:							;\
 /*
  * NOTE: one should never assume that SPR_EPC, SPR_ESR, SPR_EEAR
  *       contain the same values as when exception we're handling
- *	 occured. in fact they never do. if you need them use
+ *	 occurred. in fact they never do. if you need them use
  *	 values saved on stack (for SPR_EPC, SPR_ESR) or content
  *       of r4 (for SPR_EEAR). for details look at EXCEPTION_HANDLE()
  *       in 'arch/openrisc/kernel/head.S'
@@ -1056,8 +1056,8 @@ ENTRY(ret_from_fork)
  */
 
 
-/* _switch MUST never lay on page boundry, cause it runs from
- * effective addresses and beeing interrupted by iTLB miss would kill it.
+/* _switch MUST never lay on page boundary, cause it runs from
+ * effective addresses and being interrupted by iTLB miss would kill it.
  * dTLB miss seems to never accour in the bad place since data accesses
  * are from task structures which are always page aligned.
  *
diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index d5befd632fa9..60840dd109d2 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -91,7 +91,7 @@
 #endif
 
 /*
- * TLB miss handlers temorary stores
+ * TLB miss handlers temporary stores
  */
 #ifdef CONFIG_OPENRISC_HAVE_SHADOW_GPRS
 #define EXCEPTION_STORE_GPR2		l.mtspr r0,r2,SPR_SHADOW_GPR(2)
@@ -194,7 +194,7 @@
  *
  * PRMS: handler	- a function to jump to. it has to save the
  *			remaining registers to kernel stack, call
- *			appropriate arch-independant exception handler
+ *			appropriate arch-independent exception handler
  *			and finaly jump to ret_from_except
  *
  * PREQ: unchanged state from the time exception happened
-- 
2.48.1

