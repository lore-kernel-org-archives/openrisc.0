Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBB4299931
	for <linux-openrisc@vger.kernel.org>; Wed,  6 May 2026 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091586; cv=none; b=C5dH1L0YvKRY59I67RBW2S4U6ZPQOVVajjfFSv/0l//Un4V1FhrPJrPMC5KHwlxeS84VZ14ipx3SUWQ8/f+5C9V8QCt8qhMt7zdvoN1btpc5zKJTDDLPyB14CkMGcznLpSBNLpwtxaVgvKenoXwo2NjanHrSK0AqAI4ZXAOgFXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091586; c=relaxed/simple;
	bh=kJTWDH+RMDBRw6z32nWM5I1eeBUaU/qi5bJ1+ClXTms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSj/nylxnfWfIYUgKH4WMoABcCYiSaMVWGUZhLm6HJax7085oDAuivooryElH5CCZ6JIuZpiKopRe2OXeUrUcK3pHEQU1QZ3sTk3pFp5in2XtKl7lT6BZJOsCJzCPhiVmOl1FHyQcQ5ne6600lm7K+mBCTHXQTan07jVMLhnjfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BAQ4mZap; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAQ4mZap"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778091584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kJTWDH+RMDBRw6z32nWM5I1eeBUaU/qi5bJ1+ClXTms=;
	b=BAQ4mZapGsoI1DGDqGSwhhTPZIZnvpfiFp+rcM3uDkQG/EHXn8iAV4dWw3kLqrMWU7S1RC
	/V/1Lu6jcRMEY4SiKdDNAshKwR2MwSYXjAkjmJZbz4bukOJ8uwbgouy84NmUIFYhdNx51j
	zgT7zj5g5vgOQD6jbC1xO6QDoNy1FzA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-GeJ85Je9NT-E0NaopyakuQ-1; Wed,
 06 May 2026 14:19:40 -0400
X-MC-Unique: GeJ85Je9NT-E0NaopyakuQ-1
X-Mimecast-MFC-AGG-ID: GeJ85Je9NT-E0NaopyakuQ_1778091579
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C94318005B9;
	Wed,  6 May 2026 18:19:39 +0000 (UTC)
Received: from localhost (unknown [10.2.16.44])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A8D219560A2;
	Wed,  6 May 2026 18:19:38 +0000 (UTC)
Date: Wed, 6 May 2026 14:19:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stafford Horne <shorne@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	stefanha@redhat.com, Stafford Horne <shorne@gmail.com>
Subject: Re: [PULL 0/2] OpenRISC board maintainer updates for 2026-05-05
Message-ID: <20260506181937.GA208805@fedora>
References: <20260505172926.2235826-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EfLLO0Px+pxi0o+s"
Content-Disposition: inline
In-Reply-To: <20260505172926.2235826-1-shorne@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--EfLLO0Px+pxi0o+s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--EfLLO0Px+pxi0o+s
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmn7hjkACgkQnKSrs4Gr
c8iL5wf/QuhYyfjZuZ+W9Urwjzhi8CGOFT2cdT5XT+bIIDHpL965S9rCPutQ1h16
9Rhg1hVRSMlErg0hbS2SsMuJ3BkKjO1tPEFWLZ7BBzQgL9VzvHU3VJ/ozcsAGT2b
Aax/EJ6N/6rKGUWAtnpQ9LNXx92+ZwHzC9kqZIZQmZsPrxdXDtY4omHCavzRlTr3
silaI9dg9aC3QyiZRwjSbSrZVjfUZXKDA4ngWMUCR9S13tgbWntCFsKEKhOaPM5N
eysiouNV61IY3K3SSs9rd2zZY+84KIICIkwNm9dO7Nl96IMgjkb+aEQT36BBK8oj
OLBygV40yOrbY5mLkfUBJpu71fTN5g==
=2nR0
-----END PGP SIGNATURE-----

--EfLLO0Px+pxi0o+s--

