Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712F425B08E
	for <linux-openrisc@vger.kernel.org>; Sat, 20 Jun 2026 06:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781935698; cv=none; b=VjVa/4zzL2Ya7EVSSFmokMbX+cQ4YlDWy2FH0L3WYD/FQkzumQQ9rpyyRvS5iMDueiK++6QZqprkRwvb8T8OpAJFiFgHLtyWLNBsWA6lsXXdAF+UlMuUfUAZVNvrMovl9XxS7grm0WkEqILL4RTeg9gofBM9L2KTy2EkgEwST6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781935698; c=relaxed/simple;
	bh=ZVPVwIfKksOvosJ1evCJa7ljpfK31kaKF80PclCmTpU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W3jiEtg8jriKnH/Ac9e8LmAfoASlg9/26E9YU1sB2NzcRaOp3HUAMcTl8tiGopRQPtoDjP8vszKYpWiNTuifkzeZTmWFukCTCnPK3ja3CdOs5EDAkvIU7GRXxT7rhfEwNqsgdsbla1tbRBljwS5DW/2AULp8iuxqJT8QRenvmwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG/QwgT3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG/QwgT3"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so21704845e9.0
        for <linux-openrisc@vger.kernel.org>; Fri, 19 Jun 2026 23:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781935694; x=1782540494; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ordXgc9nJRpLSeLkwWhZb/qzIyRmr4ECwc5iFQ8iUW8=;
        b=OG/QwgT3KgKUizU78+FX+KfMD4ylUCAKNUBs9QBR4LJWLAafanS3ErNX/T4Xv5a+o8
         c4SqPJsKKWa54zhlZ7RkJoKIMUSXAmhzCVPAGvtdvtj74VoiThFX2rkvzTUPZu3+Rc7p
         7T64Y4k2m9xK8Qyiph7PUTTJnxa3ywtaqqBhW3HD5jqWz4Gi8MSLc6FAu07klXKlX9s/
         Yt9QGy+3OBYtrJz+xrOrmGplyUE+RNZl6TCVk/SNlIMeunUhdTb7GZNGxatdi7hQke/B
         Q4nakX2Afo9gAEqrChzp9f0Lthakg4MYQU++sK8cR8IpZZtWTDw1npDJGeStx/w2eOR8
         WTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781935694; x=1782540494;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ordXgc9nJRpLSeLkwWhZb/qzIyRmr4ECwc5iFQ8iUW8=;
        b=HUzdwdh4PgfsZPGXvNZuPKg30bMhTDLZuWRhCaqp1UIiz3gFXTkMNjrbyHrwC8RZRV
         40CvRmzQ4LEYzl4ishgx+wYy7BEcAIEH0FAyt9nuVdkF5C1NXJXu0DGTIM4G3gGOAypV
         ItzNVSy3PNQrdPqnsDilFb8v6015zBz/UcVnt5ruFpipX48a5ZTiWJ9ZdF62Vna5sLxl
         v6RyJPC95la6WsD6/RV7nmE4rzbpHwM5resQ5MJamTB3LUeiduZMvMU/+rLQs6e+tmoc
         TWM0EOry09ew3rzRv7InBN0xu8O0EvIJyZBfBxpvmw8BN1uFKg/QVzM5VSh/eE9rl08U
         i5lg==
X-Gm-Message-State: AOJu0YyA/vJgSzJYznG4LHOehSOZA4xgwjE1DJHrl0IiE2Tcewt/+YKo
	lMt3ON+LhYFKRSlxMD79U+NqFgeV8ydIEk0G7WdX5oIDJt4FcXfv8kiY
X-Gm-Gg: AfdE7ckXXnyfbcGdr5LcCX/niOyd/021qzdHnc0ZK2wmo4SLjR0rXKotSCLv+6vulo9
	P6sTPpE9E0pSsZMwtLo3HubyODVhhS0GPILGUSowJnnYDlEmyVEd/kBCR6iYFia/wIa1C2imUqz
	CzerWsgGQKAmKVDDovde8pgRLpaYZ22sbWYqYe83O4HNBTPiF46UuGWQAkCSt7LWfsaEBi5HnKO
	T1Z7BL1ze2sw+P0dZS6i8bdx4Mqi3JGZv5eY+B5SwJZDd35T3SUhV1NDMlDJV37Cbupppou6RGR
	C68K/gb5/Knck1gF/rxDSSYD2uqTZ7Sjz7nbV1cTQ8uBjTakCL6C20MxKN5RvnMMjf5BLBanseH
	UC8QuaVqhrTewcQhAauwCYjd5A+RNRTfHJFpyp+NdE1EhUJ+Q7lWsQovlkjFex56IGeeHQ16/bE
	mnaH5daXJ+j4WR3xozi3K5twOKquxX46QcHOF8G2IxIv8oaRJkbjvjHGIF/PDGK2LPIaChwW6jR
	nJiUg==
X-Received: by 2002:a05:600c:4fd0:b0:492:4986:24e with SMTP id 5b1f17b1804b1-4924986054bmr22525905e9.21.1781935693608;
        Fri, 19 Jun 2026 23:08:13 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1fa34sm133654435e9.5.2026.06.19.23.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 23:08:12 -0700 (PDT)
Date: Sat, 20 Jun 2026 07:08:12 +0100
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC updates for 7.2
Message-ID: <ajYuTOzdrCbV8NM3@antec>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,

I just noticed, this series was done on top of a random merge during v7.0.
Please let me know if you would like to rebase on 7.1 etc, but I think it will
not change much, it's been in next for a while.

Please consider for pull,

The following changes since commit d79526b89571ae447c1a5cfd3d627efa07098348:

  Merge tag 'spi-fix-v7.0-merge-window' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi (2026-02-20 17:14:36 -0800)

are available in the Git repository at:

  https://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to aca063c9024522e4e5b9a9d1927433f6a01785a3:

  openrisc: Fix jump_label smp syncing (2026-05-23 06:34:49 +0100)

----------------------------------------------------------------
OpenRISC updates for 7.2

A few fixes for text patching related code:

 * Update the section of map_page used in text patching.  It was
   left with __init when text patching was introduced to OpenRISC.
 * Add fix to invalidate remote SMP core i-caches after text is patched.

----------------------------------------------------------------
Stafford Horne (4):
      openrisc: mm: Fix section mismatch between map_page and __set_fixmap
      openrisc: Cache invalidation cleanup
      openrisc: Add full instruction cache invalidate functions
      openrisc: Fix jump_label smp syncing

 arch/openrisc/include/asm/cacheflush.h |  4 ++++
 arch/openrisc/kernel/head.S            | 10 ----------
 arch/openrisc/kernel/jump_label.c      |  2 +-
 arch/openrisc/kernel/patching.c        |  3 +++
 arch/openrisc/kernel/smp.c             | 21 +++++++++++++++++++++
 arch/openrisc/mm/cache.c               | 16 ++++++++++++++++
 arch/openrisc/mm/init.c                |  2 +-
 7 files changed, 46 insertions(+), 12 deletions(-)
