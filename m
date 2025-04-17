Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC55223323;
	Thu, 17 Apr 2025 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876970; cv=none; b=FyMumVxx6l4a4BPIYFTmqLOos3nY6pow2SN+WTzJCifHg930xr0+9YOLj0v0uMux60IZ7YkzXCQOifR0qYdkTiND+O3VPMHDbvpgHj8MHW9mHTtwm4PCylCw8zde+4OlqP1JvtlAGjwVrJitqzydjkexzP0rffN1ea2iBGdpSiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876970; c=relaxed/simple;
	bh=wiPWrUhGj00o1lWQzH91MZMqqRNzqRZfWVe0JK/I1Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLv051+GcxLRwaBuEy7+CQTGGUIgdzH93cPDIMuL4UlcW1whXEH/th5eCnAQxvusno1IevkNG3TQacrZG1oUHcjuqMiE1UbKdi1wCPulypOZ0VEu8Pl7mWM0C1JHzzP2oQEYY39CVNEAJiAEhWYZSJ1O4kTyrcsigYJaxbxEQFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PurnAwqO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PurnAwqO"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so3160595e9.0;
        Thu, 17 Apr 2025 01:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744876966; x=1745481766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B3jRal4Jn7vaNumBAt7rfXcFuMG2Mrpl8kHbOKtDn3g=;
        b=PurnAwqOgWAWxNFANfgZpKs4h9MY/m4avljyP6nWhh34kThBKqFQLP8VP/ch0RduBF
         KX91dZy9hckhbZ0+jxuVjjR8PMIg9jYdLYrdDBeSMg5JYUfuM9AGeLxix4kHWNqkgpYd
         S7Dq/WaxEEa0TDvF14E2brN20xh0v2oYcn4EbmsG4RUKXC5HFH7d7+mAcvYxBVVvqCyD
         qNhkwlAENKIkILrl6s5QAfvxmbj5BpBymNEUuwZzYwCr35934uDeijrWWiwaVBCyOcEv
         ODwyi7iqcE/KNR4LkEX6H12XdNfsyLSEu9NMljnyyIAZp5n17xmCyCEMLJEPrDCSGto6
         969A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744876966; x=1745481766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3jRal4Jn7vaNumBAt7rfXcFuMG2Mrpl8kHbOKtDn3g=;
        b=mEPdA1IaLivibCJntSlJaH6xaG6XH8lPMCVHUeJzG9Bo2hxz0kpItInObEvMKpcM0o
         srKnBFOklBpKX+4JO/KG7+2mRcoPDcbm8OQ3dBCosR/Uty+bQR48bkltXsm5Ed35bCZR
         RNGcmZb9IevW1NeJD7chw7dW3DWWFIEHO9N9AGjmUDzIwW2xrXRrHb+lTUXRG4UhIOtk
         W3c5rha++BYR9Sb8IXC5pa2Ek/pQEWBbInhkVn0nd9Ps/16d+cZlRDZiROwPCYpBGepq
         vOHSxq4MAk2mINwHmMR+0RLuozSgQ3BoDgg8DmiNnZ88uKBU9HO7UWTBbLtR1stOBlKU
         wu5g==
X-Gm-Message-State: AOJu0YzRkH24Dv1pyAbkqXSfQ6R1LRNEG0NTGNMeJst83Fr1h8vs28jE
	kZ/wmeMi5tNQX/htrXwPGB6ZKEFLIMBFzVW00p5oc1x3uI0wk8sfB6adpQ==
X-Gm-Gg: ASbGnctIBum8lZfCNDISerhdCeo2V+Wa1JDkEVz0+rftxQgYjLjbFug392USCrdQjxE
	Pw+ibeQ6WK5lUCnmjQKqZh4kd/JuJ/KkzKQRVXVxc1j+Myl3bZnzCdWx9dGrEEcwuJGrpORu8k/
	DzL3yhU6cWu1wJxcC9HzL7GHGmxrhdQfNOKy192J0rx6sMkslIFrlB7DP4jH9HlNx5UPv4ffkgT
	IMWQnoDv30fL+ePc15A2uNOpj5gMCZzMdyloYiM2g049Xc3gqyID9JOk3Pbw4bk+dizaekR7BQF
	tvayY7Jx2oyUMUEMFp8pj2YfaaE4gMEtdYEunf+eSR756Z8zywOaGO3iYrs0Cyfh947EP5/j2f8
	tVNQ/
X-Google-Smtp-Source: AGHT+IH5OKa5afzPi32/16/OV2y6Ec4xor63cnp26lhNOVp1/F7kmjRKREcEYTwkZY1Dq496mdbCag==
X-Received: by 2002:a5d:47af:0:b0:38d:de45:bf98 with SMTP id ffacd0b85a97d-39ee5b13061mr3776453f8f.8.1744876966458;
        Thu, 17 Apr 2025 01:02:46 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405f583bcesm32200525e9.3.2025.04.17.01.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 01:02:45 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH 0/2] OpenRISC documentation updates
Date: Thu, 17 Apr 2025 09:02:30 +0100
Message-ID: <20250417080236.4021257-1-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update OpenRISC docs to point to the correct mailing list and
a new toolchain release page.

Note for others, the https://openrisc.io/software page was also updated
to point to bootlin toolchains which are created to the buildroot team.

Stafford Horne (2):
  Documentation: openrisc: Update mailing list
  Documentation: openrisc: Update toolchain binaries URL

 Documentation/arch/openrisc/openrisc_port.rst        | 12 ++++++------
 .../zh_CN/arch/openrisc/openrisc_port.rst            | 12 ++++++------
 .../zh_TW/arch/openrisc/openrisc_port.rst            | 12 ++++++------
 3 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.47.0

