Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD0CC433EF
	for <openrisc@archiver.kernel.org>; Fri, 27 May 2022 22:38:13 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 5312D20DEE;
	Sat, 28 May 2022 00:38:12 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mail.librecores.org (Postfix) with ESMTPS id B9EC420C7C
 for <openrisc@lists.librecores.org>; Sat, 28 May 2022 00:38:10 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id a13so5332610plh.6
 for <openrisc@lists.librecores.org>; Fri, 27 May 2022 15:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=SJDDEewHkQoewKcvq51r4wF1VexW7nDeHXQxPJ7bGqI=;
 b=iLfgchsUyzGSdkmg/aJcF0EcdMLN1sthFXbcyHhJgrV1EnjVpCXZxM4pSM/S6adP31
 g0SAh2haE0QKiEQI5FI9wFSCO47B0NVyZ301lYhueDBGjtqEwaTyPosHUEJyVsdQkN96
 PmW8FBVfHM+2LmmC/8Rp1epbcUuaLLIvtlTA2/B7qWZUVZR+ld9nKSy+WV70jDiotqto
 JDRfSxwCbctE/qWg9bc7dCTc/9OkVzWSft/rIWu7xAFNLhJzAC3svGlFXC7JXi+69dwF
 D8NXEStBn3kwQQAucVVVdFQUfUdemxwlDOWJL3jJe/w15EW6g3vWLThOftDZ5bRTT5PZ
 u3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SJDDEewHkQoewKcvq51r4wF1VexW7nDeHXQxPJ7bGqI=;
 b=SSkywO7IKgEJTbAZ0zvLUtmKG9UVZNR05kscIW8xGLX+vwsS6v/ij9WjI5Taz5efWi
 rgecKM0v7dIEEmU7Lud019GAU8amK4094wXMhLtOFdBTPSKbujIIIs1ghRHxsq7UWNoD
 Vgpl9fBlHx88EEGOkUzhsh23eizIGh9z6q9SZMTdW3Ln2JCCtk3fxUAjY74l68GswlUK
 rcA/hwGYWyNlW7VqGtn+utxD4TOhwnsTtmdNUPcbDm9BGUalV7baQQ564zMLRJZck5vR
 IGM+YXGiVG3HXim6DwfEgHIC/nZAh2B8OGD8N6VdCd3vV302krYqBUCA2EgWjgR9BTNM
 ZTgw==
X-Gm-Message-State: AOAM531m6BlLTqxvwirWso0MCtWQwUZFOJsariZ6mXCZqPyNyN/kPqCt
 V04ghlDWbnLy3aWpIZheySg=
X-Google-Smtp-Source: ABdhPJz8temooJ7kPX8csZ9vxu+kR02L+qkUvKN5QC/SQZ1uqpp04r+24iMhjzc+nwStsQWaIV4CsA==
X-Received: by 2002:a17:90b:314c:b0:1e0:35e9:e6b with SMTP id
 ip12-20020a17090b314c00b001e035e90e6bmr10469957pjb.25.1653691089071; 
 Fri, 27 May 2022 15:38:09 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a632c0c000000b003f5e0c264bcsm3953813pgs.66.2022.05.27.15.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 May 2022 15:38:08 -0700 (PDT)
Date: Sat, 28 May 2022 07:38:06 +0900
From: Stafford Horne <shorne@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: Link failure with Debian toolchain
Message-ID: <YpFSzpl5fdq7O3pk@antec>
References: <CACPK8XcBRtd+RFhXaR-B3wbeM1gsmCW3hgRp_uwS0-g-oCWniw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XcBRtd+RFhXaR-B3wbeM1gsmCW3hgRp_uwS0-g-oCWniw@mail.gmail.com>
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
Cc: openrisc@lists.librecores.org, nicolas@debian.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Hi Joel,

On Thu, May 26, 2022 at 11:26:45PM +0000, Joel Stanley wrote:
> Hi Stafford,
> 
> I'm not sure if you were aware, but Debian now has a or1k cross compile:
> 
> $ apt policy gcc-or1k-elf
> gcc-or1k-elf:
>   Installed: 12.1.0-2+1.0.2
> $ apt policy binutils-or1k-elf
> binutils-or1k-elf:
>   Installed: 2.38-2+1.0.3

I didn't know about this. but it looks right.

> I've used it to build a mork1x litex soc so I think it works in some
> situations at least.
> 
> I was trying to build your latest Linux kernel changes, applied on top
> of v5.18, however the bug reproduces with plain v5.18.
> 
> $ CROSS_COMPILE=or1k-elf- ARCH=openrisc make O=or1k or1klitex_defconfig
> $ CROSS_COMPILE=or1k-elf- ARCH=openrisc make O=or1k -j8

This looks good too. What is the meaning of O=or1k? I never have used that
before.

> This fails at the link step:
> 
>   LD      vmlinux.o
> + or1k-elf-ld -r -o vmlinux.o --whole-archive
> arch/openrisc/kernel/head.o init/built-in.a usr/built-in.a
> arch/openrisc/built-in.a kernel/built-in.a certs/built-in.a
> mm/built-in.a fs/built-in.a ipc/built-in.a security/built-in.a
> crypto/built-in.a block/built-in.a lib/built-in.a drivers/built-in.a
> sound/built-in.a net/built-in.a virt/built-in.a --no-whole-archive
> --start-group lib/lib.a /usr/lib/gcc/or1k-elf/12/libgcc.a --end-group
> or1k-elf-ld: /usr/lib/gcc/or1k-elf/12/libgcc.a: error adding symbols:
> archive has no index; run ranlib to add one
> 
> The libgcc.a appears to have the expected files inside it.
> 
> I tried running ar -a libgcc.a, and that changed the error to look like this:
> 
> or1k-elf-ld: init/main.o: in function `do_one_initcall':
> main.c:(.init.text+0x12ec): undefined reference to `__muldi3'
> main.c:(.init.text+0x12ec): relocation truncated to fit:
> R_OR1K_INSN_REL_26 against undefined symbol `__muldi3'
> 
> With a lot more undefined reference errors for __muldi3, __ashldi3,
> and __lshrdi3.

This seems to mean that the builtins for 64-bit ops are not being found. So
something is wrong with libgcc symbols.  Maybe something strange with the
multilib args used when building the toolchain.

I'll have a look at it. It would be nice if I can used this toolchain for my CI.

-Stafford
> I'm not sure if this is a toolchain error or a kernel one. The kernel
> appears to be doing the right thing.
> 
> I've cc'd Nicholas who is the Debian maintainer for the package in
> case he has any ideas.
> 
> Cheers,
> 
> Joel
