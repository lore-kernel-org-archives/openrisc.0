Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C90F4F20E
	for <linux-openrisc@vger.kernel.org>; Tue, 19 Mar 2024 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710884582; cv=none; b=t3ErhSWO4L/YFcOfJ7w1BSuZNnPXhdAYtDsW0zEDLHXYJsnIkYcDNKciZVBqyp7S2hRmZ3bPAHppPLV1Hg/Ww3cJF6JdJacGYcM+X5i+1m4DihymtaFUfS/r53Do/qLyIUPTIx6vUIIgvebcDoCFKNfS9WXMa8xzm89XOdQnZiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710884582; c=relaxed/simple;
	bh=o3r6XltSn7T1uGTk07Wi7laRQqIz8JuIispTC34FJ+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBdQ/dy5qts+gxRcEPx6Q6lqoivLvhGRW0GDVuTthnpZ1dwC7iwqYvLzu+zl4sd3HW7aZdvimsOiil9DYbsrm0CHncFq3aYfjm4jU+l1N4J8keHTdLVP+uC7Px2/Dz6PGvXfIJbbUUKtN4w+fETyUWtWCWXn7McnpYk8p//6Js0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7jAqe/o; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7jAqe/o"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4146562a839so8306095e9.1
        for <linux-openrisc@vger.kernel.org>; Tue, 19 Mar 2024 14:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710884578; x=1711489378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFvKdRIMK1Zy3EK9VazDyW2mCoPbeoFiUZiDZoWkdHY=;
        b=k7jAqe/oHABM+ES7VlMdTuOAdG2LR6KoPpGbl7+hDMDQGjs0WYsiUPLu4ayMRpLlFa
         Q3vgLtyIW5SAW+AS2djMUveBWFPaV9vIyHZ8bq0VkFl8Hik14MbTrx+EANOE/IY0aGBm
         GaqnNLrUHSB5V0xBRva7c55zp0AXCoV+OZwcsNTVzdHh/Jj/HTz7ck2lhFzYtPiiO5C9
         A+5tdWvMSLfaVk8z4FYbeYlhXgYt1H/zFqx7XTcv26Ot9A9XH4Fjw/m2ZC7ZRYX6HUiu
         RSRQLAdu4kBE3pvY14a3RbuLKaBVqbBSgCIETxUjh9d/yqYaptsAcR1lrKqbpZLDKwVK
         Q+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710884578; x=1711489378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFvKdRIMK1Zy3EK9VazDyW2mCoPbeoFiUZiDZoWkdHY=;
        b=ifWRAAga55egwHjBW8SVR+zNw8+g6U7XS/GySFiAgXTcIXcSC3KNGMiqvQSE4dQfQM
         NeOldXjp0fEsBq4GfvQH3pHkaR3Bty0UoMQy9o4h7NERks5NDsHkcU3HMfltBDOMGps5
         pvWuUXdS8bkd8wssKOKToCj6IaXHRdJuuWGap5bO9cv8uBM0nP8HJXefJBmAdl9Z1ly8
         qmo2KfQODvM8GroVokMFrAVapBmSvNs/AKzqxLMCMUVa8ycjKaNqxeRRq/1iaL21fdwL
         dApTL1TWWQ7uN8Baigb1vA8GKP9LhEJ5emqllUYBEY8vYNeMuHkiLewwdgfaHJHYENLy
         dNpw==
X-Gm-Message-State: AOJu0YxYB/v0rGyhlDMaFWeDWPrh0h8qK7EUWGozGx5CFw81Q0ashsw5
	s7pN/tfqljwqFkqS4HHM/NU1lv+9TgK5QU4cXEZ4dVGEEonS+wK+
X-Google-Smtp-Source: AGHT+IFjOr7178WzN8Wmv+aGpWzZvbz5fKIDGIQmfdzmSUi5iAy+j3CTov8Hr6kCWw+bzrGkiy1U+g==
X-Received: by 2002:a05:600c:1551:b0:414:413:538d with SMTP id f17-20020a05600c155100b004140413538dmr2770014wmg.0.1710884578214;
        Tue, 19 Mar 2024 14:42:58 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id b2-20020a05600c4e0200b004140837a0d4sm99647wmq.3.2024.03.19.14.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:42:56 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH 4/4] or1k: Add prctl wrapper to unwrap variadic args
Date: Tue, 19 Mar 2024 21:42:44 +0000
Message-ID: <20240319214244.736981-5-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319214244.736981-1-shorne@gmail.com>
References: <20240319214244.736981-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On OpenRISC variadic functions and regular functions have different
calling conventions so this wrapper is needed to translate.  This
wrapper is copied from x86_64/x32.  I don't know the build system enough
to find a cleaner way to share the code between x86_64/x32 and or1k
(maybe Implies?), so I went with the straight copy.

This fixes test failures:

  misc/tst-prctl
  nptl/tst-setgetname
---
 sysdeps/unix/sysv/linux/or1k/prctl.c | 42 ++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 sysdeps/unix/sysv/linux/or1k/prctl.c

diff --git a/sysdeps/unix/sysv/linux/or1k/prctl.c b/sysdeps/unix/sysv/linux/or1k/prctl.c
new file mode 100644
index 0000000000..1aa707d175
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/or1k/prctl.c
@@ -0,0 +1,42 @@
+/* prctl - Linux specific syscall.  OpenRISC version.
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
+#include <sysdep.h>
+#include <stdarg.h>
+#include <sys/prctl.h>
+
+/* Unconditionally read all potential arguments.  This may pass
+   garbage values to the kernel, but avoids the need for teaching
+   glibc the argument counts of individual options (including ones
+   that are added to the kernel in the future).  */
+
+int
+__prctl (int option, ...)
+{
+  va_list arg;
+  va_start (arg, option);
+  unsigned long int arg2 = va_arg (arg, unsigned long int);
+  unsigned long int arg3 = va_arg (arg, unsigned long int);
+  unsigned long int arg4 = va_arg (arg, unsigned long int);
+  unsigned long int arg5 = va_arg (arg, unsigned long int);
+  va_end (arg);
+  return INLINE_SYSCALL_CALL (prctl, option, arg2, arg3, arg4, arg5);
+}
+
+libc_hidden_def (__prctl)
+weak_alias (__prctl, prctl)
-- 
2.44.0

