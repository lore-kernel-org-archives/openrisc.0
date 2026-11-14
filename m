Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794675405;
	b=E3aM5IaoTYpcWTSzQreWOGkO3HqaCjyN2h5MtM6WJrofjwe3R4GOlPUfjCKzUqqp5KMK
	 SZ3OIl8iyusKcIiMKIK4kP8YMRsHsaX2b8t1kS+q6+ppQLhR97UiBS0TBu8IqDxIjXiKH
	 GMPjXpAd1E/ISSv7Jkeia89iwwXogZYHa/CmewNlLsUnKrJNnB0T//cA/5h8spU9YTb1G
	 BcIe7p9DGrkau4fPmpS4PexEggDpQo5qT6PpkIXiCfVk9ElUY03xpRy0oxIy1MFvu9oHO
	 8sreJdFPLMxxWC8FhJPnsTvB+0ueXXyW3kp39B3VMV2PA9+dyURS3J+L5Vh93YUb/1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794675405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=M+6ivWBMmxezy4v/LQH71faPp84I+G626mB69PT8i1U=;
	b=YzGJl2WIAhFh9QyNd7anlLf2zZWCMtZF8DeAu74UK5vlVw+W2h2KrziqFtQj2fZDtk3+
	 EMhAC9ihbhxHUDXZKc/jIbANH04c/VQ3cYeGXjMqbjwN0T/RSYCTVLHQi9hWck/4Gic1G
	 RY6r0OI06/7fNRLH+AgtMGkSkZYW1l/FhTkVVLSQuNeEUAsenhjUSj0+a+YkEZgkqXl7+
	 6h8ySD1hhZaL4LE5rlTc8YW/YS+PGv8k2Pk7RNq5bzRvfIfCFk/SEE0F6RQnpzXl37zmj
	 OOGnsnGBpNfrrdlC3DjoEkKivTtOdA1P8DIRFo9Cf5gqx07qgCtV7eZ1xNo2+0g8aDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BELsfkBE;
	arc=none smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA56F606A8B1
	for <linux-openrisc@vger.kernel.org>; Sat, 14 Nov 2026 16:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA56F606A8B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BELsfkBE
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bccecba199so2440378e87.1
        for <linux-openrisc@vger.kernel.org>; Sat, 14 Nov 2026 08:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794675403; x=1795280203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M+6ivWBMmxezy4v/LQH71faPp84I+G626mB69PT8i1U=;
        b=BELsfkBE6hXeMWsLkbtlRF/tk79rWRN0B+r0VOYnqnZxmf+ReMlC7y/1xg9k2iE9zm
         mp0pGARAKsPcoqvjSHcrl5j1aS/xhzouTXwPnB+zYBrPKWHTbhQM00f3W70Os0cISdTG
         ithC0iFPEGmYVjoV8oPhVnVrmMUXqmoewJqiaelaQnpcmmtQum7Vycpp/swNxSopJu3H
         F6/qvwns7T6lXaPf+cz5DBIFmcEz0dMbJ9EUxrZQ/D1sHDaC5Jo60Zi51wpA8eG53lnI
         fc4rNRL0Tu/v3C28aRz2yOlL+wVUaSj7uXW03rosmQtwm/Oc43Hq7pPPFP+/gMuhMjHs
         vVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794675403; x=1795280203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M+6ivWBMmxezy4v/LQH71faPp84I+G626mB69PT8i1U=;
        b=WZHM8HUV6+1ksBOGht6+9j0Ipwt8paMXmFueTwpqBm11yivs4Tb2rksmkgIrbn2xmF
         54Q256Mzva3hMSR65fc+qluFVgQ7H+4Nn9M8FUH9SUfVr3mMn5WT8l1y4Ak2m4Trxnjp
         7WTMflqCOorEkSVimM5z8Um0USUWrTvMUebOUU4UQhV4uWYfAyJK5s63E4pOiulgZZQJ
         PhyvHqt/R4A9PLFHVpmbnvh9ebKl6YwTRw7Y/Ci2jzYa7RtpryBQQtSPSOGzQma6TXwU
         SkPBlSDrzDjKYY5o5N0mSJResS6E0S3kXDNKBqlDXk7sn4IKGBIH7ooHdF5LUbynHuhe
         aKfA==
X-Forwarded-Encrypted: i=1; AL+hErEflDig/BZEulzTvVaV11p6Zl8/OLOHxxRXOOhxpc1ZXfbBJqnWxFvtw3apDrHNqgaWsSek7aKyeI0doc1zdA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+olwEh7j9UmqjAtxxyYEnMfRPw2Le27f1oRKi5HYx5+ThmxcCj
	ksUjFCzEtTbAYoy/waw7HmRoT293S6P4qh6P/Wgm2tqs5tx66fA1jRhw
X-Gm-Gg: AYBFou2we5zZ2H6/UobQEcxcPdAMCt1LAXfj3uNm15YXkJESuBqyNepZUpYjoZ49R2H
	gEN07yrN79rlDTn2tXoDDbcEgkyjvhd+ngGSaHaJfU/6fJZoBuj/gDmxOL9zvrGQhVml6mcNROR
	jdiHx1FozGmQG0gsAxDC2Q0eBOO1pygaboq21iJ2L3oQ7x1AVVnDAjcs//iU3BObrk4R+M/6gtJ
	vhEEQvzpbInC/wIKn3hIXiEer6iGfv527LEeeynn8ICpD4VlLgesk/KmzLbm2X/gLCWcLr8HCFe
	ek+d5/zlDDtUz2wj462Pgj6xH8OCrK+SRY/SsW1XyvOx8dfCCX0Va5kDtyyvwaw3gDJI+j5CpNa
	eGPsqh/8pAGWWmYMy/1LXTjHbhNWAMDcl77vt3usUvB16gyGo0tCrVjawu8ReObvl3XvaVA+CnX
	sEI107VjQDiPbz9p+9PjTwJ9spp22aUX2LTsSDrdzHA9JEFdeOvivtANdkEfnuw4rWIREThG4Zl
	R92MTCor6K4J/hqVqYN6XLxeh2XPbKDhlh/pB/H/61ZKyPgk0v6GEOqStUgBDNEVUEuXbzawTf+
	AjC6eR2I51rrCJRjzfMs/9eB2bnG61Hm5wr198GKn3czYwRafy4y72ZpoayCkJemYRdTJ7gL3U2
	ere4G9cB1yQ==
X-Received: by 2002:a05:6512:31c3:b0:5bf:e241:cd4f with SMTP id 2adb3069b0e04-5c1709ca463mr2480341e87.32.1794675402862;
        Sat, 14 Nov 2026 08:56:42 -0800 (PST)
Received: from SafoStation ([31.40.65.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1712dad26sm1792051e87.8.2026.11.14.08.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:56:42 -0800 (PST)
From: Safocl Stollmannovic <safocl88@gmail.com>
To: Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-openrisc@vger.kernel.org
Subject: [PATCH v3 05/14] openrisc: fix duplicate extern declarations
Date: Sat, 14 Nov 2026 20:55:45 +0400
Message-ID: <20261114165612.368785-6-safocl88@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114165612.368785-1-safocl88@gmail.com>
References: <20261114165612.368785-1-safocl88@gmail.com>
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Post: <mailto:linux-openrisc@vger.kernel.org>
List-Help: <mailto:linux-openrisc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-openrisc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compiling a kernel module with a C++ compiler results in a "duplicate
extern specifier" error.
This occurs because the code contains `extern asmlinkage`, and `asmlinkage`
expands to `extern C` when processed by a C++ compiler.
Since the code already contains sections that respond to a C++ compiler,
I believe it is a perfectly valid approach to gradually move toward a state
where kernel modules can be compiled by a C++ compiler without any issues.
The `extern` specifier must be removed.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=222257
Signed-off-by: Safocl Stollmannovic <safocl88@gmail.com>
---
 arch/openrisc/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 73ffb9fa3..c46899806 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -129,7 +129,7 @@ void show_regs(struct pt_regs *regs)
  * Copy the thread-specific (arch specific) info from the current
  * process to the new one p
  */
-extern asmlinkage void ret_from_fork(void);
+asmlinkage void ret_from_fork(void);
 
 /*
  * copy_thread
-- 
2.56.1

