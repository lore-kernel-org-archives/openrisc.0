Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32A04A3867
	for <linux-openrisc@vger.kernel.org>; Tue, 15 Sep 2026 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476976; cv=pass; b=NCr2tpuYEey/o7P9PqxUxsLCsXYFX4HPkh5d9RXIXxzDeEuunamXfmR5qGWwtXpm4whxNdhOABoZA4sey0hLAOv26sPKlqqcuZRThVHiwvUwo8kEc3E6Chkz0k5nK3W9WfY7nrmWTXmUtniErANDjUwF9O5M/vWQjWL0ksm4GEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476976; c=relaxed/simple;
	bh=7U8VSjkKPBAW3IjkZinqdZujwWo98Mm4ytydvIVt5es=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=GhBWlSLpbfaRJWS8OY9ZyuYfCfiSpZ+sXMxGFzq/BCXYssnDp267mImmD8dkZ3VhPH5hlWusQV1ZmBPxWNHepnfCk7FNoY8cRQK1be6kl3B/9f5kjNK1rRGORpTmHZ4VdZUCecF8Ay8xsQFf6uewGnmf5sPYFZnxF/Jne5ITv5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLOvkz7g; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLOvkz7g"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so19507605e9.1
        for <linux-openrisc@vger.kernel.org>; Tue, 15 Sep 2026 05:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789476973; cv=none;
        d=google.com; s=arc-20260327;
        b=HADiJ17fgyJqQuGtwHgY5wSOJbNDbpbarzK6i+GBn1Pse51Ap0gZ6o/o4RVMlwgXVd
         K2x2FJkvVNjwI74zaYtSl1lnlb8G1rDQtyQIBUnGNj50WUMOboF9DP4E/NTZN4lRdAWk
         TrZULsVNRyjKFvv03BReseJ0gtNL1K5L1BLKD5+5nNn9VKHPcM0RAqtsTLssG2Yr+ozo
         YLmb6yvlgclisp8tgPGSzi8tL+0/z6nZFQMk2f9muEdlXv+ulK39FmC9gTrJ1bg6VzyT
         sKet0vaskSJlMVm4Vd3l9+FJWvyBlQKmZi0aCEJDbzKq7Y3io7o6ArWyN9U5UV1KyETf
         AXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=X7J+y3RUn0+QrgkFcKooJ9BhHylWjgww/WgpahwjkFI=;
        fh=FIJpdBwUEgWwSYrFNz1pDWs4q3TUHGGnzrs7Gjw6l+w=;
        b=hYC0V+7Or0c0AEAOGcLDOxNgE5bFNbrs3sEA5XoWj6Bnv5qkQ+Twq+fgjD+K667Is/
         WWiWg0NkIWRjzDcyjupffMLfBQ/LkYuGr+3gR25Zhf9DXlySZINNQ5V4CsWcTRHnzRC3
         FmsM2XQayMUOabihisaizCSl3N7vj8heWNmNwCPgynZZr2QHIPNRKSSvscghZ0+wc/uA
         rdGd54ArXkaV9kkkz29x/vNyEi/bZjASmsQsMAfQI3qDylHaWG2sp1YGUEFmsp1RA6gB
         ACMfoXkRhRjs1CTK5lsafC+tSDYRO0cDw9Ay8oNuFuoKRPjVYIidsShSTg9YabQrDGJz
         DCxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789476973; x=1790081773; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X7J+y3RUn0+QrgkFcKooJ9BhHylWjgww/WgpahwjkFI=;
        b=OLOvkz7gWlqCyDvIrdo+nKknMq6BMyR292dtsvk6zlqObJICggmmLpOeQt6Syxyim2
         C7J8iwY0o2Kth7G50BGMeG7HQYL6gPIzYEkohQtvE1OukD7mWJ2ll0Y9Fn0d/2aCrjdL
         +80oqxsRsv1m8OTGaoncKckCq3I1fsQJRwWPnuamIUTsgmWx3zNR4dgEDPZDMc+jG74+
         CUAKZGrvt3DfW09Yo1ViGNN2iTRLkqu6ytumZ3XKK0J62IPy8o6V1DnxWfv9MIk7pGco
         AZXlr+KhLteS7kuHZczSbrYqH7J/LNHI5cvaCw7Gl5T6ZexawpN0BLQSkD+/7G4+IH0n
         1vfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476973; x=1790081773;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X7J+y3RUn0+QrgkFcKooJ9BhHylWjgww/WgpahwjkFI=;
        b=MoXmTIwSXX24iC3hMObVBFtnO9wLdcBCxGGNmEM16u+8+Kn/aqLPbKMtqdN73y0K7F
         oP8/U8DtsqH+VbpxY6x2SCzxtbx/WupXT6cuv7JICUltNYMA+PTutP1/yxqTB+K/lVaw
         Pvey0a7ssXKBY+6d+wMVLPKD7TSAs54K/aDgOkiTxTad6nItex56wR8jZ7Zx3r+mQT9B
         +nmhSrPelaX3pDOMMhl+2/SrMxti/hLDbPBAk7VxrRziJdBqPCCCFCz+Rz83HFb+ufg5
         2piRSjCL+2daWiIy4AGBd+fEPByX9EoX2Wd/oBSCCk1aw6HuBqEwqyw+nyso+szETScz
         LEIg==
X-Gm-Message-State: AFuF++m3XpIfpL+77c3LceW4RvY24gJcgcjT+9CX6Dmp8sPNivJKO5mO
	KiIBhS2T8pwHoQ8kVGAX8UD8bmUgZJ5zambHa5eiYI/s171rwbrUUnpKWzNp1fB7Zo36AEk5yOg
	2BrvboyCCizi7EmdOO9sZK/0lZdtBGSGG+lGmPmg7jpzM
X-Gm-Gg: AYBFou0aUH4lN6Y2CJuGDkuGMrYEV6TavQvr4JQLS/C7d7ooYNzPxdbZUwuK+ie1Toe
	fXqY6uiDAcOSDCllzHhuoZn0ZjsrijK5HerRoEku2qdQGW0DFziz08Y9mpM6axUGGR3tIf0x2R7
	Pj/jQvPybHDRMiCQo4eneh4Ugc4K9pjAm78HuBKHl4YSfRNdCT2Zd+VSC5Fjo1cAvzgqSOJb2Th
	bgDBjmvsDltPqOPDkpiOoOfLkW3Q5aMpYI7+XAX54Si2CXcqzWQTC4Yaf5axitl97o5/Fvz+DKk
	cbLrbQy0TLjVOOcGCJsVuNDH5ciSVXfYjDsMzpGRCi7xy9GcNylVP5DJdr+573v2
X-Received: by 2002:a05:600c:5394:b0:49d:2555:1a6d with SMTP id
 5b1f17b1804b1-49e7a68d7d5mr181430635e9.16.1789476972769; Tue, 15 Sep 2026
 05:56:12 -0700 (PDT)
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:56:11 -0700
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:56:11 -0700
From: Ruslan Vagner <rusya92266@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Sep 2026 05:56:11 -0700
X-Gm-Features: AcwNN1UcTJyHBmvp0D5zI0DCyxXO1pcOdrZsOaAQCItPKtfqjBF9BqjMzL8aL-0
Message-ID: <CAF9RqJ7xfmAQyon4KB5p9_Tiop0M7yk98M04u16frmHPbxn7nw@mail.gmail.com>
Subject: [PATCH] openrisc: fix comment typo in entry.S
To: linux-openrisc@vger.kernel.org
Cc: shorne@gmail.com, jonas@southpole.se, Ruslan Vagner <rusya92266@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Fix the spelling in comments. No functional change.

Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
---
 arch/openrisc/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index 18e68680471e..fc72d54476e5 100644
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
2.54.0.windows.1
