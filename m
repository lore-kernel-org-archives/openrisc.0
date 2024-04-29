Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AA88BE2
	for <linux-openrisc@vger.kernel.org>; Mon, 29 Apr 2024 05:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714369675; cv=none; b=Mv3yDwtTpNWXT2Wx3NsiOdbkBWKyKcT9zDD4VWyuXI7/Tb66JIgini8bst37WvCtj5jj3FfH2eoaF8WxWGJ/PNycGofmEBttL9md9HCgczL3G7nX5CIi790/tGrexLeM+GwGSRTZ8VOaY5ZcQOHPCfs4A9PtkKu7m66xilXgIBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714369675; c=relaxed/simple;
	bh=mLwCaUnpVNYspA5hxuA7e/h66qZyOZMRdg20tEUMey8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irT1+EB7w28saXHCFzgGN9bOie1iZ0h1y44PoBtyYBwBTrkYoTviSb6CmJ5ZpFIvl8nIJy63vODTCH3duUes1VvBrmqclqcuY5FjiTtbrRICWgLkbVqiuxmyCoGpE157pLeZ708kY+JAPgKDAUVuC8H79tks5bJRI4qWTdqk7fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mB55GS7d; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mB55GS7d"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34d2178fc7fso306033f8f.0
        for <linux-openrisc@vger.kernel.org>; Sun, 28 Apr 2024 22:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714369672; x=1714974472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3FsMpaHolUB4pEeVOHK1G0YGpTQh86HITlXYaKsVC8=;
        b=mB55GS7dQAi1zZ03c0DDuLTsB2AAZwX6mKECU+yLxZhvNC/e9PgaPXcDtWmVi4WBx9
         2Qufc5zvwnGLfCHZ/nmcfqzMaPM7bB731kLimKSeXjHrEBFDExaoi3XOx4qFGdKaYF/F
         TTLRJO4EDnueKROvYIQ06BceJdZUCvmhJNkmpGnK1TKYvYlt8VKFUEHq9oPfmf+YT3DJ
         uuWUxUvc1CrURnfW+fk9Y2DqzZG/S8bDoi4LAaFLyNdxZ8pDZdMHmJn3K1HYOn/sVlBw
         XgR+AohKxBbfWGzM+5cFo1D618xyUxqYep7AdL72DmUPrEIVB33Cf9OUxRovtiN163fT
         PXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714369672; x=1714974472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3FsMpaHolUB4pEeVOHK1G0YGpTQh86HITlXYaKsVC8=;
        b=kzJlcrE8D/XUPdZxKmT4WBkB127S1bV/rjR83Odilfqhd1Dtq5xvvSAQypBbhpp3ZW
         vaRpeF1VW99U0VFfrljyUHXhKXs3cbsj0UdxwJ9ry2xcyWh6DRZ1fDJwZXpVHx/Byr2u
         Gw1GrsRvZUmqe1gc+ow2DdJFozi+eYt6AftmGT92tdku/GBmnkEKv41gKFGdO1PN2CEB
         Nz2iuv+TWQ22bw4pi2q3PAbzEha2k+IKsZMme64eY3KV4Kf7L7ZzUUTwEf7ISR+T/LGJ
         hDoKhXTZxRAMD53BjjL0TleNjoIvJfeNGQwB0xO2uMeJAb6vA3G3UvIuCe9W6NjNbK9Y
         ne5Q==
X-Gm-Message-State: AOJu0Yw1EELVs6A7USxqwsGoJRJvItjxjI1AYRp7ZjBDBpOpCLE7sqt/
	XCzmU/nwKca01JqafzsLt7NJt652cikSaygtRUGNYeHwGvNsk7hS
X-Google-Smtp-Source: AGHT+IHkCfQ5Yw//0n6aC98+3a+H057n49GluhSS6dYo6tFP1BYgnS7QKHLdTVakotEu1Az28t5whg==
X-Received: by 2002:a05:6000:e4c:b0:34b:66be:3199 with SMTP id dy12-20020a0560000e4c00b0034b66be3199mr7169528wrb.62.1714369671905;
        Sun, 28 Apr 2024 22:47:51 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d65c7000000b00349eb6eae3esm28802102wrw.4.2024.04.28.22.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 22:47:49 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 3/3] build-many-glibcs.py: Add openrisc hard float glibc variant
Date: Mon, 29 Apr 2024 06:47:35 +0100
Message-ID: <20240429054735.2467433-4-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429054735.2467433-1-shorne@gmail.com>
References: <20240429054735.2467433-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the OpenRISC hard float glibc variant to the build many
script.  We update the compiler for glibc to support hard-float
multilibs to allow us to use a single generic compiler for all glibc
variants, this requires updating the compiler name.

Tested and all builds are passing.
---
Since v1:
 - No change

 scripts/build-many-glibcs.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/build-many-glibcs.py b/scripts/build-many-glibcs.py
index 35dac538e5..38eb9f2dd2 100755
--- a/scripts/build-many-glibcs.py
+++ b/scripts/build-many-glibcs.py
@@ -362,8 +362,9 @@ class Context(object):
                         gcc_cfg=['--enable-obsolete'])
         self.add_config(arch='or1k',
                         os_name='linux-gnu',
-                        variant='soft',
-                        gcc_cfg=['--with-multilib-list=mcmov'])
+                        gcc_cfg=['--with-multilib-list=mcmov,mhard-float'],
+                        glibcs=[{'variant': 'soft'},
+                                {'variant': 'hard', 'ccopts': '-mhard-float'}])
         self.add_config(arch='powerpc',
                         os_name='linux-gnu',
                         gcc_cfg=['--disable-multilib', '--enable-secureplt'],
-- 
2.44.0

