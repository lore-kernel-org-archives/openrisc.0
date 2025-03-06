Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BB04C6E
	for <linux-openrisc@vger.kernel.org>; Thu,  6 Mar 2025 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275523; cv=none; b=jY4OmJgDJbKskjqZDeyXLfYp+tXP0UjEXiNXwb1lJRZx/d751cB6lUM4lDMripg4ZhrSWLB1KXh1m3QymjSsm/JFupwoW0AFTE+0Z0fw1Jr0OrjKWJfXy6mWqEmGyRTNAgrjfKyZvkKBoP0SJ2bnPt+EmMlcLVAOJli4azM6TI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275523; c=relaxed/simple;
	bh=0iInUkr6YB9lRmxxnzbKbOFNE31vCim7xZLrJ/qaIj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMyP25F+ynpImwqrrQdAcqD9te2ed3N9rVlOyODFLvmdiRYkjRXipPOAg382KHF043BW5S8u9QUCvV8R6gF60BYmIVl+is7ULQ2wO0Cx2xF36XlT1NTtJRI+7+UJbZBnBPH4olyX47e4rIy+zkC6BH54LJKh/9wOddqSW+2yU4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQP8m9+5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQP8m9+5"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bcc04d4fcso5349905e9.2
        for <linux-openrisc@vger.kernel.org>; Thu, 06 Mar 2025 07:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741275520; x=1741880320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fRgwxpiT4aTdZ/wGnP3XHQkvcO+hTpqTs04DM1z7cmQ=;
        b=mQP8m9+5dy9cAXKADlzk9NKZSnjGGcGinVoYxZd2bjbenMAY7BB5X2kRNIS8wW1rwK
         2Pq1Kt+1Zwzl9mLJz7hR3rDq5TgWGPwPIfU2IoIdTbZo57FDUhi5DrDdkyRYytvINoqA
         FVBDIgAwNAENZ8qQEFHxQ74GbtwcI85Oj5wYMgj1fbzgtumOKvdepMA8c7T0p34rlKwz
         RIqgQqGiTDxYU7JGf5FSKOhGRRyqIEnUP8sDNzZj+Lv1K49nLQ8lYaKiL2zS/ajfXaqm
         VAHpbi3MZUmbU9EcEOd1iPAljiSOlsm81S8F+mZjo/eoUwYggZN3oPaQkEEeNBpJ9+wO
         Y4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741275520; x=1741880320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRgwxpiT4aTdZ/wGnP3XHQkvcO+hTpqTs04DM1z7cmQ=;
        b=YFfRQj+Ui9S6PnGxr20C71bpzRHjAtVs/FXzzpl2fG6rKYFqH6LVXKKFg+cC2DANAd
         k8LBwVCUp5FdRJLNJtgV5Mbm3q9qRM0Qmlf7dbAsKIK/zHryX72NQ654JtH7XyapJjbY
         QTZ153aivnkRWzM+UGsFOxdWl35OdqyMugdcN40I6cgRSww5Ku2JbHsapvXeKgzb+5QE
         zPbkGJdmnkhexTwqDpF7IelGLm6uVkhBnwXFhcUon78hOEixyepvEZLcz2Q5Fxrm8EDP
         I2YahBNJ1KeqnP0kWdzPErQigRxvNMvd6LnzqJ2oVTAka9dr2ipxghwE+3xZwrT3cMoN
         bDWQ==
X-Gm-Message-State: AOJu0YyUcrn3diY3mNuPrCbSZip80VLKk6cktwm4J+Z2eeE1E4GQwNXb
	XRNWJsJBc4P6JNDAlDiy6d0BR1E7IbVFXeMWlHLup5086Cd8QB1DEEAAANVF
X-Gm-Gg: ASbGncultipKQGudI4MMnDkj+Sn7gnkAkWC3dYoD1VikpRKdN478/rO/dtQe16wKxzF
	xSGdBMVp80+92UQRPO8z5ycrbVV8CtIm6PlsP0gfmoELURTlYaZ4TcmTdGWz71krbPWnkXIL/oQ
	z4ZfQWL+wZXuC39JH/sx1yLiW12YZBjivuLxIaK15gC0Z1IU+d/+hbJqJe4O22mXP9A6FVDWkbj
	0fXlw67Y9u6S++CWucgo3xdUH4C222kouAtX3YCukmJXAg0Uij51u2OCzfBVIxOipamkJlp74Gi
	YYhTge76LOn4WcBFSug8vvvbQmwFAjKKZ/eGiiX0LXDyDv3ysZJsB3Fs1LZjLcMIxHM07dilUL4
	8IT/6g+ER
X-Google-Smtp-Source: AGHT+IGDgckB4ZMZ5mZU0sxyKTq8ZJBoTAYCuLFuurn4bNWOB+P6Fky5fiath0W2dBMzKg+RrTDubg==
X-Received: by 2002:a05:600c:4f15:b0:439:8c80:6af2 with SMTP id 5b1f17b1804b1-43bd2ae000emr51699605e9.21.1741275519717;
        Thu, 06 Mar 2025 07:38:39 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01d2cdsm2410489f8f.57.2025.03.06.07.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:38:38 -0800 (PST)
Date: Thu, 6 Mar 2025 15:38:37 +0000
From: Stafford Horne <shorne@gmail.com>
To: Idzwan Nizam Jamal Abdul Nasir <idzwan.nizam@yahoo.com>
Cc: linux-openrisc@vger.kernel.org
Subject: Re: Performance improvements of Marocchino implementation
Message-ID: <Z8nBfbkXiNCcdtK5@antec>
References: <810295975.3514440.1740967866807.ref@mail.yahoo.com>
 <810295975.3514440.1740967866807@mail.yahoo.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <810295975.3514440.1740967866807@mail.yahoo.com>

On Mon, Mar 03, 2025 at 02:11:06AM +0000, Idzwan Nizam Jamal Abdul Nasir wrote:
> Hi,
> 
> I am interested in OpenRISC Benchmarking and Performance improvements task
> listed as one of the project ideas in Google Summer of Code. I am unable to
> participate in GSOC but I would like to contribute to the task gradually as I
> acquire skills in digital logic and computer architecture.
> 
> Is the task still open? I would be glad if you could point me to the right
> direction such as documentation I should read or tools I have to be familiar
> with. Any guidance is welcome and greatly appreciated. Thank you.

The task is still open.  There are other students interested so I will have to
end up having to choose the student with the best proposal and skill.

Please try to get started by reading up on what was done last year in this
space and see if you can follow some of the steps to get the development
environment setup.

Our previous GSoC participant, Leo, did a lot of ground work but never submitted
any formal GSoC progress report or documentation.

What he did produce were:

    Here's the embench-iot with fusesoc compatability changes applied:
    https://github.com/hhe07/embench-or-patched

    And here's some tools I made for working with instruction printouts on
posedge:
    https://codeberg.org/hhe07/or-analysis-utils

He started this blog with details of how to get OpenRISC simulations working
with Litex or FuseSoC.

    https://hhe07.codeberg.page/openrisc-work/

What we want to do is:

 *Getting started*
  1 Get openrisc mor1kx and maroccino working in embench-iot
    a. With SoC, either fusesoc or litex (fusesoc should be easier)
    b. With backend, either icarus or verilator (verilator seems to run faster)
    c. Serial output needs to work to be able to capture timing information or
      when tests start and stop.  In verilator this is a bit tricky but should
      work with the proper flags.
 *Recording Results*
  2 We next want to record reults in a format similar to embench-iot-results[0]
    a. Collect results for default maroccino, mor1kx
    b. Collect results with permutations of cpu and compiler config
      i.  Caches of difference sizes, enabled/disabled, different branch
          prediction algorithms, different ALU implementations, etc.
      ii. Certain instructions enabled/disabled by the compiler, -mror, -msfimm
          etc see `or1k-elf-gcc --target-help` (Note: the project aims to
          benchmark both CPU pipeline, compiler and instruction set efficiency)
 *Improving results*
  3 We next can look at where the cpus are lacking performance and how to
    improve things in the pipeline, LSU, caches etc.
  4 We can then go back to 2 (Record results again) and compare.

The 2024 GSoC project was only able to get done with steps in 1 and just started
with 2.a.  I think there is a lot of work left to be done, getting done with 2
for a GSoC project would be a great accomplishment.

[0] https://github.com/embench/embench-iot-results
