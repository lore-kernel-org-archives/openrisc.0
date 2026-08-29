Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEAA34A3C9
	for <linux-openrisc@vger.kernel.org>; Sat, 29 Aug 2026 06:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787985630; cv=none; b=hoqj42oFEwaZcBZV6p+LJcS2KEYY6WOb5/L7/eo6pkS24bl+Ygt/NzloNTUsUt6csIVtiQiARrQXfB5EZmNzCr0YMUafa33oMM4rsFNSQMvP0AvEpOrfwX0YwBNnuBi7xzH5uBrMzOsrK4F5C7hxpBfvufl7YUGsvgyOXwd6oS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787985630; c=relaxed/simple;
	bh=Sseqr9v2u+9IdH1ncKFIbfqzrLnecsZu0AT53ZZPrpY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cvau7Hywq3MLsEV046+kw9MvbpsemEhymozkptgLgqzdZJJqgwQxQNtcqGogXiRb+608rCVsdXDzpALUty+fNgL/pN9yPGI4WB9C9ua7a9QJ7zSBkB0qbY1Ra2Ntpq3AIR8p9q869GHb495P7xMAN+VXQvQu4mkbxvuvx/IwzDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNBTOLFE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNBTOLFE"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-482e4998d28so1177708f8f.2
        for <linux-openrisc@vger.kernel.org>; Fri, 28 Aug 2026 23:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787985627; x=1788590427; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7DWtTAQIr3GS9yNff27bhqyvWbMb6qON5ieBsdlpRi8=;
        b=LNBTOLFEbiwrsvcDZDDskP24HzHsQqRF+6dC15Ly8gIOnen95xVLjtVzO7RLuRaNji
         jE+esUyT3qlDyefgbN/4GMlR65ERoYeYxbUN1GdPWO/9iTqYsJazXGHw1rfDEhfcsbpY
         L3CreqWr9S1uu5S+NiF42jS/hdxgltbVOMpaLIlhImS4+e13s3Pm0ZN9B1AyKLbwUD9a
         5GKkK4ibhd9QbMt/lN66esjdIZCWOq8wCDwlfn83gaQJMVZCDlrUpDuauYlXqu9tbUoj
         KC+5m5mtUSFxMTotJAN2jMpGkN1w8MViYc7UezXTN9ycWTpNCKMhkqIiQNSDTPUVNQqX
         JHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787985627; x=1788590427;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7DWtTAQIr3GS9yNff27bhqyvWbMb6qON5ieBsdlpRi8=;
        b=AYqD23IgQxbTlYYkwfmelQEpHJPUJiu/x2DTaQLq69FCU+pv9S6YI6B1SIXqTx6IOr
         xTDrT1rmlMtKGYELJABJ5IBfpllql//mID8Cm70KXQDPmQjhvj7RCxFAwDFW9gd88scS
         d11ymb27blfbQ7rdEQRPALTeyqmNk5pvV8FotzYi4pGoWqXvUzcYJRKQfIp2WBYquC1x
         GAK6ZqiREU+MImnqlvnbYneb2xCkbSLr0Fokx7IItnuCTFkNcr9TFLI/PjmuydxcbzHC
         LQJM2JdzWgmfG05VOJoDVwkyHXf3ergPQZyD6Yd+wVJTv96gfV07xpRTzqmdIR3rIKHO
         ElaA==
X-Gm-Message-State: AFuF++lBOWzSwBqk7iiA2ReYHuhk0EBkjagFj3/T9FwiUQtGdWYaVHz1
	VnbMjsPg+BVL+zfM2m2KZliGsXgOQ/XrPvZEl3fP68bhKaU/vHPDAVvNDIVkpA==
X-Gm-Gg: AR+sD120HHDj0SR2ReToYusY13bHKCFrMZgoLVr5Qaq1qI2w0IO7+V0/qxumIz0j8DX
	KEI7Xqrd7KXQHCMefcT4OLtF8AEP4Gml3ke04O07sc306kP+Sa0iFYzgbElhZDhQ3gnGpxP5fQr
	GakplEZstWczO9E74wI6iLgG+zMbhktq5wy4RSc+hNXgPw3J7grYI0XTyyO3J51lA4Qvc2QOMrM
	c9Q/IRJ3ziz2eZFiJrWj7/MWFwT/nIhHgOhQnz++mk01t8gguZSyiNvWdR4ApwGPPsudLjWSRvT
	sdq6dQ2jL93Wkl7JLhg97+k4qKS8JX6QOXyp8RWabdZDRaW4gL/6jCdzj3xvTIEISM6BWc4W4D6
	W+YrLwejYFacGRwmGt0p0kS0/nIVjoYe7+g6C5S3W95ADgKuYTwRCHDp36iKiG8hwxwF7lQnNgK
	f4AsFx9sei9Z6DkzzojGuoLQgiKNw1qlJq2EzE7L+7uEKfu/dsb54GjY+bwRFiWhhvMSGORV2p/
	k7MktnfPhjI4Dbms8JNpYKJsAtp9wspY4WT/OaKltU=
X-Received: by 2002:a05:600c:c170:b0:499:afe2:e4d0 with SMTP id 5b1f17b1804b1-49b91c2930dmr196281065e9.8.1787985626920;
        Fri, 28 Aug 2026 23:40:26 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b94dc103dsm99954485e9.1.2026.08.28.23.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 23:40:26 -0700 (PDT)
Date: Sat, 29 Aug 2026 07:40:25 +0100
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC 7.3 updates
Message-ID: <apJ-2fH66_goKXF0@antec>
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

The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:

  Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)

are available in the Git repository at:

  https://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 78004e9a87f240df03e2f73120d291763c32e0a7:

  openrisc: fix arbitrary kernel memory access via or1k_atomic syscall (2026-08-29 07:32:26 +0100)

----------------------------------------------------------------
OpenRISC 7.3 updates

One small item and one bug fix.

 * The bug fix is to fix an unchecked access in our or1k_atomic syscall,
   I am debating if we should just deprecate this as there is minimal
   need for it.

----------------------------------------------------------------
Ali Ahmet Memis (1):
      openrisc: fix arbitrary kernel memory access via or1k_atomic syscall

Julia Lawall (1):
      openrisc: drop unneeded semicolon

 arch/openrisc/kernel/entry.S | 43 +++++++++++++++++++++++++++++++++++++++----
 arch/openrisc/mm/tlb.c       |  4 ++--
 2 files changed, 41 insertions(+), 6 deletions(-)
