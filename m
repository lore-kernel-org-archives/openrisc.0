Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559ED17BA6;
	Fri,  5 Sep 2025 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092612; cv=none; b=sP6AwFQjMqbRwt0ayjbllGqXxufL1YIc9b2tLHhdm/lQ6DcaHtxC8LJIFwJyKrA/KRt75pTdyDjK36dWQj3NZSWPkVlEElMIFlqSL2hvCE6+TfI5N3tHv1LpnJ0T2vWVeOK5tJZVPBjddZwWfHtYXJdjTUy2+nQohojpARTnTMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092612; c=relaxed/simple;
	bh=ouLB2GyNpB1Uz5P4xEJfwiUxaPqbq43VCk1TEm0nhd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTKD8nVk6KHcmPdtp56buvjRi3a0iCdat+YP9yDodqVxF4XvJsc7nXC4bNYJUYBSl/dXoKRqjyRDUlo+9j2I/njhdPM7DJvBauIQNN1zt+F+RvcTRIo6zQ05JyWlVLfNVw6qW+DGm4VxOAsZu2aaRL8A6Q8ZjC8a7QyhndjI3sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6Cf2eWq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6Cf2eWq"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so8820995e9.0;
        Fri, 05 Sep 2025 10:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757092609; x=1757697409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4JZXGZQK4+aPXzsNsXAjn+r0rkwVSB6hlGGc2MQLvZ8=;
        b=l6Cf2eWqT7lAc3JSluMAjIDxbklBGiaIEB89ODHKiG91AsgNLu7ruWuaM4hHk7ccTx
         iXEm+uaFQrHPB5B6gsfYcTqnEt7yEf8TAWSqbttZz6dl/QlAwTXUMVKFPN/DFKrhs483
         6IcsIyPhu24Grl/5qZOYRSE/TBRraR6Tzse3wyGD57HTxa2F1Ko1klfHgoQdmHsVvID9
         hr1fDzlVaNiAb3nRBgNSWdbcOZ/C0DaR8M5MalkGl7mvsHv8DWvzgCRAQYZnEJJQtzYZ
         xrEq5ZFkEyw4IIv/45y1TemrK6PG3BM84aEFXnYA5M8Is2YxPOXEjY9Vmuz43cxFm32g
         XvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092609; x=1757697409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JZXGZQK4+aPXzsNsXAjn+r0rkwVSB6hlGGc2MQLvZ8=;
        b=nzW4mITPkwEjbW0PJrMtMGZQYRDl390cNmPRQ4E2D668nvDTWEuFbqAOduOwIYea9F
         VBgNwLishMpgMMbKcJGbO0Y0b+R/TFbMKQCM0pua5lT88M44BEqKTrvcYFFNlSEm2j/l
         3ZqO6zn6K918cbutiXcZlTr6OrpZBkNeiGSOu+IuRl/kfKW5il1Y6Lofp+Y2HQJzc0u7
         0K3vP1KoPPYRnuWRYRyhya3i+hz6sXBV6zFnv1Y9QzE8Jp37Hp20K004wGyuFwZDS6h2
         cbAiN0kCYsuretkdhlixMSKlQ0u3zYF1eiLijsC8ghKpYHnaxwJK7pJTb3Ms12DTPA8Q
         aUUA==
X-Forwarded-Encrypted: i=1; AJvYcCU+AFYFYHYs3e0rgR/30bbyYvo7tudOVkmsaroFMFVpTKi5e18yVtIQZrJ2vFzXKVehRTo5yqRRqWLx7ehmgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeY9UVHMHy1PIvke5ognjmnWEhZKMEeTGo/1qwQcBZXuzzG5tH
	fJBAY72LLVYvi5maBtKwLkEMr3zjeDjs4zIqBbJcI+pQx5oDToB62bLTHEuJ6Q==
X-Gm-Gg: ASbGnctDfG6spe4sLZP1FaA3Zo2fU0i2EhJPm8HeRTDNurv4NTv1BBgvi0wfBIJarp3
	2zPGwr1kx6GMXjQ8YcSUr8AF4jNKYXUklQsVnH7Z1KOuvoiDABB2nkjYSh2d9YWdToy0XRve7To
	/z9a4nZuTaUc4+7Uu+FfQ7UwzxhHtcr9EZpGHfVcuI/bCq8wWt0fugOD5ZdB1Y8xn8b+QnngnLw
	z3lnvvBBswvM0lMVvAbxvEIqpoZG5u66VWqjzMs7w2QqAPThqrg/lHhQa5lE9bGECMYydOGyf+z
	v7MS8X+jymk8UPhFZrP1ynV1aKYJ+NatNCiIgcPZML7UvwMU+S86ZPdAQgzeEA4VA7iw/JGnVoh
	a8quDKlJzTXRQDvt+XEmKfsRDsw0gQeWs+zIfFG9eNZzP6XzNwVcH5ojZfo8LffOb6aE9M/BV
X-Google-Smtp-Source: AGHT+IGEPhI6d/AQJxAER2t/VYs0nTP+0MPnvNgN5uJkvZaFMSVMqNVMdiLO3Y1PoL7u/hCV77WqRA==
X-Received: by 2002:a05:600c:1daa:b0:45b:92a6:63e3 with SMTP id 5b1f17b1804b1-45dd5b68e02mr32053815e9.9.1757092608562;
        Fri, 05 Sep 2025 10:16:48 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e12444de96sm7187305f8f.19.2025.09.05.10.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:16:47 -0700 (PDT)
Date: Fri, 5 Sep 2025 18:16:46 +0100
From: Stafford Horne <shorne@gmail.com>
To: ChenMiao <chenmiao.ku@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] openrisc: Support basic trace mechanism
Message-ID: <aLsa_h00k8nOoZB8@antec>
References: <20250904100109.688033-1-chenmiao.ku@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904100109.688033-1-chenmiao.ku@gmail.com>

On Thu, Sep 04, 2025 at 10:00:48AM +0000, ChenMiao wrote:
> From: chenmiao <chenmiao.ku@gmail.com>
> 
> Hello everyone,
> 
> This implements a basic text patching mechanism and a complete jump_label
> implementation for OpenRISC. It should be noted that the jump_label have
> passed testing.
> 
> 1. Implement the patch_map interface and the patch_insn_write single insn
> write API by providing FIX_TEXT_POKE0. And create a new insn-def.h to record
> openrisc's instruction macro definition which only have OPENRISC_INSN_SIZE
> now.
> 
> 2. Support for the R_OR1K_32_PCREL relocation type is added for module insertion,
> enabling subsequent jump_label selftest module insertion.
> 
> 3. Regenerate defconfigs for or1ksim_defconfig and virt_defconfig.
> 
> 4. Based on the previously implemented patch_insn_write, achieve a complete
> jump_label implementation, directly supporting arch_jump_label_transform_queue.
> And add a new macro OPENRISC_INSN_NOP in insn-def.h.

Thank, this is looking good.  I will queue this soon once the final items are
cleaned up.

> Link: https://lore.kernel.org/openrisc/20250805084926.4125564-1-chenmiao.ku@gmail.com/T/#u

> Thanks,
> 
> Chen Miao
> 
> ---
> Changes in V4:
>   - Added testing for jump_label
>   - Split part of the jump_label patch content to form the third patch
>   - Implemented R_OR1K_32_PCREL module support for jump_label testing
> 
> Changes in V3:
>   - Removed the is_exit_text used, added some necessary comments.
>   - Modify some macro like __ASSEMBLY__ to __ASSEMBLER__ and ensure the
>     defconfig by make savedefconfig.
> 
> Changes in V2:
>   - Add a new insn-def.h to record the insn macro.
>   - Modify the patch_insn_write API from const void* to u32 insn.
>   - Using the modified patch_insn_write API in 
>     arch_jump_label_transform_queue.
> 
> chenmiao (4):
>   openrisc: Add text patching API support
>   openrisc: Add R_OR1K_32_PCREL relocation type module support
>   openrisc: Regenerate defconfigs.
>   openrisc: Add jump label support
> 
>  .../core/jump-labels/arch-support.txt         |  2 +-
>  arch/openrisc/Kconfig                         |  2 +
>  arch/openrisc/configs/or1ksim_defconfig       | 19 ++---
>  arch/openrisc/configs/virt_defconfig          |  2 +-
>  arch/openrisc/include/asm/Kbuild              |  1 -
>  arch/openrisc/include/asm/fixmap.h            |  1 +
>  arch/openrisc/include/asm/insn-def.h          | 15 ++++
>  arch/openrisc/include/asm/jump_label.h        | 72 +++++++++++++++++
>  arch/openrisc/include/asm/text-patching.h     | 13 +++
>  arch/openrisc/kernel/Makefile                 |  2 +
>  arch/openrisc/kernel/jump_label.c             | 52 ++++++++++++
>  arch/openrisc/kernel/module.c                 |  4 +
>  arch/openrisc/kernel/patching.c               | 79 +++++++++++++++++++
>  arch/openrisc/kernel/setup.c                  |  2 +
>  arch/openrisc/mm/init.c                       |  6 +-
>  15 files changed, 256 insertions(+), 16 deletions(-)
>  create mode 100644 arch/openrisc/include/asm/insn-def.h
>  create mode 100644 arch/openrisc/include/asm/jump_label.h
>  create mode 100644 arch/openrisc/include/asm/text-patching.h
>  create mode 100644 arch/openrisc/kernel/jump_label.c
>  create mode 100644 arch/openrisc/kernel/patching.c
> 
> -- 
> 2.45.2
> 
> 
