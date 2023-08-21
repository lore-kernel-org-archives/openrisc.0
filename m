Return-Path: <linux-openrisc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14788EE4993;
	Mon, 21 Aug 2023 15:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbjHUPON (ORCPT
        <rfc822;linux-openrisc@archiver.kernel.org> + 1 other);
        Mon, 21 Aug 2023 11:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbjHUPOM (ORCPT
        <rfc822;linux-openrisc@vger.kernel.org>);
        Mon, 21 Aug 2023 11:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4831E2
        for <linux-openrisc@vger.kernel.org>; Mon, 21 Aug 2023 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692630800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFQlCCBNCoXKcesi1ukMU3Md79GFl2aJD/2jvPafjYk=;
        b=FW8KwG4sD2DoAvybdOzbQPD6tATeFhnP6M85TXaHN4eMxjgmkG8QEuLlWr9Lw2Gr0AAMO3
        HCWUkwMT6u4t2qIJjNObe8WgUvt+pyG0n5OnASDuFing0+ZPbuZ8+7Omy5Wgpzb7sm0cWc
        cxJZDMIgu1600Gq+DJMTh4jbBWIimLo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-DfLSlZ50PgGDVdt34Z74xA-1; Mon, 21 Aug 2023 11:13:20 -0400
X-MC-Unique: DfLSlZ50PgGDVdt34Z74xA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-40ea01f3e3bso45748191cf.1
        for <linux-openrisc@vger.kernel.org>; Mon, 21 Aug 2023 08:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692630799; x=1693235599;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFQlCCBNCoXKcesi1ukMU3Md79GFl2aJD/2jvPafjYk=;
        b=C6lrlzNUJmywz87MkNzhKbtSH0vXQmpNAGW321MB2rOz2TuDNWuX2hf+6FuxuadkqD
         BAG2/ZM6TxHS7LwiiABjNBLCtJ+htErZWM+T8XMPC/Itp5HN/GG8u2nPvXYaThOc3JYX
         mpYB7Xd3uuhcMfIY9nHV4Xbgc/7/Kh/ssh3IltQykVtXKdysqpBYBLQPQyv2xGFZwNYd
         ktXGyBbuswEqWfhYl7fsbykRHS6rIupt4XCXwahGZJRm5XfeuN3B1HGD+Op61znL03uz
         BfWD1rmnWxWbF2JDHbTdV5HcO9/V3qxvBa0WlAFFJm+2hT/y5tof0sbNlosXziq3vFPW
         xUJQ==
X-Gm-Message-State: AOJu0YwhwlHl4Nxbu6PgnFPM9kMaklz7jTI9rZZwxf+jN9AaXea6nEpA
        L4oJBfork72deUN0pIhxTj10zzxYO9hLbe8rGTTQMG6hqO5LoHDnTfIpn6PvVY0qg8/4gj/b/Aw
        4oF2fjlWQmjA9bgkFVvvsoHWSKZ41RDv68gg=
X-Received: by 2002:ac8:5bd5:0:b0:40f:f07f:1c01 with SMTP id b21-20020ac85bd5000000b0040ff07f1c01mr11879287qtb.40.1692630799141;
        Mon, 21 Aug 2023 08:13:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8vRmC5awX3PhUUofEzfojNIFNQomV9AdNl2JRtAc2NUAi4xsvzz39EghzAbswpSuSz8sRJQ==
X-Received: by 2002:ac8:5bd5:0:b0:40f:f07f:1c01 with SMTP id b21-20020ac85bd5000000b0040ff07f1c01mr11879261qtb.40.1692630798829;
        Mon, 21 Aug 2023 08:13:18 -0700 (PDT)
Received: from [192.168.1.11] ([79.123.74.8])
        by smtp.gmail.com with ESMTPSA id 3-20020ac85743000000b004107fc9113bsm2163410qtx.22.2023.08.21.08.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 08:13:18 -0700 (PDT)
Message-ID: <f9ee2f12-2ea5-625b-1485-ce9d05167ac3@redhat.com>
Date:   Mon, 21 Aug 2023 16:13:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] sim: or1k: Eliminate dangerous RWX load segments
To:     Stafford Horne <shorne@gmail.com>,
        GNU Binutils <binutils@sourceware.org>,
        Nick Clifton via Gdb-patches <gdb-patches@sourceware.org>
Cc:     Mike Frysinger <vapier@gentoo.org>,
        Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20230819074518.2253226-1-shorne@gmail.com>
From:   Nick Clifton <nickc@redhat.com>
In-Reply-To: <20230819074518.2253226-1-shorne@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-openrisc.vger.kernel.org>
X-Mailing-List: linux-openrisc@vger.kernel.org

Hi Stafford Horne,

   The simulator code is actually maintained by the GNU GDB project
   rather than the GNU Binutils project, so I am redirecting this
   email to the gdb-patches list.

> This fixes test failures caused by the new linker warning which report:
> 
>    ./ld/ld-new: warning: load.S.x has a LOAD segment with RWX permissions
> 
> Fix this by splitting the linker MEMORY into ram and rom to avoid
> generating RWX sections.  This required tests to be adjusted to fix
> issues with the move.  Namely:
> 
>    - fpu tests: were incorrectly using l.ori with ha(anchor) which now
>      that we pushed the anchor up in memory it exposes the bug.  Update
>      to used the correct l.movhi instruction instead.
>    - adrp test: the test reports ram offset addresses, now that we have
>      moved memory layout around a bit I adjusted the test output.  Some
>      padding is added before pi to show that the actual address of pi and
>      the adrp page offset are not the same.

(It is nice to see that this new linker feature helped to detect these problems. :-)

> Bug: https://sourceware.org/PR29957
> ---
>   sim/testsuite/or1k/adrp.S               | 5 +++--
>   sim/testsuite/or1k/fpu-unordered.S      | 2 +-
>   sim/testsuite/or1k/fpu64a32-unordered.S | 2 +-
>   sim/testsuite/or1k/fpu64a32.S           | 2 +-
>   sim/testsuite/or1k/or1k-test.ld         | 7 ++++---
>   5 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/sim/testsuite/or1k/adrp.S b/sim/testsuite/or1k/adrp.S
> index eaddcb03885..192324c698e 100644
> --- a/sim/testsuite/or1k/adrp.S
> +++ b/sim/testsuite/or1k/adrp.S
> @@ -17,9 +17,9 @@
>   
>   # mach: or1k
>   # output: report(0x00002064);\n
> -# output: report(0x00012138);\n
> +# output: report(0x0001a008);\n
>   # output: report(0x00002000);\n
> -# output: report(0x00012000);\n
> +# output: report(0x0001a000);\n
>   # output: report(0x00002000);\n
>   # output: report(0x00014000);\n
>   # output: report(0x00000000);\n
> @@ -32,6 +32,7 @@
>   	.section .data
>   	.org 0x10000
>   	.align 4
> +pad:	.quad 	0
>   	.type   pi, @object
>   	.size   pi, 4
>   pi:
> diff --git a/sim/testsuite/or1k/fpu-unordered.S b/sim/testsuite/or1k/fpu-unordered.S
> index 624aa0fe05d..a89172e37af 100644
> --- a/sim/testsuite/or1k/fpu-unordered.S
> +++ b/sim/testsuite/or1k/fpu-unordered.S
> @@ -57,7 +57,7 @@ start_tests:
>   	 *  r13  e   as float
>   	 *  r16  nan as float
>   	 */
> -	l.ori	r11, r0, ha(anchor)
> +	l.movhi	r11, ha(anchor)
>   	l.addi	r11, r11, lo(anchor)
>   	l.lwz	r12, 0(r11)
>   
> diff --git a/sim/testsuite/or1k/fpu64a32-unordered.S b/sim/testsuite/or1k/fpu64a32-unordered.S
> index e0ae6e770d1..51d915e4e75 100644
> --- a/sim/testsuite/or1k/fpu64a32-unordered.S
> +++ b/sim/testsuite/or1k/fpu64a32-unordered.S
> @@ -58,7 +58,7 @@ start_tests:
>   	 *  r14,r15  e   as double
>   	 *  r16,r17  nan as double
>   	 */
> -	l.ori	r11, r0, ha(anchor)
> +	l.movhi	r11, ha(anchor)
>   	l.addi	r11, r11, lo(anchor)
>   	l.lwz	r12, 0(r11)
>   	l.lwz	r13, 4(r11)
> diff --git a/sim/testsuite/or1k/fpu64a32.S b/sim/testsuite/or1k/fpu64a32.S
> index 71b72b7761c..6ea60b28cf2 100644
> --- a/sim/testsuite/or1k/fpu64a32.S
> +++ b/sim/testsuite/or1k/fpu64a32.S
> @@ -98,7 +98,7 @@ start_tests:
>   	 *  r14,r15  e  as double
>   	 *  r16,r17  a long long
>   	 */
> -	l.ori	r11, r0, ha(anchor)
> +	l.movhi	r11, ha(anchor)
>   	l.addi	r11, r11, lo(anchor)
>   	l.lwz	r12, 0(r11)
>   	l.lwz	r13, 4(r11)
> diff --git a/sim/testsuite/or1k/or1k-test.ld b/sim/testsuite/or1k/or1k-test.ld
> index f1535daeabd..c26ecaf3f23 100644
> --- a/sim/testsuite/or1k/or1k-test.ld
> +++ b/sim/testsuite/or1k/or1k-test.ld
> @@ -20,8 +20,9 @@ MEMORY
>       /* The exception vectors actually start at 0x100, but if you specify
>          that address here, the "--output-target binary" step will start from
>          address 0 with the contents meant for address 0x100.  */
> -    exception_vectors : ORIGIN =  0 , LENGTH = 8K
> -    ram               : ORIGIN =  8K, LENGTH = 2M - 8K
> +    exception_vectors : ORIGIN =  0 , LENGTH =  8K
> +    rom               : ORIGIN =  8K, LENGTH = 40K
> +    ram               : ORIGIN = 40K, LENGTH =  2M - 40K
>   }
>   
>   SECTIONS
> @@ -37,7 +38,7 @@ SECTIONS
>   	*(.text.*)
>   	*(.rodata)
>   	*(.rodata.*)
> -    } > ram
> +    } > rom
>   
>       .data :
>       {

