Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6479A26F289
	for <linux-openrisc@vger.kernel.org>; Tue, 28 Apr 2026 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396896; cv=none; b=VG9LpeDxS82SWzfOaX0QXdWSjmle9oKcqGcVVuE/U/Pyl1QgP1nO3qe52PzT44Sqo1UifqTQMGr5PhrYMFkn30MOZnZGCAw1RUF9AX0nqLBEXYiCf7JkdEbfJjyEicAMdSVPzS0FMqICZP0sg+XSfcDcjc4T/h1RtvvNpAQ8Aa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396896; c=relaxed/simple;
	bh=4XHQIhU6JFFJSMVzNaX9EI+uUYFdED97lTFZClWxvIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2Las6mPJjSaYjXuEpIsEtq/viq8XZVBUjhBaxRXvQjU9Kxvgn/f9LRrXo75o7vdAa/8+2Y/dFcbsQn544BSsa1xIyM6EdWhjkecB8U6UhL/GAC38Mfyt0uc4Ua+cxDgqLL6O72YCPxqx17ioi3lBFJ8gTfDoOsf0qF/QPWCMNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1qNMXWq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1qNMXWq"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so154342615e9.0
        for <linux-openrisc@vger.kernel.org>; Tue, 28 Apr 2026 10:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777396894; x=1778001694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmGOYhAGLse9yeus0Owfrm0ZcexMp7LbBCY4UT6PZys=;
        b=F1qNMXWqyEOl+70GoJ6q0J5cEHOiXQq2v31EWa7HrP7DseHFYupipgp+LhdakAGwuL
         dAKNuzuH2Dj394r3ZoV3ai/F1O/V/X13nFk6AcTJGv3tkt5I3MC38sG15YLoMoaYT24K
         w2/ZG+yQvWBk5ZVGp/Xvno9KBDMWcbTHe/igyybEJEr8rixU4mJcxjXEVAmW6ewek3Je
         MkHmr41AF4aMia7Alt7AdJaXaxK3+USkaaudCUDMgiwgM2w9wr2juYS7U09IucFfUyBD
         MROePG3itZ6xt7AsT8AAxFfiVT18WpGXsKzIOOeUirDk3u7NNvbSyRbM3wintiL0cq0H
         RkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777396894; x=1778001694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RmGOYhAGLse9yeus0Owfrm0ZcexMp7LbBCY4UT6PZys=;
        b=YqqYiscQtnRnBhS2srZO0nsKcJqyXKxDW5Ajse9Rx/5qPcABFkF0TxOpJUjpZ3pY/P
         /ZJ7caa6kZs03sHgyNqn+wuPxEI5BVWAMnnG+NbxXPADXsOAA5tLDZw7HaiDOCONqAbF
         NuHAXhjkAdC85M2UYhy6MipGARh4DU+H8dqqyG3vn3l85C32Z0zDf4ujR2aFYHT7W+bv
         jb3O33jYDcfVhs33hwbPaYqPrD8ETS79wmbM1eJ/I3gaQi3Wu9w2456SQDcO9j+de3q+
         nddT1gmR74Atdidj5zu1S7MXjWIxGgK5EO7FY8KxL2axvjfRSBXIt9rBAfx+SEfaAVbG
         Q7Fw==
X-Gm-Message-State: AOJu0YzNwaWaQWTBmQpPZlEjeQGATPWEGdyXGCPlC8WSBscJ9lMsV3RZ
	7id0ZUg498ySr58V+PHQ97HIoLzcrOoIB4ru+qs/Wdx95Xfpn0Lram5wkQthA+8G
X-Gm-Gg: AeBDieuLj+J18XBQva6m3reaPfYP5c6/9KowwYd5dxdE/kdNXFVqhER9iI++keXuyiA
	p2SvhUeCLHrxetx9Neox0pQV+1txC+NpksuDa0Q+qym5HHlO2soWE+ytbj8fsQ12OWZQanJmlLZ
	ot6mUknUOdTyjpGSI+gGrNuVbefkLO9y8TZMvsxfpONlB/QeBLNFIH0SbG+b+vbdZOB+By1M+if
	Hfjy0dTUnVqp2uh+ZgBdL1QbJcUWKlFqyh/xzNzVVF0gMTTnARao2+Du9WG4Am5uZE2wtwMshxa
	oNIupYRJ1VJ/IHHq3jKigsHjDU//w8OzamumAhvjSDoJFy+s78FGfg5fbihBE5tc1OMaptd81Ht
	FWKcQHUGMluBN3Y1glnvbD7gUx/wyNZ18disn2DmZPRHU8TUElvZyai5VHD7QXmwbSJLRDBoKgp
	+Vbo293stOxr5D4XsT7Sx2OQsNCaQfNb+nS7cyzxu5faqRkr7iMO+EgVEZDkZ9vujocFTt8SxFU
	AEe4cQ3qF802rco
X-Received: by 2002:a05:600c:3b8a:b0:48a:56de:d640 with SMTP id 5b1f17b1804b1-48a77b0a367mr70786875e9.16.1777396893535;
        Tue, 28 Apr 2026 10:21:33 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b900af7sm900415e9.1.2026.04.28.10.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:21:30 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Peter Maydell <peter.maydell@linaro.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH 2/2] MAINTAINERS: Add myself as the OpenRISC virt maintainer
Date: Tue, 28 Apr 2026 18:20:55 +0100
Message-ID: <20260428172055.1525176-3-shorne@gmail.com>
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

I defined the virt board but didn't realize there is a separate section
for listing boards in MAINTAINERS.  Add myself as maintainer.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44207949d7..e9807fe6c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1516,6 +1516,12 @@ F: hw/intc/ompic.c
 F: hw/or1k/or1k-sim.c
 F: tests/functional/or1k/test_sim.py
 
+virt
+M: Stafford Horne <shorne@gmail.com>
+S: Odd Fixes
+F: docs/system/or1k/virt.rst
+F: hw/or1k/virt.c
+
 PowerPC Machines
 ----------------
 Bamboo
-- 
2.53.0

