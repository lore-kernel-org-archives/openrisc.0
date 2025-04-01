Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C2820485F;
	Tue,  1 Apr 2025 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743537701; cv=none; b=uFopo9TmdzEq0460ne8ASIFx5xFzjd/zD0lyrHpPLN06ij8otiYqFQL9+pwj55YAAGchgiV34dEuDWcP+98RciL8Rw+iSqLMciPSdJHdC6iGkdUrrbJl2J1HY9Gla2zZJw+v2xYXsvrwqgJF/cp34fcd0Q/ZEZ3OERc8RabbK0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743537701; c=relaxed/simple;
	bh=n6u/2N9sdpiROP8kWcaGNWdcS2RLVXVmRUPoRNVjrqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ecKtvm+A+uFbHIbIRrHKoWzk4cSNmBdVKc+p1yc8aeLYnDqGQVy6pICOj8DXKuro6RMh3LIY+PJzJIHtRXXjFfKyRl9qNONnKsDKNCy4QMGsdSxIoCXqhejqnHYLLp4b/8QzN2IkABYGgHZToMK8s7oG+4s+abkcehlJYi+yPEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEHjj/bx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEHjj/bx"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-227a8cdd241so28190575ad.3;
        Tue, 01 Apr 2025 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743537699; x=1744142499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6a7A3LUOsk4GLO9veKSbe03f/1tHGnsxYKTsgj1e9AQ=;
        b=GEHjj/bxJgjswD4CbznNj3y+Wu2jNNEpHwTETA8W5T8o9DIwbh1Keu4RPRTwxwaxYI
         00KtcPOfEfOH6x8boHCbxkpoEHkUtbdDRZi3Zq42IPYV77wWd7LxDhimmkyiXUfx2Syi
         F2COchDI5Szj2XTQ7Os1QscCEcPMPojF19/+NpBz8UViYOgs4ZEGI6hJgFNzKFNanD+Q
         yn1lMtl1lIsXNO9Kn9uLxy2agMUpB0dTt3XZhYK9dbCq/FSqk5Mgv8j1NMeiGua3BL6v
         CqEERHGy4M7bNfwYyB0VXH1d5yhbNr2H5kmXgWZct2baoiv6bEodZu21Cj711mtSbV+Y
         0sGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743537699; x=1744142499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6a7A3LUOsk4GLO9veKSbe03f/1tHGnsxYKTsgj1e9AQ=;
        b=KDR3kyZaueQzMayC70qDv3FEYCvX0wkK9w1EaFy6FmRu/TUY+UK0z6nLCRmfZYtqV2
         a8dG+J86bP/MmV+9wctacMnC8F/uBeDOXGPKgcpQcCo7LV8U686inxs7P4/tFyiIrBoh
         dhkKqbFn8EvjNwSmCjFq4NcMJfWXPnbjIbII/NdIar2i+BxGhqVBoISRM1BzPSVB/XcJ
         YwAveu8me2OF6dRc1BqanBWy8ZXF2nHJnUrMNO5OiQ6Z5YNmym8mpSqFDhTX2MM4H8RA
         gfzAvYzEJ6ZwS3gbPXsX6T/5aAuwWmuTyPq/h4C0lyqxpQrQSkkgvWmQhj5m/isoYxgm
         EBOg==
X-Forwarded-Encrypted: i=1; AJvYcCUNat3/y7av6V/XRu6JSjaFHTSdHbPlwzvEaSLznwZMm3I7XXMpENWgZ6XUIcXFODFdMkUt+83BfF8jFAY=@vger.kernel.org, AJvYcCV4NaxmoNJ7poI9qA5SFBbaCOhOG2S5OiXANPl/vBSq1xkT4YLpHO5vb1uhqf3jJvnLDKxtG4OtChSz3sVitYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfS4m9z9UyixcrwPV0Qck1reUAd3l1eGUlZlwm6dyLr3ZYUrsH
	DKtnkPA5gf+rEHU7zPlIo0da46Z2qEV4WXEdio1a56ChhapoqGrw
X-Gm-Gg: ASbGnctDmNhfp2K8ZNc+qRtZaPJ980M1qvcKFzwcmH+b+h1eorhdTVlMoeVyN5btIT7
	KtRL0CZjZBgKHJB0KjLrFEySLdvoE2Hj6nqACTbuIAlJkMi+8l3Hk2otWTT8FqOdBxDqPtvWOtu
	9NJ9fjcRSX8WSdiEWLm8JzVHvK1r+8eg8e85/axT+IKi2DXW5y2gyyKJc739q0U9gqEDYd7gc+A
	Lf/C6Gl2N5BG4AgNuNcsy0sqsz69JC4pc2aUuVVoUyAChKBaMqcgh5SVbVZx3dvYRo1hEeA93Jm
	tB6o6cT1gabmgEByyLrLn1CyFNmoHnArty9i4UPiuIvl1T0=
X-Google-Smtp-Source: AGHT+IG23oi8g7sj+7nWe/W3KFfo2Q2tVEadmN3izEtk8fXXMPL+eB5DbyBV84grww8W6IYec08kyQ==
X-Received: by 2002:a17:903:120c:b0:220:cd9a:a167 with SMTP id d9443c01a7336-2292f942c16mr235677215ad.4.1743537699122;
        Tue, 01 Apr 2025 13:01:39 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c44:e4e:6e69:d5cb:5b5a:ea6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1f818csm92949965ad.233.2025.04.01.13.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 13:01:38 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: sahilcdq@proton.me,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] openrisc: Fix build warning in cache.c
Date: Wed,  2 Apr 2025 01:31:29 +0530
Message-ID: <20250401200129.287769-1-sahilcdq@proton.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c5c6fd8be51207f0abd3 ("openrisc: Introduce new utility functions
to flush and invalidate caches") introduced new functions to flush or
invalidate a range of addresses. These functions make use of the mtspr
macro.

The kernel test robot reported an asm constraint-related warning and
error related to the usage of mtspr in these functions. This is because
the compiler is unable to verify that the constraints are not breached
by functions which call cache_loop_page().

Make cache_loop_page() inline so that the compiler can verify the
constraints of the operands used in mtspr.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503311807.BZaUHY5L-lkp@intel.com/
Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
Hi,

I noticed that the previous patches have already been merged in the
for-next branch of openrisc's repo. So, I thought I would send a separate
patch to fix this.

I managed to reproduce the warning and error using or1k-linux-gcc 13.3
following the instructions found here [1]. The issue is not with the usage
of unsigned int in place of unsigned short. I tried replacing int with
short but that didn't work either. Apart from this, I see there are no
issues with mfspr even though this uses unsigned long for the register
"ret" and for the immediate value "add".

Also, from the gcc manual [2]:

> The compiler cannot check whether the operands have data types that are
> reasonable for the instruction being executed.

I am not sure if the above is just for output operands or all operands.

In mtspr, __spr is constrained to be an immediate value. I noticed that
all calls to mtspr (except for the ones called via cache_loop_page())
have the value of __spr evaluated to a constant at compile time. However,
the compiler is unable to determine if the constraints of the operands
are violated when mtspr is called via cache_loop_page(). Making
cache_loop_page() __always_inline solves this problem since this results
in the value of __spr being evaluated before compilation is completed.

This warning/error can also be observed for mfspr by changing its
prototype to:

__attribute__((__noinline__))
static unsigned long mfspr(unsigned long add) {...}

The compiler did not throw any other warnings/errors on my machine.

Thanks,
Sahil

[1] https://download.01.org/0day-ci/archive/20250331/202503311807.BZaUHY5L-lkp@intel.com/reproduce
[2] https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Output-Operands

 arch/openrisc/mm/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/mm/cache.c b/arch/openrisc/mm/cache.c
index 7bdd07cfca60..0216d65e6f86 100644
--- a/arch/openrisc/mm/cache.c
+++ b/arch/openrisc/mm/cache.c
@@ -40,7 +40,7 @@ static __always_inline void cache_loop(unsigned long paddr, unsigned long end,
 	}
 }
 
-static void cache_loop_page(struct page *page, const unsigned int reg,
+static __always_inline void cache_loop_page(struct page *page, const unsigned int reg,
 					    const unsigned int cache_type)
 {
 	unsigned long paddr = page_to_pfn(page) << PAGE_SHIFT;
-- 
2.48.1

