Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA348159565
	for <linux-openrisc@vger.kernel.org>; Mon,  6 Jan 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736168495; cv=none; b=O1xrl5lWoj20JcMVdqsqSTxUK1SsMdkccm7EoAN4acgslGhi10/+FGVRTSKcV1sAQoITa7tT7IJaj2omLDst8TcAs9h5yY5YI2u7Cm+GVP0eXOjaYeUhHgXoAZGQzqRixv2GgjG/ulmjlVfGSOu4TqwHKj7KUnv9f3OL7M7yE8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736168495; c=relaxed/simple;
	bh=wTfMFHqejdyMqF7T3PCgetw79DKiWCEzG/hRrSC9K2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bgbOhn/Dc9kPxdUl4RqyFju7EpXdBA865KUnDiP4TBKnTBdmjVcstAtb9Fu9G/dOxbZxVCLoFIt1BCnBgTJe2W7wNHxor5WW4DY1D3ypL8rFqnCjgkG1+hApSp5b8TC+g8H3PycdBwDNR2bGbQ0bw+e6pWep4cvtxIQHi2RIirw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H83dX/Cf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H83dX/Cf"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436637e8c8dso145862335e9.1
        for <linux-openrisc@vger.kernel.org>; Mon, 06 Jan 2025 05:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736168492; x=1736773292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Mk+JzD7LuFMEpDTdDcsmHlJ7HrXGvotCwnVeQEKBd8=;
        b=H83dX/CfnXcQ5NJchLXsW2VnRXfr2Rs69FWIZtFyuVO5vDdWBT/VMpf1FLWSRSlPCx
         sYcqcmhpUX2rcrCK3cb+P0GnxYqQGHRFi3oRw/nXVp6qQqOJovAdd7yV8LZU86aqfWDC
         +WHLmqktOJazugHhw+ctd0Uh0OcNxiUK4jsuYoFnYeTpUtPk4Wf4HyUIB8z2KHAcTqTD
         Pc4Q01rvcxFPJDRTj4re2jAbVs9uTirfwddsuxGUwPpoqjn+98F+6P8HuSUFU7iMHHI5
         8r2HMEys9KjyNzfCzhzJzwgsylyO+3QUQA3QowI+KpD0+f0c+pVhFLecOP/8sGKM3pDn
         yo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736168492; x=1736773292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Mk+JzD7LuFMEpDTdDcsmHlJ7HrXGvotCwnVeQEKBd8=;
        b=Po4tsXUvrhtthzEA85oZREAflAd2T5Cqm4dcyHVL/MWMsfCqXYB/fePPszYyIY6p7v
         nCmaPITK8GhXdm/p7qq7uQhBG2QWaTtQh+0XI1hzrdZPQZEmG5i10kRKJjeZRKtRGrXW
         usqYwvnnpTkaiKxBoumNPdIY8mg6UAHUsfxiB5ZNndIl3QLvXAl6roRyRDYYEiE5LZH2
         oI7N9PgnYmEX/jhLmIcexHoy0q748fUPYBq/dYk0MxGRfj4qpfuDT4k7uIi6vaOP/ww+
         UANcU1dy8zNTbf9BqJCk5u2sFeM2RcQFW2i2y2SXMAUBYK6ugVsvb901l+nUucTF+Sof
         Z6Tg==
X-Gm-Message-State: AOJu0YxSKa0LVOUR9fe2pjuQBCLol2OZdJO7Tjbn9Mk1948XNp46DDPj
	ThkiSoVjIyySb4rRItYq71Vbm7+G5q0KYBMDk+1kw3haRA6+/S1fOJrURw==
X-Gm-Gg: ASbGncsJh38ZVApPuplAcMV9VrFT7nnSqRdHwhS1fQyic6CaTCq57bcbQcgmdor/fDp
	qFunVWV4pZiFDsFMZEGe7oKvUJcpwChtD8VD3vvmq74fqtN8cdTDtDhghAI9AXVeA1uWLCzBe+q
	0bwkL3ta9CGxZ1XVcGoUB/Fm802ggiTXF0UCyi7E5iBuBX446RCGmUvYo/5+dxNuRaU639PqU1j
	BKMK/SYBzofns+hm24KGKc/vwp5SdDlc0gxKHscRCcW0/nGpbWmEMMHCHrYdrBMKoiVILwf1i8X
	dZXWkrn4nD61GvGm2VZh
X-Google-Smtp-Source: AGHT+IHIEfxyi0Zojkaoz5KClwLmZ/3MEKk+5hziIZDuQwVAHpmTHbdMm5+igGLO4rJs8DEVcgU7mw==
X-Received: by 2002:a05:600c:3b23:b0:436:4708:9fb6 with SMTP id 5b1f17b1804b1-43668b5e02dmr430317715e9.20.1736168491033;
        Mon, 06 Jan 2025 05:01:31 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b4274csm603821645e9.38.2025.01.06.05.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 05:01:29 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: GCC patches <gcc-patches@gcc.gnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH] or1k: add .note.GNU-stack section on linux
Date: Mon,  6 Jan 2025 13:01:17 +0000
Message-ID: <20250106130117.1230925-1-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the OpenRISC build we get the following warning:

    ld: warning: __modsi3_s.o: missing .note.GNU-stack section implies executable stack
    ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker

Fix this by adding a .note.GNU-stack to indicate the stack does not need to be
executable for the lib1funcs.

Note, this is also needed for the upcoming glibc 2.41.

libgcc/
	* config/or1k/lib1funcs.S: Add .note.GNU-stack section on linux.
---
 libgcc/config/or1k/lib1funcs.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libgcc/config/or1k/lib1funcs.S b/libgcc/config/or1k/lib1funcs.S
index 0c2ec5fc8c4..8f7266bedb9 100644
--- a/libgcc/config/or1k/lib1funcs.S
+++ b/libgcc/config/or1k/lib1funcs.S
@@ -19,6 +19,11 @@ a copy of the GCC Runtime Library Exception along with this program;
 see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see
 <http://www.gnu.org/licenses/>.  */
 
+/* An executable stack is *not* required for these functions.  */
+#ifdef __linux__
+.section .note.GNU-stack,"",%progbits
+.previous
+#endif
 
 #ifdef L__mulsi3
 	.balign 4
-- 
2.47.0

