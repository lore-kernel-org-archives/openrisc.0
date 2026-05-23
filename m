Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458EC1B87C9
	for <linux-openrisc@vger.kernel.org>; Sat, 23 May 2026 05:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779514611; cv=none; b=PjQA7HnwszbLe+yEbsjlYXfRDREfld2V7RU4lS59utVZL+NwwrvoaE2QM4jFMezVTX1QRUZKxo1r2vKp9L7479SV3wSWGWllh0shrZK3+VLoqy6PyiFkqLMYVkFy778StZAGe3p+Tl8fAfqUYoofQs6cCX3k4l+aks0ACaZbKSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779514611; c=relaxed/simple;
	bh=3HSHCZ8Q3WBJKdLqCMbDak3jV89I2zFOeB0ea3eJtIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYY/u5Jbwm6ImSkYVkaMUiGDQZwBHKLhQBsr49xxFjb2IKkPH+TwxEDPoJLLzjAorCSx5/Yd2m7xNDUueFiRqldJePEvdrMVSK22KTtw4n89PrLUssON5PQVgP3pqPe4k55jQmtOHpZPo5x5bo5afw351X9gdrW1/qY575TEVGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXPQh3sf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXPQh3sf"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49048e043e5so7363855e9.1
        for <linux-openrisc@vger.kernel.org>; Fri, 22 May 2026 22:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779514609; x=1780119409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5yHq4tCJcntUkoscwvXvYErx2Bu2LpJAc8eJsep0Cto=;
        b=gXPQh3sfxPmQ47lDRPmeUefvag0TxyxLBJpVSGoevkdszj6jB2kIN+wRrTRRt3TkIC
         C53v/ITtR0ZBvhh6u2wc9djWoDPKRt5HOKPu8yrJL9ZGi8wc/g1RU9mTgUAFIzKooIbr
         LTq9RDApVQ9nWJ+zyFWMpVIhD7QczUBFj1t435j4HEc9mx2aHeWlbfEeUikGwAPa1ctR
         AclFJQkmurOCzJBBS9VNUWFYozr3ndhcaRM/7kATJ+flbckI9RIqkxLFXT3KbTLJpFGE
         +88Ve+362+rQVzmfGlWYiJkB2yHj0tKsQhm9tPzV2mCTaF4sLdJYMKoTrHJ1JXjuewqF
         xukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779514609; x=1780119409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yHq4tCJcntUkoscwvXvYErx2Bu2LpJAc8eJsep0Cto=;
        b=FjfdIYmZGwCGPtrNHNMRTfgiwCtGODS5nwsRWzhfxg2jpYUZ/OQMrNuHQLLUSuWSov
         GlCj0Fza5onSSOeRO31sJVnVeDtrUTV8rNHJg9aCeyWaEBCno5n2CYbktFgAlK8c89wi
         uretE7HGirf4R2MO9IjeMmU9h/SkfaFUbBsdiPFBGwrbbWxgDSyO2wS576OJeFjKl86D
         o5wkKHQylaammUNhEf2B4sG12e/zg6ldU6R/b4CMejhKgG+YTM6ySsaANs0ZLiw/kYH0
         rRK1RkyXj9+rFX+C55fwhvzV8ZmQ5HjP0NR606Gmcy3jg1fYWYP8PTrMtU4U+CU6QaNr
         mw4Q==
X-Gm-Message-State: AOJu0YwjSeBibYvf+O54rgvjZ9NNxFSQ1PC4YPCXVmQ2o+zu33adLCvr
	aF+Y1ybgfURLzdN1rF7UKH8Cbe/OHR6lK46U1EpQiG9yfCblaDNVScptMHj1pw==
X-Gm-Gg: Acq92OGT3eVLHvmZCw/o7mRYOkU2u+b4DdFEKgADpTxTG5yl++3kXW8biGISblaabEI
	2JeUpu1/4z4sp45ko+qlvUKL8gI9apfABc0oYfREfkDcllD/UXsr4vbhpVDSgMnvcY0f4JLf8BF
	eebded6MefTYrWPPUJaye+KD9l+9KDvSHBLBMox/czO49Facpg+OthHlng35HUq7i/pwv5fPUH/
	dClDVS0J4Q7c/JccnK9nje+UCvnPtI/mGZ1kv4SswmcJ01MOa1YHFEPDBEXPN8gRKQs5BuZ+xh8
	cpF0i3Gj1jDqNJJwgeZ/GhJwM9KUJzBmSbLUGOaQXSHpTXfLFmyu+D7hb9SH6GhtnAlAQPDpC+j
	ERdqUjINijbg5/WCYWXKc+fxbTRdDHEvM87jwhjBSzZKOvD9xGJ4e2JZust2IDrMIhl0BPCSswQ
	aQuurWCUckqJPGQgaIYN+8wh/jRyFatgaeQHLIJyzL9UafP5XyecuTn/OZMYnZX1f/pTTRlEL3y
	+Qrxw==
X-Received: by 2002:a05:600c:8217:b0:490:51e9:deba with SMTP id 5b1f17b1804b1-49051e9e233mr12874215e9.27.1779514608454;
        Fri, 22 May 2026 22:36:48 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454ea134sm103216805e9.8.2026.05.22.22.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:36:47 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH 0/3] OpenRISC Fixes for jump_label SMP Syncing
Date: Sat, 23 May 2026 06:36:15 +0100
Message-ID: <20260523053624.630443-1-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On OpenRISC I noticed our jump_label implementation based on arm64 uses
kick_all_cpus_sync() to force remote cores to pick up static_key updates.  The
call to kick_all_cpus_sync() on OpenRISC does run IPIs on remote cores, but it
does not have any guarantees about instruction cache invalidation.

The jump_label code seems to work fine and passes tests, but I had suspicions
that this was incorrect.  My suspicion was correct, and I was able to reproduce
issues where static_keys on remote cores were left stale after jump_label
updates using a custom test [0].

This series fixes the issues by triggering remote icache invalidation after
jump_label text patching is done.

[0] https://github.com/stffrdhrn/or1k-utils/tree/master/tests/smp_static_key_test

Stafford Horne (3):
  openrisc: Cache invalidation cleanup
  openrisc: Add full instruction cache invalidate functions
  openrisc: Fix jump_label smp syncing

 arch/openrisc/include/asm/cacheflush.h |  4 ++++
 arch/openrisc/kernel/head.S            | 10 ----------
 arch/openrisc/kernel/jump_label.c      |  2 +-
 arch/openrisc/kernel/patching.c        |  3 +++
 arch/openrisc/kernel/smp.c             | 21 +++++++++++++++++++++
 arch/openrisc/mm/cache.c               | 16 ++++++++++++++++
 6 files changed, 45 insertions(+), 11 deletions(-)

-- 
2.53.0

