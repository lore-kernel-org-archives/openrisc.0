Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260D9ECAAA1
	for <openrisc@archiver.kernel.org>; Tue, 30 Aug 2022 07:33:54 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id EEE25248F5;
	Tue, 30 Aug 2022 09:33:53 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by mail.librecores.org (Postfix) with ESMTPS id C0F4A24310
 for <openrisc@lists.librecores.org>; Tue, 30 Aug 2022 09:33:52 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id bu22so12641618wrb.3
 for <openrisc@lists.librecores.org>; Tue, 30 Aug 2022 00:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc;
 bh=AkyiwZAyTL+qEnClAJjmshzXLVaiiWcOqi2bEVx9lPg=;
 b=aRJmmvilCx9hvnJwsqFDPwUjBgxD5a6DXdivTL+SL6hBqXqSgsQY6k4ALeR8FvREBs
 29wLOX4jEh7pKEjjJOucUsyR6KsAsGxnleJB90+lIKMn0lwehPN+a28RBx4XSP0JcCpb
 tP05S/5Bl9i9PsRfB/mpmNAHJebhPrkZO8+cqakoCF0UxM+jgP8F9hdJ7m0dJy9698Hk
 +ix5Kdnbdj6A9npKn848lfV0UW/d3if+lSSi0fLHWNgF4jDqVxiaJ2yKNijxt2ctV/jF
 s4qgeh3LyJrpPG0ORO8pKTQBjeYKw1FdHIWS+bg0J/Hp8DM6+qamo3RDZENkCPnTqP40
 OTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=AkyiwZAyTL+qEnClAJjmshzXLVaiiWcOqi2bEVx9lPg=;
 b=rDXoHdJUaYklv+PPtOWfIEHHeTQwQyDBZOPk+lRYermz/gI5y63J3sMlXdUgveW6LO
 hLn+c+40ZTsyvWH95GzLNP4/wY41wutU3jZeK5M58jvN8whXNZhaJBq6mUZP1t678LKe
 dR8S+a4VYbPgax8bRyhNovqERoGztNEE5TJApi9S2eKqJB5REA50QMKVcCyr6Xnh/7pD
 z/Qkf2bfDXa7u5tO65++98tHVDNZKC2aBqQuOktu4Itb6shLFzl3kCWEvixohlKRGrfp
 3Q7LY025D/D+CUIOx79pOmmH/6nTmvirv0lAWti1+aMuhqG9PTq/CxJoDcNVCof1c/dA
 IcdA==
X-Gm-Message-State: ACgBeo2dgp/5GjTu7WCLgDnOUJPjZ3QwN1toHLAS7jsY1Z9HgoRoz6NJ
 qs8uHVaakv61CINUpnktO9Q=
X-Google-Smtp-Source: AA6agR7M6K5NpAKHxyoBknJxWk60gWpGtre/xWrzuWyDehqu9BTVBu8aAalG/O21/110w8lPoNr+Bg==
X-Received: by 2002:a5d:59a2:0:b0:226:e6c3:a6c2 with SMTP id
 p2-20020a5d59a2000000b00226e6c3a6c2mr258841wrr.236.1661844832254; 
 Tue, 30 Aug 2022 00:33:52 -0700 (PDT)
Received: from localhost ([2a03:b0c0:1:d0::dee:c001])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a7bc351000000b003a5ee64cc98sm10920055wmj.33.2022.08.30.00.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Aug 2022 00:33:51 -0700 (PDT)
Date: Tue, 30 Aug 2022 07:33:51 +0000
From: Stafford Horne <shorne@gmail.com>
To: guoren@kernel.org
Subject: Re: [PATCH 2/3] openrisc: ptrace: Remove duplicate operation
Message-ID: <Yw29XwOoUY1Foze/@oscomms1>
References: <20220830065316.3924938-1-guoren@kernel.org>
 <20220830065316.3924938-3-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830065316.3924938-3-guoren@kernel.org>
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
Cc: linux-arch@vger.kernel.org, monstr@monstr.eu,
 Guo Ren <guoren@linux.alibaba.com>, arnd@arndb.de,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk, oleg@redhat.com,
 dinguyen@kernel.org, openrisc@lists.librecores.org, palmer@dabbelt.com,
 vgupta@kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Tue, Aug 30, 2022 at 02:53:15AM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The TIF_SYSCALL_TRACE is controlled by a common code, see
> kernel/ptrace.c and include/linux/thread.h.
> 
> clear_task_syscall_work(child, SYSCALL_TRACE);
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/kernel/ptrace.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
> index b971740fc2aa..cc53fa676706 100644
> --- a/arch/openrisc/kernel/ptrace.c
> +++ b/arch/openrisc/kernel/ptrace.c
> @@ -132,7 +132,6 @@ void ptrace_disable(struct task_struct *child)
>  	pr_debug("ptrace_disable(): TODO\n");
>  
>  	user_disable_single_step(child);
> -	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
>  }
>  
>  long arch_ptrace(struct task_struct *child, long request, unsigned long addr,
> -- 
> 2.36.1
> 
