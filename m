Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E7518FDDB;
	Sun, 23 Mar 2025 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742759785; cv=none; b=OMgZZm1wbEFmRyZgsQQEF0SlECZK73v3O4YRs6cxe/OwEQ0n/I4M+Vy/vkCEQX8sV5dQ+fzfCPd+mz+SDJ//d4Ef38YIUezptpusdqwFSSpGrc4ATPVTPgTZP/eqlyb9IO80Q8fdtZbKd5FjcHAYLJp70rJaF3CJQcnCCdczMWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742759785; c=relaxed/simple;
	bh=ey12okA1mBGR/d4YXKhEOkYPeZoG2SJ1wv1StOplzk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OBBboDzqb2kXr6kuYhyk37nXms/TTURsub+L+eaQAJ39tR7l2E1JOxUzI98prrRFbBMeajTJKPBmVI5DBF+5aNh/6vL0hkLP6SkCHq2kQtGHqZ9Ex7nLJabuLzI6Rnm6sXNs709h0gr6hdUvoGl7xGKgOl3ROOlD7MNCo6QtQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mn4u43Dt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mn4u43Dt"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2235189adaeso65268195ad.0;
        Sun, 23 Mar 2025 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742759783; x=1743364583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JbGhHXiz+yHWIRS0J0HaRJdz3b6Z6Xt88OXocCfW5PU=;
        b=mn4u43Dt+7CGSlfJAjyGPmu+0KFidVa7vyFIBL0+2P8qrxA4EbEQos3ZjJ5PHPTblr
         VxNxn1qj8e6G3G+s6t7o8Wb6L7PHsbfRtK3WncZjgRSFG+pZLdfTwpKM0sCG+UekbOyD
         G68+GoSLcNVEWcRP304X02ooLDTCK/IQIdAzFFuwI6CxYM9s5DVLS5xG+qGz6PJI3Y8r
         e6DazmxCNbPBr/Ukk1wb1hrEjxPpMrBDk6Ds8Qkh+zaEkYgpfsqSF3rIvx7xFz+O6ddB
         E9lYX8iZmVx64pRTRjn1LIfhlcd+BV8TWx2MQR1nMwTsanHHElwmjzaOTICAh62ta7Zi
         DWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742759783; x=1743364583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbGhHXiz+yHWIRS0J0HaRJdz3b6Z6Xt88OXocCfW5PU=;
        b=iRqjuYJZsjoKvIHHOwUrOrLgzRs82/WHyehRc7eeLdwrAWfjw7p7tVRAJmOPjXi9ZR
         ljcDaymkhA/19tf0IPe5Za1mSOySe4SHDZ9OC81upJxo+cPzLyQOJybSFeaaYhqNIAZ+
         f49dE8+gkM/q48ADy2oe/lbNzrAvKYSsJeHG4tHgoXYyIf1bJ+LHAmORMRFOmQsAGt2C
         3ka+8pI1zJAVBUj3EQepjG7gN6v4RV5Rr82kAFd3k83N2jmBYD90h99mMUFKJdrX10Ys
         Pf1B0xbLrNVT4d3kvPZINkCjMjgM4S39YSPZdxP9pUzdwcvc108vC7Yrbv5QrlMqTFUx
         LsNw==
X-Forwarded-Encrypted: i=1; AJvYcCX2r5/BqrifsRCeNLTfK4anhd0cXLXoinmimg/bf9APpvylx8wo8bL2RamLeiI/7/Hbqr7FPC/g+J9WL+YfFeQ=@vger.kernel.org, AJvYcCX9q+9Y7Hk2JbMIhkFdicU4h2fE2bC+rQIiLUoQs/TjjWyTAA4MID7SHv0N5mllMhxmi/zfz4rrRdDgWac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1bMJnZgoIeC3+8Q2SwAqVNa93TijqJpAfkF0JeZBX5hTBgW3T
	DkpX1+iUmYtUQFO2hLo7fAUfxFPnjKgKcX9gEhRQICzHLZ23FCKVg5CXrg==
X-Gm-Gg: ASbGnctiLpsgTFq3yDHPNoC/DLnaQzffqsyCnASMnIsE8oNlfXb6hYohxleIVUP3LPz
	zK2v7lZ4I2F6959mzMOBykllUcNnCdYjrWqa9ksvpHq6SY3NPe+GjJHDOeFL7I5GhAL6ld+bzF3
	+yp5dvFUKC3x8q+xtvt3qVNqMSwW6ouu+SC9L1mgBy7ZVAWP+D0MWdxZ0bWZPGoWu5owj/rvu9N
	BPeMWemy+Ngmh3dpH/2Ekfc8iCn42hHBHbqERfrnpAZKEPonzSFCrfPRZT1QSCqTg4+6RYgDq7F
	/DieTXIlNTrrGdeMVc8WIhhGmziojj6847zaYA0=
X-Google-Smtp-Source: AGHT+IE1DC/rUzdOEmLzwlBnU4oTbHFF3XfpS02WKPUbUuyKbHJWmnEJ8ufDgLK4oBhhtQqAIr4k2g==
X-Received: by 2002:a17:902:d9d0:b0:21f:6d63:6f4f with SMTP id d9443c01a7336-2265e67fa37mr180147865ad.2.1742759782757;
        Sun, 23 Mar 2025 12:56:22 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c45:ad2a:889a:b085:dc4f:7d7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f5047csm55582875ad.99.2025.03.23.12.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 12:56:22 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: sahilcdq@proton.me,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] openrisc: Add cacheinfo support and introduce new utility functions
Date: Mon, 24 Mar 2025 01:25:41 +0530
Message-ID: <20250323195544.152948-1-sahilcdq@proton.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch series is substantially different from the previous two
versions. I have split the previous versions into 3 patches as follows:
1. Refactor struct cpuinfo_or1k.
2. Introduce new utility functions and check existence of cache
   components.
3. Add cacheinfo support.

The main purpose of this series is to expose CPU cache attributes for
OpenRISC in sysfs using the cacheinfo API. The core implementation
to achieve this is in patch #3. Patch #1 and #2 add certain enhancements
to simplify the implementation of cacheinfo support.

Patch #1 removes duplication of cache-related data members in struct
cpuinfo_or1k.

Patch #2 introduces several utility functions. One set of functions is
used to check if the cache components and SPRs exist before attempting
to use them. The other set provides a convenient interface to flush or
invalidate a range of cache blocks.

Thanks,
Sahil

Sahil Siddiq (3):
  openrisc: Refactor struct cpuinfo_or1k to reduce duplication
  openrisc: Introduce new utility functions to flush and invalidate
    caches
  openrisc: Add cacheinfo support

 arch/openrisc/include/asm/cacheflush.h |  17 ++++
 arch/openrisc/include/asm/cpuinfo.h    |  58 ++++++++++++--
 arch/openrisc/kernel/Makefile          |   2 +-
 arch/openrisc/kernel/cacheinfo.c       | 104 +++++++++++++++++++++++++
 arch/openrisc/kernel/dma.c             |  18 +----
 arch/openrisc/kernel/setup.c           |  39 ----------
 arch/openrisc/mm/cache.c               |  52 +++++++++++--
 arch/openrisc/mm/init.c                |   5 +-
 8 files changed, 224 insertions(+), 71 deletions(-)
 create mode 100644 arch/openrisc/kernel/cacheinfo.c


base-commit: ea1413e5b53a8dd4fa7675edb23cdf828bbdce1e
-- 
2.48.1

