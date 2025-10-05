Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73EE10A1E
	for <linux-openrisc@vger.kernel.org>; Sun,  5 Oct 2025 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759646141; cv=none; b=Ljf3eTBNhWEi31w7uLfqP6ET1UsdXOWw0XEvoG6tNrSfPHesQalep93gEBcICPqFz9U6QzktPFRcsVpFGIGpJRXCFrkc6GNJ8Z0PBzXwJFA6B1lDnntrVMgYLuqU7S56qKfbxNOh1oPCSe6UYZ7rfGWWH8f4UVBLr8RLuIm2xrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759646141; c=relaxed/simple;
	bh=5VrhzHDMjjWSE91exTxL2AaN739vo05Zspz0TxMnduE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dADN9AcXH/KfN2GPzEgK3fkC0j5MAn/2pA6bh1gecCQDoH0Og5QBgiqO9vxrAKrC5HnpGXTeZ8gvV7n7J5O74bAaY8VBcuZvXMFT6EKKMyJDAQZGPnTPEzzL0lO+yQb5k33IJfawPA89t2nIhM/NZTOq8qYeIVmro+dyQYHChuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSpiZXbI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSpiZXbI"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e2e363118so33627515e9.0
        for <linux-openrisc@vger.kernel.org>; Sat, 04 Oct 2025 23:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759646138; x=1760250938; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2rcSyZ+WMtwF2hZaJMeBS9ckws0AkW9s6+ei9+CY7Kk=;
        b=lSpiZXbIP9QfYuPlIgFNMUXG/LObHjgBXjAZtUE93s7vVICxfMA3NwhJ1uHEgymQiG
         gRMY88qIOePszKTWF0hsgvmo/KakQU1Tu1GPTp/YKI4WbdewNF+AbSAIct89Vfb4NZUg
         MuO0kM3/3UikIrI8oy4J8ui4smjw624PuWDHaJMK1t04HxfQPzhTUU5a5ZMNwe6UlklI
         d6RNAJy0jzGX49i3OwsXJmk0Xsfr2MqASkzGAdOlprJEhnre/z4V6f74J3K3TXP9szKp
         pET7skjKU67PYWfiQjlul1+rvvemlIeA9DF/p63L/ylL6OOFnB/H8Hz3gNoRVCJIw9zV
         tzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759646138; x=1760250938;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rcSyZ+WMtwF2hZaJMeBS9ckws0AkW9s6+ei9+CY7Kk=;
        b=WjBbHVv2ArxKOo7zyk3/7pV4B86av9MFT3zyN3J8giEgKo2erRq8w8HUtNiz8H3g0Q
         m3169iltNPQfoyR6fWCV33cE/HYKK5pkg4jUapKDUe/PN27SDz2AUVmzo/dlM8Pwyany
         8tkWMM7uImF3OWrYeISHaI3z1f+iqKGQyrXKQCb63EiAMI+DFmfhpy4RIwv0Qzq+4QUP
         xuetBYickKF3wGdjgMbmxTUpaYC48AgrW+NyM1F5Q+zdsrQnAlEpca2rrwVBeHDvRiBD
         xsycu87fP/MxDVgNZ8ByPXOTjR+iiU9aKrUTGqnhVyqqFQyGaj+3yPE2HMkw0fo1icOM
         C1dA==
X-Gm-Message-State: AOJu0YzTzhIQHq83J8oPJI5PJniACuh6tVJ5OyuAHyO5RWvHMEH713nP
	airBEJ0VMcDLFJIbyGOS9OED/OQ5PwYJSJjZfPTYBjgL8YUpcGLIYq1b6vPy8w==
X-Gm-Gg: ASbGncu6jfVWeb7SNVgVCqSObS94ZBzYPYwf/X8b46xkAK5GvuVVTe9rn/Elpf2WRgd
	8d8461HUD7dj3zZrk3tOmCaAinjvsd0ZghQXc+D5qGDWNbbpZNxTzxByGAGwsLw8UhJ95Zf9WbY
	txQKCPrwzV9CVTA0s68vqBbkXSl+gpPcXStYmsX7RJWLYcpDu/tZu77px64O8HWRMjMjfr63xSo
	6l56i+BP9WaVvsLcQ7rPipkII9mY4hsKmfyqCVGQSpMMP37PmQIExRTZh6qT4J6BsMycp7V0/6i
	c4UWtWbAN4tYrSaszCpFFy94He1cpaCCmbG2Kwb+EFUR24ztghwrGXXWE5g9RcTLNZ0+DHhIYk7
	l0mByx9zwAm31GKp/6UsfsnJZGXcwPvdl3I3YCM2hNli8WVZwJG9mxx9ol8D3Y2BxcLfSPrKtLP
	yYi+6icVq0YWuW6dTi1/rC
X-Google-Smtp-Source: AGHT+IG4EpN5GFt0hdbvyfHbROf8lY/f3eM4VfEv5SVIfYealuYiXMFchpEPZEsQb1Hc940YbQdTxA==
X-Received: by 2002:a05:600c:8b16:b0:45f:29ed:2cff with SMTP id 5b1f17b1804b1-46e711725fdmr53349985e9.35.1759646137650;
        Sat, 04 Oct 2025 23:35:37 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b7e37sm197232645e9.1.2025.10.04.23.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 23:35:35 -0700 (PDT)
Date: Sun, 5 Oct 2025 07:35:34 +0100
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC updates for 6.18
Message-ID: <aOIRtnhTn3Gt8yr5@antec>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,

Please consider for pull,

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 8c30b0018f9d93391573e091960d257fd9de120a:

  openrisc: Add jump label support (2025-09-11 11:27:59 +0100)

----------------------------------------------------------------
OpenRISC updates for 6.18

I picked up one series from Chen Miao, our Google Summer
of Code contributor:

 - Added OpenRISC support for static keys

----------------------------------------------------------------
chenmiao (4):
      openrisc: Add text patching API support
      openrisc: Add R_OR1K_32_PCREL relocation type module support
      openrisc: Regenerate defconfigs.
      openrisc: Add jump label support

 .../features/core/jump-labels/arch-support.txt     |  2 +-
 arch/openrisc/Kconfig                              |  2 +
 arch/openrisc/configs/or1ksim_defconfig            | 19 ++----
 arch/openrisc/configs/virt_defconfig               |  2 +-
 arch/openrisc/include/asm/Kbuild                   |  1 -
 arch/openrisc/include/asm/fixmap.h                 |  1 +
 arch/openrisc/include/asm/insn-def.h               | 15 ++++
 arch/openrisc/include/asm/jump_label.h             | 72 ++++++++++++++++++++
 arch/openrisc/include/asm/text-patching.h          | 13 ++++
 arch/openrisc/kernel/Makefile                      |  2 +
 arch/openrisc/kernel/jump_label.c                  | 51 ++++++++++++++
 arch/openrisc/kernel/module.c                      |  4 ++
 arch/openrisc/kernel/patching.c                    | 79 ++++++++++++++++++++++
 arch/openrisc/kernel/setup.c                       |  2 +
 arch/openrisc/mm/init.c                            |  6 +-
 15 files changed, 255 insertions(+), 16 deletions(-)
 create mode 100644 arch/openrisc/include/asm/insn-def.h
 create mode 100644 arch/openrisc/include/asm/jump_label.h
 create mode 100644 arch/openrisc/include/asm/text-patching.h
 create mode 100644 arch/openrisc/kernel/jump_label.c
 create mode 100644 arch/openrisc/kernel/patching.c
