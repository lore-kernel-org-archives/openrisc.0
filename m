Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A41AAE28
	for <linux-openrisc@vger.kernel.org>; Thu, 12 Dec 2024 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734038284; cv=none; b=EzlcZh/7rLj/KILNhyH3V/zt4Fu6ceGOKCAnfm5MgeYQ9Vv99xATVLzU9/XQ7uzGL+eMsZwvXbMO9E7WIsE4OBrvZzEAzJm0fHQPO/YIyKHyLqFFWzACwsVOyDgJRjPH/w0wT2Ei2mv0gCSYlh4mZwQ5LXoFc7T/N3qDCIGVbgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734038284; c=relaxed/simple;
	bh=eTcEB8Fqy3T357oJlleRmawzsip6ngs3gggTNf9IcYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uXw9WhpGGs28hFyuWfBPKfyQN4UGHxr56irVQstOqCt/E83tQv4ByHyMPGr/Sf3xSHqIXale3AC2/y/L41ShF7W4Fe1w97d3dqOoGw79hvDV8qtMjj3CrPCZBucQVhG3rduPt2GSYndCHJRWSXdj2sk9CiNwUK9MrHkprMZwBkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRcyYONM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRcyYONM"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso1047079f8f.1
        for <linux-openrisc@vger.kernel.org>; Thu, 12 Dec 2024 13:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734038281; x=1734643081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OdXVm6w85j5so6XVFMzX5aO16bmj8zVmTy5MAKlEBhc=;
        b=PRcyYONMmKURB6GVoc3MySM6nZsvK3JFx7TcxYfg0jWqsA9Otn/lUh5tYvZ+gWKm7/
         NiAJtKlwMrBj67zxtpvIY2oylDKzsMh7QmKJcMQfDI7XKXyq+T4A0XKquxhhe/AlEU2G
         qfzF1DysJHMGq7VhYWtPeA0kOHU+aUxOTXLB/Q62f10M97bo5O0UhpoXVxqqqC78aP9S
         uD8SiSvnAmUvjlZcZG37xJlq+5vRLDqudBUsjlC6F5Mx+6qAqCuvZBTU12r6mChvK3t+
         9k8RsWO7ruZxcfVHAmzkS7FpUimaFk2iIXueAHtuT7ZaUnuE/O23lmfw/ES5diSf9yPt
         v/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734038281; x=1734643081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdXVm6w85j5so6XVFMzX5aO16bmj8zVmTy5MAKlEBhc=;
        b=EBLfvCeJ7JUwvTjp+/FtBeWekyfmn9inPwQ4eBkmk9wWxEi9WmELw9zEZQhGiEGYKW
         8rExWb30RKN39c/3prLrfX9Bzu5XpByWVie8BkNjJZP+fuZnJkSNcV9rS5gyRAS/v8+J
         9uV1bMk3SZrVnJCxI4+gGIbbKLSPyTOILHZzsFr4weplQ1AECKwBq82nideMeEFzkevj
         q3Moexb2pr4iGUA4lqPHL4kriCMFgsDvvg575GjFBsNPJA0R7FvRlkhiV2tjPWzBZtvy
         qycEozZlRfwv74yaSCX4gzFgyY/nB81BNZsUwec4vaRYlQJUmWo6UZwuC0EjQ0cMrM0i
         CI3w==
X-Gm-Message-State: AOJu0YzWlvA8lNgFLc6/lw/L9s+d/bP/58SujL/FhvmJq4HCqdmHQRsI
	gRN5UkLt1Plye8itX22VuiQHYwbrY2tarruBUSouNGvs2Fm7STT+l/jJ6Ltb
X-Gm-Gg: ASbGncvQO7pABAv1CszbMxFU4PTBz74qVsoOlfu2cvGSezU/bnxFWmIHYIMkoifme8N
	5lqKJLZbUk6BNy9JiNt6+Y0Zy9bn5ddJeniYa0GbVh5xKG+JMBeokMbmEJ8yMGia/Rs001HqBQq
	th/tgJbtXUmTe8oc9kYAkYm53Z5IyY6RWbKf2hJ8f7sxqi4wemp8J033tgrjh/1tGlWCk2k9Htq
	v2VJlOpDCmRftn/KlXF3KUssWOQ0ckrqFxHBIVQV73vbxOAh09NIBbHgPFbOMzW/Dq0JosZX1Tr
	zDcktkG5SjAmxO4UwoAK
X-Google-Smtp-Source: AGHT+IGNBQgplgngbKqy6SA2Letbj09+m05ik79Z1/HPo/Fz599J9m56r0aN8v0/D7p9qKKW5THqVA==
X-Received: by 2002:a5d:6d82:0:b0:385:fd24:3317 with SMTP id ffacd0b85a97d-38880ac604amr104633f8f.1.1734038281134;
        Thu, 12 Dec 2024 13:18:01 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f440sm5017357f8f.17.2024.12.12.13.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 13:17:59 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH] or1k: Update libm-test-ulps
Date: Thu, 12 Dec 2024 21:17:54 +0000
Message-ID: <20241212211754.2139130-1-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pick up new functions cospi, "Imaginary part of csin", exp10m1, exp2m1,
log10p1, log2p1, sinpi and tanpi.
---
I ran this on ron of a build from 2024-12-06. It looks like a few new functions
have been added upstream since.  Posting, then will add new functions as needed
later.

 sysdeps/or1k/nofpu/libm-test-ulps | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sysdeps/or1k/nofpu/libm-test-ulps b/sysdeps/or1k/nofpu/libm-test-ulps
index e130fd8a1d..305b6cef70 100644
--- a/sysdeps/or1k/nofpu/libm-test-ulps
+++ b/sysdeps/or1k/nofpu/libm-test-ulps
@@ -535,6 +535,10 @@ Function: "cosh_upward":
 double: 2
 float: 2
 
+Function: "cospi":
+double: 1
+float: 1
+
 Function: Real part of "cpow":
 double: 2
 float: 5
@@ -570,6 +574,9 @@ Function: Real part of "csin":
 double: 1
 float: 1
 
+Function: Imaginary part of "csin":
+float: 1
+
 Function: Real part of "csin_downward":
 double: 3
 float: 3
@@ -763,6 +770,9 @@ Function: "exp10_upward":
 double: 2
 float: 1
 
+Function: "exp10m1":
+double: 3
+
 Function: "exp2":
 double: 1
 
@@ -776,6 +786,9 @@ Function: "exp2_upward":
 double: 1
 float: 1
 
+Function: "exp2m1":
+double: 2
+
 Function: "exp_downward":
 double: 1
 float: 1
@@ -905,6 +918,9 @@ Function: "log10_upward":
 double: 2
 float: 2
 
+Function: "log10p1":
+double: 1
+
 Function: "log1p":
 double: 1
 
@@ -929,6 +945,9 @@ double: 1
 Function: "log2_upward":
 double: 1
 
+Function: "log2p1":
+double: 1
+
 Function: "logp1":
 double: 1
 
@@ -1003,6 +1022,10 @@ Function: "sinh_upward":
 double: 3
 float: 3
 
+Function: "sinpi":
+double: 1
+float: 1
+
 Function: "tan_downward":
 double: 1
 
@@ -1028,6 +1051,10 @@ Function: "tanh_upward":
 double: 3
 float: 3
 
+Function: "tanpi":
+double: 2
+float: 2
+
 Function: "tgamma":
 double: 9
 
-- 
2.47.0

