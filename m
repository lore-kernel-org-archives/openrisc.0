Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2698FC43334
	for <openrisc@archiver.kernel.org>; Mon,  4 Jul 2022 20:26:36 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 22617211D5;
	Mon,  4 Jul 2022 22:26:35 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mail.librecores.org (Postfix) with ESMTPS id 1FA1420C94
 for <openrisc@lists.librecores.org>; Mon,  4 Jul 2022 22:26:33 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id 67so119432pfy.5
 for <openrisc@lists.librecores.org>; Mon, 04 Jul 2022 13:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=AGwRvWCCXxaNyzavWyqNngeZRBKVx4fqE5pni+I28Y8=;
 b=oKjCpLuE4IAP4vSAtCd3XH09gijYQ59ZKq0Nga0TAGCN36u8S8nT+3KnodDhAOZV/6
 mkuu8nThC6F4zUN/OCJIoOHfM7D3fYItMozSRLq4CyLtnthDSOXWyo2vsTxyvPr8j3hb
 2tdKJ5nGOOcvY+h03flq7aHT1moe4V3XiATqnqGmtcECuvlpY+WFgW0pVzX8q8xzYNSS
 N+/wv+IF81e2EEMQS6NRdI7CLNNZsYdgtTxCIXA+EQ83NJuzUNKivMiQDzOfCJqNZmSz
 Zj+jQq8Q2wIaXM0rpYIFIJey9rPklnmcwZWTwZm/HYcZBdKEAV/A8MO1GYZk76o6uNsc
 hxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AGwRvWCCXxaNyzavWyqNngeZRBKVx4fqE5pni+I28Y8=;
 b=RnGGaVARFbFuPweeN5BJodEOxgyo4bFDjqGO36v8DcgqdiBpQofz9zbIoVi52D0QwV
 CaY5O9w5UBwIjzrMGtJ+PRI1Wv5slGUmoL1MEXIBO1RakHxf9BVm3KeFNlA2izUMSBQw
 9v7PGL9QFHu4AOkYTzNeygbLm+mTNn8WN8+WauL9wB7mVfFl4jEeDrODhfav30v5Y/pJ
 UOCZjwTGVpBwFLrhOEXrCtWXrKyQooQp4lfabgt/YR6JqD2YFCeX38d50h/SQOUcGt80
 K23pzQH+XJ3/TX82LzuZUjWJ/5kn9D98nOfq2zkmBFrbmsghknD4C7pDeGOAE57rAkrT
 QRsQ==
X-Gm-Message-State: AJIora9e8tPDXAeAyMTfhW+3IAvFnW+8nf16JP8ky8tqkSEoUrQxle73
 O7ZQYVgAU9YxwIDSurvenM0=
X-Google-Smtp-Source: AGRyM1vBuurZ1e8WHBsDB0dHh+TO9PRWklP9Sq9N7LukPN12b/pMhmUuj4uq5Po+DhGXhzyadAurwQ==
X-Received: by 2002:a05:6a00:2448:b0:528:7acc:363 with SMTP id
 d8-20020a056a00244800b005287acc0363mr1403311pfj.32.1656966391468; 
 Mon, 04 Jul 2022 13:26:31 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 f80-20020a623853000000b005252380a87bsm21274606pfa.59.2022.07.04.13.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jul 2022 13:26:31 -0700 (PDT)
Date: Tue, 5 Jul 2022 05:26:29 +0900
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 07/11] target/openrisc: Add interrupted CPU to log
Message-ID: <YsNM9QPAjzll8Olo@antec>
References: <20220703212823.10067-1-shorne@gmail.com>
 <20220703212823.10067-8-shorne@gmail.com>
 <4bfc20ec-962b-2017-f2ba-26cd65bd3d9f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bfc20ec-962b-2017-f2ba-26cd65bd3d9f@linaro.org>
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
Cc: Openrisc <openrisc@lists.librecores.org>,
 QEMU Development <qemu-devel@nongnu.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Mon, Jul 04, 2022 at 03:34:52PM +0530, Richard Henderson wrote:
> On 7/4/22 02:58, Stafford Horne wrote:
> > When we are tracing it's helpful to know which CPU's are getting
> > interrupted, att that detail to the log line.
> 
> "at".
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Actually it should be "add", thanks I fixed it.

-Stafford
