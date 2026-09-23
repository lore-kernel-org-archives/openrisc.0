Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639A247533A
	for <linux-openrisc@vger.kernel.org>; Wed, 23 Sep 2026 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790163063; cv=none; b=VcMdsx8IJREXtTbDtAnE9W9b6Uc5pyVMzJzou4NaNvENbRnkRT8WM046I3rtBbL9V++U0ZCgbtP1XBeOvYyECdkLfV0gvnb6TLA08fnrbNP7oYi0vXHrHEBgdJRMuY8Xt762EQMSH+coC61F1MIH+pm1iQ5uSScixDODmchUtb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790163063; c=relaxed/simple;
	bh=xqQ+NYvyXWCfjlyvjvxmg1kCwOY0kqb1jeO3C2JsWsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iMV5wT+pB4kinpI1CRlNw/2ij6EjKJIXKqneD4Cp76sAIohURxenx4uV7C1QtLT189VAMAg2Liw2E5VAlMVCpJjELcw0783X4IeIjeXkwp0pOUaFBXLK9of9578hSIaVuGKGXRh8aFA/RBKcmnRJaqcueqci3EXorNbBdH4dRZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nsz18lbF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nsz18lbF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790163037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xqQ+NYvyXWCfjlyvjvxmg1kCwOY0kqb1jeO3C2JsWsM=;
	b=Nsz18lbFVu6dNfd80MtDuQMgfIpx7EELPDC29vYgNYaUvA1NaQ4T3TlREjSWvWbQ5PpT8V
	e+IV/dhs7W5cp1g4d7Lmb1cb1rMQO36LcmYKLJ4u9PjUxmhC6aWNuidttbrMLpXpZgnqyr
	a9oNldzhNwnDf3M3i/NSZF5mOAXTfyY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-hU8g012GMpKeOZhxZhxwBw-1; Wed,
 23 Sep 2026 07:30:34 -0400
X-MC-Unique: hU8g012GMpKeOZhxZhxwBw-1
X-Mimecast-MFC-AGG-ID: hU8g012GMpKeOZhxZhxwBw_1790163029
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1EA81955E8C;
	Wed, 23 Sep 2026 11:30:26 +0000 (UTC)
Received: from fedora (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9573118002B6;
	Wed, 23 Sep 2026 11:30:13 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 23 Sep 2026 13:30:26 +0200 (CEST)
Date: Wed, 23 Sep 2026 13:30:12 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org, bpf@vger.kernel.org,
	paul@paul-moore.com, eparis@redhat.com, sgrubb@redhat.com,
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com,
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	guoren@kernel.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
	jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com, James.Bottomley@hansenpartnership.com,
	deller@gmx.de, ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, davem@davemloft.net,
	andreas@gaisler.com, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	chris@zankel.net, jcmvbkbc@gmail.com, tglx@kernel.org,
	peterz@infradead.org, luto@kernel.org
Subject: Re: [PATCH v3 14/14] audit: rename audit_syscall_entry_regs() to
 audit_syscall_entry()
Message-ID: <arO4RArEfB5HJqR-@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
 <0bb32d256099870f3f9ca2632cccf58538f882ed.1790088067.git.rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0bb32d256099870f3f9ca2632cccf58538f882ed.1790088067.git.rrobaina@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: Ysvn94qTaqMIXGO8BLLsR5kY9j6o7p97QtHRpAL86cg_1790163029
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 09/22, Ricardo Robaina wrote:
>
> Now that every architecture has been converted to the pt_regs-based
> audit_syscall_entry_regs(), the legacy audit_syscall_entry() and
> __audit_syscall_entry() helpers that took the individual syscall
> argument registers (a0-a3) no longer have any callers.
>
> Remove those legacy helpers and rename audit_syscall_entry_regs() and
> __audit_syscall_entry_regs() back to audit_syscall_entry() and
> __audit_syscall_entry(), restoring the original naming.
>
> The _regs variants were introduced separately, and the architectures
> converted one per patch, specifically so this final rename is the only
> step that removes the old prototype. That keeps the series bisectable:
> every commit builds, and no caller is ever left referencing a helper
> that has been removed.
>
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

