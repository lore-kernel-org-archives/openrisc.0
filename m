Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5872701A7;
	Sat, 26 Apr 2025 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745649051; cv=none; b=gksG7uppTNpDo5qEvRkkVa5navtHDVPu12RF3zBRfiMZVEaP0ZQtJt+cW0FYg4eJ18eawlY6NVj9kVgSyNS0U40oEaRvFIaEJ1SSE7+dpiErLtYlfRcoo8ea/CdeO2tQaOGGjG1Z+3KgFqIeAp9owFQEe3Bg/z69sFIJJWJozeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745649051; c=relaxed/simple;
	bh=AmmIhKeVFwOSm0clzj00KCj537CkKBODcUaNbhSL8dg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mc4tD0ZTRR0qLBu0Wqw1BF1eoyHdZ2SrRvc1EplJpGMXRMSgfWXlzooe5FLNzlvhvKpTtFmlXPuvyBf0rbGdZgMdtJUU3mmVAgiYx+bYqsoVGhMITTYoWUTeV5Kzfa8c58F/Vwz5MLm4i3yn3IRfGWfizqzKSsCxzU0eqVVsFKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3OgP116; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3OgP116"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso3372493f8f.0;
        Fri, 25 Apr 2025 23:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745649048; x=1746253848; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlmtQ07EJPScNFMpyC+UL1KgQsfIYoLnFSdUrIsQ9pw=;
        b=e3OgP116ji9tWr28fq7w6DVFxebSLHjYdMMWUJDlj2AhKPZyw8R4/e3E45myY/5pMC
         QJc/Y6nHYc1PnV9Sqtfv++Qm4Crl1UgKQeeE8G7u99Hy/knYhIU36+QQTU6Lyi0joC8V
         c4EUpBQ7LYnIgivZtKnzVIfdG5oTWknuOC1gaQeTf5uKWiQYlTz9pNOIfxvkgcaXiLzB
         aTJHmlXuNrBkbhYHeO7Ld81/M2Ee57kTeYMbLIe4x7WlYFPCX7/J8OYlhN1xHqk21Ew+
         KE+poCcjdq0ckaOG8AcMhvwB1F9RvgN6qMdaXtcazoC/CDmshpA75cvvZLZR9Dqurd0w
         GtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745649048; x=1746253848;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlmtQ07EJPScNFMpyC+UL1KgQsfIYoLnFSdUrIsQ9pw=;
        b=GHTHSZVe73FVkvpMQSdH/uRZxmmuh/VFv8MI9/tEIQvpzI3yCoYGYmHT3GrQK+HDVd
         RwdMHw9MtmyjOezwp4oGXbvzqdHMohwDMyI/f9OJ9NpNZmaWPQS9NDYzJlN903iI5XSl
         qbI7U3l29mn2kyZfakSUoUnnMT1+O0+W4MWd2ZipsWp8CN9E/v0okuCmPuhsAzvxBvFj
         9pxxvfKgxxOnafZoMUIHKxJDihcCK0HxE+lEUuxqoiwVJMGg8ujRQZvquvFAOs4+jiyZ
         a2/RdTmlu7ZdOCQwRVqbi9gztAfW67102IGfH/kCzPn9K9zDq1w9OpNSg3bz180kK3Cc
         IhNw==
X-Forwarded-Encrypted: i=1; AJvYcCUCTuDVAvU5NItD0SAD1om4GkCpgNe+9y0r3yZ8ZtYtVb5+kliQR8lS4voIthskf5PoSvOADNjA5g78yeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNvZvW8a+biVeQbQqw5+K3tPXFNI3h5vKVPdXZGTbOt/kxLZbM
	SsCy28vbOkYngit6uqPjA0cWSfhMuapTjUf8Wapc5A3fqUtnCD7QjhnYHg==
X-Gm-Gg: ASbGnct2CRhqTjXyaWguxSC31ViGFUarfbb0mSh5O5X/DSJauOL44NyhGblXb5T4p+q
	D4di+xK0+yBCQqYKq5PNpaj05J4GInZaW7l1/Y5NZh6UBUDfLyyqo0gESbvjZzm8ls4I5YsSkod
	noTaKovISyOyvqVXIjkra+biUxS74H9rXz8cUiGKXZkGGHUjoYpHbwcX19IQ2LymEBjm4RdAFsD
	5Fv5h7aSjDJBkIcSc0ZMa0lt6Gd9M2VcZcEMo2hHO5ACbDSn9pWdsmNAlG/qtCPcS+Y8YJBjKHr
	75MS0JBz73YcO2Upqmka2TqR30KfeNDVCp+hQnzLc+PWwgCogLuw0sBuFmNZyzx5azhgBjeww1O
	mwxY7
X-Google-Smtp-Source: AGHT+IFgQ0MhY3r9zgNJb+7EP48dS4QLAc+080zOXPC3a76pmyclQa8/d2gv7EplNHBQFjG7R1lzSQ==
X-Received: by 2002:a05:6000:40ce:b0:3a0:6c62:8169 with SMTP id ffacd0b85a97d-3a074e2fd14mr3860135f8f.25.1745649047914;
        Fri, 25 Apr 2025 23:30:47 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5d479sm4555619f8f.92.2025.04.25.23.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 23:30:47 -0700 (PDT)
Date: Sat, 26 Apr 2025 07:30:45 +0100
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC updates for 6.15
Message-ID: <aAx9lbfe28qzOpf_@antec>
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

The following changes since commit 38fec10eb60d687e30c8c6b5420d86e8149f7557:

  Linux 6.14 (2025-03-24 07:02:41 -0700)

are available in the Git repository at:

  https://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 66ffd2f3161124f2f5019b55d8ef3add26a002a5:

  Documentation: openrisc: Update toolchain binaries URL (2025-04-20 07:07:23 +0100)

----------------------------------------------------------------
OpenRISC updates for 6.15

This is a bit late as I was on holiday, but as there are no huge
structural changes I hope it's OK to include mid release cycle.

 - Support for cacheinfo API to expose OpenRISC cache info via sysfs,
   this also translated to some cleanups to OpenRISC cache flush and
   invalidate API's
 - Documentation updates for new mailing list and toolchain binaries

----------------------------------------------------------------
Sahil Siddiq (3):
      openrisc: Refactor struct cpuinfo_or1k to reduce duplication
      openrisc: Introduce new utility functions to flush and invalidate caches
      openrisc: Add cacheinfo support

Stafford Horne (2):
      Documentation: openrisc: Update mailing list
      Documentation: openrisc: Update toolchain binaries URL

 Documentation/arch/openrisc/openrisc_port.rst      |  12 +--
 .../zh_CN/arch/openrisc/openrisc_port.rst          |  12 +--
 .../zh_TW/arch/openrisc/openrisc_port.rst          |  12 +--
 arch/openrisc/include/asm/cacheflush.h             |  17 ++++
 arch/openrisc/include/asm/cpuinfo.h                |  24 +++--
 arch/openrisc/kernel/Makefile                      |   2 +-
 arch/openrisc/kernel/cacheinfo.c                   | 104 +++++++++++++++++++++
 arch/openrisc/kernel/dma.c                         |  18 +---
 arch/openrisc/kernel/setup.c                       |  45 +--------
 arch/openrisc/mm/cache.c                           |  56 +++++++++--
 arch/openrisc/mm/init.c                            |   5 +-
 11 files changed, 214 insertions(+), 93 deletions(-)
 create mode 100644 arch/openrisc/kernel/cacheinfo.c
