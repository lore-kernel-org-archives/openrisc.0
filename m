Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D30E2D73B5
	for <linux-openrisc@vger.kernel.org>; Wed,  8 Jul 2026 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526694; cv=none; b=JOWHOWhtp1wleYVBQv0AnFwBf4Le27BED+v9Oh5QV5Ctoy6Hw1Jq6gzQ3YHOz3xn9Ef/98wIeIxfR5ppS6MgXkgDebniepeQIdEmscj88P1MQgaPEiGpkZ3VDdsd2euKMYF3JzPs9TbYHvnBifiit2eRK3y7MzRn2OCbXm1o46U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526694; c=relaxed/simple;
	bh=rkZTTrKDp1fLIJPaNfi+EBow6fHXCvgjUtBGn831Gm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VHWLubw5n0vT6l04/KQa4AFwrhwEnk6ymzWXQZTyr9fkBTi69xJxL1xsJEdVSWRzqzerjvpDVOLOsLTcJJFKmvtzMqCJfXG9nbsCarIBHJxMr8SKfqJrpUZYkEGonk3WV3mOci8PggF6IiqjqwMCv0Xhki2TGi3iVUswklUYmIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DXkP4w0r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXkP4w0r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783526690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8P/ciXzD2S1KvjG8yWg06YK1HrAoM9H+3p3KtWGqU68=;
	b=DXkP4w0rBXsaquakZkFNg378WjVFF11CDC/ygj7fE62vO3j7dkySjU/q2j+dBcG0UJ2rko
	wA/l7apmXIWoiY1fcCnEH05AXzI2wFG7/8qoMDJ154bjTJsrGMtECmeZhCRQSvn4vdsyTh
	hFmkJT1eAy6dgerv3b05nh6pO/AZPMw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-fn1pYKmRPGGlbjH-rSP4QA-1; Wed,
 08 Jul 2026 12:04:48 -0400
X-MC-Unique: fn1pYKmRPGGlbjH-rSP4QA-1
X-Mimecast-MFC-AGG-ID: fn1pYKmRPGGlbjH-rSP4QA_1783526682
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E37718009D8;
	Wed,  8 Jul 2026 16:04:40 +0000 (UTC)
Received: from fedora (unknown [10.44.33.83])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1D1D21956040;
	Wed,  8 Jul 2026 16:04:21 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  8 Jul 2026 18:04:39 +0200 (CEST)
Date: Wed, 8 Jul 2026 18:04:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Richard Weinberger <richard@nod.at>,
	Chris Zankel <chris@zankel.net>,
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	Brian Cain <bcain@kernel.org>, Michal Simek <monstr@monstr.eu>,
	Dinh Nguyen <dinguyen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 11/18] seccomp, treewide: Rename and convert
 __secure_computing() to return boolean
Message-ID: <ak51A77h1YRIl5tz@redhat.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.230735780@kernel.org>
 <2e6ed364-ce8f-4b4b-8675-acd07f140f4f@huawei.com>
 <871pddsuzl.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <871pddsuzl.ffs@fw13>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: r-gnuD77RnbKbkU05GuywJt2BJvK8ET9eUNQhgMncVk_1783526682
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 07/08, Thomas Gleixner wrote:
>
> On Wed, Jul 08 2026 at 09:43, Jinjie Ruan wrote:
> >
> > The return value of __seccomp_filter is checked in the wrong way, check
> > -1 should be replaced with check false, maybe:
> >
> > -               if (__seccomp_filter(this_syscall, true))
> > -                       return -1;
> > +               if (!__seccomp_filter(this_syscall, true))
> > +                       return false;

Or simply

	return __seccomp_filter(this_syscall, true);

and remove "return true" below ?

Either way, I personally like this change, I was always confused by these -1's.

Acked-by: Oleg Nesterov <oleg@redhat.com>

