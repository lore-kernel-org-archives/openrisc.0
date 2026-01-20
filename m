Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581C334D4FA
	for <linux-openrisc@vger.kernel.org>; Tue, 20 Jan 2026 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768928876; cv=none; b=Ci/8SBUfOs/YV2vRRi2ITuKhWLOidSo68U4RIncKSn7MD6m86apnDbPd6y2MNp2n7D7DFfMkDy5SaYb0Q3bW5yvAswiTQoc7mE2YGa1ZL/Oy1+TRiQ6J/XJMrMgeiHj7Mwqai2ijCBVdu62qw/cQZCxTKo3NCaiP3dWbYE66ElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768928876; c=relaxed/simple;
	bh=yaiWIw951xQh8LxqCes7U6aQaT2eH7soDbS1FxASes0=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type; b=nuVqPOXprw+qGFn942TzMdBXnRVT5Z/TQP2EAWSeYTy5NZsgf8N5QJ90+TBrrijHWNwszpfsjWBUqmdwT7Rmrm0u2aCtTaEnNAi2mcD/DsASFn/23Cn3dkD3HHD+2uCGXJ6iaV/yDPh16MNdskMHjkkldYXLZ6w9ZHlfXjC5L6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHTLUt+H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHTLUt+H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768928873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iaKzfCbyFQZSOqNeo+ub1E9K3vbJu1lANAkalkOAeWw=;
	b=YHTLUt+Hff75SO+7FaPt7Mq81yf6+E2i5qNlhPwJ/HcP4OsfGSikXYREqHfCnZmi5hkDvd
	/K1LclAiwPo9bgUZBlufpLqdorVigf3fk51wzeZvvBJpiXCG1orhzbC4SfUt6VVGet4YcI
	4XWqInp+1nDcvvADByT60R448HbUUWI=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-GZA3y_fjOPS-cHEW15YF1A-1; Tue, 20 Jan 2026 12:07:51 -0500
X-MC-Unique: GZA3y_fjOPS-cHEW15YF1A-1
X-Mimecast-MFC-AGG-ID: GZA3y_fjOPS-cHEW15YF1A_1768928871
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b70bd4a2ccso816501eec.1
        for <linux-openrisc@vger.kernel.org>; Tue, 20 Jan 2026 09:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768928871; x=1769533671;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaKzfCbyFQZSOqNeo+ub1E9K3vbJu1lANAkalkOAeWw=;
        b=HDwIc89ELG2z0hDL6sfEhtJJyvekfLuGLTWx7uxLpBZm8eqLOyADSgEmKHva6qLzUP
         RQ1X4W5Hxer3Le2zSTFeq20F0JzRBvjoKNO9FlZ6Fk1HaAo1AwrnwwJ3UwSPfKmP86Ah
         N2KkuheCtPTAog3CwssyhM03lywQ9kppJo+pqrNzPNq91f3SKcEacm5YHy8G/7+OgwIk
         rNuv2xOuCxmwA9RB1oy/Z0drcmypCW7Aa3MVQn23C6NDmU3ZDsNFLHlbM3mx3My4I/Q4
         WJohv1uunWf0YwZtyu8jw3/QYeXyJbEUtdfh5U0n/zfTaiSuo5GK3xEaGYebYFv80bW7
         2P/g==
X-Gm-Message-State: AOJu0YzQegPEjVGBYHaVx3aKkioGMBWf6Ps/h2uhQQB/ivalBIMpjvc3
	s24XrtCdqFcAb8wyW6pg5RJZUvXTeyDmO2a5sJhZoJpbwxkwE/sZpUls3M89YIvZtUnZmOt6iMM
	wXMQg7srqg3dA4te2k/+tX3tDim7Q3cJs/0s+RIiGQD5awvgudl5tI03Sj0R+u1Hy4ZAk
X-Gm-Gg: AZuq6aL6PtZNSdJ49jIK9RAkjOmOiw1BTGc+TNeD4w0vdiSyaN4DeA0cCIj5wJbi2VK
	hhIfK2zq3csbd1rAjY6Af5jkCPdGhGP7tZq3NxCDH/fX55eZDpZTaDO9e8/o3eOAfEF2DoNuj+Y
	+GGZqLhl9epCYXZrthQd35aR8kKdIhxbGNoBpHtpE7OoTfYtByzu1CQ9jwjsWUk1LfTbgHzKURO
	Q9rFaqNtwx3ZetBJMWN+SNjGhcTwT+iH7PrVLf4+0kbUcfwAmGOceqfRrmbMuS80FWqBj1iKZ2E
	Xnsi2i+UWQuzryEx45UbnDRC8Zn8dgYTvija7++1bqN/heOXTU6p9t/06oNzNbjCp4QJxDVZZwt
	puTJyzMs0lk846UZkdrCLA3Nq45ADiqjhpf8whN+vq8tiKAby
X-Received: by 2002:a05:7301:d0f:b0:2a4:61d1:f451 with SMTP id 5a478bee46e88-2b6b3f33b7cmr11274660eec.16.1768928869231;
        Tue, 20 Jan 2026 09:07:49 -0800 (PST)
X-Received: by 2002:a05:7301:d0f:b0:2a4:61d1:f451 with SMTP id 5a478bee46e88-2b6b3f33b7cmr11274587eec.16.1768928867120;
        Tue, 20 Jan 2026 09:07:47 -0800 (PST)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3503ce3sm17718409eec.12.2026.01.20.09.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 09:07:46 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Tue, 20 Jan 2026 12:07:23 -0500
Subject: [PATCH] openrisc: define arch-specific version of nop()
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260120-openrisc-nop-v1-1-a29da65537c8@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avIrBN0oKyuEi1Mx5qNikIE0t2Tl
 m/xf4NKhanCKhoUurlyih16EOAuG0+S7LsBFU5Ko5IpUyxcnYwpyxkPE5bRW28C9CQXCvz8u21
 /3w+MnPi0XgAAAA==
X-Change-ID: 20260120-openrisc-nop-82b7f95dad7f
To: Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>
Cc: linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=yaiWIw951xQh8LxqCes7U6aQaT2eH7soDbS1FxASes0=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDLzt8VL7BI449AfV2H35rDGK1vdrlOyYZMPspf2bmSa0
 Ca28OqdjlIWBjEuBlkxRZYluUYFEamrbO/d0WSBmcPKBDKEgYtTACaiosPIMOGZ9ultx9ZP0lG/
 lL56/ZcsD5GSaIOSO1Zv19/yaL+ccYCRYaOyjNeOW8ddy3a/5H3gxRSp62agd53v37SX6wu0tY/
 XsgEA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PJ4t5SYun7GAOzaOxpsSGGMLiDqrHCEK6Idxscl76bQ_1768928871
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

When compiling a driver written for MIPS on OpenRISC that uses the nop()
function, it fails due to the following error:

    drivers/watchdog/pic32-wdt.c: Assembler messages:
    drivers/watchdog/pic32-wdt.c:125: Error: unrecognized instruction `nop'

The driver currently uses the generic version of nop() from
include/asm-generic/barrier.h:

    #ifndef nop
    #define nop()   asm volatile ("nop")
    #endif

Let's fix this on OpenRISC by defining an architecture-specific version
of nop().

This was tested by performing an allmodconfig openrisc cross compile on
an aarch64 host.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601180236.BVy480We-lkp@intel.com/
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 arch/openrisc/include/asm/barrier.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/openrisc/include/asm/barrier.h b/arch/openrisc/include/asm/barrier.h
index 7538294721bed7bc8da3d08f3db89a408091f3f8..8e592c99090235423a9f4c9149da9822918afb13 100644
--- a/arch/openrisc/include/asm/barrier.h
+++ b/arch/openrisc/include/asm/barrier.h
@@ -4,6 +4,8 @@
 
 #define mb() asm volatile ("l.msync" ::: "memory")
 
+#define nop() asm volatile ("l.nop")
+
 #include <asm-generic/barrier.h>
 
 #endif /* __ASM_BARRIER_H */

---
base-commit: d08c85ac8894995d4b0d8fb48d2f6a3e53cd79ab
change-id: 20260120-openrisc-nop-82b7f95dad7f

Best regards,
-- 
Brian Masney <bmasney@redhat.com>

