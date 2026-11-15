Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707574;
	b=sfI06+eSjN3kp5cAJPvbd+AnMpQD1RJ9GwjR9i1G8FKY4RwHLOPuR2mMO6SrfXUN9Qin
	 jCBnyha+M4qVUXL7pzOTtLzEj4GL610KAiFzTy7Hinx7bFC3RH8rhd0ykLTcEdSE3xyYr
	 j7Mc8UXvo0BTL61EoKOhnXT7nTeQZf1kB/h7siJ2RZdXlrF5Z7K7ZTI/bkQ+dRU5VxB3L
	 V38LvWik1jfPdM6v0OvKD2oxq1x2OGoaE67vNhz5jEPmIX4G+f6F0V8dIsDBsPa2VRXkp
	 3h5Txc1BAGZPcnRAS1fvNOuYSMD8eJ5y9eU5q3RYFGUfaqU9fZ93IBeYSDILIRag9RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+ejYmTs6mWnDyApUtB1ZIDj1lWthS9/CwrgCU+uOWhs=;
	b=hhPEpj/cBruJ0EsxWsMYpfoz95JVL7dJTAUwOPL2xmuAxIXKxa58sb+WoNjONMMGAaoJ
	 yOgkTI82F06aZZHlqhBZCG0Zus4K97UxkYOqSfD8yyJBa7Mc8/kjOIIUzm17e7I6bcOVD
	 lS5Tt+rhBIDa8CAZpG9IRWduo+LKHmKKtZUQ0HO9JRVMdXkRdDZSViDn/P4Gxq/QtsRz7
	 +c8TkP5gegVXLjd7TZcqPkWGYGMz7xagN4x6Bg8bvlyeunlHYvtSPvzeu7KPY+qfjPNwW
	 iYlpG+MaQhcZPuGqFq2CtLmpOoHcceMkft2qkHOalhhjpN5xm8lyE2Yn1q57kVjvndA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=krssnxES;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E919606A323
	for <linux-openrisc@vger.kernel.org>; Sun, 15 Nov 2026 01:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E919606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=krssnxES
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4919a880834so1065494f8f.0
        for <linux-openrisc@vger.kernel.org>; Sat, 14 Nov 2026 17:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794707572; x=1795312372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+ejYmTs6mWnDyApUtB1ZIDj1lWthS9/CwrgCU+uOWhs=;
        b=krssnxESzo9GaRXDH2qg++cHod8q/wIiofiMVhzU6IM3OLpyAG/Ozby9mU9ASLrBcV
         WU3+jLr5T9C3o4JT0i0nKRudNXDOVRei2ySxN8WhWT6FFXFj2ioddNtAhcn4tGqqi/jR
         K1w8K3GFcprQVHipESSL5qtuDsyG0u1KqIwjABdAk+NWFEVJOtsOOBeEDSab+HeCsETo
         XvXmZ2NczFJNZdBJ+3H1m5zPe2TY8BOAXyv8ukeiqOW4zhwIgLLl3C+9xtc2b/2wQJkh
         SLdhhZ+02lc24gwX5TQ0Y0a/SEnHNlNfODITC2y3BbjZL9gz8l86BRaxv7FuqGRKA5Mf
         k9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794707572; x=1795312372;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ejYmTs6mWnDyApUtB1ZIDj1lWthS9/CwrgCU+uOWhs=;
        b=UVAd2UvROS2qEE/u/P8GN+Sy9KeyrnZ1xmMfTqUGzCuKa8s2gnSXx1dYxi8sX+uJg+
         FS2NBkpyF3djlJZ6VcG7TQ498BO8zwyFJRgflxOKC8VvRC0zHPomT9bm6xl8MXAl1rj5
         1RQWY4n96T/4Iv/XRfVuo1zx9ikUlR76SSsKsj4X8sstOAr9E3Wt5BA7Gvo2U2Ap6193
         H21Pjkm2tf3Yzn0p65Y7e8Gk1r1CauaUfrQd9nPk/B8TNYnvo/jL/uaLgpOlj3BrsZaW
         S3QqpnAhQ0HyMAJXmgx5uzYlwPqhm03X7YJoxjeQEDT7mU3JFzMVmuaYc7fE8PwrMBnB
         emZg==
X-Forwarded-Encrypted: i=1; AL+hErEwTJlB+Eji8bEPBb2h8JQwAv38j79vW3eRxhVAC8rDczpXKJu9ttbmvAOm0GggSgjmMyF02nsIoI5QNY8aYA==@vger.kernel.org
X-Gm-Message-State: APuU4Z96Vzv7UmoiwXuyvsZ/19ALYnc7efaEzuJsjc39sIb+Mkaxy408
	5Zfsegl8brlU/l+vZCac8tKTIW+E2p9A5GkM5NZtKgU53hQVQ2pnuDOD
X-Gm-Gg: AYBFou18pZ1RniggfJFTgg/fS0c1DCYWRpLyGOXRMDi1JNypQ5jryd0kQJlycRC/HEx
	kWCOMPm2ui/6i/jpqzwbFb07M93T+MRlXw+bgwLvCkd9mTfSgIiWRdEQzK8ccfW2PeNcLQr4Fn/
	PyOI8KqoBA+0UnVfq9KjeZTXl5NPaKXLN+r9vocA328Hx1zRrhVCnHI5+Q+xEa+f90M85GvyGVm
	hCl4C4tJ9XV6Sw9AQn/944PS++/zDImLENx5DGIFD8Cu21BH4VSAA9XP0ICu786iYZk5XDiRQiR
	zd6Vcup25rQdhBwveBTfSmjbn1m9yw+i/+uxfYG5xkLDDuZvIN0dqqcLonCAjEZ23qSM2+RvmjH
	p9f9QL9zll51gclffd/Ugdcbu1ttbNhz3fmeDCZ7cUTJmtl5lJ9pQoh0DlIKFVDd+vtqnyB11Vb
	rCnVSUmZwDdzw0ZmmLJlM04F9vtVAQr9rj0DrvYPCYjCm3zD9Idz/3qu1sZhUR/v42h/bKekpva
	ha3LRJZZ5kPqswZM+4rgFMde7FznxnfLtmYdMgpxuqtDHzbvu1dSc89mnEjlraZKc2gA6ptRfQZ
	M2jHJ6yQOyWuMcaVWUFqQL8GsJUaT67J5rSlvEZ1Ocm8hTqbGC5wgSVrgrrWncGe0bJFbVpbxaX
	oGEGTeox31T38TnufPQx+X6AfXF8E
X-Received: by 2002:a05:600c:548e:b0:4bb:5c92:ce12 with SMTP id 5b1f17b1804b1-4bb5c92cedemr107415355e9.17.1794707572354;
        Sat, 14 Nov 2026 17:52:52 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb679b7e1asm112112405e9.6.2026.11.14.17.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 17:52:51 -0800 (PST)
Date: Sun, 15 Nov 2026 01:52:50 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil <sahilcdq0@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org,
	pjw@kernel.org, wangruikang@iscas.ac.cn, namcao@linutronix.de,
	kees@kernel.org, linux-openrisc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] openrisc: Add unit tests for KProbes on branch
 instructions
Message-ID: <avkQctt0CKt3YcsH@antec>
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-4-sahilcdq0@gmail.com>
 <avAsy43KVO-7Nm9z@antec>
 <dbfe2a41-c99d-4f00-ac0d-2b2b31a72986@gmail.com>
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Post: <mailto:linux-openrisc@vger.kernel.org>
List-Help: <mailto:linux-openrisc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-openrisc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbfe2a41-c99d-4f00-ac0d-2b2b31a72986@gmail.com>

On Fri, Nov 13, 2026 at 10:45:03PM +0530, Sahil wrote:
> On 11/8/26 1:33 PM, Stafford Horne wrote:
> > On Tue, Oct 27, 2026 at 01:42:39AM +0530, Sahil Siddiq wrote:
> > > Tests already exist lib/tests to verify the generic functionality of
> > > KProbes. Add unit tests to verify that KProbes work on instructions
> > > that require simulation in the OpenRISC ISA, and that the corresponding
> > > delay slots are handled correctly.
> > > 
> > > Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
> > > ---
> > > Changes v2 -> v3:
> > > - arch/openrisc/kernel/tests/test_kprobes_asm.S:
> > >    - (test_kprobes_*): Set value in r11 register to 0 prior to running tests
> > >    - (test_kprobes_adrp):
> > >      Place function at page-aligned address
> > >      Use PAGE_SIZE macro instead of magic number
> > >      Move value in r13 to r11 before exiting
> > > 
> > > Changes v1 -> v2: New commit
> > > 
> > >   arch/openrisc/Kconfig.debug                   |  30 +++-
> > >   arch/openrisc/kernel/Makefile                 |   1 +
> > >   arch/openrisc/kernel/tests/Makefile           |   3 +
> > >   arch/openrisc/kernel/tests/test_kprobes.c     |  59 +++++++
> > >   arch/openrisc/kernel/tests/test_kprobes.h     |  24 +++
> > >   arch/openrisc/kernel/tests/test_kprobes_asm.S | 157 ++++++++++++++++++
> > >   6 files changed, 273 insertions(+), 1 deletion(-)
> > >   create mode 100644 arch/openrisc/kernel/tests/Makefile
> > >   create mode 100644 arch/openrisc/kernel/tests/test_kprobes.c
> > >   create mode 100644 arch/openrisc/kernel/tests/test_kprobes.h
> > >   create mode 100644 arch/openrisc/kernel/tests/test_kprobes_asm.S
> > > 
> > > [...]
> > > diff --git a/arch/openrisc/kernel/tests/test_kprobes_asm.S b/arch/openrisc/kernel/tests/test_kprobes_asm.S
> > > new file mode 100644
> > > index 000000000000..bc87a5fb00d5
> > > --- /dev/null
> > > +++ b/arch/openrisc/kernel/tests/test_kprobes_asm.S
> > > @@ -0,0 +1,157 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > +/*
> > > + * KProbes unit tests for OpenRISC
> > > + *
> > > + * Unit tests borrowed liberally from similar work of RISC-V. All
> > > + * original copyrights apply as per the original source declaration.
> > > + */
> > > +
> > > +#include <linux/linkage.h>
> > > +#include <asm/asm.h>
> > > +#include <asm/page.h>
> > > +
> > > +#include "test_kprobes.h"
> > > +
> > > +SYM_FUNC_START(test_kprobes_j)
> > > +test_kprobes_j_addr1:
> > > +	l.addi	r11,r0,0
> > > +	l.j	2f
> > > +	l.nop
> > 
> > Just a tiny comment here about indenting the delay slots.
> 
> Got it, I'll indent this.
> 
> > You could also use the delayslots here, for example:
> > 
> > 	l.j	2f
> > 	 l.addi	r11,r0,0
> 
> I initially thought of that too. But then I thought by keeping l.addi
> before l.j, I would also be able to test this for the case when
> there are no delay slots. I can reshuffle the instructions if that
> test isn't required. Please let me know what your thoughts are.

I don't think it matters either way since these are tests.  But, it would be good
to note that in a comment at the top of the files where you want to maintain
that convention.

However, thinking a bit further that may be hard to enforce down the line just
for a handful of files.  We should assume the kernel code uses delayslots.

-Stafford

> > > +1:	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
> > > +	l.addi	r11,r13,0
> > > +	l.jr	r9
> > > +	l.nop
> > > +2:	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
> > > +test_kprobes_j_addr2:
> > > +	l.j	1b
> > > +	l.nop
> > > +SYM_FUNC_END(test_kprobes_j)
> > > [...]
> > > -- 
> > > 2.55.0
> > > 
> 
> Regards,
> Sahil
