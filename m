Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE935246778
	for <linux-openrisc@vger.kernel.org>; Mon, 14 Jul 2025 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505165; cv=none; b=OzQncO49kNZvwdT4pP/DRv+YsosyR863gl9y72nlrK2i4OV0R9R6E+PXwm2NOP6Rghs1B5xXn49XzXz7J1HebbSFOFOsckYyRyOzKn3/Nil17f/+rdPj5SWZU6ViiNk3TnS35nfAME07jWScap6gqqTJOeOyvMfFMn7oIK2aW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505165; c=relaxed/simple;
	bh=I0uwFyjoHf3dO8eVxOXL7xmxM6xJpTF7aCCD8p5QI7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKjeU0O+V6svVAq4ReW+TKfWG6mgMDxtX44dEtMfhdx91ziRTHTKdSLXQTWNf+6FT6LT8E3pdriqYeNpQtJtV8+WovERu/nVAlmfBPQY7FMLf+wqqpIYBjvQIMKiC8slj7bhFFZHPmnexLqfKoaz/TN9TqUkoOBZt7ZNmdeh0Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEZJMT1h; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEZJMT1h"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-454ac069223so27574265e9.1
        for <linux-openrisc@vger.kernel.org>; Mon, 14 Jul 2025 07:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752505162; x=1753109962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0uwFyjoHf3dO8eVxOXL7xmxM6xJpTF7aCCD8p5QI7U=;
        b=gEZJMT1h/ejIze9PDJBe8hDoonXEWJBNz3FeNkj6CfL+0iXb8+TlC38IUwLakTRQ2n
         /IKGXS+WtNw+tRtToE4z9/FIzaNxZrjwk/FP2ArhG4T9IsvSgI5w5UQZ3BfZcevnZn2j
         z+p7b0fJWi5/Xv3dadTHKXeBaV+kqtYlUiWZRtzfeODYsNPcy4MaDs8i9O+jr4RE0w+E
         CNHN8AdWl6U4aAlNnWUn6Noxcv/rTEzTY/exObYXR/plLtfTeBcbRSfEvpImHEBNxi7k
         z9NNYetlko/b4sYwrXefcfpSDW4j5kGR/lhaD4+VTCayQdbT/MoVcl5OHVtX4EXepLeN
         AVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505162; x=1753109962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0uwFyjoHf3dO8eVxOXL7xmxM6xJpTF7aCCD8p5QI7U=;
        b=HelrFQvt5L4rGZkSBjATxChKmEePnwSCMGxs/uJk2wOJGeAxJoWRs1abyNBzbIFIhP
         2QQqKTz+QOJ713TNpMIlw+mj6stDiZeJCdhZ6H8Gno1yW5hFVbdkNnecVqGDcnnTzM3T
         A+7rPAMvOPojf6OVpFLEXf9ERIucmZj8kYVhH6DU8hkpP8JbQIQ/sPCK8c4IhICgxV8J
         sin1AnPmu/uxxBAEMdGWKYothedlNhQos3ia0oSJTx1mvmDUPa+J/ugFscKB/OoCaSiU
         hw3oG0X91w2Ee3l/A4JyMthI23x7EMa3G2Y8DAVwYZOGEPUHBJaGpIsr6dY1jUYuvM97
         jSDg==
X-Gm-Message-State: AOJu0YyCXaV6qSXqd1AjNzFAJ36cx1alAQjGTxkQq81Y5Ejaz1E6BpQN
	xwPBgK/VavTmCpIqNJTeXDbKmSzBnJrd8YstdHAQc+jfzz/Gvu7NcZp9VykwrQ==
X-Gm-Gg: ASbGnctGAmkKKVpxOw/DgSaGLou+KdNu5aCcrZW6X25V6Nq3ya8hSDssiP9TtFT25zt
	jsCrtJf5MUe7bEdWfx4sDKaH6E5Pi+c58t1K4H5CpC2bUvGRsaccbscE5hGto8Jmry4S3/ikamo
	jTLb/H2RSzb6KnhUPhhhbDy/7KCJX/2+g4j3GrErAkHy9bVchOT6UtL2qlYfb+C34qSy48SMfmG
	UyOUa1+yUafH4jszXciwJUas9BO0Hk+gUL24CJaQ/380DqJxIQSooSNT/Ck6gWUitq80SfC1jbo
	0qqRKiiqpfLOQWK3dA1aq/+tKvX3OZ+li3k4sqArIQKis+0pN+QlEFLKgJM4J5xz05eHbkpL5/0
	0h49cfW85OtgmVvtbHRvksmQTtUxlYWQwXISQ8Legnp11kEJJjlHSy19Z3N6xnw==
X-Google-Smtp-Source: AGHT+IGO5/opwsI88gfzaKm1ibI8wfcaom/rTfC7KrFE+bwOHUmqgjb5EG0GV0oP/Jl4bH8f39slpg==
X-Received: by 2002:a05:600c:46ce:b0:456:21f4:a0a3 with SMTP id 5b1f17b1804b1-45621f4a239mr19914045e9.5.1752505161911;
        Mon, 14 Jul 2025 07:59:21 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4561a052729sm38824595e9.33.2025.07.14.07.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 07:59:20 -0700 (PDT)
Date: Mon, 14 Jul 2025 15:59:19 +0100
From: Stafford Horne <shorne@gmail.com>
To: Gary Lau <zgliu@foxmail.com>
Cc: linux-openrisc <linux-openrisc@vger.kernel.org>
Subject: Re: [QUESTION] Does or1k-elf-gcc handle OpenRISC 4B
 alignmentrequirement?
Message-ID: <aHUbRxBk6fBnLaj3@antec>
References: <tencent_9B9E72B11681621EC7FA7CBD636247D74F06@qq.com>
 <aHI1dhsflDh2Ci1l@antec>
 <tencent_FEB56C143F39CEE7BB1C5B3A1C7E82940909@qq.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_FEB56C143F39CEE7BB1C5B3A1C7E82940909@qq.com>

On Mon, Jul 14, 2025 at 05:21:16PM +0800, Gary Lau wrote:
> Hi Stafford,
> The load elf failure seems not be related to the alignment issue.
> It seems be related to the memory stack conflict between main program and client elf.
> I will fix it.

OK Great.

> Anyway, thanks that you confirmed the or1k-gcc does not take care of 4B alignment.

Thanks for confirming.

-Stafford
