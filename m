Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF972594BF
	for <linux-openrisc@vger.kernel.org>; Tue,  7 Jan 2025 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266479; cv=none; b=L8pnx2y8HcUXB+WSZK5hCRI6fEJxXkr71gx+omyCk69olzQfrQQhRfN66jz2MkmxBv4dA4dCnh1Ds7MzpKgslD4huogFRYtx7JXVnQeNZimvCa/qf7SafbotyVjoA0bfx70LyEO7pZIhe/KuIud5DpBVSqoNVQuwtNcYm9MpIZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266479; c=relaxed/simple;
	bh=gEF5UHRwwYURGjy4Ng6+9Wst8wVL/HMlLDuvuuSuTCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j89fFmcawhzdlNiZ8ewrjuwLh2ahHyKkLRm67MZWvoq2fiWFrU4EUhvATaqaRlJRWEJHEyFzFdG0IJFmL6HlOx/sa65grGtGXjgY8ZEjjAo5inY5CXwZsdEEBfwEI8KH6v1pTki5vAHaYmF0CgtxkRceXDg4VYOZ+b9vCkiDymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPzEpJhU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPzEpJhU"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-386329da1d9so7363431f8f.1
        for <linux-openrisc@vger.kernel.org>; Tue, 07 Jan 2025 08:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736266475; x=1736871275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TVZp7Dkdpihxa4TygmRj9uRTx4zyiJYAHQugt7wG0OE=;
        b=TPzEpJhUjzQqrXQxGuaeLfmWYJehsed/gkIpILSoTCvLNjqMnzKyobXBaftFxb8Qvg
         XUa3ZeZuXg5ITstlN/64GUZoTDpOutlxMu7WnIkHh6dfnl8pZX1EcoQap0I/hA/t20/x
         TUfzXVlKbgUtH8g0UUGyanlVsfdHTJo6Yt8buLt5nlqM49DUZv2oqFohfwtkdVsCUtQO
         NwxAeW17ffUVyuLQRfjr5c3jZijt0oFuOjgO+AZTKWLYajtx74k9WmMnGOLzSPvVLYb9
         q5s5FPKGdaPOPCrKa6NxqYKd8zaukODDILAXS+mX/PZRmhqTaZx7YIs4iklw4/ZYVq33
         FS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736266475; x=1736871275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVZp7Dkdpihxa4TygmRj9uRTx4zyiJYAHQugt7wG0OE=;
        b=DWtVbISRcehykmVD0iCaveAAN1FklJ0RHIosGLxa5b2mj3UbP9n2bBgOES5IqLjRLT
         7sG460RyduZ/gLY6J9xZHb/GQt4dFy3K33/kAzDGcQOuKRfGvfLOv5CuXqta/DIeahV3
         FGabiH+4/KUYIo/y25uOnuUPlLjdiHeywo9V+HDpcetw7HyHoK8gKK49L+KWkJeqZ4hL
         xkCy8lQbHycju7zaKgFAXaX052Ki1x4NZq5w04Vl/qKKQXoWZU1k+uvjtkGGT+EMT/wm
         UDlg0vdwSBgVAy4x5Q2cX7It1bOxHH3sZS8aSt1HltuhprC4Ru4Wd3O5JupQNO+3uE76
         gxQA==
X-Gm-Message-State: AOJu0YzR4xzEw5fRPDLb+blngvuD+hmIzrxYckUmi++Nx8MtdT7yaNkl
	EhQAoesHOkkSlvAXy061JzLGOUUEkCYU+Lk2n9s6sef9GSqY9awt
X-Gm-Gg: ASbGncv0lI7qtd/QGukz0wTt9QTUbTJpU/bofZpMA7s6aTdsNzaeFjUwRioUY54Lxnb
	ILIShEbrdU2HOCZy8CTX/QEjlhJKIXNklHI0bVYsUKWTQn78u6vl9gHr9Hcfc3XKvxk9Qd5ZcKL
	ijD6oin3xLj571LgW5X3IzvrXa/19tbv78qYJSCawcdFzsW6DsXELrckpYFVWbhXvXFAX9vnQyt
	f1ky4SE6pJwyZkpQ3LAa3nmq+Nx4orDy8yxQUV4CIOhGk8taPDCmuLIhdeUWLeTJWJ4ZpAVeBZL
	P+wURYWvNJ5EyozM/bok
X-Google-Smtp-Source: AGHT+IHVcKsL22mIEv56ZslAXQ3OXSKROOjOFO+RUBK3sa+0thO7JMIjABW2QNgHHCyMxorMAVni/g==
X-Received: by 2002:a5d:64c2:0:b0:385:e968:f189 with SMTP id ffacd0b85a97d-38a22408262mr53949894f8f.51.1736266475285;
        Tue, 07 Jan 2025 08:14:35 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a2311b3c8sm47836541f8f.25.2025.01.07.08.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 08:14:33 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [COMMITTED] or1k: Update fpu libm-test-ulps
Date: Tue,  7 Jan 2025 16:14:26 +0000
Message-ID: <20250107161426.3100832-1-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 sysdeps/or1k/fpu/libm-test-ulps | 171 ++++++++++++++++++++++++++++++--
 1 file changed, 165 insertions(+), 6 deletions(-)

diff --git a/sysdeps/or1k/fpu/libm-test-ulps b/sysdeps/or1k/fpu/libm-test-ulps
index c27afc99c8..b0de024cae 100644
--- a/sysdeps/or1k/fpu/libm-test-ulps
+++ b/sysdeps/or1k/fpu/libm-test-ulps
@@ -25,6 +25,22 @@ double: 2
 Function: "acosh_upward":
 double: 2
 
+Function: "acospi":
+double: 2
+float: 1
+
+Function: "acospi_downward":
+double: 1
+float: 2
+
+Function: "acospi_towardzero":
+double: 1
+float: 2
+
+Function: "acospi_upward":
+double: 2
+float: 1
+
 Function: "asin":
 double: 1
 
@@ -49,10 +65,24 @@ double: 2
 Function: "asinh_upward":
 double: 3
 
-Function: "atan":
+Function: "asinpi":
 double: 1
+float: 1
 
-Function: "atan2":
+Function: "asinpi_downward":
+double: 1
+float: 1
+
+Function: "asinpi_towardzero":
+double: 1
+float: 2
+
+Function: "asinpi_upward":
+double: 2
+float: 2
+
+Function: "atan":
+double: 1
 
 Function: "atan2_downward":
 double: 5
@@ -63,6 +93,22 @@ double: 5
 Function: "atan2_upward":
 double: 8
 
+Function: "atan2pi":
+double: 1
+float: 1
+
+Function: "atan2pi_downward":
+double: 1
+float: 2
+
+Function: "atan2pi_towardzero":
+double: 1
+float: 2
+
+Function: "atan2pi_upward":
+double: 1
+float: 2
+
 Function: "atan_downward":
 double: 1
 
@@ -84,6 +130,22 @@ double: 2
 Function: "atanh_upward":
 double: 3
 
+Function: "atanpi":
+double: 2
+float: 1
+
+Function: "atanpi_downward":
+double: 1
+float: 2
+
+Function: "atanpi_towardzero":
+double: 1
+float: 2
+
+Function: "atanpi_upward":
+double: 1
+float: 1
+
 Function: "cabs":
 double: 1
 
@@ -154,14 +216,12 @@ float: 2
 
 Function: Real part of "cacosh_upward":
 double: 4
-float: 3
+float: 4
 
 Function: Imaginary part of "cacosh_upward":
 double: 3
 float: 2
 
-Function: "carg":
-
 Function: "carg_downward":
 double: 5
 
@@ -499,6 +559,22 @@ double: 3
 Function: "cosh_upward":
 double: 2
 
+Function: "cospi":
+double: 2
+float: 2
+
+Function: "cospi_downward":
+double: 1
+float: 2
+
+Function: "cospi_towardzero":
+double: 1
+float: 1
+
+Function: "cospi_upward":
+double: 1
+float: 2
+
 Function: Real part of "cpow":
 double: 2
 float: 5
@@ -534,6 +610,9 @@ Function: Real part of "csin":
 double: 1
 float: 1
 
+Function: Imaginary part of "csin":
+float: 1
+
 Function: Real part of "csin_downward":
 double: 3
 float: 3
@@ -651,7 +730,7 @@ float: 4
 
 Function: Imaginary part of "ctan_upward":
 double: 2
-float: 1
+float: 2
 
 Function: Real part of "ctanh":
 double: 2
@@ -729,6 +808,18 @@ Function: "exp10_upward":
 double: 2
 float: 1
 
+Function: "exp10m1":
+double: 3
+
+Function: "exp10m1_downward":
+double: 3
+
+Function: "exp10m1_towardzero":
+double: 2
+
+Function: "exp10m1_upward":
+double: 4
+
 Function: "exp2":
 double: 1
 
@@ -742,6 +833,18 @@ Function: "exp2_upward":
 double: 1
 float: 1
 
+Function: "exp2m1":
+double: 2
+
+Function: "exp2m1_downward":
+double: 3
+
+Function: "exp2m1_towardzero":
+double: 3
+
+Function: "exp2m1_upward":
+double: 3
+
 Function: "exp_downward":
 double: 1
 float: 1
@@ -871,6 +974,18 @@ Function: "log10_upward":
 double: 2
 float: 2
 
+Function: "log10p1":
+double: 1
+
+Function: "log10p1_downward":
+double: 2
+
+Function: "log10p1_towardzero":
+double: 3
+
+Function: "log10p1_upward":
+double: 2
+
 Function: "log1p":
 double: 1
 float: 1
@@ -899,6 +1014,18 @@ double: 1
 Function: "log2_upward":
 double: 1
 
+Function: "log2p1":
+double: 1
+
+Function: "log2p1_downward":
+double: 2
+
+Function: "log2p1_towardzero":
+double: 2
+
+Function: "log2p1_upward":
+double: 2
+
 Function: "logp1":
 double: 1
 float: 1
@@ -973,6 +1100,22 @@ double: 3
 Function: "sinh_upward":
 double: 3
 
+Function: "sinpi":
+double: 2
+float: 2
+
+Function: "sinpi_downward":
+double: 2
+float: 2
+
+Function: "sinpi_towardzero":
+double: 2
+float: 1
+
+Function: "sinpi_upward":
+double: 2
+float: 3
+
 Function: "tan_downward":
 double: 1
 
@@ -994,6 +1137,22 @@ double: 2
 Function: "tanh_upward":
 double: 3
 
+Function: "tanpi":
+double: 3
+float: 3
+
+Function: "tanpi_downward":
+double: 2
+float: 3
+
+Function: "tanpi_towardzero":
+double: 2
+float: 3
+
+Function: "tanpi_upward":
+double: 2
+float: 4
+
 Function: "tgamma":
 double: 9
 
-- 
2.47.0

