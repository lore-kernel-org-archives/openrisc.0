Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020DBDDCB
	for <linux-openrisc@vger.kernel.org>; Mon, 29 Apr 2024 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714369675; cv=none; b=lk6w+Yebn++r2cEf/xfr/OdzOfXvDaDHDR2nDAN0Ieaw8c43mHjVngo9dxmqNjwN34zmwVgM78IG3Rd0uUEIs2P6p43M4x1BwRMFLEDB8Kc+BG5XjMgRzBbFtzSym4Ka8a/wI+zQx/cIWzv7bXU/mFUdZT+HrR7NwjkJtjqmguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714369675; c=relaxed/simple;
	bh=4q6vAjkjJg0+95T0xpKeLlTb0MO99yBnT23eNzXFgpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNl3qUqgS3ccyuJYv8gQZRIVFUBBYP+G1OI521qJwlSYwAXn1hzIsuOlQZPckHf5lznlQBDpyKyuJC8TN5Rq3f2LFp7oMt/Z3Id0xXthpv6V0hN6w9smx3/RKAJkHjSrHsUJVcIOvKILvs3ZImLuGogOt+BEugv/zyCkoxrkQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVKo7QTx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVKo7QTx"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41c011bb920so4766305e9.1
        for <linux-openrisc@vger.kernel.org>; Sun, 28 Apr 2024 22:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714369669; x=1714974469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bl2zidldAzHBbGK9N+PpetrZ8ErzFoH8vR1P0D5Cdk=;
        b=PVKo7QTxQ5BN2hk3yI2W1mIk7xCf8qN3JBcWFRpwHRIv4kE5X38VXXfCSdj3fIrBJ/
         aLKrB6kgXc0K/3lF9qP0eZ7D+uqvACn3KtwaRGNZmY6o8A/xDaeUJvWxi5S/YbfJr/Ft
         bWCVnoDR+gpKye46F7rGK6UvMwbnoyLjInV+Pe3NeYCJXktjN4dSRNPgD4hJrDBOwzWT
         72nAayniSPDEdhWhdhwaKDMB3NYlcFGHoTBC4XjoMcZaS+2zr6YJnKUk1dtd/Gzihq3b
         fLCsoSs6ryNkYRYlHuVvMl5bGlSFV3NDi54XyzwpRt5KfIw5uzlGyuUeo0bUP/fPc+8q
         ToZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714369669; x=1714974469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bl2zidldAzHBbGK9N+PpetrZ8ErzFoH8vR1P0D5Cdk=;
        b=CfIFz4xN2M4qJKrxdI3IyMCs8dME2N82KpBOgqyhyD3lWrXUAvmOzbmbFK1mmLPf77
         3RIJ282Q3kP8dxxCE1B28QmFew/aU0yVJKd6f4zd9Eh6jDVsQio+PggLsKgnVW3HNI+D
         XfsGZipJWFBk4r9mIWIYqOZjOA9zk/E8SW2CoPPVrrtXA7QyUmM/co3YlU4uLc2JKT7t
         moptSmM6GrSPvNyz6qEBh9s4fRqTYKQ96qiB3lTkajiNdRs4Yd5LG8Umxu/6H+jPjPp7
         Eq1WhVRtHsClZPK5xUT2ax3QP12IDz/v56pGznSRtirHBx8EASf95chr4OvumoTFCn9U
         G8aw==
X-Gm-Message-State: AOJu0YztJhEieNJSDCg4YUgX9BkkyYf/5rRnGUFpUHEJvRTigFEhT3PQ
	YybH2UFINr5EV4I4OgE49bJBdQq9kdc6TMbAGil8j1dFrLZI+eoAje17ig==
X-Google-Smtp-Source: AGHT+IH9Wb28nnLZ8DDRwtsirs/oPDP0JNbS9fouYOewLeeIgfpilc8N4s4vC5uhkEG69YcbKp9cww==
X-Received: by 2002:a05:600c:3b99:b0:418:7ec1:7bdb with SMTP id n25-20020a05600c3b9900b004187ec17bdbmr5471061wms.5.1714369668339;
        Sun, 28 Apr 2024 22:47:48 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id fm18-20020a05600c0c1200b0041b5500e438sm14375574wmb.23.2024.04.28.22.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 22:47:45 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 2/3] or1k: Add hard float support
Date: Mon, 29 Apr 2024 06:47:34 +0100
Message-ID: <20240429054735.2467433-3-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429054735.2467433-1-shorne@gmail.com>
References: <20240429054735.2467433-1-shorne@gmail.com>
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
an ABI fix.  The Linux kernel has always defined padding in mcontext_t
that space was missing from the glibc ABI.  In Linux this unused space
has now been re-purposed for storing the FPCSR.  This patch brings
OpenRISC glibc in line with the Linux kernel and other libc
implementation (musl).

Compatibility getcontext, setcontext, etc symbols have been added to
allow for binaries expecting the old ABI to continue to work.

*Hard float ABI*

The calling conventions and types do not change with OpenRISC hard-float
so glibc hard-float builds continue to use dynamic linker
/lib/ld-linux-or1k.so.1.

*Testing*

I have tested this patch both with hard-float and soft-float builds and
the test results look fine to me.  Results are as follows:

Hard Float

    # failures
    FAIL: elf/tst-sprof-basic		(Haven't figured out yet, not related to hard-float)
    FAIL: gmon/tst-gmon-pie		(PIE bug in or1k toolchain)
    FAIL: gmon/tst-gmon-pie-gprof	(PIE bug in or1k toolchain)
    FAIL: iconvdata/iconv-test		(timeout, passed when run manually)
    FAIL: nptl/tst-cond24		(Timeout)
    FAIL: nptl/tst-mutex10		(Timeout)

    # summary
	  6 FAIL
       4289 PASS
	 86 UNSUPPORTED
	 16 XFAIL
	  2 XPASS

    # versions
    Toolchain: or1k-smhfpu-linux-gnu
    Compiler:  gcc version 14.0.1 20240324 (experimental) [master r14-9649-gbb04a11418f] (GCC)
    Binutils:  GNU assembler version 2.42.0 (or1k-smhfpu-linux-gnu) using BFD version (GNU Binutils) 2.42.0.20240324
    Linux:     Linux buildroot 6.9.0-rc1-00008-g4dc70e1aadfa #112 SMP Sat Apr 27 06:43:11 BST 2024 openrisc GNU/Linux
    Tester:    shorne
    Glibc:     2024-04-25 b62928f907 Florian Weimer   x86: In ld.so, diagnose missing APX support in APX-only builds  (origin/master, origin/HEAD)

Soft Float

    # failures
    FAIL: elf/tst-sprof-basic
    FAIL: gmon/tst-gmon-pie
    FAIL: gmon/tst-gmon-pie-gprof
    FAIL: nptl/tst-cond24
    FAIL: nptl/tst-mutex10

    # summary
	  5 FAIL
       4295 PASS
	 81 UNSUPPORTED
	 16 XFAIL
	  2 XPASS

    # versions
    Toolchain: or1k-smh-linux-gnu
    Compiler:  gcc version 14.0.1 20240324 (experimental) [master r14-9649-gbb04a11418f] (GCC)
    Binutils:  GNU assembler version 2.42.0 (or1k-smh-linux-gnu) using BFD version (GNU Binutils) 2.42.0.20240324
    Linux:     Linux buildroot 6.9.0-rc1-00008-g4dc70e1aadfa #112 SMP Sat Apr 27 06:43:11 BST 2024 openrisc GNU/Linux
    Tester:    shorne
    Glibc:     2024-04-25 b62928f907 Florian Weimer   x86: In ld.so, diagnose missing APX support in APX-only builds  (origin/master, origin/HEAD)

Documentation: https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.4-rev0.pdf
---
Since v1:
 - Moved ulps file to a previous patch
 - Added getcontext, setcontext, swapcontext, compat symbols

 sysdeps/or1k/fpu/fclrexcpt.c                  |  44 ++++
 sysdeps/or1k/fpu/fegetenv.c                   |  32 +++
 sysdeps/or1k/fpu/fegetmode.c                  |  29 +++
 sysdeps/or1k/fpu/fegetround.c                 |  29 +++
 sysdeps/or1k/fpu/feholdexcpt.c                |  33 +++
 sysdeps/or1k/fpu/fenv_private.h               | 199 ++++++++++++++++++
 sysdeps/or1k/fpu/fesetenv.c                   |  32 +++
 sysdeps/or1k/fpu/fesetexcept.c                |  35 +++
 sysdeps/or1k/fpu/fesetmode.c                  |  39 ++++
 sysdeps/or1k/fpu/fesetround.c                 |  39 ++++
 sysdeps/or1k/fpu/feupdateenv.c                |  33 +++
 sysdeps/or1k/fpu/fgetexcptflg.c               |  29 +++
 .../or1k/fpu/fix-fp-int-convert-overflow.h    |  38 ++++
 sysdeps/or1k/fpu/fraiseexcpt.c                |  67 ++++++
 sysdeps/or1k/fpu/fsetexcptflg.c               |  43 ++++
 sysdeps/or1k/fpu/ftestexcept.c                |  27 +++
 sysdeps/or1k/fpu/get-rounding-mode.h          |  38 ++++
 sysdeps/or1k/fpu_control.h                    |  61 ++++++
 sysdeps/or1k/math-tests-snan-payload.h        |  26 +++
 sysdeps/or1k/math-tests-trap.h                |  27 +++
 sysdeps/or1k/sfp-machine.h                    |  18 +-
 sysdeps/unix/sysv/linux/or1k/Versions         |  14 ++
 .../unix/sysv/linux/or1k/getcontext-common.S  |  88 ++++++++
 sysdeps/unix/sysv/linux/or1k/getcontext.S     |  69 +++---
 sysdeps/unix/sysv/linux/or1k/libc.abilist     |   4 +
 sysdeps/unix/sysv/linux/or1k/makecontext.c    |  49 ++++-
 .../unix/sysv/linux/or1k/setcontext-common.S  | 120 +++++++++++
 sysdeps/unix/sysv/linux/or1k/setcontext.S     | 102 +++------
 .../unix/sysv/linux/or1k/swapcontext-common.S | 139 ++++++++++++
 sysdeps/unix/sysv/linux/or1k/swapcontext.S    | 109 ++--------
 sysdeps/unix/sysv/linux/or1k/sys/ucontext.h   |   1 +
 sysdeps/unix/sysv/linux/or1k/ucontext_i.sym   |   3 +
 32 files changed, 1397 insertions(+), 219 deletions(-)
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
 create mode 100644 sysdeps/or1k/fpu_control.h
 create mode 100644 sysdeps/or1k/math-tests-snan-payload.h
 create mode 100644 sysdeps/or1k/math-tests-trap.h
 create mode 100644 sysdeps/unix/sysv/linux/or1k/Versions
 create mode 100644 sysdeps/unix/sysv/linux/or1k/getcontext-common.S
 create mode 100644 sysdeps/unix/sysv/linux/or1k/setcontext-common.S
 create mode 100644 sysdeps/unix/sysv/linux/or1k/swapcontext-common.S

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
diff --git a/sysdeps/unix/sysv/linux/or1k/Versions b/sysdeps/unix/sysv/linux/or1k/Versions
new file mode 100644
index 0000000000..c1299de116
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/Versions
@@ -0,0 +1,14 @@
+libc {
+  GLIBC_2.35 {
+    getcontext;
+    setcontext;
+    swapcontext;
+    makecontext;
+  }
+  GLIBC_2.40 {
+    getcontext;
+    setcontext;
+    swapcontext;
+    makecontext;
+  }
+}
diff --git a/sysdeps/unix/sysv/linux/or1k/getcontext-common.S b/sysdeps/unix/sysv/linux/or1k/getcontext-common.S
new file mode 100644
index 0000000000..9187749615
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/getcontext-common.S
@@ -0,0 +1,88 @@
+/* Save current context.  OpenRISC common version.
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
+/* This common getcontext template helps define different
+   implementations using control macros.  Before including
+   this file in another file define the following:
+
+     __CONTEXT_FUNC_NAME
+     __CONTEXT_ENABLE_FPCSR
+     __CONTEXT_SIGMASK_OFFSET
+ */
+
+/* int getcontext (ucontext_t *ucp)
+
+   Returns 0 on success -1 and errno on failure.
+ */
+	.text
+ENTRY(__CONTEXT_FUNC_NAME)
+	/* Store r1, the stack pointer.  */
+	l.sw	(UCONTEXT_MCONTEXT +  1*4)(r3), r1
+	/* Store r2, the frame pointer.  */
+	l.sw	(UCONTEXT_MCONTEXT +  2*4)(r3), r2
+	/* Store r9, the link register.  */
+	l.sw	(UCONTEXT_MCONTEXT +  9*4)(r3), r9
+	/* Store r9 to reg[11] too, as we need two links for makecontext.  */
+	l.sw	(UCONTEXT_MCONTEXT + 11*4)(r3), r9
+	/* Store r10, the TLS register.  */
+	l.sw	(UCONTEXT_MCONTEXT + 10*4)(r3), r10
+	/* Store r14-r30 even, callee saved registers.  */
+	l.sw	(UCONTEXT_MCONTEXT + 14*4)(r3), r14
+	l.sw	(UCONTEXT_MCONTEXT + 16*4)(r3), r16
+	l.sw	(UCONTEXT_MCONTEXT + 18*4)(r3), r18
+	l.sw	(UCONTEXT_MCONTEXT + 20*4)(r3), r20
+	l.sw	(UCONTEXT_MCONTEXT + 22*4)(r3), r22
+	l.sw	(UCONTEXT_MCONTEXT + 24*4)(r3), r24
+	l.sw	(UCONTEXT_MCONTEXT + 26*4)(r3), r26
+	l.sw	(UCONTEXT_MCONTEXT + 28*4)(r3), r28
+	l.sw	(UCONTEXT_MCONTEXT + 30*4)(r3), r30
+
+#ifdef __CONTEXT_ENABLE_FPCSR
+# ifdef __or1k_hard_float__
+	/* Store the floating point state.  */
+	l.mfspr	r4, r0, 20
+	l.sw	(MCONTEXT_FPCSR)(r3), r4
+# else
+	/* Store zero to indicate default rounding as per softfloat.  */
+	l.sw	(MCONTEXT_FPCSR)(r3), r0
+# endif /* __or1k_hard_float__ */
+#endif /* __CONTEXT_ENABLE_FPCSR */
+
+	/* Get signal mask.  */
+	/* rt_sigprocmask (SIG_BLOCK, NULL, &ucp->uc_sigmask, _NSIG8) */
+	l.ori	r6, r0, _NSIG8
+	l.addi	r5, r3, __CONTEXT_SIGMASK_OFFSET
+	l.ori	r4, r0, 0
+	l.ori	r3, r0, SIG_BLOCK
+	l.ori	r11, r0, SYS_ify (rt_sigprocmask)
+	/* Do the syscall.  */
+	l.sys	1
+	 l.nop
+
+	/* if -4096 < ret < 0 holds, it's an error */
+	l.sfgeui r11, 0xf001
+	l.bf	1f
+	 l.nop
+
+	l.jr	r9
+	 l.ori r11, r0, 0
+
+1:	l.j	__syscall_error
+	 l.ori	r3, r11, 0
+
+END(__CONTEXT_FUNC_NAME)
diff --git a/sysdeps/unix/sysv/linux/or1k/getcontext.S b/sysdeps/unix/sysv/linux/or1k/getcontext.S
index a25b377bda..da69e6999c 100644
--- a/sysdeps/unix/sysv/linux/or1k/getcontext.S
+++ b/sysdeps/unix/sysv/linux/or1k/getcontext.S
@@ -17,56 +17,35 @@
    <https://www.gnu.org/licenses/>.  */
 
 #include <sysdep.h>
+#include <shlib-compat.h>
 #include "ucontext_i.h"
 
-/* int getcontext (ucontext_t *ucp)
+#define __CONTEXT_FUNC_NAME __getcontext
+#define __CONTEXT_ENABLE_FPCSR 1
+#define __CONTEXT_SIGMASK_OFFSET UCONTEXT_SIGMASK
 
-   Returns 0 on success -1 and errno on failure.
- */
-	.text
-ENTRY(__getcontext)
-	/* Store r1, the stack pointer.  */
-	l.sw	(UCONTEXT_MCONTEXT +  1*4)(r3), r1
-	/* Store r2, the frame pointer.  */
-	l.sw	(UCONTEXT_MCONTEXT +  2*4)(r3), r2
-	/* Store r9, the link register.  */
-	l.sw	(UCONTEXT_MCONTEXT +  9*4)(r3), r9
-	/* Store r9 to reg[11] too, as we need two links for makecontext.  */
-	l.sw	(UCONTEXT_MCONTEXT + 11*4)(r3), r9
-	/* Store r10, the TLS register.  */
-	l.sw	(UCONTEXT_MCONTEXT + 10*4)(r3), r10
-	/* Store r14-r30 even, callee saved registers.  */
-	l.sw	(UCONTEXT_MCONTEXT + 14*4)(r3), r14
-	l.sw	(UCONTEXT_MCONTEXT + 16*4)(r3), r16
-	l.sw	(UCONTEXT_MCONTEXT + 18*4)(r3), r18
-	l.sw	(UCONTEXT_MCONTEXT + 20*4)(r3), r20
-	l.sw	(UCONTEXT_MCONTEXT + 22*4)(r3), r22
-	l.sw	(UCONTEXT_MCONTEXT + 24*4)(r3), r24
-	l.sw	(UCONTEXT_MCONTEXT + 26*4)(r3), r26
-	l.sw	(UCONTEXT_MCONTEXT + 28*4)(r3), r28
-	l.sw	(UCONTEXT_MCONTEXT + 30*4)(r3), r30
+#include "getcontext-common.S"
 
-	/* Get signal mask.  */
-	/* rt_sigprocmask (SIG_BLOCK, NULL, &ucp->uc_sigmask, _NSIG8) */
-	l.ori	r6, r0, _NSIG8
-	l.addi	r5, r3, UCONTEXT_SIGMASK
-	l.ori	r4, r0, 0
-	l.ori	r3, r0, SIG_BLOCK
-	l.ori	r11, r0, SYS_ify (rt_sigprocmask)
-	/* Do the syscall.  */
-	l.sys	1
-	 l.nop
+versioned_symbol (libc, __getcontext, getcontext, GLIBC_2_40)
 
-	/* if -4096 < ret < 0 holds, it's an error */
-	l.sfgeui r11, 0xf001
-	l.bf	1f
-	 l.nop
+#if SHLIB_COMPAT (libc, GLIBC_2_35, GLIBC_2_40)
 
-	l.jr	r9
-	 l.ori r11, r0, 0
+/* Define a compat version of getcontext for glibc's before the fpcsr
+   field was added to mcontext_t.  The offset sigmask changed with this
+   introduction, the change was done because glibc's definition of
+   ucontext_t was initially defined incompatible with the Linux
+   definition of ucontext_t.  We keep the compatability definition to
+   allow getcontext, setcontext and swapcontext to work in older
+   binaries.  */
 
-1:	l.j	__syscall_error
-	 l.ori	r3, r11, 0
+# undef __CONTEXT_FUNC_NAME
+# undef __CONTEXT_ENABLE_FPCSR
+# undef __CONTEXT_SIGMASK_OFFSET
+# define __CONTEXT_FUNC_NAME __getcontext_nofpcsr
+# define __CONTEXT_SIGMASK_OFFSET (UCONTEXT_SIGMASK - 4)
 
-END(__getcontext)
-weak_alias(__getcontext, getcontext)
+# include "getcontext-common.S"
+
+compat_symbol (libc, __getcontext_nofpcsr, getcontext, GLIBC_2_35)
+
+#endif
diff --git a/sysdeps/unix/sysv/linux/or1k/libc.abilist b/sysdeps/unix/sysv/linux/or1k/libc.abilist
index c40c843aaf..959e59e7e7 100644
--- a/sysdeps/unix/sysv/linux/or1k/libc.abilist
+++ b/sysdeps/unix/sysv/linux/or1k/libc.abilist
@@ -2255,3 +2255,7 @@ GLIBC_2.39 stdc_trailing_zeros_ui F
 GLIBC_2.39 stdc_trailing_zeros_ul F
 GLIBC_2.39 stdc_trailing_zeros_ull F
 GLIBC_2.39 stdc_trailing_zeros_us F
+GLIBC_2.40 getcontext F
+GLIBC_2.40 makecontext F
+GLIBC_2.40 setcontext F
+GLIBC_2.40 swapcontext F
diff --git a/sysdeps/unix/sysv/linux/or1k/makecontext.c b/sysdeps/unix/sysv/linux/or1k/makecontext.c
index fa6626e7de..7e131bae41 100644
--- a/sysdeps/unix/sysv/linux/or1k/makecontext.c
+++ b/sysdeps/unix/sysv/linux/or1k/makecontext.c
@@ -16,6 +16,7 @@
    License along with the GNU C Library; if not, see
    <https://www.gnu.org/licenses/>.  */
 
+#include <shlib-compat.h>
 #include <sysdep.h>
 #include <stdarg.h>
 #include <stdint.h>
@@ -36,12 +37,11 @@
      r1     : stack pointer
      r2     : frame pointer, set to NULL
 */
-void
-__makecontext (ucontext_t *ucp, void (*func) (void), int argc, ...)
+static void
+do_makecontext (ucontext_t *ucp, void (*startcontext) (void),
+		void (*func) (void), int argc, va_list ap)
 {
-  extern void __startcontext (void);
   unsigned long int *sp;
-  va_list ap;
   int i;
 
   sp = (unsigned long int *)
@@ -55,8 +55,8 @@ __makecontext (ucontext_t *ucp, void (*func) (void), int argc, ...)
 
   /* Keep uc_link in r14.  */
   ucp->uc_mcontext.__gprs[14] = (uintptr_t) ucp->uc_link;
-  /* Return address points to function __startcontext.  */
-  ucp->uc_mcontext.__gprs[9] = (uintptr_t) &__startcontext;
+  /* Return address points to function startcontext.  */
+  ucp->uc_mcontext.__gprs[9] = (uintptr_t) startcontext;
   /* Frame pointer is null.  */
   ucp->uc_mcontext.__gprs[2] = (uintptr_t) 0;
   /* Restart in user-space starting at 'func'.  */
@@ -64,14 +64,47 @@ __makecontext (ucontext_t *ucp, void (*func) (void), int argc, ...)
   /* Set stack pointer.  */
   ucp->uc_mcontext.__gprs[1] = (uintptr_t) sp;
 
-  va_start (ap, argc);
   for (i = 0; i < argc; ++i)
     if (i < 6)
       ucp->uc_mcontext.__gprs[i + 3] = va_arg (ap, unsigned long int);
     else
       sp[i - 6] = va_arg (ap, unsigned long int);
+}
 
+void
+__makecontext (ucontext_t *ucp, void (*func) (void), int argc, ...)
+{
+  extern void __startcontext (void);
+  va_list ap;
+
+  va_start (ap, argc);
+  do_makecontext (ucp, &__startcontext, func, argc, ap);
   va_end (ap);
 }
 
-weak_alias (__makecontext, makecontext)
+versioned_symbol (libc, __makecontext, makecontext, GLIBC_2_40);
+
+#if SHLIB_COMPAT (libc, GLIBC_2_35, GLIBC_2_40)
+
+/* Define a compat version of makecontext for glibc's before the fpcsr
+   field was added to mcontext_t.  The offset sigmask changed with this
+   introduction, the change was done because glibc's definition of
+   ucontext_t was initially defined incompatible with the Linux
+   definition of ucontext_t.  We keep the compatability definition to
+   allow getcontext, setcontext and swapcontext to work in older
+   binaries.  */
+
+void
+__makecontext_nofpcsr (ucontext_t *ucp, void (*func) (void), int argc, ...)
+{
+  extern void __startcontext_nofpcsr (void);
+  va_list ap;
+
+  va_start (ap, argc);
+  do_makecontext (ucp, &__startcontext_nofpcsr, func, argc, ap);
+  va_end (ap);
+}
+
+compat_symbol (libc, __makecontext_nofpcsr, makecontext, GLIBC_2_35);
+
+#endif
diff --git a/sysdeps/unix/sysv/linux/or1k/setcontext-common.S b/sysdeps/unix/sysv/linux/or1k/setcontext-common.S
new file mode 100644
index 0000000000..8a4f147513
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/setcontext-common.S
@@ -0,0 +1,120 @@
+/* Set current context.  OpenRISC common version.
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
+/* This common setcontext and startcontext template helps define
+   different implementations using control macros.  Before including
+   this file in another file define the following:
+
+     __CONTEXT_FUNC_NAME
+     __CONTEXT_ENABLE_FPCSR
+     __CONTEXT_SIGMASK_OFFSET
+     __STARTCONTEXT_FUNC_NAME
+ */
+
+/* int setcontext (const ucontext_t *ucp) */
+	.text
+ENTRY(__CONTEXT_FUNC_NAME)
+	l.ori	r30, r3, 0
+
+	/* Restore signal mask.  */
+	/* rt_sigprocmask (SIG_SETMASK, &ucp->uc_sigmask, NULL, _NSIG8) */
+	l.ori	r6, r0, _NSIG8
+	l.ori	r5, r0, 0
+	l.addi	r4, r3, __CONTEXT_SIGMASK_OFFSET
+	l.ori	r3, r0, SIG_SETMASK
+	l.ori	r11, r0, SYS_ify (rt_sigprocmask)
+	/* Do the syscall.  */
+	l.sys 1
+	 l.nop
+
+	/* if -4096 < ret < 0 holds, it's an error */
+	l.sfgeui r11, 0xf001
+	l.bf	1f
+	 l.nop
+#ifdef __CONTEXT_ENABLE_FPCSR
+# ifdef __or1k_hard_float__
+	/* Restore the floating point state.  */
+	l.lwz	r28, (MCONTEXT_FPCSR)(r30)
+	l.mtspr	r0, r28, 20
+# endif /* __or1k_hard_float__ */
+#endif /* __CONTEXT_ENABLE_FPCSR */
+	/* Restore argument registers, for the makecontext case.  */
+	l.lwz	r3, (UCONTEXT_MCONTEXT +  3*4)(r30)
+	l.lwz	r4, (UCONTEXT_MCONTEXT +  4*4)(r30)
+	l.lwz	r5, (UCONTEXT_MCONTEXT +  5*4)(r30)
+	l.lwz	r6, (UCONTEXT_MCONTEXT +  6*4)(r30)
+	l.lwz	r7, (UCONTEXT_MCONTEXT +  7*4)(r30)
+	l.lwz	r8, (UCONTEXT_MCONTEXT +  8*4)(r30)
+
+	/* Restore registers stored in getcontext.  */
+	l.lwz	r1,  (UCONTEXT_MCONTEXT +  1*4)(r30)
+	l.lwz	r2,  (UCONTEXT_MCONTEXT +  2*4)(r30)
+	l.lwz	r9,  (UCONTEXT_MCONTEXT +  9*4)(r30)
+	l.lwz	r10, (UCONTEXT_MCONTEXT + 10*4)(r30)
+	l.lwz	r11, (UCONTEXT_MCONTEXT + 11*4)(r30)
+	/* Restore r14-r30 even, callee saved registers.  */
+	l.lwz	r14, (UCONTEXT_MCONTEXT + 14*4)(r30)
+	l.lwz	r16, (UCONTEXT_MCONTEXT + 16*4)(r30)
+	l.lwz	r18, (UCONTEXT_MCONTEXT + 18*4)(r30)
+	l.lwz	r20, (UCONTEXT_MCONTEXT + 20*4)(r30)
+	l.lwz	r22, (UCONTEXT_MCONTEXT + 22*4)(r30)
+	l.lwz	r24, (UCONTEXT_MCONTEXT + 24*4)(r30)
+	l.lwz	r26, (UCONTEXT_MCONTEXT + 26*4)(r30)
+	l.lwz	r28, (UCONTEXT_MCONTEXT + 28*4)(r30)
+	l.lwz	r30, (UCONTEXT_MCONTEXT + 30*4)(r30)
+
+	l.jr	r11
+	 l.ori	r11, r0, 0
+
+1:	l.j	__syscall_error
+	 l.ori	r3, r11, 0
+
+END (__CONTEXT_FUNC_NAME)
+
+	/* We add a NOP here because when the unwinder is looking for the
+	   enclosing function of the link register (r9) address FDE lookup will
+	   use '$r9 - 1' finding setcontext which is wrong.  This is because in
+	   makecontext we have set r9 to the start of &__startcontext.
+
+	   If this NOP did not exist the unwinder would repeatedly find
+	   __setcontext's FDE in an infinite loop.  Modifying/deleting the below
+	   __startcontext's FDE has no help on this.  */
+	l.nop
+
+ENTRY(__STARTCONTEXT_FUNC_NAME)
+
+	l.ori	r3, r14, 0
+	l.sfeq	r3, r0
+	/* If uc_link is not 0 resume there, otherwise exit.  */
+	l.bnf	__CONTEXT_FUNC_NAME
+	 l.nop
+
+#ifdef SHARED
+	/* Obtain a pointer to .got in r16 */
+	l.jal	0x8
+	 l.movhi r16, gotpchi(_GLOBAL_OFFSET_TABLE_-4)
+	l.ori	r16, r16, gotpclo(_GLOBAL_OFFSET_TABLE_+0)
+	l.add	r16, r16, r9
+	l.lwz	r16, got(exit)(r16)
+	l.jr	r16
+#else
+	l.j	exit
+#endif
+	 l.nop
+
+END(__STARTCONTEXT_FUNC_NAME)
diff --git a/sysdeps/unix/sysv/linux/or1k/setcontext.S b/sysdeps/unix/sysv/linux/or1k/setcontext.S
index d28a0ac0aa..a49a5c51c3 100644
--- a/sysdeps/unix/sysv/linux/or1k/setcontext.S
+++ b/sysdeps/unix/sysv/linux/or1k/setcontext.S
@@ -16,93 +16,39 @@
    License along with the GNU C Library; if not, see
    <https://www.gnu.org/licenses/>.  */
 
+#include <shlib-compat.h>
 #include <sysdep.h>
 #include "ucontext_i.h"
 
-/* int setcontext (const ucontext_t *ucp) */
-	.text
-ENTRY(__setcontext)
-	l.ori	r30, r3, 0
+#define __CONTEXT_FUNC_NAME __setcontext
+#define __CONTEXT_ENABLE_FPCSR 1
+#define __CONTEXT_SIGMASK_OFFSET UCONTEXT_SIGMASK
+#define __STARTCONTEXT_FUNC_NAME __startcontext
 
-	/* Restore signal mask.  */
-	/* rt_sigprocmask (SIG_SETMASK, &ucp->uc_sigmask, NULL, _NSIG8) */
-	l.ori	r6, r0, _NSIG8
-	l.ori	r5, r0, 0
-	l.addi	r4, r3, UCONTEXT_SIGMASK
-	l.ori	r3, r0, SIG_SETMASK
-	l.ori	r11, r0, SYS_ify (rt_sigprocmask)
-	/* Do the syscall.  */
-	l.sys 1
-	 l.nop
+#include "setcontext-common.S"
 
-	/* if -4096 < ret < 0 holds, it's an error */
-	l.sfgeui r11, 0xf001
-	l.bf	1f
-	 l.nop
+versioned_symbol (libc, __setcontext, setcontext, GLIBC_2_40)
 
-	/* Restore argument registers, for the makecontext case.  */
-	l.lwz	r3, (UCONTEXT_MCONTEXT +  3*4)(r30)
-	l.lwz	r4, (UCONTEXT_MCONTEXT +  4*4)(r30)
-	l.lwz	r5, (UCONTEXT_MCONTEXT +  5*4)(r30)
-	l.lwz	r6, (UCONTEXT_MCONTEXT +  6*4)(r30)
-	l.lwz	r7, (UCONTEXT_MCONTEXT +  7*4)(r30)
-	l.lwz	r8, (UCONTEXT_MCONTEXT +  8*4)(r30)
+#if SHLIB_COMPAT (libc, GLIBC_2_35, GLIBC_2_40)
 
-	/* Restore registers stored in getcontext.  */
-	l.lwz	r1,  (UCONTEXT_MCONTEXT +  1*4)(r30)
-	l.lwz	r2,  (UCONTEXT_MCONTEXT +  2*4)(r30)
-	l.lwz	r9,  (UCONTEXT_MCONTEXT +  9*4)(r30)
-	l.lwz	r10, (UCONTEXT_MCONTEXT + 10*4)(r30)
-	l.lwz	r11, (UCONTEXT_MCONTEXT + 11*4)(r30)
-	/* Restore r14-r30 even, callee saved registers.  */
-	l.lwz	r14, (UCONTEXT_MCONTEXT + 14*4)(r30)
-	l.lwz	r16, (UCONTEXT_MCONTEXT + 16*4)(r30)
-	l.lwz	r18, (UCONTEXT_MCONTEXT + 18*4)(r30)
-	l.lwz	r20, (UCONTEXT_MCONTEXT + 20*4)(r30)
-	l.lwz	r22, (UCONTEXT_MCONTEXT + 22*4)(r30)
-	l.lwz	r24, (UCONTEXT_MCONTEXT + 24*4)(r30)
-	l.lwz	r26, (UCONTEXT_MCONTEXT + 26*4)(r30)
-	l.lwz	r28, (UCONTEXT_MCONTEXT + 28*4)(r30)
-	l.lwz	r30, (UCONTEXT_MCONTEXT + 30*4)(r30)
+/* Define a compat version of setcontext for glibc's before the fpcsr
+   field was added to mcontext_t.  The offset sigmask changed with this
+   introduction, the change was done because glibc's definition of
+   ucontext_t was initially defined incompatible with the Linux
+   definition of ucontext_t.  We keep the compatability definition to
+   allow getcontext, setcontext and swapcontext to work in older
+   binaries.  */
 
-	l.jr	r11
-	 l.ori	r11, r0, 0
+# undef __CONTEXT_FUNC_NAME
+# undef __CONTEXT_ENABLE_FPCSR
+# undef __CONTEXT_SIGMASK_OFFSET
+# undef __STARTCONTEXT_FUNC_NAME
+# define __CONTEXT_FUNC_NAME __setcontext_nofpcsr
+# define __CONTEXT_SIGMASK_OFFSET (UCONTEXT_SIGMASK - 4)
+# define __STARTCONTEXT_FUNC_NAME __startcontext_nofpcsr
 
-1:	l.j	__syscall_error
-	 l.ori	r3, r11, 0
+# include "setcontext-common.S"
 
-END (__setcontext)
-weak_alias (__setcontext, setcontext)
+compat_symbol (libc, __setcontext_nofpcsr, setcontext, GLIBC_2_35)
 
-	/* We add a NOP here because when the unwinder is looking for the
-	   enclosing function of the link register (r9) address FDE lookup will
-	   use '$r9 - 1' finding setcontext which is wrong.  This is because in
-	   makecontext we have set r9 to the start of &__startcontext.
-
-	   If this NOP did not exist the unwinder would repeatedly find
-	   __setcontext's FDE in an infinite loop.  Modifying/deleting the below
-	   __startcontext's FDE has no help on this.  */
-	l.nop
-
-ENTRY(__startcontext)
-
-	l.ori	r3, r14, 0
-	l.sfeq	r3, r0
-	/* If uc_link is not 0 resume there, otherwise exit.  */
-	l.bnf	__setcontext
-	 l.nop
-
-#ifdef SHARED
-	/* Obtain a pointer to .got in r16 */
-	l.jal	0x8
-	 l.movhi r16, gotpchi(_GLOBAL_OFFSET_TABLE_-4)
-	l.ori	r16, r16, gotpclo(_GLOBAL_OFFSET_TABLE_+0)
-	l.add	r16, r16, r9
-	l.lwz	r16, got(exit)(r16)
-	l.jr	r16
-#else
-	l.j	exit
 #endif
-	 l.nop
-
-END(__startcontext)
diff --git a/sysdeps/unix/sysv/linux/or1k/swapcontext-common.S b/sysdeps/unix/sysv/linux/or1k/swapcontext-common.S
new file mode 100644
index 0000000000..b7e2d4c820
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/swapcontext-common.S
@@ -0,0 +1,139 @@
+/* Swap two contexts.  OpenRISC version.
+   Copyright (C) 2022-2024 Free Software Foundation, Inc.
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
+/* This common swapcontext template helps define different
+   implementations using control macros.  Before including this file
+   in another file define the following:
+
+     __CONTEXT_FUNC_NAME
+     __CONTEXT_ENABLE_FPCSR
+     __CONTEXT_SIGMASK_OFFSET
+ */
+
+/* int swapcontext (ucontext_t *oucp, const ucontext_t *ucp) */
+	.text
+ENTRY(__CONTEXT_FUNC_NAME)
+
+	/* Same as getcontext.  */
+	/* Store r1, the stack pointer.  */
+	l.sw	(UCONTEXT_MCONTEXT +  1*4)(r3), r1
+	/* Store r2, the frame pointer.  */
+	l.sw	(UCONTEXT_MCONTEXT +  2*4)(r3), r2
+	/* Store r9, the link register.  */
+	l.sw	(UCONTEXT_MCONTEXT +  9*4)(r3), r9
+	/* Store r9 to reg[11] too, as we need two links for makecontext.  */
+	l.sw	(UCONTEXT_MCONTEXT + 11*4)(r3), r9
+	/* Store r10, the TLS register.  */
+	l.sw	(UCONTEXT_MCONTEXT + 10*4)(r3), r10
+	/* Store r14-r30 even, callee saved registers.  */
+	l.sw	(UCONTEXT_MCONTEXT + 14*4)(r3), r14
+	l.sw	(UCONTEXT_MCONTEXT + 16*4)(r3), r16
+	l.sw	(UCONTEXT_MCONTEXT + 18*4)(r3), r18
+	l.sw	(UCONTEXT_MCONTEXT + 20*4)(r3), r20
+	l.sw	(UCONTEXT_MCONTEXT + 22*4)(r3), r22
+	l.sw	(UCONTEXT_MCONTEXT + 24*4)(r3), r24
+	l.sw	(UCONTEXT_MCONTEXT + 26*4)(r3), r26
+	l.sw	(UCONTEXT_MCONTEXT + 28*4)(r3), r28
+	l.sw	(UCONTEXT_MCONTEXT + 30*4)(r3), r30
+
+#ifdef __CONTEXT_ENABLE_FPCSR
+# ifdef __or1k_hard_float__
+	/* Store the floating point state.  */
+	l.mfspr	r6, r0, 20
+	l.sw	(MCONTEXT_FPCSR)(r3), r6
+# else
+	/* Store zero to indicate default rounding as per softfloat.  */
+	l.sw	(MCONTEXT_FPCSR)(r3), r0
+# endif /* __or1k_hard_float__ */
+#endif /* __CONTEXT_ENABLE_FPCSR */
+	/* Store ucp to non-argument syscall preserved register.  */
+	l.ori	r30, r4, 0
+
+	/* Get signal mask.  */
+	/* rt_sigprocmask (SIG_BLOCK, NULL, &ucp->uc_sigmask, _NSIG8) */
+	l.ori	r6, r0, _NSIG8
+	l.addi	r5, r3, __CONTEXT_SIGMASK_OFFSET
+	l.ori	r4, r0, 0
+	l.ori	r3, r0, SIG_BLOCK
+	l.ori	r11, r0, SYS_ify (rt_sigprocmask)
+	/* Do the syscall.  */
+	l.sys	1
+	 l.nop
+
+	/* if -4096 < ret < 0 holds, it's an error */
+	l.sfgeui r11, 0xf001
+	l.bf	1f
+	 l.nop
+
+	/* Same as setcontext.  */
+
+	/* Restore signal mask.  */
+	/* rt_sigprocmask (SIG_SETMASK, &ucp->uc_sigmask, NULL, _NSIG8) */
+	l.ori	r6, r0, _NSIG8
+	l.ori	r5, r0, 0
+	l.addi	r4, r30, __CONTEXT_SIGMASK_OFFSET
+	l.ori	r3, r0, SIG_SETMASK
+	l.ori	r11, r0, SYS_ify (rt_sigprocmask)
+	/* Do the syscall.  */
+	l.sys 1
+	 l.nop
+
+	/* if -4096 < ret < 0 holds, it's an error */
+	l.sfgeui r11, 0xf001
+	l.bf	1f
+	 l.nop
+
+#ifdef __CONTEXT_ENABLE_FPCSR
+# ifdef __or1k_hard_float__
+	/* Restore the floating point state.  */
+	l.lwz	r28, (MCONTEXT_FPCSR)(r30)
+	l.mtspr	r0, r28, 20
+# endif /* __or1k_hard_float__ */
+#endif /* __CONTEXT_ENABLE_FPCSR */
+
+	/* Restore argument registers, for the makecontext case.  */
+	l.lwz	r3, (UCONTEXT_MCONTEXT +  3*4)(r30)
+	l.lwz	r4, (UCONTEXT_MCONTEXT +  4*4)(r30)
+	l.lwz	r5, (UCONTEXT_MCONTEXT +  5*4)(r30)
+	l.lwz	r6, (UCONTEXT_MCONTEXT +  6*4)(r30)
+	l.lwz	r7, (UCONTEXT_MCONTEXT +  7*4)(r30)
+	l.lwz	r8, (UCONTEXT_MCONTEXT +  8*4)(r30)
+
+	/* Restore registers stored in getcontext.  */
+	l.lwz	r1,  (UCONTEXT_MCONTEXT +  1*4)(r30)
+	l.lwz	r2,  (UCONTEXT_MCONTEXT +  2*4)(r30)
+	l.lwz	r9,  (UCONTEXT_MCONTEXT +  9*4)(r30)
+	l.lwz	r10, (UCONTEXT_MCONTEXT + 10*4)(r30)
+	l.lwz	r11, (UCONTEXT_MCONTEXT + 11*4)(r30)
+	l.lwz	r14, (UCONTEXT_MCONTEXT + 14*4)(r30)
+	l.lwz	r16, (UCONTEXT_MCONTEXT + 16*4)(r30)
+	l.lwz	r18, (UCONTEXT_MCONTEXT + 18*4)(r30)
+	l.lwz	r20, (UCONTEXT_MCONTEXT + 20*4)(r30)
+	l.lwz	r22, (UCONTEXT_MCONTEXT + 22*4)(r30)
+	l.lwz	r24, (UCONTEXT_MCONTEXT + 24*4)(r30)
+	l.lwz	r26, (UCONTEXT_MCONTEXT + 26*4)(r30)
+	l.lwz	r28, (UCONTEXT_MCONTEXT + 28*4)(r30)
+	l.lwz	r30, (UCONTEXT_MCONTEXT + 30*4)(r30)
+
+	l.jr	r11
+	 l.ori	r11, r0, 0
+
+1:	l.j	__syscall_error
+	 l.ori	r3, r11, 0
+
+END (__CONTEXT_FUNC_NAME)
diff --git a/sysdeps/unix/sysv/linux/or1k/swapcontext.S b/sysdeps/unix/sysv/linux/or1k/swapcontext.S
index d09651a5b2..861c1e26ba 100644
--- a/sysdeps/unix/sysv/linux/or1k/swapcontext.S
+++ b/sysdeps/unix/sysv/linux/or1k/swapcontext.S
@@ -16,101 +16,36 @@
    License along with the GNU C Library; if not, see
    <https://www.gnu.org/licenses/>.  */
 
+#include <shlib-compat.h>
 #include <sysdep.h>
 #include "ucontext_i.h"
 
-/* int swapcontext (ucontext_t *oucp, const ucontext_t *ucp) */
-	.text
-ENTRY(__swapcontext)
+#define __CONTEXT_FUNC_NAME __swapcontext
+#define __CONTEXT_ENABLE_FPCSR 1
+#define __CONTEXT_SIGMASK_OFFSET UCONTEXT_SIGMASK
 
-	/* Same as getcontext.  */
-	/* Store r1, the stack pointer.  */
-	l.sw	(UCONTEXT_MCONTEXT +  1*4)(r3), r1
-	/* Store r2, the frame pointer.  */
-	l.sw	(UCONTEXT_MCONTEXT +  2*4)(r3), r2
-	/* Store r9, the link register.  */
-	l.sw	(UCONTEXT_MCONTEXT +  9*4)(r3), r9
-	/* Store r9 to reg[11] too, as we need two links for makecontext.  */
-	l.sw	(UCONTEXT_MCONTEXT + 11*4)(r3), r9
-	/* Store r10, the TLS register.  */
-	l.sw	(UCONTEXT_MCONTEXT + 10*4)(r3), r10
-	/* Store r14-r30 even, callee saved registers.  */
-	l.sw	(UCONTEXT_MCONTEXT + 14*4)(r3), r14
-	l.sw	(UCONTEXT_MCONTEXT + 16*4)(r3), r16
-	l.sw	(UCONTEXT_MCONTEXT + 18*4)(r3), r18
-	l.sw	(UCONTEXT_MCONTEXT + 20*4)(r3), r20
-	l.sw	(UCONTEXT_MCONTEXT + 22*4)(r3), r22
-	l.sw	(UCONTEXT_MCONTEXT + 24*4)(r3), r24
-	l.sw	(UCONTEXT_MCONTEXT + 26*4)(r3), r26
-	l.sw	(UCONTEXT_MCONTEXT + 28*4)(r3), r28
-	l.sw	(UCONTEXT_MCONTEXT + 30*4)(r3), r30
+#include "swapcontext-common.S"
 
-	/* Store ucp to non-argument syscall preserved register.  */
-	l.ori	r30, r4, 0
+versioned_symbol (libc, __swapcontext, swapcontext, GLIBC_2_40)
 
-	/* Get signal mask.  */
-	/* rt_sigprocmask (SIG_BLOCK, NULL, &ucp->uc_sigmask, _NSIG8) */
-	l.ori	r6, r0, _NSIG8
-	l.addi	r5, r3, UCONTEXT_SIGMASK
-	l.ori	r4, r0, 0
-	l.ori	r3, r0, SIG_BLOCK
-	l.ori	r11, r0, SYS_ify (rt_sigprocmask)
-	/* Do the syscall.  */
-	l.sys	1
-	 l.nop
+#if SHLIB_COMPAT (libc, GLIBC_2_35, GLIBC_2_40)
 
-	/* if -4096 < ret < 0 holds, it's an error */
-	l.sfgeui r11, 0xf001
-	l.bf	1f
-	 l.nop
+/* Define a compat version of swapcontext for glibc's before the fpcsr
+   field was added to mcontext_t.  The offset sigmask changed with this
+   introduction, the change was done because glibc's definition of
+   ucontext_t was initially defined incompatible with the Linux
+   definition of ucontext_t.  We keep the compatability definition to
+   allow getcontext, setcontext and swapcontext to work in older
+   binaries.  */
 
-	/* Same as setcontext.  */
+# undef __CONTEXT_FUNC_NAME
+# undef __CONTEXT_ENABLE_FPCSR
+# undef __CONTEXT_SIGMASK_OFFSET
+# define __CONTEXT_FUNC_NAME __swapcontext_nofpcsr
+# define __CONTEXT_SIGMASK_OFFSET (UCONTEXT_SIGMASK - 4)
 
-	/* Restore signal mask.  */
-	/* rt_sigprocmask (SIG_SETMASK, &ucp->uc_sigmask, NULL, _NSIG8) */
-	l.ori	r6, r0, _NSIG8
-	l.ori	r5, r0, 0
-	l.addi	r4, r30, UCONTEXT_SIGMASK
-	l.ori	r3, r0, SIG_SETMASK
-	l.ori	r11, r0, SYS_ify (rt_sigprocmask)
-	/* Do the syscall.  */
-	l.sys 1
-	 l.nop
+# include "swapcontext-common.S"
 
-	/* if -4096 < ret < 0 holds, it's an error */
-	l.sfgeui r11, 0xf001
-	l.bf	1f
-	 l.nop
+compat_symbol (libc, __swapcontext_nofpcsr, swapcontext, GLIBC_2_35)
 
-	/* Restore argument registers, for the makecontext case.  */
-	l.lwz	r3, (UCONTEXT_MCONTEXT +  3*4)(r30)
-	l.lwz	r4, (UCONTEXT_MCONTEXT +  4*4)(r30)
-	l.lwz	r5, (UCONTEXT_MCONTEXT +  5*4)(r30)
-	l.lwz	r6, (UCONTEXT_MCONTEXT +  6*4)(r30)
-	l.lwz	r7, (UCONTEXT_MCONTEXT +  7*4)(r30)
-	l.lwz	r8, (UCONTEXT_MCONTEXT +  8*4)(r30)
-
-	/* Restore registers stored in getcontext.  */
-	l.lwz	r1,  (UCONTEXT_MCONTEXT +  1*4)(r30)
-	l.lwz	r2,  (UCONTEXT_MCONTEXT +  2*4)(r30)
-	l.lwz	r9,  (UCONTEXT_MCONTEXT +  9*4)(r30)
-	l.lwz	r10, (UCONTEXT_MCONTEXT + 10*4)(r30)
-	l.lwz	r11, (UCONTEXT_MCONTEXT + 11*4)(r30)
-	l.lwz	r14, (UCONTEXT_MCONTEXT + 14*4)(r30)
-	l.lwz	r16, (UCONTEXT_MCONTEXT + 16*4)(r30)
-	l.lwz	r18, (UCONTEXT_MCONTEXT + 18*4)(r30)
-	l.lwz	r20, (UCONTEXT_MCONTEXT + 20*4)(r30)
-	l.lwz	r22, (UCONTEXT_MCONTEXT + 22*4)(r30)
-	l.lwz	r24, (UCONTEXT_MCONTEXT + 24*4)(r30)
-	l.lwz	r26, (UCONTEXT_MCONTEXT + 26*4)(r30)
-	l.lwz	r28, (UCONTEXT_MCONTEXT + 28*4)(r30)
-	l.lwz	r30, (UCONTEXT_MCONTEXT + 30*4)(r30)
-
-	l.jr	r11
-	 l.ori	r11, r0, 0
-
-1:	l.j	__syscall_error
-	 l.ori	r3, r11, 0
-
-END (__swapcontext)
-weak_alias (__swapcontext, swapcontext)
+#endif
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

