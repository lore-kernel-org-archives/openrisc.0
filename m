Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C664CC38A02
	for <openrisc@archiver.kernel.org>; Fri, 28 Oct 2022 07:48:31 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id A9BD924B58;
	Fri, 28 Oct 2022 09:48:30 +0200 (CEST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by mail.librecores.org (Postfix) with ESMTPS id E9FFF24B58
 for <openrisc@lists.librecores.org>; Fri, 28 Oct 2022 09:48:29 +0200 (CEST)
Received: by mail-wr1-f43.google.com with SMTP id z14so5863282wrn.7
 for <openrisc@lists.librecores.org>; Fri, 28 Oct 2022 00:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U0U3J+Q69fu7o/YQz3q/fMO7g+tmuXGKvEK6KG9JDGA=;
 b=oqmNgqsztuMpLAhNQorP3820L6EJNnJRDoXEb4RgzXZQMfNQDcyVCHVYlvSTb+cksH
 CwJ2aeLsuRGbAg4oUeweMw9W7RVPie8fbQhXZCKgnIXewPhBCQ2D8qNqXYiXfhT76dW6
 xJX6KJ6QR8kf1VFJxGUsMl5/+ENJJ5Wxii90WkOuwZT7HNIb6lID8pp/UFcfXmak4LFL
 jTzzJYzhej1Kn237Slz8BJcwQbdSqVXWEQpinfJlNcbgrjQ4bsMdqNEumXt3CMYlYdSi
 LO4ALfufKLzxVKs824kdxmBew78rDuLIWHvjPbK+3tKTM3XpkrSx4Zr/NWhajts4BWCr
 /L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U0U3J+Q69fu7o/YQz3q/fMO7g+tmuXGKvEK6KG9JDGA=;
 b=5j2TAccyiEtW8d4vGwDEp2fYAjclxO6pvCQpHV51nhD1OQinMm7Qw9O348VGiE1/i1
 oDY59IpZtOwfYDa2QL9YeVkzDIxUZmR1EmctKhUV8x7c6TVokJa1RlvGNZiOTj9NEXV/
 2U9JQ73PQLaJ0+PUfLnrkWJDe4eHWGbcvDHlTX90ic1N3WEJVxP6JhkshHdcvZ37YP0E
 tBKlhs6K5YvNT/9BBtHFZqXfBrtReFSEXi5bEPM0vIx1XCaJeRKjoUBsE9PT92aBao4p
 riIYQimmTbLNO72HXxcixdkBdP2q849PqrrG0kSthHTOaYCXIKrNyXRKHi00ZnJZEaCN
 MgGQ==
X-Gm-Message-State: ACrzQf0GDn6i7YakOIO/Vo6xCBOw7iAgySq0nOk0vrQU6W2IeIvS00qz
 o4N6Zu7uBdKCDQ0ncRY3m+YOYw==
X-Google-Smtp-Source: AMsMyM6VIrVFAYX3MFdpAr2A3aolwkCyi7gytgwNOdq5lcvzoSJ4ww9Dhq1bl3mK11pqR8Em7mdPlA==
X-Received: by 2002:adf:ef4e:0:b0:236:6608:f6ce with SMTP id
 c14-20020adfef4e000000b002366608f6cemr18585925wrp.85.1666943309562; 
 Fri, 28 Oct 2022 00:48:29 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a5d4301000000b0022efc4322a9sm2989820wrq.10.2022.10.28.00.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Oct 2022 00:48:29 -0700 (PDT)
Date: Fri, 28 Oct 2022 09:48:28 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: x86@kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <20221028074828.b66uuqqfbrnjdtab@kamzik>
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
 <20221014155845.1986223-3-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014155845.1986223-3-ajones@ventanamicro.com>
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
 Alexander Gordeev <agordeev@linux.ibm.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Vasily Gorbik <gor@linux.ibm.com>, Yury Norov <yury.norov@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <hca@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Fri, Oct 14, 2022 at 05:58:45PM +0200, Andrew Jones wrote:
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
> which will issue the warning when reading /proc/cpuinfo. Ensure no
> warning is generated by validating the cpu index before calling
> cpumask_next().
> 
> [*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.
> 
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/x86/kernel/cpu/proc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> index 099b6f0d96bd..de3f93ac6e49 100644
> --- a/arch/x86/kernel/cpu/proc.c
> +++ b/arch/x86/kernel/cpu/proc.c
> @@ -153,6 +153,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  
>  static void *c_start(struct seq_file *m, loff_t *pos)
>  {
> +	if (*pos == nr_cpu_ids)
> +		return NULL;
> +
>  	*pos = cpumask_next(*pos - 1, cpu_online_mask);
>  	if ((*pos) < nr_cpu_ids)
>  		return &cpu_data(*pos);
> -- 
> 2.37.3
>

Hi x86 maintainers,

I realize 78e5a3399421 has now been reverted, so this fix is no longer
urgent. I don't believe it's wrong, though, so if it's still of interest,
then please consider this a friendly ping.

Thanks,
drew
