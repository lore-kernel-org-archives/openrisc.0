Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826B11DED70
	for <linux-openrisc@vger.kernel.org>; Mon,  6 Jan 2025 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736184381; cv=none; b=uj5kaCB19lZBWlPOOQWPsNbApYT0pR77ZMNjky7mX06Kq5jijoYdLF7rENGeQjUrhBpQvnrDTjT7QDuEP9oMLhTDFinL9OSNeBpCiUPUpE0ehygaZel0GiE32xiZEO3sIeB5dxks7Ma8G7kNZLG3eSo1wAxf0CEXGzCdkuRQVMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736184381; c=relaxed/simple;
	bh=qdipReYLtDpaMluX8bc2Kyx4YYzwrldmI/z2pfJF7YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvxqAwruWUWZBPhoJQaQmc823+4pXwHTVawcKYa0677qYEXv0MMndxAYkosdMtUnNP8uKIWJS1ioGI5nymoPOzdyrDbCC1x0aH1gU4DWELGV8VcXDn5pe/2HEzJt+Bft8X+pKPqK3Co6X+UJ5HSPwoI3QrRDt1++eyNWpJFpBsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZrZPIFP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZrZPIFP"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4362f61757fso145597085e9.2
        for <linux-openrisc@vger.kernel.org>; Mon, 06 Jan 2025 09:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736184378; x=1736789178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqGZu+BgKii2rzDHNrlNIg5auIbcSKxEgTd5Md4k8pE=;
        b=WZrZPIFPNL2LT7EYZikM2LGCTgnEPvLwuGIA0RgRNKh7Xozu4Vtwh51i1FPQVgmUTs
         1JH+FFf8j5yNBS4+vyCV79KL7AYTRTeJDJUSw/OZYKEn4AKVDQrhjC4ckeM3/MuDW0CL
         QSVz8WUu+zNUS0+qdjYMyGI762of28+bFGpjizYy8u9FVuiBp2+aD5GfwrM1acRU502f
         toY7NT1zFWGNA08ZPnmUfGoeq6y9ypbezuQHAE1aTYGadAowjuZ9QKq8ZiLr3yzcQ4LZ
         OjjU67HsvgUpf4XllCrPs6iptB+eijpUpc3NTsrwI5cNYYSK2AFnmPz/SXDPCy+lMxhv
         X4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736184378; x=1736789178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqGZu+BgKii2rzDHNrlNIg5auIbcSKxEgTd5Md4k8pE=;
        b=S40ITKxuD8hoC0oSa0v+PTd7URhAtOgbAsu/2v8iMTaKHUEFd+YBM9Xq6VM5uGOFoj
         1hBPNMV533vs0aKZFGc8mE1GhtM0x6SRkCCS9XZH226/IXXAWAq4ll1Kda1jdtB6MntM
         GHnLHmMaov1jdROFgvQ9ys9y8DiMOf4xtINC9PA+EgTwFvYYNHqDGkLq7RLuMwtRgGBV
         nIkb4D5WUa6jeOLigggI50D5H0WOEHMvZRfFO/WVusiZRt/KRPDa+jN9zEh/cFoxOgLQ
         erE0IgZuZJTnuJgzWhXcoRBculuRy1U06EOShLcSzEzk2kj38RXzrqk7ZvkDrb+cATFA
         90wA==
X-Forwarded-Encrypted: i=1; AJvYcCWp8FN+rKmI9iaXUa8njBnoEO1AQbUpyunjfevIxTL4KiXOjDfmpT1IYVI0f49mBm2O1k1IDdSCXCd9CY+t4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+0Ii7y6+KVcLseRoRjWAzOyQzwYGo58Ach7p9RM4NKdXM//Be
	ydgl1lBz8q1ZzsS4ymVumDH1eonfXOpS1ADa0CqPf8bWJaH2E2rD95GsuA==
X-Gm-Gg: ASbGncvlY1v9lCfslnSoImlLAv/bWMg9r1+N075mCuiswrgEywtARioXdXJpNxb5ESp
	R2xzApjS1VVeMLeoJD0qFugnVQYUCA3QLxEZXlFKBlMk9Ev0aaP46nvIjDSXid7KjD8eiradzJy
	DRic5/p4v7RPKuG9yK5UiQiMj/25ES3teR8FgL+9oqnG3CBM2G/0PVmKDOTYJXdu27wW2doe6YL
	EGgfMlUKyMJ4j2V3/DUxkwEZZG7uOUOhtbkvgvdeNVGkBpuyXvxuPg9Y5Z/5Cglv9y4WHf+R+xT
	GijiOM+/CxMx+Vr6LK3c
X-Google-Smtp-Source: AGHT+IGDoR6bqp55DCKvIHmH6gqo+TCccASolED8cCu6Tu8nC2/OYTxd2ZFf2+hb6yD/O127EIbP1Q==
X-Received: by 2002:a05:600c:1d2a:b0:435:330d:de86 with SMTP id 5b1f17b1804b1-4366790d3c0mr557313195e9.0.1736184377617;
        Mon, 06 Jan 2025 09:26:17 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea42esm582931715e9.9.2025.01.06.09.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 09:26:16 -0800 (PST)
Date: Mon, 6 Jan 2025 17:26:15 +0000
From: Stafford Horne <shorne@gmail.com>
To: Jeff Law <jeffreyalaw@gmail.com>
Cc: GCC patches <gcc-patches@gcc.gnu.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH] or1k: add .note.GNU-stack section on linux
Message-ID: <Z3wSN45WT5r3cY1F@antec>
References: <20250106130117.1230925-1-shorne@gmail.com>
 <3335b1e7-5488-4e4d-a313-3e989b2abd9f@gmail.com>
 <Z3wMiWSBG7BJyYSv@antec>
 <cbc35acb-968b-4c98-902b-fea85a175808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbc35acb-968b-4c98-902b-fea85a175808@gmail.com>

On Mon, Jan 06, 2025 at 10:03:50AM -0700, Jeff Law wrote:
> 
> 
> On 1/6/25 10:02 AM, Stafford Horne wrote:
> > On Mon, Jan 06, 2025 at 07:37:56AM -0700, Jeff Law wrote:
> > > 
> > > 
> > > On 1/6/25 6:01 AM, Stafford Horne wrote:
> > > > In the OpenRISC build we get the following warning:
> > > > 
> > > >       ld: warning: __modsi3_s.o: missing .note.GNU-stack section implies executable stack
> > > >       ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> > > > 
> > > > Fix this by adding a .note.GNU-stack to indicate the stack does not need to be
> > > > executable for the lib1funcs.
> > > > 
> > > > Note, this is also needed for the upcoming glibc 2.41.
> > > > 
> > > > libgcc/
> > > > 	* config/or1k/lib1funcs.S: Add .note.GNU-stack section on linux.
> > > OK for the trunk.  You've got write privs, correct?
> > 
> > Thanks,
> > 
> > Yes I should still have access.  Also, I would like to add to the release-14
> > branch.  Is there anything special I need to do to add the patch there?
> Nothing really special on the release branches.

Thanks, I have pushed the patch to trunk and releases/gcc-14.

-Stafford
