Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61841C433F5
	for <openrisc@archiver.kernel.org>; Thu,  6 Oct 2022 16:18:58 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id E4B1324929;
	Thu,  6 Oct 2022 18:18:56 +0200 (CEST)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mail.librecores.org (Postfix) with ESMTPS id 629D624BB6
 for <openrisc@lists.librecores.org>; Sat,  1 Oct 2022 19:53:38 +0200 (CEST)
Received: from ymorin.is-a-geek.org (unknown
 [IPv6:2a01:cb19:8b51:cb00:9961:1217:61e8:73cc])
 (Authenticated sender: yann.morin.1998@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 8EE51780313;
 Sat,  1 Oct 2022 19:53:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1664646818;
 bh=XVqQEszfsaqpORn/XyfgPty0a3ejN+XQ6ormQgbYw08=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XZwpmaYwSmsEUKI+YcW22Sg7KolY8rdVHBaxwjQE73/MNi3/zkVqGM17GVlnZmyeY
 TCsIo9iNgkdaxdO2lgUXeZybtpPMVvDcah/y5Gqc4+3jHZz3jADw/SMqc5j9++2TVF
 e/SZCPrO00hQ9gp1jgw1QPgceh0XcZWgs0URJKtSwiX0pdTaq//qiMqVdIaVsmdV4o
 dO5TTi8QO2VqA736potj6JNiPjlda+rud5OEtOOVkjtFe04AhCU2FbL63anCfxb4j2
 RiHdQMqBv4HjNpn9BuQ+TfhXkjN8+ltuCR7nnClq+/YIHkmSQ4EU8TNkTEgmkbtT5B
 5MOJg3Xcnhjnw==
Received: by ymorin.is-a-geek.org (sSMTP sendmail emulation);
 Sat, 01 Oct 2022 19:53:32 +0200
Date: Sat, 1 Oct 2022 19:53:32 +0200
From: "Yann E. MORIN" <yann.morin.1998@free.fr>
To: Stafford Horne <shorne@gmail.com>
Subject: Re: [Buildroot] [PATCH] or1k: Only define TARGET_HAVE_TLS when
 HAVE_AS_TLS
Message-ID: <20221001175332.GN30794@scaer>
References: <20220929145740.4846-1-shorne@gmail.com>
 <YzgmG9Ihqt6xC7CA@oscomms1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzgmG9Ihqt6xC7CA@oscomms1>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Mailman-Approved-At: Thu, 06 Oct 2022 18:18:55 +0200
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
Cc: openrisc@lists.librecores.org, gcc-patches@gcc.gnu.org,
 Yann Morin <yann.morin@orange.com>, buildroot@buildroot.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Stafford, All,

On 2022-10-01 11:35 +0000, Stafford Horne spake thusly:
> On Thu, Sep 29, 2022 at 03:57:40PM +0100, Stafford Horne wrote:
> > This was found when testing buildroot with linuxthreads enabled.  In
> > this case, the build passes --disable-tls to the toolchain during
> > configuration.  After building the OpenRISC toolchain it was still
> > generating TLS code sequences and causing linker failures such as:
> > 
> >  ..../or1k-buildroot-linux-uclibc-gcc -o gpsd-3.24/gpsctl .... -lusb-1.0 -lm -lrt -lnsl
> >  ..../ld: ..../sysroot/usr/lib/libusb-1.0.so: undefined reference to `__tls_get_addr'
> > 
> > This patch fixes this by disabling tls for the OpenRISC target when requested
> > via --disable-tls.
> > 
> > Tested-by: Yann E. MORIN <yann.morin@orange.com>
> > 
> > gcc/ChangeLog:
> > 
> > 	* config/or1k/or1k.cc (TARGET_HAVE_TLS): Only define if
> > 	HAVE_AS_TLS is defined.
> 
> I have pushed this upstream now.  Adding buildroot patches should be easy to do
> now.

That's great, thanks for fixing this! :-)

I'll poke my work alter-ego on Monday to look at providing the backports
for Buildroot.

Regards,
Yann E. MORIN.

-- 
.-----------------.--------------------.------------------.--------------------.
|  Yann E. MORIN  | Real-Time Embedded | /"\ ASCII RIBBON | Erics' conspiracy: |
| +33 662 376 056 | Software  Designer | \ / CAMPAIGN     |  ___               |
| +33 561 099 427 `------------.-------:  X  AGAINST      |  \e/  There is no  |
| http://ymorin.is-a-geek.org/ | _/*\_ | / \ HTML MAIL    |   v   conspiracy.  |
'------------------------------^-------^------------------^--------------------'
