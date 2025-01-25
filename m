Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EF714A62B;
	Sat, 25 Jan 2025 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737786584; cv=none; b=tLCdqpGr1x2lKLPV9H8cqFsfgYoCY2bbe2UJIDBgZo8qShCTpM30Ye3tHzOTLFo+A6m8II2pXH2jzBNj3kxgQettqgXqX7xMdM+oxn39lWA+vM6liATE8UJhVE6oye5cd5rHRW5IGfogy3M4p6XpLimMbEofK1Yf88HarIingvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737786584; c=relaxed/simple;
	bh=NMkdfTNxfmXc3OCZvWKJ39MC6mIYUVkH1umWVYP3s1g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=etjE8gXboJsjHLvs63p2DRnkcYFM/K/lmRHUca4Sp/5aI7qs+7By4h4snXNjVlGkoaown2qWG2ozrvL0qRTO9X1plVde0KKrv/4yYPfM3NaJ0StHY+jY2dH5UbRZzI/XPBeZPKhZ8OoKyhD9Qm53FAVLqW4rHA2hhSKrYFh7Izo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4Rh+GVR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4Rh+GVR"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361c705434so19642205e9.3;
        Fri, 24 Jan 2025 22:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737786581; x=1738391381; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gn977NUMlfulJuDpCYDgpEsxoWqesIPv/BfOt9/xqHU=;
        b=L4Rh+GVRnUgmomnqkzTisdfHK6LWSo7Nw5xi7dVFEgqed8f4QAZNrxTxLll9ty3+pq
         ZuEf+UJG87+VnYsccwr5o0Ue4yub10JZxF2GxuNCbE4WZ//wf4wznlPC5nfU8WGlgVMi
         i5E4S+9xv20ThPWt2zQykmW80Ltg0iujLIKeA64qsJ5cmZ+0ENpEOut3STi8T0MvSnBP
         w4oxCYS0VIN6wZvOQNQfqSr7cCn+yJmIC4hK3uFc/h7dFYsrmcrfsWtjt5IMXvEfNTWZ
         Gp5x6dX567fSYTLiCvvDlOiN0CsrGsSnBRlMGdGw+xxF6KqsahgowD4QiRKYfEFqmEN2
         y6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737786581; x=1738391381;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gn977NUMlfulJuDpCYDgpEsxoWqesIPv/BfOt9/xqHU=;
        b=vCjQr8yn2sj1N3x8n4o6nDli0fMJEWEIWORzjcIs7IRxwfnmbJbdKH8mzlCilPtZl2
         r26817402rRaCD3dA9iSlYMH5O4FvTdYR+AXqWmZxoFYBpbsn/2/TVkA33BAh4JJigRs
         yenRHw0UnKjSPkRnRO/pki3xKIVl7yz/462OCRUr4PtHQ52M07qGUjBSn8XYLW0T+30J
         JHFKx9Ky8aaF4qbT6C7xuyuPyyh1DUGu7xwcUavAe8rOy8zQbZj3MqR1aU8vWmBBkrdO
         TXRVs/euKxZmwtzEQghkER7Hs1XJxSodOFSCdIuxZQUFVM8PSKUlOagahXzfugO/d+eQ
         6ocQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvzU7aRQR3XiAvvrinyLskGJ77zUabL8z/bvPlvyVq1Yb8qMd8OyW8fFbRxOJPqsN5MDan6EjRGzIoeKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2uTW9BSJQTupYMCSdp/LmD/ywSVLW4RVBllerbEFPhLhYTZ12
	9d0tJ7cfWhoixZZTAgPMuhlXpVSsLaelMnwUcHpBZkWfUcoptlzDbHuJAF18
X-Gm-Gg: ASbGncsaGHO66w5Um5CUuRQoMWE6BzDBHyVNXmUJwSTZVhNRVA9YwLjmOntFmtbolhN
	CmoY7kXQdMWOsv6BrbPd6q/Y68OLGxoFK5S/iQ7RdmeR5BIPcAQMTibOlismeBXsPPCz29ddXuQ
	bqcsIh5IyYtJbNi/ULOVzcJ26N2HQ7MGXhAGz8qlolFKtMbxKZrdTkYispkTMjP6FwidcZX2H0T
	GWhbjJV9xOlZDT9VxIxVS54BjeylDUnq/kexWxb6mn8s16bFc2AG4lf3J5RAmkgv6jrkq1Eo56N
	9vsT9eZBR1bbFuJ2yghAtruDlzpdXwQTHO8JBXjagkv5
X-Google-Smtp-Source: AGHT+IH3DRuEA8yt1Fa5PGgD9dTztA+tMitH+w2+eHSFYz+Jf9A8hJovXT1+fW6MK2EKqXOegw1ZXQ==
X-Received: by 2002:a05:600c:3114:b0:436:1aa6:b8ee with SMTP id 5b1f17b1804b1-438913bfe72mr321932055e9.2.1737786580821;
        Fri, 24 Jan 2025 22:29:40 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4d3393sm49753285e9.37.2025.01.24.22.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 22:29:39 -0800 (PST)
Date: Sat, 25 Jan 2025 06:29:37 +0000
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC updates for 6.14
Message-ID: <Z5SE0Ybg7afKcihs@antec>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,

Please consider for pull,

The following changes since commit fc033cf25e612e840e545f8d5ad2edd6ba613ed5:

  Linux 6.13-rc5 (2024-12-29 13:15:45 -0800)

are available in the Git repository at:

  https://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to ea1413e5b53a8dd4fa7675edb23cdf828bbdce1e:

  rseq/selftests: Add support for OpenRISC (2025-01-14 17:17:16 +0000)

----------------------------------------------------------------
OpenRISC updates for 6.14

A few updates from me and the community:

 * Added support for restartable sequences
 * Migration to Generic built-in DTB from Masahiro Yamada

----------------------------------------------------------------
Masahiro Yamada (1):
      openrisc: migrate to the generic rule for built-in DTB

Michael Jeanson (1):
      openrisc: Add HAVE_REGS_AND_STACK_ACCESS_API support

Stafford Horne (2):
      openrisc: Add support for restartable sequences
      rseq/selftests: Add support for OpenRISC

 arch/openrisc/Kbuild                               |   1 -
 arch/openrisc/Kconfig                              |   5 +-
 arch/openrisc/boot/dts/Makefile                    |   2 +-
 arch/openrisc/configs/or1klitex_defconfig          |   2 +-
 arch/openrisc/configs/or1ksim_defconfig            |   2 +-
 arch/openrisc/configs/simple_smp_defconfig         |   2 +-
 arch/openrisc/include/asm/ptrace.h                 |  73 +++-
 arch/openrisc/kernel/entry.S                       |   4 +
 arch/openrisc/kernel/ptrace.c                      |  96 +++++
 arch/openrisc/kernel/signal.c                      |   2 +
 tools/testing/selftests/rseq/param_test.c          |  24 ++
 tools/testing/selftests/rseq/rseq-or1k-bits.h      | 412 +++++++++++++++++++++
 .../selftests/rseq/rseq-or1k-thread-pointer.h      |  13 +
 tools/testing/selftests/rseq/rseq-or1k.h           | 181 +++++++++
 tools/testing/selftests/rseq/rseq-thread-pointer.h |   2 +
 tools/testing/selftests/rseq/rseq.h                |   2 +
 16 files changed, 816 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-or1k-bits.h
 create mode 100644 tools/testing/selftests/rseq/rseq-or1k-thread-pointer.h
 create mode 100644 tools/testing/selftests/rseq/rseq-or1k.h
