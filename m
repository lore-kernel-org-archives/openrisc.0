Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC31C4167B
	for <openrisc@archiver.kernel.org>; Thu, 29 Dec 2022 16:22:31 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 207F224B95;
	Thu, 29 Dec 2022 17:22:30 +0100 (CET)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mail.librecores.org (Postfix) with ESMTPS id 64D8B248FB
 for <openrisc@lists.librecores.org>; Thu, 29 Dec 2022 17:22:28 +0100 (CET)
Received: by mail-pf1-f169.google.com with SMTP id x26so6691714pfq.10
 for <openrisc@lists.librecores.org>; Thu, 29 Dec 2022 08:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to; bh=PMNgd8bQDMgdEx3QpMo3jWGl4T1DZKXjFMtqF5doPS4=;
 b=qXEmllgjQDDILSAqKv5rHoGkicbo4R4i0RBYCEbuy5JWCS9/AA+DWTMXLQgqDAappW
 903kwqubN40SB2KttGjjG54UgZAHr5bwFbysTxqCEokE3BNB09i/uefHEDV0SvFj1/tu
 1Lu+CFCesVDE+jl4EXnA8KkiboPktg6mieeJ7onX1tkrVdG7KvaiHAaOG9gcqJyJPbGd
 pCkV7szyzafl528HANkkvX+fSJQQtn4lOJvi8JPHEP8zM7yI6lOkG51EtxjdpiS6qS6y
 bkQ9rcSKWrjbuS7i9mSjttcyHwgDwy/ruAPC9lLbcJkXlwaOVpsqeXNx1gIuMeQUkJfm
 MIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMNgd8bQDMgdEx3QpMo3jWGl4T1DZKXjFMtqF5doPS4=;
 b=Anh5qEYGVU4yhwM0oxX7mVXDuB5EnFekhAO9KUF0eTmlbqnLPw/JPekjH0R8T8PSOD
 Cpb4tED4f86QUt6KOdLAJ3IkJ4c5xM5tOfefjuf9snRx3ODHd/BLfwoaMt1ruoenERyT
 5HvezQKpUtDh7KP9YguR9aiAeSH7kqt4FUXR4AXgbDj/nSx6om2yq7IXx7xk8Lk9rHkH
 0OszEmMDfcW4mTIGeNME8FKq3bWEXd4MSxM0iPV+1RakuJoI6UKmFfUDFLxM1gBhvfvt
 CRKNAp5VGMfbE54U9ar92YA0B6kP0cbzJAuuDmJcBmL9c6Q6a5QJC/H2y/mvN2586ihE
 ZHpA==
X-Gm-Message-State: AFqh2kqls0oGAJmAMtWPk6cvELEuFJfTBeba6k5hEZUX0KXDfhEF6oxS
 jEPhnpUUG095PocLXTuS0g/c6g==
X-Google-Smtp-Source: AMrXdXtoQHTvZGkC4TohzHT3/NWYHx9KB7DMUUCuZrQkc/ivfhp4AP56ANclvtUxYpd25RIK3u76xw==
X-Received: by 2002:a05:6a00:1c92:b0:576:f322:419f with SMTP id
 y18-20020a056a001c9200b00576f322419fmr28959611pfw.28.1672330946621; 
 Thu, 29 Dec 2022 08:22:26 -0800 (PST)
Received: from localhost ([135.180.226.51]) by smtp.gmail.com with ESMTPSA id
 l190-20020a6225c7000000b005771d583893sm12598441pfl.96.2022.12.29.08.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Dec 2022 08:22:26 -0800 (PST)
Date: Thu, 29 Dec 2022 08:22:26 -0800 (PST)
X-Google-Original-Date: Thu, 29 Dec 2022 07:53:49 PST (-0800)
Subject: Re: [PATCH 13/19] arch/riscv: rename internal name __xchg to
 __arch_xchg
In-Reply-To: <20221222114635.1251934-14-andrzej.hajda@intel.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: andrzej.hajda@intel.com
Message-ID: <mhng-8937d883-402e-4523-a023-8171ed0e386b@palmer-ri-x1c9>
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
Cc: mark.rutland@arm.com, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 peterz@infradead.org, dri-devel@lists.freedesktop.org,
 linux-mips@vger.kernel.org, andrzej.hajda@intel.com,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, boqun.feng@gmail.com,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 intel-gfx@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, loongarch@lists.linux.dev,
 rodrigo.vivi@intel.com, andriy.shevchenko@linux.intel.com,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, 22 Dec 2022 03:46:29 PST (-0800), andrzej.hajda@intel.com wrote:
> __xchg will be used for non-atomic xchg macro.
>
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> ---
>  arch/riscv/include/asm/atomic.h  | 2 +-
>  arch/riscv/include/asm/cmpxchg.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> index 0dfe9d857a762b..bba472928b5393 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -261,7 +261,7 @@ c_t arch_atomic##prefix##_xchg_release(atomic##prefix##_t *v, c_t n)	\
>  static __always_inline							\
>  c_t arch_atomic##prefix##_xchg(atomic##prefix##_t *v, c_t n)		\
>  {									\
> -	return __xchg(&(v->counter), n, size);				\
> +	return __arch_xchg(&(v->counter), n, size);			\
>  }									\
>  static __always_inline							\
>  c_t arch_atomic##prefix##_cmpxchg_relaxed(atomic##prefix##_t *v,	\
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index 12debce235e52d..2f4726d3cfcc25 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -114,7 +114,7 @@
>  					    _x_, sizeof(*(ptr)));	\
>  })
>
> -#define __xchg(ptr, new, size)						\
> +#define __arch_xchg(ptr, new, size)					\
>  ({									\
>  	__typeof__(ptr) __ptr = (ptr);					\
>  	__typeof__(new) __new = (new);					\
> @@ -143,7 +143,7 @@
>  #define arch_xchg(ptr, x)						\
>  ({									\
>  	__typeof__(*(ptr)) _x_ = (x);					\
> -	(__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr)));	\
> +	(__typeof__(*(ptr))) __arch_xchg((ptr), _x_, sizeof(*(ptr)));	\
>  })
>
>  #define xchg32(ptr, x)							\

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks!
