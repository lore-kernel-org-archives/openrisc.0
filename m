Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96522C3A5A3
	for <openrisc@archiver.kernel.org>; Fri, 11 Nov 2022 10:17:13 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 1E15D24A91;
	Fri, 11 Nov 2022 11:17:12 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by mail.librecores.org (Postfix) with ESMTPS id 8245824130
 for <openrisc@lists.librecores.org>; Fri, 11 Nov 2022 11:17:11 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id v1so5820832wrt.11
 for <openrisc@lists.librecores.org>; Fri, 11 Nov 2022 02:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:user-agent:message-id:in-reply-to:date:references
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BH/APi1a0PoKAJZknP8AkAonpu9TnXBBnNUq+HUkcwM=;
 b=4oOscMH7jU6ury8coe6FqLy7zK1XZNinWBvFR7izLUhT8UO+Uf7A34vnnALOX+0uZw
 6u0BzpFG7Xf65rlpJuAvjMgTNhVx/gSKcxgRlSDN2zH7W+6LI6BnNcuT8FnlleBan74e
 U+nnWKJgynFDrs5h1v4LHjxM1v+N8pvPWTcuhFJiAYBmZcFqEaaRiyqBxAjt+VLKVj27
 ymKqo1xHrZ7qEJ3SsTyk8ixNapD9K4j74hbbeGy2nwxMGfxLNJInz1YB3DFYiKEqav4a
 oeGBzhxJPbF4jd3XpyzDJKvMeI1dC4S63nsd7WzmmwS7/SrtVuS1+i59tvEjxRd8GW0+
 CSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:user-agent:message-id:in-reply-to:date:references
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BH/APi1a0PoKAJZknP8AkAonpu9TnXBBnNUq+HUkcwM=;
 b=Jfs/QZvI2iSs319Z5yA6wY2fia3v1oUbBIAW4hTfi4ReXz1JeBMlwnqorrPIofKoQ/
 0o2Xz0znxiL9Txfej9jCLT9PMlRi5I+5KNSjIGucOWXGMmdVCCwomTZrPO6a3NaOPM+6
 6VWKPvARKoksyhrTtxq05z0pOjUzB5aPHptd4nGAtH4xHsM36NMZyrdVa+icAJeHt8dX
 QON9+tlfLXJL6iVNpAGgxW7C3aH+GpgOzw31t0kJKJVsOOcjcOLzca2PoSaQGRQ/On6I
 kC9kqjte6U6CEiyl6d8X9M2him+081rkKbtnnU9XjWAiebaFh7dBUNoUe5xi7kn4HiCr
 1tgg==
X-Gm-Message-State: ANoB5plI5hc2JSwygVnavSmnK+0luxo/muGbg43Z4+ksEbtYLi+tbF/i
 V44sTwbg5CVj9AvvpiSm81NObg==
X-Google-Smtp-Source: AA0mqf4pSdxpuNsvbAiQ/VPT4Uicb2yIOEyOj0DptBJEnqY46AvxjvE1jv4RoOcak7HL0HGEg3fM1Q==
X-Received: by 2002:a05:6000:18cc:b0:236:6d79:b312 with SMTP id
 w12-20020a05600018cc00b002366d79b312mr805921wrq.699.1668161831083; 
 Fri, 11 Nov 2022 02:17:11 -0800 (PST)
Received: from localhost ([95.148.15.66]) by smtp.gmail.com with ESMTPSA id
 h8-20020a05600c2ca800b003b4a699ce8esm8500043wmc.6.2022.11.11.02.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Nov 2022 02:17:10 -0800 (PST)
From: Punit Agrawal <punit.agrawal@bytedance.com>
To: Yicong Yang <yangyicong@huawei.com>
Subject: Re: [External] [PATCH v5 0/2] arm64: support batched/deferred tlb
 shootdown during page reclamation
References: <20221028081255.19157-1-yangyicong@huawei.com>
Date: Fri, 11 Nov 2022 10:17:09 +0000
In-Reply-To: <20221028081255.19157-1-yangyicong@huawei.com> (Yicong Yang's
 message of "Fri, 28 Oct 2022 16:12:53 +0800")
Message-ID: <87pmdtztga.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: wangkefeng.wang@huawei.com, prime.zeng@hisilicon.com, realmz6@gmail.com,
 linux-doc@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, punit.agrawal@bytedance.com,
 linux-riscv@lists.infradead.org, will@kernel.org, linux-s390@vger.kernel.org,
 zhangshiming@oppo.com, lipeifeng@oppo.com, corbet@lwn.net, x86@kernel.org,
 Barry Song <21cnbao@gmail.com>, arnd@arndb.de, anshuman.khandual@arm.com,
 openrisc@lists.librecores.org, darren@os.amperecomputing.com,
 yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 guojian@oppo.com, xhao@linux.alibaba.com, linux-mips@vger.kernel.org,
 huzhanyuan@oppo.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Yicong Yang <yangyicong@huawei.com> writes:

> From: Yicong Yang <yangyicong@hisilicon.com>
>
> Though ARM64 has the hardware to do tlb shootdown, the hardware
> broadcasting is not free.
> A simplest micro benchmark shows even on snapdragon 888 with only
> 8 cores, the overhead for ptep_clear_flush is huge even for paging
> out one page mapped by only one process:
> 5.36%  a.out    [kernel.kallsyms]  [k] ptep_clear_flush
>
> While pages are mapped by multiple processes or HW has more CPUs,
> the cost should become even higher due to the bad scalability of
> tlb shootdown.
>
> The same benchmark can result in 16.99% CPU consumption on ARM64
> server with around 100 cores according to Yicong's test on patch
> 4/4.
>
> This patchset leverages the existing BATCHED_UNMAP_TLB_FLUSH by
> 1. only send tlbi instructions in the first stage -
> 	arch_tlbbatch_add_mm()
> 2. wait for the completion of tlbi by dsb while doing tlbbatch
> 	sync in arch_tlbbatch_flush()
> Testing on snapdragon shows the overhead of ptep_clear_flush
> is removed by the patchset. The micro benchmark becomes 5% faster
> even for one page mapped by single process on snapdragon 888.
>
> With this support we're possible to do more optimization for memory
> reclamation and migration[*].

I applied the patches on v6.1-rc4 and was able to see the drop in
ptep_clear_flush() in the perf report when running the test program from
Patch 2. The tests were done on a rk3399 based system with benefits
visible when running the tests on either of the clusters. 

So, for the series,

Tested-by: Punit Agrawal <punit.agrawal@bytedance.com>

Thanks,
Punit

[...]

