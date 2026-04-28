Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D533D6F8
	for <linux-openrisc@vger.kernel.org>; Tue, 28 Apr 2026 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396887; cv=none; b=f/xBsXbv4pKXNTPPRHvvFDM629opsW9aELwEq/OdU2vzQqj1xsVDqZfLSZBkXhKqdMv6E0ttrr5utSCNMLG4GOPPLySoZwSRKTmKpjwQEIvrKExBfKnDOg4PIXHqCZryddujrDswWyc+WOKgwPzOwoGb+Z7scN5O3Ua/fnc4+js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396887; c=relaxed/simple;
	bh=VJ5kuWag0yirH/88cC7jEcEC8XGMLYWlsHCpXZNwqBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jKmyR2Xk274LzSWFTZO3pKCzr2GCLja8MoHKvd5UyxjxWvbrBs/UghjGocBW/w8a/44JHkKUbZt5rPeUi2qrmPuhh0ynOF9PBvn5Z5AxwVNypNDr5GsLAqWuwpb4A6licUHa7yUSwKRH7Lgk+QByipbBwCpRNynjiEiqBPGa5wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe6A85Wc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe6A85Wc"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so11764150f8f.3
        for <linux-openrisc@vger.kernel.org>; Tue, 28 Apr 2026 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777396884; x=1778001684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kNowD0TcLYhrB4CuZH19TpRiJOZYqasUwam8Xxvtx38=;
        b=Qe6A85WcnJC2Om97QG0WrXqvR+pMvKbyld4vv0qzDmSVlctlBI2aoy72X5pouKapFx
         /SzQ7V+rGCItjUkcem2N9+FZun5+tlS0I5krcMJed3eBr+l2smp5Q9EBXvRYJzNJnvMm
         fwGMc/TnMBOSyLJvENW37sX1MUWJABJBWMGZyYDspiNQE1jfMNPPsE9ntwdIz2/y22eN
         XMoX2EMOlRVCONOzpg5fdVlauvsmbXfBv1vQZNeCdu76Ece0HDV0vonuBsno53nmzTl0
         f5YotoTrdVbFRZe0m/HWN8XSlcp6TugDZJRi8Jg7CzJIlaNH0apCN2AsGQb605MVpCNO
         WOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777396884; x=1778001684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNowD0TcLYhrB4CuZH19TpRiJOZYqasUwam8Xxvtx38=;
        b=FDOdtYErXeej8j3qowL7GJKtuEip+pi6P3v5kznjCRt5/iA+Eh2leBJjp40JZz5ENp
         rgJ32fxDyhEi6bZZkibO7HTf1gTw/3mNSLlBMf9ZaV7TYcv8rAFTpqfUCe+xDmbPRawF
         Hv8BIzygBfUQGHivKDM/fQmXVoAm0yO0IKu5xZI6KWYsK4DjDZ97L/L9pp+I7KNxTemf
         Zdtd/j1OfCKLmO58YuvMu85Cavqs8VbG6oN2k0AT9WuZiuo4YMIKfyfR423AN/QoaQB2
         +2asr9WeQ5nt0rZKKNfJs90f04Nwp6VC+vfirrYCb1TiPnB3p6KWUuyrfrjPwpQurr1O
         GlXg==
X-Gm-Message-State: AOJu0Yxq5Rg5jRxTlC3Da9jU5TGE4p+Nkfh2R6npZsmjYZDDD5O1N/mo
	3NyFq8ubxhUDg4S4hAgJAvazyRBaJIVhc5ylqsjgl7jfhykgdYdogQox
X-Gm-Gg: AeBDiesTurp6wAFZmc9aC1B2a85MSUEWXCvzySAteSXQnNXb+epXrq9kfK77aZxOZg7
	R3RKDhJLnW1YhRSxHBqXmWfW1twLWFT3p1S7RhcQGoLWRchLIv7Zn+hDBkgGZnnFoWXux16uaWu
	XoSO0gFXLeHyn+mGfBgiT182+kHOTLlbZ9fqxYQllr79LVjSEdBj9oltfoINY282R2vb7dvJ1pb
	1b5+0K4l06CoH5o2jVho2GXMIxFQGp+eErB/5WzvnB7ytJlqmNXpvDbPepvZH7oxpG7AKSaGqkv
	C1ta40o/FyqWeuYXXy4LvfKwADbt9W0CDgwcORwWYOAm2f5UQfeUJZDL3awuXUL1az5p2WVRO83
	YcvoFIIuxdLmMXLfYNVh9Z7ek9XC9/j6LkseZ9pQYOnk+9YS7VLLczZDcZ6iXEHXezsSA3dHgJW
	TipP7vQn4Xn1f7oHVu045/fOF7hZht1dcU+iQ31m9aBLaAE4rTcE+BflnWOSJSWdWXwN+5M1flX
	dRDbV2gIrWGPEea
X-Received: by 2002:a05:6000:2007:b0:43d:50c:6f33 with SMTP id ffacd0b85a97d-446494ea060mr7114729f8f.26.1777396883748;
        Tue, 28 Apr 2026 10:21:23 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d02f35csm9197860f8f.11.2026.04.28.10.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:21:22 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Peter Maydell <peter.maydell@linaro.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH 0/2] MAINTAINERS: Add myself as OpenRISC board maintainer
Date: Tue, 28 Apr 2026 18:20:53 +0100
Message-ID: <20260428172055.1525176-1-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the recent changes from Peter I realized the OpenRISC board maintainers were
not properly documented.  Add myself and ensure virt is properly listed.

Stafford Horne (2):
  MAINTAINERS: Add myself as maintainer for or1k-sim
  MAINTAINERS: Add myself as the OpenRISC virt maintainer

 MAINTAINERS | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.53.0

