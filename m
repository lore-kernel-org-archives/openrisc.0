Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C146FC433FE
	for <openrisc@archiver.kernel.org>; Wed,  2 Nov 2022 18:34:42 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 1615624C68;
	Wed,  2 Nov 2022 19:34:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mail.librecores.org (Postfix) with ESMTP id 243A924BF2
 for <openrisc@lists.librecores.org>; Wed,  2 Nov 2022 19:34:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667414079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ncRDq/BlJOAFd1lZE2ZJuHKc4OomK+HPZ50zPzXYcKQ=;
 b=Ju4vKNdWwzNjA8G2EsWoTPsL+SJjJ4fO1yqOHJKNSEUTDcajUOsxc/GCsrxbgwjICmOTLJ
 1+LUkNnPwQVkv55KBbA0S1QFPP0H8EHeVm52fHhLU2IRn2dhZfyscCW0OrT8uKb94R6Ql9
 wL2nTSiEu+LeYbCZnRlyOZ1NsGMcb5s=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-365-cOO3nTsKODKeM3NVe-a-rg-1; Wed, 02 Nov 2022 14:34:36 -0400
X-MC-Unique: cOO3nTsKODKeM3NVe-a-rg-1
Received: by mail-qv1-f72.google.com with SMTP id
 mi12-20020a056214558c00b004bb63393567so10572413qvb.21
 for <openrisc@lists.librecores.org>; Wed, 02 Nov 2022 11:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ncRDq/BlJOAFd1lZE2ZJuHKc4OomK+HPZ50zPzXYcKQ=;
 b=fTo9BASMsUBxVL+AO7TrfMPHTRZFyiOd1Y01GtpnlXl+iLRk2iq1bex2TnkmqG4j90
 X7/4Hn5fJ+L3yzbtT9A16zzxnRWN+ModbkeM02cYfrEmBUARnLwKRmgwBrPYye32GQrl
 xYKY9BPFSLz3I0o6du35noXRlYrQjGx63KdXk9VDY54zMTGaz3Ogvy3KPid+HTBaqQLk
 pZremyI6+kWvaKMMCnkpLT9gHzQboxx8AEfKMeM09XmbAGW+Jq3cmHtRyXvYHobOsHTW
 EIfNo7A0dL44rRHWO9+y3ZX6YiuJ2mTQJk1ykFjS1v5wLwFfGWQnvSLZjexpe3RdOq+8
 Lzjw==
X-Gm-Message-State: ACrzQf0BidktMkbvBfusVFQYxkOvit6MOCZpZyRP3F9vrUrlTXK82CCD
 8FJG376cgU0vP0zrQwb/IqgtlARKtwZ8e/8y3fLxdpqSySDB27jZnAhZjppDQrsm/a3FnsQBE1A
 Ft49jLp7nZ8SuZO8CUKkSZsV4KQ==
X-Received: by 2002:a05:622a:248c:b0:3a5:15f9:57a5 with SMTP id
 cn12-20020a05622a248c00b003a515f957a5mr18914929qtb.48.1667414075616; 
 Wed, 02 Nov 2022 11:34:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4FNihlWG52eEaddlVJ4IcxN5GuBU/ct7sDYakGhS8G9lm88SJZYPQReqCWBc6NZ/CtMAHrgg==
X-Received: by 2002:a05:622a:248c:b0:3a5:15f9:57a5 with SMTP id
 cn12-20020a05622a248c00b003a515f957a5mr18914895qtb.48.1667414075423; 
 Wed, 02 Nov 2022 11:34:35 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
 by smtp.gmail.com with ESMTPSA id
 w187-20020a3794c4000000b006eed47a1a1esm8757820qkd.134.2022.11.02.11.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Nov 2022 11:34:34 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, x86@kernel.org
Subject: [RFC PATCH v2 7/8] smp: reword smp call IPI comment
Date: Wed,  2 Nov 2022 18:33:35 +0000
Message-Id: <20221102183336.3120536-6-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221102182949.3119584-1-vschneid@redhat.com>
References: <20221102182949.3119584-1-vschneid@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
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
Cc: Juri Lelli <juri.lelli@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marcelo Tosatti <mtosatti@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Steven Rostedt <rostedt@goodmis.org>, "David S. Miller" <davem@davemloft.net>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Nicholas Piggin <npiggin@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Accessing the call_single_queue hasn't involved a spinlock since 2014:

  6897fc22ea01 ("kernel: use lockless list for smp_call_function_single")

The llist operations (namely cmpxchg() and xchg()) provide similar ordering
guarantees, update the comment to lessen confusion.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/smp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 44fa4b9b1f46b..b96579fe08f09 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -503,9 +503,10 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
 #endif
 
 	/*
-	 * The list addition should be visible before sending the IPI
-	 * handler locks the list to pull the entry off it because of
-	 * normal cache coherency rules implied by spinlocks.
+	 * The list addition should be visible to the target CPU when it pops
+	 * the head of the list to pull the entry off it in the IPI handler
+	 * because of normal cache coherency rules implied by the underlying
+	 * llist ops.
 	 *
 	 * If IPIs can go out of order to the cache coherency protocol
 	 * in an architecture, sufficient synchronisation should be added
-- 
2.31.1

