Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9EB21D3D6
	for <linux-openrisc@vger.kernel.org>; Mon,  9 Jun 2025 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749495595; cv=none; b=afmYSHHbQY65AxZcX4p1vwQdSj/Ut0w5QhqLC5Xvxsq/fGPMUg14V3UBlnzNDqQ8y7Ov0efQJtGBB+XVD+MxJT//bj+OXcoej7hd4+p9eieryMLM8i0G569l/C2emyK+zxTaB6VrGcRIjGfwDryDVHXRqwdonwC1uLuiHlmAwLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749495595; c=relaxed/simple;
	bh=q/jc9lfJFfoAgT+zc/3m3DAHq1WHSKLxUUK34iNmf+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZdDhNyg45KLmyJJYNCfBLTEzjB4reNgWef93K/lAfPetdUDs3AZESYCbD7U6hsTUJIC1OTa1FCBpGf5NX6U4cbEUlJ14WLoA6sD6vJwWeLH311QqmIavqmJxVbzFQiE9WNUDIY2Snnw4AIQWC8Y2t2OqBCrQqyiBmWDQYLrj6yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyWZt/JA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyWZt/JA"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so32992055e9.0
        for <linux-openrisc@vger.kernel.org>; Mon, 09 Jun 2025 11:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749495592; x=1750100392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2k4SK+lTe91LQklGg9ahzquwN7Y50TXezRd7P0ejvII=;
        b=AyWZt/JA79d6oCZMM1C/L9E0BXt/8kIymgqS4DXuvBBSSkg+aCzVkfbH4bTzofiPDS
         +CLfCJSAO+CdsavcYQLXnOCQmt7cjsXxqD6p0wPslKUGiaXvt39aNFHOAwnpikgXoflo
         7cxb4XjeCnO1OJET15+I4H5YV12RK82qCMJh+QJfl94pmeh6qfSKmptIw7lrHDobae3g
         CtpVEzzf2g9QZq357h0WXb/PMTXuLOEGEoK+EsfiTkwJE3N6tFVuUqviiRJDe0j23UG2
         ULeCNyB4n0AIA2xmhBOFFCLol+FngWzx870P8RJArzP16PSs/Ua1J8LXPs7r7ODe2cXp
         DxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749495592; x=1750100392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2k4SK+lTe91LQklGg9ahzquwN7Y50TXezRd7P0ejvII=;
        b=OOu0uZeetRnkwJwAnoPWtxIhJn/AZE4I8/LJUkR+Xzh9ieQ96pOaDzdKP083JUbSgc
         3BxsCq1D0en9UgDoRiQcbZ/N3NcsTgj3lItE3li3+d9AZ7nIhxJ7lr4WiG8dxpdewBej
         RwLj8jrZycLBopQ1ACR4kwPuU68+UgRjGEynU/aKwKwNmOLNJOJQXSX+lf+FQT2VZlnM
         L3g5bNAhxnS7nCwCdfP//5wWeMhOAouaGDwHWlDL7IIq7FIFEQOpR7oS3YRmF/2UB/ne
         DY53wVSgw1ssZb9lXHuENHSTN0hxGTNnxQfqtiaoZGjqIdTl4Drc1fq3nNb8+UwhblSX
         zgYg==
X-Gm-Message-State: AOJu0Yw0BK3qYNAvjkpf6OaisF/Yd9lQE+7aFrw9wteAmMXW7VFO9DnO
	yF3ft/L2pUTfFNrVRmywNSBYWKNhlgNpyq4kHlZ4uhoICPiTHUQmHnAa
X-Gm-Gg: ASbGncucP4gvA3dRPnGj+ScdpeHcKiUk3iDKKzofkbgEbPSCfmJhotE5PQ/sF0lvqKB
	A6Ic/vNxohlW44dhZkFLV86ZyvhieYeMzO6a2ppSpr0sdOAd1Gy9cr7l3/fdChhuO3mnaBa4MAS
	mRmKnZaNx1z6FWzBNjPBE+gFEmd19z9zK+iYg8EtSGlhR4TkXpV44doY51RtGkuys1DU3l48/zw
	+l+LtkIn34MiLn+ZnkjJzhjDS+WrtCg3rF87dzbRGrUfK/jB+w0k7KPqRVHeGrgqiOUbmrFKucA
	uWb6xl9lXsi4bC18lC53HVjktl4rr20/mAT7RdDUEbTunYPEqG2v6MPzqtgwjSyLTYl1F+fglCO
	p0iuL54GcV4kb3V0=
X-Google-Smtp-Source: AGHT+IHmmGwnSYuars7eMt4CdrFshBR1nSFr2mvLWVMVYxjF6Fk12rNkKxJtlIM0rVOguZWuRUo2mA==
X-Received: by 2002:a05:6000:2f88:b0:3a4:dd63:4adf with SMTP id ffacd0b85a97d-3a5319a2f10mr11929150f8f.34.1749495592166;
        Mon, 09 Jun 2025 11:59:52 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532461798sm10003386f8f.87.2025.06.09.11.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 11:59:50 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GCC patches <gcc-patches@gcc.gnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH] or1k: Fix ICE in libgcc caused by recent validate_subreg changes
Date: Mon,  9 Jun 2025 19:59:46 +0100
Message-ID: <20250609185946.1538314-1-shorne@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit eb2ea476db2 ("emit-rtl: Allow extra checks for
paradoxical subregs [PR119966]") paradoxical subregs or the OpenRISC
condition flag register (reg:BI sr_f) are no longer allowed.

This causes and ICE in the ce1 pass which tries to get the or1k flag
register into an SI register, which is no longer possible.

Adjust or1k_can_change_mode_class to allow changing the or1k flag reg to
SI mode which in turn allows paradoxical subregs to bre generated again.

gcc/ChangeLog:

	PR or1k/120587
	* config/or1k/or1k.cc (or1k_can_change_mode_class): Allow
	changing flags mode from BI to SI to allow for paradoxical
	subregs.
---
Sending again to correct mailing list.

 gcc/config/or1k/or1k.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gcc/config/or1k/or1k.cc b/gcc/config/or1k/or1k.cc
index 62e2168e0ee..f1c92c6bf6c 100644
--- a/gcc/config/or1k/or1k.cc
+++ b/gcc/config/or1k/or1k.cc
@@ -1408,8 +1408,9 @@ static bool
 or1k_can_change_mode_class (machine_mode from, machine_mode to,
 			    reg_class_t rclass)
 {
+  /* Allow cnoverting special flags to SI mode subregs.  */
   if (rclass == FLAG_REGS)
-    return from == to;
+    return from == to || (from == BImode && to == SImode);
   return true;
 }
 
-- 
2.49.0

