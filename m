Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE1FC433F5
	for <openrisc@archiver.kernel.org>; Thu, 29 Sep 2022 14:21:50 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 94E4524851;
	Thu, 29 Sep 2022 16:21:49 +0200 (CEST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by mail.librecores.org (Postfix) with ESMTPS id 673C6248B4
 for <openrisc@lists.librecores.org>; Thu, 29 Sep 2022 16:21:48 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id s14so2496418wro.0
 for <openrisc@lists.librecores.org>; Thu, 29 Sep 2022 07:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=6/3S4SqDN7s02eu32dMD8zSI0cpG/EMn6+nA5mGI7Ig=;
 b=fohR4TTWFo+aKaHOU80z8jlxlGze8JyK+FrBc031T77KQZjIKD1kcmlEfNLLQNy7sJ
 jn2LrXu1f+AoDZ+Yu/xeKVa/kCtmmoLudUJnRNawU4you7Rcx/9qKudGs+Nr98N83all
 g1AKVIpjsD5zcWDt1G5WOARNrDPde4Y4CPAL9XL+MW2SPguZbGEL6a3bfNseR3Q0oBK0
 4MsLhSRQB7tKe7xv6SajZ2mKlS+liv05/aAU9BSN5Du07jR+fLACrr7EO5TBoAoxyLx8
 DVwVdErCAmq4op/49bnX3LTJeZNqYe7wdYYh3NrwA8L4gAD/K292M4249UM+a2AhC8bP
 5kjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=6/3S4SqDN7s02eu32dMD8zSI0cpG/EMn6+nA5mGI7Ig=;
 b=gaTqhK5NngFMsL+hOE8jK/szX/EZkT2USqoZvLQqRjxlBZ/Yatk8bhhw95CP+p981x
 1KznyLwuKfpb4Za70LRiTgm0o7ESWq+aSTrzEb7R0ZDx5U2bhDA4FVlTGoG960ZWwZXI
 WtVfyJg2bTaXqaRw75ax69N/pIraFLhusHDNA+2737EgziJHFwsBRxPOM27K68e73vU4
 vvkoM9H/5WChcUKwQpUMTVUSMIpASDdO1aUzrJ6ruVQmqoos8SY7ZlrUF/0OGTmF1FZm
 mWj2c3Ye0ZKNUXSzhyGtVpO9P1ynoGm34vg7m1VIMOOPpaZ+6r2cyKTux+52uo2WOXRm
 kS5A==
X-Gm-Message-State: ACrzQf0eS/R3tVYfgho5bxHPo6NB+D5+ZvT/QXfIvNZsNZReMKtReh9z
 KpnZbVn9w7nIXG3gEBFxG7E=
X-Google-Smtp-Source: AMsMyM5uPhqI7tGH6OtYXpZMFPVOnRLcTvo3E6MDWHWjwFtaNwwoHyK6OOkdOq6PXfjMjY2YrxcDag==
X-Received: by 2002:a05:6000:78e:b0:22a:7e99:da93 with SMTP id
 bu14-20020a056000078e00b0022a7e99da93mr2484830wrb.20.1664461307820; 
 Thu, 29 Sep 2022 07:21:47 -0700 (PDT)
Received: from localhost ([2a03:b0c0:1:d0::dee:c001])
 by smtp.gmail.com with ESMTPSA id
 z14-20020adff74e000000b002205a5de337sm3856422wrp.102.2022.09.29.07.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Sep 2022 07:21:47 -0700 (PDT)
Date: Thu, 29 Sep 2022 14:21:46 +0000
From: Stafford Horne <shorne@gmail.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] openrisc: update config files
Message-ID: <YzWp+p+1V1UmCAb3@oscomms1>
References: <20220929101458.32434-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929101458.32434-1-lukas.bulwahn@gmail.com>
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: Jonas Bonn <jonas@southpole.se>, openrisc@lists.librecores.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Sep 29, 2022 at 12:14:58PM +0200, Lukas Bulwahn wrote:
> Clean up config files by:
>   - removing configs that were deleted in the past
>   - removing configs not in tree and without recently pending patches
>   - adding new configs that are replacements for old configs in the file
> 
> For some detailed information, see Link.
> 
> Link: https://lore.kernel.org/kernel-janitors/20220929090645.1389-1-lukas.bulwahn@gmail.com/
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Hello,

Thanks for the patch this looks fine to me.  Usually I just generate this
defcnfigs using make savedefconfig.  If there is some better way which
doesn't generate the file with the # comment's I haven't found it.

I will queue this.

-Stafford

> ---
>  arch/openrisc/configs/or1ksim_defconfig    | 5 -----
>  arch/openrisc/configs/simple_smp_defconfig | 4 ----
>  2 files changed, 9 deletions(-)
> 
> diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
> index 6e1e004047c7..af1164807206 100644
> --- a/arch/openrisc/configs/or1ksim_defconfig
> +++ b/arch/openrisc/configs/or1ksim_defconfig
> @@ -19,9 +19,6 @@ CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
>  CONFIG_INET=y
> -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> -# CONFIG_INET_XFRM_MODE_BEET is not set
>  # CONFIG_INET_DIAG is not set
>  CONFIG_TCP_CONG_ADVANCED=y
>  # CONFIG_TCP_CONG_BIC is not set
> @@ -34,7 +31,6 @@ CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
>  # CONFIG_FW_LOADER is not set
> -CONFIG_PROC_DEVICETREE=y
>  CONFIG_NETDEVICES=y
>  CONFIG_ETHOC=y
>  CONFIG_MICREL_PHY=y
> @@ -52,4 +48,3 @@ CONFIG_SERIAL_OF_PLATFORM=y
>  # CONFIG_DNOTIFY is not set
>  CONFIG_TMPFS=y
>  CONFIG_NFS_FS=y
> -# CONFIG_ENABLE_MUST_CHECK is not set
> diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
> index ff49d868e040..84ca3203af9c 100644
> --- a/arch/openrisc/configs/simple_smp_defconfig
> +++ b/arch/openrisc/configs/simple_smp_defconfig
> @@ -27,9 +27,6 @@ CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
>  CONFIG_INET=y
> -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> -# CONFIG_INET_XFRM_MODE_BEET is not set
>  # CONFIG_INET_DIAG is not set
>  CONFIG_TCP_CONG_ADVANCED=y
>  # CONFIG_TCP_CONG_BIC is not set
> @@ -60,5 +57,4 @@ CONFIG_SERIAL_OF_PLATFORM=y
>  CONFIG_TMPFS=y
>  CONFIG_NFS_FS=y
>  CONFIG_XZ_DEC=y
> -# CONFIG_ENABLE_MUST_CHECK is not set
>  # CONFIG_RCU_TRACE is not set
> -- 
> 2.17.1
> 
