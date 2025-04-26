Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46646136;
	Sat, 26 Apr 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745684212; cv=none; b=vGa86Lcjrr0eU7qsSPkrCfXqNaEKOACX/1HYR3pI/tGnRfvWmgYGOmXVDpsNeGDgB9ZS7EvO32g8Ld/WRWHbRAQb+NPcoHC34VPpHCDccT3QBQbQcM0wlzD1De0+Oihhx4mDTCpzySgaQenUX6K6B8N2crd6gFzjORdmWaF7sPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745684212; c=relaxed/simple;
	bh=bpdkhL/t589TgFMO/E4dOwuSnMH2fQGyR4TpH9/Ocks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hROoP2yQUsGOHdK5Hp0AkZa2++aj47QhOr9g7TIlywFE7LaOLMeYE+j09+TviGc9LNVeK7w9Lhvb9QSQh54rtyjax/r34NXNol08NjAnM7m+AH/G86K6odY9WtVUg6fRPk9BC2DcBXUxiYKVD3ahUxJTqN1lzwE9P9q3M+l5O5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNdPcWZf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNdPcWZf"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so32139965e9.1;
        Sat, 26 Apr 2025 09:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745684209; x=1746289009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zp3fQrRUWHXbKvtzZBX9EuAXxb/MA/+/lmQHdJuziZU=;
        b=lNdPcWZfUfYq/S19fUHkDyC1ScIWBdbazLuVeUFpbHzb61zVToOZVb+ePfFxWQqvpv
         JeRW7Cgd7ct1OtZuojn+uxKV+cWF7aIZb83x0f+GOizDOx9mvS0uJTU46C1jwPH2QZ+M
         qyox+PNCZlgbCYP2R7Knc3Wj9FMu1rx5od7aS86pdSDfxnBMInSZogJDbpYUQN8CW/7I
         lhKuWsbe9gjWo+EYX0gf103/aMcbmmokutpsGX6sW7/us2qTQZwgRljfTUqDi+3fdKOJ
         9A+K2wusnsgl5A7rGmXoy9I5DiIVsHal0DoKXsEn2DyekkzM4SO57J+QiAhEPCBUaD97
         3okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745684209; x=1746289009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zp3fQrRUWHXbKvtzZBX9EuAXxb/MA/+/lmQHdJuziZU=;
        b=X+a4mgj/YULpl9UtVyDgcplKwq+dZcMZCopwkrkesInL+OkLyIO1L/RvDdVS4RXDCw
         nSfdT4K574mE4Dj/2bh5LzLDB/dcRHUuRG4RQNxD9FgkQmBb49xArz1p6cLBWw3b9n24
         mwMWPRto8Has7Dadjv1mkxp/ChLzbj/HdRxQEYWpJoMnkk8g9anlHyfYx6Lvm+3rBb6C
         sd2oTszY+jwaqYG9UPhBa4RYeS3GtaZ6hm5FlyxSHWTFrkCSsQuM4snRbuFXjlo/vOwv
         kn/mEQhMd9yzDnVJBEGfWB34kuGF13yJS3wr7oRwXpbF8ZupCa5RtjVmK+cF31Y2OfFs
         /ZQA==
X-Forwarded-Encrypted: i=1; AJvYcCUqMhDf9Lt+jCL18p+/EJHUyn9/lgwD/jX0a13UajU5bul509Z0qytPVHMCGyyJA2i35hs4+usKIuE=@vger.kernel.org, AJvYcCVD6OGd9XqvDkIG1onPKcEpDONxehqiRi2Crvo08+FZtN2UgaodACB4hXsGy9C1pks18hbrOyMCEaB8+Y81TB8=@vger.kernel.org, AJvYcCX0p5gfTJ4QxKXuGKeAd06RwAKFQJz/Kl2ezBvs95kbDeqkd71pg+Xdjv58ALnUw5MDeqKADBzvjcYjvGy8@vger.kernel.org
X-Gm-Message-State: AOJu0YxTSplDFD9zQNOt+R1xljqLVVe6fnAqZe32vv3nQg7pnBFWbhp3
	JAN4IbEh+nUXLrHpC6N7GMiNi4cMlDVzHvjdOT0RfQ57f1K+4b7m
X-Gm-Gg: ASbGncvDXelq2/QZ4SYmC6ajQt7Gi6Vw3z7j9B/C2jNC4LicmgT6Yrdp9r+t2X48bUY
	5qEpKc2WLgVl/X8Js4aD1FKtrZj46NEFsd306C3aY+SsxXoIBFDONT4PpZzEHlMJrR9+fGxQiiQ
	V7kjvCV1cjz0rfjfPW5Tk10uyMn+8w6PqKim3aTuyvdHc5cEX819vKqShzMAliDkZBbupcGHgTX
	EPAdX07/00BWqgtrd7V/yqL8KoDTDE8G5gK/1GaPLjbuHWD1yys46jyUGl1EoeQbkCl5eLVOx9o
	tx8SmyJRvYA3fokU8GAvRF2bMXSdEmxRStG2VvixMC7+p5l2flQoB0yHXdETr8j+yd/m8e55nAP
	jZD43
X-Google-Smtp-Source: AGHT+IHdPYbP+AuotpFDxFO4OqA9np45IJBZfPXINItoiFYPTHkA/T3N8MrGrdrUthV76FM+9yPMdg==
X-Received: by 2002:a05:600c:3494:b0:43d:fa:1f9a with SMTP id 5b1f17b1804b1-440ab378a92mr30724565e9.30.1745684208735;
        Sat, 26 Apr 2025 09:16:48 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2a2e59sm96867715e9.16.2025.04.26.09.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 09:16:47 -0700 (PDT)
Date: Sat, 26 Apr 2025 17:16:47 +0100
From: Stafford Horne <shorne@gmail.com>
To: Ann Yun <by.ann.yun@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, corbet@lwn.net,
	linux-openrisc@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation:openrisc: Add build instructions with
 initramfs
Message-ID: <aA0G74KvymHRU44-@antec>
References: <20250426154544.15351-1-by.ann.yun@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426154544.15351-1-by.ann.yun@gmail.com>

On Sat, Apr 26, 2025 at 11:45:44AM -0400, Ann Yun wrote:
> Mention how to include initramfs when building the kernel and
> direct the reader to ramfs-rootfs-initramfs.rst documentation for more
> details
> 
> Signed-off-by: Ann Yun <by.ann.yun@gmail.com>
> ---
> V1 -> V2: Mention Documentation/filesystems/ramfs-rootfs-initramfs.rst
> 
>  Documentation/arch/openrisc/openrisc_port.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/arch/openrisc/openrisc_port.rst b/Documentation/arch/openrisc/openrisc_port.rst
> index a8f307a3b499..69aed4069e3b 100644
> --- a/Documentation/arch/openrisc/openrisc_port.rst
> +++ b/Documentation/arch/openrisc/openrisc_port.rst
> @@ -40,6 +40,12 @@ Build the Linux kernel as usual::
>  	make ARCH=openrisc CROSS_COMPILE="or1k-linux-" defconfig
>  	make ARCH=openrisc CROSS_COMPILE="or1k-linux-"
>  
> +If you want to embed initramfs in the kernel, also pass ``CONFIG_INITRAMFS_SOURCE``. For example::
> +
> +	make ARCH=openrisc CROSS_COMPILE="or1k-linux-" CONFIG_INITRAMFS_SOURCE="path/to/rootfs path/to/devnodes"
> +
> +For more information on this, please check Documentation/filesystems/ramfs-rootfs-initramfs.rst. 

This is one trailing whitespace on the above line.  Can it be removed

-Stafford

>  3) Running on FPGA (optional)
>  
>  The OpenRISC community typically uses FuseSoC to manage building and programming
> -- 
> 2.37.2
> 
