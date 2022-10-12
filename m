Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06161C433FE
	for <openrisc@archiver.kernel.org>; Wed, 12 Oct 2022 16:51:42 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 980FB24851;
	Wed, 12 Oct 2022 18:51:41 +0200 (CEST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by mail.librecores.org (Postfix) with ESMTPS id 93898248D5
 for <openrisc@lists.librecores.org>; Wed, 12 Oct 2022 14:42:17 +0200 (CEST)
Received: by mail-ej1-f52.google.com with SMTP id fy4so1270644ejc.5
 for <openrisc@lists.librecores.org>; Wed, 12 Oct 2022 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=scSSoPVjvPcIKMwAKdcIxF1HMnXwBEuvlyuD0JbeDac=;
 b=hSkbNoXoG3wWcVdKnqVO7XYK1bv0MH9u8oEv95OaWkkCTB9RsoNg9sS+DyfAXD0gi8
 C3B5RxdZ6EF3FePvqnrCKkr5w8XgiGA0OEB2iK+NsGb9ZOHdvUgBAY5mEupVk514sXh2
 BcfULR6zZ2AZhQJP/B28JemyEcyeDcI3AKRJ5lPKFWuGde9NbfJyX15rLE2gsyDez6YX
 OKDkOurVilre1ybmB6wqSmbSEpcfuh+ukasYa8QPIj2WOxaDkWQTz+Nri8qre79tIxTd
 1cFDVYDQytan/tbkNZZVN4NNSOJbGSrVUq2mGHauT+3m9QGeWYsm/jufVV+rUDLqTO07
 hCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scSSoPVjvPcIKMwAKdcIxF1HMnXwBEuvlyuD0JbeDac=;
 b=Cy/pJa3sJO+3od7qiCVov2ch6CmsVW5LVy9naqhShlSRkPLghaYkF2R4SpLb3TL4lp
 vc9o4fEpqhaGLhXI9UKOFRYoee/xXi7b/q53JAVxMhWUzNkwN7kM1q5sPgahdW+hCc6r
 aerADMr0g+F0NDvvJj6dh5n18mLhzdOxNUlz+NJehcNOmWmitLO78YVTYKOqinJa657O
 ZZdEGg4eTJy0qGxoIcWEXiVh6JZ7yamXQxhxgETGg9Zx1TjDANqwGuIvyRqPvAjmTO3+
 To8jD8LhVxRpAMKHgtI9ZwbVz6Esy82/W1pETezu6LI9fGqebXOJ7uGf7Yr/A+/SPztp
 Xuew==
X-Gm-Message-State: ACrzQf2cqhUxS2HldD4Ht/QKmhtnhNcOkzWCgQq1Pf6zKlao7ZquNjyZ
 rGDTfTOsWfoCpaYQ40Vzbe2uhA==
X-Google-Smtp-Source: AMsMyM5pMRTzBK4wxOaeWPxAICeTFfKr9UUi5U35RJKBVu1VmBh/W7bpRQUc+vTTEtwGS2qmCt2lPQ==
X-Received: by 2002:a17:907:a06b:b0:78d:d25f:b726 with SMTP id
 ia11-20020a170907a06b00b0078dd25fb726mr7250759ejc.203.1665578537183; 
 Wed, 12 Oct 2022 05:42:17 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
 by smtp.gmail.com with ESMTPSA id
 w21-20020aa7da55000000b0044e01e2533asm11133463eds.43.2022.10.12.05.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Oct 2022 05:42:16 -0700 (PDT)
Date: Wed, 12 Oct 2022 14:42:15 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <20221012124215.edmgo6767yipfkt2@kamzik>
References: <20221012081905.1800640-1-ajones@ventanamicro.com>
 <20221012082422.uavybxdfmv4xkhxi@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012082422.uavybxdfmv4xkhxi@kamzik>
X-Mailman-Approved-At: Wed, 12 Oct 2022 18:51:41 +0200
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
 Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Yury Norov <yury.norov@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <hca@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 openrisc@lists.librecores.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>


Adding more people and lists to CC in order to point this patch out,
because, based on a quick grep of cpuinfo seq operations, I think at least
openrisc, powerpc, and s390 also need an equivalent patch (and I've
already sent a patch for riscv). While the test is simple (see next
paragraph) I'm not equipped to test on each architecture.

To test, just build a kernel with DEBUG_PER_CPU_MAPS enabled, boot to a
shell, do 'cat /proc/cpuinfo', and look for a kernel warning.

Thanks,
drew

On Wed, Oct 12, 2022 at 10:24:22AM +0200, Andrew Jones wrote:
> On Wed, Oct 12, 2022 at 10:19:05AM +0200, Andrew Jones wrote:
> > Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
> > started issuing warnings[*] when cpu indices equal to nr_cpu_ids - 1
> > are passed to cpumask_next* functions. seq_read_iter() and cpuinfo's
> > start and next seq operations implement a pattern like
> > 
> >   n = cpumask_next(n - 1, mask);
> >   show(n);
> >   while (1) {
> >       ++n;
> >       n = cpumask_next(n - 1, mask);
> >       if (n >= nr_cpu_ids)
> >           break;
> >       show(n);
> >   }
> > 
> > which will issue the warning when reading /proc/cpuinfo. Ensure no
> > warning is generated by validating the cpu index before calling
> > cpumask_next().
> > 
> > [*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.
> > 
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > Cc: Yury Norov <yury.norov@gmail.com>
> > ---
> 
> Forgot the changelog...
> 
> v2:
>   - Added all the information I should have in the first place to the
>     commit message [Boris]
>   - Changed style of fix [Boris]
> 
> >  arch/x86/kernel/cpu/proc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> > index 099b6f0d96bd..94ac02c8dd6f 100644
> > --- a/arch/x86/kernel/cpu/proc.c
> > +++ b/arch/x86/kernel/cpu/proc.c
> > @@ -153,6 +153,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)
> >  
> >  static void *c_start(struct seq_file *m, loff_t *pos)
> >  {
> > +	if (*pos >= nr_cpu_ids)
> > +		return NULL;
> > +
> >  	*pos = cpumask_next(*pos - 1, cpu_online_mask);
> >  	if ((*pos) < nr_cpu_ids)
> >  		return &cpu_data(*pos);
> > -- 
> > 2.37.3
> > 
