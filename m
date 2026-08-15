Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881F937CD2F
	for <linux-openrisc@vger.kernel.org>; Sat, 15 Aug 2026 06:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786775381; cv=none; b=AAOC3k2nV9t7L86xJs78/Qz9tA2bRkJBDpOHOSY+uvtv3wN9N5PwLlvnopnclgSGeX9BFPgH0E4NTuB3yfKJ7KcMBf7XfIXQwSlqrfUdzVbEukB3jehdmNBbpWjpnGhUQNmj2/SO/dsKuLMUhuwvK4DDoiVx230dM3CSeBHJ23Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786775381; c=relaxed/simple;
	bh=W8MmxHf8VIQLta/DajtV9zcCqnPXegiit1LybxZci8I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C9gfQ7VtwGKjWZrGj+qkXJhHLwV/s4D0AL90RXs+Ksf4RaCd8X8yVed+asNsTpKxE/i1gl2JlZ24SgtclbQYcmaWWqKM5wTxPAyPNndZEp/CmJiHm/tL3VZywZU2V1qa7saR9eOFbfAFsOJiobYikIGLNiAX0iOEjrxHT90qc4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ipz2MNry; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ipz2MNry"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4798bea72f9so1081120f8f.1
        for <linux-openrisc@vger.kernel.org>; Fri, 14 Aug 2026 23:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786775378; x=1787380178; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yvXa4hqxNLmS0mJoNsfuYgFzcEEkXHmR2wmUF9L+xbo=;
        b=Ipz2MNrydJfoJ7PatQ8kMlR1LQ5FyGtwJ4TvLUeE/qsLK63tGp8edShlJ6FfnIMwgJ
         iSNR3Mtocg+t1fH2C7jIeT6jVrJm3LKcqHej6QzaGB/rN6yl6ZwCOaZ4vUaVv4f2d5fI
         4qSRtBnH4dx0vnxaaoDPVL7NTIFm1IubMtstMCDKqZWNxojTfNIZAQRTA77RFVdkPaQt
         bUR9Zfs6rzv3qkNeenngJOUR9MW2mTKwzhFU+W7xgvtNji6m8LvLA3TEKkIHuRpcHtvR
         J1ykEUC/+EByxmWsaJBptM/+qsfqSuH95qN/8cAwvYN94xGKYrM9iblA60gcbON9d2jW
         WCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786775378; x=1787380178;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yvXa4hqxNLmS0mJoNsfuYgFzcEEkXHmR2wmUF9L+xbo=;
        b=s/fnX3iBg6VLVYAplUBg5hTiuzk0yJNB+iyxh0YGYIBF2PBeh7bX3iOcOQTcg71eXO
         wzR1L9+ztXwopIBYgEXCpl8rHdoZa26/FJ/VXwNaHQDzKeH4yB233JjamODbyaDSt6t3
         qT7qYa4QxeZMLdAZTd9YNg6n07jX39fM4D121uUmz1Wf+NB2+xl22nWGYtaVLNzRb/wA
         yxUBDEOR5v0hOOST7U2ZqObWgKidauhT/76yRToiH1KDw8MFSk6P+EfWHTBlnRQifGjK
         +gE1jukkVM4gpUce2Z1AFtS9nmlcJyte8vUBjPnNInDUc3OInge4hgt+JoDTUXsDP0ro
         Dh2Q==
X-Gm-Message-State: AOJu0YwI789t1hVt3e7fxcjyTGZwlqFJE26c7t2xONmE0n10mu1SvEfj
	a4V2f+n5suY6yfsrJquis2UrJmt4uVETpOzJqQ3VmLEfHBub69TN4LE1dg4uBnzG
X-Gm-Gg: AR+sD10v7vnFuqCWsXek+L+WJKbSGorUwyGXOQRFJ30NubwadrwDoviADOTiS2JY94P
	vhf1Pw13CXBwtwNALxU469pt3blUz02cz4Kkb8EWArRxYPUTAyAhnrVnX1wjMsQc+gbGSu9fwUy
	Nyr3Y8keOCM1bn0o8xVj6J3j/WRu1Ry8Ywtrh/WzKBBZQJQQfB0aw/Deu+f0No4MKFG/Kv91kAd
	sAms7LmV+LIHpYeozMjGPUBdr44h2pSy4BWugHWJKPA6nhoFoIr0P4HPGh6BjzRnNPHoaz5MPL+
	YkANeq0mqJ8Y1IX3RcNyPfRRsTmZR7i/W3kPfP9LtmKQFZ7CRR5E+QIOsuFzGMoKgXGhWe5SmlB
	JF3Co3+kU2X1oVoej0HJu346T5BY9B5qWFirtfrXjSEnCquA1DOGELrid1mzMDPiZTXudiAlRFb
	YfcAzqUfUB2aMRCtDp/sGzxb8Kp2LZIJl+Wk+4BEjsjqqTdTVB3rJCCJYZWx7IimGp2AeaE2SjU
	rI0RPd88Qmxinax0mb3+IaMHd/OyaQXuABz0R0afaRd996d
X-Received: by 2002:a05:6000:298f:10b0:47f:b51d:f0ec with SMTP id ffacd0b85a97d-4816079a13dmr13020127f8f.15.1786775377592;
        Fri, 14 Aug 2026 23:29:37 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2ccc00sm13726034f8f.35.2026.08.14.23.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 23:29:37 -0700 (PDT)
Date: Sat, 15 Aug 2026 07:29:36 +0100
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC fix for 7.2
Message-ID: <aoAHUJuULSJM-caZ@antec>
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

for you to fetch changes up to 32ef1b30ad736519f7a207bcc2986f3d4129d972:

  openrisc: signal: do not restore privileged SR bits on sigreturn (2026-08-15 07:14:55 +0100)

----------------------------------------------------------------
OpenRISC fix for 7.2

A bug fix found by researchers.

 * Ensure to mask all privileged bits when restoring the supervisor
   register from sigreturn.

----------------------------------------------------------------
Ali Ahmet Memis (1):
      openrisc: signal: do not restore privileged SR bits on sigreturn

 arch/openrisc/include/asm/processor.h | 2 ++
 arch/openrisc/kernel/signal.c         | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)
