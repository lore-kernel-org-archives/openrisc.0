Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54616C433F5
	for <openrisc@archiver.kernel.org>; Thu, 26 May 2022 23:27:02 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 21CEC248CD;
	Fri, 27 May 2022 01:27:01 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by mail.librecores.org (Postfix) with ESMTPS id DBD5E248CC
 for <openrisc@lists.librecores.org>; Fri, 27 May 2022 01:26:58 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 h126-20020a1c2184000000b003975cedb52bso1475811wmh.1
 for <openrisc@lists.librecores.org>; Thu, 26 May 2022 16:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=DWkaZrRymrDvZ5bP75khxG+fNTQ0lNnbhxpZK0tmMKs=;
 b=YlVK90oDw/rnYHS/F2ByhDLWm0H/HL+3b9J0RHnNAneIQA6SNMvKbZ2sMjsNkzoNde
 GtLKDypoT4SoUkvu7uectThfAI6HKdDNCZe1+G9nWXXoes1reUZ0/zeZ5CwEwcvY62iW
 /buk0JKyeXpWANOsoL/NT2j6moNt+0Jk+fAgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=DWkaZrRymrDvZ5bP75khxG+fNTQ0lNnbhxpZK0tmMKs=;
 b=vsqEhuMEb6+vnCUzXFPkXpBn+vzZ/muIrtirH6h/yPu8u32wC6VNXFYrs6v2Jgseb+
 W49ljrAsN8sa0eTt3kw1cMC7pChG7fRTOqWIav58bh9ijhRRFAHVlFJjwofqt6eZNMCA
 Hd0Jn85gDrdE7H91v3zGVu3QwKfHHIwmmEx4TTrkZb5TDhaKLleT+xwQ4tGS6L176ARK
 ONlw7p9I3aLjW+JdLdL09Aqon50nFOw9hGZIECMbwi7WHj9TVTMYNNniFy1tMLYYvSBM
 JQqOWM7ZZgVN8Nhb5GGkkXQbAmzWXCqr13JV8YwpFnQ23rNzqb+O6iQAtMfcJplnc8pw
 gP2Q==
X-Gm-Message-State: AOAM530nczKHqDfn5TjYJ8wGlAv8WaI4tr1x+RW4YKZn8/59GrTCJ4AC
 60OE4qtNER1h1HX1nRXewqOESEO8rPjDxKI9I60=
X-Google-Smtp-Source: ABdhPJwAg5k8gSlhG+Z7ZKHj+i6kUaFlRveRAMfnbLm4wwhn5u9rF/wxFU/AjnYZ7AJrDU9Bv32+OboFELOOh/xP/J0=
X-Received: by 2002:a7b:c001:0:b0:394:87bc:ad70 with SMTP id
 c1-20020a7bc001000000b0039487bcad70mr4419879wmb.147.1653607618313; Thu, 26
 May 2022 16:26:58 -0700 (PDT)
MIME-Version: 1.0
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 26 May 2022 23:26:45 +0000
Message-ID: <CACPK8XcBRtd+RFhXaR-B3wbeM1gsmCW3hgRp_uwS0-g-oCWniw@mail.gmail.com>
Subject: Link failure with Debian toolchain
To: Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Stafford,

I'm not sure if you were aware, but Debian now has a or1k cross compile:

$ apt policy gcc-or1k-elf
gcc-or1k-elf:
  Installed: 12.1.0-2+1.0.2
$ apt policy binutils-or1k-elf
binutils-or1k-elf:
  Installed: 2.38-2+1.0.3

I've used it to build a mork1x litex soc so I think it works in some
situations at least.

I was trying to build your latest Linux kernel changes, applied on top
of v5.18, however the bug reproduces with plain v5.18.

$ CROSS_COMPILE=or1k-elf- ARCH=openrisc make O=or1k or1klitex_defconfig
$ CROSS_COMPILE=or1k-elf- ARCH=openrisc make O=or1k -j8

This fails at the link step:

  LD      vmlinux.o
+ or1k-elf-ld -r -o vmlinux.o --whole-archive
arch/openrisc/kernel/head.o init/built-in.a usr/built-in.a
arch/openrisc/built-in.a kernel/built-in.a certs/built-in.a
mm/built-in.a fs/built-in.a ipc/built-in.a security/built-in.a
crypto/built-in.a block/built-in.a lib/built-in.a drivers/built-in.a
sound/built-in.a net/built-in.a virt/built-in.a --no-whole-archive
--start-group lib/lib.a /usr/lib/gcc/or1k-elf/12/libgcc.a --end-group
or1k-elf-ld: /usr/lib/gcc/or1k-elf/12/libgcc.a: error adding symbols:
archive has no index; run ranlib to add one

The libgcc.a appears to have the expected files inside it.

I tried running ar -a libgcc.a, and that changed the error to look like this:

or1k-elf-ld: init/main.o: in function `do_one_initcall':
main.c:(.init.text+0x12ec): undefined reference to `__muldi3'
main.c:(.init.text+0x12ec): relocation truncated to fit:
R_OR1K_INSN_REL_26 against undefined symbol `__muldi3'

With a lot more undefined reference errors for __muldi3, __ashldi3,
and __lshrdi3.

I'm not sure if this is a toolchain error or a kernel one. The kernel
appears to be doing the right thing.

I've cc'd Nicholas who is the Debian maintainer for the package in
case he has any ideas.

Cheers,

Joel
