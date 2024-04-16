Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1C92231C
	for <linux-openrisc@vger.kernel.org>; Tue, 16 Apr 2024 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299832; cv=none; b=PpzeJLYeo3uJkEA2yOEoAPCm/NTp/h1U84IEAfHaNAh5UnkxI3S22TAIWRdp0+wlMiLBwZfoXZ1EboHvZJlpJqwtUbFZwz7wGvPK42q2LfDP2YijsS4VhsFeHeoAtI2RZsvjYVxe3tTFVFE32EZ6SGN1OVGlcpCnTq7IONkgrCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299832; c=relaxed/simple;
	bh=m6IyhsJuOXtOgIlo1iRx7fNL0Xmwo4GPSslczGQio6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWT7Xo3Cc8mx31OhZsvo6oP7ZQM2B2CNQBWdiYCR/P6xZZft3Hgo9QOInm2vM/5NgFUmjW3IMJ+vM0rhnDKgfwRoJ1i3BQBfAAju8DMbqP7OPtq233DqksF+V3OqlGCnJ1BH3VY0kI6HMF9tnwkNQfkmNRDLltPErx5nqZjym8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtRFQOwm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtRFQOwm"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4167fce0a41so860265e9.0
        for <linux-openrisc@vger.kernel.org>; Tue, 16 Apr 2024 13:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713299830; x=1713904630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cCQCfz07+wOX3FHSZEC0Mo0q80E3mOKT/qEMyPAHrtQ=;
        b=TtRFQOwmko+K/fTnTtOHGO2RSxKCDhRoY4HNR2p4BWvLz1/nuwwndXlgo+oAgiRlOd
         NwqPy/VHdKaNMnKpyR84Wgh8tuvlHXIS6ZLucP13QKkWCpqigOod3iqlsxXyJDPF9+1L
         DLyGcQJpT9CJyf1+i10tC41rC79llWP9Z8I75eRma0IltfAl4EbJjYAFOif4dL1oTWsB
         Pwe/S9A5s+UulkEFIcc/TLZkHtM/faz+sglBLnzS9ywM2ghfA+PuBeApz2ZFcqjRUVSA
         J0mixYXeR0rk+D7JczWkS4eKMiTuOMgZLltLuRpVENUMZSzHvWQxKMwnPJyhpidyxR3g
         jNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713299830; x=1713904630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCQCfz07+wOX3FHSZEC0Mo0q80E3mOKT/qEMyPAHrtQ=;
        b=G3oIal7xpgrvqfpaZm8JSqYqO+OWsVXMgJ35XaOd0tGs+qb3EfmKJPoTNw9UWJq2wV
         TT+t0HAPsCCyWlneIaYdwb39xtAnXmZXeldWJmq8jHUy+Olmw5YPD6/fblDaDqcsrNYr
         yX9MPL8qBr+7fp0Qa7xd3mNDov/VuBTBFuQ2ByyC6EX/EZ4Mhk7mEsnksHj4tHjtYxwQ
         /LgNGUWaG1K0tNyBhc+59HvcSLeYWkv3tJMw9ZNJHaGTYR9uBteeAtDcy+J6F44pxMzD
         cD0PxrXXr69yboafavWTL5pExXJYDTWhvMds/LmpRJwaA5OpkIY9Gv3tTEg3D0Nb96XH
         cppQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5RGE4CWIuRksxnV9oUNMXAKWbaBnabkQWC/Q2nK32MDO16rTx2SJfPzBa+HdiB+RuMxbO9JTQDMCj5qtGa5eVgYP0rh5IHwsz5Htx390=
X-Gm-Message-State: AOJu0Yy1FTgYaN4ADJlZ7EseDh19osDb7yVcx0ynxGAu6QjxuuCVLBYu
	oNOz53/+zz2GBSmK/rtGf5gP3EVMqmDO9z2NIYObs/KLUMm7V+aq
X-Google-Smtp-Source: AGHT+IGvZHz9s3N7Jr/Wsjn8SkKj3IW5o2/tDBxiB9FtC9cLaexrDwVqOELLWtFBfx5QUkdT3H6sxQ==
X-Received: by 2002:adf:fa11:0:b0:346:4e74:819a with SMTP id m17-20020adffa11000000b003464e74819amr2764346wrr.14.1713299829350;
        Tue, 16 Apr 2024 13:37:09 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id f12-20020a0560001a8c00b0034744966ff0sm11121004wry.59.2024.04.16.13.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 13:37:07 -0700 (PDT)
Date: Tue, 16 Apr 2024 21:37:06 +0100
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	GLIBC patches <libc-alpha@sourceware.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH 1/2] or1k: Add hard float support
Message-ID: <Zh7hcqSWKc9qrnP3@antec>
References: <20240329074044.1961252-1-shorne@gmail.com>
 <20240329074044.1961252-2-shorne@gmail.com>
 <4fca2ce2-2a45-4021-b91c-3e0c9dd8f6e2@linaro.org>
 <b3bf9676-ddc2-48eb-9c94-7512281155a3@linaro.org>
 <9870848e-0b2e-423f-8dd1-4bed6968aeda@linaro.org>
 <1cd9db5c-fd3a-45d8-96d5-227ea720dab3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cd9db5c-fd3a-45d8-96d5-227ea720dab3@linaro.org>

On Tue, Apr 16, 2024 at 12:56:11PM -0700, Richard Henderson wrote:
> On 4/16/24 09:20, Adhemerval Zanella Netto wrote:
> > Right, it was not clear from patch without dig into the ABI documen
> > itself.  So the only thing I am not sure is the mcontext_t change.
> > Other ABIs added a symbol version to proper handle it, so maybe
> > OpenRISC would need something similar.
> 
> Yes, I think some compat symbols are needed for getcontext et al, since the
> size of ucontext_t changes.

Just to re-iterate, the size of ucontext_t provided by the kernel never changed.

But the change of ucontext_t in glibc changing causes issues.

With the glibc ucontext_t size change there will be a problem with running
old compiled applications on new versions of glibc if this hard-float series is
added as is.  I will see if we can add some versioning to ensure binaries will
not break when running on new glibc versions after this series.

> I think softfloat glibc should populate the same field (with zero, since
> neither exceptions nor rounding are supported).

Let me double check this is the case.

-Stafford
