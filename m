Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F683FA3743
	for <openrisc@archiver.kernel.org>; Thu, 27 Oct 2022 23:07:23 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 0EAE824B70;
	Fri, 28 Oct 2022 01:07:23 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mail.librecores.org (Postfix) with ESMTPS id 25AAF24B3B
 for <openrisc@lists.librecores.org>; Fri, 28 Oct 2022 01:07:22 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id q71so3160899pgq.8
 for <openrisc@lists.librecores.org>; Thu, 27 Oct 2022 16:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to; bh=3gyfpmFe14VJ3jdYNVJ0rx3Ah2uaRzNTmMnT4495S4I=;
 b=ZNNSYZLMCiTx3pCpdTSLaMqTAwcT0XD23hboDkck2m1sj0K18I/wiwFIJBnxkxlMh1
 TMOX+6v0XNUWVLrMkaS7nFMD6HK3C70ZLK5411vF56AMxZrrEveIWdn7U/wWYAX6hu8f
 z7X+MhLcDZ2abQ+JkeJnFiHqWkFba2HtnVwkX4LhmKXO9kCXDrbkBH+MQc0VlITciM7I
 DQ4GGK7LnrmeObtOo33dthlXeC/HBl0rQRBuyHKeRHXZmYYPUrcsYqTcTlXIWwUSoL9i
 Op+9awjoXqXajuMDeHaLc5MvW/7/blHnT1v9JwgcyUng9A7q3UoZ9aZNVukbXbfjaCwz
 UOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gyfpmFe14VJ3jdYNVJ0rx3Ah2uaRzNTmMnT4495S4I=;
 b=TZeEgiZoLV9Gkj4jQm6jEtqkZJbzywqsdDznRXMQbgYfXFKJ9hKbM4ZW7FzCvGdeEf
 46Zb2L/nTWxtHdo3Qd6MdYJ/nkk7vTUcfiyNGCHnBLIGbw/82JE5sloulLKWDQr+eNs+
 rt5atQvTRHTx2NEnLSif7ytNMM4Q7pC0MKy2Z5W/2H2CtTI2+XZ3SkOHRFo1uq1C+SiV
 f6XHR0LrRUnSorrmcVBAqeBDwP4lMX/5PWZR2n1OKGQNwfONhKdzWLWYlHEwBWwhB7na
 hoVtaidazXS1C79CFUc+6soilxhQOXLxdgDipiEdyAsYCsJ/EykYn7IHDeq+Efd9pmeV
 E0LA==
X-Gm-Message-State: ACrzQf0gNWov9oUwYi0PdNL7tP1yyTkIXxwnZ4y0rGu0iClciDik6vh2
 8pv3OFTXL8QMrTi9fGmydg/3lQ==
X-Google-Smtp-Source: AMsMyM48cCCOaGHpcUrqKPuvLPqi8N0s0YHUDIkD3gXkNLjihHit7dpsoFkfZbjAvACH4Z61kt9rCg==
X-Received: by 2002:a65:44c1:0:b0:428:ab8f:62dd with SMTP id
 g1-20020a6544c1000000b00428ab8f62ddmr44319504pgs.211.1666912040505; 
 Thu, 27 Oct 2022 16:07:20 -0700 (PDT)
Received: from localhost ([50.221.140.188]) by smtp.gmail.com with ESMTPSA id
 bf4-20020a170902b90400b00186e8526790sm1675818plb.127.2022.10.27.16.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Oct 2022 16:07:18 -0700 (PDT)
Date: Thu, 27 Oct 2022 16:07:18 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Oct 2022 15:22:27 PDT (-0700)
Subject: Re: [PATCH v3 0/2] Fix /proc/cpuinfo cpumask warning
In-Reply-To: <20221014155845.1986223-1-ajones@ventanamicro.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: ajones@ventanamicro.com
Message-ID: <mhng-b3bcbdea-1572-44ba-9d9a-e35e55b8880f@palmer-ri-x1c9a>
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
Cc: jonas@southpole.se, linux-s390@vger.kernel.org, agordeev@linux.ibm.com,
 dave.hansen@linux.intel.com, gor@linux.ibm.com, yury.norov@gmail.com,
 mpe@ellerman.id.au, hca@linux.ibm.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, openrisc@lists.librecores.org, mingo@redhat.com,
 bp@alien8.de, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 tglx@linutronix.de, aou@eecs.berkeley.edu
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Fri, 14 Oct 2022 08:58:43 PDT (-0700), ajones@ventanamicro.com wrote:
> Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
> started issuing warnings[*] when cpu indices equal to nr_cpu_ids - 1
> are passed to cpumask_next* functions. seq_read_iter() and cpuinfo's
> start and next seq operations implement a pattern like
>
>   n = cpumask_next(n - 1, mask);
>   show(n);
>   while (1) {
>       ++n;
>       n = cpumask_next(n - 1, mask);
>       if (n >= nr_cpu_ids)
>           break;
>       show(n);
>   }
>
> which will issue the warning when reading /proc/cpuinfo.
>
> [*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.
>
> This series address the issue for x86 and riscv, but from a quick
> grep of cpuinfo seq operations, I think at least openrisc, powerpc,
> and s390 also need an equivalent patch. While the test is simple (see
> next paragraph) I'm not equipped to test on each architecture.
>
> To test, just build a kernel with DEBUG_PER_CPU_MAPS enabled, boot to
> a shell, do 'cat /proc/cpuinfo', and look for a kernel warning.
>
> While the patches are being posted together in a series since they're
> for two different architectures they don't necessarily need to go
> through the same tree.
>
> v3:
>   - Change condition from >= to == in order to still get a warning
>     for > as that's unexpected. [Yury]
>   - Picked up tags on the riscv patch
>
> v2:
>   - Added all the information I should have in the first place
>     to the commit message [Boris]
>   - Changed style of fix [Boris]
>
> Andrew Jones (2):
>   RISC-V: Fix /proc/cpuinfo cpumask warning

I just took the RISC-V fix, might be worth re-sending the x86 one alone 
as nobody's replied over there so it may be lost.

Thanks!

>   x86: Fix /proc/cpuinfo cpumask warning
>
>  arch/riscv/kernel/cpu.c    | 3 +++
>  arch/x86/kernel/cpu/proc.c | 3 +++
>  2 files changed, 6 insertions(+)
