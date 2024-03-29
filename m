Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC0D3CF7D
	for <linux-openrisc@vger.kernel.org>; Fri, 29 Mar 2024 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711698058; cv=none; b=IgfUH0PJ34MeNIumd0Zr7tlJ3AuWU20UQGdeh1aJcupppdNqtAQdlZefMVQMP+TeVzNc6OyeMiAaaNE14+OeFthgWgblvpidIm2HHYLXVx1SCwaMvrMBDwzZjQ4SI3kffWFllz3YyB3cPjVqkXpaycoAfA1KhCDyHacE5UYSTZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711698058; c=relaxed/simple;
	bh=nmglvY2cI6TRjeHUUXwDYeLtBbsywfbT/oqMqwg81Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxmNOC0tnyyow1AQCcHt6RYB8SU1SeMpc5mhlu72J36+MeFq3RNz2p+v2tjbN61YEyHVnK8Qo/HQatV5640MRW/MFReI8aKq30Kpn7o75AcobPNS1n1rE4LxdeBXye1JqtL7AaeMwAzM1VadpEWSFudD7eX4RMdQ0E47h2cLNXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpXivw4s; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpXivw4s"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-414866f92beso11800485e9.3
        for <linux-openrisc@vger.kernel.org>; Fri, 29 Mar 2024 00:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711698052; x=1712302852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irXi2Q+k1PKtHeMVbs9ZBKqlN6GSIBq95Z8K1DrXu68=;
        b=WpXivw4sA5LbwQ+hy1m8gdh/6Hy29RgiIh7DjDulFdPSIpcd3LV/wtu4H8Goqql3Ih
         OyBWYrLBFM9Fjd2lkVKcfd8OVmaI6lePcwTzzfF+imr11KPmBqGCxyhhq0juRN8sHLnN
         O+odLODTb1ChuvmSJgZOYxIcAYqjHir2lKgA1xplxQes3CuJ15DR5yTgo3WsGT/sdWnm
         tal5ZPwyjTLcNkyAk2gg6yU9jwcYHosc0nybg1oRXbW956GzMs7kMRiAGuEK9Zu/apeZ
         sBQsx50m3B4c98VMxT+/7BtYrDIi+hbQjXKBXUqQQfDxchgHvfxH0Zmqaax6q3jD25jA
         GQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711698052; x=1712302852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irXi2Q+k1PKtHeMVbs9ZBKqlN6GSIBq95Z8K1DrXu68=;
        b=jHy9k11iezX2WzmNlG1iXQ4nko1GUoaNLbGoKMkZW6uaocu+AyANpuBDogST57fTsT
         EsiZyMPdvYlAkPgpmMSlOyTyH1y1QULWSsQK5rac+mpGUYErCgyV4KZcbFexjQlfKefl
         LPpSdvDqdfoewOTf0A2YNjU9v9obOnUEcYZBTHI6aHiNbjod/wUOU9KMu9alTwxRSBBL
         tdi79tt4uP2qU/4qtQpT25sSuL1yuGR1cbKvfyQ3+ePNl1ny1FJ9Cm9s54xIWaKn6yEQ
         n9+40pehHg6dpXuZWtjwDyv/9ZJv3vpf0+QTaVPVdF5SuXyXH3R/ZOjqGGv9nvS+aPkd
         +y0Q==
X-Gm-Message-State: AOJu0YxDrUo2+T4htIkCyM8dFOySa+F8n08h0i676M7t8bVwKw7c2c8C
	Lsx0FBnu9QYSH6VNKrGZ0a4ULIZggkMCX/p4WGNpc53apjReLHizkWM6ruFN
X-Google-Smtp-Source: AGHT+IHyNpDCRoWTFkcx9quWaeOltBPPYOXnJvnNScjPrt0b19JtYjLZNt6VArZCmzucuehugpsIVQ==
X-Received: by 2002:a05:600c:5253:b0:414:8a7b:481b with SMTP id fc19-20020a05600c525300b004148a7b481bmr1057956wmb.31.1711698051751;
        Fri, 29 Mar 2024 00:40:51 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c500c00b00415514e4c7dsm504693wmr.4.2024.03.29.00.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:40:49 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH 1/2] or1k: Add hard float support
Date: Fri, 29 Mar 2024 07:40:43 +0000
Message-ID: <20240329074044.1961252-2-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329074044.1961252-1-shorne@gmail.com>
References: <20240329074044.1961252-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds hardware floating point support to OpenRISC.  Hardware
floating point toolchain builds are enabled by passing the machine
specific argument -mhard-float to gcc via CFLAGS.  With this enabled GCC
generates floating point instructions for single-precision operations
and exports __or1k_hard_float__.

There are 2 main parts to this patch.

 - Implement fenv functions to update the FPCSR flags keeping it in sync
   with sfp (software floating point).
 - Update machine context functions to store and restore the FPCSR
   state.

*On mcontext_t ABI*

This patch adds __fpcsr to mcontext_t.  This is an ABI change, but also
an ABI fix.  The linux kernel has always defined padding in mcontext_t
that was was missing from the glibc ABI.  This unused space is has now
been re-purposed for storing the FPCSR.  This patch brings OpenRISC
glibc in line with the Linux kernel and other libc implementation
(musl).

*Hard float ABI*

The calling conventions and types do not change with OpenRISC hard-float
so glibc hard-float builds continue to use dynamic linker
/lib/ld-linux-or1k.so.1.

*Testing*

I have tested this patch both with hard-float and soft-float builds and
the test results look fine to me.  Results are as follows:

Hard Float

    # failures
    FAIL: elf/tst-sprof-basic      (Not checked, seen in other ports too)
    FAIL: gmon/tst-gmon-pie        (GCC PIE bug)
    FAIL: gmon/tst-gmon-pie-gprof  (GCC PIE bug)
    FAIL: nptl/tst-cond24          (timeouts)
    FAIL: nptl/tst-mutex10         (timeouts)

    # summary
	  5 FAIL
       4279 PASS
	 83 UNSUPPORTED
	 16 XFAIL
	  2 XPASS

    # versions
    Toolchain: or1k-smhfpu-linux-gnu
    Compiler:  gcc version 14.0.1 20240324 (experimental) [master r14-9649-gbb04a11418f] (GCC)
    Binutils:  GNU assembler version 2.42.0 (or1k-smhfpu-linux-gnu) using BFD version (GNU Binutils) 2.42.0.20240324
    Linux:     Linux buildroot 6.8.0-rc5-00003-g9158c6253560-dirty #78 SMP Fri Mar 22 16:56:54 GMT 2024 openrisc GNU/Linux

Soft Float

    # failures
    FAIL: elf/tst-sprof-basic
    FAIL: gmon/tst-gmon-pie
    FAIL: gmon/tst-gmon-pie-gprof
    FAIL: iconvdata/iconv-test     (timeout, passed when run manually)
    FAIL: nptl/tst-mutex10

    # summary
	  5 FAIL
       4281 PASS
	 81 UNSUPPORTED
	 16 XFAIL
	  2 XPASS

    # versions
    Toolchain: or1k-smh-linux-gnu
    Compiler:  gcc version 14.0.1 20240324 (experimental) [master r14-9649-gbb04a11418f] (GCC)
    Binutils:  GNU assembler version 2.42.0 (or1k-smh-linux-gnu) using BFD version (GNU Binutils) 2.42.0.20240324
    Linux:     Linux buildroot 6.8.0-rc5-00003-g9158c6253560-dirty #78 SMP Fri Mar 22 16:56:54 GMT 2024 openrisc GNU/Linux

Documentation: https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.4-rev0.pdf
---
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
 31 files changed, 2062 insertions(+), 2 deletions(-)
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

diff --git a/sysdeps/or1k/fpu/fclrexcpt.c b/sysdeps/or1k/fpu/fclrexcpt.c
new file mode 100644
index 0000000000..44224f9c24
--- /dev/null
+++ b/sysdeps/or1k/fpu/fclrexcpt.c
@@ -0,0 +1,44 @@
+/* Clear given exceptions in current floating-point environment.
+   OpenRISC version.
+   Copyright (C) 2024 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+int
+feclearexcept (int excepts)
+{
+  fpu_control_t cw;
+  fpu_control_t cw_new;
+
+  /* Mask out unsupported bits/exceptions.  */
+  excepts &= FE_ALL_EXCEPT;
+
+  /* Read the complete control word.  */
+  _FPU_GETCW (cw);
+
+  cw_new = cw & ~excepts;
+
+  /* Put the new data in effect.  */
+  if (cw != cw_new)
+    _FPU_SETCW (cw_new);
+
+  /* Success.  */
+  return 0;
+}
+libm_hidden_def (feclearexcept)
diff --git a/sysdeps/or1k/fpu/fegetenv.c b/sysdeps/or1k/fpu/fegetenv.c
new file mode 100644
index 0000000000..70c75aa0bf
--- /dev/null
+++ b/sysdeps/or1k/fpu/fegetenv.c
@@ -0,0 +1,32 @@
+/* Store current floating-point environment.
+   Copyright (C) 2024 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+int
+__fegetenv (fenv_t *envp)
+{
+  _FPU_GETCW (*envp);
+
+  /* Success.  */
+  return 0;
+}
+libm_hidden_def (__fegetenv)
+weak_alias (__fegetenv, fegetenv)
+libm_hidden_weak (fegetenv)
diff --git a/sysdeps/or1k/fpu/fegetmode.c b/sysdeps/or1k/fpu/fegetmode.c
new file mode 100644
index 0000000000..7fffd2e0b5
--- /dev/null
+++ b/sysdeps/or1k/fpu/fegetmode.c
@@ -0,0 +1,29 @@
+/* Store current floating-point control modes.  OpenRISC version.
+   Copyright (C) 2024 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+int
+fegetmode (femode_t *modep)
+{
+  _FPU_GETCW (*modep);
+
+  /* Success.  */
+  return 0;
+}
diff --git a/sysdeps/or1k/fpu/fegetround.c b/sysdeps/or1k/fpu/fegetround.c
new file mode 100644
index 0000000000..7e993b980a
--- /dev/null
+++ b/sysdeps/or1k/fpu/fegetround.c
@@ -0,0 +1,29 @@
+/* Return current rounding direction.  OpenRISC version.
+   Copyright (C) 2024 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <get-rounding-mode.h>
+
+int
+__fegetround (void)
+{
+  return get_rounding_mode ();
+}
+libm_hidden_def (__fegetround)
+weak_alias (__fegetround, fegetround)
+libm_hidden_weak (fegetround)
diff --git a/sysdeps/or1k/fpu/feholdexcpt.c b/sysdeps/or1k/fpu/feholdexcpt.c
new file mode 100644
index 0000000000..0036e41ba2
--- /dev/null
+++ b/sysdeps/or1k/fpu/feholdexcpt.c
@@ -0,0 +1,33 @@
+/* Store current floating-point environment and clear exceptions.
+   OpenRISC version.
+   Copyright (C) 2024 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fenv_private.h>
+
+int
+__feholdexcept (fenv_t *envp)
+{
+  libc_feholdexcept_or1k (envp);
+
+  /* Success.  */
+  return 0;
+}
+libm_hidden_def (__feholdexcept)
+weak_alias (__feholdexcept, feholdexcept)
+libm_hidden_weak (feholdexcept)
diff --git a/sysdeps/or1k/fpu/fenv_private.h b/sysdeps/or1k/fpu/fenv_private.h
new file mode 100644
index 0000000000..4f401e7a5a
--- /dev/null
+++ b/sysdeps/or1k/fpu/fenv_private.h
@@ -0,0 +1,199 @@
+/* Private floating point rounding and exceptions handling.  OpenRISC version.
+   Copyright (C) 2024 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef OR1K_FENV_PRIVATE_H
+#define OR1K_FENV_PRIVATE_H 1
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+static __always_inline void
+libc_feholdexcept_or1k (fenv_t *envp)
+{
+  fpu_control_t cw;
+  fpu_control_t cw_new;
+
+  /* Get and store the environment.  */
+  _FPU_GETCW (cw);
+  *envp = cw;
+
+  /* Clear the exception status flags.  */
+  cw_new = cw & ~FE_ALL_EXCEPT;
+
+  if (cw != cw_new)
+    _FPU_SETCW (cw_new);
+}
+
+#define libc_feholdexcept  libc_feholdexcept_or1k
+#define libc_feholdexceptf libc_feholdexcept_or1k
+#define libc_feholdexceptl libc_feholdexcept_or1k
+
+static __always_inline void
+libc_fesetround_or1k (int round)
+{
+  fpu_control_t cw;
+  fpu_control_t cw_new;
+
+  _FPU_GETCW (cw);
+  cw_new = cw & ~_FPU_FPCSR_RM_MASK;
+  cw_new |= round;
+  if (cw != cw_new)
+    _FPU_SETCW (cw_new);
+}
+
+#define libc_fesetround  libc_fesetround_or1k
+#define libc_fesetroundf libc_fesetround_or1k
+#define libc_fesetroundl libc_fesetround_or1k
+
+static __always_inline void
+libc_feholdexcept_setround_or1k (fenv_t *envp, int round)
+{
+  fpu_control_t cw;
+  fpu_control_t cw_new;
+
+  /* Get and store the environment.  */
+  _FPU_GETCW (cw);
+  *envp = cw;
+
+  /* Clear the status flags and rounding mode.  */
+  cw_new = cw & ~(FE_ALL_EXCEPT | _FPU_FPCSR_RM_MASK);
+
+  /* Set rounding mode.  */
+  cw_new |= round;
+
+  if (cw != cw_new)
+    _FPU_SETCW (cw_new);
+}
+
+#define libc_feholdexcept_setround  libc_feholdexcept_setround_or1k
+#define libc_feholdexcept_setroundf libc_feholdexcept_setround_or1k
+#define libc_feholdexcept_setroundl libc_feholdexcept_setround_or1k
+
+static __always_inline int
+libc_fetestexcept_or1k (int ex)
+{
+  fpu_control_t cw;
+
+  /* Get current control word.  */
+  _FPU_GETCW (cw);
+
+  /* Check if any of the queried exception flags are set.  */
+  return cw & ex & FE_ALL_EXCEPT;
+}
+
+#define libc_fetestexcept  libc_fetestexcept_or1k
+#define libc_fetestexceptf libc_fetestexcept_or1k
+#define libc_fetestexceptl libc_fetestexcept_or1k
+
+static __always_inline void
+libc_fesetenv_or1k (const fenv_t *envp)
+{
+  if (envp == FE_DFL_ENV)
+    _FPU_SETCW (_FPU_DEFAULT);
+  else
+    _FPU_SETCW (*envp);
+}
+
+#define libc_fesetenv  libc_fesetenv_or1k
+#define libc_fesetenvf libc_fesetenv_or1k
+#define libc_fesetenvl libc_fesetenv_or1k
+#define libc_feresetround_noex  libc_fesetenv_or1k
+#define libc_feresetround_noexf libc_fesetenv_or1k
+#define libc_feresetround_noexl libc_fesetenv_or1k
+
+static __always_inline int
+libc_feupdateenv_test_or1k (const fenv_t *envp, int ex)
+{
+  fpu_control_t cw;
+  fpu_control_t cw_new;
+  int excepts;
+
+  /* Get current control word.  */
+  _FPU_GETCW (cw);
+
+  /* Merge current exception flags with the passed fenv.  */
+  excepts = cw & FE_ALL_EXCEPT;
+  cw_new = (envp == FE_DFL_ENV ? _FPU_DEFAULT : *envp) | excepts;
+
+  if (__glibc_unlikely (cw != cw_new))
+    _FPU_SETCW (cw_new);
+
+  /* Raise the exceptions if enabled in the new FP state.  */
+  if (__glibc_unlikely (excepts))
+    __feraiseexcept (excepts);
+
+  return excepts & ex;
+}
+
+#define libc_feupdateenv_test  libc_feupdateenv_test_or1k
+#define libc_feupdateenv_testf libc_feupdateenv_test_or1k
+#define libc_feupdateenv_testl libc_feupdateenv_test_or1k
+
+static __always_inline void
+libc_feupdateenv_or1k (const fenv_t *envp)
+{
+  libc_feupdateenv_test_or1k (envp, 0);
+}
+
+#define libc_feupdateenv  libc_feupdateenv_or1k
+#define libc_feupdateenvf libc_feupdateenv_or1k
+#define libc_feupdateenvl libc_feupdateenv_or1k
+
+static __always_inline void
+libc_feholdsetround_or1k (fenv_t *envp, int round)
+{
+  fpu_control_t cw;
+
+  _FPU_GETCW (cw);
+  *envp = cw;
+
+  /* Check whether rounding modes are different.  */
+  round = (cw ^ round) & _FPU_FPCSR_RM_MASK;
+
+  /* Set new rounding mode if different.  */
+  if (__glibc_unlikely (round != 0))
+    _FPU_SETCW (cw ^ round);
+}
+
+#define libc_feholdsetround  libc_feholdsetround_or1k
+#define libc_feholdsetroundf libc_feholdsetround_or1k
+#define libc_feholdsetroundl libc_feholdsetround_or1k
+
+static __always_inline void
+libc_feresetround_or1k (fenv_t *envp)
+{
+  fpu_control_t cw;
+  int round;
+
+  _FPU_GETCW (cw);
+
+  /* Check whether rounding modes are different.  */
+  round = (*envp ^ cw) & _FPU_FPCSR_RM_MASK;
+
+  /* Restore the rounding mode if it was changed.  */
+  if (__glibc_unlikely (round != 0))
+    _FPU_SETCW (cw ^ round);
+}
+
+#define libc_feresetround  libc_feresetround_or1k
+#define libc_feresetroundf libc_feresetround_or1k
+#define libc_feresetroundl libc_feresetround_or1k
+
+#include_next <fenv_private.h>
+
+#endif
diff --git a/sysdeps/or1k/fpu/fesetenv.c b/sysdeps/or1k/fpu/fesetenv.c
new file mode 100644
index 0000000000..742ca719e0
--- /dev/null
+++ b/sysdeps/or1k/fpu/fesetenv.c
@@ -0,0 +1,32 @@
+/* Install given floating-point environment.  OpenRISC version.
+   Copyright (C) 2024 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fenv_private.h>
+
+int
+__fesetenv (const fenv_t *envp)
+{
+  libc_fesetenv_or1k (envp);
+
+  /* Success.  */
+  return 0;
+}
+libm_hidden_def (__fesetenv)
+weak_alias (__fesetenv, fesetenv)
+libm_hidden_weak (fesetenv)
diff --git a/sysdeps/or1k/fpu/fesetexcept.c b/sysdeps/or1k/fpu/fesetexcept.c
new file mode 100644
index 0000000000..43734eac18
--- /dev/null
+++ b/sysdeps/or1k/fpu/fesetexcept.c
@@ -0,0 +1,35 @@
+/* Set given exception flags.  OpenRISC version.
+   Copyright (C) 2024 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+int
+fesetexcept (int excepts)
+{
+  fpu_control_t cw;
+  fpu_control_t cw_new;
+
+  _FPU_GETCW (cw);
+  cw_new = cw | (excepts & FE_ALL_EXCEPT);
+  if (cw != cw_new)
+    _FPU_SETCW (cw_new);
+
+  /* Success.  */
+  return 0;
+}
diff --git a/sysdeps/or1k/fpu/fesetmode.c b/sysdeps/or1k/fpu/fesetmode.c
new file mode 100644
index 0000000000..d4556927ce
--- /dev/null
+++ b/sysdeps/or1k/fpu/fesetmode.c
@@ -0,0 +1,39 @@
+/* Install given floating-point control modes.  OpenRISC version.
+   Copyright (C) 2024 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+int
+fesetmode (const femode_t *modep)
+{
+  fpu_control_t cw;
+  fpu_control_t cw_new;
+
+  _FPU_GETCW (cw);
+  cw_new = cw & ~_FPU_FPCSR_RM_MASK;
+  if (modep == FE_DFL_MODE)
+    cw_new |= (_FPU_DEFAULT & _FPU_FPCSR_RM_MASK);
+  else
+    cw_new |= (*modep & _FPU_FPCSR_RM_MASK);
+  if (cw != cw_new)
+    _FPU_SETCW (cw_new);
+
+  /* Success.  */
+  return 0;
+}
diff --git a/sysdeps/or1k/fpu/fesetround.c b/sysdeps/or1k/fpu/fesetround.c
new file mode 100644
index 0000000000..c2ada98f1b
--- /dev/null
+++ b/sysdeps/or1k/fpu/fesetround.c
@@ -0,0 +1,39 @@
+/* Set current rounding direction.  OpenRISC version.
+   Copyright (C) 2024 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fenv_private.h>
+
+int
+__fesetround (int round)
+{
+  switch (round)
+    {
+    case FE_TONEAREST:
+    case FE_TOWARDZERO:
+    case FE_DOWNWARD:
+    case FE_UPWARD:
+      libc_fesetround_or1k (round);
+      return 0;
+    default:
+      return round; /* A nonzero value.  */
+    }
+}
+libm_hidden_def (__fesetround)
+weak_alias (__fesetround, fesetround)
+libm_hidden_weak (fesetround)
diff --git a/sysdeps/or1k/fpu/feupdateenv.c b/sysdeps/or1k/fpu/feupdateenv.c
new file mode 100644
index 0000000000..3355bf6596
--- /dev/null
+++ b/sysdeps/or1k/fpu/feupdateenv.c
@@ -0,0 +1,33 @@
+/* Install given floating-point environment and raise exceptions.
+   OpenRISC version.
+   Copyright (C) 2024 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fenv_private.h>
+
+int
+__feupdateenv (const fenv_t *envp)
+{
+  libc_feupdateenv_or1k (envp);
+
+  /* Success.  */
+  return 0;
+}
+libm_hidden_def (__feupdateenv)
+weak_alias (__feupdateenv, feupdateenv)
+libm_hidden_weak (feupdateenv)
diff --git a/sysdeps/or1k/fpu/fgetexcptflg.c b/sysdeps/or1k/fpu/fgetexcptflg.c
new file mode 100644
index 0000000000..a954f6a2f1
--- /dev/null
+++ b/sysdeps/or1k/fpu/fgetexcptflg.c
@@ -0,0 +1,29 @@
+/* Store current state of exceptions.  OpenRISC version.
+   Copyright (C) 2024 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fenv_private.h>
+
+int
+fegetexceptflag (fexcept_t *flagp, int excepts)
+{
+  *flagp = libc_fetestexcept_or1k (excepts);
+
+  /* Success.  */
+  return 0;
+}
diff --git a/sysdeps/or1k/fpu/fix-fp-int-convert-overflow.h b/sysdeps/or1k/fpu/fix-fp-int-convert-overflow.h
new file mode 100644
index 0000000000..78104289c0
--- /dev/null
+++ b/sysdeps/or1k/fpu/fix-fp-int-convert-overflow.h
@@ -0,0 +1,38 @@
+/* Fix for conversion of floating point to integer overflow.  OpenRISC version.
+   Copyright (C) 2024 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef FIX_FP_INT_CONVERT_OVERFLOW_H
+#define FIX_FP_INT_CONVERT_OVERFLOW_H	1
+
+/* The generic libgcc2.c conversions from floating point to long long
+   may not raise the correct exceptions on overflow (and may raise
+   spurious "inexact" exceptions even in non-overflow cases, see
+   <https://gcc.gnu.org/bugzilla/show_bug.cgi?id=59412>).  */
+#define FIX_FLT_LONG_CONVERT_OVERFLOW 0
+#define FIX_FLT_LLONG_CONVERT_OVERFLOW 1
+
+#define FIX_DBL_LONG_CONVERT_OVERFLOW 0
+#define FIX_DBL_LLONG_CONVERT_OVERFLOW 1
+
+#define FIX_LDBL_LONG_CONVERT_OVERFLOW 0
+#define FIX_LDBL_LLONG_CONVERT_OVERFLOW 0
+
+#define FIX_FLT128_LONG_CONVERT_OVERFLOW 0
+#define FIX_FLT128_LLONG_CONVERT_OVERFLOW 0
+
+#endif /* fix-fp-int-convert-overflow.h */
diff --git a/sysdeps/or1k/fpu/fraiseexcpt.c b/sysdeps/or1k/fpu/fraiseexcpt.c
new file mode 100644
index 0000000000..bbacfd50bc
--- /dev/null
+++ b/sysdeps/or1k/fpu/fraiseexcpt.c
@@ -0,0 +1,67 @@
+/* Raise given exceptions.  OpenRISC version.
+   Copyright (C) 2024 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+#include <float.h>
+#include <math.h>
+
+int
+__feraiseexcept (int excepts)
+{
+  if (excepts == 0)
+    return 0;
+
+  /* Raise exceptions represented by EXPECTS.  */
+
+  if (excepts & FE_INEXACT)
+  {
+    float d = 1.0, x = 3.0;
+    __asm__ volatile ("lf.div.s %0, %0, %1" : "+r" (d) : "r" (x));
+  }
+
+  if (excepts & FE_UNDERFLOW)
+  {
+    float d = FLT_MIN;
+    __asm__ volatile ("lf.mul.s %0, %0, %0" : "+r" (d));
+  }
+
+  if (excepts & FE_OVERFLOW)
+  {
+    float d = FLT_MAX;
+    __asm__ volatile ("lf.mul.s %0, %0, %0" : "+r" (d) : "r" (d));
+  }
+
+  if (excepts & FE_DIVBYZERO)
+  {
+    float d = 1.0, x = 0.0;
+    __asm__ volatile ("lf.div.s %0, %0, %1" : "+r" (d) : "r" (x));
+  }
+
+  if (excepts & FE_INVALID)
+  {
+    float d = HUGE_VAL, x = 0.0;
+    __asm__ volatile ("lf.mul.s %0, %1, %0" : "+r" (d) : "r" (x));
+  }
+
+  /* Success.  */
+  return 0;
+}
+libm_hidden_def (__feraiseexcept)
+weak_alias (__feraiseexcept, feraiseexcept)
+libm_hidden_weak (feraiseexcept)
diff --git a/sysdeps/or1k/fpu/fsetexcptflg.c b/sysdeps/or1k/fpu/fsetexcptflg.c
new file mode 100644
index 0000000000..c327e4c5d1
--- /dev/null
+++ b/sysdeps/or1k/fpu/fsetexcptflg.c
@@ -0,0 +1,43 @@
+/* Set floating-point environment exception handling.
+   Copyright (C) 2024 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+int
+fesetexceptflag (const fexcept_t *flagp, int excepts)
+{
+  fpu_control_t cw;
+  fpu_control_t cw_new;
+
+  /* Get the current exceptions.  */
+  _FPU_GETCW (cw);
+
+  /* Make sure the flags we want restored are legal.  */
+  excepts &= FE_ALL_EXCEPT;
+
+  /* Now set selected bits from flagp. Note that we ignore all non-flag
+     bits from *flagp, so they don't matter.  */
+  cw_new = (cw & ~excepts) | (*flagp & excepts);
+
+  if (cw != cw_new)
+    _FPU_SETCW (cw_new);
+
+  /* Success.  */
+  return 0;
+}
diff --git a/sysdeps/or1k/fpu/ftestexcept.c b/sysdeps/or1k/fpu/ftestexcept.c
new file mode 100644
index 0000000000..59f06afa22
--- /dev/null
+++ b/sysdeps/or1k/fpu/ftestexcept.c
@@ -0,0 +1,27 @@
+/* Test exception in current environment.  OpenRISC version.
+   Copyright (C) 2024 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#include <fenv.h>
+#include <fenv_private.h>
+
+int
+fetestexcept (int excepts)
+{
+  return libc_fetestexcept_or1k (excepts);
+}
+libm_hidden_def (fetestexcept)
diff --git a/sysdeps/or1k/fpu/get-rounding-mode.h b/sysdeps/or1k/fpu/get-rounding-mode.h
new file mode 100644
index 0000000000..a66d553be8
--- /dev/null
+++ b/sysdeps/or1k/fpu/get-rounding-mode.h
@@ -0,0 +1,38 @@
+/* Determine floating-point rounding mode within libc.  OpenRISC version.
+
+   Copyright (C) 2024 Free Software Foundation, Inc.
+
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _OR1K_GET_ROUNDING_MODE_H
+#define _OR1K_GET_ROUNDING_MODE_H	1
+
+#include <fenv.h>
+#include <fpu_control.h>
+
+/* Return the floating-point rounding mode.  */
+
+static inline int
+get_rounding_mode (void)
+{
+  fpu_control_t cw;
+
+  _FPU_GETCW (cw);
+  return cw & _FPU_FPCSR_RM_MASK;
+}
+
+#endif /* get-rounding-mode.h */
diff --git a/sysdeps/or1k/fpu/libm-test-ulps b/sysdeps/or1k/fpu/libm-test-ulps
new file mode 100644
index 0000000000..948ec01cdc
--- /dev/null
+++ b/sysdeps/or1k/fpu/libm-test-ulps
@@ -0,0 +1,1115 @@
+# Begin of automatic generation
+
+# Maximal error of functions:
+Function: "acos":
+double: 1
+float: 1
+
+Function: "acos_downward":
+double: 1
+float: 1
+
+Function: "acos_towardzero":
+double: 1
+float: 1
+
+Function: "acos_upward":
+double: 1
+float: 1
+
+Function: "acosh":
+double: 2
+float: 2
+
+Function: "acosh_downward":
+double: 2
+float: 2
+
+Function: "acosh_towardzero":
+double: 2
+float: 2
+
+Function: "acosh_upward":
+double: 2
+float: 2
+
+Function: "asin":
+double: 1
+float: 1
+
+Function: "asin_downward":
+double: 1
+float: 1
+
+Function: "asin_towardzero":
+double: 1
+float: 1
+
+Function: "asin_upward":
+double: 2
+float: 1
+
+Function: "asinh":
+double: 2
+float: 2
+
+Function: "asinh_downward":
+double: 3
+float: 3
+
+Function: "asinh_towardzero":
+double: 2
+float: 2
+
+Function: "asinh_upward":
+double: 3
+float: 3
+
+Function: "atan":
+double: 1
+float: 1
+
+Function: "atan2":
+float: 2
+
+Function: "atan2_downward":
+double: 5
+float: 2
+
+Function: "atan2_towardzero":
+double: 5
+float: 2
+
+Function: "atan2_upward":
+double: 8
+float: 2
+
+Function: "atan_downward":
+double: 1
+float: 2
+
+Function: "atan_towardzero":
+double: 1
+float: 1
+
+Function: "atan_upward":
+double: 1
+float: 2
+
+Function: "atanh":
+double: 2
+float: 2
+
+Function: "atanh_downward":
+double: 3
+float: 3
+
+Function: "atanh_towardzero":
+double: 2
+float: 2
+
+Function: "atanh_upward":
+double: 3
+float: 3
+
+Function: "cabs":
+double: 1
+
+Function: "cabs_downward":
+double: 1
+
+Function: "cabs_towardzero":
+double: 1
+
+Function: "cabs_upward":
+double: 1
+
+Function: Real part of "cacos":
+double: 1
+float: 2
+
+Function: Imaginary part of "cacos":
+double: 2
+float: 2
+
+Function: Real part of "cacos_downward":
+double: 3
+float: 2
+
+Function: Imaginary part of "cacos_downward":
+double: 5
+float: 3
+
+Function: Real part of "cacos_towardzero":
+double: 3
+float: 2
+
+Function: Imaginary part of "cacos_towardzero":
+double: 4
+float: 2
+
+Function: Real part of "cacos_upward":
+double: 2
+float: 2
+
+Function: Imaginary part of "cacos_upward":
+double: 5
+float: 7
+
+Function: Real part of "cacosh":
+double: 2
+float: 2
+
+Function: Imaginary part of "cacosh":
+double: 1
+float: 2
+
+Function: Real part of "cacosh_downward":
+double: 4
+float: 2
+
+Function: Imaginary part of "cacosh_downward":
+double: 3
+float: 3
+
+Function: Real part of "cacosh_towardzero":
+double: 4
+float: 2
+
+Function: Imaginary part of "cacosh_towardzero":
+double: 3
+float: 2
+
+Function: Real part of "cacosh_upward":
+double: 4
+float: 3
+
+Function: Imaginary part of "cacosh_upward":
+double: 3
+float: 2
+
+Function: "carg":
+float: 1
+
+Function: "carg_downward":
+double: 5
+float: 2
+
+Function: "carg_towardzero":
+double: 5
+float: 2
+
+Function: "carg_upward":
+double: 8
+float: 2
+
+Function: Real part of "casin":
+double: 1
+float: 1
+
+Function: Imaginary part of "casin":
+double: 2
+float: 2
+
+Function: Real part of "casin_downward":
+double: 3
+float: 2
+
+Function: Imaginary part of "casin_downward":
+double: 5
+float: 3
+
+Function: Real part of "casin_towardzero":
+double: 3
+float: 1
+
+Function: Imaginary part of "casin_towardzero":
+double: 4
+float: 2
+
+Function: Real part of "casin_upward":
+double: 3
+float: 2
+
+Function: Imaginary part of "casin_upward":
+double: 5
+float: 7
+
+Function: Real part of "casinh":
+double: 2
+float: 2
+
+Function: Imaginary part of "casinh":
+double: 1
+float: 1
+
+Function: Real part of "casinh_downward":
+double: 5
+float: 3
+
+Function: Imaginary part of "casinh_downward":
+double: 3
+float: 2
+
+Function: Real part of "casinh_towardzero":
+double: 4
+float: 2
+
+Function: Imaginary part of "casinh_towardzero":
+double: 3
+float: 1
+
+Function: Real part of "casinh_upward":
+double: 5
+float: 7
+
+Function: Imaginary part of "casinh_upward":
+double: 3
+float: 2
+
+Function: Real part of "catan":
+double: 1
+float: 1
+
+Function: Imaginary part of "catan":
+double: 1
+float: 1
+
+Function: Real part of "catan_downward":
+double: 1
+float: 2
+
+Function: Imaginary part of "catan_downward":
+double: 2
+float: 2
+
+Function: Real part of "catan_towardzero":
+double: 1
+float: 2
+
+Function: Imaginary part of "catan_towardzero":
+double: 2
+float: 2
+
+Function: Real part of "catan_upward":
+double: 2
+float: 1
+
+Function: Imaginary part of "catan_upward":
+double: 2
+float: 2
+
+Function: Real part of "catanh":
+double: 1
+float: 1
+
+Function: Imaginary part of "catanh":
+double: 1
+float: 1
+
+Function: Real part of "catanh_downward":
+double: 2
+float: 2
+
+Function: Imaginary part of "catanh_downward":
+double: 1
+float: 2
+
+Function: Real part of "catanh_towardzero":
+double: 2
+float: 2
+
+Function: Imaginary part of "catanh_towardzero":
+double: 1
+float: 2
+
+Function: Real part of "catanh_upward":
+double: 4
+float: 4
+
+Function: Imaginary part of "catanh_upward":
+double: 2
+float: 1
+
+Function: "cbrt":
+double: 4
+float: 1
+
+Function: "cbrt_downward":
+double: 4
+float: 1
+
+Function: "cbrt_towardzero":
+double: 3
+float: 1
+
+Function: "cbrt_upward":
+double: 5
+float: 1
+
+Function: Real part of "ccos":
+double: 1
+float: 1
+
+Function: Imaginary part of "ccos":
+double: 1
+float: 1
+
+Function: Real part of "ccos_downward":
+double: 3
+float: 1
+
+Function: Imaginary part of "ccos_downward":
+double: 3
+float: 3
+
+Function: Real part of "ccos_towardzero":
+double: 3
+float: 2
+
+Function: Imaginary part of "ccos_towardzero":
+double: 3
+float: 3
+
+Function: Real part of "ccos_upward":
+double: 1
+float: 2
+
+Function: Imaginary part of "ccos_upward":
+double: 2
+float: 2
+
+Function: Real part of "ccosh":
+double: 2
+float: 1
+
+Function: Imaginary part of "ccosh":
+double: 1
+float: 1
+
+Function: Real part of "ccosh_downward":
+double: 3
+float: 2
+
+Function: Imaginary part of "ccosh_downward":
+double: 3
+float: 3
+
+Function: Real part of "ccosh_towardzero":
+double: 3
+float: 3
+
+Function: Imaginary part of "ccosh_towardzero":
+double: 3
+float: 3
+
+Function: Real part of "ccosh_upward":
+double: 1
+float: 2
+
+Function: Imaginary part of "ccosh_upward":
+double: 2
+float: 2
+
+Function: Real part of "cexp":
+double: 2
+float: 1
+
+Function: Imaginary part of "cexp":
+double: 1
+float: 2
+
+Function: Real part of "cexp_downward":
+double: 4
+float: 2
+
+Function: Imaginary part of "cexp_downward":
+double: 3
+float: 3
+
+Function: Real part of "cexp_towardzero":
+double: 4
+float: 2
+
+Function: Imaginary part of "cexp_towardzero":
+double: 3
+float: 3
+
+Function: Real part of "cexp_upward":
+double: 2
+float: 2
+
+Function: Imaginary part of "cexp_upward":
+double: 3
+float: 2
+
+Function: Real part of "clog":
+double: 3
+float: 3
+
+Function: Imaginary part of "clog":
+double: 1
+float: 1
+
+Function: Real part of "clog10":
+double: 3
+float: 4
+
+Function: Imaginary part of "clog10":
+double: 2
+float: 2
+
+Function: Real part of "clog10_downward":
+double: 7
+float: 5
+
+Function: Imaginary part of "clog10_downward":
+double: 8
+float: 4
+
+Function: Real part of "clog10_towardzero":
+double: 5
+float: 5
+
+Function: Imaginary part of "clog10_towardzero":
+double: 8
+float: 4
+
+Function: Real part of "clog10_upward":
+double: 6
+float: 5
+
+Function: Imaginary part of "clog10_upward":
+double: 5
+float: 4
+
+Function: Real part of "clog_downward":
+double: 4
+float: 3
+
+Function: Imaginary part of "clog_downward":
+double: 5
+float: 2
+
+Function: Real part of "clog_towardzero":
+double: 8
+float: 4
+
+Function: Imaginary part of "clog_towardzero":
+double: 5
+float: 3
+
+Function: Real part of "clog_upward":
+double: 8
+float: 3
+
+Function: Imaginary part of "clog_upward":
+double: 8
+float: 2
+
+Function: "cos":
+double: 1
+float: 1
+
+Function: "cos_downward":
+double: 1
+float: 1
+
+Function: "cos_towardzero":
+double: 4
+float: 1
+
+Function: "cos_upward":
+double: 4
+float: 1
+
+Function: "cosh":
+double: 2
+float: 2
+
+Function: "cosh_downward":
+double: 3
+float: 1
+
+Function: "cosh_towardzero":
+double: 3
+float: 1
+
+Function: "cosh_upward":
+double: 2
+float: 2
+
+Function: Real part of "cpow":
+double: 2
+float: 5
+
+Function: Imaginary part of "cpow":
+float: 2
+
+Function: Real part of "cpow_downward":
+double: 5
+float: 8
+
+Function: Imaginary part of "cpow_downward":
+double: 2
+float: 2
+
+Function: Real part of "cpow_towardzero":
+double: 5
+float: 8
+
+Function: Imaginary part of "cpow_towardzero":
+double: 2
+float: 2
+
+Function: Real part of "cpow_upward":
+double: 4
+float: 1
+
+Function: Imaginary part of "cpow_upward":
+double: 2
+float: 2
+
+Function: Real part of "csin":
+double: 1
+float: 1
+
+Function: Real part of "csin_downward":
+double: 3
+float: 3
+
+Function: Imaginary part of "csin_downward":
+double: 3
+float: 1
+
+Function: Real part of "csin_towardzero":
+double: 3
+float: 3
+
+Function: Imaginary part of "csin_towardzero":
+double: 3
+float: 1
+
+Function: Real part of "csin_upward":
+double: 2
+float: 2
+
+Function: Imaginary part of "csin_upward":
+double: 1
+float: 2
+
+Function: Real part of "csinh":
+float: 1
+
+Function: Imaginary part of "csinh":
+double: 1
+float: 1
+
+Function: Real part of "csinh_downward":
+double: 3
+float: 1
+
+Function: Imaginary part of "csinh_downward":
+double: 3
+float: 3
+
+Function: Real part of "csinh_towardzero":
+double: 3
+float: 2
+
+Function: Imaginary part of "csinh_towardzero":
+double: 3
+float: 3
+
+Function: Real part of "csinh_upward":
+double: 1
+float: 2
+
+Function: Imaginary part of "csinh_upward":
+double: 2
+float: 2
+
+Function: Real part of "csqrt":
+double: 2
+float: 2
+
+Function: Imaginary part of "csqrt":
+double: 2
+float: 2
+
+Function: Real part of "csqrt_downward":
+double: 5
+float: 4
+
+Function: Imaginary part of "csqrt_downward":
+double: 4
+float: 3
+
+Function: Real part of "csqrt_towardzero":
+double: 4
+float: 3
+
+Function: Imaginary part of "csqrt_towardzero":
+double: 4
+float: 3
+
+Function: Real part of "csqrt_upward":
+double: 5
+float: 4
+
+Function: Imaginary part of "csqrt_upward":
+double: 3
+float: 3
+
+Function: Real part of "ctan":
+double: 1
+float: 1
+
+Function: Imaginary part of "ctan":
+double: 2
+float: 2
+
+Function: Real part of "ctan_downward":
+double: 6
+float: 5
+
+Function: Imaginary part of "ctan_downward":
+double: 3
+float: 2
+
+Function: Real part of "ctan_towardzero":
+double: 5
+float: 3
+
+Function: Imaginary part of "ctan_towardzero":
+double: 3
+float: 2
+
+Function: Real part of "ctan_upward":
+double: 2
+float: 4
+
+Function: Imaginary part of "ctan_upward":
+double: 2
+float: 1
+
+Function: Real part of "ctanh":
+double: 2
+float: 2
+
+Function: Imaginary part of "ctanh":
+double: 2
+float: 2
+
+Function: Real part of "ctanh_downward":
+double: 3
+float: 2
+
+Function: Imaginary part of "ctanh_downward":
+double: 6
+float: 5
+
+Function: Real part of "ctanh_towardzero":
+double: 3
+float: 2
+
+Function: Imaginary part of "ctanh_towardzero":
+double: 5
+float: 3
+
+Function: Real part of "ctanh_upward":
+double: 2
+float: 2
+
+Function: Imaginary part of "ctanh_upward":
+double: 2
+float: 3
+
+Function: "erf":
+double: 1
+float: 1
+
+Function: "erf_downward":
+double: 1
+float: 1
+
+Function: "erf_towardzero":
+double: 1
+float: 1
+
+Function: "erf_upward":
+double: 1
+float: 1
+
+Function: "erfc":
+double: 5
+float: 3
+
+Function: "erfc_downward":
+double: 5
+float: 6
+
+Function: "erfc_towardzero":
+double: 3
+float: 4
+
+Function: "erfc_upward":
+double: 5
+float: 6
+
+Function: "exp":
+double: 1
+float: 1
+
+Function: "exp10":
+double: 2
+float: 1
+
+Function: "exp10_downward":
+double: 3
+float: 1
+
+Function: "exp10_towardzero":
+double: 3
+float: 1
+
+Function: "exp10_upward":
+double: 2
+float: 1
+
+Function: "exp2":
+double: 1
+
+Function: "exp2_downward":
+double: 1
+
+Function: "exp2_towardzero":
+double: 1
+
+Function: "exp2_upward":
+double: 1
+float: 1
+
+Function: "exp_downward":
+double: 1
+float: 1
+
+Function: "exp_towardzero":
+double: 1
+float: 1
+
+Function: "exp_upward":
+double: 1
+float: 1
+
+Function: "expm1":
+double: 1
+float: 1
+
+Function: "expm1_downward":
+double: 1
+float: 1
+
+Function: "expm1_towardzero":
+double: 1
+float: 2
+
+Function: "expm1_upward":
+double: 1
+float: 1
+
+Function: "gamma":
+double: 4
+float: 7
+
+Function: "gamma_downward":
+double: 7
+float: 7
+
+Function: "gamma_towardzero":
+double: 7
+float: 7
+
+Function: "gamma_upward":
+double: 5
+float: 6
+
+Function: "hypot":
+double: 1
+float: 1
+
+Function: "hypot_downward":
+double: 1
+
+Function: "hypot_towardzero":
+double: 1
+
+Function: "hypot_upward":
+double: 1
+
+Function: "j0":
+double: 2
+float: 9
+
+Function: "j0_downward":
+double: 5
+float: 9
+
+Function: "j0_towardzero":
+double: 6
+float: 9
+
+Function: "j0_upward":
+double: 9
+float: 9
+
+Function: "j1":
+double: 4
+float: 9
+
+Function: "j1_downward":
+double: 5
+float: 8
+
+Function: "j1_towardzero":
+double: 4
+float: 8
+
+Function: "j1_upward":
+double: 9
+float: 9
+
+Function: "jn":
+double: 4
+float: 4
+
+Function: "jn_downward":
+double: 7
+float: 9
+
+Function: "jn_towardzero":
+double: 7
+float: 9
+
+Function: "jn_upward":
+double: 7
+float: 9
+
+Function: "lgamma":
+double: 4
+float: 7
+
+Function: "lgamma_downward":
+double: 7
+float: 7
+
+Function: "lgamma_towardzero":
+double: 7
+float: 7
+
+Function: "lgamma_upward":
+double: 5
+float: 6
+
+Function: "log10":
+double: 2
+float: 2
+
+Function: "log10_downward":
+double: 2
+float: 3
+
+Function: "log10_towardzero":
+double: 2
+float: 1
+
+Function: "log10_upward":
+double: 2
+float: 2
+
+Function: "log1p":
+double: 1
+float: 1
+
+Function: "log1p_downward":
+double: 2
+float: 2
+
+Function: "log1p_towardzero":
+double: 2
+float: 2
+
+Function: "log1p_upward":
+double: 2
+float: 2
+
+Function: "log2":
+float: 1
+
+Function: "log2_downward":
+double: 1
+
+Function: "log2_towardzero":
+double: 1
+
+Function: "log2_upward":
+double: 1
+
+Function: "pow":
+double: 1
+
+Function: "pow_downward":
+double: 1
+float: 1
+
+Function: "pow_towardzero":
+double: 1
+float: 1
+
+Function: "pow_upward":
+double: 1
+float: 1
+
+Function: "sin":
+double: 1
+float: 1
+
+Function: "sin_downward":
+double: 4
+float: 1
+
+Function: "sin_towardzero":
+double: 3
+float: 1
+
+Function: "sin_upward":
+double: 7
+float: 1
+
+Function: "sincos":
+double: 1
+
+Function: "sincos_downward":
+double: 1
+float: 1
+
+Function: "sincos_towardzero":
+double: 4
+float: 1
+
+Function: "sincos_upward":
+double: 1
+float: 1
+
+Function: "sinh":
+double: 2
+float: 2
+
+Function: "sinh_downward":
+double: 3
+float: 3
+
+Function: "sinh_towardzero":
+double: 3
+float: 2
+
+Function: "sinh_upward":
+double: 3
+float: 3
+
+Function: "tan":
+float: 1
+
+Function: "tan_downward":
+double: 1
+float: 2
+
+Function: "tan_towardzero":
+double: 1
+float: 1
+
+Function: "tan_upward":
+double: 1
+float: 1
+
+Function: "tanh":
+double: 2
+float: 2
+
+Function: "tanh_downward":
+double: 3
+float: 3
+
+Function: "tanh_towardzero":
+double: 2
+float: 2
+
+Function: "tanh_upward":
+double: 3
+float: 3
+
+Function: "tgamma":
+double: 9
+float: 8
+
+Function: "tgamma_downward":
+double: 9
+float: 9
+
+Function: "tgamma_towardzero":
+double: 9
+float: 8
+
+Function: "tgamma_upward":
+double: 9
+float: 8
+
+Function: "y0":
+double: 3
+float: 9
+
+Function: "y0_downward":
+double: 3
+float: 9
+
+Function: "y0_towardzero":
+double: 4
+float: 9
+
+Function: "y0_upward":
+double: 3
+float: 9
+
+Function: "y1":
+double: 3
+float: 9
+
+Function: "y1_downward":
+double: 6
+float: 9
+
+Function: "y1_towardzero":
+double: 3
+float: 9
+
+Function: "y1_upward":
+double: 7
+float: 9
+
+Function: "yn":
+double: 3
+float: 3
+
+Function: "yn_downward":
+double: 6
+float: 8
+
+Function: "yn_towardzero":
+double: 8
+float: 8
+
+Function: "yn_upward":
+double: 8
+float: 8
+
+# end of automatic generation
diff --git a/sysdeps/or1k/fpu/libm-test-ulps-name b/sysdeps/or1k/fpu/libm-test-ulps-name
new file mode 100644
index 0000000000..7f72f7a873
--- /dev/null
+++ b/sysdeps/or1k/fpu/libm-test-ulps-name
@@ -0,0 +1 @@
+OpenRISC hard-float
diff --git a/sysdeps/or1k/fpu_control.h b/sysdeps/or1k/fpu_control.h
new file mode 100644
index 0000000000..4ac03db7a9
--- /dev/null
+++ b/sysdeps/or1k/fpu_control.h
@@ -0,0 +1,61 @@
+/* FPU control word bits.  OpenRISC version.
+   Copyright (C) 2024 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef _FPU_CONTROL_H
+#define _FPU_CONTROL_H
+
+#ifndef __or1k_hard_float__
+
+# define _FPU_RESERVED 0xffffffff
+# define _FPU_DEFAULT  0x00000000
+# define _FPU_GETCW(cw) (cw) = 0
+# define _FPU_SETCW(cw) (void) (cw)
+
+#else /* __or1k_hard_float__ */
+
+/* Layout of FPCSR:
+
+ +-----------+----------------------------+-----+----+
+ |  32 - 12  | 11 10  9  8  7  6  5  4  3 | 2-1 |  0 |
+ +-----------+----------------------------+-----+----+
+ |  Reserved | DZ IN IV IX  Z QN SN UN OV | RM  | EE |
+ +-----------+----------------------------+-----+----+
+
+ */
+
+# define _FPU_RESERVED 0xfffff000
+/* Default: rounding to nearest with exceptions disabled.  */
+# define _FPU_DEFAULT  0
+/* IEEE: Same as above with exceptions enabled.  */
+# define _FPU_IEEE     (_FPU_DEFAULT | 1)
+
+# define _FPU_FPCSR_RM_MASK (0x3 << 1)
+
+/* Macros for accessing the hardware control word.  */
+# define _FPU_GETCW(cw) __asm__ volatile ("l.mfspr %0,r0,20" : "=r" (cw))
+# define _FPU_SETCW(cw) __asm__ volatile ("l.mtspr r0,%0,20" : : "r" (cw))
+
+#endif /* __or1k_hard_float__ */
+
+/* Type of the control word.  */
+typedef unsigned int fpu_control_t;
+
+/* Default control word set at startup.  */
+extern fpu_control_t __fpu_control;
+
+#endif	/* fpu_control.h */
diff --git a/sysdeps/or1k/libm-test-ulps-name b/sysdeps/or1k/libm-test-ulps-name
deleted file mode 100644
index 0af6591fd9..0000000000
--- a/sysdeps/or1k/libm-test-ulps-name
+++ /dev/null
@@ -1 +0,0 @@
-OpenRISC
diff --git a/sysdeps/or1k/math-tests-snan-payload.h b/sysdeps/or1k/math-tests-snan-payload.h
new file mode 100644
index 0000000000..62467a371c
--- /dev/null
+++ b/sysdeps/or1k/math-tests-snan-payload.h
@@ -0,0 +1,26 @@
+/* Configuration for math tests: sNaN payloads.  OpenRISC version.
+   Copyright (C) 2024 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef OR1K_MATH_TESTS_SNAN_PAYLOAD_H
+#define OR1K_MATH_TESTS_SNAN_PAYLOAD_H 1
+
+/* OpenRISC floating-point instructions do not preserve NaN
+   payloads.  */
+#define SNAN_TESTS_PRESERVE_PAYLOAD	0
+
+#endif /* math-tests-snan-payload.h */
diff --git a/sysdeps/or1k/math-tests-trap.h b/sysdeps/or1k/math-tests-trap.h
new file mode 100644
index 0000000000..a95b42d66d
--- /dev/null
+++ b/sysdeps/or1k/math-tests-trap.h
@@ -0,0 +1,27 @@
+/* Configuration for math tests: support for enabling exception traps.
+   OpenRISC version.
+   Copyright (C) 2024 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <https://www.gnu.org/licenses/>.  */
+
+#ifndef OR1K_MATH_TESTS_TRAP_H
+#define OR1K_MATH_TESTS_TRAP_H 1
+
+#include <fenv.h>
+
+#define EXCEPTION_ENABLE_SUPPORTED(EXCEPT)	((EXCEPT) == 0)
+
+#endif /* math-tests-trap.h */
diff --git a/sysdeps/or1k/libm-test-ulps b/sysdeps/or1k/nofpu/libm-test-ulps
similarity index 100%
rename from sysdeps/or1k/libm-test-ulps
rename to sysdeps/or1k/nofpu/libm-test-ulps
diff --git a/sysdeps/or1k/nofpu/libm-test-ulps-name b/sysdeps/or1k/nofpu/libm-test-ulps-name
new file mode 100644
index 0000000000..76c66a0e53
--- /dev/null
+++ b/sysdeps/or1k/nofpu/libm-test-ulps-name
@@ -0,0 +1 @@
+OpenRISC soft-float
diff --git a/sysdeps/or1k/sfp-machine.h b/sysdeps/or1k/sfp-machine.h
index d17fd37730..e58e683969 100644
--- a/sysdeps/or1k/sfp-machine.h
+++ b/sysdeps/or1k/sfp-machine.h
@@ -36,7 +36,6 @@
 #define _FP_MUL_MEAT_DW_Q(R,X,Y)				\
   _FP_MUL_MEAT_DW_4_wide(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
 
-
 #define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_loop(S,R,X,Y)
 #define _FP_DIV_MEAT_D(R,X,Y)	_FP_DIV_MEAT_2_udiv(D,R,X,Y)
 #define _FP_DIV_MEAT_Q(R,X,Y)	_FP_DIV_MEAT_4_udiv(Q,R,X,Y)
@@ -90,4 +89,21 @@
 
 #define FP_ROUNDMODE (_fpcsr & FP_RND_MASK)
 
+#ifdef __or1k_hard_float__
+#define FP_INIT_ROUNDMODE					\
+do {								\
+  __asm__ volatile ("l.mfspr %0,r0,20" : "=r" (_fpcsr));	\
+} while (0)
+
+#define FP_HANDLE_EXCEPTIONS					\
+do {								\
+  if (__builtin_expect (_fex, 0))				\
+    {								\
+      _fpcsr &= ~FP_EX_ALL;					\
+      _fpcsr |= _fex;						\
+      __asm__ volatile ("l.mtspr r0,%0,20" : : "r" (_fpcsr));	\
+    }								\
+} while (0)
+#endif /* __or1k_hard_float__ */
+
 #define _FP_TININESS_AFTER_ROUNDING 0
diff --git a/sysdeps/unix/sysv/linux/or1k/getcontext.S b/sysdeps/unix/sysv/linux/or1k/getcontext.S
index a25b377bda..397b9e4c60 100644
--- a/sysdeps/unix/sysv/linux/or1k/getcontext.S
+++ b/sysdeps/unix/sysv/linux/or1k/getcontext.S
@@ -46,6 +46,12 @@ ENTRY(__getcontext)
 	l.sw	(UCONTEXT_MCONTEXT + 28*4)(r3), r28
 	l.sw	(UCONTEXT_MCONTEXT + 30*4)(r3), r30
 
+#ifdef __or1k_hard_float__
+	/* Store the floating point state.  */
+	l.mfspr	r4, r0, 20
+	l.sw	(MCONTEXT_FPCSR)(r3), r4
+#endif /* __or1k_hard_float__ */
+
 	/* Get signal mask.  */
 	/* rt_sigprocmask (SIG_BLOCK, NULL, &ucp->uc_sigmask, _NSIG8) */
 	l.ori	r6, r0, _NSIG8
diff --git a/sysdeps/unix/sysv/linux/or1k/setcontext.S b/sysdeps/unix/sysv/linux/or1k/setcontext.S
index d28a0ac0aa..4bf258b6f1 100644
--- a/sysdeps/unix/sysv/linux/or1k/setcontext.S
+++ b/sysdeps/unix/sysv/linux/or1k/setcontext.S
@@ -40,6 +40,12 @@ ENTRY(__setcontext)
 	l.bf	1f
 	 l.nop
 
+#ifdef __or1k_hard_float__
+	/* Restore the floating point state.  */
+	l.lwz	r28, (MCONTEXT_FPCSR)(r30)
+	l.mtspr	r0, r28, 20
+#endif /* __or1k_hard_float__ */
+
 	/* Restore argument registers, for the makecontext case.  */
 	l.lwz	r3, (UCONTEXT_MCONTEXT +  3*4)(r30)
 	l.lwz	r4, (UCONTEXT_MCONTEXT +  4*4)(r30)
diff --git a/sysdeps/unix/sysv/linux/or1k/swapcontext.S b/sysdeps/unix/sysv/linux/or1k/swapcontext.S
index d09651a5b2..dfc788812c 100644
--- a/sysdeps/unix/sysv/linux/or1k/swapcontext.S
+++ b/sysdeps/unix/sysv/linux/or1k/swapcontext.S
@@ -45,6 +45,12 @@ ENTRY(__swapcontext)
 	l.sw	(UCONTEXT_MCONTEXT + 28*4)(r3), r28
 	l.sw	(UCONTEXT_MCONTEXT + 30*4)(r3), r30
 
+#ifdef __or1k_hard_float__
+	/* Store the floating point state.  */
+	l.mfspr	r6, r0, 20
+	l.sw	(MCONTEXT_FPCSR)(r3), r6
+#endif /* __or1k_hard_float__ */
+
 	/* Store ucp to non-argument syscall preserved register.  */
 	l.ori	r30, r4, 0
 
@@ -82,6 +88,12 @@ ENTRY(__swapcontext)
 	l.bf	1f
 	 l.nop
 
+#ifdef __or1k_hard_float__
+	/* Restore the floating point state.  */
+	l.lwz	r28, (MCONTEXT_FPCSR)(r30)
+	l.mtspr	r0, r28, 20
+#endif /* __or1k_hard_float__ */
+
 	/* Restore argument registers, for the makecontext case.  */
 	l.lwz	r3, (UCONTEXT_MCONTEXT +  3*4)(r30)
 	l.lwz	r4, (UCONTEXT_MCONTEXT +  4*4)(r30)
diff --git a/sysdeps/unix/sysv/linux/or1k/sys/ucontext.h b/sysdeps/unix/sysv/linux/or1k/sys/ucontext.h
index b17e919154..1b428592ee 100644
--- a/sysdeps/unix/sysv/linux/or1k/sys/ucontext.h
+++ b/sysdeps/unix/sysv/linux/or1k/sys/ucontext.h
@@ -38,6 +38,7 @@ typedef struct
     unsigned long int __gprs[__NGREG];
     unsigned long int __pc;
     unsigned long int __sr;
+    unsigned long int __fpcsr;
   } mcontext_t;
 
 /* Userlevel context.  */
diff --git a/sysdeps/unix/sysv/linux/or1k/ucontext_i.sym b/sysdeps/unix/sysv/linux/or1k/ucontext_i.sym
index a8d4db080f..45cd72527d 100644
--- a/sysdeps/unix/sysv/linux/or1k/ucontext_i.sym
+++ b/sysdeps/unix/sysv/linux/or1k/ucontext_i.sym
@@ -13,6 +13,7 @@ _NSIG8				(_NSIG / 8)
 -- Offsets of the fields in the ucontext_t structure.
 #define ucontext(member)	offsetof (ucontext_t, member)
 #define stack(member)		ucontext (uc_stack.member)
+#define mcontext(member)	ucontext (uc_mcontext.member)
 
 UCONTEXT_LINK			ucontext (uc_link)
 UCONTEXT_STACK			ucontext (uc_stack)
@@ -23,4 +24,6 @@ STACK_SP			stack (ss_sp)
 STACK_SIZE			stack (ss_size)
 STACK_FLAGS			stack (ss_flags)
 
+MCONTEXT_FPCSR			mcontext (__fpcsr)
+
 UCONTEXT_SIZE			sizeof (ucontext_t)
-- 
2.44.0

