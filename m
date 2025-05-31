Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999BA208A7
	for <linux-openrisc@vger.kernel.org>; Sat, 31 May 2025 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748671409; cv=none; b=pvAs5y4bIajoNUj92YWxIHUpFx2WiaSnoet5ZOzAQN5hVQfO5VKX6Win94WHn3N7unS4+6x+/Rf47RUNNUhPVQPpqq+jtLg2Wb2EX31IBCNKG1CJCqESF58dXjCYoKO3W3ujmPrLYQfddE8gVmHNslgLbXT9C7Q4NI67cKKibdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748671409; c=relaxed/simple;
	bh=uk9sMwOeMT1oclgKXm9xFr5xNUPRIj/Q1WbH3h8lxVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FotcODyxO9zBaOQ8WzYowqlzxi/y3Kg2tdkYpJZwLxsaSHhWFnaAKR+DKAqMCVA95vhi1wmRXPnK/FI6kv+qHMMUpFT6++mlSEuofTQmxPxduUVcaEVbTJku1xdT4eaiPZO44FxyhkYr2NE7D27qsDHq/FzOmsj+Zl9v69kUPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZJfpy4U; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZJfpy4U"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4fdc27c4aso132555f8f.3
        for <linux-openrisc@vger.kernel.org>; Fri, 30 May 2025 23:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748671406; x=1749276206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u0baP/kVXWz7gvsVaNZ8memoPrOqil+E1U2Rg1IE5H8=;
        b=HZJfpy4UfuFDswvfQeC/uwxLp+K6Q/1Y+TexfFu6mzouFDo8lyKjj4xSCKN15GgQ1P
         DsJTNTrB9Ie/ZNviAl/Cg29vovrD3wypeKptZYKFti8y8Wgbto9EQqqk/SJ4Gk0qtRyO
         QJo0tphxiBor2be4xnmd0a7Nz3ljggguOV3lPxOQt0m7Nx4iJhvaW+ZZ8xDHx72KvCio
         QRbnxTVggU88/1HG89/YZkTmZmlFarl15mOzPCZkHYD6NgzJSj4bbkWDUszkqYvGUWhA
         Nkxu/dEXEZQpMesfXmg706V4hBpq8Ai27Zlon1YTAj814o6sM1Rs6+ONVgIyu2c3sXJp
         LC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748671406; x=1749276206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0baP/kVXWz7gvsVaNZ8memoPrOqil+E1U2Rg1IE5H8=;
        b=piOHnfU7KwTV9mF/gsyC5G+fVBXHQBf3F3osQmVHa+19HIW680wlQX06fPMk1s30Cm
         LE1Ry6nX78brHoGSF2BjuyXjcAbDAxMzUN+GDVZEqn98sL8wdk969a/rpgMeuRYhAm9a
         mqiCfMMm8mcp35MpZH4j3ZvmIDjJA93w0SClZrqBPT6OmBfc7sZE5whHKDYyXRc6y/MZ
         GvT7pII70UL8j3dOlwfjpLcb+aI0Ue66YgaQ+P5cZxX3EbhVT7bju1HXx9V1V7jpbGXr
         zG8vJqn5Bb+uUze9VRBOvx0TgGb6bEomnU3D2WwUALAH/Tp4d2RbsNTVGdCtuaaNlxSg
         jlRw==
X-Gm-Message-State: AOJu0YxejlAFtzndzkgLbsLAxoG1/pn5tZL+pJyi4mspIsatRLHj9CrR
	o2uqGDI3Pb36bcgtEAAl7XzKH9f1LJlplVbfFl2Zoa3uZBdKTMqai1qKlwWXdQ==
X-Gm-Gg: ASbGnctwL1Wg6EKGvuQt24ZTF5JtfgSYbI8T6K9sBsAfrAVCFyHsSRNu1UAkQjL9SDz
	MXbOvFH6ptAS0b90CVUv7+xqYgXyNb0zuu623howvwtJ9WLsAs6tud9Urt6V0DfFNZfjh6TK91T
	1beDUtr/4+y8jRfmimZ2eiZmQ0VrgqHYd8LYFzz3fmS4AdmLK73VwpND11k/19awlcsESL0zZsq
	ONBzB+OqQFdMDhUecYUIVoH6Xckhb/PYCZDYMVDK48NkGCYM52MB55/5lVniPUAD5fGa4c65SSP
	zU4ucI3ZQVSs/izmQcBrtDb360EZpIKLYSQTOvRmzwlGOZYt+nZXoqejIm2GTzsmmSCYO6hjgBS
	WkcSDI2h2nORTObk=
X-Google-Smtp-Source: AGHT+IGG2MHt33VB5oEbcahLxA92otJRMqhQ0mdGVF1/QfEMUnbiYpm1ZHhEUqbUbFTB9heBXuIVGQ==
X-Received: by 2002:a05:6000:2407:b0:3a4:e082:c8f4 with SMTP id ffacd0b85a97d-3a4f89e2ec5mr4019332f8f.47.1748671405714;
        Fri, 30 May 2025 23:03:25 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c866sm7007699f8f.32.2025.05.30.23.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 23:03:24 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GCC patches <gcc-patches@gcc.gnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH] or1k: Fix struct return test
Date: Sat, 31 May 2025 07:03:21 +0100
Message-ID: <20250531060321.3687859-1-shorne@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In or1k structs are returned from functions using the memory address
passed in r3.  In the current version of GCC the struct stores changed
from r11 (the return value) to r3 the incoming memory address.  Both of
are valid.

Adjust the test to match what GCC is producing now.

gcc/testsuite/ChangeLog:

	* gcc.target/or1k/return-2.c: Fix test.
---
 gcc/testsuite/gcc.target/or1k/return-2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gcc/testsuite/gcc.target/or1k/return-2.c b/gcc/testsuite/gcc.target/or1k/return-2.c
index add3720c88e..c072ae23142 100644
--- a/gcc/testsuite/gcc.target/or1k/return-2.c
+++ b/gcc/testsuite/gcc.target/or1k/return-2.c
@@ -16,4 +16,4 @@ struct a getstruct (long aa) {
 /* Ensure our return value is returned on stack.  */
 /* { dg-final { scan-assembler-not "r12," } } */
 /* { dg-final { scan-assembler "l.or\\s+r11, r3, r3" } } */
-/* { dg-final { scan-assembler-times "l.sw\\s+\\d+.r11.," 3 } } */
+/* { dg-final { scan-assembler-times "l.sw\\s+\\d+.r3.," 3 } } */
-- 
2.49.0

