Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D851C433EF
	for <openrisc@archiver.kernel.org>; Mon,  9 May 2022 22:32:32 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 68FC82490D;
	Tue, 10 May 2022 00:32:31 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mail.librecores.org (Postfix) with ESMTPS id 5F44F2490C
 for <openrisc@lists.librecores.org>; Tue, 10 May 2022 00:32:28 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id y41so8594694pfw.12
 for <openrisc@lists.librecores.org>; Mon, 09 May 2022 15:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=pWbw2Mwy88SDSkfpA4D7g/Rmsq9eS9lL/9r9k9KvO7g=;
 b=aKb0kPhWVd5eMpmlkl9NknitMxg8gh5oazT3otM1H7wNssSLITeEgVYd3fLrFpqhAN
 6lW7y7N8edPrk+YAtulN/xaP8NiOVNXKZAi6KA0NNveYzfnxDp9ggPIafs2mYWMuEWpF
 yisEk6Vl9il9YEGMryMzMjf2wBlPJtypJNMiXj/O7kxrK4628fYPSch836eJYFLJD5Wl
 OrKTh30iRJgEMKA4TvqbYiX+DIHWjjGEmbm+VHeiIrDIZkzUjvIVMUmJT2O64m4s1rq4
 s75jC01yaX0ljYX5/96b4XICWLQpDnMGWrtzgp0A1FvhK7kRpUekOBDbUefjzvvkL2IY
 V5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=pWbw2Mwy88SDSkfpA4D7g/Rmsq9eS9lL/9r9k9KvO7g=;
 b=VDX0kV2OPw5fRIZSYE0IYFKdXeWKpZb1J5WaqHsBNkWcR48RqqaQFJegpwHVZGpoV6
 6ecqIKOLXs5LQv0CxThZYyFRlyGCqHk1zLHY6oUWFIsZNcet+QvZpaoCgvxxqI8fLGi2
 7Q9OckNpgnCub/fkpNmuTPG0D3VOPxWIyoV6D95AGjDkuUqogz0WMfFxLGhGIvY4cMe4
 v6CXFVRakZDuEy2t8qFwIE2s6rvffXFBfuRT9IkFh6Tz1Aqp2UjWj1Li1VIAY9y3VzEG
 6j6RgRXEyiWhesWCtRm0Y34ryLtmU+07x6Cqt413OD+VuzZ5mfwREbTMZvFro/6Axg0K
 LVKQ==
X-Gm-Message-State: AOAM533XEfM37XcBSDiGvDr/Jpaff/aZ2eC5SWNR3OnV+yo4Niso/3Ap
 g+Vaf5k1P355xU2u1BE2MOtrrQ==
X-Google-Smtp-Source: ABdhPJxUc/qGM9x1mbDewFdh0f2iSebcv/MH281VDWnsTPJAYa63hm5brMdaLkqzPiol6IuhZdvYkA==
X-Received: by 2002:a05:6a02:10d:b0:381:f4c8:ad26 with SMTP id
 bg13-20020a056a02010d00b00381f4c8ad26mr14585787pgb.135.1652135546996; 
 Mon, 09 May 2022 15:32:26 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223]) by smtp.gmail.com with ESMTPSA id
 w19-20020a1709029a9300b0015e8d4eb1ddsm407885plp.39.2022.05.09.15.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 May 2022 15:32:26 -0700 (PDT)
Subject: [PATCH v5 3/7] asm-generic: qrwlock: Document the spinlock fairness
 requirements
Date: Mon,  9 May 2022 15:29:52 -0700
Message-Id: <20220509222956.2886-4-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220509222956.2886-1-palmer@rivosinc.com>
References: <20220509222956.2886-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Arnd Bergmann <arnd@arndb.de>
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: peterz@infradead.org, Palmer Dabbelt <palmer@rivosinc.com>,
 guoren@kernel.org, jszhang@kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, jonas@southpole.se, linux-csky@vger.kernel.org,
 mingo@redhat.com, longman@redhat.com, linux-arch@vger.kernel.org,
 aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>, boqun.feng@gmail.com,
 openrisc@lists.librecores.org, Paul Walmsley <paul.walmsley@sifive.com>,
 Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, sudipm.mukherjee@gmail.com,
 macro@orcam.me.uk
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

From: Palmer Dabbelt <palmer@rivosinc.com>

I could only find the fairness requirements documented as the C code,
this calls them out in a comment just to be a bit more explicit.

Reviewed-by: Arnd Bergmann <arnd@arndb.de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 include/asm-generic/qrwlock.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 7ae0ece07b4e..24ae09c1db9f 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -2,6 +2,10 @@
 /*
  * Queue read/write lock
  *
+ * These use generic atomic and locking routines, but depend on a fair spinlock
+ * implementation in order to be fair themselves.  The implementation in
+ * asm-generic/spinlock.h meets these requirements.
+ *
  * (C) Copyright 2013-2014 Hewlett-Packard Development Company, L.P.
  *
  * Authors: Waiman Long <waiman.long@hp.com>
-- 
2.34.1

