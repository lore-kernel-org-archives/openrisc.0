Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0B73431E6;
	Fri,  1 May 2026 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777622358; cv=none; b=NIlT9pcGNUtZAXYda44ukwR9xlPBbKc7SktpvK9URfsVlafSSiu/+p6ftnlEA4Jeo1dxBh3EY+WQ18s/OAuZdj48DmCARTlI0JovYPM5JodiQjDREINZ/AU2PYHH8VemOIXdKt6Yp3ZyesMgk+TnoHUQE/MYOFABgxa+TCLfrac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777622358; c=relaxed/simple;
	bh=N4mrsNzdWk6tOBnoyUyiBaCEP8aS3RfCv5qOYULDMc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnNxbCOlHFhteJByhBjQCO3HQxdjfdBldwYQ/S3mJ+BCHrSoYjIrScP4Zkfx7070wUeNjqpx8ZbqxONPzmJXNh69LQVATJEwfCRyMMPiZl79han3+AI+X1437U76Th/MZPIwa/uHQAZLfecVoY9JQNQxV7GE48crQTWL+8JO8p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=t7I12aUF; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="t7I12aUF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1777622355; bh=slTtZbemCbfCCnwj1l+83CNOvt3Nnt6FGfm9jNroCl0=;
	h=From:Message-ID:From;
	b=t7I12aUF7z8wrvL9UwB/RTu2sp0oJbb9BZVdXUNjYp1U1lBKEtDapGCOCp9zNrZVR
	 kbDi/txCAGGmxf/rDC9LI4ehcE+ZYFs8I/gWXuUInCVdXbpjeR6sHtBeEKP48wdY3Y
	 WaybM1mg6P/4C/tynlcJJ3d1sIG4i8E7KDj98kfk=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id BCBCDC0A7D;
	Fri, 01 May 2026 09:59:14 +0200 (CEST)
Date: Fri, 1 May 2026 09:59:14 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/nolibc: add support for OpenRISC / or1k
Message-ID: <afRdUjkM7aOFKpxQ@1wt.eu>
References: <20260429-nolibc-openrisc-v2-1-8d7d7a2f3fec@weissschuh.net>
 <afJRPLFAHt2aTmEr@antec>
 <5f223443-0136-4938-ac93-14876e788ff1@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f223443-0136-4938-ac93-14876e788ff1@t-8ch.de>

On Wed, Apr 29, 2026 at 10:58:31PM +0200, Thomas Weiﬂschuh wrote:
> On 2026-04-29 19:43:08+0100, Stafford Horne wrote:
> > On Wed, Apr 29, 2026 at 05:20:45PM +0200, Thomas Weiﬂschuh wrote:
> > > Add support for OpenRISC / or1k to nolibc.
> > > 
> > > _start() uses the same wrapper construct as in arch-sh.h.
> > > libgcc is necessary as OpenRISC is missing 64-bit multiplication.
> > > 
> > > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > 
> > Acked-by: Stafford Horne <shorne@gmail.com>
> 
> Thanks!
> 
> > Do you want me to pick this up to send via the openrisc queue? Or do you prefer
> > it go via the selftests queue?
> 
> I'll take it through the nolibc tree. Otherwise we'd get a bunch of
> merge conflicts, too.
> 
> (...)

And from a nolibc perspective it's also an ack by me, thanks Thomas!

Acked-by: Willy Tarreau <w@1wt.eu>

willy
