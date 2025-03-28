Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2018F49
	for <linux-openrisc@vger.kernel.org>; Fri, 28 Mar 2025 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743156576; cv=none; b=WFtp8tRM5DWnwhQwk8MGxM4dKaO5lUGvp7mwzb+1un7ngPlL84ctcXa0od150sJvfmX/hT+pN8ACkUb45/D8GO6Q6pYT3FuWGg6/Y0zQNCUkY8UmKsewjyg+ZmUcSnE1M8LSkj4kcjNuth+uxScQoJPqFwUhVXheDL+Azb/j5Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743156576; c=relaxed/simple;
	bh=673GPIK0VMmlJabWvL/jVOEoLXBRcNGDNHK8MvO9sd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oKXlhyFao8YFYAoAHnnvZRNR7j3+aQ25nDAy8XCZD+XUsdtDF5hP4gt1Dcc1UHBiqa8y1K/cpJjS4tsoqSRPFsQmQ5mIas9o4iPIt3+xa4AMrw3inzRFCf66gVjOuMBp6ozBQR/nnipvf2UDQzUWIhvHMMP1vB7+WOFaYHiLVzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecs6zZxi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecs6zZxi"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso14984745e9.2
        for <linux-openrisc@vger.kernel.org>; Fri, 28 Mar 2025 03:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743156573; x=1743761373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IODo1Pi6Vh6JvVtdGiyNXNlRTPaPT5/nRAGROAUkPPI=;
        b=ecs6zZxi5rDzZhjH/KI6x/8ujDnkL8DrPACBzE6gfEtUcg2mmkEmuL67rMz5XtKNcR
         D9el7Adyec19SSPtPwrYs/TWeuWVccJUbeUWrnrJ4cIHmF2haKoAIWZQ2tUih3H04wmI
         jXs2R17DVQ0M5XI0EvB+5yDBhWWo3CqXoBf+Nwo+iZZE1oUabha1r1Knf0GsZciMEbyz
         meYUxhEkX0ZOG1BiJrDUkLsfmsg5lJleWEvZkXcauK/4z3m+1nDkwbe1yz2ItW0UjASl
         3Rb7FYXqO2qJ4FFk1w02fHkdSqjd4pIW4V9oX1mH2x3+9LcLvI9HzxE8jSsp9XzUVBjX
         /HcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743156573; x=1743761373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IODo1Pi6Vh6JvVtdGiyNXNlRTPaPT5/nRAGROAUkPPI=;
        b=uFCqWfsT+fRFiv/btNlw3KfGzjpvQW0LIzLhnKbyKykry8U86Mr8SHxyA9JwHWsw7H
         IojArU3EhjROoSngpWNWfsHrnTxOWuwZtwqc7y9M9e8LonLOHlGsuUNp53oYJw8D2qB3
         jl9jeIAIqPfKm+kpmVk2yvx5CSyBbE6PtW/fPZZqu5INtpGV9RjUsp8qzQ8k/htT/5mO
         7lmOTE75cIDV8CbZxZM4PJSnrx9X3YFTDWS4dhotiIXLrPLfOUqT1HKv+MvmWcSMf+ly
         dEey74A6DYEJ3X3Pngk85w5RyGPJW9Cm/kTxw4CFHHdc5qZX95Nh0Azyc/w4hi5rqi0V
         K5Mg==
X-Gm-Message-State: AOJu0Yx4RDcQPG+uCzDUizeadR04XDOYKp9qvEBmoibPWygXTMURtG/p
	+oqSOmMwNv4cA1IowzUAEVfxZhAkcyqQIbjnmhBd6zi7TG+HEAswiFuk9A==
X-Gm-Gg: ASbGncsycWnYGVA3xq8oaaJ5oTI0/87gzYiLv+v21NqYHCSqRc+TClOTy9wVg3L87DF
	hbgsZ4iOVoqf6ECXAGGxwr3ZLuQaRehJhBCgoLOSeVd9Ag/shpS/r8bS10Zu1X5ttZPb4UrfIdu
	SO7kD59yvHYxnBsr9rJIsQouFttXHqwqL2hR42c40aJPZeesTZfCG4QmnEwW1uu3P1q2tdh7czc
	fqvQNVz2xW4OY0yKWHVm6KcVNEC8U+aj+0Bevhe1r4/rxbvh/saBu08ZUvuJgvYQ3B/d51DH+xB
	YWI4lv3iVQBL3LZoDUv/iDgDBz7t9Mm3sfM2RxJEJERT6ZZqqmGgIGBBWET5ojzPhkxGt7vIIIA
	Mh7PRDLsQ
X-Google-Smtp-Source: AGHT+IHo1Wd35NDNmyyFJGwXDPjSK4Brhf+c4ZOidGtst0X/o9JUOokcMLW/XvlT347VXEZVZLD2cA==
X-Received: by 2002:a05:600c:190b:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-43d84f9a086mr65151145e9.10.1743156572826;
        Fri, 28 Mar 2025 03:09:32 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8fcd78bdsm22108965e9.24.2025.03.28.03.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 03:09:30 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: Newlib <newlib@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH] or1k: Fix compilation for __OR1K_MULTICORE__ builds
Date: Fri, 28 Mar 2025 10:09:27 +0000
Message-ID: <20250328100927.2184243-1-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When building newlib for multicore environments we specify __OR1K_MULTICORE__
which switches the build to allocate one struct _or1k_reent per CPU
dynamiocally.

This was using a strange definition of (*_or1k_reent)[], and causing
the following compiler error:

    ./gnu-toolchain/newlib/libgloss/or1k/impure.c: In function ‘_or1k_reent_init’:
    ./gnu-toolchain/newlib/libgloss/or1k/impure.c:121:21: error: assignment to ‘struct ..
      121 |         _or1k_reent = (struct _or1k_reent*) _sbrk_r(0, memsize);
	  |

Fix this compiler error by changing the or1k_reent definition to a pointer
to structs.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 libgloss/or1k/impure.c         | 2 +-
 libgloss/or1k/or1k-internals.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libgloss/or1k/impure.c b/libgloss/or1k/impure.c
index e94fd637c..7780c9170 100644
--- a/libgloss/or1k/impure.c
+++ b/libgloss/or1k/impure.c
@@ -108,7 +108,7 @@ _or1k_libc_getreent(void) {
 }
 
 #ifdef __OR1K_MULTICORE__
-struct _or1k_reent (*_or1k_reent)[];
+struct _or1k_reent *_or1k_reent;
 #else
 struct _or1k_reent _or1k_reent;
 #endif
diff --git a/libgloss/or1k/or1k-internals.h b/libgloss/or1k/or1k-internals.h
index 3aabdb05d..d92c16699 100644
--- a/libgloss/or1k/or1k-internals.h
+++ b/libgloss/or1k/or1k-internals.h
@@ -55,8 +55,8 @@ struct _or1k_reent {
 
 
 #ifdef __OR1K_MULTICORE__
-extern struct _or1k_reent (*_or1k_reent)[];
-#define OR1K_REENT (*_or1k_reent)[or1k_coreid()]
+extern struct _or1k_reent *_or1k_reent;
+#define OR1K_REENT _or1k_reent[or1k_coreid()]
 #else
 extern struct _or1k_reent _or1k_reent;
 #define OR1K_REENT _or1k_reent
-- 
2.47.0

