Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2D523AD;
	Sun, 27 Apr 2025 00:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745712485; cv=none; b=EKXwIO+CKAVUDriUry4ncr55EVET8vJUhuXePMd9DTKZeg8CfHBLeT2IxIlCEuWMOUbhkrnDrWLLqBynao+BquGARDBYeMHDHRpsabFYCw8x/EkOUBR6hpu3Oy8Drt7IxRrH6JrvuM5uLyU2kD0LDHmjN8JkUInXxpKeEuueEIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745712485; c=relaxed/simple;
	bh=wjfCCLlYwZmCYTqqiEjtNJ6/c6Tb+wztP3xDkbSqKdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TXQ5fNpdU7gTQr73Le04HkI55yB60Tmov/y+39Fb2cRJd0Y5WXuWHko8I0HOXvwjHTGPmqaa814bWKC98gT4lglb/m3cdnqTzZSBuCS4eeByEiDCW0bB0yrXpw9AvnBPNfzRoxUWI+8oihVo5qoULgI90WO+EzwarHC/rFRBw9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aetFolDD; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aetFolDD"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-476ae781d21so41496201cf.3;
        Sat, 26 Apr 2025 17:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745712483; x=1746317283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RCT/HRgqINzLY7CNRmoeSWmRK0EmClZ132m+Jd5dekw=;
        b=aetFolDDcFDNAiJwkUZQqxIloKVF0KnKh9PZ7g7703AQSkbvy4jc+fii57eQpOMKGL
         nGmxTuRrH80KyMO1ItiXmKSLV0/eH+O6Tf0f072LHt8FmrRx4MHRK3gNTIciKYcNEGeE
         P6q22FTkeQBSwdSDb0Rmkj/qyZJQQQmrRVX10LEAuGGy/jidKXJUhJtAb3Kfo1r9p3dI
         1gA1+O+I+kUGcv5svYgybduswTFazni+ui+viZL9HyYyoQ1tIZGSpKhUW0yvVBzxvw8k
         O40/sIqvkjUl2LKW64DE2Wj74syBWevKcH666h+376p2Nw/yjdHGDD1qk9bW6V8egzY8
         gqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745712483; x=1746317283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCT/HRgqINzLY7CNRmoeSWmRK0EmClZ132m+Jd5dekw=;
        b=Q6VwWbv7UyYAbl6wCnhtweuy3LmoroH2ayM5LhKaDK9FeJfwG6bFki+aD59nboD37q
         5vptBUGKq4WtNqV+WjeCwjoNrOcwsr+z/oRan0hLvqguOeTY6+KO1RpeZWfu0zj5hsiW
         JIsTVEOCc05Kv9fJjrIcYLCtlPwRAANAPhC/IU4ALo+ngu5H74Vyt3CB5HIOVfe66HkK
         /uh2aVs1RbwrmVknLFfZI0v9zeUodRfJW6aM9ycoC1Pz/SevLWH8x9Jbw/0Amvv/MI5n
         GODfhLeFeEyhSyREpzV5xdlUDf13fT+ss0e9NUXagWR1cBjt/FTPto9MPkitMyCmp0y2
         yKVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYve9UnsL0q4nY2vhsGNSoEQs3sEYVSFWaWfvGzveyZrsXQvWhwx2VU68J9VCjWO+7OTIluIXoz2lTKpvF@vger.kernel.org, AJvYcCV7rErHIsVTzb1dvtSzXSDB8ZPFdD1I6SYIZCKWgqrFyh0z6OMimpCEYgvtclTXTXaZzA6Tt9S1oEm5WRzbAi4=@vger.kernel.org, AJvYcCVyg7MtqnNxGZLD68kQ8TuXD+hKIta57yfG7YWFb1bnIXL5NN3XWf/+Dd4+iM+KdqNZuPNM2C6RhrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE8mF2hx1CfaHUEwcthV3Ugsy5LiFBeM3sSg79W0IWtJ4ZBOjf
	Iy5FDKwUclzXZwZ8uVfLFXJvfXrsaIau3kboDElgH6XylMemtC6+SPCiNJiD
X-Gm-Gg: ASbGncsF3SPnlhxdVqJQ0Bv6WmCyYS/yrv8nrw8VlY4gGM+LyR0757v61SRNBrJz9QB
	zXsEbRudOyfvc4QvJsizm0t0wGTyaEWL0GELAUvQqYQn91QQf07L5OSj2xWcNHtT5WCaneWAnKk
	hVPHEiOe2psg5nOgO4hbSfTBkWhiTxHwcr26vUhuLPiPyis+6B/xNLL3InrTT+x6fl6S1BAF2Hk
	sEbDTa5B3k71QvT3PfYFDa32Jc6Hr07RerpzU90O1J0zZM8CqW6cYmYoC3T+bPxF3FmcDtXNMy4
	arK2jQNTdMmK5siBt3w/7YPJRV6PZndb4Z+7CxVd46ettkqKaWix8gaYAG1dF4cE
X-Google-Smtp-Source: AGHT+IGJRjTpMxSkNOT4b/hu4ZKYONDwvEUcE81889nOKyIcHfYOkBgTJk5UAGkzu0u6JlnnrSv6cw==
X-Received: by 2002:ad4:5f0b:0:b0:6e4:3ddc:5d33 with SMTP id 6a1803df08f44-6f4d1efe8abmr89438496d6.13.1745712482754;
        Sat, 26 Apr 2025 17:08:02 -0700 (PDT)
Received: from localhost.localdomain ([142.113.95.30])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0ad455asm39529296d6.122.2025.04.26.17.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 17:08:02 -0700 (PDT)
From: Ann Yun <by.ann.yun@gmail.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: corbet@lwn.net,
	linux-openrisc@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ann Yun <by.ann.yun@gmail.com>
Subject: [PATCH v3] Documentation:openrisc: Add build instructions with initramfs
Date: Sat, 26 Apr 2025 20:07:26 -0400
Message-Id: <20250427000726.17015-1-by.ann.yun@gmail.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mention how to include initramfs when building the kernel and
direct the reader to ramfs-rootfs-initramfs.rst documentation for more
details

Signed-off-by: Ann Yun <by.ann.yun@gmail.com>
---
V2 -> V3: Fix the styling error (trailing whitespace)
V1 -> V2: Mention Documentation/filesystems/ramfs-rootfs-initramfs.rst

 Documentation/arch/openrisc/openrisc_port.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/arch/openrisc/openrisc_port.rst b/Documentation/arch/openrisc/openrisc_port.rst
index a8f307a3b499..60b0a9e51d70 100644
--- a/Documentation/arch/openrisc/openrisc_port.rst
+++ b/Documentation/arch/openrisc/openrisc_port.rst
@@ -40,6 +40,12 @@ Build the Linux kernel as usual::
 	make ARCH=openrisc CROSS_COMPILE="or1k-linux-" defconfig
 	make ARCH=openrisc CROSS_COMPILE="or1k-linux-"
 
+If you want to embed initramfs in the kernel, also pass ``CONFIG_INITRAMFS_SOURCE``. For example::
+
+	make ARCH=openrisc CROSS_COMPILE="or1k-linux-" CONFIG_INITRAMFS_SOURCE="path/to/rootfs path/to/devnodes"
+
+For more information on this, please check Documentation/filesystems/ramfs-rootfs-initramfs.rst.
+
 3) Running on FPGA (optional)
 
 The OpenRISC community typically uses FuseSoC to manage building and programming
-- 
2.37.2

