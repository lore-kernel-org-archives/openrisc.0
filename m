Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B563CF7D
	for <linux-openrisc@vger.kernel.org>; Fri, 29 Mar 2024 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711698052; cv=none; b=Raz1LCUPKNZpdGg7Se0Yh/nA/K/2NaJVeUXffsLaPVlrKE0SiVO+CRQFupalxhIpAhqJwYoe5lPAGjnC/cZXgS9B3XoXX8AWJcv08kb1nTlLCjF4dOWVnj4xAkJJHB9OtZ/wr/I03ikz85JcxRORsN2/UU9AwSVR/0nhZs05OUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711698052; c=relaxed/simple;
	bh=Vh2UOG+M2h4Zx1laRciruxObEPSVtwsv7siEaJ2OPJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cntriJ0RCWZiZg6Go1uAKJzcbP0PnDdFxyR9Vs/GgvGNFfe/SOQzF9NDf/urePbXf5EQM0/r9wSeTQhDT260tgEcCVoGo2+sPWHV5fpTwb27SVBBntAHB+FBYSi3+fsumZ3onFwrfUBO/D+Z57Tu+VQm1/i0s5+vvOlvzAZzHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehc36Yi1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehc36Yi1"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-415482308f8so7553025e9.1
        for <linux-openrisc@vger.kernel.org>; Fri, 29 Mar 2024 00:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711698049; x=1712302849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k+lf5/0+XbAeMgmjtNpXFcohadGHfuvs5fUqq/J2NsQ=;
        b=ehc36Yi1JGJ5S5vN5ZdIOikrxepEqRPM+s8Mz3RZHyqq9ztEGzAVQJy9VIfDT/V5ET
         +vuu4cLJflzlZz2k9lzAeih/1p205uY43iY/uuXfTIbuDYozYUxicp9lYmvv81G/s4S0
         Pn/dgxAx49G5FiqcHtTQlmmcmdtz7MlVZcnVdeLW1nFvIj3qY8kJK/KefptaxV7C+2KU
         mWB/apc+q/icFbpCrjGAB/t2ZAaCj/4cpxjaTFqbUpce3/3ltpxCEiQoALWb9Fa75TmU
         zzbT8kxyiQnUJcJQ9hQGX6QiXfw7ezplw5C3WvaGmNLzR9qWwkccorcEaHTYuRbtPSxD
         oOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711698049; x=1712302849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+lf5/0+XbAeMgmjtNpXFcohadGHfuvs5fUqq/J2NsQ=;
        b=IUELwFFMiST9cMH1x59/MzU/fYDJjaTGMlx9BUB5w7p5z/N3RNi9lJ5BuXDRlXD5Qd
         NhpRTxcsT+RZv67jNk1cRqcc/ZwA3igFmTtLSyk4KbfarcaHCN4NzbCBN7oTScUpNtOi
         A6jEXaSAs9+lcRU12MGg3/bjfD37gHapWx9hCEb4yQ/8ZjCytqugY0AVHaW55fHF8x8V
         lUmP/up/HbatYG74BXBm4LKjlNbbIpDO/rvynremqpEi2LwMV4B+MDgogLBJAiAV9Huj
         8uGip0dIVKvketbXQit3hbUmUj4TJ4H/cC7lGFebQgVfUcQmHaevjvHMmf2Gsco9ef+V
         tvFw==
X-Gm-Message-State: AOJu0YzdGWPUjSVQmizDkDkReQxoE1ja+ycNgVh6ozdmTEcI0krBX8K5
	kTZTj/BJCrzsfKfiTbaARF+GCF6jhk35FqYIqfqWXSTkmrmC+6YL0r78LnsT
X-Google-Smtp-Source: AGHT+IGPufPlN8j+bEZD6uM3cKcff2ttxr1WsOff/1DIr8BeOMi9QROZlhnh165tunWvdlc0LfLpwg==
X-Received: by 2002:a05:600c:3554:b0:414:910c:450b with SMTP id i20-20020a05600c355400b00414910c450bmr1031729wmq.4.1711698048609;
        Fri, 29 Mar 2024 00:40:48 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05600c538600b004148ff6ef54sm4573304wmb.29.2024.03.29.00.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:40:46 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH 0/2] OpenRISC glibc hard float support
Date: Fri, 29 Mar 2024 07:40:42 +0000
Message-ID: <20240329074044.1961252-1-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds hardware floating point support to the OpenRIS glibc port.

I will keep this cover letter short and point to patch 1/2.  It contains details
about the change and testing results.

Stafford Horne (2):
  or1k: Add hard float support
  build-many-glibcs.py: Add openrisc hard float glibc variant

 scripts/build-many-glibcs.py                  |    5 +-
 sysdeps/or1k/fpu/fclrexcpt.c                  |   44 +
 sysdeps/or1k/fpu/fegetenv.c                   |   32 +
 sysdeps/or1k/fpu/fegetmode.c                  |   29 +
 sysdeps/or1k/fpu/fegetround.c                 |   29 +
 sysdeps/or1k/fpu/feholdexcpt.c                |   33 +
 sysdeps/or1k/fpu/fenv_private.h               |  199 +++
 sysdeps/or1k/fpu/fesetenv.c                   |   32 +
 sysdeps/or1k/fpu/fesetexcept.c                |   35 +
 sysdeps/or1k/fpu/fesetmode.c                  |   39 +
 sysdeps/or1k/fpu/fesetround.c                 |   39 +
 sysdeps/or1k/fpu/feupdateenv.c                |   33 +
 sysdeps/or1k/fpu/fgetexcptflg.c               |   29 +
 .../or1k/fpu/fix-fp-int-convert-overflow.h    |   38 +
 sysdeps/or1k/fpu/fraiseexcpt.c                |   67 +
 sysdeps/or1k/fpu/fsetexcptflg.c               |   43 +
 sysdeps/or1k/fpu/ftestexcept.c                |   27 +
 sysdeps/or1k/fpu/get-rounding-mode.h          |   38 +
 sysdeps/or1k/fpu/libm-test-ulps               | 1115 +++++++++++++++++
 sysdeps/or1k/fpu/libm-test-ulps-name          |    1 +
 sysdeps/or1k/fpu_control.h                    |   61 +
 sysdeps/or1k/libm-test-ulps-name              |    1 -
 sysdeps/or1k/math-tests-snan-payload.h        |   26 +
 sysdeps/or1k/math-tests-trap.h                |   27 +
 sysdeps/or1k/{ => nofpu}/libm-test-ulps       |    0
 sysdeps/or1k/nofpu/libm-test-ulps-name        |    1 +
 sysdeps/or1k/sfp-machine.h                    |   18 +-
 sysdeps/unix/sysv/linux/or1k/getcontext.S     |    6 +
 sysdeps/unix/sysv/linux/or1k/setcontext.S     |    6 +
 sysdeps/unix/sysv/linux/or1k/swapcontext.S    |   12 +
 sysdeps/unix/sysv/linux/or1k/sys/ucontext.h   |    1 +
 sysdeps/unix/sysv/linux/or1k/ucontext_i.sym   |    3 +
 32 files changed, 2065 insertions(+), 4 deletions(-)
 create mode 100644 sysdeps/or1k/fpu/fclrexcpt.c
 create mode 100644 sysdeps/or1k/fpu/fegetenv.c
 create mode 100644 sysdeps/or1k/fpu/fegetmode.c
 create mode 100644 sysdeps/or1k/fpu/fegetround.c
 create mode 100644 sysdeps/or1k/fpu/feholdexcpt.c
 create mode 100644 sysdeps/or1k/fpu/fenv_private.h
 create mode 100644 sysdeps/or1k/fpu/fesetenv.c
 create mode 100644 sysdeps/or1k/fpu/fesetexcept.c
 create mode 100644 sysdeps/or1k/fpu/fesetmode.c
 create mode 100644 sysdeps/or1k/fpu/fesetround.c
 create mode 100644 sysdeps/or1k/fpu/feupdateenv.c
 create mode 100644 sysdeps/or1k/fpu/fgetexcptflg.c
 create mode 100644 sysdeps/or1k/fpu/fix-fp-int-convert-overflow.h
 create mode 100644 sysdeps/or1k/fpu/fraiseexcpt.c
 create mode 100644 sysdeps/or1k/fpu/fsetexcptflg.c
 create mode 100644 sysdeps/or1k/fpu/ftestexcept.c
 create mode 100644 sysdeps/or1k/fpu/get-rounding-mode.h
 create mode 100644 sysdeps/or1k/fpu/libm-test-ulps
 create mode 100644 sysdeps/or1k/fpu/libm-test-ulps-name
 create mode 100644 sysdeps/or1k/fpu_control.h
 delete mode 100644 sysdeps/or1k/libm-test-ulps-name
 create mode 100644 sysdeps/or1k/math-tests-snan-payload.h
 create mode 100644 sysdeps/or1k/math-tests-trap.h
 rename sysdeps/or1k/{ => nofpu}/libm-test-ulps (100%)
 create mode 100644 sysdeps/or1k/nofpu/libm-test-ulps-name

-- 
2.44.0

