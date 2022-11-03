Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0DCC4167B
	for <openrisc@archiver.kernel.org>; Sun,  6 Nov 2022 21:19:37 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 0DA7320CD6;
	Sun,  6 Nov 2022 22:19:36 +0100 (CET)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com
 [209.85.160.54])
 by mail.librecores.org (Postfix) with ESMTPS id A442825940
 for <openrisc@lists.librecores.org>; Thu,  3 Nov 2022 18:31:33 +0100 (CET)
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-13b6c1c89bdso2920378fac.13
 for <openrisc@lists.librecores.org>; Thu, 03 Nov 2022 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HvZ5+E5qu4GOYga/FqvgfxEG1c0dU8d73zf2fP+htGs=;
 b=iPqtLSq3l2qHplG860uNDrfYq9b0lZFbxHP6kSO5WcDFeNj74LgawQ3XHbriQnJzId
 91YDCFJ926vJ7L1jeQcvLnKN5IicgY26QvhLOUAx6NfuqsczuDo2+p95tiUE3Y3d3p8R
 Wb3AVYnqzTL0X7haZY7BTZ+oilwvxbeF6lVkgFNf8aMcvJgkuEefwy01BOsLK5VvAvzw
 YLeXvyd9tsE28Dp154l4LlczkE6gYboihsErhJGgG+F9jOSH92X0IzDV0rfpYNgoQqIc
 gaqjq4mqtFEpLgO3pJNfAld17zV9i0u6xe8AK0ilXIHLGax8f5r/eP0/Q0saTHwnR/aB
 J0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvZ5+E5qu4GOYga/FqvgfxEG1c0dU8d73zf2fP+htGs=;
 b=DldrFr9EZij0c5yh1DmjnaQPRUoHgiAiIKHgxBGZoLl+cD35R7PILl+q0CGkZIFqKj
 pv08Rl48h9ApzfOK6F/sXj8nQFJVPOK0Lounhn6iAzZXuyaqfNxYyLuD42Sy6LxBKviL
 i4ZXf0Dbuq4k/+mQIxL4bGK+35FlkFngP2en+crlfQpi8ZV1YbjnNWo7mhD7vdJaBLLm
 sD4qEB0VpZ+v1ZbaHQRCmGbMUofPmsXElFLRugCh3eBZQVfTo91ceg/ABqYfh82r7oZZ
 haJyon/nS3C1kCg9tkw3ndf/vHGSvv5FNVQQNNWmAW5cSPw7LBOur5AiJxlp0Gl/kJF0
 ssGg==
X-Gm-Message-State: ACrzQf3Rg8zA8Xxf5WMDiREB2g9wfOXN47/mk/IkvJQOGEwbNmS+Ezis
 A+XPWJYmpNNvTUqcIqn0FtM=
X-Google-Smtp-Source: AMsMyM6fJYEOKNxJ1D+xB246uqRaGV2DX2E0qNo3z76RYRYleK2EIFTcmwXSUrFyVWM6R7buKJ49fQ==
X-Received: by 2002:a05:6870:31c5:b0:13d:a04a:6ecf with SMTP id
 x5-20020a05687031c500b0013da04a6ecfmr1655565oac.101.1667496692226; 
 Thu, 03 Nov 2022 10:31:32 -0700 (PDT)
Received: from localhost ([12.97.180.36]) by smtp.gmail.com with ESMTPSA id
 r13-20020a4a964d000000b00425806a20f5sm430333ooi.3.2022.11.03.10.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Nov 2022 10:31:31 -0700 (PDT)
Date: Thu, 3 Nov 2022 10:31:30 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <Y2P68sfCJMvhKmhj@yury-laptop>
References: <Y1v+Ed6mRN9gisJS@zn.tnic> <20221031080604.6xei6c4e3ckhsvmy@kamzik>
 <Y1+OUawGJDjh4DOJ@zn.tnic> <20221031100327.r7tswmpszvs5ot5n@kamzik>
 <Y2K6clNJBn0SbWU+@zn.tnic> <20221103125945.lrr5oxxmylwpam53@kamzik>
 <Y2PX9GfxWYh6+XGT@zn.tnic> <20221103153404.uh77nrdkowrxj6cr@kamzik>
 <Y2PsvvOWVs9ZLBsp@yury-laptop> <Y2PxAiJ1yNzcUSgs@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2PxAiJ1yNzcUSgs@zn.tnic>
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
 Alexander Gordeev <agordeev@linux.ibm.com>, x86@kernel.org,
 Vasily Gorbik <gor@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <hca@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 openrisc@lists.librecores.org, Ingo Molnar <mingo@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, Thomas Gleixner <tglx@linutronix.de>,
 Albert Ou <aou@eecs.berkeley.edu>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Nov 03, 2022 at 05:49:06PM +0100, Borislav Petkov wrote:
> On Thu, Nov 03, 2022 at 09:30:54AM -0700, yury.norov@gmail.com wrote:a
> > Callers should pass sane arguments into internal functions if they
> > expect sane output.
> 
> What internal function? It's in a global header.
> 
> > The API not exported to userspace shouldn't sanity-check all inputs
> > arguments.
> 
> That doesn't have anything to do with userspace at all.
> 
> APIs exported to the rest of the kernel should very well check their
> inputs. Otherwise they're not APIs - just some random functions which
> are visible to the compiler.

Let's take for example cpu_llc_shared_mask() added by you in
arch/x86/include/asm/smp.h recently:

  static inline struct cpumask *cpu_llc_shared_mask(int cpu)
  {
         return per_cpu(cpu_llc_shared_map, cpu);
  }

It's in a global header and available to the rest of the kernel, just as
well. How does it check its input? Maybe I lost something important in
per_cpu() internals, but at the first glance, there's no any protection
against -1, nr_cpu_ids, and other out-of-range arguments.
