Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660821638D
	for <linux-openrisc@vger.kernel.org>; Tue,  5 May 2026 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002186; cv=none; b=W0Y7Efqoxea0Ra/KJqhjL07ZVLDYISHAuV2jdUaPC6idRlPBsdPMKyy46O9uV69bGO63vumpV5++fRZmkjk7nxUiBMmx4mLJ5xfzDLyeOBcZrsTjSWTu0TpPYI1KrzJKT76UHmn32lsshKPwWPTzWlXea/PGzRnlUIWG0fFKMRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002186; c=relaxed/simple;
	bh=DlvkOUBq1EWRnsEHL/tlQgCSflFWn7V7hj56qKLfNDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMhnN4lQVFvkiuekYZ7tedX18Y/r+bDr3HIza3Fm0hZ0gRoZOSDh6fJ1DKzUJkOk2cTgOD8ekrMsLZcPJ/UO/2jdqkQiKzEB0IBExdokf8P7He8rxrp4xl0ZUDoFD/Hr66dZe+I0Ox9puKA3DJCy6oNiQsJ0d8FVoPabW1EcAXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNHvkxp7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNHvkxp7"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d64313c39so3919775f8f.3
        for <linux-openrisc@vger.kernel.org>; Tue, 05 May 2026 10:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778002184; x=1778606984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyaAkabMJvUFOvU8uLyog+hcEkYJAZfMRJ0zkLwucxQ=;
        b=FNHvkxp7A85Zz8+eSjlQAbkK4L0WGQxz2Se9YW3O4CxS7+tjNliLKMrchNrSDPH2xT
         5SYP9tbkHTVw3VBPyMPnx819DVVJFlw1ho8adgqHpNubsElzyEm8wnifkLY7y6BGQC2j
         m4EQA2P58yfZjhr8eDSLMSqXhTIte1xDzQyE95tRctOVkPhkoUKX2EDiaG5l6PnNZL0k
         rg/8Cb4CJPQTLJgw3yppfcTh4QVwNVhzwVqm22VMti73kHMbBxdZMqelWytlGXmdiH1I
         gNleqphPGoKzcBYGocNVWr81qfKnTudLAJdRiWxBXSEtT5saq6O/WAuPRJZpHygpBHm2
         p56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002184; x=1778606984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uyaAkabMJvUFOvU8uLyog+hcEkYJAZfMRJ0zkLwucxQ=;
        b=dZWWSU5ck8Ar2ermm9oz0bCWPmmBmU//eFnux9AdjpYs2hV9gAgEAnv6FUIw9c2x9x
         +dNnsiCbRYIn80b4E3DJlzmSE3V5L0eAPTn4egpG4Ots3auW1mtaUHevc4D2v5msImzn
         qAyDNXeRUmC8KZkA21yMnUZOK3oeLU+gcQm8N4pqwLo5tbcNDTsyeM6YHDxKlaJ7i35C
         j1Nb0FhZNppTbBzIFgpAU2X5dezQ9vzB3Gg1ZV3LXHiNt12PvGLCL+o51leKtqKrtAdn
         hP89QcTYtheJqJ88kSh2Y29eeSa72fhuvYJ1KcJclEEZlcHIxVyGVjmPdoR/nfKBaXLW
         IpFA==
X-Gm-Message-State: AOJu0YyaH+Ce/VY0JnpHUN4k++F/YGD3qRjuc048b0E7Ml91D+huu1GX
	8Kn9jfNiYmaYvQOB6b9JHTptwT3fEW5+4pj0lXJ4XCLxzsvod6kDENYf
X-Gm-Gg: AeBDievZzhSteck+M58Wfz32zezAyne2Di7vLui/f6LaQwOqRX73t1vc3W60oTcMHrT
	j/uZhCQvZktH3zPOPH502KfUZwbPERKXEgocaE0F757a67vP+IGRGG7CQDJxb+YChyjwAiZsiZ7
	L3vRkzwfFRbUNtt1xbZysx8yW2A3QqCizXOzq7Sgl+yMd4MmlxoYgsFMgfXvu7jSN/P4upEYUED
	aqM0Gnfpvg4jsyhP6yxbTofubazDE0xwO6fLGd1pGEN8jHC9Cx2K488Wy2QPmgdCBXlNdKpfnqL
	kuP/WgAg5IHwTpSyPYyGkx4QARtbf4Wkgww5m8kSdh1y2LWOQoBRBGaVErWoPj+W7RnlZSFRRmB
	Pec4Uxmqjh2yls29eW5P8c+ci7ofSSS9rLYQiwzIv5De/h2ys2GqfOAF3/kV2BYi+ysL4M7wNez
	xy6Me0zqlmhobV/h1kAVlxMiLhaSX5zNVKnPeN6vmTJA8DlWw9/8+Cb317ByyChRIgkXWJ2PKWZ
	5IKisH5qbAE0dz0
X-Received: by 2002:a5d:5f90:0:b0:44a:8c10:40dc with SMTP id ffacd0b85a97d-4515b9f3c74mr97263f8f.18.1778002183738;
        Tue, 05 May 2026 10:29:43 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960902sm6694853f8f.28.2026.05.05.10.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:29:41 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	stefanha@redhat.com,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/2] MAINTAINERS: Add myself as the OpenRISC virt maintainer
Date: Tue,  5 May 2026 18:29:26 +0100
Message-ID: <20260505172926.2235826-3-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505172926.2235826-1-shorne@gmail.com>
References: <20260505172926.2235826-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I defined the virt board but didn't realize there is a separate section
for listing boards in MAINTAINERS.  Add myself as maintainer.

Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44207949d7..e9807fe6c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1516,6 +1516,12 @@ F: hw/intc/ompic.c
 F: hw/or1k/or1k-sim.c
 F: tests/functional/or1k/test_sim.py
 
+virt
+M: Stafford Horne <shorne@gmail.com>
+S: Odd Fixes
+F: docs/system/or1k/virt.rst
+F: hw/or1k/virt.c
+
 PowerPC Machines
 ----------------
 Bamboo
-- 
2.53.0

