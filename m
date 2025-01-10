Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7D20ADCE;
	Fri, 10 Jan 2025 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504597; cv=none; b=NRJbiC8enSQCMdfB1uztiKLWSv6rJ3jBm9DktKpB5j1dTsx/FBxdWxPzOp5ZfrCs1b7bevBzCMDqbIYzbpIBZPxbxlkT9YUHRFAbyAp8NqJX9h4SJIcceMHlpd4gQmB/QX27+HjXgU9vvtdF/om2boJ9WdhiC/MNtoYR4rBDNvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504597; c=relaxed/simple;
	bh=aSksDJkZ1WmhNpSVAXGfqli4L4Puo5jL2h6gFHsx9QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBs4EUSQnuYr9ylMwo8Q+UtwEU11dazwaX/gVcHdzddq64fNpt/flR5aFMKs2kZMwOOWHjgD/aqptvWTYX8DR60PhrLBIMyj7U0BqQjOODq1iaNeCFC4bkcy0ACRKXFVD4hpknHLaYiBgdQShNdxi32suWNhrsGpzEhezI+1dAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ix3WzU2j; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix3WzU2j"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385dece873cso986426f8f.0;
        Fri, 10 Jan 2025 02:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736504593; x=1737109393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teWKZxJyk/aKggT0W8GcfH9G/8aXzY8HN+NxidR4DNM=;
        b=Ix3WzU2jmSMSuyzztQAukR0EX0ep9eMmwMno7mmE7edQcHmSC1QXcC8otffhiZUkpW
         91tnhgRPYA/IbOS6Z32SLsQ6rT8Y5LVCfj33N0OW5sOhO/gc0z1LRQBy6t+YVjHRlReC
         uk0/zfdnJOtb9Q/AI9QGLWQXodDwRJFNJwiLTPAPMPjC6IXwqb/5JgdLyw+E9XUuxAoJ
         lthiec6cJX+YI+JZV41Uln4bP5680H0HtadBhzIYF6EgftJZ7/vgHJix9ZtxoTWARCxc
         aChmCv/A0r8W0uTZUoPH0uv/MLlN3qS47zNpR4RulaB2Owyg+Zyj/Bz66ogP+QFz/3Fv
         7eCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504593; x=1737109393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teWKZxJyk/aKggT0W8GcfH9G/8aXzY8HN+NxidR4DNM=;
        b=PiUubxppKrLRJhAj8GU/8z/0O3BJKjktByUFrmYo/0OWFt/1NL9EnivvRVqtzFkyqx
         58RpqdhrVq7OaKkliP13RPy0uzJnPUdr+rwgwuE9cIkoZtqtsmbsqcus8a2i0vGE8Dde
         vsaqZI+Y6W2T6lORi2EPiMNvfsia464bVGp4HgQoT25QnhWmcnkZKsAYipE2XK2k0b8T
         GurP7zWkUrjLuB8/dylS2VIMNlPMVH52YXDNFYuio8obutuH9Wi/UmEn1YUxFEr4zM0x
         7z+0hxXbfiw661ITc1zgZO8yNnm5f1WyQvhXK0X2Xn/yZ5IszwZdJkcGPYUCXi6YL/lg
         06Pg==
X-Gm-Message-State: AOJu0YyG0hAiCeq2r77qp3gJf1n+woX5yyeeFdnR03xJVKPJ/Xn913C8
	Ez8upPpvZeGDeJ0ur3JbyUXmgtAuM+Vo9bgYfJnUcPGWwu/0VqU6hiTZkV4q
X-Gm-Gg: ASbGncsJizv6RGnyYUjNxU2vQDnNl/Y64l7aa1G+0zxkDWPfQi0F+Yw441jXEkmrnp+
	Nh08SG9nbVZp0uCwsAgEWzex9frMqJvJze4+4lu9AhyNsa3wCoX3aCQxcr4e3GdSfffDbVjbgXZ
	2fwNLy1gKDZLsUJIU11i1x9HANThv5UL9OR9j1y9lan0HQpm1fUEWX2w3mL5ul+JEXa00W3aUTd
	d7JC4NMF8TBk3qMFkF699GmGa7cdDigJEhAjMtjFRHJdl5AOmpCPL/NAjjs1pLjf0UCqd/ljEGE
	V5ndDJDtLCvmMIfEoN9r
X-Google-Smtp-Source: AGHT+IEcUlcCS6sOXSg2+yaOTA7FHERGgIC4IbmhSMVJGS0CKLLAzbY3QNjfUTaixxeDDG7P3ou6cQ==
X-Received: by 2002:a05:6000:709:b0:386:3803:bbd5 with SMTP id ffacd0b85a97d-38a8733a1f9mr10060402f8f.45.1736504592702;
        Fri, 10 Jan 2025 02:23:12 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1b44sm4177554f8f.90.2025.01.10.02.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:23:11 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Rong Xu <xur@google.com>
Subject: [PATCH 2/3] openrisc: Add support for restartable sequences
Date: Fri, 10 Jan 2025 10:22:44 +0000
Message-ID: <20250110102248.3295944-3-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250110102248.3295944-1-shorne@gmail.com>
References: <20250110102248.3295944-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support for restartable sequences on OpenRISC by doing:
 - Select HAVE_RSEQ in Kconfig
 - Call rseq_syscall() on return to userspace when CONFIG_DEBUG_RSEQ
   is enabled.
 - Call rseq_signal_deliver() to fixup the pre-signal stack frame when a
   signal is delivered on top of a restartable sequence critical section

Cc: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig         | 1 +
 arch/openrisc/kernel/entry.S  | 4 ++++
 arch/openrisc/kernel/signal.c | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index f2be2a88c286..87996dde394c 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -27,6 +27,7 @@ config OPENRISC
 	select HAVE_UID16
 	select HAVE_PAGE_SIZE_8KB
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RSEQ
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index ce6f2b08a35e..c7e90b09645e 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -714,6 +714,10 @@ _syscall_check_trace_leave:
  * interrupts that set NEED_RESCHED or SIGNALPENDING... really true? */
 
 _syscall_check_work:
+#ifdef CONFIG_DEBUG_RSEQ
+	l.jal	rseq_syscall
+	 l.ori	r3,r1,0
+#endif
 	/* Here we need to disable interrupts */
 	DISABLE_INTERRUPTS(r27,r29)
 	TRACE_IRQS_OFF
diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index c7ab42e2cb7a..f70a13ee0593 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -244,6 +244,8 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
 	int ret;
 
+	rseq_signal_deliver(ksig, regs);
+
 	ret = setup_rt_frame(ksig, sigmask_to_save(), regs);
 
 	signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLESTEP));
-- 
2.47.0

