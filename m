Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557BC2E36F4
	for <linux-openrisc@vger.kernel.org>; Thu, 11 Sep 2025 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757584385; cv=none; b=N1Yv5qaKuMsbEgy5u+cEdTfQkdIRR3haj1ophY0STIUk9NdbIJaJ/MKkTXsIn9NvHP5zhZK616LGB6S4LrIImgAz3ayvsjqyE344pquFBpyOR3MiKO/kJDYLHAWFdgVrtNoKJ2rnIn8jT4p0WXQivtSOj0X87kQULrV2AKw4qsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757584385; c=relaxed/simple;
	bh=lFnVcd9zR4wN3oCx1JWIeEdk9F+FztDRi6eORrfWkg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAD8nYEHd70bXXkv51H3aRUtiPvW/UfAk3phgSmMwWUnul5LcrkYRGBqmKWXbMy27tGx8yqfrjr4lX7s0U+PRFFxvLiZJ1EVZbweoMISrH+34mjd4ApVQodVnDe6eAJgMe8qoATvnQHoStqS+bJN0fbguKtZH0UtcMFc3ZGYMPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeR9H2dM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeR9H2dM"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so4590315e9.0
        for <linux-openrisc@vger.kernel.org>; Thu, 11 Sep 2025 02:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757584381; x=1758189181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aNugqJ6dpnTABYm+0JbEHRJnvG8/9x05gAdclmtnl7g=;
        b=SeR9H2dM6zFaCCOH6aSK1x+wJEYKLE45l/vjbHsnQTnRlxVh8OsZcxzS4o0L5OE0iJ
         sY3v8+cjd3c5yLGOUz+c/epwQipj8Jtoe8E+zHmdkmEh5t6OAMjSWvVVaey30J0BOKRC
         gFMI9F94bw4q/54gxpxAvbSvpcB9+nHhsFiWCcZSnGnF3PAwvjqk3B6tKTj79bpD3hTR
         ogFDuGXNUpl2M6IygLiSF+XZn2QIxxFbfKjASPKyhENwhHHuS6g5T+YQFEbao3qzB+77
         LBDPkHBMSyIVlRXCu82jStTjMJpwG9Cpx2VghBfIZXnEX4muorQ7UMERS0D5bl8Co/yN
         peRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757584382; x=1758189182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNugqJ6dpnTABYm+0JbEHRJnvG8/9x05gAdclmtnl7g=;
        b=AOwAYOcQftCYubiaLEX+0ptD5ac2ynX17bOFTj7RkgqGx1MzTRoFqUOTBKQDbQ4CXs
         sxLJIp8rerGeoW5d+SkU7ggUdGwAMx4lLHzHxOjVwK1XXkGwhGBcjsZFP6AM/mL+S76F
         6zsfqfUIQpzkdgiVWxP8NEDfZpSsX1/llvWgZ24hhnwyVcpg52yhqnukT12WzRg0DekW
         59GzuAK/uyLPGmSs4zmc6aLxdWZe96z3LHZf+b7R7B/oy6eXw4Tog8VfnVvGI1VGuKBn
         Khpp3lym+8+fzANzPeU44xEJyiu+ddnBmAcVZsJjj3xg0BjAxrgx5817i/KtX7GjbtdH
         nZKQ==
X-Gm-Message-State: AOJu0YzFbDGm1MxrvihBNfiQ3vcJ22z7uUEuHTLJNGHehik9tEOAblJT
	g1GZOTRHg3dRVQlqyeAe8YDAUEKh7mYdusSZYEqBoTCkuGDzZZ4HbPWv
X-Gm-Gg: ASbGncuI7sF2FGBqjlTUC2sC3JTtIq7SIwo4GnZ35NvRX/dH0MlVIgjqv5akKVQXxUk
	ds/WDlvmBiIVzHyI0lxoHuWJEjy8HC2L4lQH8HWN8up+7+5ZoytzpZ4zqtIzMDGXi4tfNsBav4u
	X6xEKcvKSj45PnKXUZm+vG9Y1uQ764E7fvBL6J1rX8VG4asT8XwyLzYQv9q5eDAm2FRlFUGKHsI
	P5oEYFKmuY3iLDZUsPt/V/S58idlQNvI4lC47/ni8CWSoPI0p3hmjN7Z2untAGAiBalGmBsyspa
	3L2KHjZQdELzPbiYRTCKK7ZHWaiKm6+EVZSzM8U9Hwo08LXteU/ULgQ2isYVaFP6vqHcIjjpZNa
	0UHtDbBiPew8ytOoOpze/oj9t2l9KXLE6DpRzM0HRsmFZD5iC/IPkSn/97m0MuYzqCVAKYEGw
X-Google-Smtp-Source: AGHT+IHSgpkbSgTD0QlNG5sAFaOhP8vFh+1xbEkg5VQAqa7ppQCAvvYJrMkfRMMvzerxx83GNRMK0A==
X-Received: by 2002:a05:600c:5d1:b0:45d:d86b:b386 with SMTP id 5b1f17b1804b1-45dfd5eec3bmr16253395e9.14.1757584381402;
        Thu, 11 Sep 2025 02:53:01 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607d7b67sm1791287f8f.49.2025.09.11.02.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 02:52:59 -0700 (PDT)
Date: Thu, 11 Sep 2025 10:52:58 +0100
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: KProbes for OpenRISC-linux
Message-ID: <aMKb-upZ2EUlHTcP@antec>
References: <e9f74ae6-10f3-4585-b727-928bb5749dd9@gmail.com>
 <aBoks-Muf4CxQvhv@antec>
 <278be55b-49e8-41ae-a7d4-c0eec6f1d90c@gmail.com>
 <aB5Qe9EpVSYAf60G@antec>
 <51b89c55-ee58-461d-a2a0-5c8dd8ba77e7@gmail.com>
 <56e910a3-46c7-4df1-b1cf-ebdfaf8e49dc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56e910a3-46c7-4df1-b1cf-ebdfaf8e49dc@gmail.com>

On Tue, Sep 09, 2025 at 09:56:06AM +0530, Sahil Siddiq wrote:
> Hi,
> 
> On 5/10/25 1:48 PM, Sahil Siddiq wrote:
> > Sure. Based on what I have understood from the synopsis of the GSoC proposal [1],
> > the focus will initially be on jump_labels. So, I'll start going through kprobes
> > in the meantime.
> I am writing this email to let you know that I am still interested in implementing
> KProbes for OpenRISC-Linux. My changes make use of Miao's text patching implementation.
> I should be able to send a patch soon.

Good news, we are looking forward to it.

-Stafford
