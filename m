Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894AEC433FE
	for <openrisc@archiver.kernel.org>; Fri,  7 Oct 2022 02:31:06 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 2BDFC24A8D;
	Fri,  7 Oct 2022 04:31:05 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by mail.librecores.org (Postfix) with ESMTPS id 97C0324A58
 for <openrisc@lists.librecores.org>; Fri,  7 Oct 2022 04:31:03 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id pq16so3279790pjb.2
 for <openrisc@lists.librecores.org>; Thu, 06 Oct 2022 19:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to; bh=9oXX1ToddAdjCT7RrejoF1gtgX9gXH4OgxAoTE01pKk=;
 b=CoIUIlp/l30nI9b/o2YjTZvVwciHUnvYi5SK6ywag4/a/mcM6KppbWz3KG3F4//vFl
 bMqA96n9dGXj+ileOiyC3XdJ68h6UoSjqU1idAlEXpkIchHHXywDqsIilE6dXFxDNARW
 NtBLKvxwl4fxQfXNrre7UJChNy6Vo3bE4ijrP3epqwzH/YL+htGdUQOR96BxodrCR6KT
 2al3u4KWt/1aPXEAVWZlplrfopo19Tgye9BhgGJO/02xU5IU1lGy0sQR1+uWJ3xx/ysr
 2wfcfGs4Gp4y2Rb8LNxGCkrhQNTDlj3PSjiC8+7t3cjcArXERmYuC/zhL0RuJOgLcqLO
 TinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oXX1ToddAdjCT7RrejoF1gtgX9gXH4OgxAoTE01pKk=;
 b=RuO6h/HOs5Yco48QM5uTpvuEsqMF2eQ8SIQLOOjbiHel6wRc5Oh8mT5lINoUJDeD1O
 ckhJZ8U5q4wSzPo1ML3AoegsSzEIvLTK9VNrOaNAaNj8+VLsbfgaZhXP7sZp5HDdvy4s
 CKHYpGtl4llQt8IXhUZig7vY7FPGzTG8otdqITdDSNxueGWNNFdkzCLPdh4lutRdAioa
 X7eDcFxPt0zsNqUWvoFLo6ODfq5bu9vUOyyhWmadcOOrVkOprMWZ2bJBldpqpDgFBwoM
 mfwjfdkMEpCPuYofoxK5xx7QtlGGDw5ZKzFipX7KtqgO3dt1Xavq3T6MDLlDpWR2Sjj3
 2enQ==
X-Gm-Message-State: ACrzQf1h5HnCmZCvx0Tw5S+gHJprRMJn+vADsPJO+OzBjaV1k6Tq3Dcz
 Lj4J5d7c/G7vidErRnNMTqjwqg==
X-Google-Smtp-Source: AMsMyM4kchN+uqfbU5gVp8zmvTg52VKf0+O3238fnLuQ4FqZxuadQCVq4nUrE/VsX2pSjMg0cIFJAw==
X-Received: by 2002:a17:902:c950:b0:178:4544:55c1 with SMTP id
 i16-20020a170902c95000b00178454455c1mr2537890pla.168.1665109862049; 
 Thu, 06 Oct 2022 19:31:02 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223]) by smtp.gmail.com with ESMTPSA id
 p8-20020a170902780800b001743ba85d39sm318593pll.110.2022.10.06.19.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Oct 2022 19:31:01 -0700 (PDT)
Date: Thu, 06 Oct 2022 19:31:01 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Oct 2022 19:30:58 PDT (-0700)
Subject: Re: [PATCH] RISC-V: Add STACKLEAK erasing the kernel stack at the end
 of syscalls
In-Reply-To: <6c48657c-04df-132d-6167-49ed293dea44@microchip.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Conor.Dooley@microchip.com
Message-ID: <mhng-8c3bb2e7-e84e-4aaa-bce8-3e8054255a2c@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: linux-efi@vger.kernel.org, heiko@sntech.de, oleg@redhat.com,
 guoren@kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 ardb@kernel.org, linux-arch@vger.kernel.org, xianting.tian@linux.alibaba.com,
 linux@armlinux.org.uk, vgupta@kernel.org, linux-snps-arc@lists.infradead.org,
 aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
 openrisc@lists.librecores.org, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-arm-kernel@lists.infradead.org, monstr@monstr.eu,
 linux-kernel@vger.kernel.org, dinguyen@kernel.org, daolu@rivosinc.com,
 davem@davemloft.net
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Tue, 06 Sep 2022 10:35:10 PDT (-0700), Conor.Dooley@microchip.com wrote:
> On 03/09/2022 17:23, guoren@kernel.org wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>> 
>> From: Xianting Tian <xianting.tian@linux.alibaba.com>
>> 
>> This adds support for the STACKLEAK gcc plugin to RISC-V and disables
>> the plugin in EFI stub code, which is out of scope for the protection.
>> 
>> For the benefits of STACKLEAK feature, please check the commit
>> afaef01c0015 ("x86/entry: Add STACKLEAK erasing the kernel stack at the end of syscalls")
>> 
>> Performance impact (tested on qemu env with 1 riscv64 hart, 1GB mem)
>>     hackbench -s 512 -l 200 -g 15 -f 25 -P
>>     2.0% slowdown
>> 
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> 
> What changed since Xianting posted it himself a week ago:
> https://lore.kernel.org/linux-riscv/20220828135407.3897717-1-xianting.tian@linux.alibaba.com/
> 
> There's an older patch from Du Lao adding STACKLEAK too:
> https://lore.kernel.org/linux-riscv/20220615213834.3116135-1-daolu@rivosinc.com/
> 
> But since there's been no activity there since June...

Looks like the only issues were some commit log wording stuff, and that 
there's a test suite that should be run.  It's not clear from the 
commits that anyone has done that, I'm fine with the patch if it passes 
the tests but don't really know how to run them.

Has anyone run the tests?

> 
>> ---
>>  arch/riscv/Kconfig                    | 1 +
>>  arch/riscv/include/asm/processor.h    | 4 ++++
>>  arch/riscv/kernel/entry.S             | 3 +++
>>  drivers/firmware/efi/libstub/Makefile | 2 +-
>>  4 files changed, 9 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index ed66c31e4655..61fd0dad4463 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -85,6 +85,7 @@ config RISCV
>>         select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>>         select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>>         select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
>> +       select HAVE_ARCH_STACKLEAK
>>         select HAVE_ASM_MODVERSIONS
>>         select HAVE_CONTEXT_TRACKING_USER
>>         select HAVE_DEBUG_KMEMLEAK
>> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
>> index d0537573501e..5e1fc4f82883 100644
>> --- a/drivers/firmware/efi/libstub/Makefile
>> +++ b/drivers/firmware/efi/libstub/Makefile
>> @@ -25,7 +25,7 @@ cflags-$(CONFIG_ARM)          := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>>                                    -fno-builtin -fpic \
>>                                    $(call cc-option,-mno-single-pic-base)
>>  cflags-$(CONFIG_RISCV)         := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>> -                                  -fpic
>> +                                  -fpic $(DISABLE_STACKLEAK_PLUGIN)
>> 
>>  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
>> 
>> --
>> 2.17.1
>> 
>> 
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
