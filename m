Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0EBC433FE
	for <openrisc@archiver.kernel.org>; Thu, 29 Sep 2022 14:30:23 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 6577E24851;
	Thu, 29 Sep 2022 16:30:21 +0200 (CEST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by mail.librecores.org (Postfix) with ESMTPS id 443FA24785
 for <openrisc@lists.librecores.org>; Thu, 29 Sep 2022 16:30:20 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id bq9so2495607wrb.4
 for <openrisc@lists.librecores.org>; Thu, 29 Sep 2022 07:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=D2lkRQCuHF3ThWvs1mxiesV0wdVCquhCSxFRRCWyCv0=;
 b=iMALSbyky95yHXp5C/DMlsV0O/oQPXNZBMo/IcK0/Hu+vb1V0jE0irnly5s9LEo9ZC
 lYLkIWwy2IlSL27z8W/8QsUtcaRDmnuXiOWgChnGkeY5GZe5yvPsyKMxyDWaJqhpiTH/
 QBN5B4lbCkfddf2xAtX5T2LnzAHp31Z35TU6vV0ALXQek3/xf/FdScfzVkdA1GQd5SkQ
 ifYYRcaIZsR6F8KG0MW1wWNIdyX/ik9HGMA7t9zSNofmZWM8ZvHM65FgBAsj8YCbkCkc
 uYozeYwDg9Kef2PpcUxOS0UxNOsQmFB81/8x5llU2k1TIW6PF+fCZTtEKu+eGecCGvpQ
 PSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=D2lkRQCuHF3ThWvs1mxiesV0wdVCquhCSxFRRCWyCv0=;
 b=Zc3gORkuDvcUvbj7PlzKQU5yGsinmlMqjsvOZveW9aevGDyaoDJ4RBEA4okpKddh6U
 vyv4RzVxlkltKRzYUBAM0Tg5m9mHIksw2hR0XuCZYnoiuDbUTmJ/M4/GUyTkiZ/bK6Bc
 guYBkq/z/X1WCSNPoVzKxDNmMxWL1ZGOS4zvb4Uok1J+AQckkyjqX8Vzzh+Hvci1ijXR
 Tcb39CNZPqUonEtfQxOJ2J/SHpxALFpq16teAKkRMoTRI5K2MKv3CtvEMjP/87qCThmu
 lrJ68WOwtj9U/KncbNkxxss/lrscPvEBqtBLL4IuMIGyVRJoeYvgai6usIw3OoWTP0yb
 s2tw==
X-Gm-Message-State: ACrzQf28BX2wNA+HWWU6Mv/OHxT17TiDhq11c5z0/Kar+EJFzgHCyl5M
 sHRcXfinjP3DOtF8WQ8ogB4=
X-Google-Smtp-Source: AMsMyM6xPtQOGyS1GcMriCqoY1+CKok3+WbriymFW3pwIEfpIfR3XLIuCYZ3t85p9ZgVut5Wa/Bfyw==
X-Received: by 2002:a5d:4bc3:0:b0:22a:4b7a:6f60 with SMTP id
 l3-20020a5d4bc3000000b0022a4b7a6f60mr2572401wrt.549.1664461819743; 
 Thu, 29 Sep 2022 07:30:19 -0700 (PDT)
Received: from localhost ([2a03:b0c0:1:d0::dee:c001])
 by smtp.gmail.com with ESMTPSA id
 hg6-20020a05600c538600b003b4e009deb2sm5127754wmb.41.2022.09.29.07.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Sep 2022 07:30:19 -0700 (PDT)
Date: Thu, 29 Sep 2022 14:30:18 +0000
From: Stafford Horne <shorne@gmail.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] openrisc: update config files
Message-ID: <YzWr+mmtLy2DRYEA@oscomms1>
References: <20220929101458.32434-1-lukas.bulwahn@gmail.com>
 <YzWp+p+1V1UmCAb3@oscomms1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzWp+p+1V1UmCAb3@oscomms1>
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

Hello,


On Thu, Sep 29, 2022 at 02:21:46PM +0000, Stafford Horne wrote:
> On Thu, Sep 29, 2022 at 12:14:58PM +0200, Lukas Bulwahn wrote:
> > Clean up config files by:
> >   - removing configs that were deleted in the past
> >   - removing configs not in tree and without recently pending patches
> >   - adding new configs that are replacements for old configs in the file

Not all of these apply to this patch.  Can you on mention what you changes you
are doing here?

> > For some detailed information, see Link.
> > 
> > Link: https://lore.kernel.org/kernel-janitors/20220929090645.1389-1-lukas.bulwahn@gmail.com/
> > 

This extra newline is not need.

> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> Hello,
> 
> Thanks for the patch this looks fine to me.  Usually I just generate this
> defcnfigs using make savedefconfig.  If there is some better way which
> doesn't generate the file with the # comment's I haven't found it.
> 
> I will queue this.

Actually..

About the subject 'openrisc: update config files' and description.  Can you be
more specific about what updates you are making for this patch?

For example: remove comments from config files.

-Stafford

> > ---
> >  arch/openrisc/configs/or1ksim_defconfig    | 5 -----
> >  arch/openrisc/configs/simple_smp_defconfig | 4 ----
> >  2 files changed, 9 deletions(-)
> > 
> > diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
> > index 6e1e004047c7..af1164807206 100644
> > --- a/arch/openrisc/configs/or1ksim_defconfig
> > +++ b/arch/openrisc/configs/or1ksim_defconfig
> > @@ -19,9 +19,6 @@ CONFIG_NET=y
> >  CONFIG_PACKET=y
> >  CONFIG_UNIX=y
> >  CONFIG_INET=y
> > -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> > -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> > -# CONFIG_INET_XFRM_MODE_BEET is not set
> >  # CONFIG_INET_DIAG is not set
> >  CONFIG_TCP_CONG_ADVANCED=y
> >  # CONFIG_TCP_CONG_BIC is not set
> > @@ -34,7 +31,6 @@ CONFIG_DEVTMPFS=y
> >  CONFIG_DEVTMPFS_MOUNT=y
> >  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> >  # CONFIG_FW_LOADER is not set
> > -CONFIG_PROC_DEVICETREE=y
> >  CONFIG_NETDEVICES=y
> >  CONFIG_ETHOC=y
> >  CONFIG_MICREL_PHY=y
> > @@ -52,4 +48,3 @@ CONFIG_SERIAL_OF_PLATFORM=y
> >  # CONFIG_DNOTIFY is not set
> >  CONFIG_TMPFS=y
> >  CONFIG_NFS_FS=y
> > -# CONFIG_ENABLE_MUST_CHECK is not set
> > diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
> > index ff49d868e040..84ca3203af9c 100644
> > --- a/arch/openrisc/configs/simple_smp_defconfig
> > +++ b/arch/openrisc/configs/simple_smp_defconfig
> > @@ -27,9 +27,6 @@ CONFIG_NET=y
> >  CONFIG_PACKET=y
> >  CONFIG_UNIX=y
> >  CONFIG_INET=y
> > -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> > -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> > -# CONFIG_INET_XFRM_MODE_BEET is not set
> >  # CONFIG_INET_DIAG is not set
> >  CONFIG_TCP_CONG_ADVANCED=y
> >  # CONFIG_TCP_CONG_BIC is not set
> > @@ -60,5 +57,4 @@ CONFIG_SERIAL_OF_PLATFORM=y
> >  CONFIG_TMPFS=y
> >  CONFIG_NFS_FS=y
> >  CONFIG_XZ_DEC=y
> > -# CONFIG_ENABLE_MUST_CHECK is not set
> >  # CONFIG_RCU_TRACE is not set
> > -- 
> > 2.17.1
> > 
