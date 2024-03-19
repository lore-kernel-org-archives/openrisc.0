Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90674EB55
	for <linux-openrisc@vger.kernel.org>; Tue, 19 Mar 2024 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710884579; cv=none; b=gtUKeGHDg/QGU+QWrwakXfPGQZhQ9koljFwYp6aT0FAukaDVabq/TV38yxm+aK9M1bcScNzf5vBYaNGILh3+iWejCh+UiFiS8ZzGQ6E2S5U+kgBX7wj+EcWsB9M/Ruu0dR+BHWgdp7kCqtxlQNDxY1Jw+oEDoILexDyw3AAbB2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710884579; c=relaxed/simple;
	bh=9vm67h6z2zNPIDrHUWgEByQkFwcbMgGgzD38RVAwz08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bisfSvUMHeIwWb20iW5MUpDHNxGW245dCrfGWkRDmgEy7vbr6RpS8SSLRvgURnQ444rKEZ4ZbvsUKD5SL+5HkTWWPbcNdj+x09oUAe6Vyv5YABL5jWazCy2bvs9Ik9rjJa6zT2ORTZKClPiZYII80BJ7GMZQYhxt2gqsZaunVG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwbZsjPr; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwbZsjPr"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d475b6609eso77723801fa.2
        for <linux-openrisc@vger.kernel.org>; Tue, 19 Mar 2024 14:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710884576; x=1711489376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z9qLOgTMYvVX0wXoZxk7qct+eKNn8JwO/lREqZCH6s=;
        b=KwbZsjPrs+x13GDBV7ixoJ9MEtm1YHM5+Dj0qhdOqSBCZFPCllHB/eYlJH6BszOl4f
         ECi3R/t+LoMs6P168Slxe4fqS+pvlECE/s4L12faN48Hd9MxKl4Y67b1pkuAJoJ7J75N
         gwT1bC44v9szCkLHSqNgRSnNYfK7bcQJ3FFsnakxteeqENcuiI24z+D4TdshYEpNlTK4
         KTUDr3GlrPxKe0RdAt8DqHTUeWbi3wLiRBe+m53uCb4w9xSNxzyyUwpePkqsPGh4vS74
         HQUFseMQhyftT+3n3SSZYYLFIhKHPSKysj1+zoTH4bbc70yWZMW9WGAvGZBmUkZ2Ho/l
         LLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710884576; x=1711489376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z9qLOgTMYvVX0wXoZxk7qct+eKNn8JwO/lREqZCH6s=;
        b=TGjOVYapR9WHWwRV5NommgyrFzsKlbf95OC7KAQWdzRSjKR7f7mHTrCr6HuO/1ToCX
         MqA7O9HHIw2drwQp+IUDcm1g/u8OiQ/wgFnycrxHNkvV0AA9Y9hCfFprvOyfJ2CEDcck
         XZAZhTN1IIdea1Z1YwouR/qotUMWbgvHnb3g4mddSnGqw77aHjEQuP5a1iEgLMRnFF2u
         jz9SQ9Tz5cVKVSl2KWBKc68DJfkOjrcHkAcWZ0FoHRzgoHAaB2WYpAO7HnYN3uqHatgF
         CSRLq7WHmEM/gTRMbGtDx2eflUAD/1Kd3OBxYbqM5ny8Sly/s7WC41ohdq3NDhCkqLgi
         RWzA==
X-Gm-Message-State: AOJu0YwlxKlD8kWtz5rRnhsXfXurJuwMT1SLQBNQNzVe/XTWkF4xaiGy
	ZygVqbuerLVt/K+buD5Naq6L0n1/CkZY8EgwNzYMi5I49BwszQSZ
X-Google-Smtp-Source: AGHT+IHNv0UB0RRLVsaSeaiS0h3QlgYQpvcQZPkH8mzY9Wp3lcE8wSTkQcWK2XDEnkMYYaRji754Vg==
X-Received: by 2002:a2e:8518:0:b0:2d4:764f:87ea with SMTP id j24-20020a2e8518000000b002d4764f87eamr2970125lji.34.1710884575603;
        Tue, 19 Mar 2024 14:42:55 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c358b00b0041408af4b34sm107553wmq.10.2024.03.19.14.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:42:54 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH 3/4] or1k: Only define fpu rouding and exceptions with hard-float
Date: Tue, 19 Mar 2024 21:42:43 +0000
Message-ID: <20240319214244.736981-4-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319214244.736981-1-shorne@gmail.com>
References: <20240319214244.736981-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test failure:

  math/test-fenv

If rounding mode and exception macros are defined then the fenv tests
run and always fail.  This patch adds an ifdef using the
__or1k_hard_float__ macro provided by gcc to avoid defining these fenv
macros when they cnnot be used.  This is similar to what is done in csky.

Note, I will post the or1k hard-float support soon. So, I prefer to
leave the hard-float bits here for now.
---
 sysdeps/or1k/bits/fenv.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sysdeps/or1k/bits/fenv.h b/sysdeps/or1k/bits/fenv.h
index 587039ca03..01267805e6 100644
--- a/sysdeps/or1k/bits/fenv.h
+++ b/sysdeps/or1k/bits/fenv.h
@@ -21,6 +21,7 @@
 # error "Never use <bits/fenv.h> directly; include <fenv.h> instead."
 #endif
 
+#ifdef __or1k_hard_float__
 /* Define bits representing exceptions in the FPCSR status word.  */
 enum
   {
@@ -51,6 +52,24 @@ enum
 #define FE_UPWARD     (0x2 << 1)
 #define FE_DOWNWARD   (0x3 << 1)
 
+#else
+
+/* In the soft-float case only rounding to nearest is supported, with
+   no exceptions.  */
+
+enum
+  {
+    __FE_UNDEFINED = -1,
+
+    FE_TONEAREST =
+# define FE_TONEAREST	0x0
+      FE_TONEAREST
+  };
+
+# define FE_ALL_EXCEPT 0
+
+#endif /* __or1k_hard_float__ */
+
 /* Type representing exception flags.  */
 typedef unsigned int fexcept_t;
 
-- 
2.44.0

