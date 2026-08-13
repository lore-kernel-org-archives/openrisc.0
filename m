Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8470E370AE7
	for <linux-openrisc@vger.kernel.org>; Thu, 13 Aug 2026 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640714; cv=none; b=l++SOZxZHm4MLT5PCfQiFUIzFCRVCxYiHeNiFj9GuoTLr8E5EeIRf0v/CycpcodqtpBVY5QupFvVXVZ8aOLcMh/DbH5cPhz2YzjB6sDTl3cysuUYuBEUtXDHfFLKy1kXU0oehTKVUFSAOV59mPZyixk/Rv9/dtyrHV+9WIFsW1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640714; c=relaxed/simple;
	bh=GbfZpaJBd81q0U+Y+6xRQMaEOr/17VF6ef/kRJ6DddU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=krIvkhLbLPqgNM3DA8MJrsqjJiDVcSBy0dxpDReY3FXeYZZlPJNhpTBZh+wZK6/tpGmDgq10TJAUmJlzhFRI/EVlS4+V5mN3H3XnwqcmdzHvL22wLsN/xevuOCJ573i/WACJ9l6erNUcOQ2vub5XAiRVZjBHiR3uvCuu3sSFz1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cEewR84v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEewR84v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hWmoGsUF+splwZL2Jc4XbPhM/cn3FE+Io5Xgg3E/U0=;
	b=cEewR84vz2bIl+7g4QF67ur8QYFsSJ5bqeUkzPs2h8GOjZjcWP+ufRt3JuMCTPF1p3+vui
	cffDOeO8OJXEPznAEUB0F6W1zhprpXBpoDlv/lO12wi7cKb2+7ajF0JnyPoLeFLZWPiCJs
	kt7YtsqOzFxgw/5lZrlwdOe9TASkGY0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-gbL4XSmqN4CGUkdxqhGf9w-1; Thu,
 13 Aug 2026 13:05:07 -0400
X-MC-Unique: gbL4XSmqN4CGUkdxqhGf9w-1
X-Mimecast-MFC-AGG-ID: gbL4XSmqN4CGUkdxqhGf9w_1786640703
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80F231955E76;
	Thu, 13 Aug 2026 17:05:02 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 85526195DF98;
	Thu, 13 Aug 2026 17:04:49 +0000 (UTC)
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
Subject: [PATCH 06/13] microblaze: pass all six syscall args to audit_syscall_entry()
Date: Thu, 13 Aug 2026 14:02:56 -0300
Message-ID: <eb3d7ae5d98f6b377a376bdb4dd1b80dfcda8922.1786626275.git.rrobaina@redhat.com>
In-Reply-To: <cover.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 77EyL5NzIRhL0-jgnIMk00qcsV7MWObnDpx0LuCtXOs_1786640703
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Update the audit_syscall_entry() call to forward the 5th and 6th
syscall arguments (r9, r10) now that the audit core logs all six.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/microblaze/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/ptrace.c b/arch/microblaze/kernel/ptrace.c
index 5234d0c1dcaa..21bcd8dfe42d 100644
--- a/arch/microblaze/kernel/ptrace.c
+++ b/arch/microblaze/kernel/ptrace.c
@@ -147,7 +147,8 @@ asmlinkage unsigned long do_syscall_trace_enter(struct pt_regs *regs)
 		 */
 		ret = -1L;
 
-	audit_syscall_entry(regs->r12, regs->r5, regs->r6, regs->r7, regs->r8);
+	audit_syscall_entry(regs->r12, regs->r5, regs->r6, regs->r7,
+			    regs->r8, regs->r9, regs->r10);
 
 	return ret ?: regs->r12;
 }
-- 
2.55.0

