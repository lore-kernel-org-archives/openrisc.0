Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727ECC433EF
	for <openrisc@archiver.kernel.org>; Fri, 10 Jun 2022 02:07:33 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 13B69248FA;
	Fri, 10 Jun 2022 04:07:32 +0200 (CEST)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by mail.librecores.org (Postfix) with ESMTPS id 2A5C8248F3
 for <openrisc@lists.librecores.org>; Fri, 10 Jun 2022 04:07:30 +0200 (CEST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id B2E6B5C0064;
 Thu,  9 Jun 2022 22:07:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Thu, 09 Jun 2022 22:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1654826846; x=
 1654913246; bh=5uTANf/WYMEcobzT20+oLiSBs4TT47fsgg5u5hi00GQ=; b=e
 h7QJjk+xOiPOR7X9DUZ0qhzlrWGBhU71enL0C1YMQdit3Em/gpyrfc+9S8P2pYm4
 bgrk5BRuR/JmMLOf61t+X4cHpyR1QsKmFLi03VlMv1PGu8aQQJJ4xKXSuez4cV01
 a/SLS/MpvGq7iLLsBNMnvGCurq/uLnwgnme5x9wFGwPb2M2fGmTdxvXPDXuW/c3O
 Adf0BaiZWMzbqK7HOnJG+f28w3d0M+z66qiVhzMryptbUZs2xGbUJQ6voiVY/yha
 UhI8R6xM/9ykZJLrepJ7l7aH1yCXgSWa6C3xeE+y11GFFDdOwEyCTJSDdhbM5soI
 r9p+ornHeeC2E7/6ytcxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1654826846; x=
 1654913246; bh=5uTANf/WYMEcobzT20+oLiSBs4TT47fsgg5u5hi00GQ=; b=D
 ZrGe9u4b4Lh/8efX5RJF5lfZ6e0FfqAYZq+S9erh4GnWg1/+CBHt0Ge1O0S70MLG
 35KzWbfBiaItA8CM6rdkDwTY8Ya6uxlg7/R00LSFMRct57DC5jpM7V0UGhSTq6rF
 f/nymXxORKsPptpgHVEELL9NQTrwgSYQE/5BnN4UeBh1eWOGCYkhRkJjxFAbaW1v
 /s7KnaWOR8GLFI+I++xT3j8tEXN1NiwB4Pj8hAPV9OPHQ/YfaNwjAzEfa1fMWW4L
 zK88xuSYLcqx3zaO0DN5CSSy4ANM9iJoZGtQQmVd0+1vSVZwTSasKPvOwoDOsqLm
 AeJuAjYh2ifsZzVJjBrMA==
X-ME-Sender: <xms:XqeiYlnf9b5HjrskL8oX4VBvx7yzYlyJlnmxXiDRBQHUaGx7TS6EpA>
 <xme:XqeiYg0rXJHXB8VlqMOyxI399Vxdz_rBznUsIIiQY23ST5eXCj_tl-U6eye4s5pt-
 UDCx5oj0S3Gg8_kFw>
X-ME-Received: <xmr:XqeiYrpaSKBx1IhkmtpxmepDSWOXye6ol5EC6Ezk4yb5jNrvYDfkljLRf-NrXe3aeZ8OMGvMgghm14jJpoMrVB6vg9fEEqCp6Td66E3bSoJ5OdTHG-e__06ZKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddutddgheegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
 uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
 ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
 tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:XqeiYlkprXSKO-odaijYb8vXFS_TDQ523ypJDDTkQQz2_-4whNhryg>
 <xmx:XqeiYj1VMMn4t8bZ39UhBPD58W5y1QieacGlMEJuRtQSDh5D69ly1Q>
 <xmx:XqeiYku1SxEKGxfaX3OcNS2IuhlZBiT-V3iuKqxfE2XqYNc3ZT_RuA>
 <xmx:XqeiYs-mNPNwdwlISSIqxPZJQkvUZyvswTqRkaTMVTEGxY-4g0Rlng>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jun 2022 22:07:26 -0400 (EDT)
Subject: Re: [PATCH] or1k: Add support for a little-endian target variant
To: Stafford Horne <shorne@gmail.com>
References: <20220609060357.26436-1-samuel@sholland.org>
 <YqHZnGBh6ty6MiJp@antec>
From: Samuel Holland <samuel@sholland.org>
Message-ID: <424f88ac-49de-0804-f2b6-4b788ae8ef80@sholland.org>
Date: Thu, 9 Jun 2022 21:07:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YqHZnGBh6ty6MiJp@antec>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: openrisc@lists.librecores.org, gcc-patches@gcc.gnu.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Hi Stafford,

On 6/9/22 6:29 AM, Stafford Horne wrote:
>> diff --git a/gcc/config.gcc b/gcc/config.gcc
>> index c5064dd37666..0c3a09dfe810 100644
>> --- a/gcc/config.gcc
>> +++ b/gcc/config.gcc
>> @@ -2866,6 +2866,11 @@ or1k*-*-*)
>>  	done
>>  	TM_MULTILIB_CONFIG=`echo $TM_MULTILIB_CONFIG | sed 's/^,//'`
>>  
>> +	case ${target} in
>> +	or1k*le*-*)
> 
> Should this be just or1kle*-*?

I wasn't sure what the order of "le" and "nd" would be if both were present.

>> +		tm_defines="${tm_defines} TARGET_LITTLE_ENDIAN_DEFAULT=1"
>> +		;;
>> +	esac
>>  	case ${target} in
>>  	or1k*-*-linux*)
>>  		tm_file="${tm_file} gnu-user.h linux.h glibc-stdint.h"
> 
> 
>> diff --git a/gcc/config/or1k/or1k.opt b/gcc/config/or1k/or1k.opt
>> index 8a66832a99b1..497f259faae9 100644
>> --- a/gcc/config/or1k/or1k.opt
>> +++ b/gcc/config/or1k/or1k.opt
>> @@ -24,6 +24,14 @@
>>  HeaderInclude
>>  config/or1k/or1k-opts.h
>>  
>> +mbig-endian
>> +Target Report RejectNegative Mask(BIG_ENDIAN)
>> +Use big-endian byte order.
>> +
>> +mlittle-endian
>> +Target Report RejectNegative InverseMask(BIG_ENDIAN, LITTLE_ENDIAN)
>> +Use little-endian byte order.
>> +
> 
> We should explain what is the default int he doc's.
> 
> Can you also document in: gcc/doc/invoke.texi

Yes, I will do that for v2.

Regards,
Samuel
