Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9A0C43334
	for <openrisc@archiver.kernel.org>; Fri, 10 Jun 2022 01:39:43 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id CEEA7248F8;
	Fri, 10 Jun 2022 03:39:42 +0200 (CEST)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 by mail.librecores.org (Postfix) with ESMTPS id 17A21248F8
 for <openrisc@lists.librecores.org>; Fri, 10 Jun 2022 03:39:41 +0200 (CEST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 2C6C15C0191;
 Thu,  9 Jun 2022 21:39:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Thu, 09 Jun 2022 21:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1654825179; x=
 1654911579; bh=LQFyetndjzCC2dC7UAxlU8A9JcKy7UkaIb86rV1EdS8=; b=t
 CZ3r/UqOIIP8FRmMe06cT7L1kgqShmOqG9yvgucMUcYiRGaB2L3HlM0Yq2uMd6VJ
 5mswBC5LCRyv8Os77GOhGKFE5jbHAA0var1F5MvqmmRffL/zyfGffaV5ISouEsbl
 EkpJX9fK3cqbB6KlkvPrl097PXrChNc6ShOIDFXVC1yxHm1xGU1Lge4ig1D/03LV
 FKHpQ5538V2C04j93MxNmZjtma/9gU9qcnfBBmHS1ofECTexc9T8NSE9XQ2QSJlK
 EmGUaX1IHsO+o4us/AQiifOkX86BGq8S0HOw9N76UqB0Vk/oe1PVGptwR/1STaXq
 ErJTX6eKqLGc6uCAfvSZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1654825179; x=
 1654911579; bh=LQFyetndjzCC2dC7UAxlU8A9JcKy7UkaIb86rV1EdS8=; b=l
 /7R3c90Z7tAgDHv2zyuLALt65ZglgALAnP+66F65x/WmsO0/+8muozioadKSiBvL
 EwDDDE/hAZqEei4WS1UE9+DBpVXRo480BJK4UTtxSDoBmZSmh9vlF8iVtf7XTr50
 XDPaZZyDNdvHp1zVIE3AkGgdTBhsc+aLa8H+8hr5nlrUJwngSXt+UF3pCACGTWpr
 mrfuSGZ0vJhi7X56x9+WdCH6/9xEKKICSpp9TzZaFsx9kvShnssV/MeypApwJZLS
 KW/LDXBtMMeqBIHVVirc5a+ghe15p0+WDnrtXu/onHXeeIoBBU9LZJjF58lUr/k7
 TG2PEbaQw28wN2yo/r5lw==
X-ME-Sender: <xms:2qCiYpr58FJWP4UWvm6dHOFaWq54NvwUUIEO8hIHpwSqsr-86SP8Hg>
 <xme:2qCiYrq-yL6PAugcRWzxsm4uILMgfDT2n3DUxWjmusQjNYa4V3g5eWNoY6bemw-2c
 s9ytGO2LkztR4gnXQ>
X-ME-Received: <xmr:2qCiYmOprK1mW0tQSzzS9Buxc7IccT0y6CeC3xzQmCr88_ZbONiv5EsiQtTbKIccsbbJ2pPLu6FBxHOBu1zJiWkjnOAmnk7r4yuHOscs44r8VzlB3H0otFg8-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddutddggeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
 uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
 ggtffrrghtthgvrhhnpeeffeduhfdthfevkeehgeekveekkedutdeiffetveehteekueev
 vdfhudffvdettdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhlihhnuhigqdhsuh
 hngihirdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
 rhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:26CiYk592lgOihvdtj4SFalZLbwDjWer3hKuoF4oiGSAnIqAuWta9A>
 <xmx:26CiYo4yx4UH00oBGX7dwmnMAP8NKWq_5M4hH1pIxe2MckEhVLCILg>
 <xmx:26CiYsi2Ci0p4jPaGE468sBPhauWMGu95wnIsaveZiEF6azSTyZkwA>
 <xmx:26CiYmSkmtFGjtalAgJ8hiIsfa1PHl13lbxib6s40vOsUdJTP0A_gQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jun 2022 21:39:38 -0400 (EDT)
Subject: Re: [PATCH] or1k: Add support for a little-endian target variant
To: Stafford Horne <shorne@gmail.com>
References: <20220609060133.26409-1-samuel@sholland.org>
 <YqHXrxh5BRTk48o7@antec>
From: Samuel Holland <samuel@sholland.org>
Message-ID: <780e40a3-17eb-c1c2-6572-1fd41757e963@sholland.org>
Date: Thu, 9 Jun 2022 20:39:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YqHXrxh5BRTk48o7@antec>
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
Cc: openrisc@lists.librecores.org, binutils@sourceware.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Hi Stafford,

Thanks for the review.

On 6/9/22 6:21 AM, Stafford Horne wrote:
> On Thu, Jun 09, 2022 at 01:01:33AM -0500, Samuel Holland wrote:
>> While not officially sanctioned by the architecture spec, little-endian
>> or1k processors do exist in the wild, for example the Allwinner AR100.
>> Let's add native support for this, instead of hacks like using objcopy
>> to byteswap ELF file contents.
> 
> Hello,
> 
> In general I have no objections to this.  If there are processors that
> are little endian it makes sense to support it.  Do you have any details
> of how people built for these before? I am curious.

We post-process the binary with "objcopy --reverse-bytes 4".

https://github.com/crust-firmware/crust/blob/master/Makefile#L193
https://github.com/intelligent-agent/klipper/blob/master/src/ar100/Makefile#L39
https://github.com/nfeske/genode-allwinner/blob/scp/src/scp/Makefile#L22

The processor has both a word-invariant mode (the default), and a byte-invariant
mode:

https://linux-sunxi.org/AR100#Byte-invariant_Ranges

With a big-endian toolchain, in the word-invariant mode, all GCC optimizations
work fine, but sharing data with other software is painful. Sub-32-bit memory
accesses are reversed within each group of 4 bytes, which affects strings and
struct layouts.

In the byte-invariant mode, sharing strings and structs causes no problems, but
some GCC optimizations like -fstore-merging are broken.

>> diff --git a/gas/config/tc-or1k.c b/gas/config/tc-or1k.c
>> index ae4e3452f48..9dc5a46f2e2 100644
>> --- a/gas/config/tc-or1k.c
>> +++ b/gas/config/tc-or1k.c
>> @@ -58,8 +58,16 @@ const char FLT_CHARS[]            = "dD";
>>  #define OR1K_SHORTOPTS "m:"
>>  const char * md_shortopts = OR1K_SHORTOPTS;
>>  
>> +enum
>> +{
>> +  OPTION_LITTLE_ENDIAN = OPTION_MD_BASE,
>> +  OPTION_BIG_ENDIAN
>> +};
>> +
>>  struct option md_longopts[] =
>>  {
>> +  {"EB", no_argument, NULL, OPTION_BIG_ENDIAN},
>> +  {"EL", no_argument, NULL, OPTION_LITTLE_ENDIAN},
>>    {NULL, no_argument, NULL, 0}
>>  };
>>  size_t md_longopts_size = sizeof (md_longopts);
>> @@ -67,14 +75,30 @@ size_t md_longopts_size = sizeof (md_longopts);
>>  unsigned long or1k_machine = 0; /* default */
>>  
>>  int
>> -md_parse_option (int c ATTRIBUTE_UNUSED, const char * arg ATTRIBUTE_UNUSED)
>> +md_parse_option (int c, const char * arg ATTRIBUTE_UNUSED)
>>  {
>> -  return 0;
>> +  switch (c)
>> +    {
>> +    case OPTION_BIG_ENDIAN:
>> +      target_big_endian = 1;
>> +      break;
>> +    case OPTION_LITTLE_ENDIAN:
>> +      target_big_endian = 0;
>> +      break;
>> +    default:
>> +      return 0;
>> +    }
>> +
>> +  return 1;
>>  }
>>  
>>  void
>> -md_show_usage (FILE * stream ATTRIBUTE_UNUSED)
>> +md_show_usage (FILE * stream)
>>  {
>> +  fprintf (stream, _(" OR1K-specific assembler options:\n"));
>> +  fprintf (stream, _("\
>> +  --EB			generate code for a big endian machine\n\
>> +  --EL			generate code for a little endian machine\n"));
>>  }
> 
> Aboce you mention -EB, -EL, here is is --EB, --EL.

They are long options. I will fix the changelog.

> Does this setup big endian as the default?  We should specify that in the
> options.  i.e. "generate code for a big endian machine, this is the default."
> 
> But I am not sure how that defaulting works now.  I will try to build this
> and understand better.

The default depends on the target. It comes from gas/configure.tgt.

Regards,
Samuel
