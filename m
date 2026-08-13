Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92BE4963A7
	for <linux-openrisc@vger.kernel.org>; Thu, 13 Aug 2026 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640683; cv=none; b=RZ9FistzlVGHFlHXuut6UGZsdJWUCa/NvogQJN0qh76cpzpt/PAunf3F1r7UNEbDiokJrX/7+3bsYs/kymfCUaWqnqZ4SzfXS338teEAGfMqBmP/aE89gcQWKliLSutdNjXmkQNie1KHbz4SybRXbBuvxr5UzDaOonSSD2FE9jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640683; c=relaxed/simple;
	bh=CNJuBEFpfNHhwlYW7A4OqSS81mlR/xDc5WSiAgnzZ/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UpIyF+cU6TRJ99mqbuCrERW5NcyEOcxuzAELRKFvNl0wua2+UmHF2xwDR9qDaptX6KGA2lsvJDG9h9J6Olm81aM/zOa1DbzjhPbsNld/4rCZFl0LF/p3kJIEeoSX9wUj1DwyyY8fvjoKN5ioLVab3VslSVkQY4IP9s8p/lStpSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6d/10CP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6d/10CP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7xFlZn2dL19In3v56MGA4NWAnpSd0AP0zpWmikwEks=;
	b=b6d/10CPAu39b5OGQlgCsMS/YRRpvgQsNtVlRCaT25DjsLQD6Q7/7WbvWB0KYWgWCC2YAT
	Y9qwRq9L7rbXNaAUIF4hdFZBlpQrlWvZlMI6VhN6XMarnm9EjC1Tyesb0IFfue2WBCgLVj
	HzEbpgpFeTnCV7qbcOhN5D0etydPKVE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-F1ZGOoBaOWWr19b0IGlNbA-1; Thu,
 13 Aug 2026 13:04:34 -0400
X-MC-Unique: F1ZGOoBaOWWr19b0IGlNbA-1
X-Mimecast-MFC-AGG-ID: F1ZGOoBaOWWr19b0IGlNbA_1786640663
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1D601955E7A;
	Thu, 13 Aug 2026 17:04:21 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CEE67195DF98;
	Thu, 13 Aug 2026 17:04:06 +0000 (UTC)
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
Subject: [PATCH 03/13] arm: pass all six syscall args to audit_syscall_entry()
Date: Thu, 13 Aug 2026 14:02:53 -0300
Message-ID: <4f787a0c2a27eb919c481875b61a7467ef8ce547.1786626275.git.rrobaina@redhat.com>
In-Reply-To: <cover.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: Kq9aZ_4JVFTqEB3CM6uRMK10cdr3za2yYUiNp4_HgBs_1786640663
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Update the audit_syscall_entry() call to forward the 5th and 6th
syscall arguments (ARM_r4, ARM_r5) now that the audit core logs
all six.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/arm/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 7951b2c06fec..ace74207738d 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -869,7 +869,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 		trace_sys_enter(regs, scno);
 
 	audit_syscall_entry(scno, regs->ARM_r0, regs->ARM_r1, regs->ARM_r2,
-			    regs->ARM_r3);
+			    regs->ARM_r3, regs->ARM_r4, regs->ARM_r5);
 
 	return scno;
 }
-- 
2.55.0

