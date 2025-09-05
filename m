Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAE830E85A;
	Fri,  5 Sep 2025 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092390; cv=none; b=LvFJ249U3YEwknElGEI8WoeARcKOCjaka+mnWfLp/Puf96TXe+VRnLVOGV/9AKuX94X3dTgejF+4rBrZSC/dIctCqDKsvnZbjwdkI/zoAz4llfrbUWmXy2TwNmva7NgybYXYXIEegfY28rFfAQ0JwJJkay+xQ8K/z8d5Vuaijks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092390; c=relaxed/simple;
	bh=Y9ehm/NRrpfKkad+2N18Mcmjvu+O3ZJjhlvsYm03kRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFsgv0lpR/CO+PiP4e/LSjjcpweSjYRPXA2VHHCAd5xl/jRwUpryq9sEmvSMGZB4SxzFNoBa3KmWgOX8tyE5CnpYNqdYAokxYjKd66mDpKxTWjBBB7+kOzGKhVouFCj4Zhrt9as/B+iFoWbknMFSlV+YK3g0Za0BuqqTVc60cEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kqhf1zZQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kqhf1zZQ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so15950575e9.0;
        Fri, 05 Sep 2025 10:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757092387; x=1757697187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c3me8ckeEP54l+DgYhnwBA0gi43ti7Gl08QyLzuXdTc=;
        b=Kqhf1zZQdLJWBS8XxQVc41w3xW4g/Y3x3lAqWiobrboXpkAeJMEN1nORXy4hdAZy18
         rKBMeqrwGlXW6XSedrE3NohsVWURh4ckm4dWzjj1ETHEbIuPbS8A4si99UrprKP9ubWl
         Yv1uAoQGSL+f1+c/AJZmn9qMb+61hXER4YerAP75GLYIDZApQHwNkFyCJA4F7qObUF3c
         uqwpLLwTvmXOmcchdz/dACi8moshvdolIBlYcNE3C8nFSCvZ9XJHeT5D/LQpgmqMimgq
         rxZzh5cr0O+ouCD39wVh2hYl23ZvXk5iO/WCFeg8+ZWwS/4yfsBKwDMp8XgSpD51/sT2
         EtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092387; x=1757697187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3me8ckeEP54l+DgYhnwBA0gi43ti7Gl08QyLzuXdTc=;
        b=jhRqB3hcyQ7crqIk65S9MJpR3gKBdUK78ainfokO3zqocwzAfPPgIb0rSEeehUYxT8
         Bzbzii/jPDYR9J9l40LRw9D0Ga9h4eIh/68wyw08wEXU1mvrhYv3fBLQ29Fan15LCusv
         WCTpV1Id/XMNcwHwnCqrOed0o7fLgdxxgPwhx3Z+DEge4bwmaDbkK0GuFBuIEUJwowyN
         4aof2Nfqdo7i/fbndA4xxFl9b8hck0y7C6xvIuy0EFQkNUPA7CmdnDvgYlbR53pRbrB6
         bBjegi7Y+QnXR1b0ZH1IJFk0t2Dy7IGcBvebwYWVtdNYQTqwJLk8H5Lz0LDU8MfFoHIL
         Pghw==
X-Forwarded-Encrypted: i=1; AJvYcCVsPF/UJQH3Id6Haimkid2lEEtK4L8XBDK7yGid5wpHsrvCnD8ILtj+NFJEjDQ8X4YSLbzLbMEzGv45SrPfVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YydP8cE+SGHWFz7qqFHP2HpGFlde1svBIJN1+dEgV37hwX+YYaW
	mTHuMyp7Q8Ey4XMVs1L1xFesznOGy0k2Yaqwdua+cgnYbkbUJF5rOO/g
X-Gm-Gg: ASbGncvs4VVJiSEmkR0VVgtadbsnSzJ67zHVPd38QXgS7uJuPtLIfh7CPC6BgP/J4bO
	tCRjqpz2jwjA+ScGkRVK4q9TZ+V2N52efArOuxi4a7sROvoYsm8QBaEUy1YveMLeR8caPgRtDRB
	ItK79aKNqYUrItjMh0zkN/3Bc+4FyZFAOu25Z20DrDUHFBwuCuvAN6rcnGDOGzWtiV2VlCA8ine
	nNKZbuxJNjh4V4vCAZxECyaV/YEJxoCskMpDqYvaOL13n7/b6zkVxa+vfqdSqaYa0Cmmmoecf/I
	TePv2fQ9EFfG/CiZgzw8IPAR/E+fPzpmRk0hqxCk4E78XiMaTy1FJug4T2itqqr0NkPYxe/KAk+
	93L6dbK2lEHsISYq4p7gvesfXZcNuYZ7N1a3kc5ZmG6fy11Zt0jpHXzMFexlL5YdCXBQdi7ce
X-Google-Smtp-Source: AGHT+IHVZEFD3h/9I6GGi/rZObunQ49lbsWUV/59ib/Sv8BlypmXuasYsU0bufz1honwAtnh4VaPKg==
X-Received: by 2002:a05:600c:35ca:b0:45c:b5eb:b0bd with SMTP id 5b1f17b1804b1-45cb5ebb156mr107525775e9.8.1757092387020;
        Fri, 05 Sep 2025 10:13:07 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfcba94esm45863945e9.2.2025.09.05.10.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:13:05 -0700 (PDT)
Date: Fri, 5 Sep 2025 18:13:05 +0100
From: Stafford Horne <shorne@gmail.com>
To: ChenMiao <chenmiao.ku@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v4 3/4] openrisc: Regenerate defconfigs.
Message-ID: <aLsaIRSHCbnCLOFC@antec>
References: <20250904100109.688033-1-chenmiao.ku@gmail.com>
 <20250904100109.688033-4-chenmiao.ku@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904100109.688033-4-chenmiao.ku@gmail.com>

On Thu, Sep 04, 2025 at 10:00:51AM +0000, ChenMiao wrote:
> From: chenmiao <chenmiao.ku@gmail.com>
> 
> Regenerating defconfigs allows subsequent changes to the configs to
> be related only to the corresponding modifications, without mixing
> changes from other configs.

OK. Thanks,

> Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
> ---
>  arch/openrisc/configs/or1ksim_defconfig | 18 ++++++------------
>  arch/openrisc/configs/virt_defconfig    |  1 -
>  2 files changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
> index 59fe33cefba2..58e27d8fdb4e 100644
> --- a/arch/openrisc/configs/or1ksim_defconfig
> +++ b/arch/openrisc/configs/or1ksim_defconfig
> @@ -3,26 +3,22 @@ CONFIG_LOG_BUF_SHIFT=14
>  CONFIG_BLK_DEV_INITRD=y
>  # CONFIG_RD_GZIP is not set
>  CONFIG_EXPERT=y
> -# CONFIG_KALLSYMS is not set
>  # CONFIG_EPOLL is not set
>  # CONFIG_TIMERFD is not set
>  # CONFIG_EVENTFD is not set
>  # CONFIG_AIO is not set
> -# CONFIG_VM_EVENT_COUNTERS is not set
> -# CONFIG_COMPAT_BRK is not set
> -CONFIG_SLUB=y
> -CONFIG_SLUB_TINY=y
> -CONFIG_MODULES=y
> -# CONFIG_BLOCK is not set
> +# CONFIG_KALLSYMS is not set
>  CONFIG_BUILTIN_DTB_NAME="or1ksim"
>  CONFIG_HZ_100=y
> +CONFIG_MODULES=y
> +# CONFIG_BLOCK is not set
> +CONFIG_SLUB_TINY=y
> +# CONFIG_COMPAT_BRK is not set
> +# CONFIG_VM_EVENT_COUNTERS is not set
>  CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
>  CONFIG_INET=y
> -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> -# CONFIG_INET_XFRM_MODE_BEET is not set
>  # CONFIG_INET_DIAG is not set
>  CONFIG_TCP_CONG_ADVANCED=y
>  # CONFIG_TCP_CONG_BIC is not set
> @@ -35,7 +31,6 @@ CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
>  # CONFIG_FW_LOADER is not set
> -CONFIG_PROC_DEVICETREE=y
>  CONFIG_NETDEVICES=y
>  CONFIG_ETHOC=y
>  CONFIG_MICREL_PHY=y
> @@ -53,4 +48,3 @@ CONFIG_SERIAL_OF_PLATFORM=y
>  # CONFIG_DNOTIFY is not set
>  CONFIG_TMPFS=y
>  CONFIG_NFS_FS=y
> -# CONFIG_ENABLE_MUST_CHECK is not set
> diff --git a/arch/openrisc/configs/virt_defconfig b/arch/openrisc/configs/virt_defconfig
> index c1b69166c500..8a581e932766 100644
> --- a/arch/openrisc/configs/virt_defconfig
> +++ b/arch/openrisc/configs/virt_defconfig
> @@ -55,7 +55,6 @@ CONFIG_DRM=y
>  # CONFIG_DRM_FBDEV_EMULATION is not set
>  CONFIG_DRM_VIRTIO_GPU=y
>  CONFIG_FB=y
> -CONFIG_FIRMWARE_EDID=y
>  CONFIG_FRAMEBUFFER_CONSOLE=y
>  CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
>  CONFIG_LOGO=y
> -- 
> 2.45.2
> 
