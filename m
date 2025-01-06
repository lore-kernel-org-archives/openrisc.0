Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9950833DB
	for <linux-openrisc@vger.kernel.org>; Mon,  6 Jan 2025 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736123676; cv=none; b=Su1AXRhubhtihFP8iUD8zsTd05DZQqc03uSHyCxCCpTvr6zSjM/B+GLmlPinEWCSroMif+0e/cpon5jdy3MLivDTuwjdMNl5/PLBTpu0qYXCCjzuDj2H8ZpwLb5xN9OR10DCm2AwbHlbSpwEUwmcr6THMR7TEDlv2hdMF8OnmSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736123676; c=relaxed/simple;
	bh=VAZnC73Jj4jT5bnrVkI3WRZnT3534hv/N+8H4Fxnwmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NFjFufg2ng49ZAZsuO2nj9a40XrGUlqFfq93xpvYRlesWqe+8iCRM34JscbNCyLHJ34cNLSdi3VZEm3W+LzHp9OSSz0qdfhulnQWvkYJZS1cIQhSozyZ4Y/U3snCmr7qKTvK9/AgH/ge7pPr3OIZpkGeibXURmswJNMQBfZVfMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXI8uUR3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXI8uUR3"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so158191815e9.0
        for <linux-openrisc@vger.kernel.org>; Sun, 05 Jan 2025 16:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736123673; x=1736728473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mt/63gBMU5xtHa8zkYlsNrl7kjTQTyUZ2sa2lrnGygI=;
        b=bXI8uUR3U4yBtXpmbzdUDJ+wldghipeAg1IUYS8+PNvtpIGI1kPK7LZUbJR4H411gp
         wbh823h7+l7zVJ9he3xa59M3mW0HTbimHCZk/QsGA6o5Sx3GdSagj/oCVPR+Lj08CISx
         mjuFkmnimXixtFyxHwmmMP9B9T0IIx3jYLoiT9h45YTjSYdA/SU3IN4Om+Pu31QlBQQo
         agjDgGtiTlPc33VHmd4tIMG9SeonNYzTp72xfnK0RLOpQiuVnlIw8wZFc5OFNPWasFJj
         Flz4gyCMrYBjoUf12IwhzaBdnHlzwvkMAI3qvD17VcGoJ/PmzoXhesbKU8SouI1xPkPv
         5cZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736123673; x=1736728473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mt/63gBMU5xtHa8zkYlsNrl7kjTQTyUZ2sa2lrnGygI=;
        b=ayFIEM+5PL9xdmq6eXMHDpEEE9xXBCCjjWOc1ICmRQcY3o6Nri6jFrPqOheAY33/W/
         4m7MTfUzNPAUnfL8YZYZ7W/2/Afm/fou/O9QAV4dkoG7bLnHI2mZxs4Spz17lfWea3cQ
         UBRViditDUWwgP1GvEFpk7N70wPhaIsuCP3e2BTlRWB86xnP0vTWD5dTAnsCk+2C7ehI
         LuRJfwOLJFgFleJBwUKU1YQoDdqHUfqDvMICA4X6J/cEStF1jnYeugkfPsRLgheYV6ji
         ZpygrJjrFgmFKe52wRUi8nOLS0jYPBQFfdhig/ZeaFX+afMo/Qx57CIY82YMFMMDN1sQ
         scFQ==
X-Gm-Message-State: AOJu0YyB9ULKOfcjwUfZYybnvz4JJRrchs2vKx2lyPAqI8JLiZsx3FqE
	kre0paUJk4xZfZELNuM4KPzoYaYhDkCx4x+LX0JaGu4zjHwk7TCQ
X-Gm-Gg: ASbGncuolTeUtE7GEGYmVWgOJ36e+J/HJBm6soXjvjjqT2YlQ2j1GhyJxLxbfTymfrx
	zKN9B6IsvdRiRQqm0UqJL1xCLi9zNH8aZ1RrZPe2PJtJnq8zlniyX8kTbgI722S4o2wFzOHE2E2
	zVynRmBlt9pqSEAT95H8u/WkQu52nSgSf4G4J6gCK65DpMoJ90qVnSBqsZ192+hxbMhphevqGp2
	yfQhEgq+sGd71e3Kwg3mc0GQxB4CEuXgI89BrMm5z/vduA3F/qwGVo65APXmZ1FHQfErVGJxY7l
	sP+63n8beK6LA0EnYdfz
X-Google-Smtp-Source: AGHT+IGTADDy/oEz3l1x9/mByDcIYpYKszzg/Zdp+k+psdIBhrvQ04IxYY6yN7fbp8phv4Nm99bMBA==
X-Received: by 2002:a5d:59ab:0:b0:385:fd31:ca31 with SMTP id ffacd0b85a97d-38a223fd39fmr55364273f8f.53.1736123671518;
        Sun, 05 Jan 2025 16:34:31 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e8asm45928832f8f.37.2025.01.05.16.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 16:34:29 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [COMMITTED] or1k: Update nofpu libm-test-ulps
Date: Mon,  6 Jan 2025 00:34:25 +0000
Message-ID: <20250106003425.4064978-1-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates tolerances due to change to use CORE-MATH
---
 sysdeps/or1k/nofpu/libm-test-ulps | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/sysdeps/or1k/nofpu/libm-test-ulps b/sysdeps/or1k/nofpu/libm-test-ulps
index 46ef288135..aa047f3b6f 100644
--- a/sysdeps/or1k/nofpu/libm-test-ulps
+++ b/sysdeps/or1k/nofpu/libm-test-ulps
@@ -26,7 +26,7 @@ Function: "acosh_upward":
 double: 2
 
 Function: "acospi":
-double: 1
+double: 2
 float: 1
 
 Function: "asin":
@@ -60,8 +60,6 @@ float: 1
 Function: "atan":
 double: 1
 
-Function: "atan2":
-
 Function: "atan2_downward":
 double: 5
 
@@ -97,7 +95,7 @@ Function: "atanh_upward":
 double: 3
 
 Function: "atanpi":
-double: 1
+double: 2
 float: 1
 
 Function: "cabs":
@@ -176,8 +174,6 @@ Function: Imaginary part of "cacosh_upward":
 double: 3
 float: 2
 
-Function: "carg":
-
 Function: "carg_downward":
 double: 5
 
@@ -516,8 +512,8 @@ Function: "cosh_upward":
 double: 2
 
 Function: "cospi":
-double: 1
-float: 1
+double: 2
+float: 2
 
 Function: Real part of "cpow":
 double: 2
@@ -999,8 +995,8 @@ Function: "sinh_upward":
 double: 3
 
 Function: "sinpi":
-double: 1
-float: 1
+double: 2
+float: 2
 
 Function: "tan_downward":
 double: 1
@@ -1024,8 +1020,8 @@ Function: "tanh_upward":
 double: 3
 
 Function: "tanpi":
-double: 2
-float: 2
+double: 3
+float: 3
 
 Function: "tgamma":
 double: 9
-- 
2.47.0

