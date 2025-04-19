Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016BC78F30;
	Sat, 19 Apr 2025 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745077731; cv=none; b=pYypIdzcWpWk4GoFR8hylRhS6MlILSiOPsnrZyyrauFxXsof2rPHdfGHwy8ieQXv6ZYNvIhZF2stZ6nsFaiV3VVqjOQxZq/QROKkt7/Tmv15maLp2vowmIVkTU7A9nNnZPD2lBlijL/PUBdCrMAHBx4WahqxM+1aiwFR79IF1U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745077731; c=relaxed/simple;
	bh=nVreUzZT/ZCyCOUBM2MnNq8SkTx4mGUDQJ6XZoobqpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XgriS9+0g/RCetKCcnAIAFPSvrDxzphCCM1+Gm4fgFhnT2UkhcQ8Q1qzHuHvZtd52krzJfyrX2R6OYDV0bmut41N4ODm6Et2uYF3ldr2Brr4sK7LDZUau4PT1eLDcAxpB54TrYCMKt1z5EW66eP0HfD3HPKmbm3q6gIOsn9SaYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UK8ivAr1; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UK8ivAr1"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7370a2d1981so2250482b3a.2;
        Sat, 19 Apr 2025 08:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745077729; x=1745682529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lN/OhSLKgem6xUfA74KqwNX7jjY+v/yYMY/uZ9dnJks=;
        b=UK8ivAr1OIW9RvN2EXbJ54ti26pVetYNr7V0hln8F1s+F/sWThnw0EuK2BQ0eXVBet
         eAJ0MA7cruvai5aMi352Gqhkha0teEHbeMxByRnWuBUenJO02s/ivy0l17klMncdn+rs
         eIU/ck4F3It2Zl2uKLN7SePmTlEaOObQxwSzMLtlBllQecI5iPPbgfStQ6dgBOUhr8qI
         wiriYlP5JJ2eH1HatCXLaNlueXuVfzpABpyePXinZ5a5lG+Kx0L4hPW2q6xFEDHEiieF
         AgEpCFiPSwi8G2GpOKIurhYACdrC+i/YvT7eGSEOR70fXKDs0p+vajZll8BAttLGRKxE
         RLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745077729; x=1745682529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lN/OhSLKgem6xUfA74KqwNX7jjY+v/yYMY/uZ9dnJks=;
        b=E14sbWBu4K5zUyW4L4qdmtj2h0hyD/zYvw9NIIqqtHUyTHnICX40V3LUjJVj4BbT22
         xPNV0i9mV6R/8dhnjuaHvoIs1kyE65KDpMJ1o1G1+SJbBgqExNB2yqsvKhWYRPdaQ9U0
         n9grEUX+7Xllr/hZh8xbSRbWIIwiMRw+VyqyGSsnzJJASr9at569kyW6mApOCFoql3ar
         aXDaTvKCvNAHdt1tMvbNXE+c1W9FnOY0PGasrdnqp1r/Zj7f8k94O6CI+foe2xoWIDMQ
         UPZGgVQwK7jIYP57gAZAQeRFWDq3MLZKciZ+DnM2UzZpCrdJ9JAQLD4itNZy1pCIVv7u
         zjZA==
X-Forwarded-Encrypted: i=1; AJvYcCUsHh6fsB+dgLj5nnB1BBH0Wp5pBfCfBBPRJLHWqnb4UL5hjTbvdwX29/U5BsVRGvoRNRcql3Iz4gpw4sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgmuFWQagi3s9WDQHj3HIZYcHCeLM6RJ3O2f0QvqaJusWqwjJQ
	4AOKAYLvai8IrxSf+KvSV2M6k0jyfY6yG8zEWsvOjrXdU7+Xa3jUrMogfuDm
X-Gm-Gg: ASbGncugldbtJMqP/NR7ZP/AAAzqmHILxqrwxrhTK5pXp80PFmBNysKSabiwRZbddEE
	Mi6AP+uQ0brAEwo3Qk7VCwwKCbG0AOVJDlIUD30FM3k2nI7/46FQLl5b/5m05dLsxTlpnyS9JK8
	XUhsYcGh5cpc16rNV0RiaNUGlnomMDgj+2kr4z94coJoDy7NPqU3qbuUHJr0kl2Wc7D7Mbdfe58
	pKFPV2CVqFKjAmtmypp2U636/ZTgfKLVc/iomAkRrCJiTS80rJLoAlSJhWVJ6XYkuL3pbCQdfkg
	n/UMSIn2rHBfG+HZr9YOnOqOOSSlESzNaUBR
X-Google-Smtp-Source: AGHT+IG3bWPll+jBQM73z1sLmhDzeJ8FQuuTzTHYN7HBwqeA9z385xk8JgiFB60CbXyw+wSoTFHihw==
X-Received: by 2002:a05:6a00:3911:b0:736:491b:536d with SMTP id d2e1a72fcca58-73dc1610c96mr9449435b3a.20.1745077729098;
        Sat, 19 Apr 2025 08:48:49 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c45:45a3:affe:4635:b6b6:1a76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaad42fsm3430658b3a.121.2025.04.19.08.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 08:48:48 -0700 (PDT)
From: Sahil Siddiq <sahilcdq0@gmail.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sahil Siddiq <sahilcdq0@gmail.com>
Subject: [PATCH v6 0/3] openrisc: Add cacheinfo support and introduce new utility functions
Date: Sat, 19 Apr 2025 21:18:16 +0530
Message-ID: <20250419154819.85063-1-sahilcdq0@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The main purpose of this series is to expose CPU cache attributes for
OpenRISC in sysfs using the cacheinfo API. The core implementation
to achieve this is in patch #3. Patch #1 and #2 add certain enhancements
to simplify the implementation of cacheinfo support.

The difference between this patch series and the previous version [1] is
minor. The email address used in 'From' and 'signed-off-by' are now the
same so checkpatch does not throw a FROM_SIGN_OFF_MISMATCH warning.

The patch also addresses a build warning that was caught by the kernel
test robot [2] and addressed in a standalone patch earlier [3].

Thanks,
Sahil

[1] https://lore.kernel.org/openrisc/564042d9-0645-4a0d-aac8-383b0c699b49@gmail.com/T/#m67aed7737e79675352815470cd1e3b9ed6814b05
[2] https://lore.kernel.org/openrisc/20250323195544.152948-1-sahilcdq@proton.me/T/#md4b867e8d721f8894368ddc209875e262c1e2b60
[3] https://lore.kernel.org/openrisc/aAMwri9RK2oNuC_p@antec/T/#mc42cafae92957171cef94065f25257e5bed37ed6

Sahil Siddiq (3):
  openrisc: Refactor struct cpuinfo_or1k to reduce duplication
  openrisc: Introduce new utility functions to flush and invalidate
    caches
  openrisc: Add cacheinfo support

 arch/openrisc/include/asm/cacheflush.h |  17 ++++
 arch/openrisc/include/asm/cpuinfo.h    |  24 ++++--
 arch/openrisc/kernel/Makefile          |   2 +-
 arch/openrisc/kernel/cacheinfo.c       | 104 +++++++++++++++++++++++++
 arch/openrisc/kernel/dma.c             |  18 +----
 arch/openrisc/kernel/setup.c           |  45 +----------
 arch/openrisc/mm/cache.c               |  56 ++++++++++---
 arch/openrisc/mm/init.c                |   5 +-
 8 files changed, 196 insertions(+), 75 deletions(-)
 create mode 100644 arch/openrisc/kernel/cacheinfo.c


base-commit: 183601b78a9b1c3da2b59f2bee915f97ba745c0b
prerequisite-patch-id: 3ec7c4c93dc2780c9978de0775bf46ae43c00b83
prerequisite-patch-id: 0b455477c75ef34d81032b9419d8ad3d5e74043d
-- 
2.48.1

