Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532031;
	b=afdGlzqdl81VFfyAWUQbFOYIIp44hno1hzhSeB304JeMu+N9N9ZQK2gByXmRywfTPaPm
	 GQjpf6rrJNIZbTnOUxIrv2Trh5GrSyVzBTPLF6yVs3YW6iPM/wQqC1pfUcvGlgwk5Vc+B
	 xyTj+PTWt8DU5EH1RqHXcMDl2iVYPlecUuh1YLbmgMYaQ81PU9sg0AT9LxxGv8Sq/gpjt
	 RyKtkN423ZTlcBFHrMonjlD1rHmf5xFNJfpnP/k71+l8DuyBKjf29ZofO+P7koX3mdDgG
	 60SbvRDXNA0XDZQ7+dbqfzeAmTzEZypolci0jT1HGxzEVDCyX69C+zkZxtcDEohs89g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wg6WoOBQHQjyYluK4L+0t2kDVevkuffjDXIFvLTMO5w=;
	b=FEE40LE0FUrgs6HqEraRCDOUIe73JqJ6lB6wH5gLzrRSH+OsrDQhtj/FFAaAzY8ff8RW
	 Nv9v9VpjNewpLSVvWyJ10hJ0PFxfT5mROkhjAcZDtL/iVLkbqj3NRKUcOQUWW1el2La8M
	 f/n3hFRqCuFCkLrnA/xebp+FX+Efq3N6Vht9Cthm0lQeKe9NuBwBgbtlM8/KmfP3G+afq
	 ls4BJ+cPQcAUWr/7/n0GPEZqgjM2gJXZfJPFOjbnKF3q7YfwwEe9OMG/HvCVRg0A/b0Pw
	 pXNc8HnjI+ie6Tu3AZWpMMgWNmEeQb3JfGqniYmzBpNLuIYDtbJSCpzpEa7ybPcMqGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cPXEfF20;
	arc=none smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB69606A8AB
	for <linux-openrisc@vger.kernel.org>; Fri, 13 Nov 2026 01:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FB69606A8AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cPXEfF20
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3ac97e45a79so3843571fa.3
        for <linux-openrisc@vger.kernel.org>; Thu, 12 Nov 2026 17:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794532029; x=1795136829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wg6WoOBQHQjyYluK4L+0t2kDVevkuffjDXIFvLTMO5w=;
        b=cPXEfF20llxI5d/9D4GvK+Hfe3KNJCcc/Wlpb+vVT3jd2hxVEH3+iaBD17a2tuS0hj
         UA49lj0e/5Ok8tpkwMgtFy6axX8gjf6/QP7+nHr59jwvT1saT0/IUZeE5NZayETDWUDD
         pWUYtqxASyf61n/zJ/bH3Ze+AB9YmBwApWfmeQLMjrngXafoEXvfiE1u7ewThlU6vYKf
         R/zYBScMOGl22VezzRuuCbdny5p8ZjbXGj1goGYLaLAeErOUqdfwiFjWX8tljlLVNFq1
         3XjqBYdIpvhIf5A3gIV6eY0WO7mfyCfg0iOxqxHPfsIL9KJMJeEazB1x776ZH0whaOcf
         Un+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794532029; x=1795136829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wg6WoOBQHQjyYluK4L+0t2kDVevkuffjDXIFvLTMO5w=;
        b=YT39CiRncIYKmh2U1A6BoKYe5uwb3yTKvCZrBMMrZ8EYbqJUisOjBgjSvk7AdeTnmK
         1Xxu9AOvMcIVmY00C83ljcJGd377SOScfNMjW7drIQ7CBkK6vY4KGSaZJ/uYuOD5miag
         bGfDcl8DQ7i9HTvDczAwaJl1/xJyD2Wt7e0merjBxq4Hbx437ADrazO3VR9TU/n8BvO7
         zCRSD6zRfCAChMxXIBzhyCb0eIxNJhvnVCjv6p1csL7zq8358VlA1YzGqYZKozijxPPZ
         ZNDVqEXYjEB+A7Szo8amFovDkxm4tN0gvy7dXsh7AyykZGbAxCc/IgUrzr5yIU4HdSoQ
         D+6Q==
X-Forwarded-Encrypted: i=1; AL+hErEoodi1Irqi7/S2wNZmpslPuEi8Y7+EaGs6r221An+PDcjKAb8YKH1FyRmJwbz5fSsqbrDe5kJ4LtCg79HS2A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/34Q4msPxdsc4l6wb3sotPQgikbnu0IWSV37RDnbiDG2HOtKVT
	OrlvjmXAAUl0tdXk+3oMJhWNPqHlMM2GnT6rPJhwIp4sk1os6gocz2Zu/Ez8YROKrEo=
X-Gm-Gg: AYBFou2TaR+mZmLp6AufjnqpH8/N6XyuTXom2d7yb2PKxZ213ExfOJmDyNtYRRWXti4
	5VoaNi0lkXGHsMN0ovQlAjt4U2KGbYxjkwZPnI1AIQ+Hm8CNe6QFS1hxipIQUCdYSeiV649Jakn
	NiVaJSKeb/y06l3GsufGPiRqbHadRYI3H9CuBxP8gp7aetoe6FMmnxukj+eHI9LLCjYDH8S6RU6
	q18KAUOox0XzgQVnp4kuDIWWuxnnlXddP1BQOkZXVm3merwBnCpjfVtu7EkOf/e/EmbTtP3HWKt
	x+sgpA5CE7a+MApJXTCRMRFQhPB5czu+3/Ks4IQz8Sudnc6u/YVU27o1IgP9qjG+BKX1UpRZWvm
	+pZdm+KJXAwD9j2ga0KZz6eAJPb4rN4SQrqlkBG59Zn2gYuuzKY53vmRG4pCOmL0W8pqIZSo4NW
	sVF+H3DT2ByR7uWgXGXUkw28PenM2EQSJJOHCE/9IBSFvW+Vxeanuerb/0NPVy651JgDFrng0H0
	xywd2/ORDqzYRkIv5mDRCU0t4xLQklsjREyPzC/6/jtKv6oI2tL99DApgcVeyfZUXYE5jnuAP1T
	Iar4B7sBsooXljPtJV83gBwV0a3xSzL2otsOH/GDhY6t1N81tw3rvucZQsLPiz2W5AkHk5gbCNq
	Bzzk/yxbizDzFAtt/sM0Nb7yIV1+DtK4U
X-Received: by 2002:a2e:a809:0:b0:3ab:716d:6406 with SMTP id 38308e7fff4ca-3ae2b511123mr3715531fa.17.1794532028747;
        Thu, 12 Nov 2026 17:07:08 -0800 (PST)
Received: from SafoStation ([31.40.65.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae2b7d183bsm3133941fa.31.2026.11.12.17.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 17:07:07 -0800 (PST)
From: Safocl Stollmannovic <safocl88@gmail.com>
To: Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-openrisc@vger.kernel.org
Subject: [PATCH v2 05/10] openrisc: fix duplicate extern declarations
Date: Fri, 13 Nov 2026 05:06:10 +0400
Message-ID: <20261113010631.139191-6-safocl88@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113010631.139191-1-safocl88@gmail.com>
References: <20261113010631.139191-1-safocl88@gmail.com>
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

