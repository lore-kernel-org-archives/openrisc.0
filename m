Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550D91ABEA5;
	Sat, 26 Apr 2025 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745657449; cv=none; b=Ysd3NStydxmGdeSIX5xWZTp0bsBfbZPSLW2T8G6/z1kxm/c3RhqQR223B4xNcaZl/FOVJrua2Bfwn5+F2srVhHG3nw4ti8u9u5Fw8K8atLZZ+dUJVRJf/3Dr3meZFP3lyjHoAdMapZGGlHqNFOumqKdk0R2FgGmnpIiavP7KtTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745657449; c=relaxed/simple;
	bh=vOC+XArWTnrUyRqnOa0YSxgxbCDfn7LGUYWPMoGQ3xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ex1iQlXCT7dV/7F8gU9E4elnrIYecb/bNciC9UxeM8OdgD1BrJ5rk/lNPpKUtccB3HsgpgBDvIog4IZrPUyFR9v5bXtQyBxym2h9WccxCGSNPMPGXyK+rJU4ZTy8Mm1J1toT+B9BfrfcEcitV9k7CJ5CfnPj9YSPqPWYxdOpEHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEqWeTt9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEqWeTt9"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso27979175e9.1;
        Sat, 26 Apr 2025 01:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745657445; x=1746262245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u++CHq19depwRXmivfgeucz9xTKpXmOjbCOWLfIjFrw=;
        b=nEqWeTt9B3OZYjGtGITv+eRHwJIWc2Qy0+hjTAisXq6LXVSWVJgBeC9YMXnacBapJg
         BTqi5A9a49CRMMvTfSUjtghhQVKxPNgYdOnu1yM7mBZnG6ESY1wtGka6DGWeV95Yuz+d
         uxbXRLILzmRx31RrNkzRj736IQUHCA70fqvd29vEb9ZznoeCyLY4IKhgTxQ+U6mPA2+e
         hAu/wSXYGXXQQd6a/JSaZ5ugppZrPHfoPPyLvX53sj16EBIu4Atc4oF7Z7wfJVHrFYD+
         aqWCGzz/NVKu6pa9p8BkBnUcJTRjO02sfbsUxONegSU0UXCARnPt5SXUJHm8Os2hfarG
         5prQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745657445; x=1746262245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u++CHq19depwRXmivfgeucz9xTKpXmOjbCOWLfIjFrw=;
        b=eHhzzbpqRmRXUH/gtB1FF1f0sFdiesxxqkG3n5xvDg+xb831/3Knrxz8kmG4fxWFFp
         47CmYaigjX7Ud1gqp47oOVqmFtZvF3OuHfSZzpyouyAcRGx/LtNHYcobECzEjB0VY0rH
         Rf4Uu4NgqqV0EPGUd8WOgyDMzqdwKT9zNdt3d9TLKvJCONaVQzZebOPaFVw9ne3DiQP0
         MxvlJGtvbM2s7X7+HD6VHQcW87fvyEhxwMkmk/XvWua9qgH45fT4dA1TM+tXKyIDTm4x
         G0O45/zUXiC/YZrFSw+qKmIl0k3a29sWW+60+mml+k/65ffWt3QTCTl0cw1sADB5FHmz
         VYAw==
X-Forwarded-Encrypted: i=1; AJvYcCUnaoq+PIltRtKD5K7Ydh9N5SwrpyTbzXkeJW1QOj1ty2RwWmNUrhWwMneGmss5YZ9WAIh44mvXuFw=@vger.kernel.org, AJvYcCVoL/jCfTq2O/ggESbi2bNDNhxk0dMZkepNKlQeVqayVsOFsw4jbMZcarHYWPHEwguOYu9kDpUmW6tcwliVJOg=@vger.kernel.org, AJvYcCWOhIl86SJf3Z5ZoDGCqYQA6BntMDVRzMeAtcXxh0XI/ak3ZHsNA8p5AnAz45deAVNrRxnxz9KrEcqMBfAN@vger.kernel.org
X-Gm-Message-State: AOJu0YzdGu1c/IKsKtmH/Q22mFOZq5a0o/XkaW1kE7tVocaAUgy/HbU4
	/KKURbI7DYS+Y4QdX65nx79eHY0T4FXFZ/ZRn3Odhbd9rJrezJKiSX5/yQ==
X-Gm-Gg: ASbGnct/DAumDq3qyuBpgxj7nPUcvBtSyED0tUv8ATlvTm4USQar0b2jFP6fteUxZtn
	8Bou6po+8fo5zjMrAAMWw8kN3mxhcfv+trAZibQ0erzDJuUHBOSjbWgYeF4XDfpfbSD1DgAB8q/
	grFdLgS4kdHRGkmVLAg1LQ+5uApd/WFJu/JN2XZoZj1/pi3h8yiVFC3T0r75fihzkreVMNczyhG
	U6TGiOxMyu6XllkLDrXiQh9KCSnsHkRKHCYI7da0h31pjPpx4wZckKOKx9YOkfOLbvt+ZRyjdzE
	eCOUgJXtzRtHwXcTI4cTxzRPyq1BUPyBDNOUPJVGJJv1rD/22GrCZ5j4d/jSlyyDLYsDpRX7lDM
	3otn+tVvJh41SS0Y=
X-Google-Smtp-Source: AGHT+IGZ2JKoAMAnk3e/zD6qAb4IjMbF8OfH0tbLCxS6bSA2+zmwJ6Akf6HD9MCHePtBzvsH/W9qwg==
X-Received: by 2002:a05:600c:a345:b0:43d:82c:2b23 with SMTP id 5b1f17b1804b1-440a66985e6mr40692515e9.23.1745657445195;
        Sat, 26 Apr 2025 01:50:45 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d29ba29sm85440365e9.7.2025.04.26.01.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 01:50:44 -0700 (PDT)
Date: Sat, 26 Apr 2025 09:50:43 +0100
From: Stafford Horne <shorne@gmail.com>
To: Ann Yun <by.ann.yun@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, corbet@lwn.net,
	linux-openrisc@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation:openrisc: Add build instructions with
 initramfs
Message-ID: <aAyeY-cFSDuLYnJZ@antec>
References: <20250425201018.12756-1-by.ann.yun@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425201018.12756-1-by.ann.yun@gmail.com>

On Fri, Apr 25, 2025 at 04:10:18PM -0400, Ann Yun wrote:
> Mention how to include initramfs when building the kernel
> 
> Signed-off-by: Ann Yun <by.ann.yun@gmail.com>
> ---
>  Documentation/arch/openrisc/openrisc_port.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/arch/openrisc/openrisc_port.rst b/Documentation/arch/openrisc/openrisc_port.rst
> index a8f307a3b499..4ab28879d7ed 100644
> --- a/Documentation/arch/openrisc/openrisc_port.rst
> +++ b/Documentation/arch/openrisc/openrisc_port.rst
> @@ -40,6 +40,10 @@ Build the Linux kernel as usual::
>  	make ARCH=openrisc CROSS_COMPILE="or1k-linux-" defconfig
>  	make ARCH=openrisc CROSS_COMPILE="or1k-linux-"
>  
> +If you want to embed initramfs in the kernel, also pass ``CONFIG_INITRAMFS_SOURCE``. For example::
> +
> +	make ARCH=openrisc CROSS_COMPILE="or1k-linux-" CONFIG_INITRAMFS_SOURCE="path/to/rootfs path/to/devnodes"
> +

I think this is good, but maybe we can mention to refer to Documentation/filesystems/ramfs-rootfs-initramfs.rst
for more details on this?

Also, it may be helpful to mention we can get pre-built busybox rootfs images
here:

  https://github.com/stffrdhrn/or1k-rootfs-build/releases

But if we do that then it would be better to show how to use thos rootfs images,
which maybe something better we have in our openrisc/tutorials[0].

-Stafford

[0] https://github.com/openrisc/tutorials

>  3) Running on FPGA (optional)
>  
>  The OpenRISC community typically uses FuseSoC to manage building and programming
> -- 
> 2.37.2
> 
