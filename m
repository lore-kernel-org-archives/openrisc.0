Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66F34A2E16
	for <linux-openrisc@vger.kernel.org>; Tue,  5 May 2026 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002182; cv=none; b=hlQBC9MwDcV99PLGyS3BX41CXN9ijp7COvSJr2cj5IzqhqRKh1h5Qe6kKDjP42V6m1CFx+iPD35iL0Hm47Tu6C2q+q1kp+9RTuqYHK9uiqK3BQJwqBPMhGQsTge0pmb9OplNtfhZ9CZQ6ZBoDzZpsDZ3XoeN4yHonjVDqUZ52so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002182; c=relaxed/simple;
	bh=PnYpdWXpmNNJz5dNVfO0qzn73uOba7E59LeSnYflYH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fVakbBcgT+gkfYgUBQuQKaZ4EPxtlMVkfdQwwdR3P1Cp5DEC7nw8J00eLEfr8iO2vyqMqJr53HXoCUMQvzHwK6JDGwg2zOOhNA/wD0YP+FQrgE+Gm8u7vrxImd1kQVNQu0Qcr6o3TvXPD7n10WDfQegGasLBdRxpl04w2OiyPZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2WzQXcx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2WzQXcx"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso49155725e9.2
        for <linux-openrisc@vger.kernel.org>; Tue, 05 May 2026 10:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778002179; x=1778606979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hoSOi7ycLlP/xlUg9Cx6ztjnzMetX3ekEZi2wmcfu2Q=;
        b=Y2WzQXcxvJH6jgWO2aIsl+FX6O0tf7E+ibQSZHZSsvFgp3IG+NZk6J5gu84VmHv2U8
         JAkj6KyeC+Zu2AXqmZtO9z2GmCXt1850T/pIa+rNYu8bih0W+6V1uIKU81zsmZKJYE0C
         o373CW2QyHQF8SQBJySTBOHw+ve89ce0gdagMOUnRou+9IBohtJcKHFkYIwsQ+3mGsyD
         IPihi8fVfS0KGOxYadF75lDMbjqgBXwjKmA/sqASBpe43iqCfsedvu/c30GETRuOlSId
         dTRcYnBVmIp5of+oI5IEtf3wN/M3f/EWO8m6Ix7fTGqcDlKVzok/w9VgM28DlK0tZtnj
         KtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002179; x=1778606979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoSOi7ycLlP/xlUg9Cx6ztjnzMetX3ekEZi2wmcfu2Q=;
        b=glvV0CDiAPwEiJINmviV0SMl/C8Cv8A1JlwXxAxp5Fc68yOhU/MMhyGkdHhmln+lA7
         VHkHBukrP4cH3zmMpFTkToI8XpoTDwPOyHMkF574JPnZMf3ZxIHXNN7b8ZUiPpsSgJOr
         MPiKEwB3mAKAyJSSk7HkSxM3z2PJFZ5BtTxaVZtnSGdBZbPhZnPsLTpFtLamh0EprjvD
         PNIAUWZYPzIp0W4b65dJZuMbOfXCh+O0i9KXDvhIEYQLHlXZksTCdEcNPgKKjVyqvcUz
         Z942y4PNY3yUSH34/wkN60UJcN32juWQXU1VyTIvLV5p7TtUA78eCBWjcEMx1ZWfTBRO
         XLiQ==
X-Gm-Message-State: AOJu0YylcGKxGqpCvOtgprCBsFmPM9uw3WDTB6rWut3dfvHRkchEL3Ln
	JoZzhxsR/NaXqgTFwMSAlSUFTm1cbPNrggOu4CUwc0jpvf3a4kvx4Gt4PTeRQg==
X-Gm-Gg: AeBDiety/vCpD64PuHXqx+qOSlSApLIQDdDvRmy9SLCU0+kbOL2ZmcLdVBPCFgOHcl8
	jmk7xPusp21UM17AnhrbJsf7WDM3cU6ahNREX5jhsLDqwId8d0y9PZXea0pJ+MDKXl6KMgaE5Mn
	7iA3fdklOqO6d+LP1SdxWlJ/vgY4PPsBqZ4cmLyqv/QlrWtmqfi6ctz+IqP3cmGf0x+NqGEyn2g
	avsiqS7OJ2EZeJnQQYh+FP1EfF2G7nCdooYZAGiWmDVmcNE9eXdhUt6cn1vb/LV9YZk8EYbFglU
	hjag9A1UpUOYBWNx1zzx4N95458zGjBjxzoJLYJsQeMphDypPbJVTwX4ETpgc4cSI4VsjfKKSok
	jdDRSaq5dIPJchM4ioFUZjMRrcSmpGKum8uVKSvDLWg323UwlxZQHFFqTLA/OVrLq7n/F7TZByo
	YDDNTCGh3LvEt+YBNthr7Tn3THLXxgQ5hEuF75GFk456qb5rusooMDsYLrSZWxeXQo/sAD/bGqN
	J6LEUn7ky6B8qk+
X-Received: by 2002:a05:600c:c4a7:b0:487:219e:42d with SMTP id 5b1f17b1804b1-48e51e22043mr3705325e9.11.1778002178805;
        Tue, 05 May 2026 10:29:38 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e51f766f4sm703785e9.3.2026.05.05.10.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:29:37 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	stefanha@redhat.com,
	Stafford Horne <shorne@gmail.com>
Subject: [PULL 0/2] OpenRISC board maintainer updates for 2026-05-05
Date: Tue,  5 May 2026 18:29:24 +0100
Message-ID: <20260505172926.2235826-1-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

Please consider for pull,

Note: I haven't done a PR for a while, please let me know if there are any
issues.

The following changes since commit 759c456b1d22fe4083c8b384da27d3f56fd53f82:

  Merge tag 'linux-user-next-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-04-27 12:57:33 -0400)

are available in the Git repository at:

  https://github.com/stffrdhrn/qemu.git tags/or1k-maint-20260505

for you to fetch changes up to 7d20f4ff1d0550ebcd918993ecf04733a353246b:

  MAINTAINERS: Add myself as the OpenRISC virt maintainer (2026-05-05 17:56:18 +0100)

----------------------------------------------------------------
OpenRISC board maintainer updates for 2026-05-05

----------------------------------------------------------------
Stafford Horne (2):
      MAINTAINERS: Add myself as maintainer for or1k-sim
      MAINTAINERS: Add myself as the OpenRISC virt maintainer

 MAINTAINERS | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

