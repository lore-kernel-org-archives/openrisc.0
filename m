Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B9B3C5558
	for <linux-openrisc@vger.kernel.org>; Fri, 10 Apr 2026 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775828411; cv=pass; b=iuyLZMOM6elJWZiXoPMD+V5rhzNsrzYnRmd6Xxqjc6FRUhlEoY2OeZBm/wEW5LoPmqjkZHhZ0vZRR5zJAUn0/MVDhMpoU7HYrD8Swgw9CnKbfyjPDjaUEMnm2cTfyEjFqAXqV6jE3bNZL+hFlJFMTrkf/NtAJ53/aCl0nXz2wKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775828411; c=relaxed/simple;
	bh=LSR04DrYd2CNPoGkLuzcgQfT1tMVn5ZfdEM6iihG19s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obs8HteX9wjK7FNsnuUkr6MHsAmzBo2q37gI1xmG8O8uCgcGZjbVC0IZTwykbYgXiN+slK/N4cgtMqkuokLsieZON6CuuJaeH8p+YMJga0Ijf4/C9afUxW+XXRt8qHaVa3agI2OrzboLyL9BRmmdobpyMrIjH7XV3Bcgm1eAXwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hQz2S2eA; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQz2S2eA"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1279eced0b9so3035220c88.0
        for <linux-openrisc@vger.kernel.org>; Fri, 10 Apr 2026 06:40:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775828408; cv=none;
        d=google.com; s=arc-20240605;
        b=SNUtby4dgupC0JF0wfvH9O7D3mQ9zBjUwauISBbSratum4nznDQJy/l1v3cR3zBm3/
         R9zFADyGtzA6J4m3Ui2y1oTidSInS1CHZh04mbUNJOtGrUlDogbo+5a8tRWOQnUCd/SN
         6pOInHvrkSEvN1QW5d+ZP8Botssz61pv69+y3ZqlKWgF4EnKkjiAmHM385bkb9F24ZeG
         fcuHTzAt3SNJcEDGHGXe9qVXnLo+136DAIHOp4FhjX/rdrvcgFNF3K8r1o9rtCzuXAdf
         1U+6WwxL79sQafKMXDB9vSxoDXDtWdWwxhOEKxc1ua2fogZi5kXh5HwYkyWNLBztY0hg
         1ouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iCXB7w7ko4o+lkpt1Tfr/OwLPxl1m2l/vGRhYm7vF9w=;
        fh=vWQhIh2yKyFm7K6OefGUSoxDYZJj56eDFfymZyDbYfY=;
        b=IGfZjV5+L34P1bbc15Qmm/7yFjJK7ND3NlpVKaVOq2LPGxUjijhmXZOOElnzDer2/1
         Qhh2v1+uCbCoRHdyOScNMSGwbm4FBQKb39qblsLXkMYG78VkxLsfYYuluJiNgMgcgKyw
         ZPNpoW9HDnfdmMKey2njt/u3VJXk/7m3HsF142EB6CaFPQDr92QPN5NBZO4s6gzBfGcz
         uyP0+HZAKpQxmzRRFFAQiGPnuGumfcojVJC0fUTtaH0pN6OfVT6mOMBNBpgsDZ67Vd22
         b0CHjPFwkosk0L9xVPSKQ9bU/g1CfVE/ZurBOBWMNSyetkqvAP4AXsHyX7N8Fsxov0Qi
         vfZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775828408; x=1776433208; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iCXB7w7ko4o+lkpt1Tfr/OwLPxl1m2l/vGRhYm7vF9w=;
        b=hQz2S2eA6fQgX48yk+tCvNgyGHkH3in9ICr9R3nNckPAigBowZqMfigKifcIhzYpCM
         Q+/YIz+ysefRWSUnNmhglkj0Uhveycw+tEIWYFQHXT9E/nijwSZWr1cQc+EZruQV8Nqi
         QlM5/4ipSL9yaXfzuXui19XftHId/rwiyyNmw82ZK3yAYnqe2Jsfa8+R82+XyDhnQS3w
         +8Ezg845wN/IHF1oYswYrjIG7lZ4ovtGU2QXhbAMZuo6Qlo9MMBbjDUDxglBQyOFbF9M
         eRD8OEU1VW9NMn724QtVr84bSl+ZKF7XRo5VntGTmOidFOeqDYcwXhUTx6IDcDAt/NAr
         x57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775828408; x=1776433208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCXB7w7ko4o+lkpt1Tfr/OwLPxl1m2l/vGRhYm7vF9w=;
        b=CKwaiGeufAy5Arl8EeWqlXpWbkRmckAvhi8G6WSmTNNHpcRKRv7iyjkHacP/+lpKex
         cl6ArPZk/FdwKj+ocYPVmoFDpcAskEi9CZvg0umRuVtHVyqtsMx2PpCdrOWsN/wgocZt
         Aer9A5Db3S7OWSqTwfMxZERHGd7WcJHn/67+hNpIXB2VmTAUaGS/ZEWHJREKdJLMyTmf
         JePuQRKFWHueZ1eQoCfDp6J6F7ZnjE04EPkokp0Vt3I9YOtjUs/XgNRpZh+XjBeYhZIl
         yVNDbYnjXP0UIlERRXbysKP15VkjYdkmhROIKyOl9bQrXEmASZqLHoYAJUhlqCllnG6A
         nGFA==
X-Forwarded-Encrypted: i=1; AJvYcCV0XKgTPjv82OHAXwjRXFluEXnv3iiN7CpY9U7FwPYNnK/iMfr4NUUY1NwxKqlyNd4iJEDSjFAOKwQ9IZfQzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4sGYazi7CJAqQYh4RHWmx8EkLr7J3tw8Y8QF1ZvT/TFcyHd1u
	B9NenZ2FESKZbreMUKzFdK26T+hMPIuWGJ2g34va6Tr4V1SHwDagG+Yok7TAwzt6Cy+wfsgICnt
	5+HZAMDCn0xGoDYnq6q6iG8UkBNFEwCt05VA9tVWL
X-Gm-Gg: AeBDievT3BCevJ+jK2TCxP3/x9+JziPJ8dG4Hchrx9yRMH4baVFFF9eZlMEe9Yz2cCM
	pl2TsPkxI0N8/i6G+xqCBXtY04W0FOlPF0ErJX3UBD8Cz0M5U7fNSgKV2f9bVH9+0/YfF6KXPN6
	OiXD1rG3FnWTNaLuBsoXIOuVK1rjp6vQH2A3zBk/sztT6IzAKnx6AN/2bgJ1vStBsgfGsn4U28T
	M/SU4hOcGy8ZWUfnprMvYO2ha934c2KFAQ1/yOzZrdYPsjTSONRJ3+BbFHRBM0Avxs8Wdbqp9CI
	xIy4e5Rxoe75DynNPrdRsmi/JVi+Ff5lVrOtOxS5vpxez17S
X-Received: by 2002:a05:7022:fa04:b0:12c:2ed4:62fa with SMTP id
 a92af1059eb24-12c34ef907emr1882312c88.32.1775828406651; Fri, 10 Apr 2026
 06:40:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120318.862164111@kernel.org>
In-Reply-To: <20260410120318.862164111@kernel.org>
From: Marco Elver <elver@google.com>
Date: Fri, 10 Apr 2026 15:39:30 +0200
X-Gm-Features: AQROBzBE-9UxDQG5mMJLgipEeL_Y5pwE-Y_PUrJGxDBLilqBu51b8lLzxdip708
Message-ID: <CANpmjNO1vsO1LT6xijhz3nsjQa+_A=9omfgOSz=aGn293-LqTg@mail.gmail.com>
Subject: Re: [patch 19/38] kcsan: Replace get_cycles() usage
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
>
> KCSAN uses get_cycles() for two purposes:
>
>   1) Seeding the random state with get_cycles() is a historical leftover.
>
>   2) The microbenchmark uses get_cycles(), which provides an unit less
>      counter value and is not guaranteed to be functional on all
>      systems/platforms.
>
> Use random_get_entropy() for seeding the random state and ktime_get() which
> is universaly functional and provides at least a comprehensible unit.
>
> This is part of a larger effort to remove get_cycles() usage from
> non-architecture code.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: kasan-dev@googlegroups.com

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  kernel/kcsan/core.c    |    2 +-
>  kernel/kcsan/debugfs.c |    8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -798,7 +798,7 @@ void __init kcsan_init(void)
>         BUG_ON(!in_task());
>
>         for_each_possible_cpu(cpu)
> -               per_cpu(kcsan_rand_state, cpu) = (u32)get_cycles();
> +               per_cpu(kcsan_rand_state, cpu) = (u32)random_get_entropy();
>
>         /*
>          * We are in the init task, and no other tasks should be running;
> --- a/kernel/kcsan/debugfs.c
> +++ b/kernel/kcsan/debugfs.c
> @@ -58,7 +58,7 @@ static noinline void microbenchmark(unsi
>  {
>         const struct kcsan_ctx ctx_save = current->kcsan_ctx;
>         const bool was_enabled = READ_ONCE(kcsan_enabled);
> -       u64 cycles;
> +       ktime_t nsecs;
>
>         /* We may have been called from an atomic region; reset context. */
>         memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
> @@ -70,16 +70,16 @@ static noinline void microbenchmark(unsi
>
>         pr_info("%s begin | iters: %lu\n", __func__, iters);
>
> -       cycles = get_cycles();
> +       nsecs = ktime_get();
>         while (iters--) {
>                 unsigned long addr = iters & ((PAGE_SIZE << 8) - 1);
>                 int type = !(iters & 0x7f) ? KCSAN_ACCESS_ATOMIC :
>                                 (!(iters & 0xf) ? KCSAN_ACCESS_WRITE : 0);
>                 __kcsan_check_access((void *)addr, sizeof(long), type);
>         }
> -       cycles = get_cycles() - cycles;
> +       nsecs = ktime_get() - nsecs;
>
> -       pr_info("%s end   | cycles: %llu\n", __func__, cycles);
> +       pr_info("%s end   | nsecs: %llu\n", __func__, nsecs);
>
>         WRITE_ONCE(kcsan_enabled, was_enabled);
>         /* restore context */
>
