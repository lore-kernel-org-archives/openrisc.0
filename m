Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB6FC433FE
	for <openrisc@archiver.kernel.org>; Sun,  6 Nov 2022 21:19:35 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 404B7211B0;
	Sun,  6 Nov 2022 22:19:34 +0100 (CET)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mail.librecores.org (Postfix) with ESMTPS id 58BF424B93
 for <openrisc@lists.librecores.org>; Sat, 15 Oct 2022 20:08:51 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id b25so4446464qkk.7
 for <openrisc@lists.librecores.org>; Sat, 15 Oct 2022 11:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4wAaC7lbGaB3AX/Lsftuvb2OO1sJpQJ6Ykn9DFNJXY0=;
 b=FyRwiQ1Kkh2U3R7rwv/cUWgWbhnhVuRAkvLikv3swWoWi+Qni43MwmjlvAl7Qd5YWU
 e3eQ8r4coovbGUfjgmrmah9muM3lMIJqLMPtobpzhigxXHyNURqImNwciQiRzGsAHdHO
 qXOEVFqd/G+S/R1kNsVrId98EksJPTRvXw6S31DLxWwCE/s50meM1rY5rsjT96D1ObDy
 lCH7/wDPhN4Zl3js/rayUXV95GaO+0Ed0I7Aor4TcANC3GM2Q2PJASLmjnpLgyV/gbKH
 KXTHOpPBMJ9ORopJ3VS/8U3M5d4tTN/mU0ZQfTgvUx8AXj2lFRY2L268IjoNTL418YNj
 eMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4wAaC7lbGaB3AX/Lsftuvb2OO1sJpQJ6Ykn9DFNJXY0=;
 b=4qY4RlxxlaYaOA+fjfLP2eg+yX8l/U3plMBOrRvMvr38lCxnIbIQ7DqsstdUCEgRvG
 U8laeS+PeL1+iC3yZm1tXSLFAKS32Mm/Goakivh8u5fel0VK1n/xgh9HAMTvQDjhj6gi
 TgX9d3h7v005sv4vJkCplkxr4Q78k2R7oD9gC+1p+6Yj88Fzfa8MIT85mQtHhvm1c0KU
 Pc9s3gbHyV/Me1Fa8qGYUU/3LAYnUDp7CYStG+hP3hO2lmPINmc2+2wg4by8URVyjP4y
 mS9Bh7/PnzkkZ7U6hOkOprwgbCzGg4d29wBkM3JZ5DRdkmitxpQKpFFNbBqoLb1ATBAj
 iNuA==
X-Gm-Message-State: ACrzQf3Udd6HVjUOXTpy6iehkUPVn4zBwR6Uo/hPnV53KB+iYXXrr26F
 UtJ5m70tdSBLwPlVrsLdvxY=
X-Google-Smtp-Source: AMsMyM6RKmR37GztXAcqofHNQn3klZzUQq+GK3VRFWmYfAI4qhzKm9L4cuQOR6HCO3RXlQARuABfrA==
X-Received: by 2002:a37:6303:0:b0:6ec:554b:131d with SMTP id
 x3-20020a376303000000b006ec554b131dmr2532393qkb.166.1665857330103; 
 Sat, 15 Oct 2022 11:08:50 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:2b6d:8b98:c35a:4b7])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a05620a400600b006b949afa980sm5294690qko.56.2022.10.15.11.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Oct 2022 11:08:49 -0700 (PDT)
Date: Sat, 15 Oct 2022 11:08:51 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v3 0/2] Fix /proc/cpuinfo cpumask warning
Message-ID: <Y0r3M+WCMqugVoXf@yury-laptop>
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014155845.1986223-1-ajones@ventanamicro.com>
X-Mailman-Approved-At: Sun, 06 Nov 2022 22:19:32 +0100
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
Cc: Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <hca@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>, Albert Ou <aou@eecs.berkeley.edu>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Fri, Oct 14, 2022 at 05:58:43PM +0200, Andrew Jones wrote:
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

Acked-by: Yury Norov <yury.norov@gmail.com
