Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B62594B4
	for <linux-openrisc@vger.kernel.org>; Mon, 14 Jul 2025 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505396; cv=none; b=Z4hNKidpz19ifdMuQUYxFh3wo2PyJxQCPEhmFOBV72R4QG9zJ7glDUpvJCBnr/u05Dbl91Lo0fhHqbV2MFRT6MtTH9c9wRMd5Nx4bHenWFZjIapNLodl3loqIcHOF186M5VNHdCuJXuZvH6oLi+0zHPbX/Z4q/4vDVN6/M9EL1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505396; c=relaxed/simple;
	bh=Fc/ZG0mjs+PXBqBDEp+8/GLkm5N2HPtRmzpvuFAqsTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDpDC0hcpElF5RsYF6OYDvdCSgkJg9YmShuzR6I1UMqyvaNDF9b6YBFiS7VoHrGiECuZ34foWXIybQuJhN67JpaDxgCfjOXCTMjGaEPjpQ2a5ncxiSzQHlPEsIBDUl4/jYKYbOKLocJPhL+wnRZwTTvSC/QQ4Lm+mEN75bgV2Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNs4ZROO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNs4ZROO"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4530921461aso28817785e9.0
        for <linux-openrisc@vger.kernel.org>; Mon, 14 Jul 2025 08:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752505393; x=1753110193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pou0/669bpLQlQV2+ssa2AzCE8/7MmYXz6G+ZmNgc8k=;
        b=jNs4ZROOhLfZkmWhx373+aWXaVu58jA7MtUgRtNcM4QNwH/f1W2Gxj4k/junYZiD/9
         XR6uJGf0MLNCi0gjxSwnqOSqGl/R7L4T7wClDZKvPQS8TZTGWndm+b1f4WcwevQuW8Gb
         /f7pvz844jo3OQ5oILG79qYZ+6WpeYuKsoEZTnYEkjy7z45uQiqWIGppqUEBW5yajgo2
         cfOFjvChV7PyIP268BXo3lTzS6oqHqDXb+M3oyWuWU1AfNDrwfIaBAs1D03jbEyNC8Sf
         LaEcea8gRvB8fnWOaU1eBZj/zAVrowPam63E1yNkMEpX+VwNOl+4FsDoxhxqTgbbKLNZ
         rE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505393; x=1753110193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pou0/669bpLQlQV2+ssa2AzCE8/7MmYXz6G+ZmNgc8k=;
        b=jtoNrnXezpBg29SuxL4LxETliyAySPBdL6yPNxzhRvbedE4ZRNhD5CTZle1NUGPkvL
         xZeW4kbaZrLPHe+ZOtC6azvklTKlgEsg7tOJdBFK6CoiuP+w+4L58gUkuXm+PV+icn0g
         gZSfmEPkIGUgXkbnzi1e/aU95b0uKZwY1OYys0xkc303LZXJ+H5XMFLhJjtfdSEb1e6p
         jUvZerwoZLEKMAL8JnLQi+fgqi3fOGrX1MmHeVZco9KyJvNsXWGlWz/oqqms4Ar/EBpY
         4fvp0czb/L5P+1BcyI8i3pKdLChgqEcWyuoJcxaUhGCDN0WNmf9baGUq2z++9wMr4++G
         MKjQ==
X-Gm-Message-State: AOJu0Yya6sEn7MG/R8N/OqYJZtTN1oPElgLkj81B9fMvJx9U88Vx4nT0
	zgQuqkJc8o5AxRvTXxote4qnKY6l199uOmWvrHKbJQQQln34LE5KX7m6
X-Gm-Gg: ASbGncvarGz9NGG5Zue0OSh4B0iG5pZzcbm6VNCo+TB+3h7oIWZ0YagyEdCzUCRVqgR
	l2gqsN7+awZLvRvBxA7/fAZH7duP1EP6y3xk3r+u2tl2OAVBL5zGem9wunpyB/jsDFF5tyWcWhn
	NgmOXr0/BDA07DLc9du6+qRn3lp4LZ1LC41VxQaqS4HGnMmY+DRzFIDvSAI7mjze45zlR48xVMC
	3Ks3u746oyBfEm7dIrsDjlewD+JMhKzH9sXvc/2FUtd6T8F0JGDRrFFGbk8SyM+cUPVGSRAcRIf
	cbh+Pguv5wDSy5NF0YlK3Ixm+YeK698OPmAW6eB5e6uIby0pcXCKUk0zkbFvt9CQpK+P6aY5K6E
	26fH7anNo8aZC8hbDLT0qw6ELwiJf/lHP9FikmFV1P3OQ6Po+tqrZ4ktifGfqQg==
X-Google-Smtp-Source: AGHT+IEC6MZzBYd6gfwGC2/9ZmbaUfyfWCqp8OdVqFxzQFjPyqHrfuCFNuhLxtFEw0eVwBiUfCkF2g==
X-Received: by 2002:a05:6000:2002:b0:3a4:f7ae:77e8 with SMTP id ffacd0b85a97d-3b5f35302demr8078052f8f.15.1752505392596;
        Mon, 14 Jul 2025 08:03:12 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc91e3sm12537455f8f.43.2025.07.14.08.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 08:03:10 -0700 (PDT)
Date: Mon, 14 Jul 2025 16:03:08 +0100
From: Stafford Horne <shorne@gmail.com>
To: Gary Lau <zgliu@foxmail.com>
Cc: linux-openrisc <linux-openrisc@vger.kernel.org>
Subject: Re: [Question]or1k-elf/or1k-linux Windows/Cygwin
 toolchainavailability?
Message-ID: <aHUcLABF4dBl7641@antec>
References: <tencent_D7671DAE3F2DCA4F5AAD8A421C72F3568E08@qq.com>
 <aHNLQdk1W_A7PvDw@antec>
 <tencent_AB1F05656F2D0DC53C8ECD792547FB8E8707@qq.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_AB1F05656F2D0DC53C8ECD792547FB8E8707@qq.com>

On Mon, Jul 14, 2025 at 03:06:15PM +0800, Gary Lau wrote:
> Hi Stafford,
> 
> 
> I found there is already or1k toolchain for windows in below link:
> https://www.embecosm.com/resources/tool-chain-downloads/

Oh, thats right.  I forgot about it.

-Stafford
