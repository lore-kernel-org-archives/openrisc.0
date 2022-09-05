Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF20BC38145
	for <openrisc@archiver.kernel.org>; Tue,  6 Sep 2022 08:25:02 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 3AD8620C8F;
	Tue,  6 Sep 2022 10:25:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mail.librecores.org (Postfix) with ESMTP id A474720C8F
 for <openrisc@lists.librecores.org>; Tue,  6 Sep 2022 01:41:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662421280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DFfKWgywJFbioeLAhuiHEair9Ne9S1P0+6xTQAPQaR8=;
 b=Xfcyo+qxU1AzJAXVATSf7xnpK242CF5Z4NmKonND9xzPoVLZL22zmh93m6dRBZ20L5qUmA
 SafR/rAyPwLhKO1wMKjATmRBRvOK43NFL8GJPBzjMkbntMrM9WgEWb/sbnIQzVnxlUK1NY
 BRN5GumViR0qCeMYFCbT8BvdTBoxIAQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-yQk96nNAMoegP9S3tesI_A-1; Mon, 05 Sep 2022 19:41:17 -0400
X-MC-Unique: yQk96nNAMoegP9S3tesI_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A307138041C0;
 Mon,  5 Sep 2022 23:41:16 +0000 (UTC)
Received: from localhost (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 226FB1415137;
 Mon,  5 Sep 2022 23:41:15 +0000 (UTC)
Date: Mon, 5 Sep 2022 19:40:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stafford Horne <shorne@gmail.com>
Subject: Re: [PULL 00/11] OpenRISC updates for 7.2.0
Message-ID: <YxaI+n/mn3yw5prq@fedora>
References: <20220904072607.44275-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WLtjUio9Vs+QpEBQ"
Content-Disposition: inline
In-Reply-To: <20220904072607.44275-1-shorne@gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Mailman-Approved-At: Tue, 06 Sep 2022 10:24:59 +0200
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: openrisc@lists.librecores.org, qemu-devel@nongnu.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>


--WLtjUio9Vs+QpEBQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/7.2 for any user-visible changes.

--WLtjUio9Vs+QpEBQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMWiPoACgkQnKSrs4Gr
c8ig6Af/RIfNBXrarBvWj6BRP+y3U9YMpzlme9olxdRmsf2XkmWCxTqSfw3QzWIk
bwaREHU9fdLTKEuDyi5sFnDNrfWVU5TRacYnxUJUmr964YPvRUwR4j6HBf6Nh4yu
kWNBOmSlLgaTE7T0T6IjkBSC871Ym20lvqXHxQuigzYZd85qZ7kdC+SWBb3fDbn9
uFd0sdudr+WKi/2LNZT0JE+ge2lF59SqR2HogHo1NbMxHGAJlip+eYYRmgEt7Pnj
6k6b9E5FCVakaxdhoyI5fWcfAU5Rr1k3LL0co9HS15Jjrc5PBAbegB/DOb6l3zVl
yB2zguFftcYjsj2CsuIz/bVuS2NmvQ==
=WV2Q
-----END PGP SIGNATURE-----

--WLtjUio9Vs+QpEBQ--

