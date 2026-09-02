Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5164A43FF
	for <linux-openrisc@vger.kernel.org>; Wed,  2 Sep 2026 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360334; cv=none; b=GVT8fjNSlZ2hZrpH8VYNxZNR7dS/KAI+bGEL2w6LLRqOV+TpSRssjVdQ/QXGKguslDqo8yZfTSA/RyRs4XEcL7TF6hRv37Xv90U/zb54/Q4O4VQwnxtvwNChH3iro3cC38+G4+F0ZgNjwcBbd5ASW7snjFvnG2FQGgtGDVGtkUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360334; c=relaxed/simple;
	bh=jq17hbYLb63begqUlax0zfoLb1QS8lLPBPIiPSa6mk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Hljue748JFHe+v2KzbxmAEuI7dq37x/B2dP5k6SHTbnw4viQkYf2EbupmygR8RVgfBnfcXvQFGHQj2gUPGAKbeLJDEo2JbldB+UDy1fRyTE9r0l5/Sexi6NNKqZgu8+8+uzN2+y9zpj86SZjHrc2udr0K0kFmdiVIdwOQqhiieE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HAz92uri; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HAz92uri"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788360329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMrptk4mqYOQP3eWTGD3d/U/K/Lln3cM3PUoSH99Zx0=;
	b=HAz92uri3K/B+kn5ycFQoSW9lf0hT89ITYz72AcHZpNgqr4ZMH3HbSEv8dPc6xLKDmDIjx
	KRPRt83cA81rNsJAT/uqz4AfzSRGDGHkvUFRiEcoYcKGcnPS9iD+Nt2QUmTiyhj2CDqZve
	fM0Hy0jtw6BpA1z8CA70tCTDMW8ZhX0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-U63W3z6YNve8UdxmLpajGg-1; Wed,
 02 Sep 2026 10:45:24 -0400
X-MC-Unique: U63W3z6YNve8UdxmLpajGg-1
X-Mimecast-MFC-AGG-ID: U63W3z6YNve8UdxmLpajGg_1788360320
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B785195D03D;
	Wed,  2 Sep 2026 14:45:19 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B17831800641;
	Wed,  2 Sep 2026 14:45:06 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	bpf@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	sgrubb@redhat.com,
	oleg@redhat.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	guoren@kernel.org,
	monstr@monstr.eu,
	tsbogend@alpha.franken.de,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	tglx@kernel.org,
	peterz@infradead.org,
	luto@kernel.org,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH v2 05/13] csky: pass pt_regs to audit_syscall_entry()
Date: Wed,  2 Sep 2026 11:43:38 -0300
Message-ID: <83f97472fb90a20f84892b6686c2158027c3e06c.1788351089.git.rrobaina@redhat.com>
In-Reply-To: <cover.1788351089.git.rrobaina@redhat.com>
References: <cover.1788351089.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: nlODxYx4pSnSkhCK4z-_4YETzuX531TWV92kpbD4wKs_1788360320
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

audit_syscall_entry() now takes a pointer to pt_regs and extracts
the syscall arguments itself via syscall_get_arguments(). Drop the
individual argument registers from the call and pass regs instead.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/csky/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index ee2867a1576e..5c3051bcd78c 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -329,7 +329,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, syscall_get_nr(current, regs));
 
-	audit_syscall_entry(regs_syscallid(regs), regs->a0, regs->a1, regs->a2, regs->a3);
+	audit_syscall_entry(regs_syscallid(regs), regs);
 	return 0;
 }
 
-- 
2.55.0

