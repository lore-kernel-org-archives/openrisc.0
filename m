Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD7E1AB91B
	for <linux-openrisc@vger.kernel.org>; Thu, 20 Jun 2024 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892834; cv=none; b=B4zZKAYrqg3lRXwWYcBnCArPdABuhS1zmDPrnBiodhGkMUJPr/p/yniyzleDuMpdMVkeeTyecNFUYcIc6DEL6yKPAlj37BKdQTbT3Pe4PHPFAofrLhqu0zm+VNW0+dv4lXjPur5SpV3d3Q7lG03pqmLtz88Jvkx9VSJR+4vgl2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892834; c=relaxed/simple;
	bh=7iNDG+pX69CfOiq6z4uti3ImEjmhcDqEsqUE4vo+d64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTcRfHSwrd4rUT9ews5XmrKLB6H2I0brMa6IVyGGbCl9GExHopKXqc5FWkyZztRY6kjvzwGa8vsXFzAKb8wv0Sx1/J9Il5aJNXErv76uGRzJj7PHoRB0xFugU278I9mFYmGCmZAtUTbIWTsh3Dau2pmzbaOPhvpaB4Bii0O+Dq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvWK6scK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvWK6scK"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4218314a6c7so8347485e9.0
        for <linux-openrisc@vger.kernel.org>; Thu, 20 Jun 2024 07:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718892831; x=1719497631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi2FS7p72moMfuGMI4WMAWTXBZIOyz4i2lxiGfP7Xss=;
        b=MvWK6scK0+urrRKfq2E8Og+fjcohsyidKxoD/w30mgo94HfKF1rNunIL6V1FNpvDE2
         1LPStqwfsnfhPy/2CVRrY1/aEsTDyA05j96pVwgTfBpCZnGGydiXwpy2kdPd1fjtZ6zP
         SAzkmre9QlvgNl/2cmfTMTiSqDzHRn9eT5VGrTojSSO02+WRb9MNa2Mo+1Qz0G8iASto
         BPgNAfZoWdPj8tIQyKFPsr9pvMyjbz6xdXrMO4PzGIzha4CNT06iACQQsAQBrv8VI+d+
         QRAaxS4uyrzR1WcMam2DLsYEiMsMhhmZJJhjEahuO8poqQPYB+c2kC1/AfqRz7+E7Fyl
         YS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718892831; x=1719497631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi2FS7p72moMfuGMI4WMAWTXBZIOyz4i2lxiGfP7Xss=;
        b=UzWgoJyMGtEINNzVZRIn9EDgg69bn1QpM+ZN6Z1+OJg0VQDGwKbfGop4IMHo9PXeLX
         Znrc5R+/AnuyNekK3rhSztaaWThDdX7rDvWDay4T1WVl0q2ggaajaBS47l5vNzOBZgtX
         /oe/qQK+hnhOQw1ZYKB50DBBG+yeJ5BgxOZ4fQ9cLGfFwpWnPny3/2x+GKYzjJ/yavj/
         D85FTpP7WAESO6/AjyXDAa6nZi/voXJ5cdHojfczGcobxJiZ4s3SZJkt9Q1ztNlh+z5d
         YVH0JxvWb9GCwsc4mq/BQmdKoiYhzdLSHGjs0hiJ7symruAZb18nNdXCxDeUtpmzcwSu
         iouQ==
X-Gm-Message-State: AOJu0YzifFoLG+05orkBKdnlFqu3+X8KN8QF36SGfvdA9D6K01wYWNT9
	M+EaP+8SAE9Vm6q8nBpFL0nA4BHFnj5Ql6G65vjRx6J20rnKrJm1
X-Google-Smtp-Source: AGHT+IGsZnj3m8ftoLeObc7AzjbqcchP9W7K4NRaFrzypfvXQCZbN4+4wg453PImwkMbmz8IsGdayQ==
X-Received: by 2002:a05:600c:33aa:b0:422:7037:54d7 with SMTP id 5b1f17b1804b1-42475296928mr35608395e9.28.1718892830331;
        Thu, 20 Jun 2024 07:13:50 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d04f011sm26636505e9.0.2024.06.20.07.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:13:48 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:13:48 +0100
From: Stafford Horne <shorne@gmail.com>
To: Dru Nelson <drudru@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	julius@fossi-foundation.org
Subject: Re: An openrisc assembly question
Message-ID: <ZnQ5HKsc0fk6N5tw@antec>
References: <CALqrBYqb7AQhRFm-fTLca+S_-QQY30RvQeFWYQz4iUrSrVsg9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALqrBYqb7AQhRFm-fTLca+S_-QQY30RvQeFWYQz4iUrSrVsg9Q@mail.gmail.com>

Hi Dru,

Pardon the late reply, I have been away one a business trip.

I am not sure about the l. prefix for sure.  I assumed it just meant "Logic"
operations.  There are also "lf." prefixes for floating point and "lv." for
vector operations.

I am CCing others who may know the facts.
Also, BCCed a few in case they don't want their mail shared publically.

-Stafford

On Sun, Jun 16, 2024 at 04:08:19PM -0700, Dru Nelson wrote:
> Hello,
> 
> I have a quick question about openrisc assembly.
> Why do they prefix every mnemonic with the letter L?
> 
> dru
> Sent from my iPhone
> 
> 
> -- 
> Sent from iPhone
