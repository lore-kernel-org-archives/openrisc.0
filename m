Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4F126F289
	for <linux-openrisc@vger.kernel.org>; Tue, 28 Apr 2026 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396892; cv=none; b=gDDVVmhYAVlUIFtq+KCBc+R//EwijKgW3CWCRuxJuHVHgM/vnCgm+Be/q0n4dLJq+xa1kvwykTLGmqYR+8nldudZssa50tW/mcTqG0OZYclJdywkcBQu7Xzmm+IeyY9xySg+agSVkWB7bI31NksRbUZZiFiYlE6p3MT/IcRsTVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396892; c=relaxed/simple;
	bh=rLmk/Yt7BFtKjGxQMi+PZOSooKfNF2fJTMGedEAdf1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJYbB/o7ezzllvrlRy18Snlp9QUiNb6YBBCqsrEexkhKMVJi4FghJNvZ0xD3MlGIFG24jgSyZoXDHL6zDeuB7uIRkrKHdlEx9GeAccMG1pCVbzAtaDDnXuWSFjBCHH5ekPehyi9pZfC0dsYvbMFqYhgop/xJRF6di1EHKOMzy/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLGH4nks; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLGH4nks"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-483487335c2so113546995e9.2
        for <linux-openrisc@vger.kernel.org>; Tue, 28 Apr 2026 10:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777396890; x=1778001690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1cPbAMl8P/PHQADbAv6Bo8nBq564FcOK0Gul+d1/lg=;
        b=FLGH4nksSVu99SZJSN9qz6v4bd5UgHyYwLJj5g8w4gVXkF1uYDDg9hZMxNxopvVOdf
         FR+4sxWfOxxoRqTr8M4gOb46zG6V4PnED6oppnpXPAhowlxV9z+vESIVDxhkKFzRiypL
         XGPPdJgd8M+2CTGZ3Wqr1BCvlbU0WflY8PzTaNnEWj4aQxBtJJ1kdaWVCxP9BamrtD/r
         jDMDVkklX3A+HUDVKS03ISLJmQbD13SbBKC/KZYFfJoEb0ltP9IFYt90jMUK5DrZHRLr
         /i+m7CqNeaLW/KVxGLxlygJb+iFyL+H6PHyNEIdafYFzjJBrcodBDxKtl/yAcm4USITB
         XHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777396890; x=1778001690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v1cPbAMl8P/PHQADbAv6Bo8nBq564FcOK0Gul+d1/lg=;
        b=L0zAJFGVWINWygCBzy62tEoQwM2jcgp90TcAmgjbMKlwSUJESoG3hZIRB10fMccY7Y
         cDbwSikZVrA5bNEaut4xfFOnKEnaVhvPnq7gcbDCOgMsYjoZcgXB0Ou8bvdEQfv91BTA
         V7rD1kJzDLigfoGSma7EMMN3xeeiKFCP7mgKZUZVFc3YLT3hqvq2SDnyP11TZ8JX6HO3
         vdXWuJMF0Fg9fR0DnpNFhUjbbOS+dpICwlUZfk4x4fFyEBwqir1ESRz+nKgVjaMqYLk1
         ZhTDXLwktUe3BLbv2X1P98265TLfiNEbzvZtgs2lNP1nQUg24pNzrBuukENUDajiGtot
         G70Q==
X-Gm-Message-State: AOJu0Yx4D4wpRQqhOiwKbr9HYcounX5qK+gUAXREU/Y4aBABfArLk96u
	gz0R5K04s3Gfafmf5KM3QBAWSC6lZB3V08SIjtRDuX5mb3p3V7pr8zyt
X-Gm-Gg: AeBDiev8Pqg1Ul/a2Iby+X+2YADsyzJRvo/+Z7Qf8jw/jzqSInSpxhEMLRZY/YZ8oEw
	rnw2m4aeBlG73puXVAHPOGdZsuQi17R87gRP7i4FRdTsVaf3jN5JME1nR/w1KUI+mmZBdBbGp4z
	ppg/LfdZe1e5ErPTVFqZ9EIn5f26Skn2wHQCRVFAx8+JeZL/g9CsM0VXFL0NBUQHID1LFc4kDua
	ImQn+YjW7vyKhu3zV7vqJWYtpshAR9YAuuVxQ9h2NzEN0OQUT8NfSKNfPvjsrkCk0uV3c19i/FT
	NFOW6rUK113vEH0dAce27GvH9q7mSMZPkq5qjNqbyf7BN/XUEXSF/LRJ2+aqAvruDEz5DVTL4B1
	rWyQEt4ndFamhFZ37Y5+dF7cXW4128abww+kufJaM+5EoQLAb0mWdRMpC5pnzHsw5FYSubBsflW
	mQo2+kJjdWpi7yZlyTzjt5GgTLUzzi2YxdOeNZ2FAXog7xm2PIz8DxwPCbmtie0HyEfWp1mdgmN
	kVndrF2aFJBioU/
X-Received: by 2002:a05:600c:c048:b0:489:1ae1:4eb9 with SMTP id 5b1f17b1804b1-48a77b233e4mr39882815e9.28.1777396889798;
        Tue, 28 Apr 2026 10:21:29 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b91285esm865315e9.5.2026.04.28.10.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:21:24 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Peter Maydell <peter.maydell@linaro.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH 1/2] MAINTAINERS: Add myself as maintainer for or1k-sim
Date: Tue, 28 Apr 2026 18:20:54 +0100
Message-ID: <20260428172055.1525176-2-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428172055.1525176-1-shorne@gmail.com>
References: <20260428172055.1525176-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was recently orphaned and since I have been handling the OpenRISC
odd fixes for a while I'd like to list myself as maintainer.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 49f9bce818..44207949d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1509,7 +1509,8 @@ F: include/hw/pci-host/xilinx-pcie.h
 OpenRISC Machines
 -----------------
 or1k-sim
-S: Orphan
+M: Stafford Horne <shorne@gmail.com>
+S: Odd Fixes
 F: docs/system/or1k/or1k-sim.rst
 F: hw/intc/ompic.c
 F: hw/or1k/or1k-sim.c
-- 
2.53.0

