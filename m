Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA701EA87
	for <linux-openrisc@vger.kernel.org>; Fri,  3 May 2024 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757260; cv=none; b=eG0CFQgdPEBepJZf/t6x02BnaWrFmM8Y+vrSQKgnNbDAIpTr8Pj/eNuq4O6qz+mCYXnywz/k2F50bAXjXlgq0ii9JU4GPxnbygUC2JaYRwcl8xBcaWYx8hGgK/qELWVnaSeUn9HyMHFV/ZK2/JBRtU1UQ3yLq/GrZHSl7qeB0qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757260; c=relaxed/simple;
	bh=cAcb54PGt4IkkVFJQfKrb+npEvop2UggQj+c6AoHM20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmnZ7na5RRvVutg9YX39a4DhDP66XEPcNSwOCCST5eBrfnUZOisrZoWL6Jj7UeLDJ54l4/Jib+keS8xkwnH9Rg5rkVo5ZzPXY8YJz4ShrTo6H0eeaiTY7qRErzY+G27nwE6tOamWP6SZbUVB4jCRyeg9l/46g4eKScJ1wqggUA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkldCapK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkldCapK"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-347e635b1fcso7003019f8f.1
        for <linux-openrisc@vger.kernel.org>; Fri, 03 May 2024 10:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714757257; x=1715362057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qYjyJJ05xUCtujauJ9HzAjbJ3tQY7Vn4UiIDiSnCEmg=;
        b=RkldCapKeh9JaDfGcF3r0I03v7WBMaaCYXiRqvh10zFsdIItFqIYnDBxaZb+qdMZCR
         rro7Nz3M9gaRGI/B0N1vAidB5UpMKuclyWYH4pdw3wHXXI0UBcZ8qGx1FmdB9j6FSWRf
         ZNZq2kXEOndcA65Hx9EZN+EVj6adW5D/K1PdsVdy+zyOa61du2AmdTZyVG0gdvFq+lsv
         acPTOzaOPJWwBzoa3eTdBUJjJCQNtxTOPt0X0XxYAQD6a1IgNy5oPB8JWYuirXm5YjdI
         x0hBAnIY5Hjhru+kQS36chRnFDwc88Q1PXxJmwmd8ZsrMdnctNOMiDyKDtIs5GUutuYD
         ILPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714757257; x=1715362057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYjyJJ05xUCtujauJ9HzAjbJ3tQY7Vn4UiIDiSnCEmg=;
        b=ciLPv2ddtZTwwI6D9DdV0uzvjWri/KDJrWj/CtPP2rV1bQWNRnfK6Wj5tld0ZRBz9w
         RqCx2pO3Yj9yhhMVefaHg+vFuxwk4lRXWIIAHgmtLWUg422Gncxgx0lVskxw0M6MuqC2
         UMk8Q3dX/+pjguqh55iU4BWh1fwARwGNZhZLTw7OlM1Vwvvi4K03Zlz9oqrks3zH1iwx
         lDC+UFoUA3I7ZBtObscddYAGtjjiQ+RUR7bIWjfbkxouySBQe+vyiKFDBcrp0tF7STLb
         rNoIFUntbwSMp5Oa3w/U1VP1oPxfKNMhlhFsSKLUPrn0CRtO9pzTodbkG3+axWQaiH6E
         X4ng==
X-Gm-Message-State: AOJu0YxzaQ/jwx195rtAqL7jZ1PNDe0RB6lHT7KdGeoBptd77iMfJGUr
	Yj0ZYPGVsxDTyKby5vHrG61Qa8MTHT9BBUke8Xjt1Hu/IiU042yW
X-Google-Smtp-Source: AGHT+IGdbuXgZ7FjlqWCaVIAd7yIeULfbCib6TXnFHcPCeG6NysaTz0KCEB8VjJgEEv6OHZxGueY3A==
X-Received: by 2002:adf:f0d1:0:b0:34c:8b03:48b6 with SMTP id x17-20020adff0d1000000b0034c8b0348b6mr2395827wro.23.1714757256519;
        Fri, 03 May 2024 10:27:36 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id p12-20020adfe60c000000b0034ccd06a6a3sm4246310wrm.18.2024.05.03.10.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 10:27:35 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH v3 0/3] OpenRISC glibc hard float support
Date: Fri,  3 May 2024 18:27:28 +0100
Message-ID: <20240503172731.675178-1-shorne@gmail.com>
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

Changes since v2:

 - Remove spurious whitespace cleanup.
 - Add a bit more docs and explaination about the FPSCR register flags.
 - Add Reviewed-by from Adhemerval.

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
 sysdeps/or1k/fpu_control.h                    |   89 ++
 sysdeps/or1k/libm-test-ulps-name              |    1 -
 sysdeps/or1k/math-tests-snan-payload.h        |   26 +
 sysdeps/or1k/math-tests-trap.h                |   27 +
 sysdeps/or1k/{ => nofpu}/libm-test-ulps       |    0
 sysdeps/or1k/nofpu/libm-test-ulps-name        |    1 +
 sysdeps/or1k/sfp-machine.h                    |   17 +
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
 38 files changed, 2545 insertions(+), 221 deletions(-)
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

