Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9434C626
	for <linux-openrisc@vger.kernel.org>; Tue, 19 Mar 2024 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710884576; cv=none; b=H28V5PI3wPwQneqZcZfGWYVpDPtJA/ZUOZeTGUgKA3I8mIhQhpb/VOZlxfEPuGlliTAh8mYOB0I1zs8A116RyXdbvhFpAbOYzBnga46iV9ygSHV+/W8p4/JgbJIwcQoqaPxtckyI0/C0UNUffsGe8yXax3hdpicakwpc5eoPST0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710884576; c=relaxed/simple;
	bh=rzGkCbNxNmfyMer+h/FPbJdKE393WxWFQlZfTTcNuio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXRwjkDwGNhqDag8dKPBiuIHq1UjM+wiasBofWrVtKdJyjUkE5ShQVah5spppwvwef+d6fjGjqqhCdiIm/Bb7lWNVi7xCSdMTWz7H6TR26gODEYZewxU4KWxhaHXFU6S0qVDO1QY2XOOjfi9E2eEE1cAmeVO+ZjfN7LxALT32Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7YfUePL; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7YfUePL"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34175878e3cso1525002f8f.0
        for <linux-openrisc@vger.kernel.org>; Tue, 19 Mar 2024 14:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710884573; x=1711489373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCdgl/DWJ2XjWent0NIObpJTy33XFQUHHm3ihhQ0Kg4=;
        b=b7YfUePL86wwxF+0rVLPpGoUewad7RcOLALgsklnTmnPe6FsJ2zemMAX6dhKfG+yOj
         h4efcjfdaYBvd+7yoIxe3FYVErIr3Ui+x9ZWLglFTmmx17l9FQ8Se3hYEB31BNqIxQVy
         a/0CDsIsBqS8SwsEzdNilE7y/+fzwR8RzC9H0WWd6ED27maYeHLrKSES/tFGJGH1+sWM
         99kEQdBR1Z8pn9NzsUO5D3XKU/7Pr8RnrgYYIqfNsmX2dOnCvKhZhOfIn9F1MeZ5txpw
         om+nXe3DKnjbj8mDQIwPR1BJFsA28w3qeYQuuK7CBSwMyexzkPEMmgGsCbuQ5ZrQOK4S
         3bDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710884573; x=1711489373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCdgl/DWJ2XjWent0NIObpJTy33XFQUHHm3ihhQ0Kg4=;
        b=TPS6Q6wT82m7BLxumIuO08vUSbpI99hbCpf+sQJSLAdLfoQlLxJDcP9/tEd7u54l2K
         opdVMj0F4kAHkr6SCpKYgcT/lEeJeF6vwEpoH+B0EmHuQPfy9EgbsliVBTUXVZouLOOv
         NrMgrTyoCD08oUPuh9vV2RwKzIEewOScULZo/lDXTOxKzGJpkLviWg0tpf6NDg75mXi9
         v5I4L8eoFCzLqu5EbmsAY7K4abnzV9EWe/JTbqaS6lBK0+iAgEeL2RPm76zvrOKuGW2w
         4NNUfsXM72492t1SAxQ+w5kakuYFcCEZYDTbzfHuiiJ+bKf0qWDKwiFkYVljUFLF3+J1
         adSg==
X-Gm-Message-State: AOJu0YzrF7pRQAfXeEByR4QLMDog8718pU007x/TDfpllhPZI3uGSPoT
	pUkjl2mYrRRobRLQiPTc1xuKQstCkjS/mSBMGZuTvxVNkWoFO4/C
X-Google-Smtp-Source: AGHT+IGAYy/a469CQ0niHTRyTQyAmosTgM7ojdV8A8NVbY66XjE2CtKx5RXjzJu2AmO2UO5ragyA7g==
X-Received: by 2002:a05:6000:12cb:b0:33e:ca35:9fe8 with SMTP id l11-20020a05600012cb00b0033eca359fe8mr197321wrx.19.1710884573399;
        Tue, 19 Mar 2024 14:42:53 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id bp2-20020a5d5a82000000b0033e43756d11sm10614604wrb.85.2024.03.19.14.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:42:52 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH 2/4] or1k: Update libm test ulps
Date: Tue, 19 Mar 2024 21:42:42 +0000
Message-ID: <20240319214244.736981-3-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319214244.736981-1-shorne@gmail.com>
References: <20240319214244.736981-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To fix test failures:

    FAIL: math/test-float-hypot
    FAIL: math/test-float32-hypot
---
 sysdeps/or1k/libm-test-ulps | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sysdeps/or1k/libm-test-ulps b/sysdeps/or1k/libm-test-ulps
index 94b383669d..785bae70d0 100644
--- a/sysdeps/or1k/libm-test-ulps
+++ b/sysdeps/or1k/libm-test-ulps
@@ -834,6 +834,7 @@ float: 6
 
 Function: "hypot":
 double: 1
+float: 1
 
 Function: "hypot_downward":
 double: 1
-- 
2.44.0

