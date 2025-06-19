Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA72475CD
	for <linux-openrisc@vger.kernel.org>; Thu, 19 Jun 2025 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338875; cv=none; b=msj+jPQUxUOKr+5RtMij6XNBNak7HE4ZtX263DhsD1uJ6ALFobbxRF2Q/1hu4lGM9ji2TomPF09Z8kfKJe5YVoU4JUv4Bojf814ysjoiAKJGTWMlEIhQdHoBpTMkcT4cLvOKerUij+7ydHpoboM4tmV53lORX0j5F2i1zqCbYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338875; c=relaxed/simple;
	bh=HFI2tpZtH0U3t2PH/Xs7MiSaSpkxK9AMKJdZiEbGXvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=em5Stp+WMAU98salJ26Oa8Hpvu7ggVM3316LgQJSy6+PoIHgTBLa1gFsBVkl56W2qHUfoSGEIMqftHlFmQ1DVNaLY7RC3pujoj7fPcFFdFY3dwnea3q/xKHp/27tygCBAqJjAzkSVk+68b6fYwRp8YTF3Myp+a1Ic+ADZ2hbT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/SFDoJT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/SFDoJT"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so6096555e9.1
        for <linux-openrisc@vger.kernel.org>; Thu, 19 Jun 2025 06:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750338872; x=1750943672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oQ7xeYbO0DgtDzgjDzPW3rvsL2d3lERv6UPTNAKsUgE=;
        b=h/SFDoJT1Jbk++rB7GEv9gq23tSv39HSb1mvmAny1fnbIIg7/qIzU9abi+kbaB+hPR
         Hl8P4yIoWUzvrB9rJeSK9GvGjgzCO6911VusqmgDO+M0C36EW93A9BrAhayJSBeUzZJI
         2mFG/DBsaKl3ti4SgCZ0GOXfTGvTwgtSmuHbmucz8PJvQO9A8WFxtMk8aymMwqQW5ZFf
         GH/d57mlZlNLOVvupp7nvers/z+AmUI1GGD8swtsL0WtPQETALkzuT7HRvZ7fHqkXImm
         KVRBNzvZ7RijqDDVOaY1HvUuMyqAXos/4xEKpek8ZT4j+C8VpqwtlmNAPojb8qg4Hfqy
         wOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750338872; x=1750943672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQ7xeYbO0DgtDzgjDzPW3rvsL2d3lERv6UPTNAKsUgE=;
        b=s5peW1Zb7TmytzWSmT7HmB5IGLqR7o8BBDJQrxF+ycP/vEKDLPYkfBXSZVczJiP8fr
         XVRrlkMyJb3BL3MlucOUwBNrbX64zDa38k2I3RWh1nkCftS12ZMLdkGbtol3Cgh7jxu3
         trVQmgYza1Rtr5ox1tE8dtWfSnSqoB3diBwaFPwJ3w6pkOavlo1riSGyaN3o/BSrBeRD
         8HOgx+XCdexU6yLJZ5GvBaIwY9MjjpQyyRilqQX1kZQBPB2TNFSUcilMfvLIskadQ1lo
         zSg4RJQfweZoNm1s4nZCfHAY8BW63VXznOYRURafKACZh4+nypB/BGx/JAZLRH92AcCr
         eo9w==
X-Forwarded-Encrypted: i=1; AJvYcCXotrsGUdlWkLxuprzR3305EbCeLMumDHEhYv//z9pLUI7EHOxG0NRL4H65Z3bn3HcYOiD/79guGtfMuhf1CQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnRMgDfmycKh/cs7Z3PrUmXqNQgWyLcQEUKydFkYMiJA9MLMKl
	oovosSfKVoKra5FRNtzHD2OaqxrUAaG1Se5bpeXU8P+7q3FZj6DMH6vhPPQtZQ==
X-Gm-Gg: ASbGnctGzkeAXK2AlVr9LnHyE09FVQ6RiWX3zctVwi/lJjaFNAvmh3a+UClFzhooBxv
	cM1C5sfQpAHdWwuiz90BcvwgrsgbddVnKgygyqZnghGQCSh5F+4x42GUJBCWI2ONALEBi9sQIlv
	5vWpItl9F92muset2ykSZkVJvOdqKgjx342Y6jFgOOVs8nckjDBoRBhEMtT2Ds1+7oZTyj0widJ
	HVSSmrXVc0pn6Hk9dJ2HMi/tiT1wwokb5SEE8aZuEHRWjCTJRbnWcQ+cPY10WQ25LDxXNYnsRPO
	mu5pbEGHBqs9FJOYHq7BJrNQzxljgY+T2Qlav7iWw8asPtQ4IKNbZiwjzMbwtYMVWhvOWNl0b9A
	Dd6YHQtqnL/NNZrqdDO4/buhO8g==
X-Google-Smtp-Source: AGHT+IFzbY7PDRQHIpTQsmQLemmucer9JL3xi/UzPNUKd/6h6H3dcIHan49FL8KJHldJS4TpMRggUQ==
X-Received: by 2002:a05:600c:3d85:b0:450:ce44:b7 with SMTP id 5b1f17b1804b1-4535ec2e9cfmr34857625e9.5.1750338872246;
        Thu, 19 Jun 2025 06:14:32 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4536366326fsm2334915e9.38.2025.06.19.06.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 06:14:30 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GCC patches <gcc-patches@gcc.gnu.org>
Cc: Dimitar Dimitrov <dimitar@dinux.eu>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH 0/2] OpenRISC fixes for PR120587
Date: Thu, 19 Jun 2025 14:14:24 +0100
Message-ID: <20250619131426.1292212-1-shorne@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a small series to fix If-Conversion on OpenRISC after the build broken
with recent subreg changes.

Stafford Horne (2):
  or1k: Implement *extendbisi* to fix ICE in convert_mode_scalar
    [PR120587]
  or1k: Improve If-Conversion by delaying cbranch splits

 gcc/config/or1k/or1k.cc       | 54 +++++++++++++++++++++++++++++++++
 gcc/config/or1k/or1k.md       | 57 +++++++++++++++++++++++++++++++++--
 gcc/config/or1k/predicates.md |  4 +++
 3 files changed, 113 insertions(+), 2 deletions(-)

-- 
2.49.0

