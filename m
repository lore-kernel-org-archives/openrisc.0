Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E55C433EF
	for <openrisc@archiver.kernel.org>; Fri, 10 Jun 2022 01:00:11 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 634FA248F2;
	Fri, 10 Jun 2022 03:00:10 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mail.librecores.org (Postfix) with ESMTPS id A8E88248F8
 for <openrisc@lists.librecores.org>; Fri, 10 Jun 2022 03:00:08 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id u18so21598988plb.3
 for <openrisc@lists.librecores.org>; Thu, 09 Jun 2022 18:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=x15SER3XppMB1mQ1mrnOTHyHUkaSjeKqt6uasf4ICJw=;
 b=OLYYz7lrxQH8sypzkk/YVekwfxOio1IByfW2iocfPh1ss5NS4TfZs2J9A4foVK21ax
 NWxd47lzsZZYjNZ+7/i6BQLhI4YXDkvYcNFh4yD3KNdYd7TMX4qVr9fwG7SCuULNF1F5
 lW+V5mNLqZK1Gqu17FHSrev1Pu6e7u7f63F0L/85Z6gWAsh2fly5nJI090SlXgVry7Bs
 JjZTuX6IM1kvcW/lrJa99vMOi7MVEGwwRWd1ZhxTEC+ypyVs6icluuh8yyOfE5OIACUd
 9CNtTW8kHV24U6ikLIfKTLlJI4nf4LjVDz4lX9MTffEEKxsq9rAirLlEwCnNqBZcLXAa
 9wDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=x15SER3XppMB1mQ1mrnOTHyHUkaSjeKqt6uasf4ICJw=;
 b=1iS7uLeTIDgVe9REvYatJ7/YEzJUFvD3ztOQB9kZdgl80Xv1EYP4e1AYSYDkF+lywl
 7at8zJh9SvnmyOaqoeea1UPXhOC9COSiuXkvtDOLpkEGVgTnxrB+blbQWFVd70wbURtC
 wwWHb7kzpw33DLYyixRUVMa6MUwI2P8x6NQ/emGDIjXMNBRvr3qnAyDf4azpLEY2mon6
 EUF53Ud2uYAXWTrvry/9nfM+C/LFnV4vP2xhhzjEoGY0HCsiG5/fY077W6y1AkScfPrz
 Wj2FQYKg6J2d+sde98+uXRc232by7qkoOFAbrzvQc6qSmISKjpCG/DEXKfwnlKWmH1Ne
 LZ8w==
X-Gm-Message-State: AOAM532JTswLFaAMNDSMyDfh0FSxc/44GSa+y6Tj+PnqQwQhAov3jW3p
 nJXDgZOxXqCyUuK4OFXNQU8=
X-Google-Smtp-Source: ABdhPJxkXONIqvGzBatLm0YbsnaFcxUUc15z7EMu+eRv5IFqmSg6/LS70b9SYtf5Y3+FS9TBVWGpQQ==
X-Received: by 2002:a17:902:da87:b0:166:423d:f3be with SMTP id
 j7-20020a170902da8700b00166423df3bemr40504719plx.150.1654822807110; 
 Thu, 09 Jun 2022 18:00:07 -0700 (PDT)
Received: from squeak.grove.modra.org (158.106.96.58.static.exetel.com.au.
 [58.96.106.158]) by smtp.gmail.com with ESMTPSA id
 f3-20020a17090aa78300b001e09cab8893sm309906pjq.42.2022.06.09.18.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jun 2022 18:00:06 -0700 (PDT)
Received: by squeak.grove.modra.org (Postfix, from userid 1000)
 id 7638111403B4; Fri, 10 Jun 2022 10:30:03 +0930 (ACST)
Date: Fri, 10 Jun 2022 10:30:03 +0930
From: Alan Modra <amodra@gmail.com>
To: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH] or1k: Add support for a little-endian target variant
Message-ID: <YqKXk/h25IyLMscp@squeak.grove.modra.org>
References: <20220609060133.26409-1-samuel@sholland.org>
 <YqHXrxh5BRTk48o7@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqHXrxh5BRTk48o7@antec>
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
Cc: openrisc@lists.librecores.org, binutils@sourceware.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Jun 09, 2022 at 08:21:19PM +0900, Stafford Horne via Binutils wrote:
> In general I have no objections to this.  If there are processors that
> hare little endian it makes sense to support it.  Do you have any details
> of how people built for these before? I am curious.

The patch looks fine to me too, except that I suspect the testsuite
needs updating for little-endian.

-- 
Alan Modra
Australia Development Lab, IBM
