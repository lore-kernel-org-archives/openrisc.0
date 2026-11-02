Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604133;
	b=v2fp+7VGCMtVVdt7cbxBLlN6Zjj0rdXM9EJ9YxL6RZxjbTeR5HViW0fn77N+H7IeFHvQ
	 jrp+lfI3zwE/ebQy5An6MSAQl7y8cdV1LqTKw/1APrJSyM7vKo9xAYsICjZxZ9RiBBxVI
	 sG/dUrURfyAcdYxWjJqJSBaONUFGnaE5snGgxfdxtEpFY1E3pZNLy96gHKHpzIh8KH6iL
	 VUOzROkNG2iJuXckIPOChoXQljbK7C22RvXbw0v73x23SQuKpdC/v3+uE2CYlRfVlpt6O
	 O5xP5QCd0yR8ZknxXmdqdiPV9qrvaAYgpPvgJVxg2ReYHhoJnqmtQQacqoIKime5umQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604133;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=YxYTF91G0F1lBThpqealjixyREmPnBACasG4sOFttPk=;
	b=jKd1YbVl+JalIGi7aM88MEvgs+9bnctSji1AtplyoA5czdIm9znGtCYbWHr/c4enILDw
	 zlfJUFSM+yAPZImkvjnxDlXz01yTgUYmkhjD8lqYoJmLAkliQxyXHAQvFPbUnOVpta/mm
	 ao7QVAVKL7u2zYM4n1aynFrx9Smc5qoeFDe+03l+YCE/jt675yWLeYhiRsm45QE8QNiTc
	 zzyf704+Lrm8MBAq7Hh6/Qn66CrCq8vxtuCsD6kN4iZgh9DO9+5tpXyFpuJnEB2Qpy34t
	 1HfHr5xpnzOovJizTUrkBCUScCTP8Csg2vucPAOOovDpgt9BYmnhtIMHomO/gUy8AeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens-energy.com;
	spf=pass smtp.mailfrom=errorhandling.siemens-energy.com;
	dkim=pass header.d=flowmailer.net header.i=@flowmailer.net header.a=rsa-sha256 header.s=s1 header.b=dKvu6EqV;
	dkim=pass header.d=siemens-energy.com header.i=schuster.simon@siemens-energy.com header.a=rsa-sha256 header.s=fm4 header.b=bSfWfPqd;
	arc=none smtp.remote-ip=185.136.64.132
Received: from mta-64-132.flowmailer.net (mta-64-132.flowmailer.net [185.136.64.132])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CA2606A33C
	for <linux-openrisc@vger.kernel.org>; Mon,  2 Nov 2026 07:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3CA2606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens-energy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=errorhandling.siemens-energy.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=flowmailer.net header.i=@flowmailer.net header.a=rsa-sha256 header.s=s1 header.b=dKvu6EqV;
	dkim=pass (2048-bit key, unprotected) header.d=siemens-energy.com header.i=schuster.simon@siemens-energy.com header.a=rsa-sha256 header.s=fm4 header.b=bSfWfPqd
Received: by mta-64-132.flowmailer.net with ESMTPSA id 202611020722043b4a76ccee0019fd35
        for <linux-openrisc@vger.kernel.org>;
        Mon, 02 Nov 2026 08:22:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=s1;
 d=flowmailer.net;
 h=from:from:sender:to:to:cc:cc:subject:subject:content-type:content-type:content-transfer-encoding:content-transfer-encoding:References:In-Reply-To:Date:Message-ID:MIME-Version;
 bh=YxYTF91G0F1lBThpqealjixyREmPnBACasG4sOFttPk=;
 b=dKvu6EqVfSnsJbr1DYEMjQGKG08K0ycQRSmZDbjHQ0wmiEUVroiHDsR71k2L9GxtosNpUg
 hI4nCzr1GZkb9FBjoGy8fY2S/cVqwm1dVXhY9WTEx8yv2k9bofoHwExDt7TKt2953ZJI5FL8
 Q7Q1PmgD/16OV1B5H/u99P5C7fuZ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm4;
 d=siemens-energy.com; i=schuster.simon@siemens-energy.com;
 h=from:from:sender:to:to:cc:cc:subject:subject:content-type:content-type:content-transfer-encoding:content-transfer-encoding:References:In-Reply-To:Date:Message-ID:MIME-Version;
 bh=YxYTF91G0F1lBThpqealjixyREmPnBACasG4sOFttPk=;
 b=bSfWfPqdM+oB6qQiyE5obxHU0/LKsL5LXG9G41UDyAlpzS7u/vvcE99C+WwEvUYX1g2Vfk
 JDhEBHYxyLIS/S9DQo54lxUFFNPQwgCAVsD6ROrofTYoXqJ2nmGp77sEcRaZqgtY9RvojQ4B
 z8IuppUMQdHxD/brkp5OMHl0YYx+Js9sUuccqD0xalrkIDDleQJXazFTp8/QNPRHNIEF2+tA
 QGcuWhV/W/Aj8QTmPZLmN/MI1cZfUDU9lacTeO7AFx4muoDlDGVu+RjdXoAs5fUZqIUN+Xol
 W3tgoMpA1UZCrVeo3VSjMLIUYquAL6HCJ7mzRxwRHYrAuvblmFyJmkMQ==;
Date: Mon, 2 Nov 2026 08:22:02 +0100
From: Simon Schuster <schuster.simon@siemens-energy.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vineet Gupta <vgupta@kernel.org>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Dinh Nguyen <dinguyen@kernel.org>, Ley Foon Tan <lftan@altera.com>,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org,
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH] nios2: ksyms: Declare __mulsi3 export
Message-ID: <20261102072202.hpcrob7xknqwx4a4@dev-vm-schuster>
References: <20261019-nios2-mulsi3-v1-1-4fd75b1bacef@linutronix.de>
 <47eb6b48-d664-440f-84b6-ba09f34d5e08@app.fastmail.com>
 <3175caa0-9f49-465d-959e-6b6c9bbb4f01@kernel.org>
 <e9f9ac85-442a-4bcc-8ec6-a03a6519178d@kernel.org>
 <cf2a83ea-5e5a-42c2-905b-199a43b6341a@app.fastmail.com>
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Post: <mailto:linux-openrisc@vger.kernel.org>
List-Help: <mailto:linux-openrisc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-openrisc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf2a83ea-5e5a-42c2-905b-199a43b6341a@app.fastmail.com>

On Sun, Nov 01, 2026 at 12:19:34PM +0100, Arnd Bergmann wrote:
> On Sun, Nov 1, 2026, at 01:26, Vineet Gupta wrote:
> > On 10/31/26 16:57, Vineet Gupta wrote:
> 
> >>
> >> ┌───────────┬───────┬───────────┐
> >> │  routine  │ calls │ functions │
> >> ├───────────┼───────┼───────────┤
> >> │ __udivsi3 │ 415   │ 238       │
> >> ├───────────┼───────┼───────────┤
> >> │ __umodsi3 │ 203   │ 131       │
> >> ├───────────┼───────┼───────────┤
> >> │ __divsi3  │ 77    │ 57        │
> >> ├───────────┼───────┼───────────┤
> >> │ __modsi3  │ 41    │ 33        │
> >> └───────────┴───────┴───────────┘
> >>
> >> I can take a stab at providing the generic libgcc implementation in
> >> lib/* but I only expect the arches using libgcc version to switch.
> >
> > It seems there 4 are always needed together or not at all.
> > Do we want 4 Kconfig gates or just one will suffice ?
> 
> Either way is fine for me. Simon did separate symbols in his
> nios2 patch[1], and I don't mind staying with that version
> unless someone else feels strongly about it.

So the implementation of these four in the series is indeed coupled and
all resolve back to a common base implementation. It got separate
symbols as I assumed that one could potentially provide optimised
assembly routines for one of them but not the others in an individual
arch; but admittedly, I did not think too much about that point (one
would indeed probably provide a specialised instance of the common base
routine?) as it was easy enough to do.

> I would however like to have separate patches to add lib/divmul.c
> and lib/mulsi3.c, and then patches on top that start using these
> from nios2 and arc.

I can split up Patch 3 in my series and pull out the nios2-KConfig
selects of the generic symbols, so that nios2 enabling them is a
separate patch.

Best regards
Simon
