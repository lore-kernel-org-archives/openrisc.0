Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB4B44370
	for <linux-openrisc@vger.kernel.org>; Wed, 20 Mar 2024 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944034; cv=none; b=Mu4ZEeUeTqXw9DAJXI7k2szAz1kKUmrJdr9uR3OxEkLFMBvXxlqvdzRnobdgMBJYU3tIMztY0eY4Z8zXJMb6D1rks4FEMKD4IL+utZGwCsXbyYj2pkGsBHP/c0417i8i9SacbDwxxw1GfkbBw0/A6GsBZ+BBgv0jMx8AYYJ+Ank=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944034; c=relaxed/simple;
	bh=hL3IIlsZoHgI2i8qdvTIeuFhB8vfdRynE7d9k8lZkgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ylhuyr8BRSHOBEd0ZGshW4qZZpYpYvOUqH5+n27fbon7nI5Ku8lyVxyH8eZVr7kYWHBP9Bk09IUwnpvy8qebWF8+4CE28/ndp2xgEy1OIsd5dW+ThtOgYFicl7uw9DyZUsbQiXEcBm4Uvr9W6Iv2TDoI/aPcTEQsA/ay88qmkOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZfycCjz; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZfycCjz"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3416df43cabso1953425f8f.3
        for <linux-openrisc@vger.kernel.org>; Wed, 20 Mar 2024 07:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710944031; x=1711548831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YhYwsG2mOYwzEym2DhIU02QGvWkIFZG1dzTkOTEZIbI=;
        b=CZfycCjz6lmlr/dB17jIOq0ttDUWJenOf6tYVNS78RGAcnN7vJNArlfi6v6v1LbTNU
         GnQryRNUauFfZvHc0FmYlIaFnRCwOrTRIFXYpjOgzBNcaiAQY4UkrzAaerShD+SUOic+
         bH7hxsjMuOdh7KvQ84SnnneYVnToqphsJxqZkGpZ3OVlz51BEuyyURA827sCbpRwk0e8
         ZaOZS7QKZ0Mp55Tq2DfylEKhbCvNs4IBjFI9fuj6b4NIApBxdCiFJ9SdwklGQYa7hsHe
         BzXqJFcFJ1T7CL0UGKpvZ2m5gsvSlZvuaUqdPN91ozwxR2iwMcn7KeDUSlmcOwt9kbVl
         hHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710944031; x=1711548831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhYwsG2mOYwzEym2DhIU02QGvWkIFZG1dzTkOTEZIbI=;
        b=IBuL6ZpInpb1Ib40ifN93l1w7qeEOI0HHQ7XKIbSZnl2/vPWtXxjbLPBPkjcD+xXBj
         cBb6yL901e4PX6lGUEjfXQw2IrPmja7IHtBC9OD1KiL2puIX2VlLatreMFAEiB11lTn1
         d+6ZLNM8KGcdazcf8lbBGkxOl2EElq6Q2ngFhNhLbFvcdh0UVwbQIwboIq5USNcDApPQ
         CpXJK3F0fkgk7rA3QBD5INwisTqs9PtUcz+ghRhIzqRHzBnS10+w+JxS10HntXjHCoW8
         ns0pEYLyWh4CGdfKdf6me4a3MtCbS+gwpch0yzOe+aZYSD6E3/uWdyNusD5+C9BGvIFe
         cHvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrAbtMp1/YDhlPheKfAFg2ELm1Ghzmr9Y88MF98d+jPaMuh0my2SvvO2Sm5gkF0O+rkTt/wfLuJHnRQVVTPjNWFpL4dyS9vO1jU0ssEQQ=
X-Gm-Message-State: AOJu0YxvGhoR2jOWI+qjSsJpZ+GO8kM0R5DygdTOm4aXPQRb/xGmvgDe
	eY2021oiBBmNmSIYovJTQd1TAFPzhSde/IMxws5CP79ZafjvdxShCHLdw7QL
X-Google-Smtp-Source: AGHT+IGSdjzYsQ5Zx1IU9/UX+FxI9xK0cNN7VsbWxygqSdFflhB8sY0SlhbNum5snq0laQYgEt/IDA==
X-Received: by 2002:adf:f6c1:0:b0:33d:5f98:82e3 with SMTP id y1-20020adff6c1000000b0033d5f9882e3mr12789705wrp.13.1710944030406;
        Wed, 20 Mar 2024 07:13:50 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id p6-20020adff206000000b0033cf5094fcesm14786010wro.36.2024.03.20.07.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 07:13:49 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:13:48 +0000
From: Stafford Horne <shorne@gmail.com>
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: GLIBC patches <libc-alpha@sourceware.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH 1/4] or1k: Fix Linux user space signal ABI
Message-ID: <ZfrvHIfPjF2GHnXL@antec>
References: <20240319214244.736981-1-shorne@gmail.com>
 <20240319214244.736981-2-shorne@gmail.com>
 <d892782b-7959-4256-9b9f-6dadd5493dcb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d892782b-7959-4256-9b9f-6dadd5493dcb@linaro.org>

On Wed, Mar 20, 2024 at 10:24:15AM -0300, Adhemerval Zanella Netto wrote:
> 
> 
> On 19/03/24 18:42, Stafford Horne wrote:
> > The OpenRISC sigcontext structure has always been defined as:
> > 
> >     struct user_regs_struct {
> > 	    /* GPR R0-R31... */
> > 	    unsigned long gpr[32];
> > 	    unsigned long pc;
> > 	    unsigned long sr;
> >     };
> > 
> >     struct sigcontext {
> > 	    struct user_regs_struct regs;  /* needs to be first */
> > 	    unsigned long oldmask;	/* unused */
> >     };
> > 
> > With Linux v6.8 we added FPU support and repurposed the oldmask
> > to use for the FPCSR (floating point control status register).
> > 
> >     struct sigcontext {
> > 	    struct user_regs_struct regs;  /* needs to be first */
> > 	    union {
> > 		    unsigned long fpcsr;
> > 		    unsigned long oldmask;	/* unused */
> > 	    };
> >     };
> > 
> > The definition of mcontext_t was always missing the extra space for
> > oldmask.  This patch adds the field __fpcsr to mcontext_t to fix the ABI
> > mismatch between glibc and Linux.
> 
> This is strictly an ABI break, this won't make the swapcontext functions 
> to fail (since they are not update to take in consideration the new field),
> but it also means that the fpcsr won't be save/restore and the application
> can potentially read uninitialized values.
> 
> But I take that the fpu support will be a new ABI, so I suggest to fix
> when you add it (along with proper support to context functions).

OK, I got it.  I will post this when the hard float code is added and also fixup
swapcontext etc to populated it correctly with or without hard float.

Note there is broken ABI already, as programs will not be able to access sigmask
if needed due to:

Linux definition:

    struct ucontext {
	    unsigned long     uc_flags;
	    struct ucontext  *uc_link;
	    stack_t           uc_stack;
	    struct sigcontext uc_mcontext;  <-- size differs between glibc and linux
	    sigset_t          uc_sigmask;   <-- won't be able to access if needed
    };

But still I will leave as is for now.  This hasn't cause any issues as far as I
have seen so far.

-Stafford
