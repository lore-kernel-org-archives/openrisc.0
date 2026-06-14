Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCB51F91F6
	for <linux-openrisc@vger.kernel.org>; Sun, 14 Jun 2026 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781467084; cv=none; b=KzRxRzz42IJHBiSOdZe8tkvZJKIh6CORwaS0rsLunI9VuyB30U1NbOBvjcFtyvZgZPgWthnNJtpIVqNgc1Jit9WSneTGr5h7deNnJkfqVwO6FB4sp1zhpw2FZSxscqRd2mOVICcCWSi5mTaJHwli2zrKyZ7lJYRxm8L0fpcE6NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781467084; c=relaxed/simple;
	bh=ezbhlo7hFMx4si1POh1HrPPX19ql4RK5cEjXbttekVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M63uJBMqiJ1qddANf1JnBaIo/sLiHT5fnLwIl6lJNBz0Io4Hj8uE7Pr3U6DIMiGt/EAQxutE1N3PwEhnYgFO8Syo9i1sPQlLIRHsXTiBwQ9y8kHNcE4QC5QAoh+CATUMZvDUwn9H9LQ1tfhrx3nlBtGG6XBRirs1noC3PmtuOdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hH1rtZSw; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hH1rtZSw"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso1677740a91.0
        for <linux-openrisc@vger.kernel.org>; Sun, 14 Jun 2026 12:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781467082; x=1782071882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YGL+jmZh6/w96+7JsNV5y8DbTOJz2qyWO10SLl9MbFw=;
        b=hH1rtZSwTZ66ahHUUOmeh3UuYpzZpB1fEgq3eGMN55fkD6BD18hbmK9jdIsVYHSB3O
         JXFsvLrvW+RLNW+biPfJ8Ey4AfpIl6+af9ZwCZT8Zl6OgevkRc3zwCylydDqpJARF1Aa
         laROuHByD88hovBgRR6oQD8sLqTdB1TwWg8IFHneRynH/+I09IxO/UgNbS+kmS9YQzcF
         tvEvui0mN5vFqedpm67OtKQv/xqECR8Hpv/ayl0CMbKJXX9J9NqB8Uv3WwO8XEoJXlfT
         EE+DJAmhb84f0swEi6BwxT45jMt9Tt2pL3TEjxDQCC8Pbr9avb8XnkeVaEF8I8ejjY/V
         i+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781467082; x=1782071882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGL+jmZh6/w96+7JsNV5y8DbTOJz2qyWO10SLl9MbFw=;
        b=PlUeGS4IwsKr9U5F5C89/0oNd+nzAmezYUJI/8xCxzUQw7h3INFzskOR7VDdw1qu7r
         ba6ga3oYH7njtgjhvLAA9SjIpOaeJ49uXx0v3etatpqljTMAXFtyFmYE1X/sbe2gevIT
         rQY+cK6Mp3Za8N4bgm7DnJByDEYkUbGwzP7n1VyPx+wr61EtDl4709Yvo74WOo2wbRiO
         5GqkH1Gf8FvpI/OkVSB+HExBUTJNJ7CCRETOdUbKyK5wWdcS6C5Bksp5j0rg6SGkPamc
         wikVkX1rCSAxyAn2qNfwCiqFwOA63zBeYcDo/RJkFVv04Mo/efizRy0qN1yOWM6nvlQL
         0bqw==
X-Gm-Message-State: AOJu0YyeBc6tg9ltDl2P9kWqObvhBHs7Wqkja0p1/OBcfES3S8ZrNvY1
	YI1w7KLS92edaPc1wc3steT1B01vaxbBdbivOVfrF6Au7ufjFcE10Mtr
X-Gm-Gg: Acq92OHT7wmZuVYG7t1Rp6CSkRZOZlUGa0kRJC9/tIg6IGLM+EQaTA+hpRAcPE/SkvD
	YTx1PWq1pIMBQ6KW1vVAHcwKjR2NOt7UVUUVjxSa+PRn4qt+cm+sJ26hJSiaYe5qjo9NOFR/hJg
	99vaCCffc6NFkufeKcWL/cp70cpP6bHOgziQzYs616TWTnSnwRsxcHVxC2avU+gAs6LdpeWyUdb
	86rpKvBzRlbgXSOErECZedm9swoykIposWt5TdHYuyJkd7w8lU7XU7uJdAJdgxHOzPVZ3VnnbTb
	Y6quuqW4PtsVhUW7Pw8wBCTllOrCwmHQAL2dDO8oQn/TSwQJ0JzQJXdXVsIVMc/rZEcvnELE99K
	w91OJeqPuu2gKcdWfZdm2Xkr8g4xXiqAAt7ViCB3R/JubZLb8+20z1ONY+TCxJrJeWBdlQqKB4q
	YoyrbUNkVsxLOllCxED2B+0i5Uy8bivvMVtmZMYCw5MYM8
X-Received: by 2002:a17:90a:d004:b0:36d:649a:39f7 with SMTP id 98e67ed59e1d1-37a03ec2584mr11831203a91.22.1781467081920;
        Sun, 14 Jun 2026 12:58:01 -0700 (PDT)
Received: from LAPTOP-TMVMP5FD.localdomain ([223.235.128.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a212a920asm10124942a91.13.2026.06.14.12.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 12:58:01 -0700 (PDT)
From: syncrain <iganschel@gmail.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syncrain <iganschel@gmail.com>
Subject: [PATCH] openrisc: Fix typo in exception comment
Date: Mon, 15 Jun 2026 01:27:32 +0530
Message-Id: <20260614195732.1592-1-iganschel@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in a comment describing exception register state.

Signed-off-by: syncrain <iganschel@gmail.com>
---
 arch/openrisc/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index c7e90b09645e..24993c35ee68 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -231,7 +231,7 @@ handler:							;\
 /*
  * NOTE: one should never assume that SPR_EPC, SPR_ESR, SPR_EEAR
  *       contain the same values as when exception we're handling
- *	 occured. in fact they never do. if you need them use
+ *	 occurred. in fact they never do. if you need them use
  *	 values saved on stack (for SPR_EPC, SPR_ESR) or content
  *       of r4 (for SPR_EEAR). for details look at EXCEPTION_HANDLE()
  *       in 'arch/openrisc/kernel/head.S'
-- 
2.39.5

