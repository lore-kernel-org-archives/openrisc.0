Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA443A9DAE;
	Wed, 29 Apr 2026 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496316; cv=none; b=ZwasEMh6IpbfKnsCc3WIpAssEEMpm4ygfCsp2I3Jjbu+fR+QiM04BMmOBojIhH3+AScbk2mPtZGuDUMkhLk3sw3vcTtnAaHOVMkVYOipSnBeGp3M1mirrqWHdBgCTB+HNjMEgiE8k1/7vD+cSLnujByvPzm2A+l6eeJoQriFZis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496316; c=relaxed/simple;
	bh=2kJKGlGn9w03tNsn83/IyBkdMu5Kroz8C56ed0vj/L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+aHdWufOHjEfaYdDCj4DZR7dtb9tz3dP6FyXeIYYhgLtuHPVG6Cx5A4DXun+nllegEzWsl009aLjuovJVsbmR6RUF8uEX9eRpOz0SUviWSPUbo21WjGrSLScIpLYeIRnJtuF4nFBALWwvOk/b/xOa1m79PBdMaEnscnH25/vKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=s75F4uEH; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="s75F4uEH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777496312;
	bh=2kJKGlGn9w03tNsn83/IyBkdMu5Kroz8C56ed0vj/L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s75F4uEHRLQR8W/YZeUwt9qp/Ww4QxexHNjB/IdgT5NVrA0dcuWQ4If5q2fwEimSW
	 1XmOnhCLzNMNeY7k97AhMheh9nX6FrZbfKcDek+Po1vVletO6SRPRAPUgVrqGNud/g
	 IVuvhkeIQ/p/Oh8d+g1oPa7pvFDsdO71nM9oxyKw=
Date: Wed, 29 Apr 2026 22:58:31 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Stafford Horne <shorne@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/nolibc: add support for OpenRISC / or1k
Message-ID: <5f223443-0136-4938-ac93-14876e788ff1@t-8ch.de>
References: <20260429-nolibc-openrisc-v2-1-8d7d7a2f3fec@weissschuh.net>
 <afJRPLFAHt2aTmEr@antec>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afJRPLFAHt2aTmEr@antec>

On 2026-04-29 19:43:08+0100, Stafford Horne wrote:
> On Wed, Apr 29, 2026 at 05:20:45PM +0200, Thomas Weißschuh wrote:
> > Add support for OpenRISC / or1k to nolibc.
> > 
> > _start() uses the same wrapper construct as in arch-sh.h.
> > libgcc is necessary as OpenRISC is missing 64-bit multiplication.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> Acked-by: Stafford Horne <shorne@gmail.com>

Thanks!

> Do you want me to pick this up to send via the openrisc queue? Or do you prefer
> it go via the selftests queue?

I'll take it through the nolibc tree. Otherwise we'd get a bunch of
merge conflicts, too.

(...)


Thomas
