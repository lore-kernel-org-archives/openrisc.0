Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316CA1EA87
	for <linux-openrisc@vger.kernel.org>; Fri,  3 May 2024 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757268; cv=none; b=sck3lG2CyE2Elq8ypwBgwzIfXYKHCpmmRxHOugT/PR1b++ALUKstj09YJjU2KE5nPAZdnmHLscAEUDLK5QKIsVD59bzNAPyJHV15t0r28QQeQGAhj6lYu5KxhTusTPuFLoiIjIOjY90KykGW8uLlT0NdxIDaSoiAYyeJ85dRzbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757268; c=relaxed/simple;
	bh=VkUZv4GvWcn4BM2BCaYGEgq2GExuqEbPzDPsT6ToNe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9MhPb3kBdmt7wsq5ts/dZBGFLeCOEdTAyrPhOGxdx8VYSBBCFxe+smLwVTMBe5zy/qQty9AjX9Kbwg35Z0GlMJuFsXsYXkhVBhoT+pFj5TtFL4V4SPhTGmrlS60vS5xh8fVLkpvawypZaFI1Z3a63HM37J+CNb5aIZpwPkpcIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zm71jZk2; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zm71jZk2"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso122014761fa.0
        for <linux-openrisc@vger.kernel.org>; Fri, 03 May 2024 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714757265; x=1715362065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILo3F4g6sqGLSNDOgBrfYgNSRthgJSy1s+0EPzQXChQ=;
        b=Zm71jZk2RRRN6FMugOZZR3B+0Fa6iQwotZ0JIB1rRaxigNyrySSjV8CD4SIFdiCx06
         KGWyoD6HfKJ82RgYGfFzQNmHzViaOcPj6PlD2g2sIhnZlhaK4xxB9Tp7WYRRQXs+nCfn
         sOHqZW2GtkIFd785VacRijV/Uu+suBKGnUXs+Gs+ny7R3w/bjMgNkr1FvRZI+h2/HsvR
         LW8e3XtU5wVY6RqvEmHHTs16fExg73cTAYBBxA5FDt+56cJ/K7mTPce2iiWjdxRUJvnH
         bqvClhGC46+h+2Rp2cQf2jl86X7wIJrN4j26emaZCBi0cdzYFWwPOY7/JIdKSxg0L/T2
         m6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714757265; x=1715362065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILo3F4g6sqGLSNDOgBrfYgNSRthgJSy1s+0EPzQXChQ=;
        b=kWt/tHqR71AdvwjKeB+omkaZNpfH9DvqNsAcPEqyGXe0juHkZX5NI6jOXJiNWy2LZF
         zEVWLfDx9pZk8eKTUV+MasOrp0n3YD+itDTY3R5R7b3e1j7l134KhFC6AI75GDwTaxe9
         Wai3jjbBE2Iy+Wo2UXPAjCW1zTM8KT4FizCfufSWvah4kzcYgzfoLdcFZ/1yo7y0EBQc
         kfHVXlclSKPTOceo9tNzgHOBjHohocfCDZXy8LbHFw0IYuRBowcsHkKCjzb1fEUpKGFG
         wa6QY/EQTZrqVD4hVfuxm9Lr9LWGRzuflT0Ib1k2wd7WgKOafINACzW12H00cjz1+nES
         G3yg==
X-Gm-Message-State: AOJu0YwAuDH+/Az6CR4QO2VtkoX8RLQmjqQgq0dzTjY+e8wHfrnrAyWm
	CgC7eFVErRcSP45cxClAu7+m22HopYpBUh8TUOhsBCZk3IC4JPLdQm3eXA==
X-Google-Smtp-Source: AGHT+IHFaRdGXjaHrPr3Yj3pKvTUz0zkMmKajIMOJ9Hp/XIiCL/t25f5rRezS/+zhmWATlazXSgpOQ==
X-Received: by 2002:ac2:443c:0:b0:51d:33de:aaec with SMTP id w28-20020ac2443c000000b0051d33deaaecmr2738815lfl.8.1714757265014;
        Fri, 03 May 2024 10:27:45 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id fm9-20020a05600c0c0900b0041c23148330sm10004921wmb.10.2024.05.03.10.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 10:27:43 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>
Subject: [PATCH v3 3/3] build-many-glibcs.py: Add openrisc hard float glibc variant
Date: Fri,  3 May 2024 18:27:31 +0100
Message-ID: <20240503172731.675178-4-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503172731.675178-1-shorne@gmail.com>
References: <20240503172731.675178-1-shorne@gmail.com>
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

Reviewed-by: Adhemerval Zanella  <adhemerval.zanella@linaro.org>
---
Since v2:
 - No change
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

