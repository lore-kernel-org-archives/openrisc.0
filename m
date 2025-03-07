Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C606224253
	for <linux-openrisc@vger.kernel.org>; Fri,  7 Mar 2025 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363685; cv=none; b=B+oF59pR5dRO8kTWRlGUebr4sq+WJAYSi8jCcm1mOl580R9XlvPTx89tHuefjBeRrEzc8rAyqp1xQPa3x9mBxqlFO5EbQymsJ+64Dm4I9T9Mpe/xO1IibVShHc/AKSi3URTGdh82Up9t/Y84itqsmDIqUzBfZ0DlNONmPma4QzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363685; c=relaxed/simple;
	bh=6y4KycOADzeACslkM9Hy578zLGz0fRrbRDkY8ZYt0OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqoVZ6BwYrPX/q5xCtN2FVeUkikNX7f5eVxKQqJcsoRqbmGl3j48g27vL0vjwXoBC/b2WFiH8seTU8vuSFZ/RHN6lot1UGT22+JZWpV5PnWmhBQOdTH1nT1xwA3WxCExl/p4kLQp4bbqVWDNANlE9PyVt8J1/DqxonOY13BwFYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4Py6QkN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4Py6QkN"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bc31227ecso11921135e9.1
        for <linux-openrisc@vger.kernel.org>; Fri, 07 Mar 2025 08:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741363681; x=1741968481; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5iW8hpq8qqE3y+MGEgUaU5/UD8g7jlZPwLSNz7ZIVsw=;
        b=k4Py6QkNChSy2CK/jBGL218yKEZQINgZAcZQM8XaQ++KSzagmKPY+Nt0fRrUPUhGQW
         ExRc67+kc9rbjyIyhd3kyO9qeXNXS5wlbg47abbKKSgK0AhJBRIQQ+rkel/MlgHbHo0z
         OedEDYG2c7Hbl7cN+TJXBP1Yp5Tzs7UlI9gEhLI16k0pDe0N6SINnKJC/H0064DO1g3Z
         sBkCyedHTsuQpnPvwsMH/izgu2YrbZmd1kYGFY8IHrUx2KWQL1oB6D0JNBHf4Dwab0kF
         Up39JqIsFc7NHqzxKiUnIK2MXUwxOgID9vN8gzsxshktRwWG2AaGBEYKT5e4/+TRlAPs
         1Agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741363681; x=1741968481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5iW8hpq8qqE3y+MGEgUaU5/UD8g7jlZPwLSNz7ZIVsw=;
        b=DWW4KUOtd5SYJ8+lk7xMQhESdcMRI3dKiY6qcHd7ZfR0q7Q5KGtWPWaw2T2VmYhYTm
         Jac50BVYaHi3HXIMfdRwTJNU70deiV35/EDzhzu1CAKPu0Uku8T8KEvxcQn0N0gg1tmr
         kg7kWiYAPwogD91NW3C7uhh24NuZKLx2XEPuAi2PWS7bOplAM1i95pswSIp5s3y+YDCX
         8micMpreOipHXLpUU3JnqaIDOEed847JFvR944UcobCctcyz/AQutLXluMnCODurlXUb
         YNDngDZEr+cxzEePJQd805SBSgwTEdHFEL3LGZEuW6Nip6izUZrE/UTbksw3iRoRPG7W
         fYTg==
X-Gm-Message-State: AOJu0YwGKa1Fn5hLEDS5ZIBSBlLFFAEyzNv/VFTPmzjVamQviK9L2GBH
	SsSvMxFZynwQVHkCyG2oBL2waeg5aJqtwAhjpTCjc9Pwu2p41lY+g6R1QQ==
X-Gm-Gg: ASbGncuXGLpgnVYOBSd84KShdRtj81cqpXFdI4Q/ixObwEhaFzwc5AFWGcHwZ0wXXBq
	D6VoxDh4pD9iV0ONz/duAdG1WJcr2NZE/h+JK2Q+/QE5eZCAtIz9lO59sgERd9YkVLUp4G7LwiF
	Z4wopn7AAYvWT5Rq3KUYWYzxGA99llFAkjv57PJR7ov6/7J/ISUJWKGNedT9vZLiks2phpK6zXx
	GZmgs9HR6IZpG8KJ3X8N+ydqas1b8TgU0guA4pp7yxA81R4eFirinMibPzdZESQGG8kcVxD9opV
	KeeK7SmRHaLEF8xkaMML3T6pG+wiMJbad0kKF0zOF1a0eUyCt6N2P+hd4wUvWSVWZP1G8ydXUma
	AUJmudEGX
X-Google-Smtp-Source: AGHT+IFwc5+x3NyySDSj54uCRJE3NGAVyERIiUSw+F96HUcnV16P7e89kmcjkVcWbPxiozy4dMTorg==
X-Received: by 2002:a05:600c:1c28:b0:43b:cd0a:970f with SMTP id 5b1f17b1804b1-43c5a5e9848mr25858805e9.3.1741363681164;
        Fri, 07 Mar 2025 08:08:01 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103808sm5855109f8f.97.2025.03.07.08.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:07:59 -0800 (PST)
Date: Fri, 7 Mar 2025 16:07:58 +0000
From: Stafford Horne <shorne@gmail.com>
To: Idzwan Nizam Jamal Abdul Nasir <idzwan.nizam@yahoo.com>
Cc: linux-openrisc@vger.kernel.org
Subject: Re: Performance improvements of Marocchino implementation
Message-ID: <Z8sZ3li6rusgkcA1@antec>
References: <810295975.3514440.1740967866807.ref@mail.yahoo.com>
 <810295975.3514440.1740967866807@mail.yahoo.com>
 <Z8nBfbkXiNCcdtK5@antec>
 <16047285.689010.1741349294786@mail.yahoo.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16047285.689010.1741349294786@mail.yahoo.com>

Hello,

Replying Again, as last mail had html and didn't make it to the list.

On Fri, Mar 07, 2025 at 12:08:14PM +0000, Idzwan Nizam Jamal Abdul Nasir wrote:
>  
> Does it mean I need to send a proposal like a student who's joining GSOC too? 

Sorry no, there is no need if you are not doing gsoc.  If you can make progress
before gsoc starts I can stear students away from this project.

But please just post your interest and progress on the mailing list.

-Stafford

>      On Thursday, March 6, 2025 at 11:39:13 PM GMT+8, Stafford Horne <shorne@gmail.com> wrote:  
>  
>  On Mon, Mar 03, 2025 at 02:11:06AM +0000, Idzwan Nizam Jamal Abdul Nasir wrote:
> > Hi,
> > 
> > I am interested in OpenRISC Benchmarking and Performance improvements task
> > listed as one of the project ideas in Google Summer of Code. I am unable to
> > participate in GSOC but I would like to contribute to the task gradually as I
> > acquire skills in digital logic and computer architecture.
> > 
> > Is the task still open? I would be glad if you could point me to the right
> > direction such as documentation I should read or tools I have to be familiar
> > with. Any guidance is welcome and greatly appreciated. Thank you.
> 
> The task is still open.  There are other students interested so I will have to
> end up having to choose the student with the best proposal and skill.
> 
> Please try to get started by reading up on what was done last year in this
> space and see if you can follow some of the steps to get the development
> environment setup.
> 
> Our previous GSoC participant, Leo, did a lot of ground work but never submitted
> any formal GSoC progress report or documentation.
> 
> What he did produce were:
> 
>     Here's the embench-iot with fusesoc compatability changes applied:
>     https://github.com/hhe07/embench-or-patched
> 
>     And here's some tools I made for working with instruction printouts on
> posedge:
>     https://codeberg.org/hhe07/or-analysis-utils
> 
> He started this blog with details of how to get OpenRISC simulations working
> with Litex or FuseSoC.
> 
>     https://hhe07.codeberg.page/openrisc-work/
> 
> What we want to do is:
> 
>  *Getting started*
>   1 Get openrisc mor1kx and maroccino working in embench-iot
>     a. With SoC, either fusesoc or litex (fusesoc should be easier)
>     b. With backend, either icarus or verilator (verilator seems to run faster)
>     c. Serial output needs to work to be able to capture timing information or
>       when tests start and stop.  In verilator this is a bit tricky but should
>       work with the proper flags.
>  *Recording Results*
>   2 We next want to record reults in a format similar to embench-iot-results[0]
>     a. Collect results for default maroccino, mor1kx
>     b. Collect results with permutations of cpu and compiler config
>       i.  Caches of difference sizes, enabled/disabled, different branch
>           prediction algorithms, different ALU implementations, etc.
>       ii. Certain instructions enabled/disabled by the compiler, -mror, -msfimm
>           etc see `or1k-elf-gcc --target-help` (Note: the project aims to
>           benchmark both CPU pipeline, compiler and instruction set efficiency)
>  *Improving results*
>   3 We next can look at where the cpus are lacking performance and how to
>     improve things in the pipeline, LSU, caches etc.
>   4 We can then go back to 2 (Record results again) and compare.
> 
> The 2024 GSoC project was only able to get done with steps in 1 and just started
> with 2.a.  I think there is a lot of work left to be done, getting done with 2
> for a GSoC project would be a great accomplishment.
> 
> [0] https://github.com/embench/embench-iot-results
> 
>   
