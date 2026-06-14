Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CBB5695
	for <linux-openrisc@vger.kernel.org>; Sun, 14 Jun 2026 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781400367; cv=none; b=g2Ps8DoxNo4SGf+gTtIxsED7XX6cE+IpFncJPkgcR/cNKDKAJJh9TWb9MCuCHyyS8zl35Om18mAcutniWhVUuVU/5InH+6TWNxmD2n0Q1ZaoYNxgLC6rvfkvbiPNz/q/e1623k53TSkadAnP63JnsOrayuWIU64JJE+ag1iWaeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781400367; c=relaxed/simple;
	bh=gZED6QN6l95WsBz4yysGYWUWKBZHWy4M/0yR7tAlPlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F+WCkueLCIAQ4D2N2CRkD50EnnN2iyARSFp3SwlW7v8xBbfyxihchuAhFSX95QISjru1gprAT6EE2yCkGB+EfinRW/37vGHi8Ee5Mc21lYnH+6uTgOAfrOpqkhnxfaUrrbKWkAkIOKXdt5DXNhKK9MnU2by2S2STihaeBYnYr+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ovbitzBY; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovbitzBY"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso1087125f8f.2
        for <linux-openrisc@vger.kernel.org>; Sat, 13 Jun 2026 18:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781400364; x=1782005164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHht0T1zK7yMSNRwoYR5/8t5KwTUUznUiJjJMmP2tas=;
        b=ovbitzBYHVvUwO8UQvUer0A72hzaXhYidGmIPmEyj6WOqPSftOG/LlRJzojnCwB0mT
         mYoZ0vJ7PGNEbkb7IFOSvtut/8IgJoouNKprbD/nhSx/3BuNC57dOw4Ia74kcsFz8U5c
         Y5H3YIK9gDg/gJdMerAQESDNhngL0fs0XF3pmFoeAb4C7/TtDDdArLNDgyjIiiinbhbo
         V3oXNjITpWEJh5WKVar4zAmpnm0bQb0aJb69UJS99ReMA+8Y1+EBz5YYiuZBO4o/iMKV
         3DK0UC50mMqCixY9J8GM3zYOkacHfwu5gJZlqRUBrl7Ph/mfi8SFD/ZJDKitsexMOq3Z
         qbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781400364; x=1782005164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHht0T1zK7yMSNRwoYR5/8t5KwTUUznUiJjJMmP2tas=;
        b=CHZwueiSatpRkNwRave3R1WRbvdec0B36yCJX0RkPKp25VLW1CXzHVIujZnjUPompa
         1raJrg9eO/Bo3wF33abHr2ZmL40TsyG/cVGvcK0SuDWuxWmoiIUGwa2kWfvYeyw8lTKM
         fZUlZkrmtfE4vd+d/PKg3fj/DZW3hORHvTDNFpkUiA5cCFY68v+8JHJIMDJvknCaccql
         DXCItAlQ+yEUAcs2dPgSLtzlvwvRYT6x8MWUpJrE5IC3IMCVgxSxpyQ1Gi0ekftjS1S3
         18240StAv4jZHrIO4JAy3cP+7HF4fW3vtp4mtGVd0bOUgUT/B8Wszdo14pmXDil3uv/g
         RDug==
X-Gm-Message-State: AOJu0YzMW8f1DPIghqncReOqJeufE/l9nI1dIeVr4vE5gTjYmyxq1ikh
	4L5D02GBi9O5rj4N225HAH8/qfH292TGcu98sQ4FDkCDCkoTg3U++Nd5
X-Gm-Gg: Acq92OH4HhMocrre22b0LAbFuuZTQbd8Rb3pWT6evd5EhhCTtl4S5vDggIt1VkAwnTP
	TdErbJvQEwbjrlQlIITgpRbbSsy3wZIi4qandVnx+ypuNorVq+dltYckDGVc25wGT6Jer73QS2H
	xncTOyEWHdV5/HrFgbGLfDHWQIQp2VhL09herC+KgIWwa9jwsMW+sZjbo/SjQznW4guawjmV7de
	OxV50vaw8I5S5H81ZT9G0fu8PfgD9QlzE7pDCBCb2BWLbW506SmqaouPcoH+VoarBELWy9XdV+n
	B2hybRBum8RabdwidL9l9em33n34TkQxYlaAOl+/NJWKe089J1Rzu5TcknQdaepEN26HF8OEsgm
	xlu8P03d3Q0f0eV/sQ3R3tYDLQlH6P8gFUyJ5sT72TKU91+en3fwwq1jadY/2JN67eAITFwvaE4
	OQCxZS1FR2VjR8QxygIwyEGiRPYuyhg06ypVINd7A/eYCTmhtnRLx0qdfr0pA3RFB6JlxLZ6H1p
	6lliA==
X-Received: by 2002:a05:6000:40c7:b0:44a:fa76:5193 with SMTP id ffacd0b85a97d-46074a5c60dmr6529047f8f.12.1781400364339;
        Sat, 13 Jun 2026 18:26:04 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b1092sm20860852f8f.17.2026.06.13.18.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 18:26:03 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GCC patches <gcc-patches@gcc.gnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH] or1k: Fix improper placement of cbranchsi4 instructions
Date: Sun, 14 Jun 2026 02:26:00 +0100
Message-ID: <20260614012600.2347385-1-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When investigating a builtin-arith-overflow-12.c test failure I found
the cause to be improper placement of a cbranchsi4 instruction.

In openrisc a cbranchsi4 instruction will be split to something like:

    (set (reg:BI ?sr_f)
	    (cmp:BI (reg:SI x) (reg:SI y)))
    (set (pc)
	    (if_then_else (eq (reg:BI ?sr_f)
		    (const_int 0 [0]))
		(label_ref:SI z)
		(pc)))

Between combine and late_combine1 optimization passes I found a case
where a cbranchsi4 was getting injected between the "set sr_f" and
"jump if sr_f" instructions.  The middle-end thought this was ok as it
could not see that the cbranchsi4 pattern will clobber the sr_f register
after splitting.

Add a clause to the cbranchsi4 pattern to indicate that it will clobber
sr_f.  This allows the middle-end to avoid placing the cbranchsi4
pattern incorrectly.

After this patch these tests pass.
  make check-gcc RUNTESTFLAGS='dg-torture.exp=builtin-arith-overflow-12.c'

gcc/ChangeLog:

	* config/or1k/or1k.md (cbranchsi4): Add clobber clause.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 gcc/config/or1k/or1k.md | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gcc/config/or1k/or1k.md b/gcc/config/or1k/or1k.md
index 85209a63f20..1af29f247d3 100644
--- a/gcc/config/or1k/or1k.md
+++ b/gcc/config/or1k/or1k.md
@@ -616,7 +616,8 @@
 	    [(match_operand:SI 1 "reg_or_0_operand" "")
 	     (match_operand:SI 2 "reg_or_s16_operand" "")])
 	  (label_ref (match_operand 3 "" ""))
-	  (pc)))]
+	  (pc)))
+   (clobber (reg:BI SR_F_REGNUM))]
   ""
   "#"
   "&& 1"
-- 
2.53.0

