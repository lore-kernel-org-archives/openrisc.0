Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D4022FE08;
	Sat, 26 Apr 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745682416; cv=none; b=mshc16HqsT/mYHsm4uyTfjoJLpBX+Dq/yeSfLiSh8OFngVEkRhP9k4F95MJNIrcsRheKaqiBK3Fy4RGwihUbXtRaBioGNkKJlTbhhXoH+IdLxFQfa49P/hDaVRi2eEjZXMEMuP1DbW+72EV4lY10ZgyfnMyQTzrCyGuDUJ0BXoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745682416; c=relaxed/simple;
	bh=Rgi8sR0Scpj8W/52YnoSRB6wQD+9spWlGVgkxRZUMug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xgqtl4tjsObFvI0uHuy4C2WxCe4dZfviLLiZxOshGiJCTXI9F1F1RQpxFgIVAhiGyGkC8GXFTmogaI9pivw/hHnrKrcbVoBAZBsBY8E0UxlYcP4Y9qrkGQ1yEDVevVpUqAVgfPzrEfFfWH5WqtdZf4oiWKwHRKSPRaZW7VdpReg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmWIv8rv; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmWIv8rv"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c542ffec37so388585785a.2;
        Sat, 26 Apr 2025 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745682414; x=1746287214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CIRhaM5iWyK1K3LU98ZIL/PoPZzSsE8wClvA+G8ee4E=;
        b=dmWIv8rvqSwpDuJMMoeplDwLlz4XtcRxwPmtkyovZTFuqmAumhjYpToOAkXFMrsxre
         vdeRISqJLXAmEnzUfLl/7jI33F15NGEtDao2uYAIrksNHO72jEquu23hQ3g7+uek1rQu
         ViCiTqIgUN0SFys2TgKKBnhN7cwInmSdJZ7UtIuCPAptoEi/0LhVPj3RjXJD9R6H4R3j
         9mrkpX3CGe4sVsXarDMN+ZU3No1ZV1rOUP0mgGKbw1bXhSrkJYyxU2dzpW/QzXCosGDc
         lP7St9fzOHK41CRcaQMKepItkv+d2GQbXN5QLEnx/1a5H4HjqQUDfUgIRv0Ld32vjxVf
         pHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745682414; x=1746287214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIRhaM5iWyK1K3LU98ZIL/PoPZzSsE8wClvA+G8ee4E=;
        b=H+iHoCyxbEvi2l/gmzL80IQM1Fr6Qk0UZ2Bd7dWu70uBwnMgj0w1VDAn+GFYBcomYx
         azs9sT2Ne6d76PF6npUhcCXSfQywM4HdR6J7PlMlvWlKDXpvqp4eWy31jeIdihWdoFl2
         UtUeSTFHSSuwyUEja5gFEEwIKqxWWYQEj2vMa9ZYXou4QC7jd9Taa909VMUZvnPSEb2u
         brqXLnmvghVddheS1s4T2YX2WWSXM3UrmRoEeU4W75CIghxKl59XvwW9kE6PyZxRmU2V
         8QmAppjxxH+cFp+8E+qwTYdaWEMHyNzJimdaRnHZXcR9hxtqX9IlMp+bScjVegkXoRvp
         U1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCW19fTCyEIvlOGb8i32kxdGmEVkl2oj7rz8vt4O3JsLI0gq5WZwEhRH2Xv7tgwka9+7l9fuxse7VpF9RGtRSlI=@vger.kernel.org, AJvYcCWbEIDh31lpz5PSpcjttLLwoqtieeyFJCjpQJ7JftwAEHq6Wt8J7aNagxVNQuuJPR+p4rkOdY9OVyCL4jmW@vger.kernel.org, AJvYcCWckM13e7MKQdKBOkpYQ5xnZvywsL5pYK5n/7JZYiZtAq0w1nZvYoOQ7y2HG01HSbU/ee1QyQPGVSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIk38HnMrR4AwYYjS92BOpjlBFPDfcevv5wAA0rgI7zG2SdkEN
	xqA1zz4jt7pgtrkUCFKGXjjOrnvMM/1UuTQ6204YN4qQ5AcyPu9S
X-Gm-Gg: ASbGncuG0DN8LiIxcvnKfcQ3oTStIPNoOE/+gq2ZZwmEAY9ZsJVPIlRNTncjjzIyi7T
	OR5cweq7Fgq1kF5HZd34N4uTXXNAgFkRNgHYbeEAXSp958tJvqoFMokgP8pWYnwlYkO59NexdS5
	/NFZXxlT4IdPZxLeZ+uGFZ62430wV8ljbg1toThqW6y1opUc9hANZn/38jPaNLoeeOIeG7Mb0Fd
	w6V2YFMO+I5OHD0VeYNBGFCtDeHVV3Y9m67cki5apX5n2Tvn9ffIId839DvWsNAb1tYf8EA3n5s
	f0rcJOF25CaY0tWNjkhR9JJuJGhsmvNpFe45QTL3Y5SkR1UIGFsdhg==
X-Google-Smtp-Source: AGHT+IGAG7Vyz7m5oLIWXmAWmffgHbM6UUmV5kNolJgcJBqni2w+s0PnDOEo9gAG9/MNL20SdUZdMA==
X-Received: by 2002:a05:620a:bcc:b0:7c5:5296:55ba with SMTP id af79cd13be357-7c9606f525fmr1039841185a.13.1745682414177;
        Sat, 26 Apr 2025 08:46:54 -0700 (PDT)
Received: from localhost.localdomain ([142.198.9.156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958ea36eesm361149685a.111.2025.04.26.08.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 08:46:53 -0700 (PDT)
From: Ann Yun <by.ann.yun@gmail.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: corbet@lwn.net,
	linux-openrisc@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ann Yun <by.ann.yun@gmail.com>
Subject: [PATCH v2] Documentation:openrisc: Add build instructions with initramfs
Date: Sat, 26 Apr 2025 11:45:44 -0400
Message-Id: <20250426154544.15351-1-by.ann.yun@gmail.com>
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
V1 -> V2: Mention Documentation/filesystems/ramfs-rootfs-initramfs.rst

 Documentation/arch/openrisc/openrisc_port.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/arch/openrisc/openrisc_port.rst b/Documentation/arch/openrisc/openrisc_port.rst
index a8f307a3b499..69aed4069e3b 100644
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

