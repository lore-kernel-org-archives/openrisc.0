Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDAC2EB84E
	for <linux-openrisc@vger.kernel.org>; Sat, 23 May 2026 05:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779514613; cv=none; b=owRJPq8rMG/s/HIGzez3XZFEgqT51R4pjmW5EoVudXEFBNrOO1u+eQh5k6Zm3arNozojr4goc3TgSd3uJuDYbJ1UpX1R0axIWxJc2AsMtNjUW+5+7khIPzCiRfaD1J90f+MpY7x1jZpuRAZ9AyOrGHrbefu9DDGVXEp7z/lEQjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779514613; c=relaxed/simple;
	bh=qbuLMSIdwLDMQyPVrXzwv3hnPVTrG6PN3h5ruMoiwoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8dCIy259z9UVe5Czu7ZW0BGQFojM4ZD46mL9O09kPJGr1VX7tdd/LAq9CZ6auoSTKkk5+1zeHp4liGd1afT3OcTkfWafrWsn+nU0EWAiARlcpPBVpsI35S+uybTGrBFy1cr5kUiA+1ksXQJjDaYFXw0rYftZCg3Wm7qzZvTToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qZynej5R; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZynej5R"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso102888155e9.1
        for <linux-openrisc@vger.kernel.org>; Fri, 22 May 2026 22:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779514611; x=1780119411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQYLpktcHIxxq3vHSLAXOh6GKgha74zW++4ibCzeh9M=;
        b=qZynej5RiJqLyevkIeqhFXGqwnXNv5WgnM7UIbJj2+7MnV+PcKPmEGID2gl9uh69DS
         2JWxEje2l7/2NLafDcAsSTZ0Ef17/gkMdOvt3Uj6JWU3tLhVRArFh7/jvkBMzDRwq6mC
         vniiZkZQHn5epJrzmf3otz1dFSOatuywY6GAjXIdhnHqKI73mqVl4pyORjGBynV4wkYm
         6c0gqv+2iMb3Ml+D/aPX4tHF1AE+C5JrIyS5CCSfTxrYFAbBj1MHWf1eCT5E5/1XU6l3
         h6cMF6Y5D+hh/ObaPGGqAsT+NvSZZzQbjoYyJ80asAz1trhd0VHmsxFJQmcG97WsDblc
         Oq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779514611; x=1780119411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WQYLpktcHIxxq3vHSLAXOh6GKgha74zW++4ibCzeh9M=;
        b=Cuud+BmoaMkiVTyAzugPMDJ8iz1ixTwJPrDNiKoG9i1MAxwn6WHwVfskhrJWH8NhLq
         8/TJ3t/jzg87ooIGimHEVOrcG3nD+vAnh9czE5gdsFYnyYx1Jo93ru14V1K09IgFdS3C
         5Rpgrh/sX3aq5IPmXUw8o2iaWmJ6n24S5CPgwEBs26TmYA4uspWv7f6xpqUoAI7LG0dI
         S4x+M/fHeC/3NddIPN8HtQEChg2veLDOZBa8lsnK44Dz3QYVfNdUTFMT76P6m+9Lm+Qu
         BG+EN91rh8uXLCvLgjkGYWuPFWdqqsycm+e9WpmgF6iTd1DfvCBd2pVhi9Gzsv08YREG
         DqJw==
X-Gm-Message-State: AOJu0Yy0y/Vc2l8heDI87cGSjWqVMaqLiNmjb+9kTHMUaVYPPwVyXD8X
	M+SbVECU938PmTgbsjhuwVP9IZXlSzTJHOcNZKJrbGJ4ouMpjw26zNUyuVhi8A==
X-Gm-Gg: Acq92OGut+BLdT2YwY/B+893TbY+Hwan7yAP9FdaPT09LKiNZzpnyOSALWD8bieiwm0
	RfwX+tnSkGKUScKDZCSnpPtS9m8ovwu8BHxhyHy0gMTBNyBoJkGhKF3xs6pDkuHx/94OS2FvNzN
	m6KLPfkmquOOsODsOc00SBvuO9uCCT8vhFYeseB4PMgv9USnCYaDwroZakFMksCzfUDx4sPccG8
	TdJhwFvDcKcK+Q17sagWHUCNwcnIo8r020uqYJKL7DtlX94WtGMdKF5ZRp3zsfRdBULRalQ7ykI
	vdAFV8WW4QZLWHPO/H20rc/1yZ+r0e5eEhiIQNvKKe62J7F3EK4RlMxAJy+rQP4Wozbk3kWfh3C
	hz/XVbJKbep9o9fRc4tznYhOeIDlbrGqzHza0lCN2XmveHwUeP2FmTcm5yvgpiet0GDPFHlhRGG
	kYz1QMcJfCt/LRd8RQ0B+40eTd52J9k9RxyqXMuQf54RHr2hdZ5HRuaWN9X7/mEl2JwGNygAkEq
	l/Lxg==
X-Received: by 2002:a05:600c:46c6:b0:490:4927:3777 with SMTP id 5b1f17b1804b1-490492738a4mr55083855e9.2.1779514610640;
        Fri, 22 May 2026 22:36:50 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904527f7f7sm142490395e9.7.2026.05.22.22.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:36:49 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: [PATCH 1/3] openrisc: Cache invalidation cleanup
Date: Sat, 23 May 2026 06:36:16 +0100
Message-ID: <20260523053624.630443-2-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523053624.630443-1-shorne@gmail.com>
References: <20260523053624.630443-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When working on new cache invalidation functions I noticed these
cleanups in the cache initialization code.  Remove unused and commented
instructions to avoid confusion.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/head.S | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index bd760066f1cd..65f474c2df4f 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -852,26 +852,19 @@ _ic_enable:
 	l.sll	r14,r30,r28
 
 	/* Establish number of cache sets
-	   r16 contains number of cache sets
 	   r28 contains log(# of cache sets)
 	*/
 	l.andi  r26,r24,SPR_ICCFGR_NCS
 	l.srli 	r28,r26,3
-	l.ori   r30,r0,1
-	l.sll   r16,r30,r28
 
 	/* Invalidate IC */
 	l.addi  r6,r0,0
 	l.sll   r5,r14,r28
-//        l.mul   r5,r14,r16
-//	l.trap  1
-//	l.addi  r5,r0,IC_SIZE
 1:
 	l.mtspr r0,r6,SPR_ICBIR
 	l.sfne  r6,r5
 	l.bf    1b
 	l.add   r6,r6,r14
- //       l.addi   r6,r6,IC_LINE
 
 	/* Enable IC */
 	l.mfspr r6,r0,SPR_SR
@@ -918,13 +911,10 @@ _dc_enable:
 	l.sll	r14,r30,r28
 
 	/* Establish number of cache sets
-	   r16 contains number of cache sets
 	   r28 contains log(# of cache sets)
 	*/
 	l.andi  r26,r24,SPR_DCCFGR_NCS
 	l.srli 	r28,r26,3
-	l.ori   r30,r0,1
-	l.sll   r16,r30,r28
 
 	/* Invalidate DC */
 	l.addi  r6,r0,0
-- 
2.53.0

