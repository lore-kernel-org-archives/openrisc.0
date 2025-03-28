Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAB81531C5;
	Fri, 28 Mar 2025 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743193608; cv=none; b=Hve/TkW7XHtUeE0Klh34BTMNNViUy7Ifg5WO1x7L5NkEE3i8xTdGWkEYyRRLUXBUCysS3tf1iyZ9QllvSoL2hFUoW4+zzvJcBvFCxOlu/XUt86LcffoPNadZCR3FfRhG08p1kfZ/ruZiWjSQw3/1NR28a6JOm3NhBURyUx3tc3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743193608; c=relaxed/simple;
	bh=FPs8gZwoE+X2cYpEh3+/cNSxQGnBqdQHiDqfIAFYu+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DIt1gDYWYdIlqnpTZN5l3QpCM2olr8d6HsOo+sTNa2Vz6HOVVWH/imEtEtJ2VXfJSOLKwBKXQUpfdOE/dP1OWyR3ZYiHwOb9EehAHJqjmjY+sWiicjn4jnOKa1j+sz4WYrpMvGoVVbRJ71OCNKQjAGN36R9taIztaGzSJ6HZA1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXLxkjc0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXLxkjc0"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso3454992a91.3;
        Fri, 28 Mar 2025 13:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743193606; x=1743798406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vu0m5qILV0MBBFjaYAFvxbD27OR1ndhcOefOD27j3Ss=;
        b=MXLxkjc08hke6Gce4zwD7tRlt1bgKzoutoG+roak5pJ+iFYFop7U03SMs1JD/mp559
         HpRNVLzh4INaewLKM60XQqex53LcJl/+TuArg0+WqFkjJbzCM6xhGV+KfA6CnHA6qU2N
         G8mZFkyZt7ikIDc4AcGTA1YnIkI3DVCnD784uFMi4Mwy8wdGFsm/vxW3TPGwx//ZouG9
         VbsXyq1z4vaK1cjRBvUBf7MlNBzCvBEi56o+SJ2jGkqx9xUBnHTG7vXsaYvUwuzSpgIj
         UTzL1FvB7DxMR/6wVZKyFYsQ3zoB7jHysrqH2cA+NQLOBH7ds27RDBbUjCYzClQSEFuO
         MqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743193606; x=1743798406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vu0m5qILV0MBBFjaYAFvxbD27OR1ndhcOefOD27j3Ss=;
        b=RWwQoujy/JjfGFmHnRzp573ORES5bXXH706kg+gnx31WyL3BEv8AH0GHIDYshxRaaW
         XwfMPt62o7W1p9hzfVih0cgaGRYacejhSx4DGejlPjuZsuoq9rsMvhWh8gPGllRRTl06
         dogemCfBommDdbGpzLegg71dYB5ISYKYZDzRiNihn750A1BbLeJTAScEKAOENZbk09ui
         siHBmo29IseQls5L1WkTTLeJx2nW5q/PiXsa9LSb81JV2gxx6z7Oq+pXztx6yy73YeWf
         yCh0ZiCOFx8Vo0K3SEtk9aYkxBpUYmVfSY4Vw4QPntWRVN8u3ui2pQWeVZt6NDfBgsjf
         TSrg==
X-Forwarded-Encrypted: i=1; AJvYcCVzE0CUjixhmxttTVccveJU7GyfhfSrwdsuPHkWf9NnGnTIUWZqfqfJ2q4cGRVIKStWkUB8WrteMP0ug9A=@vger.kernel.org, AJvYcCXyF3gnC19TWF8nAB/sCIvstpNrKK2aq27OSOCnSsjcE91iJpgbcDqtkPbmziJMcKGrqewOC8pF3eofcKxQFIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKBlr3tBkdRL4U8MkCX9IFoMv3o6k+fcBjW9o8j5hpZC6vOQeg
	2OC/QzyciYQnkKZlyuNzgiBMdM+1KRh/2vkRcohFQOHZlhkHTRph
X-Gm-Gg: ASbGncs14XJK/tabLmb2lzXldvekcCx14QDlqRfVVSTzlolBETaRJ9WAa+brcYsWa9Q
	qwZyRf1YDmVxFpai+YSgYcXkn3rfJGXT6O1j6boeG/SKwATX1hdjQUNeqDAbWD2MPCtXMrABUvI
	B50VUaU/y+j/bo4VNsyxd+SwNHUn0fMLmNQIcJfzvl/X4ICfAAxQZYufQbPxiUyLD0By/YxEbp1
	aJpqTlri/bFb1oYY2RKJx4/lLOnWLaFRgntXVbxfdDk03ypnsWWT11HiXLLeSDcK4rki2PIfzj1
	R1h8Z92fu5lwuDuELvlVap7fZob15vX6tWOZWKQ=
X-Google-Smtp-Source: AGHT+IGDnJAqO2rmyDdZtvD6K93mzUOLV/R0IUPTqKjW1dt3vpiQd1sutEld6RzW3ozIeYicwSQ6NA==
X-Received: by 2002:a17:90b:1dd0:b0:2ff:7b28:a51a with SMTP id 98e67ed59e1d1-305320b171cmr1129480a91.17.1743193600986;
        Fri, 28 Mar 2025 13:26:40 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30516d62c57sm2358889a91.28.2025.03.28.13.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 13:26:40 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: sahilcdq@proton.me,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] openrisc: Add cacheinfo support and introduce new utility functions
Date: Sat, 29 Mar 2025 01:56:29 +0530
Message-ID: <20250328202632.72809-1-sahilcdq@proton.me>
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

Patch #1 removes duplication of cache-related data members in struct
cpuinfo_or1k.

Patch #2 introduces several utility functions. One set of functions is
used to check if the cache components and SPRs exist before attempting
to use them. The other set provides a convenient interface to flush or
invalidate a range of cache blocks.

This version addresses review comments posted in response to v3. In
commit #2, I chose not to make "cache_loop_page()" inline after reading
point 15 in the coding style doc [1]. Let me know if it should be made
inline.

Thanks,
Sahil

[1] https://www.kernel.org/doc/html/latest/process/coding-style.html

Sahil Siddiq (3):
  openrisc: Refactor struct cpuinfo_or1k to reduce duplication
  openrisc: Introduce new utility functions to flush and invalidate
    caches
  openrisc: Add cacheinfo support

 arch/openrisc/include/asm/cacheflush.h |  17 ++++
 arch/openrisc/include/asm/cpuinfo.h    |  31 ++++++--
 arch/openrisc/kernel/Makefile          |   2 +-
 arch/openrisc/kernel/cacheinfo.c       | 104 +++++++++++++++++++++++++
 arch/openrisc/kernel/dma.c             |  18 +----
 arch/openrisc/kernel/setup.c           |  45 +----------
 arch/openrisc/mm/cache.c               |  87 +++++++++++++++++++--
 arch/openrisc/mm/init.c                |   5 +-
 8 files changed, 235 insertions(+), 74 deletions(-)
 create mode 100644 arch/openrisc/kernel/cacheinfo.c


base-commit: ea1413e5b53a8dd4fa7675edb23cdf828bbdce1e
-- 
2.48.1

