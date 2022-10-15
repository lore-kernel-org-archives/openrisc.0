Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D5FC4332F
	for <openrisc@archiver.kernel.org>; Sat, 15 Oct 2022 16:26:01 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 03F5324B79;
	Sat, 15 Oct 2022 18:26:00 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by mail.librecores.org (Postfix) with ESMTPS id 9C97D24BAC
 for <openrisc@lists.librecores.org>; Sat, 15 Oct 2022 18:25:59 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id a10so11924966wrm.12
 for <openrisc@lists.librecores.org>; Sat, 15 Oct 2022 09:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dNKwwUuvrgZ46xwoGGuVcYvN6TXI2tCIVd9WU2CVGOQ=;
 b=JluM3QD05PT6gVppLGJyJaOsBmS9w+f9HdZ/rv1gXA30MjMECsYItnh96r7BPeN6Vc
 Q/lON8XcAThALGZmSrjIRUYbDxj6YSCnMpXCR5IBuLFyEMxRmfOHoFmo/eK7zCthY0Pe
 71lrRasStpjrlwiWcvqsw8OV8TzK2XyRGGOBoUQxTBWRP0lkT8hBKaYhK3jDcYxUEdJF
 UTGvq4ubkjR0/6jQ0QfhhtRk3uM0gkSS7vk/NnC+ZsYmHNb/VQsY29DfOX9Tm9pr0oSf
 2tIPpp0UhZn8Hrsy9n3Ejt5mrOZcI+xD/d9EAuOKBSYdzn6tkqkl+q3WuBE9WQ+J9TYs
 XZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dNKwwUuvrgZ46xwoGGuVcYvN6TXI2tCIVd9WU2CVGOQ=;
 b=dpkVfEYiQwaAMV9HVFiAhG0JaUDiiQcLbd1i1tRphLFgRCu9deu/XkE7flE/bhcloz
 41kTXVEc9kT3E3sFjjnFlnzAD65ocS4gu0k2ywzWhw8AYZ5pIP+BTbXOpldQua29n+7h
 bPRXNK3Yx2UjvLn0aueLRLa2UU3oFNdHKdXMATVpay/u7hrxD/ODs5cXqESTfzWanEHV
 LTL6f0Y/ePvkkQcJeIeKN6uD3EVTK4l7p3vmMY2tY2qIr8q/3tIgG/lB0d6PhQvN5/7Z
 BRR+fMIKn5hDMedzIr+kCrC+bunqZC8BMrZAxac70Ve31DlaZItEmA5SNMOqsY/Vtp06
 +LUA==
X-Gm-Message-State: ACrzQf0vDmZIlp0DvpoDR6qhFY7VUdQUckUAKoMzt5qCLXgpbkbv9Z3H
 IeXFPWlbXuMH2efPzd1NqPU=
X-Google-Smtp-Source: AMsMyM71VpkOhoy31kwvj7hvjMDnCb6bByCRJVgIqksFM6+DvDOk642WbK3ppITSUWEeZzLHarGR3g==
X-Received: by 2002:a05:6000:178e:b0:22e:6d9f:1592 with SMTP id
 e14-20020a056000178e00b0022e6d9f1592mr1917812wrg.6.1665851158988; 
 Sat, 15 Oct 2022 09:25:58 -0700 (PDT)
Received: from localhost ([2a03:b0c0:1:d0::dee:c001])
 by smtp.gmail.com with ESMTPSA id
 123-20020a1c1981000000b003c6c4639ac6sm5204196wmz.34.2022.10.15.09.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Oct 2022 09:25:52 -0700 (PDT)
Date: Sat, 15 Oct 2022 16:25:51 +0000
From: Stafford Horne <shorne@gmail.com>
To: Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for
 openrisc
Message-ID: <Y0rfD8y9m54Zrc4C@oscomms1>
References: <20221013214637.30893-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013214637.30893-1-palmer@rivosinc.com>
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
Cc: jonas@southpole.se, Conor Dooley <conor.dooley@microchip.com>,
 openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Hi Palmer,

On Thu, Oct 13, 2022 at 02:46:37PM -0700, Palmer Dabbelt wrote:
> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.

Thanks, I will queue this for 6.1 right away.  I saw you originally had this as
a mega patch now split it up.  Either way is good with me, ghouth taking this
on.

> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 796ba37dd4ff..9a9ca93b63fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15234,7 +15234,7 @@ M:	Stafford Horne <shorne@gmail.com>
>  L:	openrisc@lists.librecores.org
>  S:	Maintained
>  W:	http://openrisc.io

FWIW: Our website should be https:// too.  I will sumbit a patch for that as
well.

Stafford

> -T:	git git://github.com/openrisc/linux.git
> +T:	git https://github.com/openrisc/linux.git
>  F:	Documentation/devicetree/bindings/openrisc/
>  F:	Documentation/openrisc/
>  F:	arch/openrisc/
> -- 
> 2.38.0
> 
