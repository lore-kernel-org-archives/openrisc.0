Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CC6ECAAD1
	for <openrisc@archiver.kernel.org>; Tue, 30 Aug 2022 14:20:27 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id D50B524841;
	Tue, 30 Aug 2022 16:20:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mail.librecores.org (Postfix) with ESMTP id 4B25E24130
 for <openrisc@lists.librecores.org>; Tue, 30 Aug 2022 16:20:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661869224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tORAGdOuIEyxqy7Xiz8FX0cV5xzTMMZWt6i8kmL4jMo=;
 b=OVTkcgM2M8kIQ5pYaFvUzz1zf8R1NPo15+nttQ4cFeIAGf9QTgcw1DLUYFcvUj871woSOS
 zA5TTXoxttbJMx6aBZ45Jw0XId82HHhIKAddd4WN79HlePK3++L98kO0bv9E9gLkSlxuF/
 HCa+4hCROueTArtPqVhQaLKl4WXdr80=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-l7kwZy8tMv2HEIQ0v8HnPw-1; Tue, 30 Aug 2022 10:20:17 -0400
X-MC-Unique: l7kwZy8tMv2HEIQ0v8HnPw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 897F1101A54E;
 Tue, 30 Aug 2022 14:20:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.123])
 by smtp.corp.redhat.com (Postfix) with SMTP id 8D16B492C3B;
 Tue, 30 Aug 2022 14:20:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Tue, 30 Aug 2022 16:20:12 +0200 (CEST)
Date: Tue, 30 Aug 2022 16:20:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: guoren@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/3] arch: ptrace: Cleanup ptrace_disable
Message-ID: <20220830142006.GA20935@redhat.com>
References: <20220830065316.3924938-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830065316.3924938-1-guoren@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
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
 Guo Ren <guoren@linux.alibaba.com>, arnd@arndb.de, linux@armlinux.org.uk,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 dinguyen@kernel.org, openrisc@lists.librecores.org, palmer@dabbelt.com,
 vgupta@kernel.org, sparclinux@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 08/30, guoren@kernel.org wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> This series cleanup ptrace_disable() in arch/*. Some architectures
> are duplicate clearing SYSCALL TRACE.
>
> Guo Ren (3):
>   riscv: ptrace: Remove duplicate operation
>   openrisc: ptrace: Remove duplicate operation
>   arch: ptrace: Cleanup ptrace_disable
>
>  arch/arc/kernel/ptrace.c        |  4 ----
>  arch/arm/kernel/ptrace.c        |  8 --------
>  arch/microblaze/kernel/ptrace.c |  5 -----
>  arch/nios2/kernel/ptrace.c      |  5 -----
>  arch/openrisc/kernel/ptrace.c   |  1 -
>  arch/riscv/kernel/ptrace.c      |  5 -----
>  arch/sparc/kernel/ptrace_32.c   | 10 ----------
>  arch/sparc/kernel/ptrace_64.c   | 10 ----------
>  kernel/ptrace.c                 |  8 ++++++++
>  9 files changed, 8 insertions(+), 48 deletions(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

