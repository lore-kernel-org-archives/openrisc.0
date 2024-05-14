Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F394C1E480;
	Tue, 14 May 2024 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700887; cv=none; b=s1EcD8aF+hV/+zAiETgW0TbZEZfX5ksZAVdjGAnkAYZ7BKaO9/vATc2j/xmWitvRbG2jpYfv22sjq3iIP+J9oo4q8PMnlPKTI9CgBO3DfBvGs1MZoG0ZNVvqat51odRsMmfPUDoM9uOjTsAfkA5PJ+T566eEquRG60NOroZJFqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700887; c=relaxed/simple;
	bh=dqCm6+j4tdJvYSNQPSr/2JRGDw601+2ELf59y88bj3s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YQY/FN01GIsRFkA5WQ/c2SwrklOXNw0SCxbWI8Dv6OBFbD8Zr+Y6YS72QE6zYY1lnSX37HijhP+Qra0lfc1kxYFhX/rJr+AujUVg8eWahEPbpBGzxfw4DpydzbCz4HJqoBpESRd/nvuKWXDt6AE5epime9X5nbFFhg45tJOfiWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqhNUwMU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqhNUwMU"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34f0e55787aso4515989f8f.2;
        Tue, 14 May 2024 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715700884; x=1716305684; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sobQrYRrUIrv2u/Ueg4Gp/A2t3x/7l2mYY9rspjnJ5s=;
        b=ZqhNUwMUyiZkklMW3wuzzhXJpik8VBTsLpFEGk9qJtPmtj4DtzPwh3Dh7dQAZDmS0I
         7h/2QJe83d2nEKtxTNyFdu/6LP9YkWnLuM1sHQyLoA4+xYRxEYvdUmZnHmr2z/KDaT6R
         EEvEZ652NfNCvx+xqMmQW+8f9JENZfk6MqwXivTZFDJa4iEBPPqqGNMXK4ckPcddjOft
         TLPFzKxUxTCnNgc0Ac9oFAd+PnWsJQNALg7xe3osPQrmXXy9bRZjUpFlMFo0eLrlcclr
         Ja4p2Ob36KVrQ2AWdPMIQIzct7lDalBJhH2eQaekZoxK6Z+IIqA6AtDz0UuIMA7MXj9H
         IRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715700884; x=1716305684;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sobQrYRrUIrv2u/Ueg4Gp/A2t3x/7l2mYY9rspjnJ5s=;
        b=N3EZsEvlfDPDstKeQ87pIr7ThbrKSoiA1Gdvs3tWYqNuy/DvGmptAORdSRidcfwL5M
         EhWdxt3yw5aSw77e0XOHmS172bzHNA/uyLM3F3L2vNLMOGXZ1bZmVcnKJz0VKAZupq7B
         fJNRH17v2SyENVAxsmWNqzdX/CS33BiqmGDc1iMpdNE8vWSuJPKvA0+/KY3NttjN23SQ
         nYwMoHrtgcvpepcRRo/T/t09gAdgG58u/QBBrR6I8fD5S0b1Hj/k0eEux3XZzMa82aA0
         Px+Ka4dC/EfLOx1DOBUpPzPg4As2p4ZeHdlhAkm4bSiwH8MwogPg+BTy1i84CMZm7ssz
         ecaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+q+IFxIk9g5wgK5qsihXP6KupapXV5QYh+B8cKjmm4Aa91alWTpK3ho6bHhfy2gQFqo3nJSipy6R4yTQXqq0JJGrNClbvK3btwwaf
X-Gm-Message-State: AOJu0YzZ1xKrMiUaZnjlmDGiJJ6rDdWqvxoy1uFXGohzhkp3ChnVghRR
	ZB2LWy8Rls0p4DNL/SkF5tyoEmGmuwWVQOq5DoDWfAYJNw1zcmMJQkkIuA==
X-Google-Smtp-Source: AGHT+IFaujIE7MKEMLnCBmwSzLCQPT/HDdGC6kQzBH2W7jbk07W+Q8BWVbOdZI2hOoM7qiFFLTHHRQ==
X-Received: by 2002:a5d:6a11:0:b0:34f:824:17b1 with SMTP id ffacd0b85a97d-3504a731c63mr9081171f8f.15.1715700883923;
        Tue, 14 May 2024 08:34:43 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacfdesm14107070f8f.73.2024.05.14.08.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 08:34:43 -0700 (PDT)
Date: Tue, 14 May 2024 16:34:42 +0100
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC updates for 6.10
Message-ID: <ZkOEkhs_-wiwucSO@antec>
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

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 4dc70e1aadfadf968676d983587c6f5d455aba85:

  openrisc: Move FPU state out of pt_regs (2024-04-15 15:20:39 +0100)

----------------------------------------------------------------
OpenRISC updates for 6.10

A few cleanups and fixups from me:

 - Add a few missing relocations to fix module loading.
 - Cleanup FPU state save and restore to be more efficient.
 - Cleanups to traps handling and logging.
 - Fix issue with poweroff being broken after recent power driver
   refactoings.

----------------------------------------------------------------
Stafford Horne (8):
      openrisc: Use do_kernel_power_off()
      openrisc: Define openrisc relocation types
      openrisc: Add support for more module relocations
      openrisc: traps: Convert printks to pr_<level> macros
      openrisc: traps: Remove calls to show_registers before die
      openrisc: traps: Don't send signals to kernel mode threads
      openrisc: Add FPU config
      openrisc: Move FPU state out of pt_regs

 arch/openrisc/Kconfig                 |   9 +++
 arch/openrisc/include/asm/fpu.h       |  22 ++++++
 arch/openrisc/include/asm/processor.h |   1 +
 arch/openrisc/include/asm/ptrace.h    |   3 +-
 arch/openrisc/include/uapi/asm/elf.h  |  75 +++++++++++++++---
 arch/openrisc/kernel/entry.S          |  15 +---
 arch/openrisc/kernel/module.c         |  18 ++++-
 arch/openrisc/kernel/process.c        |  13 +--
 arch/openrisc/kernel/ptrace.c         |  18 ++---
 arch/openrisc/kernel/signal.c         |  36 ++++++++-
 arch/openrisc/kernel/traps.c          | 144 ++++++++++++++++++----------------
 11 files changed, 243 insertions(+), 111 deletions(-)
 create mode 100644 arch/openrisc/include/asm/fpu.h
