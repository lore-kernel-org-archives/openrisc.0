Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178C9C433EF
	for <openrisc@archiver.kernel.org>; Mon,  9 May 2022 22:32:27 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id D5DAF248FE;
	Tue, 10 May 2022 00:32:26 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mail.librecores.org (Postfix) with ESMTPS id 385F6248FE
 for <openrisc@lists.librecores.org>; Tue, 10 May 2022 00:32:25 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id d25so13421882pfo.10
 for <openrisc@lists.librecores.org>; Mon, 09 May 2022 15:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
 h=subject:date:message-id:mime-version:content-transfer-encoding:cc
 :from:to; bh=wogL5SNF6fBWUFbVfNImZXe0oagV0GR5P/uvXUVTGHw=;
 b=IJlSe/QYx+QBVtXsevt86SPgzwgnfYUoN/+MtyvqGNjARDi5TpCiQz6TJD5R7+mW5m
 x1JKsPS1APmscP3dprFiIQRfFzjXXfYVyAdBp2oqTtlD1pomh7P+T8/J1bw9I193p9rb
 iVTOupRBY/ZlX0QdHDGqSv2jYXcpZIJ3YFVWw8NHqfqSpy1JsSbHDLG1NlA8aj1y3A0B
 deI6rVkM4HytF4YzYO3kSyKYzQRH/4jZ9v0kI2MOFYw1Tqmz4RjwXhlBTcoq+tlKfZ7W
 HZ2zuhLgAk5S9uqogxOl7tNwVp13lu6ZXSnuV0Irnw4mmHrGSywUR+iz7poAhIuNIWUQ
 /hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=wogL5SNF6fBWUFbVfNImZXe0oagV0GR5P/uvXUVTGHw=;
 b=oNMwUMzRvf8Ty/Phphg6MLAYAF6gdwGx0qQ4WxNtGB4t48NZUXOx/ouUMvboobxW32
 jcP0blMuBlWP87WigfzyLy3fNS37lgDZmPlZDg67c+4+zaHkp0YO8KhYNH99+4JagcZC
 c7fQKmdNSau2HPOncdVRpnp/evc8eJgvMpaoB89ocYZWx9+O/kkAYoXRO8QorGo3pgiX
 30oNJbjLQzlTNNFYq0swacWxrjvLA4Yoytj3oBJfDXph9aZnZA8Pc2Dvj2LKSwCWSgQz
 WAN09Ehr078l+xcHB1rXe0V+68TzDawzBhCVkwt+C63SHC4iz5ZaC2uvp1Rj7yqfNn0r
 Kwpg==
X-Gm-Message-State: AOAM530HnhOUDtfLrFV8ZIoWeb1Z3ZSuyYgAtXu7oITYwHZF/PXDwYJk
 6KmFuAm70UU/slsbX1so2mQZwA==
X-Google-Smtp-Source: ABdhPJyAwHjkK3tRBZ297rtg0Bed+Rov0Lqf/ttVjbMRkoVNvpEnT2Uuc+cDP/CXmoRrMY/G7ikPDg==
X-Received: by 2002:a63:f710:0:b0:3c6:3561:42a5 with SMTP id
 x16-20020a63f710000000b003c6356142a5mr14416105pgh.295.1652135543686; 
 Mon, 09 May 2022 15:32:23 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223]) by smtp.gmail.com with ESMTPSA id
 q10-20020a170902daca00b0015e8d4eb1besm423397plx.8.2022.05.09.15.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 May 2022 15:32:23 -0700 (PDT)
Subject: [PATCH v5 0/7] Generic Ticket Spinlocks
Date: Mon,  9 May 2022 15:29:49 -0700
Message-Id: <20220509222956.2886-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
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
Cc: peterz@infradead.org, guoren@kernel.org, jszhang@kernel.org,
 linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
 jonas@southpole.se, linux-csky@vger.kernel.org, mingo@redhat.com,
 longman@redhat.com, linux-arch@vger.kernel.org, aou@eecs.berkeley.edu,
 Arnd Bergmann <arnd@arndb.de>, boqun.feng@gmail.com,
 openrisc@lists.librecores.org, Paul Walmsley <paul.walmsley@sifive.com>,
 Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, sudipm.mukherjee@gmail.com,
 macro@orcam.me.uk
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

The changes since v5 have been very minor, just some tags and a few
wording changes to the qspinlock comment.  There's also a PR for Arnd's
tree, assuming that lands I'll take the RISC-V bits into my tree and
assuming the csky and openrisc folks don't say anything I'll take those
too (though now that we're got a multi-tree merge going that doesn't
matter so much, but I said I'd take them so I'm going to default to
that as everyone else may have tuned out).

Changes since v4 <20220430153626.30660-1-palmer@rivosinc.com>:
* Some wording cleanups for the qspinlock comment.
* Collected reviewed/tested tags.

Changes since v3 <20220414220214.24556-1-palmer@rivosinc.com>:
* Added a smp_mb() in the lock slow-path, to make sure that is RCsc.
* Fixed the header guards.

Changes since v2 <20220319035457.2214979-1-guoren@kernel.org>:
* Picked up Peter's SOBs, which were posted on the v1.
* Re-ordered the first two patches, as they
* Re-worded the RISC-V qrwlock patch, as it was a bit mushy.  I also
  added a blurb in the qrwlock's top comment about this dependency.
* Picked up Stafford's fix for big-endian systems, which I have not
  tested as I don't have one (at least easily availiable, I think the BE
  MIPS systems are still in that pile in my garage).
* Call the generic version <asm-genenic/spinlock{_types}.h>, as there's
  really no utility to the version that only errors out.

Changes since v1 <20220316232600.20419-1-palmer@rivosinc.com>:
* Follow Arnd suggestion to make the patch series more generic.
* Add csky in the series.
* Combine RISC-V's two patches into one.
* Modify openrisc's patch to suit the new generic version.


