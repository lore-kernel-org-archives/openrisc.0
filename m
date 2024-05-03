Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC96157E62
	for <linux-openrisc@vger.kernel.org>; Fri,  3 May 2024 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757264; cv=none; b=oFjPhIOSQGAttxOKr7AKUg1UFt0W34jzcn+kpdRRw9PLaGlVNjDcUQVJMdVDnXNB4xcIhoALptRlS/rs0OAEuxibbtBl/IHUwc/YiqOcmpF81OWkhIK8s0OrcSI+yPjn0BTRLJJqajHHhkcWJLgEaXatZbDec++AJbEAXjaRCr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757264; c=relaxed/simple;
	bh=9WKmzJ5a969ivD7r/i4iIZ/fpfAI5O9AbXb5FafNuRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cp1Dcok8FScsql/OumO2SOYoUb1/k5OaseIe1snr04Itaom5vMogChN/F41oubJU5vnzSKDo5/vjZknvfFzQntsqOBZzn0wjwShpyRhCt6gKVfuUgt8GD2SWs6TIj3InfpOpSbpNQowevjUNKZVhTLSfUK4YdXxdAXLzLQxarGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCAjAnU1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCAjAnU1"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41adf3580dbso19624965e9.0
        for <linux-openrisc@vger.kernel.org>; Fri, 03 May 2024 10:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714757260; x=1715362060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXfb6y8/Wc7xoBN3H7VsyzDYzQ2H0t7yiOJGu0gFZOw=;
        b=fCAjAnU1YNYjrwHT8nJjkdYlamS5Tm7bd1co5yS9CZmSVEQMRL22O15lNpbWgou+II
         10O7M9YJ3uduj5dm4nI0tjVY0YOHMmrTWceCRQj2EFWjcvW0KiN+6kA+UNCsEFazCUKu
         8Dmqmvu5xP9BlTpVHoXGet1f8Vc8QcB/v3MoR++ajdwnW1yU9mRifAjXDSM5LxCiR4H/
         /RpG/BaqMBTpYIxyapNGAvy9CwUTmV7/zw4BNBML6TGZiSQsspUvPaDI69nY5wQ1Nthp
         S9jvt7WjOmeYidZNngdgVvw9NKxbN6g+tmmdNNlqj7vI7ja1pmlB9ZurYoh1sp+Y3z1l
         u5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714757260; x=1715362060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXfb6y8/Wc7xoBN3H7VsyzDYzQ2H0t7yiOJGu0gFZOw=;
        b=au4t/A61+AaYPHp0Uhy+p9bVmFDIHlOk/ax0i49qpZfW4IWXTUFD2uAMlxudv+vLed
         rMxXyc43YPcUMsEtPIjjJ7bfMptq1y0KpPi0x+sBwzK7KERX9mzOlkItDmimeoLlRIyC
         E9movLq/nW3QUy6fc976xxt0/+bO+uz3Xw0mmNHo3nFwXa17fsmWUJ76ZY45QNBpjXTt
         BSTChejpbI31u4YFNqK5XUc7qb4uKEFQz19PsZt9N4StMz+Pzxs3487eEiYvb7eANv7y
         gZzaeKkxFDuGoDcHvLlOrzcyZ2mKrHa7h5pA6cL7VBa4riJYd71jZ9VKmHI54YgeybQS
         5qEw==
X-Gm-Message-State: AOJu0YyigF6GRQtwS+8uj3uy6PgbWqSFyjqDCSashyZdyb0RGE4LJfmV
	JfN28HDq/4kYn3esHKVZRmseO7B7v8b8stcGYnGT5m610NXSeon9
X-Google-Smtp-Source: AGHT+IGLhhlcfvbe5SUGkEDyqdMYaumUurbhQladXVJB0Y58zDnuPAu9NbQCfwJt6gLfu9XX/scKcQ==
X-Received: by 2002:a05:600c:1c83:b0:41a:4623:7ee9 with SMTP id k3-20020a05600c1c8300b0041a46237ee9mr5982069wms.10.1714757259620;
        Fri, 03 May 2024 10:27:39 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id bd23-20020a05600c1f1700b0041bfb176a87sm10104453wmb.27.2024.05.03.10.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 10:27:38 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>
Subject: [PATCH v3 1/3] or1k: Add hard float libm-test-ulps
Date: Fri,  3 May 2024 18:27:29 +0100
Message-ID: <20240503172731.675178-2-shorne@gmail.com>
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

This patch adds the ulps test file to prepare for the upcoming
hard float patch.  This is separated out to make the hard float patch
smaller.

Reviewed-by: Adhemerval Zanella  <adhemerval.zanella@linaro.org>
---
Since v2:
 - No change.
Since v1:
 - New patch split from 2/3.

 sysdeps/or1k/fpu/libm-test-ulps         | 1115 +++++++++++++++++++++++
 sysdeps/or1k/fpu/libm-test-ulps-name    |    1 +
 sysdeps/or1k/libm-test-ulps-name        |    1 -
 sysdeps/or1k/{ => nofpu}/libm-test-ulps |    0
 sysdeps/or1k/nofpu/libm-test-ulps-name  |    1 +
 5 files changed, 1117 insertions(+), 1 deletion(-)
 create mode 100644 sysdeps/or1k/fpu/libm-test-ulps
 create mode 100644 sysdeps/or1k/fpu/libm-test-ulps-name
 delete mode 100644 sysdeps/or1k/libm-test-ulps-name
 rename sysdeps/or1k/{ => nofpu}/libm-test-ulps (100%)
 create mode 100644 sysdeps/or1k/nofpu/libm-test-ulps-name

diff --git a/sysdeps/or1k/fpu/libm-test-ulps b/sysdeps/or1k/fpu/libm-test-ulps
new file mode 100644
index 0000000000..948ec01cdc
--- /dev/null
+++ b/sysdeps/or1k/fpu/libm-test-ulps
@@ -0,0 +1,1115 @@
+# Begin of automatic generation
+
+# Maximal error of functions:
+Function: "acos":
+double: 1
+float: 1
+
+Function: "acos_downward":
+double: 1
+float: 1
+
+Function: "acos_towardzero":
+double: 1
+float: 1
+
+Function: "acos_upward":
+double: 1
+float: 1
+
+Function: "acosh":
+double: 2
+float: 2
+
+Function: "acosh_downward":
+double: 2
+float: 2
+
+Function: "acosh_towardzero":
+double: 2
+float: 2
+
+Function: "acosh_upward":
+double: 2
+float: 2
+
+Function: "asin":
+double: 1
+float: 1
+
+Function: "asin_downward":
+double: 1
+float: 1
+
+Function: "asin_towardzero":
+double: 1
+float: 1
+
+Function: "asin_upward":
+double: 2
+float: 1
+
+Function: "asinh":
+double: 2
+float: 2
+
+Function: "asinh_downward":
+double: 3
+float: 3
+
+Function: "asinh_towardzero":
+double: 2
+float: 2
+
+Function: "asinh_upward":
+double: 3
+float: 3
+
+Function: "atan":
+double: 1
+float: 1
+
+Function: "atan2":
+float: 2
+
+Function: "atan2_downward":
+double: 5
+float: 2
+
+Function: "atan2_towardzero":
+double: 5
+float: 2
+
+Function: "atan2_upward":
+double: 8
+float: 2
+
+Function: "atan_downward":
+double: 1
+float: 2
+
+Function: "atan_towardzero":
+double: 1
+float: 1
+
+Function: "atan_upward":
+double: 1
+float: 2
+
+Function: "atanh":
+double: 2
+float: 2
+
+Function: "atanh_downward":
+double: 3
+float: 3
+
+Function: "atanh_towardzero":
+double: 2
+float: 2
+
+Function: "atanh_upward":
+double: 3
+float: 3
+
+Function: "cabs":
+double: 1
+
+Function: "cabs_downward":
+double: 1
+
+Function: "cabs_towardzero":
+double: 1
+
+Function: "cabs_upward":
+double: 1
+
+Function: Real part of "cacos":
+double: 1
+float: 2
+
+Function: Imaginary part of "cacos":
+double: 2
+float: 2
+
+Function: Real part of "cacos_downward":
+double: 3
+float: 2
+
+Function: Imaginary part of "cacos_downward":
+double: 5
+float: 3
+
+Function: Real part of "cacos_towardzero":
+double: 3
+float: 2
+
+Function: Imaginary part of "cacos_towardzero":
+double: 4
+float: 2
+
+Function: Real part of "cacos_upward":
+double: 2
+float: 2
+
+Function: Imaginary part of "cacos_upward":
+double: 5
+float: 7
+
+Function: Real part of "cacosh":
+double: 2
+float: 2
+
+Function: Imaginary part of "cacosh":
+double: 1
+float: 2
+
+Function: Real part of "cacosh_downward":
+double: 4
+float: 2
+
+Function: Imaginary part of "cacosh_downward":
+double: 3
+float: 3
+
+Function: Real part of "cacosh_towardzero":
+double: 4
+float: 2
+
+Function: Imaginary part of "cacosh_towardzero":
+double: 3
+float: 2
+
+Function: Real part of "cacosh_upward":
+double: 4
+float: 3
+
+Function: Imaginary part of "cacosh_upward":
+double: 3
+float: 2
+
+Function: "carg":
+float: 1
+
+Function: "carg_downward":
+double: 5
+float: 2
+
+Function: "carg_towardzero":
+double: 5
+float: 2
+
+Function: "carg_upward":
+double: 8
+float: 2
+
+Function: Real part of "casin":
+double: 1
+float: 1
+
+Function: Imaginary part of "casin":
+double: 2
+float: 2
+
+Function: Real part of "casin_downward":
+double: 3
+float: 2
+
+Function: Imaginary part of "casin_downward":
+double: 5
+float: 3
+
+Function: Real part of "casin_towardzero":
+double: 3
+float: 1
+
+Function: Imaginary part of "casin_towardzero":
+double: 4
+float: 2
+
+Function: Real part of "casin_upward":
+double: 3
+float: 2
+
+Function: Imaginary part of "casin_upward":
+double: 5
+float: 7
+
+Function: Real part of "casinh":
+double: 2
+float: 2
+
+Function: Imaginary part of "casinh":
+double: 1
+float: 1
+
+Function: Real part of "casinh_downward":
+double: 5
+float: 3
+
+Function: Imaginary part of "casinh_downward":
+double: 3
+float: 2
+
+Function: Real part of "casinh_towardzero":
+double: 4
+float: 2
+
+Function: Imaginary part of "casinh_towardzero":
+double: 3
+float: 1
+
+Function: Real part of "casinh_upward":
+double: 5
+float: 7
+
+Function: Imaginary part of "casinh_upward":
+double: 3
+float: 2
+
+Function: Real part of "catan":
+double: 1
+float: 1
+
+Function: Imaginary part of "catan":
+double: 1
+float: 1
+
+Function: Real part of "catan_downward":
+double: 1
+float: 2
+
+Function: Imaginary part of "catan_downward":
+double: 2
+float: 2
+
+Function: Real part of "catan_towardzero":
+double: 1
+float: 2
+
+Function: Imaginary part of "catan_towardzero":
+double: 2
+float: 2
+
+Function: Real part of "catan_upward":
+double: 2
+float: 1
+
+Function: Imaginary part of "catan_upward":
+double: 2
+float: 2
+
+Function: Real part of "catanh":
+double: 1
+float: 1
+
+Function: Imaginary part of "catanh":
+double: 1
+float: 1
+
+Function: Real part of "catanh_downward":
+double: 2
+float: 2
+
+Function: Imaginary part of "catanh_downward":
+double: 1
+float: 2
+
+Function: Real part of "catanh_towardzero":
+double: 2
+float: 2
+
+Function: Imaginary part of "catanh_towardzero":
+double: 1
+float: 2
+
+Function: Real part of "catanh_upward":
+double: 4
+float: 4
+
+Function: Imaginary part of "catanh_upward":
+double: 2
+float: 1
+
+Function: "cbrt":
+double: 4
+float: 1
+
+Function: "cbrt_downward":
+double: 4
+float: 1
+
+Function: "cbrt_towardzero":
+double: 3
+float: 1
+
+Function: "cbrt_upward":
+double: 5
+float: 1
+
+Function: Real part of "ccos":
+double: 1
+float: 1
+
+Function: Imaginary part of "ccos":
+double: 1
+float: 1
+
+Function: Real part of "ccos_downward":
+double: 3
+float: 1
+
+Function: Imaginary part of "ccos_downward":
+double: 3
+float: 3
+
+Function: Real part of "ccos_towardzero":
+double: 3
+float: 2
+
+Function: Imaginary part of "ccos_towardzero":
+double: 3
+float: 3
+
+Function: Real part of "ccos_upward":
+double: 1
+float: 2
+
+Function: Imaginary part of "ccos_upward":
+double: 2
+float: 2
+
+Function: Real part of "ccosh":
+double: 2
+float: 1
+
+Function: Imaginary part of "ccosh":
+double: 1
+float: 1
+
+Function: Real part of "ccosh_downward":
+double: 3
+float: 2
+
+Function: Imaginary part of "ccosh_downward":
+double: 3
+float: 3
+
+Function: Real part of "ccosh_towardzero":
+double: 3
+float: 3
+
+Function: Imaginary part of "ccosh_towardzero":
+double: 3
+float: 3
+
+Function: Real part of "ccosh_upward":
+double: 1
+float: 2
+
+Function: Imaginary part of "ccosh_upward":
+double: 2
+float: 2
+
+Function: Real part of "cexp":
+double: 2
+float: 1
+
+Function: Imaginary part of "cexp":
+double: 1
+float: 2
+
+Function: Real part of "cexp_downward":
+double: 4
+float: 2
+
+Function: Imaginary part of "cexp_downward":
+double: 3
+float: 3
+
+Function: Real part of "cexp_towardzero":
+double: 4
+float: 2
+
+Function: Imaginary part of "cexp_towardzero":
+double: 3
+float: 3
+
+Function: Real part of "cexp_upward":
+double: 2
+float: 2
+
+Function: Imaginary part of "cexp_upward":
+double: 3
+float: 2
+
+Function: Real part of "clog":
+double: 3
+float: 3
+
+Function: Imaginary part of "clog":
+double: 1
+float: 1
+
+Function: Real part of "clog10":
+double: 3
+float: 4
+
+Function: Imaginary part of "clog10":
+double: 2
+float: 2
+
+Function: Real part of "clog10_downward":
+double: 7
+float: 5
+
+Function: Imaginary part of "clog10_downward":
+double: 8
+float: 4
+
+Function: Real part of "clog10_towardzero":
+double: 5
+float: 5
+
+Function: Imaginary part of "clog10_towardzero":
+double: 8
+float: 4
+
+Function: Real part of "clog10_upward":
+double: 6
+float: 5
+
+Function: Imaginary part of "clog10_upward":
+double: 5
+float: 4
+
+Function: Real part of "clog_downward":
+double: 4
+float: 3
+
+Function: Imaginary part of "clog_downward":
+double: 5
+float: 2
+
+Function: Real part of "clog_towardzero":
+double: 8
+float: 4
+
+Function: Imaginary part of "clog_towardzero":
+double: 5
+float: 3
+
+Function: Real part of "clog_upward":
+double: 8
+float: 3
+
+Function: Imaginary part of "clog_upward":
+double: 8
+float: 2
+
+Function: "cos":
+double: 1
+float: 1
+
+Function: "cos_downward":
+double: 1
+float: 1
+
+Function: "cos_towardzero":
+double: 4
+float: 1
+
+Function: "cos_upward":
+double: 4
+float: 1
+
+Function: "cosh":
+double: 2
+float: 2
+
+Function: "cosh_downward":
+double: 3
+float: 1
+
+Function: "cosh_towardzero":
+double: 3
+float: 1
+
+Function: "cosh_upward":
+double: 2
+float: 2
+
+Function: Real part of "cpow":
+double: 2
+float: 5
+
+Function: Imaginary part of "cpow":
+float: 2
+
+Function: Real part of "cpow_downward":
+double: 5
+float: 8
+
+Function: Imaginary part of "cpow_downward":
+double: 2
+float: 2
+
+Function: Real part of "cpow_towardzero":
+double: 5
+float: 8
+
+Function: Imaginary part of "cpow_towardzero":
+double: 2
+float: 2
+
+Function: Real part of "cpow_upward":
+double: 4
+float: 1
+
+Function: Imaginary part of "cpow_upward":
+double: 2
+float: 2
+
+Function: Real part of "csin":
+double: 1
+float: 1
+
+Function: Real part of "csin_downward":
+double: 3
+float: 3
+
+Function: Imaginary part of "csin_downward":
+double: 3
+float: 1
+
+Function: Real part of "csin_towardzero":
+double: 3
+float: 3
+
+Function: Imaginary part of "csin_towardzero":
+double: 3
+float: 1
+
+Function: Real part of "csin_upward":
+double: 2
+float: 2
+
+Function: Imaginary part of "csin_upward":
+double: 1
+float: 2
+
+Function: Real part of "csinh":
+float: 1
+
+Function: Imaginary part of "csinh":
+double: 1
+float: 1
+
+Function: Real part of "csinh_downward":
+double: 3
+float: 1
+
+Function: Imaginary part of "csinh_downward":
+double: 3
+float: 3
+
+Function: Real part of "csinh_towardzero":
+double: 3
+float: 2
+
+Function: Imaginary part of "csinh_towardzero":
+double: 3
+float: 3
+
+Function: Real part of "csinh_upward":
+double: 1
+float: 2
+
+Function: Imaginary part of "csinh_upward":
+double: 2
+float: 2
+
+Function: Real part of "csqrt":
+double: 2
+float: 2
+
+Function: Imaginary part of "csqrt":
+double: 2
+float: 2
+
+Function: Real part of "csqrt_downward":
+double: 5
+float: 4
+
+Function: Imaginary part of "csqrt_downward":
+double: 4
+float: 3
+
+Function: Real part of "csqrt_towardzero":
+double: 4
+float: 3
+
+Function: Imaginary part of "csqrt_towardzero":
+double: 4
+float: 3
+
+Function: Real part of "csqrt_upward":
+double: 5
+float: 4
+
+Function: Imaginary part of "csqrt_upward":
+double: 3
+float: 3
+
+Function: Real part of "ctan":
+double: 1
+float: 1
+
+Function: Imaginary part of "ctan":
+double: 2
+float: 2
+
+Function: Real part of "ctan_downward":
+double: 6
+float: 5
+
+Function: Imaginary part of "ctan_downward":
+double: 3
+float: 2
+
+Function: Real part of "ctan_towardzero":
+double: 5
+float: 3
+
+Function: Imaginary part of "ctan_towardzero":
+double: 3
+float: 2
+
+Function: Real part of "ctan_upward":
+double: 2
+float: 4
+
+Function: Imaginary part of "ctan_upward":
+double: 2
+float: 1
+
+Function: Real part of "ctanh":
+double: 2
+float: 2
+
+Function: Imaginary part of "ctanh":
+double: 2
+float: 2
+
+Function: Real part of "ctanh_downward":
+double: 3
+float: 2
+
+Function: Imaginary part of "ctanh_downward":
+double: 6
+float: 5
+
+Function: Real part of "ctanh_towardzero":
+double: 3
+float: 2
+
+Function: Imaginary part of "ctanh_towardzero":
+double: 5
+float: 3
+
+Function: Real part of "ctanh_upward":
+double: 2
+float: 2
+
+Function: Imaginary part of "ctanh_upward":
+double: 2
+float: 3
+
+Function: "erf":
+double: 1
+float: 1
+
+Function: "erf_downward":
+double: 1
+float: 1
+
+Function: "erf_towardzero":
+double: 1
+float: 1
+
+Function: "erf_upward":
+double: 1
+float: 1
+
+Function: "erfc":
+double: 5
+float: 3
+
+Function: "erfc_downward":
+double: 5
+float: 6
+
+Function: "erfc_towardzero":
+double: 3
+float: 4
+
+Function: "erfc_upward":
+double: 5
+float: 6
+
+Function: "exp":
+double: 1
+float: 1
+
+Function: "exp10":
+double: 2
+float: 1
+
+Function: "exp10_downward":
+double: 3
+float: 1
+
+Function: "exp10_towardzero":
+double: 3
+float: 1
+
+Function: "exp10_upward":
+double: 2
+float: 1
+
+Function: "exp2":
+double: 1
+
+Function: "exp2_downward":
+double: 1
+
+Function: "exp2_towardzero":
+double: 1
+
+Function: "exp2_upward":
+double: 1
+float: 1
+
+Function: "exp_downward":
+double: 1
+float: 1
+
+Function: "exp_towardzero":
+double: 1
+float: 1
+
+Function: "exp_upward":
+double: 1
+float: 1
+
+Function: "expm1":
+double: 1
+float: 1
+
+Function: "expm1_downward":
+double: 1
+float: 1
+
+Function: "expm1_towardzero":
+double: 1
+float: 2
+
+Function: "expm1_upward":
+double: 1
+float: 1
+
+Function: "gamma":
+double: 4
+float: 7
+
+Function: "gamma_downward":
+double: 7
+float: 7
+
+Function: "gamma_towardzero":
+double: 7
+float: 7
+
+Function: "gamma_upward":
+double: 5
+float: 6
+
+Function: "hypot":
+double: 1
+float: 1
+
+Function: "hypot_downward":
+double: 1
+
+Function: "hypot_towardzero":
+double: 1
+
+Function: "hypot_upward":
+double: 1
+
+Function: "j0":
+double: 2
+float: 9
+
+Function: "j0_downward":
+double: 5
+float: 9
+
+Function: "j0_towardzero":
+double: 6
+float: 9
+
+Function: "j0_upward":
+double: 9
+float: 9
+
+Function: "j1":
+double: 4
+float: 9
+
+Function: "j1_downward":
+double: 5
+float: 8
+
+Function: "j1_towardzero":
+double: 4
+float: 8
+
+Function: "j1_upward":
+double: 9
+float: 9
+
+Function: "jn":
+double: 4
+float: 4
+
+Function: "jn_downward":
+double: 7
+float: 9
+
+Function: "jn_towardzero":
+double: 7
+float: 9
+
+Function: "jn_upward":
+double: 7
+float: 9
+
+Function: "lgamma":
+double: 4
+float: 7
+
+Function: "lgamma_downward":
+double: 7
+float: 7
+
+Function: "lgamma_towardzero":
+double: 7
+float: 7
+
+Function: "lgamma_upward":
+double: 5
+float: 6
+
+Function: "log10":
+double: 2
+float: 2
+
+Function: "log10_downward":
+double: 2
+float: 3
+
+Function: "log10_towardzero":
+double: 2
+float: 1
+
+Function: "log10_upward":
+double: 2
+float: 2
+
+Function: "log1p":
+double: 1
+float: 1
+
+Function: "log1p_downward":
+double: 2
+float: 2
+
+Function: "log1p_towardzero":
+double: 2
+float: 2
+
+Function: "log1p_upward":
+double: 2
+float: 2
+
+Function: "log2":
+float: 1
+
+Function: "log2_downward":
+double: 1
+
+Function: "log2_towardzero":
+double: 1
+
+Function: "log2_upward":
+double: 1
+
+Function: "pow":
+double: 1
+
+Function: "pow_downward":
+double: 1
+float: 1
+
+Function: "pow_towardzero":
+double: 1
+float: 1
+
+Function: "pow_upward":
+double: 1
+float: 1
+
+Function: "sin":
+double: 1
+float: 1
+
+Function: "sin_downward":
+double: 4
+float: 1
+
+Function: "sin_towardzero":
+double: 3
+float: 1
+
+Function: "sin_upward":
+double: 7
+float: 1
+
+Function: "sincos":
+double: 1
+
+Function: "sincos_downward":
+double: 1
+float: 1
+
+Function: "sincos_towardzero":
+double: 4
+float: 1
+
+Function: "sincos_upward":
+double: 1
+float: 1
+
+Function: "sinh":
+double: 2
+float: 2
+
+Function: "sinh_downward":
+double: 3
+float: 3
+
+Function: "sinh_towardzero":
+double: 3
+float: 2
+
+Function: "sinh_upward":
+double: 3
+float: 3
+
+Function: "tan":
+float: 1
+
+Function: "tan_downward":
+double: 1
+float: 2
+
+Function: "tan_towardzero":
+double: 1
+float: 1
+
+Function: "tan_upward":
+double: 1
+float: 1
+
+Function: "tanh":
+double: 2
+float: 2
+
+Function: "tanh_downward":
+double: 3
+float: 3
+
+Function: "tanh_towardzero":
+double: 2
+float: 2
+
+Function: "tanh_upward":
+double: 3
+float: 3
+
+Function: "tgamma":
+double: 9
+float: 8
+
+Function: "tgamma_downward":
+double: 9
+float: 9
+
+Function: "tgamma_towardzero":
+double: 9
+float: 8
+
+Function: "tgamma_upward":
+double: 9
+float: 8
+
+Function: "y0":
+double: 3
+float: 9
+
+Function: "y0_downward":
+double: 3
+float: 9
+
+Function: "y0_towardzero":
+double: 4
+float: 9
+
+Function: "y0_upward":
+double: 3
+float: 9
+
+Function: "y1":
+double: 3
+float: 9
+
+Function: "y1_downward":
+double: 6
+float: 9
+
+Function: "y1_towardzero":
+double: 3
+float: 9
+
+Function: "y1_upward":
+double: 7
+float: 9
+
+Function: "yn":
+double: 3
+float: 3
+
+Function: "yn_downward":
+double: 6
+float: 8
+
+Function: "yn_towardzero":
+double: 8
+float: 8
+
+Function: "yn_upward":
+double: 8
+float: 8
+
+# end of automatic generation
diff --git a/sysdeps/or1k/fpu/libm-test-ulps-name b/sysdeps/or1k/fpu/libm-test-ulps-name
new file mode 100644
index 0000000000..7f72f7a873
--- /dev/null
+++ b/sysdeps/or1k/fpu/libm-test-ulps-name
@@ -0,0 +1 @@
+OpenRISC hard-float
diff --git a/sysdeps/or1k/libm-test-ulps-name b/sysdeps/or1k/libm-test-ulps-name
deleted file mode 100644
index 0af6591fd9..0000000000
--- a/sysdeps/or1k/libm-test-ulps-name
+++ /dev/null
@@ -1 +0,0 @@
-OpenRISC
diff --git a/sysdeps/or1k/libm-test-ulps b/sysdeps/or1k/nofpu/libm-test-ulps
similarity index 100%
rename from sysdeps/or1k/libm-test-ulps
rename to sysdeps/or1k/nofpu/libm-test-ulps
diff --git a/sysdeps/or1k/nofpu/libm-test-ulps-name b/sysdeps/or1k/nofpu/libm-test-ulps-name
new file mode 100644
index 0000000000..76c66a0e53
--- /dev/null
+++ b/sysdeps/or1k/nofpu/libm-test-ulps-name
@@ -0,0 +1 @@
+OpenRISC soft-float
-- 
2.44.0

