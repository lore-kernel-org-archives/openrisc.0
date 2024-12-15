Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1928BFF
	for <linux-openrisc@vger.kernel.org>; Sun, 15 Dec 2024 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734223489; cv=none; b=fZLHVFI+DOpDKybf1muAWWiYHi8pGuApIxCHH9cPq42XNY/zWZfYiW1PbXOL2WAb/fvUPZT2Uil0tAhtjQxW/ScRayPC/jDjYlmQ4XXP5GcygPNYdr/vOmUky8qnAeOoxegxHTZ/qrumJIVIeztze7O0Nv9NHO/MXqzVJIRd6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734223489; c=relaxed/simple;
	bh=HUkorgYR3e7TGltVDC7aIZ6PHkCqeWnOrf1Zxdo5+GE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LjufGJDbJI/4fJB8qN04ugWvW4XGrgwahGXE6gO6xWlrAKLHLO+nTlWXpXB/XnlF0srOiG6wRhG31czCWCGZTpa1/iFAxQSTyV03aFNXekGMdS4rgLp6JyujczXHh9iLC03PkP4RDOy5tkDwr7pv+f4n5H9RD5nlxKzVUcvsks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/BefedF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/BefedF"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436345cc17bso9304795e9.0
        for <linux-openrisc@vger.kernel.org>; Sat, 14 Dec 2024 16:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734223487; x=1734828287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=crfFUxL6R3D0jTIPZqGcddrjBQLoahBd4QpQ/wPr2L0=;
        b=a/BefedF+VxS9KRl2P96lkT0uSYQXIwCt9wJwYJI0MwUIQ0VWiVqBusdLYK05VBJQ0
         XlnRCt2Ode5LmTLpV6RmlGQxBjudetqJvNyCpiDAHIppRGS0ld36++WzskYytOZ+pWEN
         4ii0DYHC55wibb6TSIH0WNka621sDlknZPBft0hRQtO6a85THbM2BCqhuwMZixuMKJLF
         xYgUc/5dngwgddcfhzH3MdmJDvGOX35dhX2YxVF6oKNlISH+Nja1+12OOCxl/IUfgZ3W
         rOA972JSeWG2AQJ807ZglwPWF5Mna6Ce5Do7AB9kmfupYiBt6ApcKbRIDzARoi+7zWqu
         Lrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734223487; x=1734828287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crfFUxL6R3D0jTIPZqGcddrjBQLoahBd4QpQ/wPr2L0=;
        b=g699Bl5v5LnALCoFvzXP1ySZ7N8BwBrTpVUm1sIqdcD5iXS5tMFnuyTV/KnpvZu5We
         YmoMABlrcpHAECW1cs2ZK1J3qMN1vGGdMmU4fpex30NX6Us3CAWeSnVWRvje04EnQHIy
         GcNG/Sy35fwF8KjkJF9g2BjES6OwpJkyFO5cL/Pv/2urm02601JE/IpLiZZ+o36esr4Z
         2C7m83fW7aa9nouD2xjRqucODJt7DRhGGv8kXU8ZLM2DSQzqjdKhBGdaWPrfbLr4zK0M
         3JElToKmwfQtMjGIWuYVBwxXLZii8lGlrpuHTqsNebJGRHKLTjWgmg9Ye1lSNcTEIV5S
         9Wcw==
X-Gm-Message-State: AOJu0Yyfp+eg6F1itRxUuww5Y6ChdUVpIq3rbS41oQvSFo8rvSIDigOr
	dH/OOBMeAUwyYrwFKWGms9wLKNKHf4qjsPjrkGLQBuoOiqNefCt4
X-Gm-Gg: ASbGncvl5lkxdpyJYS1lUDcTK+SK9Gdb0/b7VwoWpG4D7+LmZUF3+HRAH8Q+4gP3zS6
	7cWiNfqO7DQ06You32AfE4ocpqKdHd2aUki0fvYiufmgY/9jtljJ5ZQhscZ48ojwWd7bTrK3A9X
	w3z3MYf9v7nztTIR87rSXQPBB6ujPFSBtSw2zso5h3wM7tYsVFOgKLsL7fTS6LhBaEBwES9F9ge
	YYhksn1a5VvNOWpaN8vUny/Z3EMDANBjGLDw2TS9jz/bfa9eWPDZgZr1/ZXk9TbZ7qMItYfe83U
	M0SxgEB9NERENZyjP3op
X-Google-Smtp-Source: AGHT+IGa1rEXY5WihI3XywHYWPQMus+SKE+XhoNXKv5DtVFrjvwOMe3hdAAVTbNTuESnniqCuJTOAQ==
X-Received: by 2002:a5d:6da2:0:b0:386:3213:5b9d with SMTP id ffacd0b85a97d-3888e0b5a3fmr6155326f8f.41.1734223486360;
        Sat, 14 Dec 2024 16:44:46 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706cc6sm94574965e9.30.2024.12.14.16.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 16:44:43 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [COMMITTED] or1k: Update libm-test-ulps
Date: Sun, 15 Dec 2024 00:44:34 +0000
Message-ID: <20241215004434.2723843-1-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regen to add new functions acospi, asinpi, atan2pi and atanpi.
---
 sysdeps/or1k/nofpu/libm-test-ulps | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sysdeps/or1k/nofpu/libm-test-ulps b/sysdeps/or1k/nofpu/libm-test-ulps
index 305b6cef70..be6e12d8ac 100644
--- a/sysdeps/or1k/nofpu/libm-test-ulps
+++ b/sysdeps/or1k/nofpu/libm-test-ulps
@@ -33,6 +33,10 @@ Function: "acosh_upward":
 double: 2
 float: 2
 
+Function: "acospi":
+double: 1
+float: 1
+
 Function: "asin":
 double: 1
 float: 1
@@ -65,6 +69,10 @@ Function: "asinh_upward":
 double: 3
 float: 3
 
+Function: "asinpi":
+double: 1
+float: 1
+
 Function: "atan":
 double: 1
 float: 1
@@ -84,6 +92,10 @@ Function: "atan2_upward":
 double: 8
 float: 2
 
+Function: "atan2pi":
+double: 1
+float: 1
+
 Function: "atan_downward":
 double: 1
 float: 2
@@ -112,6 +124,10 @@ Function: "atanh_upward":
 double: 3
 float: 3
 
+Function: "atanpi":
+double: 1
+float: 1
+
 Function: "cabs":
 double: 1
 
-- 
2.47.0

