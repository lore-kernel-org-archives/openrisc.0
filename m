Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804EAC433F5
	for <openrisc@archiver.kernel.org>; Sat, 28 May 2022 12:37:49 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 3445C20DEE;
	Sat, 28 May 2022 14:37:48 +0200 (CEST)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mail.librecores.org (Postfix) with ESMTPS id 8BEB124810
 for <openrisc@lists.librecores.org>; Sat, 28 May 2022 11:50:26 +0200 (CEST)
Received: from nicolasthinkpad.home (unknown
 [IPv6:2a01:e0a:91b:e980:f165:10f:69f1:8c00])
 by smtp6-g21.free.fr (Postfix) with ESMTPS id 9EE46780346;
 Sat, 28 May 2022 11:50:23 +0200 (CEST)
Received: from nicolas by nicolasthinkpad.home with local (Exim 4.94.2)
 (envelope-from <nicolas.boulenguez@free.fr>)
 id 1nut66-0000w5-Bt; Sat, 28 May 2022 11:51:02 +0200
Date: Sat, 28 May 2022 11:51:02 +0200
From: Nicolas Boulenguez <nicolas@debian.org>
To: Stafford Horne <shorne@gmail.com>
Subject: Re: Link failure with Debian toolchain
Message-ID: <YpHwhlF0Dhf58da7@pegase>
References: <CACPK8XcBRtd+RFhXaR-B3wbeM1gsmCW3hgRp_uwS0-g-oCWniw@mail.gmail.com>
 <YpFSzpl5fdq7O3pk@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpFSzpl5fdq7O3pk@antec>
X-Mailman-Approved-At: Sat, 28 May 2022 14:37:46 +0200
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
Cc: openrisc@lists.librecores.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

> This seems to mean that the builtins for 64-bit ops are not being found. So
> something is wrong with libgcc symbols.  Maybe something strange with the
> multilib args used when building the toolchain.
> I'll have a look at it. It would be nice if I can used this toolchain for my CI.

In case it helps, the options passed to ./configure are visible here:
https://salsa.debian.org/debian/gcc-or1k-elf/-/blob/master/debian/rules#L45
