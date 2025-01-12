Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6BA1392
	for <linux-openrisc@vger.kernel.org>; Sun, 12 Jan 2025 07:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736666890; cv=none; b=PNsZa3m+7uRR5u3UpdHXE+8SvqkFtjadr5QP6JhSCeh0R28d4swNBDSoPq+vurlxsfKEZJ9+Q4CquQb/eMfa43GYz3LiHoZw58HPIS1UpjwF3WEgs6oPu567VBPyYG2qqXgczbwae+L9MO1N7rpKuzazSSmQvbPtDo/p8+ZJXBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736666890; c=relaxed/simple;
	bh=o6ZGT6CBMGLxPsjnBaLt5+HiCtXTZSF+pv2JYUQBwSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWUZ8eKheHwPPSeV80M/QPWAzb+hWjTrLrD5fzQC7sIQVeeitUEZUc1QNXwfZgL7PB5QzElLNQKib3q4e5IxZtgNFUmPvqPT7ewbX9crHKWvblnBbZ5Ws8G2T7v2i9J+4F+kEpL6oICrlG2VoToc2muazJd8RjzDDMRhJUl+Lo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNg1feC4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNg1feC4"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43622267b2eso35902025e9.0
        for <linux-openrisc@vger.kernel.org>; Sat, 11 Jan 2025 23:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736666887; x=1737271687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5yER+TlW19m5Ru/Rlv3btFxJectKr+d41tuVuk5R8PM=;
        b=FNg1feC4fMeVMqcU7u0IFOdsd0xEqCbgkVNM1rvxqe87wJIBOhulLvvKOl/WdWE0oQ
         AQpBKcngPo43vGR+HfEarQmnN25rx4WszE598aX31+PvAMYvrrKsmru2IQQdsmf223y1
         B61osMQ584UVK8eGFalTcaMnl6BjzIsFwcFZO6kv34KRkCezdMAofe6DST2wulwvAWsB
         VD/oCvNNaKU2XvE5hWZNgMINFA402F1Mtt3Rym3jEgnKHq7Dj12tnaKmjf5dPWcYlhYW
         NV6oTKzG+BkN3n324ztQWY8e5TEfce47S0NM9KzTnzhh2nA2n8mgNHt/M+9D/1Kh7zO4
         iHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736666887; x=1737271687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yER+TlW19m5Ru/Rlv3btFxJectKr+d41tuVuk5R8PM=;
        b=kLYXNZ8LcqlXpUAQJsFbYLVmctclVMRvISCFqdPD+YDVFWGxQHmLpZYJrgaQqESKBf
         fgyR6U2XEnkrxrPq1aTJu8YLyDu8GdqVBOWEBzUDdO/Cdceg3lZLuV49penNPgvQ5cMz
         wSFuytoqYPa7Ikyke06z0xJ+nQc7k0e8doOVNT7R6KAhqHcoRCfzKFWDxvE2WAET/WqB
         dNGOtMT6cIpY6wEzi4GC5JqNACDHR9w/n/fWakpWXCWicCQFZNJoXsGAPc7mOGCNnlj1
         +Cg3+h+5/6qneGfwzDr3imzFozY9mksDcNuJVNrj1xxrRi/CDFCYDgqMHvh0Cb79aKsV
         G03g==
X-Gm-Message-State: AOJu0YzPPsCyVfq3mTGOxSsbNTCAVdygUAmJtnYiqsc7pp2qimHN/Lfv
	kbl0RauXnU4ZaGk7Iv0LEsWV+O8SPBQqoIgFXUXj/XzEA1VOrA4dHdISpA==
X-Gm-Gg: ASbGncuy+eGMR95mE+sXiuaR8oA8wwUQ1DK+9YHY8RKOjXmmWz3NEu1UNgczep3nXWm
	Y8O5sBGdmeL611yfXhaqrah8AKdgMM+zrtVbciv1WRah6BImTXmRu8FKXMSyiEUMkSZerPEvYnu
	byX945vQjDZ1V19gxcb0soSWNe6tQlyuRIDpFvqEyIwBXNjKqBiYECoh7rcV7k/zB/3PaZtKgIS
	WBnvOFnhblsEVbReKwnt57xcK4CW/CwCh1tTOwgI7brjmXP2ub3tA5rYtZN8wKn4VqTDRdOVtpF
	DMUV6UxjUnfJ2HROjSI2
X-Google-Smtp-Source: AGHT+IES85iWqFcvkIqEK2XUU6TgPJnRWARRHzUO3ujKqDTcjcvl82FSEgqLOqIiERGb9F5OO3vuBQ==
X-Received: by 2002:a05:600c:22d2:b0:436:faeb:2a0b with SMTP id 5b1f17b1804b1-436faeb2c23mr3183545e9.15.1736666887289;
        Sat, 11 Jan 2025 23:28:07 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc08eesm139919365e9.10.2025.01.11.23.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 23:28:05 -0800 (PST)
Date: Sun, 12 Jan 2025 07:28:04 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: Contributing to OpenRISC Linux
Message-ID: <Z4NvBPYCkz12k0-1@antec>
References: <2613c1c6-2a2f-4ceb-8adb-f819961ec61f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2613c1c6-2a2f-4ceb-8adb-f819961ec61f@gmail.com>

Hi Sunil,

+CC List

yes, the cacheinfo task is still open.  There are many things that are still not
implemented in OpenRISC, you can always just look under the kernel
Documentation/features.

For example:

    < shorne@antec ~/work/linux > grep -r -e openrisc.*TODO Documentation/features | column -t
    Documentation/features/vm/huge-vmap/arch-support.txt:                |  openrisc:  |  TODO  |
    Documentation/features/vm/ELF-ASLR/arch-support.txt:                 |  openrisc:  |  TODO  |
    Documentation/features/vm/ioremap_prot/arch-support.txt:             |  openrisc:  |  TODO  |
    Documentation/features/vm/pte_special/arch-support.txt:              |  openrisc:  |  TODO  |
    Documentation/features/perf/kprobes-event/arch-support.txt:          |  openrisc:  |  TODO  |
    ...

How far have you come with OpenRISC so far?  If you haven't already I suggest
working through:

 - Get a simulator, I use QEMU for most development as it's faster and supports
   more memory than most FPGA.  Final verification can be done on an FPGA.
 - Get a working compiler toolchain.
 - Compile and boot the openrisc kernel.
 - Build a userspace environment, either buildroot, toybox or busybox.

I have some tools to help with this in or1k-utils [1], also there are prebuilt
environments and docs in the linux kernel [2] and qemu [3].

At the momoment, I am also thinking of what to work on next for OpenRISC, there is:

  - kexec
  - jump_label
  - kprobes
  - perf_events
  - ftrace

[1] https://github.com/stffrdhrn/or1k-utils
[2] https://docs.kernel.org/arch/openrisc/openrisc_port.html
[3] https://wiki.qemu.org/Documentation/Platforms/OpenRISC.

On Sat, Jan 11, 2025 at 05:51:17PM +0530, Sahil Siddiq wrote:
> Hi,
> 
> While hunting for project ideas related to Linux kernel
> development, I came across the "OpenRISC Linux Feature
> Development" [1] project on The FOSSi Foundation's GSoC
> page.
> 
> While I am not eligible to take part in GSoC, I am still
> interested in working on the tasks in this project. I
> noticed that progress has been made in adding rseq support
> [2]. However, I am unable to tell if progress has been
> made in the second task (reporting CPU details using the
> cacheinfo API).
> 
> If the second task is still open, I would like to give it
> a shot. I believe I'll get to learn a lot while working on
> this.
> 
> Thanks,
> Sahil
> 
> [1] https://fossi-foundation.org/gsoc/gsoc24-ideas#openrisc-linux-feature-development
> [2] https://lore.kernel.org/openrisc/20250110102248.3295944-1-shorne@gmail.com/T/#t
> 
