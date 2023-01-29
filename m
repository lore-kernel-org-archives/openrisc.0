Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB50BC61D97
	for <openrisc@archiver.kernel.org>; Sun, 29 Jan 2023 17:12:43 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 41F6423048;
	Sun, 29 Jan 2023 18:12:42 +0100 (CET)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 by mail.librecores.org (Postfix) with ESMTPS id 22F2B2304B
 for <openrisc@lists.librecores.org>; Sun, 29 Jan 2023 18:12:40 +0100 (CET)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id 1939A32000F9;
 Sun, 29 Jan 2023 12:12:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Sun, 29 Jan 2023 12:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 philipp-wagner.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm3; t=1675012356; x=1675098756; bh=zMHI21EGrF
 nJpP0126Od07mUjrlm2kXW6GY+NdjJtoM=; b=Euguc9khSEQpbq+MGoIr1gJ3H3
 8AraDgonEW8DM7xJQj5gn6up87FVua3BSv/9pRrqdeeIAriJO2QbtxWgurxl7PHD
 3MN3tnE4Hho08f2Lk2lgR+6u3LLob3K9Trv6MtZH6x9biGVofUqVf5Hqp9eZlybg
 2JBtmjy32daohczvHVqC3js4gViIELQEyKHJrRS0RMQ7nJaubwSftCyiPv9RV/l8
 ssiFv3ufCEdvBn5iuJ4MHyQByZ0ghJ9xGGadbGJQKq2ep2esKwXvTtCUcz9gF10c
 NeRZNOYEVCqkgb9uxSt4buBBVi039RC6PruNxcfMnHnaunyw/xud9cC1gkLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1675012356; x=
 1675098756; bh=zMHI21EGrFnJpP0126Od07mUjrlm2kXW6GY+NdjJtoM=; b=j
 A4q9LLazwFH1W4VAnTDuqHOmK7aouLCcZxeeq5ebl/u6Q4kvNCrNdujN2ZAXNV5O
 g9zm/ggdJ0eKq7bmJ0G+3BmM1Bo27TAL5z5dLlC+1EknuC9PBnugQ4GIQgyQyXE5
 oiEsfClq9giSnAoeGVFyf0rzZJ7zgxijWxS9oqbsJydrO6L3cmalkc0fbTV265I/
 PwOc2kYeetFCx1ZVie0eQ5Atm11prts69epsExvy5EfXw37MrA5CYTQtu1CsjWcp
 XHWZ7hQdo59QeUEDwtnqJSP27I9rpe5d8QZBTRmZA1l818/i2zt4FZgWE2ZSFLt8
 Lpl5IU+qMUeakM3SxJHRQ==
X-ME-Sender: <xms:A6nWY2Vvtq3Jzttm9BEdjRaQ5jOBZRHvq0LDc409hwjK3wp4eR-mLw>
 <xme:A6nWYylI1G3aan9N6iycIJrsc1-t1bvTX6P6T8Kpm19hlA9TAooZWb__Xl2K9-yql
 KvX0r2SzDN-FAlPC94>
X-ME-Received: <xmr:A6nWY6bnY4eDGJ5z8LPn3yr68GWsETmOEW7JA0Fs4_p7Ye6XMkOgB7_WhxeI24Jv64pkxVqHv4PjaA8gKgk-d_e-Tpd4yUZcscEo2GTh2Z_bZS88bgQX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeftddguddttdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheprfhh
 ihhlihhpphcuhggrghhnvghruceomhgrihhlsehphhhilhhiphhpqdifrghgnhgvrhdrtg
 homheqnecuggftrfgrthhtvghrnhepheeihfelgeegudeutdejgfdtgeevgefhvddvheei
 jeduveffveetkeegveektdfgnecuffhomhgrihhnpehlihgsrhgvtghorhgvshdrohhrgh
 enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghi
 lhesphhhihhlihhpphdqfigrghhnvghrrdgtohhm
X-ME-Proxy: <xmx:A6nWY9UxlC2GmhAOGeTpBhKzZjkDp_ZNOhCcsJrnf2UBbOLJT8pwrw>
 <xmx:A6nWYwlafm9BbFOQwt1LRGvPw2hgEmBn4D0MWGdrv3KKX4svAiSmLg>
 <xmx:A6nWYycI40wjhn5B1oO6pnhSPloP3NlXmduy5dZCD4emGwPMxElwDA>
 <xmx:BKnWY6UudJCP85HUEI92iQ_WqpHFzNwiE_kC4eSAAIOgoFcQpNR8ug>
Feedback-ID: ie9a94437:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Jan 2023 12:12:34 -0500 (EST)
Message-ID: <24bcadb2-d8fa-1f3f-9fcf-66fe885c4844@philipp-wagner.com>
Date: Sun, 29 Jan 2023 18:12:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: OpenRISC mailing list on lists.librecores.org status?
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>,
 John 'Warthog9' Hawley <warthog9@eaglescrag.net>
References: <Y9QwJIwmRF3wmbGR@antec>
 <22EED3FC-CB23-4245-B490-02D095CD7ABB@hm.edu>
 <72309fb9-f747-4e6a-a8a0-0843a95c9793@app.fastmail.com>
 <1a601f5d-1a3c-59eb-02f4-fa10b5664f09@eaglescrag.net>
 <520C5853-52C8-4305-A866-FEE73695AE67@hm.edu>
 <bf4efc4f-ab46-6379-805f-923051832b11@eaglescrag.net>
 <3e61dac5-15b1-462e-9302-525f7c67eb35@app.fastmail.com>
 <ea758038-6f2b-3931-8fde-c973e20943b6@eaglescrag.net>
 <Y9TV8DRbVmivrTWi@antec>
 <55ad7182-5128-68e4-b685-e4dd743e6d71@eaglescrag.net>
 <Y9W3Bit1LR/KQMsG@antec>
From: Philipp Wagner <mail@philipp-wagner.com>
In-Reply-To: <Y9W3Bit1LR/KQMsG@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Jonas Bonn <jonas@southpole.se>, Arnd Bergmann <arnd@arndb.de>,
 "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
 "postmaster@vger.kernel.org" <postmaster@vger.kernel.org>, "Wallentowitz,
 Stefan" <stefan.wallentowitz@hm.edu>,
 "info@fossi-foundation.org" <info@fossi-foundation.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 29.01.23 01:00, Stafford Horne wrote:
>> If you want to get me a list of e-mail addresses I can insert them in the
>> backend if you want to fully forklift the list over and not have everyone
>> jump through the hoops of subscribing.
>>
> 
> That would be helpful, I don't have the list of addresses though.  Stefan or
> Philipp might be able to provide it.

Stafford and John, I sent you a list of current subscribers off-list.

Thanks!

Philipp
