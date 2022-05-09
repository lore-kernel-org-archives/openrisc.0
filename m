Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EF5C43219
	for <openrisc@archiver.kernel.org>; Mon,  9 May 2022 22:32:31 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 9943C24911;
	Tue, 10 May 2022 00:32:30 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mail.librecores.org (Postfix) with ESMTPS id 613C42490D
 for <openrisc@lists.librecores.org>; Tue, 10 May 2022 00:32:27 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id n18so15184549plg.5
 for <openrisc@lists.librecores.org>; Mon, 09 May 2022 15:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=08o9m5Hkc1DwgHXwEhIgYa1O84W5gO7UU5kFrcD0IRY=;
 b=Ivfni2BR3drjv+XoR/hBXUrgG62qyubSK3Ofq7nGB2uI3j7DeKiw7jRrhjYIPRgbiL
 fX9foK05Y7Jog/gVmvwsgPmkiISwecG0vWlaNbZPsib7PJe/U0FrjNlpjZeqJTMnA4Ud
 xD2a5Ri7G1reYFJHWM8J0ABchfZtYYpFEJm7EacP6oMYWcpyn/f0Z1zDck1YxAxeMMcF
 un3MVzMWYPTLkAP7W6QyxETK9WwzzVdbB+7M0G8w56mYUpSu+iAgFJ/e7C0edwi86i0F
 9CtnFPdWIKaX25L03L6TPjghHJhiIfuQAKj24e211/mTSajbwfjFHu6V4QDWxV3ozgp7
 ADmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=08o9m5Hkc1DwgHXwEhIgYa1O84W5gO7UU5kFrcD0IRY=;
 b=qMUFw+6UtPV/f292s4SDrsq7sH0N3tyt1S7dyVhZC9+Jah1vgjyOa/n4XpVfwcd4Jc
 BMMxHvVwAxnA59/lgzgfq6cqCerxA/966Um25DSRYuMX7uN/ZositrhaWvJzF6s4W6cO
 GcDmw+MCZMdvmiJvXrM7wME9Gbc4vX61ubN/npzRbOy+766TzVD4WHOs7fbIDaIsLr78
 T7R9KGWBAw6oIk4lbXuypUJFD1SAAmIDh9ZMczaeCwwZ/eRfyje/pM1dYkH0R/Dr1YE4
 DhYr3w3wNpW74qlM11HHEC5RdDKskIpCuqtl791BIl9CpSw7Dc+XUrj1NbRjVTj680nW
 MDwQ==
X-Gm-Message-State: AOAM530Pf8RYFXPwLWA+p2frtty5/ET5Ohe6m7T56u0QC6aF7GxCjOWB
 URNhm6BCnaHjONlAOkqmNKQ20w==
X-Google-Smtp-Source: ABdhPJwfKDrkaUHJSNgn6XFJOuCcJbR4otch9RHfl10t4H02hdxl8ivFVYd6BH4xCpPZNyXowDk67w==
X-Received: by 2002:a17:903:1205:b0:15e:804c:fab4 with SMTP id
 l5-20020a170903120500b0015e804cfab4mr18051563plh.112.1652135545965; 
 Mon, 09 May 2022 15:32:25 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223]) by smtp.gmail.com with ESMTPSA id
 oa7-20020a17090b1bc700b001dcc0cb262asm224098pjb.17.2022.05.09.15.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 May 2022 15:32:25 -0700 (PDT)
Subject: [PATCH v5 2/7] asm-generic: qspinlock: Indicate the use of mixed-size
 atomics
Date: Mon,  9 May 2022 15:29:51 -0700
Message-Id: <20220509222956.2886-3-palmer@rivosinc.com>
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

From: Peter Zijlstra <peterz@infradead.org>

The qspinlock implementation depends on having well behaved mixed-size
atomics.  This is true on the more widely-used platforms, but these
requirements are somewhat subtle and may not be satisfied by all the
platforms that qspinlock is used on.

Document these requirements, so ports that use qspinlock can more easily
determine if they meet these requirements.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 include/asm-generic/qspinlock.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index d74b13825501..995513fa2690 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -2,6 +2,35 @@
 /*
  * Queued spinlock
  *
+ * A 'generic' spinlock implementation that is based on MCS locks. For an
+ * architecture that's looking for a 'generic' spinlock, please first consider
+ * ticket-lock.h and only come looking here when you've considered all the
+ * constraints below and can show your hardware does actually perform better
+ * with qspinlock.
+ *
+ * qspinlock relies on atomic_*_release()/atomic_*_acquire() to be RCsc (or no
+ * weaker than RCtso if you're power), where regular code only expects atomic_t
+ * to be RCpc.
+ *
+ * qspinlock relies on a far greater (compared to asm-generic/spinlock.h) set
+ * of atomic operations to behave well together, please audit them carefully to
+ * ensure they all have forward progress. Many atomic operations may default to
+ * cmpxchg() loops which will not have good forward progress properties on
+ * LL/SC architectures.
+ *
+ * One notable example is atomic_fetch_or_acquire(), which x86 cannot (cheaply)
+ * do. Carefully read the patches that introduced
+ * queued_fetch_set_pending_acquire().
+ *
+ * qspinlock also heavily relies on mixed size atomic operations, in specific
+ * it requires architectures to have xchg16; something which many LL/SC
+ * architectures need to implement as a 32bit and+or in order to satisfy the
+ * forward progress guarantees mentioned above.
+ *
+ * Further reading on mixed size atomics that might be relevant:
+ *
+ *   http://www.cl.cam.ac.uk/~pes20/popl17/mixed-size.pdf
+ *
  * (C) Copyright 2013-2015 Hewlett-Packard Development Company, L.P.
  * (C) Copyright 2015 Hewlett-Packard Enterprise Development LP
  *
-- 
2.34.1

