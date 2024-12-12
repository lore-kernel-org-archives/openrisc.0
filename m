Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAC6223320;
	Thu, 12 Dec 2024 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022161; cv=none; b=t8MAy/3OuPDlJhcUHeKXFxlMqTQySZv7Ox9O7TlWby67PK64IRVIFFdzsYGujTqpYW+Possk7rWgGEBk//jFB535YtdChNFlIiL3R55bi0gjLGbGhywFXpqD/KRDEOLKOvdqU6tlVlqHhkdq1iLUExYzI1RywKfWzGq0I1QYL8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022161; c=relaxed/simple;
	bh=2INhEt1eRMpTOWgisekYLZPaLn9XCfC+rwGP2+7G0kU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K9ccHIZqTdve0juxLMplPMH07tE+mH3bNbSS6UnxjpfSwwFpyTBcliDHCxs2PD3IhaE36+zoGFDTn7NHgnB0urt2qnZUQazuqN0J+TMsKBuA1cdYzF96AKzgtNlI5w2W/UeG/13oYxAwI4BX0zteRm+yVLXZynHIC2HDrU1zO9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmVxQ/mX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmVxQ/mX"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361f664af5so9059335e9.1;
        Thu, 12 Dec 2024 08:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734022157; x=1734626957; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xS8zOG2k7BJL/kIikK2Hmoex0ZOjVqRhO0dl3w9WJVc=;
        b=mmVxQ/mXjNNpwci5jBaSvYz3PzSGZN4rzNybGW7MCumXLuY8PqCZ2uk1mcskRD7UGA
         YHkJFKoxcoChAEhEEuKWkcz85RN8lupc2d6XzpjGOr3IVVw41F7W+O8IbK16xHPtzCu3
         asxnI91YFnLAshefxfKP1+XAAvKEqrbzCM6PCNWa7IBtsVQ2fBY2E6sL2QnO3ayFJ5+t
         CW6B+WlFLYiim9U5tn6ikbmnOX4LLHdSad7RMaAaFpRqWgD5CsA3XBf3xfwmHRVOCtPM
         gnXr05HeFSN0qTgN3ZQCfo2huaDhHurF7ZNtlt5vcr2qzjH198O+L+KJ+wIIQrMb4pWv
         tZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734022157; x=1734626957;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xS8zOG2k7BJL/kIikK2Hmoex0ZOjVqRhO0dl3w9WJVc=;
        b=NAwPoVYaz55jBHuisrtUtCJ8YW1Dhn0j3gHS7f7MtUZK9oOJMIF5zXGiM991b5VdnE
         JAq6ycnVG5p0Dif0RI4nH+G10YF23Nv1EyujxTLuNEt/6zCrAGY6391jrprjmo9watQO
         3O+dFS5nfxpDJujF+G91VHiAq2kOS/r+b7ZvslZ4LAzlpnMPiHtYVILEO/KGZQEAUb+v
         NXQGH7GIVYvnRjOgYyvDf55WzYysPyK6LZaoHFXcOdH9q544tUSCt6H+a5ecrH+PHHcz
         ogBpIlmpruRUBCazbBtHvIRvSU6DPE6LgmQORpDatDL9Uvxi5FkxMq1hkcIhxSlcRHoQ
         WZ7g==
X-Forwarded-Encrypted: i=1; AJvYcCVaZSc27sMAj8DSpalXAEpvugYN3f48eHI1TIVIVfoEyqDv6Y8GVipVQ2ljgpb8fvHGqvXdmIEAb84jbHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHX0lzDikOQ9QMs2EAEMB7o2saiRo/gqI8fO9DCg2zTZPe5rpD
	4JBNuperMBFmNw9HierzmBssn3nkvvKkuiCYaDPqCFfLARdBIov+kTbd3Q==
X-Gm-Gg: ASbGncuSDcqgq65HsO6UD3GOZjiXgiP+G5tZFuxzctupSzItZDOoe5W5RklWpdgDyPW
	om07ZT76JhR1o8bZoWNhAEbE9hBOdH++6Nwr/hQHlZcEmqRijtkd4+olaN/Ho+egW4mBCk7QKL0
	roHhsageg349y9hxDhUhM/e6AvAZ0kvOeurD/TFPBqk1oceEBMclvDXsa4LXLDBUx+E2uJtEc22
	eudxx9cSzM0QLlrfZZ9XfzbXvhJVp55gqoBVgb3YsykmcF7wlXlcquYj3N9JDC/jvqJUkpk1gxK
	2qExeRFSyj+8EjwokgiI
X-Google-Smtp-Source: AGHT+IHOrAVPljiHnhz8atpFCl+4bujtYaOrnXoZxDtpXkoTjXUfq98vko4R1tM33lrtMOnwjgkSYw==
X-Received: by 2002:a05:600c:19ca:b0:434:f586:753c with SMTP id 5b1f17b1804b1-4362282772fmr38061515e9.7.1734022157392;
        Thu, 12 Dec 2024 08:49:17 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b44f4sm21561785e9.30.2024.12.12.08.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:49:16 -0800 (PST)
Date: Thu, 12 Dec 2024 16:49:15 +0000
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC fixes for 6.13-rc3
Message-ID: <Z1sUC4d1kUipZIy1@antec>
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

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  https://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to c8f8d4344d50d72181207ee73175bba567c25f58:

  openrisc: Fix misalignments in head.S (2024-12-10 12:04:19 +0000)

----------------------------------------------------------------
OpenRISC fixes for 6.13-rc3

A few fixes. One is just a formatting change but I figure I will include
it here to avoid unnessesary pull requests in the future.  If you prefer
not to merge it now I can leave it out.

 - Fix from Masahiro Yamada to fix 6.13 OpenRISC boot issues after
   vmlinux.lds.h symbol ordering was changed.
 - Code formatting fixups from Geert.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      openrisc: Fix misalignments in head.S

Masahiro Yamada (1):
      openrisc: place exception table at the head of vmlinux

 arch/openrisc/kernel/entry.S       |  2 ++
 arch/openrisc/kernel/head.S        | 32 +++++++++++++++++---------------
 arch/openrisc/kernel/vmlinux.lds.S |  3 +--
 scripts/head-object-list.txt       |  1 -
 4 files changed, 20 insertions(+), 18 deletions(-)
