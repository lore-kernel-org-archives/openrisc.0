Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C3E1F0E23
	for <linux-openrisc@vger.kernel.org>; Wed, 11 Dec 2024 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956816; cv=none; b=AygQH3G6EsXVs2yRFDPBReoZxL0cWzDqTaMB24aiGMUpt5Rchvyrzty0qWUlWkmODLLsmKhZXIzkBRFsyDK6ofwHJIH5gz6nPrVg7JqgHD7Gycxvam5PEb/P1IthnAJAnBxjaoUzp8lDNwDQiBeounhE5uASRp9bPo76KuCRsTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956816; c=relaxed/simple;
	bh=LlWTbQg6BwQn1nOEcp3BHJv+wP2EFGpfMdeKcYWeB4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CDBPk6EtFq5pwhmONl4ntIIBhp6AFHiCsWLxsQKifAA4vxBqedchkhDKk/WlNjAnZCcmTH6CjiGscABnkjvClaBxXQtNwAdt5N58yIJ55D/MfEVsTjW7z4qvD1I/o40ywdRUjIb8aS5MoyxOHLPK35JFMAYn+HF0PKGnJZKw+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ieYZ+aJH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieYZ+aJH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733956812;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=hmbGGgG5VSBCgFYJ7IhyBUZb884JhaOtw4+M+UPZFg4=;
	b=ieYZ+aJHcTIq1xwGHOatUC7tMiJsOGcZmLIyXSTJVgmeqeOarLAr0FHr+ZgK2GykfJHRVv
	u6F37mffSfqpfvvunCJdrx1CSU6s1DmMiiHfVQJiv3JUzJWBMxGGb6Y1gqdrCAjA73qK6h
	uX4UqEKpSNmJ+VVtwWKqp3knt7muvrA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-YHa8joL9M6y10bOpsebQIg-1; Wed,
 11 Dec 2024 17:40:09 -0500
X-MC-Unique: YHa8joL9M6y10bOpsebQIg-1
X-Mimecast-MFC-AGG-ID: YHa8joL9M6y10bOpsebQIg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B94D919560BA;
	Wed, 11 Dec 2024 22:40:08 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.194.37])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F2AF300018D;
	Wed, 11 Dec 2024 22:40:08 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1ED62A80893; Wed, 11 Dec 2024 23:40:06 +0100 (CET)
Date: Wed, 11 Dec 2024 23:40:06 +0100
From: Corinna Vinschen <vinschen@redhat.com>
To: Stafford Horne <shorne@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>, newlib@sourceware.org
Subject: Re: [PATCH] or1k: Fix compiler warnings
Message-ID: <Z1oUxmYHBXJKHHcp@calimero.vinschen.de>
Reply-To: newlib@sourceware.org
Mail-Followup-To: Stafford Horne <shorne@gmail.com>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	newlib@sourceware.org
References: <20241210125847.401222-1-shorne@gmail.com>
 <Z1mPY2CcYF_WaHEj@calimero.vinschen.de>
 <Z1mkGubLCh8Rte7Z@antec>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z1mkGubLCh8Rte7Z@antec>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ny3Fq30Po8BB8N6_QeFToPCg7MycrRZC_0fyFDkzYZs_1733956808
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Stafford,

On Dec 11 14:39, Stafford Horne wrote:
> On Wed, Dec 11, 2024 at 02:10:59PM +0100, Corinna Vinschen wrote:
> > Hi Stafford,
> > 
> > I'm not engaged in this stuff, so maybe this is dumb...
> > 
> > Changing the parameter from uint32_t to void* sounds like it would have
> > been the right thing from the start, but it's also an ABI change on 64
> > bit or1k.  I could imagine the uint32_t is just a pointer value from the
> > lower 4G space on 64 bit.  Do we even support 64 bit or1k?
> 
> Hi Corinna,
> 
> I think it's a good conncern.  I put some comments on the patch below with my
> thoughts.
> 
> If this is OK, I will send a v2 with a better description of each change.
> 
> See below:
> [...]
> I agree that if we did have a 64-bit implementation it may be an
> issue.  But there never has been one, or1k is only 32-bit.  I think
> the ABI does not change with this patch.

IIUC or1k is designed with 32 bit and 64 bit implementations in mind.
However, if there's no existing 64 bit toolchain for or1k yet, my
concern doesn't really matter.  Even better if the ABI is 64 bit clean
before such toolchain is created.

> Maybe I am wrong, but I think this is safe because:
> 
>   - There is no ABI change as void* and uint32_t are the same in or1k
>   - There is no API change as or1k_uart.h is not a public API
> 
> What do you think?

Sounds good to me.  Just go ahead with a v2 as per your suggestion.


Thanks,
Corinna

