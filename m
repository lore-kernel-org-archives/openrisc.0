Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82105CDB465;
	Sat, 14 Oct 2023 06:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjJNGal (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Sat, 14 Oct 2023 02:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNGaj (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Sat, 14 Oct 2023 02:30:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DFCCA
        for <linux-openrisc@vger.kernel.org>; Fri, 13 Oct 2023 23:30:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-405524e6769so17506745e9.1
        for <linux-openrisc@vger.kernel.org>; Fri, 13 Oct 2023 23:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697265037; x=1697869837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZhS6EfNjAu2Xk6+DSF0lcgeLcv7BCYYmC9iVjAo5xw=;
        b=JVHHR5GFfyc+UyDovVn5BTq5qZrbukwRCoimxpmdjT5AibimqdczseDjhxaZvenAiW
         ve98DOo3pNKyR2Nkmx89szXCGoERf7pdW5qTvSZBNWMTyYZk8HgdMM24ohimppGVH1OB
         y6LOAPobWhXwZl7XZ+rtY6M7xSe/1UT9oQpFAtvrnsA1Bgenuh8oDI25uLVDg9ZcYS0y
         Z3Y1z0Acf4/JCH46DT7QM8V+xEWow2GrgQJ/TxKjrHQ8n1y5e5IpshCZA+dLHqImN02c
         KrLip5z471N0KFx6w26egL6RZapLVrDY9sV3uUaNWQpZbC0AQtNkRjXi21D8qpV93UOn
         HmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697265037; x=1697869837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZhS6EfNjAu2Xk6+DSF0lcgeLcv7BCYYmC9iVjAo5xw=;
        b=Am+WLG1QdV/dENXVMilmONXRpVKbNr3aYwfDWlfxb0BVca/q2LD8DtktP9x8fGzI3C
         vjg0OfmV3zHUDoTNShExxVlAnZHYnEYxaSDR4SDi505TvMY92iVyflc/WU2Jnkob8PXt
         tvkiANL6PlzB5xnqr8eamdC0X19bBk4m+stvlLzXNJmSKytK3BOMAq2b0Bd9wBCOVtxY
         R0AcXHfYOCRQMFxxljLl/jbN028ZYwP+BSCtXRqJip5XHdYhaWaPSFkxcFhU2X2RhpQG
         1dY5IAyYvXlo1O2Tzi8as6OjlMaWWnvTCKeV51sOQIjR0FtpISmoyARhRF2nYNJa/HPn
         EUiA==
X-Gm-Message-State: AOJu0YwnMdpUUjqe0+rNSxW2bYinDb531hHFQc9uzj5qvs9vj9iuxWPa
        a3rAGgAsHrcIxjgNslS5hKY=
X-Google-Smtp-Source: AGHT+IHgJAMcmnFtHnMA9H6+U073rnN92J9qg0NMtx3Uc1X+CV7BeZTfMM++8Qzg0mvGKiDu9RF4wA==
X-Received: by 2002:a05:600c:3b06:b0:3fe:da37:d59 with SMTP id m6-20020a05600c3b0600b003feda370d59mr1491431wms.4.1697265036405;
        Fri, 13 Oct 2023 23:30:36 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c4e8c00b0040772934b12sm1130748wmq.7.2023.10.13.23.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 23:30:35 -0700 (PDT)
Date:   Sat, 14 Oct 2023 07:30:34 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Mike Frysinger <vapier@gentoo.org>
Cc:     GNU Binutils <binutils@sourceware.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH] sim: or1k: Eliminate dangerous RWX load segments
Message-ID: <ZSo1iv/ob7D8VRQj@antec>
References: <20230819074518.2253226-1-shorne@gmail.com>
 <ZSkrm9jO8ljxhpal@vapier>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSkrm9jO8ljxhpal@vapier>
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

On Fri, Oct 13, 2023 at 05:20:55PM +0545, Mike Frysinger wrote:
> On 19 Aug 2023 08:45, Stafford Horne wrote:
> > This fixes test failures caused by the new linker warning which report:
> > 
> >   ./ld/ld-new: warning: load.S.x has a LOAD segment with RWX permissions
> > 
> > Fix this by splitting the linker MEMORY into ram and rom to avoid
> > generating RWX sections.  This required tests to be adjusted to fix
> > issues with the move.  Namely:
> > 
> >   - fpu tests: were incorrectly using l.ori with ha(anchor) which now
> >     that we pushed the anchor up in memory it exposes the bug.  Update
> >     to used the correct l.movhi instruction instead.
> >   - adrp test: the test reports ram offset addresses, now that we have
> >     moved memory layout around a bit I adjusted the test output.  Some
> >     padding is added before pi to show that the actual address of pi and
> >     the adrp page offset are not the same.
> > 
> > Bug: https://sourceware.org/PR29957
> 
> nit: put [PR sim/29957] at the end of the git commit summary (first line)
> 
> otherwise, lgtm, thanks
> -mike

Thanks Mike,

I actually pushed this long back without the above update after I read Nick's
comment.  I for some reason missed that he said he was forwarding to the sim
maintainers.

Sorry for that.

-Stafford
