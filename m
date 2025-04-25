Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6261E0DD8;
	Fri, 25 Apr 2025 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745611859; cv=none; b=mSo42aTXWdN8Vfbkic9/teAz1wfTGcmfqg5XiFymiOV0CLvL9G/aPtpYbsMjoTn5qpUIl9J3LlAQaXAljFxbPxxwDk3nGLRfbhMBGz6piEAwdHfqZb6dNA/e9OCPdoKCw+1nGKWzZ1qFJmTKJBW2P7smiFLIwRXhNfzPHOe327I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745611859; c=relaxed/simple;
	bh=iAN2DwDNSFYxPIFWBolUQgDP9zERohfJ0m9WxBGPsu0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=naVr8ZXdBLAQxWow02GNJ9aVjx511PSF4Cwsm/1pUsk0ucpweMejUxP97oNueTEyeocF+fJF954O4ROHYq2+D1lQw1hrOiFeJV4y/igI5nS/BGGc2lMUO99WIL/SpAq/07eY9hsHmbcUiKqeWha9iHJdTRJpmgdRnMbrlxgH1KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmof5/9j; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmof5/9j"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47691d82bfbso57082301cf.0;
        Fri, 25 Apr 2025 13:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745611857; x=1746216657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ecpi0yXmCLR/zZGykljJqIIXcXWNiToNhd/W6QWxv8E=;
        b=dmof5/9jqh7COdX+zRatApTbdbTju86MRtN519g4va/kNn4mWSf0K1FXysTuidkh4H
         MHvv6TUzuxRX/MfEoJfRJDGP14TNF0xfeWqH9nX/AEsdhfjseh84OA0BkC6AZDXgQ/9P
         i7m+Dd8z6vP4LZdOZZrBsFEostE6gHQB7DoKmSVW3B0Xd0hQLd7vXjhFRFdSOz4ohyAE
         mujIvxuG4cZuWn+7xomKbAxwFN8qUuxvYxBEVEIAkMspVzEmJrIdxGVFUTd+Vhm2Ro6i
         0sUh7MtUJ3zDci/NLAFTOJwGdHHpp4krasEKMFr/+h8Q7FRbYeZmoIJqcbqxnMUXUjmm
         X+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745611857; x=1746216657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecpi0yXmCLR/zZGykljJqIIXcXWNiToNhd/W6QWxv8E=;
        b=HBC4DfapU+OfPm8wSDHfTqILjciySkglQRiGqYeYByRoUKqSIiMz6Ojn8RlK0oHi8+
         jdXd6oUfGhkv48I3epHkyTMt3IL6BV51it5iwbestca7b7sfmYG9ke38kNiFOjBmnx/t
         s1A0N+62fI1TsqT74NIOUpZ59rrhDShOo5n05JHnkLcPXLFB5/jARcpv92kIhiD/h9CY
         1gxhdoG2Befk4ovsHfnNsk+h1gU4wxXN+uohVdJ+hnAWnNGkDQrsi5O/qHpDB/TQUZ/6
         gKfGJBLdgHY5WJ72gP2bhhRDHK3C29Wnx8MlWPwocYsMxt9z+TtTN1i1wiiH4e2TAquh
         k6zg==
X-Forwarded-Encrypted: i=1; AJvYcCUAPTPYK9ph+DE/Ark210YtaZuRqgpo9F/3mghRm2MZ1WSBLeZV9mUXN7nfn8W9Jr3EnuVRqCo4b4o=@vger.kernel.org, AJvYcCUGjQ4YWP7NpGlEN97epO1rtSnuA3wEjRxbxB1A+2HXK6AdJ1o5ON8uvdyLABbVqeLSx0pMCLBUSA7Vq6KuHcQ=@vger.kernel.org, AJvYcCVe1F6GeR2QSGmRqDsNLY6CYcuRcdrWGzpeTSR1zNpSwzBAcUk7NOQWIDMuxcAuc/k1xdBpsiZmZpaIjx4o@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfnu4w8oyADCMKbIx1YzncCsmxXCrFQMiIWwMLvajF1W1f5mcN
	axAnMj+Y3kVuMsaodqK9EYD8IQ8D7A6nb3zQ7G6l1OlMbhjfNCyH3uIn+szK
X-Gm-Gg: ASbGncuB9fiY1zup8nPuZi8kM/pMWPax/NDqQp1eJ4anhvr8ugRqClnUhn1e5AbWJ2J
	adYQLbmEAlHDIaDqy1RttpO6R8XasDMZ6r49dHJmphbYybtbigTtdpBgv39KlOT7D/PHvaNWYab
	7aA527CsfJ3QtUAWxyxSa8wvagGC4V9nBa1EZeXbTB875IU1WEQeBN3qjZ+whg3md5MlVngkBvg
	xmFHw9fnuJvK18JhcgdSg2aCaaph0qZXMq/1MHzz/amwrCpST1CFhPLGJmVFBEuNWHQpLMrlqpM
	NxXRJq1jtnsS25eURsT7uBD5lqMA1sqJFyb9O3nVThJJ6WqaeKlC+Q==
X-Google-Smtp-Source: AGHT+IGK15CnrUKC0fV/s8f5P3y85p0WFMcZtZmPPuQhAo0sC3m87Tby2FfjsYtTYV3Ows577HG95g==
X-Received: by 2002:a05:6214:2306:b0:6f2:c81f:9ef0 with SMTP id 6a1803df08f44-6f4d1f906fbmr12015496d6.28.1745611857070;
        Fri, 25 Apr 2025 13:10:57 -0700 (PDT)
Received: from localhost.localdomain ([69.159.84.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0aaf948sm25867756d6.110.2025.04.25.13.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 13:10:56 -0700 (PDT)
From: Ann Yun <by.ann.yun@gmail.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: corbet@lwn.net,
	linux-openrisc@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ann Yun <by.ann.yun@gmail.com>
Subject: [PATCH] Documentation:openrisc: Add build instructions with initramfs
Date: Fri, 25 Apr 2025 16:10:18 -0400
Message-Id: <20250425201018.12756-1-by.ann.yun@gmail.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mention how to include initramfs when building the kernel

Signed-off-by: Ann Yun <by.ann.yun@gmail.com>
---
 Documentation/arch/openrisc/openrisc_port.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/arch/openrisc/openrisc_port.rst b/Documentation/arch/openrisc/openrisc_port.rst
index a8f307a3b499..4ab28879d7ed 100644
--- a/Documentation/arch/openrisc/openrisc_port.rst
+++ b/Documentation/arch/openrisc/openrisc_port.rst
@@ -40,6 +40,10 @@ Build the Linux kernel as usual::
 	make ARCH=openrisc CROSS_COMPILE="or1k-linux-" defconfig
 	make ARCH=openrisc CROSS_COMPILE="or1k-linux-"
 
+If you want to embed initramfs in the kernel, also pass ``CONFIG_INITRAMFS_SOURCE``. For example::
+
+	make ARCH=openrisc CROSS_COMPILE="or1k-linux-" CONFIG_INITRAMFS_SOURCE="path/to/rootfs path/to/devnodes"
+
 3) Running on FPGA (optional)
 
 The OpenRISC community typically uses FuseSoC to manage building and programming
-- 
2.37.2

