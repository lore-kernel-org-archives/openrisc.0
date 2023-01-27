Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2DBC61DA4
	for <openrisc@archiver.kernel.org>; Sat, 28 Jan 2023 18:50:55 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 904E4229F4;
	Sat, 28 Jan 2023 19:50:54 +0100 (CET)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by mail.librecores.org (Postfix) with ESMTPS id 6249A215A8
 for <openrisc@lists.librecores.org>; Sat, 28 Jan 2023 19:50:52 +0100 (CET)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 3F6A75C02FD;
 Fri, 27 Jan 2023 16:58:24 -0500 (EST)
Received: from imap51 ([10.202.2.101])
 by compute6.internal (MEProxy); Fri, 27 Jan 2023 16:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm2; t=1674856704; x=1674943104; bh=8PgAtNNHOP
 JeJLJmE7Fb07B6YdM0h8d9oonM4v8TBFg=; b=Rbb6dgLMzzrtjOai4ag6zHGAZU
 OlWqwTliCMzTxnQtbjk9ECNIjTb6AJ6K0yw537qFewlxu4VE+ND7/eghwuNo0aC1
 eGLhFOgJxomfJQD4KO3KTdFkH0/Pau5L8UJlgekjk5WEz5ztSD/fzWz3AKuYvs4V
 LLpzt+oAPZsn2XhY+GMk5WJ9Yo9MT9p/xz7wincULd6ud6ff829dSkHtZAoYpaOp
 ZkmYM6+lmV5AnBVzfBouFKBgLnt+mfc0tKazHda/x/5+jTxbqANPBkPy3aDQEXKc
 luXJexZcA3CA9jic6DKv+zSXBAwhzOQDeImwEsTM0qqr+O1sVKg0RbP7emTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1674856704; x=1674943104; bh=8PgAtNNHOPJeJLJmE7Fb07B6YdM0
 h8d9oonM4v8TBFg=; b=akch8l7Trk5kNW15JyzIZs//KV5ZsI8/quUwqA6rffp4
 f73RyMeXo34mtHTmG9WOUgwOPZrXN+v4Lz99GIJCv3Ehc0hij5wuFHhGlhsEUv0K
 2sTOUOFSASeNBDwwPezT/Q13kn/BHc1HXHhvgGh4zXPWJ8CZo95lQNU/2m/Fw7dD
 loKfeu8tnQHbhY5D4cxk8L5+7nBIbyaJHYJjSoj3iLIMGI+45XJ+qmj545wyXgRb
 ZsdPF8oHRGlvtwkbPpr+CIE5CfZ3s79Z0EgNcP2uzeMJVhUuOV/iePc7anNx01tU
 Vt3K3fWWfEYW7BylA1oKNklUxMoWBHNA8Yr2RO4bYA==
X-ME-Sender: <xms:_0jUY5Xr1prVhd5qmG0mf90qFtS6xSDMnTY2O1qZQmXTo_R22eaa-A>
 <xme:_0jUY5lIfLBeF3Ez-9GrRKkus9RrHnegJv_9OQQhFs2vsQV6AXZ3fYfMrgDspf4xD
 QeppcMapVXkmOLerIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddviedgudehhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
 rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
 htthgvrhhnpeelffelvddulefhgfehleffledvffeujeduheefgfffhfdviefgueejjedu
 tedvieenucffohhmrghinheplhhisghrvggtohhrvghsrdhorhhgnecuvehluhhsthgvrh
 fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdgu
 vg
X-ME-Proxy: <xmx:_0jUY1a3kGBxyT-nju9eywntS_iDTJ2bKGUceJAii9P4R0-bNthjgA>
 <xmx:_0jUY8W_gP5l1_KZqAFFmI_2VTlMuJBv74AL4chkjIf23I-_rkJalA>
 <xmx:_0jUYzlp_ORVpK4HdeUAneZjxJD52WE_ukfKAB17JZYSATtmSmqIbQ>
 <xmx:AEnUYxZgWkmEUV-dX6lhw-EHovY37lbXZQ5WqM38yrcuWS6QoAgkZQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id A7CEDB60086; Fri, 27 Jan 2023 16:58:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <3e61dac5-15b1-462e-9302-525f7c67eb35@app.fastmail.com>
In-Reply-To: <bf4efc4f-ab46-6379-805f-923051832b11@eaglescrag.net>
References: <6aa3b785-5ea2-41d4-ad16-56c5b179cbe8@app.fastmail.com>
 <Y9QwJIwmRF3wmbGR@antec> <22EED3FC-CB23-4245-B490-02D095CD7ABB@hm.edu>
 <72309fb9-f747-4e6a-a8a0-0843a95c9793@app.fastmail.com>
 <1a601f5d-1a3c-59eb-02f4-fa10b5664f09@eaglescrag.net>
 <520C5853-52C8-4305-A866-FEE73695AE67@hm.edu>
 <bf4efc4f-ab46-6379-805f-923051832b11@eaglescrag.net>
Date: Fri, 27 Jan 2023 22:58:04 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
 "Wallentowitz, Stefan" <stefan.wallentowitz@hm.edu>
Subject: Re: OpenRISC mailing list on lists.librecores.org status?
Content-Type: text/plain
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.29
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
Cc: Jonas Bonn <jonas@southpole.se>,
 "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
 Stafford Horne <shorne@gmail.com>,
 "postmaster@vger.kernel.org" <postmaster@vger.kernel.org>,
 "mail@philipp-wagner.com" <mail@philipp-wagner.com>,
 "info@fossi-foundation.org" <info@fossi-foundation.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Fri, Jan 27, 2023, at 22:52, John 'Warthog9' Hawley wrote:
> Looks like the obvious address should be linux-riscv@vger (just given 
> the general naming for everything else).
>
> Anyone opposed before I set this up?

This is openrisc, not riscv -- it's a different architecture.

The name should probably be linux-openrisc@vger.kernel.org

     Arnd
