Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB5ACCA47B
	for <openrisc@archiver.kernel.org>; Thu, 14 Jul 2022 04:51:23 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 87B8720EEF;
	Thu, 14 Jul 2022 06:51:21 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by mail.librecores.org (Postfix) with ESMTPS id C14EB24915
 for <openrisc@lists.librecores.org>; Mon, 11 Jul 2022 05:46:47 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 q5-20020a17090a304500b001efcc885cc4so3773938pjl.4
 for <openrisc@lists.librecores.org>; Sun, 10 Jul 2022 20:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zH1rOKwt+eppc4uRJ3wzEb3jlVxvSJQcRh3p/hoLlMo=;
 b=ePx9tw2qDorWxYzPWcGRLOvGkwfDV4WFpjno1bzwsIkpBxrJHAnbnXDd+9TSQPIZWc
 rB8vctJmdtvbZmL7h6HXuBkhUVLcRj4hr5D8Xao8ADv5y3VOodNZydMQYF/4GMGusm5B
 AITvvCsvM4Fymc4mIY+V5NWWdLdN5dTrkn7xmybz4zKiKBZrzDwmWdMdWUAOQVASHsYU
 cWoYrJVQQwEh8W4X1CL7RJ+zQhdG9+qfpNmkK52I5z3wiRZLGNEEimJp5XIALeYrky8b
 md0dtPDDjYyabBKb/WuxSnQ+6lF4nSZ8gZYRptwvwsM03yDen/D8SIE11lqmoUisCWjs
 XneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zH1rOKwt+eppc4uRJ3wzEb3jlVxvSJQcRh3p/hoLlMo=;
 b=V9cU0v6YzTa6AMh5+6lPYQvvznTdn/lLxw77eaDnINlKMdcEbBrH/yhCQHE11QBBjE
 p62Qdhq95yYYNheI+R8yxC+TWhP+8HkOrwL2F5VKwndiNdGEZWo/SZfZXAYlurVxjchg
 nzuiHreNTSoGprq482A5AqnUhpJPs9BAgmppCN4shERpJ5tYdTHJlvFuiHH5jAD1l/Sn
 GmcGexXcAcOzHkzQpVtG/aSrKbt8i/u5fsNat2PLtlsT6/N5X9nDni1FnDybS3SuGs9e
 szywmVg9wD/nyNSXIYZmvH1y9e/SyFkFKqPrThRwn0rxjYqFxxBBpGn6sEJNAbhPusGh
 qK0Q==
X-Gm-Message-State: AJIora+atxqOnmlE2q+uqK01x4zm83y//a3Qe04ycOaTYQk2Xxr7cOXq
 3ZEeCoCO6Z5Hc7G+UR4PN9k=
X-Google-Smtp-Source: AGRyM1t+IjLE84wZXwipeZB/XUo7NKGO7BarDvcoewmact2teddnhHzQthXl8IiBONeN1GAjHbnetA==
X-Received: by 2002:a17:90b:4b4a:b0:1ef:fc95:3c4f with SMTP id
 mi10-20020a17090b4b4a00b001effc953c4fmr15058701pjb.138.1657511206386; 
 Sun, 10 Jul 2022 20:46:46 -0700 (PDT)
Received: from localhost.localdomain (47-72-206-164.dsl.dyn.ihug.co.nz.
 [47.72.206.164]) by smtp.gmail.com with ESMTPSA id
 a13-20020a170902eccd00b001664d88aab3sm3447949plh.240.2022.07.10.20.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Jul 2022 20:46:45 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2 1/4] Revert "Documentation/features: mark
 BATCHED_UNMAP_TLB_FLUSH doesn't apply to ARM64"
Date: Mon, 11 Jul 2022 15:46:12 +1200
Message-Id: <20220711034615.482895-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711034615.482895-1-21cnbao@gmail.com>
References: <20220711034615.482895-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 Jul 2022 06:51:20 +0200
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
Cc: linux-s390@vger.kernel.org, zhangshiming@oppo.com, lipeifeng@oppo.com,
 arnd@arndb.de, corbet@lwn.net, realmz6@gmail.com, linux-kernel@vger.kernel.org,
 yangyicong@hisilicon.com, Barry Song <v-songbaohua@oppo.com>,
 openrisc@lists.librecores.org, darren@os.amperecomputing.com,
 huzhanyuan@oppo.com, guojian@oppo.com, linux-riscv@lists.infradead.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

From: Barry Song <v-songbaohua@oppo.com>

This reverts commit 6bfef171d0d74cb050112e0e49feb20bfddf7f42.

I was wrong. Though ARM64 has hardware TLB flush, but it is not free
and it is still expensive.
We still have a good chance to enable batched and deferred TLB flush
on ARM64 for memory reclamation. A possible way is that we only queue
tlbi instructions in hardware's queue. When we have to broadcast TLB,
we broadcast it by dsb. We just need to get adapted the existing
BATCHED_UNMAP_TLB_FLUSH.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 Documentation/features/arch-support.txt        | 1 -
 Documentation/features/vm/TLB/arch-support.txt | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/features/arch-support.txt b/Documentation/features/arch-support.txt
index 118ae031840b..d22a1095e661 100644
--- a/Documentation/features/arch-support.txt
+++ b/Documentation/features/arch-support.txt
@@ -8,5 +8,4 @@ The meaning of entries in the tables is:
     | ok |  # feature supported by the architecture
     |TODO|  # feature not yet supported by the architecture
     | .. |  # feature cannot be supported by the hardware
-    | N/A|  # feature doesn't apply to the architecture
 
diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
index 039e4e91ada3..1c009312b9c1 100644
--- a/Documentation/features/vm/TLB/arch-support.txt
+++ b/Documentation/features/vm/TLB/arch-support.txt
@@ -9,7 +9,7 @@
     |       alpha: | TODO |
     |         arc: | TODO |
     |         arm: | TODO |
-    |       arm64: | N/A  |
+    |       arm64: | TODO |
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-- 
2.25.1

