Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6FDDF43
	for <linux-openrisc@vger.kernel.org>; Mon, 29 Apr 2024 05:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714369664; cv=none; b=SDUIQSfzYzK6bRSy2LyJzFP2BNwPARX6xprVmhujKSf7yQZSmca6HGsY68rjzn2Wjr4pLx6LQ6j7aFcPG58enNden+EVihm+NmvZ9Mb1TYQdMGHDW466tIfa43d4muZ7ieXTHJgOI5rmMk5pVzdtCNb/WGkXvSA9n6ZnLpRYZbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714369664; c=relaxed/simple;
	bh=goso9y2Vb842velO2cXQPj8QkAsJo7i2+k4dUa94rLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BQYBcZKHcmW62F+7XRHyvn+Hac6Q8iIm8mTYVZh+Zp6NjTXGKEHgYZvdw6M0UcZu58tJbaClPjgmN/8BG0lXfLFU1kRJ8NeDCLoDw+cj3eyCDiuKZuXt9cUi90MToMPnjD28WIMG31e2scSh2DGZFm2a3cpTfHlZSA6XHACkCkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUILedz2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUILedz2"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41bf1b96aeaso8313395e9.3
        for <linux-openrisc@vger.kernel.org>; Sun, 28 Apr 2024 22:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714369661; x=1714974461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uFZSG9GhCDjapQBMxcazdvrP7g89w7uGnAiX4idactw=;
        b=lUILedz2qS29gWv7eVtLbYXH7OnGrZ6NWq8Pj9YZmzrCJc6ykhKQu4hxKLKBX1SzVv
         go8RHpiPvV5DXg9MskSRSl0tDwcvQqE720x4tjX0TkFmdPxTf6uKr5nvLP8CWjD7vzhc
         voyW7AoC6Hm3Q3Fffnx6yIKPM98keNRrA4WI9wUf4uPQODV4jWmyiA1pIHCX7f7nNRgR
         l9H4l9a6jnu65tK5JfiXyOPOMRlzVfSKURkwRsdWNyMOmIQsgSlgHkZIwpeGqyIyXsCi
         zCBXmU76uwBFLqz89i+HkD4A9FssDhUeaRC77rI47r9ztyPFoqpKBTn6HjEhDAmLugjC
         64nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714369661; x=1714974461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFZSG9GhCDjapQBMxcazdvrP7g89w7uGnAiX4idactw=;
        b=OFYW3koGtvUOPrUH2/8QPdoLy4Te8uqzn0aQZHpd9njnLu7R/9l46xolw48nc3l53h
         P4YQSAaDduCurYsNg5pMjpzZyb0lnXaYz4jzmuUSpBJ0W5CD2cZKyn9v67G1uXtxau4w
         zIn+XOtOnbToPNiUwhmDvXRBm4VejL7SWyDf2vOMaZdRz7hunyCYfMnpzUu/2Pb+eR0i
         XY2QpNbZ81DOV54Gi+aqyFOXTgbUy2ZL2kaJROH/UPAJ50sMya/v4RGcsPRZEWc6KhO+
         66S0I6dV4vhGXSiIyuzVzMrqj2kK1pRX1iUPmTJ/ky9kzrqRFfbynyF10TAtDwIr9eZc
         g0rA==
X-Gm-Message-State: AOJu0YwszjfafaerSHjMfq6K/gH62oBzbR7yFGHIP5/OxB0OMG3RzpQ7
	oiUBZ9e/7OUKcgFbzYyzzrPvgtlB1LNeVp0IVfQaz87mn5Ivzgve
X-Google-Smtp-Source: AGHT+IFbvM0vNymvgV2aHIS6ImGjIQjyT3mMRSOLkSb0dunDB8N4i7bmNGNNYUXkMXG8P1odX4E7Bg==
X-Received: by 2002:a05:600c:1990:b0:41b:6753:30be with SMTP id t16-20020a05600c199000b0041b675330bemr6834635wmq.38.1714369660760;
        Sun, 28 Apr 2024 22:47:40 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b0041bf685921dsm6156243wmq.0.2024.04.28.22.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 22:47:38 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 0/3] OpenRISC glibc hard float support
Date: Mon, 29 Apr 2024 06:47:32 +0100
Message-ID: <20240429054735.2467433-1-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds hardware floating point support to the OpenRIS glibc port.

I will keep this cover letter short and point to patch 2/3.  It contains details
about the change and testing results.

Changes since v1:

 - Added combat symbols for getcontext, setcontext etc. Supporting old
   mcontext_t ABI.
 - Split fpu ulps file out to separate patch to make the main patch smaller.

Stafford Horne (3):
  or1k: Add hard float libm-test-ulps
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
 sysdeps/unix/sysv/linux/or1k/Versions         |   14 +
 .../unix/sysv/linux/or1k/getcontext-common.S  |   88 ++
 sysdeps/unix/sysv/linux/or1k/getcontext.S     |   69 +-
 sysdeps/unix/sysv/linux/or1k/libc.abilist     |    4 +
 sysdeps/unix/sysv/linux/or1k/makecontext.c    |   49 +-
 .../unix/sysv/linux/or1k/setcontext-common.S  |  120 ++
 sysdeps/unix/sysv/linux/or1k/setcontext.S     |  102 +-
 .../unix/sysv/linux/or1k/swapcontext-common.S |  139 ++
 sysdeps/unix/sysv/linux/or1k/swapcontext.S    |  109 +-
 sysdeps/unix/sysv/linux/or1k/sys/ucontext.h   |    1 +
 sysdeps/unix/sysv/linux/or1k/ucontext_i.sym   |    3 +
 38 files changed, 2517 insertions(+), 222 deletions(-)
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
 create mode 100644 sysdeps/unix/sysv/linux/or1k/Versions
 create mode 100644 sysdeps/unix/sysv/linux/or1k/getcontext-common.S
 create mode 100644 sysdeps/unix/sysv/linux/or1k/setcontext-common.S
 create mode 100644 sysdeps/unix/sysv/linux/or1k/swapcontext-common.S

-- 
2.44.0

