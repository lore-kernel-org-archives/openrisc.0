Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3833C454F
	for <linux-openrisc@vger.kernel.org>; Tue, 22 Sep 2026 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105040; cv=none; b=WYpbFPDM6nri078qlDWzlZ3+tu6tseQI9toDmfc4xkd28pcxToGN+GbBFaMXtWJVYpPw+cM48lZ4istfisnVxnE76chqoq6MN+EWu/o2Au272sGJdcTTYjim1cb8L+iM20+BrhNAFUsvnQd5qh7rcd3EGr+ou7lZzYcJShU1IzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105040; c=relaxed/simple;
	bh=AlEwOJCqXj75nlY4mRvsGPrbuus/qC7ZFbxnPlHbnpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Bn2tK9nbM25du7NPNU9obyafm9SFkbX9DyNC/ctqjfNbAlWBNCMfaNiqpsldYe02qiyu+YyTcXaJWHS2SGwsqdArPgVXihWqsqf5+ufw+vrAryhlks+uyK1ZVTeLac6lhl8QOcwAkkI3epTpAQB2/kHLYEPAhM9pSyrSdJTKocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FV9/cGm0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FV9/cGm0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790105037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4g6Pqq5n7M/gwYtRIbDe68QQcgDz6vnWXZj4Z/2+yek=;
	b=FV9/cGm0+tKvkj4KlE/MMnFb1qUgjs6bO0jeokQHEz9l2nzyJMlCh9cjWFfQSPxYq/qyzu
	2ybP9CG8Zw+d7BrZpGV00vqx+M5Se6wqblmogmkpbpRQrODpU7Vew4zLgBnT1BN7e1K2yB
	OQx0tzmkWmRSWL8eWf/DrtZjjBqOtVY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-WgDPjhSqNVm4ukglLylNhQ-1; Tue,
 22 Sep 2026 15:23:50 -0400
X-MC-Unique: WgDPjhSqNVm4ukglLylNhQ-1
X-Mimecast-MFC-AGG-ID: WgDPjhSqNVm4ukglLylNhQ_1790105026
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3BAE1955E87;
	Tue, 22 Sep 2026 19:23:45 +0000 (UTC)
Received: from wsxc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E03C63000223;
	Tue, 22 Sep 2026 19:23:26 +0000 (UTC)
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
Subject: [PATCH v3 08/14] parisc: mask compat syscall arguments in syscall_get_arguments()
Date: Tue, 22 Sep 2026 16:20:00 -0300
Message-ID: <65f32a82d590b11984723fa6f26ff96175679f9a.1790088067.git.rrobaina@redhat.com>
In-Reply-To: <cover.1790088067.git.rrobaina@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: tC0GyQrsHA45_dySHyiU71hB8Xl-5h5RCD92pl7J0qY_1790105026
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

A 32-bit compat task may leave garbage in the upper 32 bits of the
argument registers. Mask it off in syscall_get_arguments() so that
in-kernel consumers such as seccomp and audit observe the same values
the syscall actually used.

This previously happened for audit in the parisc do_syscall_trace_enter()
compat path; do it in the helper so all callers benefit and to prepare
for passing pt_regs to audit_syscall_entry().

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/parisc/include/asm/syscall.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/include/asm/syscall.h b/arch/parisc/include/asm/syscall.h
index c11222798ab2..9d10fada3b48 100644
--- a/arch/parisc/include/asm/syscall.h
+++ b/arch/parisc/include/asm/syscall.h
@@ -28,12 +28,18 @@ static inline void syscall_get_arguments(struct task_struct *tsk,
 					 struct pt_regs *regs,
 					 unsigned long *args)
 {
-	args[5] = regs->gr[21];
-	args[4] = regs->gr[22];
-	args[3] = regs->gr[23];
-	args[2] = regs->gr[24];
-	args[1] = regs->gr[25];
-	args[0] = regs->gr[26];
+	unsigned long mask = -1UL;
+
+	/* Mask off garbage in the upper 32 bits for compat tasks. */
+	if (__is_compat_task(tsk))
+		mask = 0xffffffff;
+
+	args[5] = regs->gr[21] & mask;
+	args[4] = regs->gr[22] & mask;
+	args[3] = regs->gr[23] & mask;
+	args[2] = regs->gr[24] & mask;
+	args[1] = regs->gr[25] & mask;
+	args[0] = regs->gr[26] & mask;
 }
 
 static inline void syscall_set_arguments(struct task_struct *tsk,
-- 
2.55.0

