Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891DC227EB9
	for <linux-openrisc@vger.kernel.org>; Wed, 11 Feb 2026 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770798517; cv=none; b=ota1D5/z8tKmjsZWkx0HPvk94R60sze56Z1DH8lrpxR/izsvxiehikjnfV1twCBQ9+bI/plkEjGiBxgUmF4JNLBl6wFUEgJXYlqJ2ktB3LU/zY+0795Tf1uSCvhzd/1WGrfLmQXvBTYU/tTPbKcM2MTPTgdV69LFLAApQwBOnVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770798517; c=relaxed/simple;
	bh=Ak1YujHq9kFYaR7TmMgiEZBtZ/CiAId6y8MnYEZw9Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p2OEDlM0Hml71gG6LO/KZhFPXhbL1o5Tf/ImN/OTVFazFj/VvfToL29jdvZgcy6NspaX97SUo6cNth7AK2K0aFm93M++JZMga3Z1ZLbYO3ZoLSbeF3xUEOFScRPl4WCUAON7wtd3/iyKj2VU9c+GBwJS5mVGPpL64KG6FDQ+hHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtecvNVb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtecvNVb"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4376de3f128so2024168f8f.0
        for <linux-openrisc@vger.kernel.org>; Wed, 11 Feb 2026 00:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770798513; x=1771403313; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0pu7i52Btkb7oUqPMLtups+y6usK4kMsNyCTAZ2BkKk=;
        b=GtecvNVblf1ixWZ7jQvnTu9nnGp8B58gP7VXSt7RISYL75/KWuH6FwP5i3Xg9n4nSw
         Ss/L+SwAwdpp4iMM4aEOnt0ayIM0fAkqX9Nbxu8unCaV1vp/lz9a8aHPWRyfaCY0kbU2
         UhXw5YKOf0C5vjb1/FF1KR0Ws7Pnuxp8QQmBElFtrDSk2jTVqd2l42LzsYs9RFgLQIJL
         SyQHr8TXLmo3H1/Q5vDMN5u8dTFrOb/E78FaFR37tGPR5W5MgZt7Trj1fqlMVbHmLrjv
         wRZj1cjuuIWAXMAzg7fv65NP/uSmOZQD5EmaF6le97dkLCs4XxGD7Jh+O1VFGz4Mq1mF
         AyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770798513; x=1771403313;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pu7i52Btkb7oUqPMLtups+y6usK4kMsNyCTAZ2BkKk=;
        b=Y3pWW/tF3SWmV+f4em8OqYPnkJinOBL9MWLWEb+0lFUoYLvz4wX7P7yZGtuMksq/11
         DLh9AdrEiaGSdazWWIEDU3L2KtmVMR7VM81JRbl7oyHgyanogCJmjsmXCIJiKc+Ueu26
         3/1L6l22RC5iqarem9i5xiAIlAN8ASlEyvLTAs24hYSG+bsNJ5o2RIASkVyK0DEnXNq8
         4SX2fJtwg5/0veLMQfyjCQECBCvnpqQAFdOux4N2fEOV4OP9MeX/2MuYTF2/1nXYQWIr
         UnDY/NBBxMH2AdK0Is/ZKyxZeODoxP/WqDqj8jW0J3XhjkyS3IITDXiZcVJgFt392rz6
         Nr5w==
X-Gm-Message-State: AOJu0YyeTKxH18uBkb79HDuv3Jj+Q8jDZa7vl2ATS5/uiSo1RVIKlg8z
	i90mATqmSpikp4zdmG7udkYMVsLsNLk+eeO8RdCzhhUFJfxbRNZtBdJ8s7znFw==
X-Gm-Gg: AZuq6aLFLT+BIBAmodpKX+RO3Z1S2plWovxlsla3PcLZKjaNTXdMhYOFG9D31OAu5ZQ
	MrECLBk+KNs/z4XkXBm1MQJs1tHwAutkwCYWvF7u2G+dbhkeyCM7x1jpFhn5IIv8c84/IDhO2i6
	Szcj2jKOdOqYqQDmoSi4lhgVwkdJulaaytL8l6laeYr4JXjWKrTUnL5IN3nGYoQX3aCjorK9V0d
	H9UqXm2HpIia10Fqe8Dh0EBVdB6U/J3jckD2osBmLlrQ0YnuniSUh/thAgkYR0n4xocfKXP1deu
	V/9l0PpHNXw/0Nb5nL6IukE+iBKZMtZJoKs/48ocT1mF0Ju0MwZF68/IT/gGqSywfDkxeNLg9kj
	brb1wa8C8i5kphPVLBzIgvnutGb6MhT5lYzgKUx0gMDRfHEFvyoUwz67lT9gOk6La+t8d29ahyl
	ejnp/bYULJki6Tx+0/ia7XjbR46uJ77LN3FxHSjwejmGSSMz62dojvepwo8QefrKQZ98xaimiIZ
	xJk
X-Received: by 2002:a05:6000:3110:b0:436:307c:b753 with SMTP id ffacd0b85a97d-43782cc05fdmr2704323f8f.61.1770798512485;
        Wed, 11 Feb 2026 00:28:32 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e544e2sm3314579f8f.32.2026.02.11.00.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 00:28:31 -0800 (PST)
Date: Wed, 11 Feb 2026 08:28:31 +0000
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC updates for 6.20
Message-ID: <aYw9r7h2ej3BUTMH@antec>
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

The following changes since commit 0f61b1860cc3f52aef9036d7235ed1f017632193:

  Linux 6.19-rc5 (2026-01-11 17:03:14 -1000)

are available in the Git repository at:

  https://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 0dfffa5479d6260d04d021f69203b1926f73d889:

  openrisc: define arch-specific version of nop() (2026-01-20 19:24:05 +0000)

----------------------------------------------------------------
OpenRISC updates for 6.20

The main focus for this series has been to improve OpenRISC
kernel out-of-the-box support for FPGA dev boards.

 - Adds device tree configurations for De0 Nano single and
   multicore configurations.
 - Fixes bug in OpenRISC SMP preventing the kernel from running on FPGA
   boards, due to IPIs not being unmasked on secondary CPUs in some
   configurations.
 - Picked up a fix from Brian Masney defining the nop() macro to fix
   build failures on OpenRISC for drivers using the nop() macro.

----------------------------------------------------------------
Brian Masney (1):
      openrisc: define arch-specific version of nop()

Stafford Horne (4):
      openrisc: dts: Add de0 nano config and devicetree
      openrisc: Fix IPIs on simple multicore systems
      openrisc: dts: Split simple smp dts to dts and dtsi
      openrisc: dts: Add de0 nano multicore config and devicetree

 arch/openrisc/boot/dts/de0-nano-common.dtsi        | 42 ++++++++++
 arch/openrisc/boot/dts/de0-nano-multicore.dts      | 25 ++++++
 arch/openrisc/boot/dts/de0-nano.dts                | 54 +++++++++++++
 arch/openrisc/boot/dts/simple-smp.dts              | 25 ++++++
 .../boot/dts/{simple_smp.dts => simple-smp.dtsi}   | 11 ++-
 arch/openrisc/configs/de0_nano_defconfig           | 79 +++++++++++++++++++
 arch/openrisc/configs/de0_nano_multicore_defconfig | 92 ++++++++++++++++++++++
 arch/openrisc/configs/simple_smp_defconfig         |  2 +-
 arch/openrisc/include/asm/barrier.h                |  2 +
 arch/openrisc/include/asm/smp.h                    |  3 +-
 arch/openrisc/kernel/smp.c                         | 22 +++++-
 drivers/irqchip/irq-ompic.c                        | 15 +++-
 drivers/irqchip/irq-or1k-pic.c                     | 27 ++++++-
 13 files changed, 385 insertions(+), 14 deletions(-)
 create mode 100644 arch/openrisc/boot/dts/de0-nano-common.dtsi
 create mode 100644 arch/openrisc/boot/dts/de0-nano-multicore.dts
 create mode 100644 arch/openrisc/boot/dts/de0-nano.dts
 create mode 100644 arch/openrisc/boot/dts/simple-smp.dts
 rename arch/openrisc/boot/dts/{simple_smp.dts => simple-smp.dtsi} (90%)
 create mode 100644 arch/openrisc/configs/de0_nano_defconfig
 create mode 100644 arch/openrisc/configs/de0_nano_multicore_defconfig
