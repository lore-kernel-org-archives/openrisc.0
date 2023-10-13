Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454F8CDB47E;
	Fri, 13 Oct 2023 11:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjJMLf7 (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Fri, 13 Oct 2023 07:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjJMLf7 (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Fri, 13 Oct 2023 07:35:59 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64361BD
        for <linux-openrisc@vger.kernel.org>; Fri, 13 Oct 2023 04:35:57 -0700 (PDT)
Received: by smtp.gentoo.org (Postfix, from userid 559)
        id D1B11335C34; Fri, 13 Oct 2023 11:35:56 +0000 (UTC)
Date:   Fri, 13 Oct 2023 17:20:55 +0545
From:   Mike Frysinger <vapier@gentoo.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     GNU Binutils <binutils@sourceware.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH] sim: or1k: Eliminate dangerous RWX load segments
Message-ID: <ZSkrm9jO8ljxhpal@vapier>
References: <20230819074518.2253226-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f7ZpQ4lFWPmQGquu"
Content-Disposition: inline
In-Reply-To: <20230819074518.2253226-1-shorne@gmail.com>
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org


--f7ZpQ4lFWPmQGquu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19 Aug 2023 08:45, Stafford Horne wrote:
> This fixes test failures caused by the new linker warning which report:
>=20
>   ./ld/ld-new: warning: load.S.x has a LOAD segment with RWX permissions
>=20
> Fix this by splitting the linker MEMORY into ram and rom to avoid
> generating RWX sections.  This required tests to be adjusted to fix
> issues with the move.  Namely:
>=20
>   - fpu tests: were incorrectly using l.ori with ha(anchor) which now
>     that we pushed the anchor up in memory it exposes the bug.  Update
>     to used the correct l.movhi instruction instead.
>   - adrp test: the test reports ram offset addresses, now that we have
>     moved memory layout around a bit I adjusted the test output.  Some
>     padding is added before pi to show that the actual address of pi and
>     the adrp page offset are not the same.
>=20
> Bug: https://sourceware.org/PR29957

nit: put [PR sim/29957] at the end of the git commit summary (first line)

otherwise, lgtm, thanks
-mike

--f7ZpQ4lFWPmQGquu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEfjLn+uywF2RXRpXdyTaAqES06MkFAmUpK5UACgkQyTaAqES0
6MlNqQv+M23ATXBj28DBw85ITUTTIFNQm6/NnqmwkC5o4j6AqZ2hON68hl3kLbXk
QdepcN4Cqgmavz+VBl5sumzORxJgd8PCsXfKVQEMTNitkmZFtTROSyjbgfauVfPo
FhM2l17GSOoQQwRP20v+3LY1sBMozPvNBQ++1SndsVVsjZ26XYL92VU46Ud1n5SL
KXrAPZaTe9ziDGtWk7YmCSQz+rEmKEjlHbznuA+4PO3LLAhx2NXtip0flVti+dej
dplWfiSx1X/omkH8OxqkxKGMKID1paWbfzCvJWpS+OIqeUJoxNhI7Wdo/PpxJFEI
NXTP3OfaFmcBxa1rVhU/MCVMoKo0VnYWAuOnhXQAC4wo8ke8Dk3/3DELNYbzQIzr
rrcLpkNvDVxKBrGO9Q3FxslODA/x3/IVjQ7VSvYdGu/ia6vw/b7IsOZZ6sO6KcwQ
NgzN/L9S1ou9woh0vyXfHvx/07WTXTEd3HVqqFpAy8S2C3L7eRL2Il4Te6qBLl1E
aw8dfDoM
=tM6b
-----END PGP SIGNATURE-----

--f7ZpQ4lFWPmQGquu--
