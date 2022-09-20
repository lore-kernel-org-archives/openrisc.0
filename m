Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262F9ECAAD8
	for <openrisc@archiver.kernel.org>; Tue, 20 Sep 2022 03:39:51 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 16C4624A2B;
	Tue, 20 Sep 2022 05:39:51 +0200 (CEST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by mail.librecores.org (Postfix) with ESMTPS id 64F3624A59
 for <openrisc@lists.librecores.org>; Tue, 20 Sep 2022 05:39:50 +0200 (CEST)
Received: by mail-ed1-f43.google.com with SMTP id b35so2050358edf.0
 for <openrisc@lists.librecores.org>; Mon, 19 Sep 2022 20:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=G999qRJ3ZYDAwyPJfqHMd90vcXhx8IHao6Ql7QiFPDQ=;
 b=a1adS1ECR642XvCjjjLjLzQ6JfBYYWC6Zjk4Ayb0GPq1HNHS6cqyiHrOVDg6U66sl0
 oRwS5IaWQZ+A5oOC1m7PxvHbKpXhbG7+ITj7+GYBrhpBh9xKw8vK67u8q6EX1Xki8DUo
 CDP74oWnx9ZaM60n/aZKsxAgdaJUVTWMaF9yFWNxcQkdtfYRxgwyEspizTHzaFbOCzgV
 ow1iuQ8bKgJYPcLGUqqzxM7BgkoIsKCZhQGQhb9cCsywveib9s1aSgybsdN2E41GWeXS
 rALuCfC8AzbIeVWaRYMIHWZdHmEgrfViS3GY5sZGLUldXsqTqQIWHrw+E1895ArI8ghu
 cFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=G999qRJ3ZYDAwyPJfqHMd90vcXhx8IHao6Ql7QiFPDQ=;
 b=TgUhihAoWGFiOZPawb7mBleTgtIiWHb6gmuxoFQ3luA2DrrPipRrxGuyv4YTQJdd6i
 WmjQksJ8RQc0e+BjamfKn2BdanZMUATRwN84Yu/m8EhRjZIvPZAQ2JHs+PIlQKlVIpNr
 wHhxzIV3oFwNsZrVKPo22JQPnrGwobTGXizsOO1/7F7FiXreJH4Np0QWwS206N5l+VmF
 H1RIpqUMEnmEroc0cglAckPHiBqnCBSNrHaJmM37JrexR9HqtLmiUcpyFT6qAWCAMoXP
 h/P3YV+4fvGZ617XfAFSqu4Y5RF2rS58+8SoRNXhrxMPNqk0vzZNTZCgDWfaOZIypoyP
 c5EQ==
X-Gm-Message-State: ACrzQf3S2pbxvl/M2fN05NtI6z7eNqRcOe4FfsAXwwDtXhEB5+6Vslgt
 AVYz2DipB4b+5o8nPZqocEp+Lt2zG6trvJQ2wMs=
X-Google-Smtp-Source: AMsMyM6UiGVnTD/J8ryFZQsJHTbdkIhpQZQxOdBwdC1toRqikXsXkHg47dV0ojfdIgLd8MUR/GxUavW0TPpgHSHF44M=
X-Received: by 2002:aa7:cb87:0:b0:43b:e650:6036 with SMTP id
 r7-20020aa7cb87000000b0043be6506036mr18386887edt.350.1663645189918; Mon, 19
 Sep 2022 20:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220822082120.8347-1-yangyicong@huawei.com>
 <20220822082120.8347-5-yangyicong@huawei.com>
 <302febae-508c-d73e-8676-d51752946645@arm.com>
In-Reply-To: <302febae-508c-d73e-8676-d51752946645@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Sep 2022 15:39:38 +1200
Message-ID: <CAGsJ_4ywwFJFi+q3Ra5UE3twzS9eExtvuXgoGK-8u4c1ZdXCBw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] arm64: support batched/deferred tlb shootdown
 during page reclamation
To: Anshuman Khandual <anshuman.khandual@arm.com>
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
Cc: wangkefeng.wang@huawei.com, prime.zeng@hisilicon.com,
 linux-doc@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
 yangyicong@hisilicon.com, linux-mm@kvack.org, Nadav Amit <namit@vmware.com>,
 guojian@oppo.com, linux-riscv@lists.infradead.org, will@kernel.org,
 linux-s390@vger.kernel.org, zhangshiming@oppo.com, lipeifeng@oppo.com,
 corbet@lwn.net, x86@kernel.org, Mel Gorman <mgorman@suse.de>,
 linux-mips@vger.kernel.org, arnd@arndb.de, realmz6@gmail.com,
 Barry Song <v-songbaohua@oppo.com>, openrisc@lists.librecores.org,
 darren@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 xhao@linux.alibaba.com, linux-kernel@vger.kernel.org, huzhanyuan@oppo.com,
 Yicong Yang <yangyicong@huawei.com>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Tue, Sep 20, 2022 at 3:00 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
> On 8/22/22 13:51, Yicong Yang wrote:
> > +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> > +{
> > +     return true;
> > +}
>
> This needs to be conditional on systems, where there will be performance
> improvements, and should not just be enabled all the time on all systems.
> num_online_cpus() > X, which does not hold any cpu hotplug lock would be
> a good metric ?

for a small system, i don't see how this patch will help, e.g. cpus <= 4;
so we can actually disable tlb-batch on small systems.
just need to check if we will have any race condition since hotplug will
make the condition true and false dynamically.

Thanks
Barry
