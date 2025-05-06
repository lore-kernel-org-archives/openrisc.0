Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F23198A08
	for <linux-openrisc@vger.kernel.org>; Tue,  6 May 2025 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543801; cv=none; b=m+bU6w2R9Yzs7glh4DwTWZlFvBQSYpL1E/r0/S+hwnin7kCG7ezuWUvhPzyFeCK/y1opYZ8CgZalOdGUt2g4s6oz0IXn8feovcNtZ7Mmj6OqxTMeiRC4OdxZu/umnz77K1WoSsT9/APzHS/BmEIn5P2R1ly1mZPo8cPm8NdLPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543801; c=relaxed/simple;
	bh=v/rCNExFjBDC9VXJLnuVqhiejWy5wGuCTNBRch6QXw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se2fC2b1RocsX9bQcV4wIyfXOQ1Hrz2akwuZ2wMz5h5LRDgZbvi1krOM+tlAGVq0f8YsJ02frWDDdM23raKfwjnd/ckSSAEEmvWUHMmhWsYShPtvD1E87oQSlXlIprGe3dkhuFohZ8VJG/vMBGJaNGvqvJC7b68cMvfW7VY5te8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHx/HUM/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHx/HUM/"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d0782d787so36636695e9.0
        for <linux-openrisc@vger.kernel.org>; Tue, 06 May 2025 08:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746543798; x=1747148598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=shTPvane9vm6SO7qcuRtCWFmcr5P9BtuHlBkNOksZh4=;
        b=eHx/HUM/O1PQbymzQIAzSE76tpDo6QAVAnsQYTf9cIII7nqCsYx3y0RS+V5mhJCmsv
         8tFc22og+kocn7R529Fvhyfr3Q2TaOySM8zXw1g7s8rBDrNe97ceU4Bk9k2CziwMH3my
         pN4XcE6KuQPtlUM7oD6CkV/oN4+ZfxQvjPFcCd5KKMUPLtILBtJEEiwjNvD6B2sBcXzb
         zmHoaW2BnHOpbAW3oC+OyCq5ukYg96//E657wrDHE0bbLLFBmON27Zbc87zLrZZ7YyPd
         SwH+9moPXUtWwTsoORw+TQjzN7kp1s7L3YYXCbB2AxM+es7A7BlMw6cUIsKIHRDqb2x/
         do2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746543798; x=1747148598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shTPvane9vm6SO7qcuRtCWFmcr5P9BtuHlBkNOksZh4=;
        b=aIWkPxtfe4FhYuopYN9QZSwcNV5yYuCEU7v9WeL8nVkj3Fnkd4fsYF9AfQwak+T0D+
         8R6Kr3yGplLNbceMw5L34lPnGpAuMf0X1KJA6VcaIK87fdZWYwjbtMiJ9eMbFkHo3UNL
         VSz3QsmUMDsIaF9/Fyruk1RvBLlSgTWPVWOIqnCh7CyK9+cNg70Ieo5RTOljy0Tzf8OE
         FzBqZXZPnVF14WztXt4QYW6kzygiH0T0g9aLDSfj5PT8vkasZX9d+GxJkMlbJnEk06bi
         KCDJGEN0bddSTZzNGRNkWlLPLZ6M5/zbt7NLnAoTyE7lcgwMiTtJ8sGzt2kyXZAnkNUa
         hoVA==
X-Gm-Message-State: AOJu0Yyl4G7QrU9VLfBttHXYy2swmFzeCrGcxRok7jSeH2eZRNBrlq3I
	J4zoZrtbGZgMRXfMfUO67DU7QqaRMHeM6GknTvXEKRXaFGAXmJyS
X-Gm-Gg: ASbGncuS55iR5iMUXi8IpMj4pM6tFfMHiF/zOiPmj5scrVzgtOiA+IPS0iPqowGrKFt
	6IulGNKxzEQlpY3Wr7AKgvsjh/i7JAiZeZcrqlg42AP0lIWYBkcIun+m+O1DdcrNWU7VBvq5Qce
	x85IfiOh35nMmTyAsmjAU9adiXjT2n4cErXBIGm2BEKIjotD+Qb1ZW8KSUaNFaK7Pq5HPye32qG
	KtlGOk7jxX0UAoLF+icMmRsDUdjdmAuAJ3AMRhtXDjaaExXw9C7Hu2rLM6CzvHYeoJC6ck0/i0C
	RcQlndZ1GEOtX7Z1CE+vJg2iWnoGKaxR7O6NpRgdVB2i+1HQX59gyUkaSASj27V6fOfza99XsI/
	Ert4gKgLTa2hGCm4=
X-Google-Smtp-Source: AGHT+IEhUwc3mkM3B45hI+Gqx4jRwKg2zodY8a+am2Rrp3FHN0may5mOl7L0BFYFc6hF0SOk2R7OvQ==
X-Received: by 2002:a05:600c:8283:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-441c49483f8mr116731615e9.30.1746543798299;
        Tue, 06 May 2025 08:03:18 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89ee39esm171547405e9.21.2025.05.06.08.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 08:03:16 -0700 (PDT)
Date: Tue, 6 May 2025 16:03:15 +0100
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: Queries regarding ftrace's implementation for OpenRISC-linux
Message-ID: <aBoks-Muf4CxQvhv@antec>
References: <e9f74ae6-10f3-4585-b727-928bb5749dd9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9f74ae6-10f3-4585-b727-928bb5749dd9@gmail.com>

Hi Sahil,

On Sat, May 03, 2025 at 09:44:54PM +0530, Sahil Siddiq wrote:
> Hi,
> 
> I have been looking into implementing ftrace for OpenRISC-linux. Based on what I have
> understood from the ftrace design document [1], mcount will have to be implemented in
> the kernel for ftrace to work.

Thats right.

> While this document is outdated, I did come across an article in the Linux Journal [2]
> that explains the use of fentry instead of mcount in the implementation of ftrace. It
> states that fentry is a powerful alternative to mcount. To make use of fentry, GCC's
> -pg flag needs to be used along with the -mfentry flag. Simply calling -pg results in
> mcount being used.
> 
> Should it be possible for ftrace to make use of either option (fentry and mcount) when
> implementing it for OpenRISC? Or should it only use fentry (or mcount)? mcount still
> seems to be used in other architectures (I have only checked MIPS, RISC-V, LoongArch
> and ARM so far).

I think we should stick to mcount for now.  As I understand fentry is mainly and x86
feature now.  We should be able to get it done with mcount, as you say that is
what is what is used by other architectures like riscv.

Another point is that for ftrace to work it uses a kind live patching [1] to turn
the mcount calls to NOPs when the kernel boots up.  Then when we turn on tracing
the code is patched to enable the mcount call.

This live patching covers:

 - kprobes - adds single instruction break points into kernel code
 - static keys - allows for static branches, i.e. the check for cache enabled can
   be done once then code re-written to to make certain checks go away.  We
   could use this for cache availability checks.
 - jump_label - low level support for code patching

I think before going to far with ftrace we should look more into OpenRISC's
roadmap for all of these.

[1] https://docs.kernel.org/livepatch/livepatch.html#kprobes-ftrace-livepatching
[2] https://docs.kernel.org/staging/static-keys.html

-Stafford
