Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79003597B;
	Sat, 29 Mar 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743241608; cv=none; b=tPE15PyWcJbinn+gcV550KGiBnqldBN70E1773/iwnhJ6nJTtX9jhdPIMkRnx0E1mNDsRuQ2yYG0Kdali+hiTF81PiuflGc0IfuuLvPTOkwxWTLmfwAAOrGONsiuNFlUE3y9Nw7MeqHYDlkRHvoRdSJDuQqLb4m1/E1Y+TzY+2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743241608; c=relaxed/simple;
	bh=9IBKgjHb5Is3B9+bxPb031cK4VatnnNpBMSrWSHmQBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OLwlKtdl1gLPjA18WaCh6nZTDhCna2RNWZPHPfNaWibGotDxI5UBa+Lis0DaswbHtuiKbmLvyXkAzwYSkBWbVeFXI4n5JG3IFb3jCV5E9K0LyltXgDIbuMOrDrC0b7y8KEfvpEHVBAPXUGw6VJT3e/5nXpeIcBQxIK9PIQrQzbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6bKX9uG; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6bKX9uG"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-301918a4e1bso3962338a91.1;
        Sat, 29 Mar 2025 02:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743241606; x=1743846406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E8cVT6MrHSBp3j5KY0dl3WmOT89lWVd6sQvw2BMSiYs=;
        b=C6bKX9uGIdm5fsa6N7ukXYfv/kzMoYJrophlWN7DCxKxZdTALLDFksooeCu28hnMve
         rKltKQCfv0TAnJiMFpMVcTFa6lpxbS2gpnWFkAV+dG99zYWLXnnoYkn2axdOyk5pD2ey
         yRHt/Ry1Foc9IyZO+qio+rvRkZauDso7AN5I0MWfvYwLjVS2gm6Cj2X2Zd6StQ2xGTgN
         Clw12ajSbjUYTSEnAWW6NNwiYjt/aHZPJsXtC8/BtdO/w6SnTvl1LfixwAxxoYvNfztv
         L7ic3RL/5MseD1jtFHzgFNlt8GkWD0W1lvgAEr5jrBROEPDi13l0hzE/V6zf1RBy4bFz
         HAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743241606; x=1743846406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8cVT6MrHSBp3j5KY0dl3WmOT89lWVd6sQvw2BMSiYs=;
        b=tOkkAesvkMU4OAteY6PpWKN1CQpid6DwXI7RWfoS3AJCuRTVP87yRuhUhbv1kJyLJE
         WtFp1V671VCrQnh0a2EuKQc+onSvqslqT5aQul6R3rC/9OgO50OGqqI1vGSWR1B+DEQf
         uNLf0aZGQoRr+5lvEpdnum5cCr8vCJ0yVUgdBn6mj9+orBcmzxsTgQFJVvx06kgfzDR5
         QSEAfRbP+CfN/T7YzHDAV+9tH/7ylYO0p/wquhhs9mZYK5kwBqGX0CDhSy2PfTt4FqtA
         e0f5AbM+YKvua8DPZVe8FblrgRirQeGi+ef2oLsI1OneS4MNlLDWODG45n0uoixW88pW
         54fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzUgXoDR6Xx745mCpdo93bWOyTAGryTjHW0eEIFho5Kvl0TtpJT3YzBExA461Oru6YJymzIn20mx7999WEwPU=@vger.kernel.org, AJvYcCWqJKdMRIYupHBiDYFsIZy9/Wg4wa0yVNkLBYeDW35RhZj72YvVvuYTSH2U2uVteHvoHyYfFRCXISgzyOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX2cLRKFspmlIk9AH4CxSpvGy+3tndaEG4DHTTVBa7yKJdZNiB
	YC89eGoIN6u3fOqdTP0IjHfJMShefLicDBZr7gpfytgK7/cIX4S5
X-Gm-Gg: ASbGncs90Ayh7Xvc/wkROgYOvfP9h78x8ADlPtGT8WVL7MqZ6VsNCY1f7P9hk98RSJk
	Ok1nsX0ur/iVCSyh65y9taqCShbnNqvw6Y9sqfpTfPiaWwPBaz2VhpKaJUV33DIopXFdvZHm6bO
	ai9Qvq6s0xDeo6bcXZRXJB9Mb9IAHUytGwUnnAOnQsJqad0KyveaJxZZpx3gDzE7XGXiWMB6bG7
	ykLl5/dgK3Wd3bDW1po/8HbUCpmspSAeXi5ixD2za8MmD/ywNvLF2JOOrFWx55TPztTmxYeDRSO
	BgQgapHMxoVCg/CldUhEBJSZYATe3gglRuGU
X-Google-Smtp-Source: AGHT+IF6D0VFPHIcoMNsvS1v9RMN4gemfnGPhqrJWmxm+BxELzxZwdDJ6TDHWVKqUYVJgjFzJXTi0g==
X-Received: by 2002:a17:90b:48d0:b0:2ee:db8a:2a01 with SMTP id 98e67ed59e1d1-3053216198emr4162185a91.30.1743241605943;
        Sat, 29 Mar 2025 02:46:45 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c44:e4e:6e69:d5cb:5b5a:ea6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f6b31fbsm5680573a91.40.2025.03.29.02.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 02:46:45 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: sahilcdq@proton.me,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] openrisc: Add cacheinfo support and introduce new utility functions
Date: Sat, 29 Mar 2025 15:16:19 +0530
Message-ID: <20250329094622.94919-1-sahilcdq@proton.me>
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

While testing these changes with QEMU, I realized that the check being
performed in cpu_cache_is_present() would always get evaluated to true
when the UPR_UP bit was set. This series fixes this check and addresses
v4's review comments.

Thanks,
Sahil

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


base-commit: ea1413e5b53a8dd4fa7675edb23cdf828bbdce1e
-- 
2.48.1

