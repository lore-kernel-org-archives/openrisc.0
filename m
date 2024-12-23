Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D8614293
	for <linux-openrisc@vger.kernel.org>; Mon, 23 Dec 2024 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734959157; cv=none; b=G2rQ2y6UvoH8TeSdnFIfYERA9SaBCRHQxt9sm56M7cmaa/6dUcgYSddLd9RsVE7hgOgIr2qp9CXjrMl0q2triO1Nx3dpgBgtpulIEOlSnfG4aL+0o/8t523gd6HJnXjCH0IzOdB50MMU9VNJ8xAI3dR8dtbxGPQgRVOq2nxa2Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734959157; c=relaxed/simple;
	bh=TO0sqPdT9VR/yskt6Z5hywRsIjd/s6X9CexAAqRuh+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtnM9VO+kwaQ/ydFrCxR/iHOMKp5cM30H8j8atMFchqKWMN7r3LJympJ7tbuNfEo+gnWIx6wr0h0IO0bZMU7CJxswvrjnn8yp9/bnWXzcnXVZeBF29/dcF4r/TRWuoaKpYQXRmJZxdMQOnIBmlHW5WMeLzK+TaeG23Gf7kQ0dtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btfIA2QB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btfIA2QB"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-436345cc17bso30553385e9.0
        for <linux-openrisc@vger.kernel.org>; Mon, 23 Dec 2024 05:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734959154; x=1735563954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJZA8aIH2hF6nRR7Q585417JyQyDA2yXP2MpwsXzLe8=;
        b=btfIA2QB95AEdAL2olpXwxU6qqq+u1Mpzs3pDas0rHOirdyCptDIZdVegoIdWlM0TY
         zeFHgV2NSaYr62eHb00rxecidyEgSL6oBHdnGFQ19Mqi34iS2t6hwxXkliC/2/F1s+jb
         mRfSgg/BhwpFE2b5RsAPwO/S9KidGvZEiCQExRCkvvVVFWSJthqmp0kK2mp57C+ST+GJ
         CRnvfXfmD2NlLsY++SrN6su6RfYXjpW+PJvZvIF/pqkIsYiyjtsVS7qb1mPocEG+VXQi
         iycr/ZDfIyhwzcZ7rjgh/fbfQb2B1Xy9ZGW5IKw5msbJq/pzrfB1/4kfW0Qx8RC16rXs
         5ULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734959154; x=1735563954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJZA8aIH2hF6nRR7Q585417JyQyDA2yXP2MpwsXzLe8=;
        b=fK/r+V53lwbgl+jSmXXzF5mcK/2HlN5/m3eQXzrVWZH1ovUkDhzhDgFVD3j3Cb1HGE
         apja05102ltLa2T8r/1naxLoTlbc0CdbF/hj+ThdMrgxllczYDN8jg07RgXoSyqDP9w0
         8cYgDeEXFLXMUaP/79+he1YITTFEW7wKZvbFUssJ/USPYcUpMabNUjSwmWxTLnAzm0xz
         nTuob2a/vvQGx67Nw+2cPQZsr9jY7fVTlduiZgImmTJrcLgHvyHNft6pPKjKT16GhOtN
         WfIuFL7gGkyWgS61M0rv+PsgTHkgaYnC2CZ7NLuW2fNY1MTlCxBVng/bqp5w2xd/C+IZ
         ICrw==
X-Forwarded-Encrypted: i=1; AJvYcCUkAtskjT0ymAkuFdg67kiv+Yr07sWkI+tDJaInoB887Af1fYcvwLxGr5QqnQjdT1oR8OxyUKUuSNFVIJV/ZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOshuK0iU00hhgmoQ+MyuaBMUWUQpa424tr/vfSL3bdW8wTBxw
	m7By1LX5DjIvPu7gO04qUtv6gP5WtXPcWNSZplDFHha4zl7sf3IM
X-Gm-Gg: ASbGncu9hpp/YRXvNnsJAjCKoH0raxlFvoQTEsv4/Y1ztHjWYW7wbnApOFs2aR4R+2s
	C5uocLSuIL8+uacAytxufVZy4GkAceaVGHZk6G2T7SwdBn++lCzpWUAVlnq8McaGbw7bneAKUYb
	HRVPeueuivTnGE5CTx7Sv7gRzwmhvziMOBy66MDd6MfwhH/Ifnl0SA+febQdalWOJQLwZe+A5bd
	k3+KQnC96fqdgdR3VBToV+8YP/VXV/eyymo5jwb+8aGVtAPdM3OBTW+j0Qm66abwOojJo13uf4S
	A7pRL73ZMe+QPON6SK5o
X-Google-Smtp-Source: AGHT+IGQl/G8wSP5yMr8WqG/kPJCMHd4Lu+TB7B5wpdiAuw3pY8srqlCbieEo/q4ZxzsZYcY1MzI1Q==
X-Received: by 2002:a05:600c:1ca7:b0:434:fe3c:c67c with SMTP id 5b1f17b1804b1-43668b5e201mr96260495e9.26.1734959153340;
        Mon, 23 Dec 2024 05:05:53 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661289995sm134953735e9.36.2024.12.23.05.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 05:05:52 -0800 (PST)
Date: Mon, 23 Dec 2024 13:05:51 +0000
From: Stafford Horne <shorne@gmail.com>
To: Rob Landley <rob@landley.net>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: or1k -M virt -hda and net.
Message-ID: <Z2lgL31ZeSkO59MZ@antec>
References: <afac091f-08cb-0f6d-4c01-bfa4421e7a47@landley.net>
 <Zufcf4iAqosZ7VBf@antec>
 <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec>
 <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec>
 <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
 <Z0LMqEqcdjkAxnN-@antec>
 <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>

On Sun, Dec 22, 2024 at 11:29:19AM -0600, Rob Landley wrote:
> On 11/24/24 00:50, Stafford Horne wrote:
> > > Speaking of which, is there a way to get or1k to exit the emulator? I told
> > > the kernel to reboot but it says "reboot failed, system halted" and hangs
> > > instead of exiting qemu. (My testroot runs qemu under "timeout -i 10" to
> > > kill it after 10 seconds of inactivity, I.E. nothing written to stdout, but
> > > it still counts as a failure on one of the criteria.)
> > 
> > With the or1k-sim board it is not possible.  Traditionally on or1k we use
> > special NOP instructions to reboot simulators i.e. 'l.nop 1'.  The QEMU team was
> > not happy to support this mechanism.
> > 
> >    https://lore.kernel.org/openrisc/fb69c137317a365dcb549dfef1ecd2fbff48e92c.1492384862.git.shorne@gmail.com/T/#mef76d30d294aed84548b1e0d3e23aae499deaeec
> > 
> > As an alertnative we can use the 'virt' board which supports shutdown and
> > restart via the generic syscon drivers.
> > 
> >      $ grep -C1 SYSCON arch/openrisc/configs/virt_defconfig
> >      CONFIG_POWER_RESET=y
> >      CONFIG_POWER_RESET_SYSCON=y
> >      CONFIG_POWER_RESET_SYSCON_POWEROFF=y
> >      CONFIG_SYSCON_REBOOT_MODE=y
> >      # CONFIG_HWMON is not set
> 
> I built the 6.12 ARCH=openrisc virt_defconfig and got it to boot my
> initramfs, but while it does shut down, it hasn't got network or block
> device support.
> 
> The kernel config looks like it should have virt block device support, but
> nether -hda README nor "-drive file=README,format=raw,id=hd0 -device
> virtio-blk-device,drive=hd0" seem to be wiring it up in qemu where the
> kernel can find it?

The default virt_defconfig should have the drivers we need.  The OpenRISC virt
platform supports PCI and virtio devices, so I select many of the related
drivers.

    $ grep -C1 -e PCI -e VIRT arch/openrisc/configs/virt_defconfig
    # CONFIG_WIRELESS is not set
    CONFIG_PCI=y
    CONFIG_PCIEPORTBUS=y
    CONFIG_PCI_HOST_GENERIC=y
    CONFIG_DEVTMPFS=y
    --
    CONFIG_BLK_DEV_NBD=y
    CONFIG_VIRTIO_BLK=y
    CONFIG_NETDEVICES=y
    CONFIG_VIRTIO_NET=y
    CONFIG_ETHOC=y

In my qemu startup I wire in the hard drive and network in my qemu start script:

 - https://github.com/stffrdhrn/or1k-utils/blob/master/scripts/qemu-or1k-linux

This uses:

  -device virtio-net-pci,netdev=user -netdev user,id=user,net=$IPRANGE.1/24,host=$IPRANGE.100
  -device virtio-blk-device,drive=d0 -drive file=${DISK},id=d0,if=none,format=qcow2

> Haven't tried to get fancy with the network yet. The buildroot config is
> still or1ksim...

Yeah, its nothing fancy for me either. The buildroot with systemV init scripts
get everything working for me.

-Stafford
