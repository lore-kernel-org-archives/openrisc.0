Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0870D4A2E10
	for <linux-openrisc@vger.kernel.org>; Tue,  5 May 2026 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002184; cv=none; b=TK2v3RSnh8LC93JBZfii1Wbnz9t+07pmRvm8RsyVYWpBf4SBi81zxZ29OQQvfUsqmMEyTPdJ2SMynt8goTrPG2lXu1IpY/x7BWAY9rgPfEYRFpYmOegFEeW9gEsu5AAg6xKPS0eNu0ExLe1AjhYLnWvwWknW6YjiMffRbBGr0cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002184; c=relaxed/simple;
	bh=tRntvI2GtsQ8jVGhd+RrYQ9L0L3mVxMbqAngQ8uvPn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omz6J944HsNvm+J+dmMtLerxn5NuFJAwD0hc31g50fDSZcKz5m2aD2t0qe7A/eOKj8mJYkavhfXtddUm2tiiXBQDq3jWdC3Xf5TCW/IIpXQ1Vcu7wygSFtco4VyNKMdf9fHNZkZOuUDI36BO7Kaz8RWRSw/HTjW0zyt/19Zir7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/B9QsxC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/B9QsxC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so62337395e9.2
        for <linux-openrisc@vger.kernel.org>; Tue, 05 May 2026 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778002181; x=1778606981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/t6JUfYa2nZid8K5f02rFeaT8IlpqWngp8IDRPDyi1E=;
        b=J/B9QsxCxR0JecWgwkHWRe08TSTRhl/DldYUJev/1TeNI0yz5c/4C/knTmZhzyz25E
         xpLuJZdgNcxGlkQ6xhqhWqt+6DXOHUkg2ZINDFFYZxJeJUvlOYDgJMJ4QipQ8GLjKKQB
         0Xxva7n7AFEbmpOjBp/HwyHbYW2YEmkaa4a8AW3TXvSh94osbSdTBY7KKRt8E1CICYv5
         2AHicdFikwRZ7rztRsfYGz6T2u/HT3IpU5/ib8QvHdD9UJL8LvTCrrVSsUp6573f3P47
         ErxzCgwvGpvs+V95g/Q+IxG+TRBXGk3Fuvmb/x4ASA/oDt+AtIY6KSCVmSYx7dgNFEza
         0KKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002181; x=1778606981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/t6JUfYa2nZid8K5f02rFeaT8IlpqWngp8IDRPDyi1E=;
        b=GUqIL5FeclsOigjCnxywvJVB7AQHz8bW9oKEX95qimzjiSFnEVTaBpcW4/w0saYfVs
         6VdPCmQBTBi2H7BttnSdjIRoKY6PR0h8qncn4xT5AwZaaTwS0SKCxD4/52pnDWeFETmO
         gbSbiwWTO3RRP0R4Rmw5XvhJ271yNzOqVDvexLTEH0J7Z0n/PE8c7jtRgvX0xvCxOPIG
         9M3eZvUwMxZ1xV+2R+zl140YR0ONjqbAsZq5gj5ne3xot1xRKpgxTc6/XlKHOmVsW9cP
         5YUMLFJyRKuRmNNweDf5Qnq4besYPUnWMZZI5zyxdp/Eqnag0V+7HIMP+ZTM1anIJ14U
         hNOA==
X-Gm-Message-State: AOJu0YxPM1aaMJIDaRQDtQIn5c5sHFS2GNFbLmjmqSIAbD3D8jQp987i
	GiWfa3ICPM2PQRXSwc1Qw9RjLUa9FbVMiF1DxzvOg7KAnkiyW2A4Ohnh
X-Gm-Gg: AeBDiev7srga/1Quba+EjQePUtqzHVFLRbJZOqlnbieD9PC2G2m2rEgoHJ/e+DFg8Ad
	7c8wezLofuuvwLFu4uNKuglN3aJv5VaPUWVwInJFE9iB8H9VEXzVWGRLEsH9WGrOp1vRpkkpVVe
	6qqSqlX5hzJu9MyNgHb+CBicZz9X/cPHgzi4obBQJzNlPWQkuEmni+KCYu7W7Xktd76dsBmX6i8
	gR0+b2eqtj+wWEisVWVKC2PXlACHvIDo5CAwlPSCVEAZkN/Q5oyCpvoGIs9W4aj2kaHX6WBQjbu
	Xdv4eADYEdaN8Th5nJPEAe+dZQarnX9wAePLmA2qWrYUxgAB1qzB5DAw82DitjPkGuRRipcPluY
	4MkzQIK5PF+Awn4Zng6ubZkU8JkeK5gAVb4HUh+0pOzjnV6HbCiI75TdHDE/sj3lFx795mgo4Ju
	kZ7u9zJAP8/r+vWLn1WssKCyHKVCSnUBb/WBTu1NbhPGVaJq6IDd1ZZchFIizOYPJmCRBfq1htJ
	QnitDTM4ucQFXlZ
X-Received: by 2002:a05:600c:c096:b0:485:40db:d40c with SMTP id 5b1f17b1804b1-48e51e08fedmr2450175e9.3.1778002181132;
        Tue, 05 May 2026 10:29:41 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb6ffb7sm371662115e9.5.2026.05.05.10.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:29:39 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	stefanha@redhat.com,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/2] MAINTAINERS: Add myself as maintainer for or1k-sim
Date: Tue,  5 May 2026 18:29:25 +0100
Message-ID: <20260505172926.2235826-2-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505172926.2235826-1-shorne@gmail.com>
References: <20260505172926.2235826-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This was recently orphaned and since I have been handling the OpenRISC
odd fixes for a while I'd like to list myself as maintainer.

Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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

