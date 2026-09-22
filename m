Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B764A260D
	for <linux-openrisc@vger.kernel.org>; Tue, 22 Sep 2026 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105056; cv=none; b=h3sjSYCyGZ9coC3/xZNRlIwxzwCd0dYhQ5wVpL71ou8pNbSV8sW9+itx2wOm3cv1/KBr3tz7un7FqPc9gPan+ARmaW54qv3v4W2nAkfcdW/xy6I/WS53BUamM6n7Y+hQUEjXuQDK5VasY14eO+EN7/TQCsINm1RJcswAPBWh6oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105056; c=relaxed/simple;
	bh=1YIRcw6TVMcmgO62i3P5UTqUzmBXzR6bwpjqAvgmaHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=PoKMO5FmMi4ylUu8El7naUfyiYJJ7UPmao+8iXkaai25xUX1fu/79N9D9Efv2XbMyOrOseEahK1bNxZ3qvTeMbTrR6lN6SCYbIto9dZS83NLm02P2eBWYLKky+wwSjhqo0g3wlmdAjmTHmm8mkvdZHSZ9T6bRPa1wRRfTYvgXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKXOSQAO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKXOSQAO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790105050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BCkLKZy59p7aSSwyfXTPaoOl48Jr0ljTw2NZSx5GJk8=;
	b=dKXOSQAOAD63cpNmSpS6i1p7Pm6kopH0dig3xJ4FtYD4N3yWAWpXIg+jTUwuEW9RFGzcv/
	tZVpP1OVpzkdApiNkACNTMLSLX7gDFGYrE2WPevVOopBbnabSt+3X0ADcrVfRnPxQLU0ER
	e82/CB7U8ZmDv1XG2gJrObi3tnN23I0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-IW0o-oMYNpOyqGDeiDJV9Q-1; Tue,
 22 Sep 2026 15:24:06 -0400
X-MC-Unique: IW0o-oMYNpOyqGDeiDJV9Q-1
X-Mimecast-MFC-AGG-ID: IW0o-oMYNpOyqGDeiDJV9Q_1790105041
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BC1E1956050;
	Tue, 22 Sep 2026 19:24:01 +0000 (UTC)
Received: from wsxc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA19B30001B9;
	Tue, 22 Sep 2026 19:23:47 +0000 (UTC)
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
Subject: [PATCH v3 09/14] parisc: pass pt_regs to audit_syscall_entry()
Date: Tue, 22 Sep 2026 16:20:01 -0300
Message-ID: <385724169e030185dc9e0deefb52457ba5581090.1790088067.git.rrobaina@redhat.com>
In-Reply-To: <cover.1790088067.git.rrobaina@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: P4OfOYBxji24NdMSKFC6Q39vcHqVpTgQz7LAlHZZ270_1790105041
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

audit_syscall_entry() now takes a pointer to pt_regs and extracts
the syscall arguments itself via syscall_get_arguments(). Drop the
individual argument registers from the call and pass regs instead.

Per-argument compat masking is now handled in syscall_get_arguments()
(see the preceding patch), so it is dropped here; the syscall number
still needs masking for compat tasks and is left in place.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/parisc/kernel/ptrace.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index 1d9e210702e1..4e62d6bd6466 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -359,15 +359,10 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 
 #ifdef CONFIG_64BIT
 	if (!is_compat_task())
-		audit_syscall_entry(regs->gr[20], regs->gr[26], regs->gr[25],
-				    regs->gr[24], regs->gr[23]);
+		audit_syscall_entry_regs(regs->gr[20], regs);
 	else
 #endif
-		audit_syscall_entry(regs->gr[20] & 0xffffffff,
-			regs->gr[26] & 0xffffffff,
-			regs->gr[25] & 0xffffffff,
-			regs->gr[24] & 0xffffffff,
-			regs->gr[23] & 0xffffffff);
+		audit_syscall_entry_regs(regs->gr[20] & 0xffffffff, regs);
 
 	/*
 	 * Sign extend the syscall number to 64bit since it may have been
-- 
2.55.0

