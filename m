Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15D2CDB465;
	Sat, 14 Oct 2023 08:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjJNI02 (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Sat, 14 Oct 2023 04:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNI02 (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Sat, 14 Oct 2023 04:26:28 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CDEB7
        for <linux-openrisc@vger.kernel.org>; Sat, 14 Oct 2023 01:26:26 -0700 (PDT)
Received: by smtp.gentoo.org (Postfix, from userid 559)
        id C146B335C5D; Sat, 14 Oct 2023 08:26:25 +0000 (UTC)
Date:   Sat, 14 Oct 2023 14:11:24 +0545
From:   Mike Frysinger <vapier@gentoo.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     GNU Binutils <binutils@sourceware.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH] sim: or1k: Eliminate dangerous RWX load segments
Message-ID: <ZSpQsN+RDzykf0iu@vapier>
References: <20230819074518.2253226-1-shorne@gmail.com>
 <ZSkrm9jO8ljxhpal@vapier>
 <ZSo1iv/ob7D8VRQj@antec>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="A7YUB2DCJULXoJ3i"
Content-Disposition: inline
In-Reply-To: <ZSo1iv/ob7D8VRQj@antec>
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org


--A7YUB2DCJULXoJ3i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14 Oct 2023 07:30, Stafford Horne wrote:
> On Fri, Oct 13, 2023 at 05:20:55PM +0545, Mike Frysinger wrote:
> > On 19 Aug 2023 08:45, Stafford Horne wrote:
> > > This fixes test failures caused by the new linker warning which repor=
t:
> > >=20
> > >   ./ld/ld-new: warning: load.S.x has a LOAD segment with RWX permissi=
ons
> > >=20
> > > Fix this by splitting the linker MEMORY into ram and rom to avoid
> > > generating RWX sections.  This required tests to be adjusted to fix
> > > issues with the move.  Namely:
> > >=20
> > >   - fpu tests: were incorrectly using l.ori with ha(anchor) which now
> > >     that we pushed the anchor up in memory it exposes the bug.  Update
> > >     to used the correct l.movhi instruction instead.
> > >   - adrp test: the test reports ram offset addresses, now that we have
> > >     moved memory layout around a bit I adjusted the test output.  Some
> > >     padding is added before pi to show that the actual address of pi =
and
> > >     the adrp page offset are not the same.
> > >=20
> > > Bug: https://sourceware.org/PR29957
> >=20
> > nit: put [PR sim/29957] at the end of the git commit summary (first lin=
e)
> >=20
> > otherwise, lgtm, thanks
> > -mike
>=20
> Thanks Mike,
>=20
> I actually pushed this long back without the above update after I read Ni=
ck's
> comment.  I for some reason missed that he said he was forwarding to the =
sim
> maintainers.
>=20
> Sorry for that.

np.  had some hardware failures on my main desktop so only just catching up.
-mike

--A7YUB2DCJULXoJ3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEfjLn+uywF2RXRpXdyTaAqES06MkFAmUqUK8ACgkQyTaAqES0
6MmLCQv9E+1y98XEQW2KCJm5hVmPgl5oAjaJCGC1YOLyUcdv2MzQ4LYCe4/irxNu
4zLNmFfcGIfRM4kQJH2jmLnXOiOxCWumEetaBkT5pMdV3IUH7KsShTwyhgsQjqpd
yy73QbPRXuVuH0D3payh9DujF6Q/H6qm6hPK+EUx0t/9c7XCgRstxvhE9d1K6bzH
7G2jJU8mjh79RaTPv1Aj/qsdfUzf6WLO0Zz7v0FP38sYgHhQ9ecE6gzRO/f777Qi
0TYH2Zb9NWjqf3nF7UeDYlsp1bgSENRv3J39E63fpZf9DsIhNHm//vQNrXaFp8qz
pPxcKjqBcAKLvtmoFqOTj9F27oBxZNtkN80yzMP5qCYIBW5F6QD7TN91BrQau9Hx
uG/X+pg5YEKmcgcGdItoZQ+AZjcPT3801vRpeqVHbl3oiMJaFPrPXRC8eUqIfuLi
nEFEi+5m4eUUqILtqowr1ZhvvKRbS7fOkTSQOUL88MVonaWO7FgyZH3+Hl5FdcS4
MV3jq+LM
=02jy
-----END PGP SIGNATURE-----

--A7YUB2DCJULXoJ3i--
