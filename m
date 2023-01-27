Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969C9C27C76
	for <openrisc@archiver.kernel.org>; Sat, 28 Jan 2023 18:50:55 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 69875229DC;
	Sat, 28 Jan 2023 19:50:54 +0100 (CET)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by mail.librecores.org (Postfix) with ESMTPS id 2CC292159B
 for <openrisc@lists.librecores.org>; Sat, 28 Jan 2023 19:50:52 +0100 (CET)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 237595C00E2;
 Fri, 27 Jan 2023 15:59:36 -0500 (EST)
Received: from imap51 ([10.202.2.101])
 by compute6.internal (MEProxy); Fri, 27 Jan 2023 15:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1674853176; x=
 1674939576; bh=Sv0w51yX23C2mjl3PwTwssyzSbBniS6TiSWNe8/i7QI=; b=T
 TKJHOJ8UXGHmURk3J/b9xP3/C+oSN9+AKYmIsTnOuO2IgJ4/6O7zhCptWZAEXw9o
 bqz1vmyHTsbME20uhLNnRyrdfba3inzWlwNORZ88B0j1UOHzF1l76WB/NhJ7xx61
 inXz7vOvCog4o+8RwP7tZyVq4BJThGD145p9LkYpkCxkk0JaL0l7tZNF4EsiVwzc
 fWoGumDn6e9Yq9aw7YTNYjrOvcapa7i3t+PtmSNCSa2WUFOTIbHFUn6ybEv6H0PW
 v2ncjuMAFc8di9AmXuitGQhwznI7dx0FuPalCz91EX9bMyOMit6sTuTiuJCrqOaX
 CxNJonIfGFe30RPkbnzgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674853176; x=
 1674939576; bh=Sv0w51yX23C2mjl3PwTwssyzSbBniS6TiSWNe8/i7QI=; b=k
 6TmmeJxh5Gfb5HfTH8dYnRtReUC6w9Mk/hwgwrrWraQBAcgrwjCF+XmuEmjImqP7
 SX++NfQJJMLooLN4Ll4H7EkbMhJ3TNL4w+GNxWwpIYi4ShhZ1FvUOYdhSkNP/9ae
 tCTBguOtLnMZc14UnNFHYtz6uY1jTOeTz7FAv2DnLEDaCIvSXt+7qqig+/X+D3Bi
 Ecb10uhhC7mzxX6cAqvYE9pvxcCCvQb7NLeldVQ28E1vyFcsjcKMjp86lSfvCsiH
 oTaz+46EV6snWvmrzji/4XBX9SHXNOcjI28pd6XJedaOB7ae6h8K8Cm7bWiGsUuJ
 1ieGp4uLTnMQyCbEqj0og==
X-ME-Sender: <xms:NzvUY1yoNE6CiPtUEw3IB1yFW-vI1xKhqPJZL5l5DxnOndrxpvJsBA>
 <xme:NzvUY1RzdODO_zg_dx_L73DtfsvYKCqCLzTprM2oEPggDZpAAV1qJSZoS_UZ-vXP5
 aCJ-3pAq861UBW8zFc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddviedgudeggecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
 tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
 grthhtvghrnhepgedvvdffieeugeeuveeivdelvdfghfeuvdeuvdejveelhfeigfekueel
 teeltdfhnecuffhomhgrihhnpehlihgsrhgvtghorhgvshdrohhrghdpfhhoshhsihdqfh
 houhhnuggrthhiohhnrdhorhhgpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhi
 iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:NzvUY_XqAlL2ErN86XGKbQGmQchjPofcMbwBvrnx2eFRWLc9ETTWAQ>
 <xmx:NzvUY3iUFd9evtRuNVvNOeJ2pkIq-gVJ_oX66ZRDYsRATecuvhZl4A>
 <xmx:NzvUY3DLd4qFGX0yJUvvz7Pvlb1qxOsqWYTp7kc4esh_kbPYxbII9Q>
 <xmx:ODvUYy5cmu8W19iAcqKYG-YBlk13_KDXNmkeYrumufO2WjjmRcVqCQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 535A1B60086; Fri, 27 Jan 2023 15:59:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <72309fb9-f747-4e6a-a8a0-0843a95c9793@app.fastmail.com>
In-Reply-To: <22EED3FC-CB23-4245-B490-02D095CD7ABB@hm.edu>
References: <6aa3b785-5ea2-41d4-ad16-56c5b179cbe8@app.fastmail.com>
 <Y9QwJIwmRF3wmbGR@antec> <22EED3FC-CB23-4245-B490-02D095CD7ABB@hm.edu>
Date: Fri, 27 Jan 2023 21:59:00 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Wallentowitz, Stefan" <stefan.wallentowitz@hm.edu>,
 "Stafford Horne" <shorne@gmail.com>
Subject: Re: OpenRISC mailing list on lists.librecores.org status?
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Jonas Bonn <jonas@southpole.se>, postmaster@vger.kernel.org,
 "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
 "mail@philipp-wagner.com" <mail@philipp-wagner.com>,
 "info@fossi-foundation.org" <info@fossi-foundation.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Fri, Jan 27, 2023, at 21:17, Wallentowitz, Stefan wrote:
>> Am 27.01.2023 um 21:12 schrieb Stafford Horne <shorne@gmail.com>:
>> =EF=BB=BFOn Fri, Jan 27, 2023 at 08:51:13AM +0100, Arnd Bergmann wrot=
e:
>>> I got a bounce from a discussion[1] of a kernel patch, with status
>>> "lists.librecores.org[88.198.125.70]:25: No route to host". Is that
>>> a temporary problem, or does this list have to move after the
>>> librecores.org domain now redirects to fossi-foundation.org [2]?
>>=20
>> I didnt't realize this, I have moved to London in the last few months=
 and
>> haven't been doing a lot of OpenRISC work while I get settled so this=
 slipped
>> past my radar.
>>=20
>> CCing Stefan and Philipp who managed the mailing list.  It seems the =
last mail I
>> received for the mailing list was 8 days ago.
>>=20
>> Philipp is there a new mailing list server/domain now?  What has happ=
ened to the
>> archive of openrisc mailing list?
>
> Sorry, we have outages at the moment and have started to mitigate by=20
> looking for alternatives.
>
> Arnd, do you have a suggestion for a mailman service for an=20
> architecture=E2=80=99s kernel mailing list? Sorry for the inconvenienc=
e, I will=20
> look into keeping the service stable. Is Google groups an acceptable=20
> target for this mailing list?

I would recommend hosting on vger.kernel.org, which has a lot of other
architectures already.

Adding postmaster@vger.kernel.org to Cc, they can probably help you.

     Arnd
