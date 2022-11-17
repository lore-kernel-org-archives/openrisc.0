Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB63C433FE
	for <openrisc@archiver.kernel.org>; Thu, 17 Nov 2022 14:24:18 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 445FB20CD6;
	Thu, 17 Nov 2022 15:24:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mail.librecores.org (Postfix) with ESMTP id 14FE220CD6
 for <openrisc@lists.librecores.org>; Thu, 17 Nov 2022 15:24:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668695055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nZPY6OJIRrwMZkBLytVOAK+0kIpEYMOqoTEpl19M6ws=;
 b=Jim0yvnQUkfXa64i8eZLemC9LJf1QHjxQQV0Q70jQsvjkgaHl2AN9g66wz2Hu/U+Y/Emqo
 u0kCZ8AH/Rzo0Vpkr6qIg3T29efgnSzuE5EgSqUEXSQ79Nf4MoiKgfIkuVOXe2pxojUFVH
 Fg9w20Aj1hhWTn39TXsYQ5VqoAOLzaY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-536-QgmVzgZnN_eJzXRC9i2Drg-1; Thu, 17 Nov 2022 09:24:11 -0500
X-MC-Unique: QgmVzgZnN_eJzXRC9i2Drg-1
Received: by mail-wr1-f72.google.com with SMTP id
 i12-20020adfaacc000000b0023cd08e3b56so767312wrc.12
 for <openrisc@lists.librecores.org>; Thu, 17 Nov 2022 06:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nZPY6OJIRrwMZkBLytVOAK+0kIpEYMOqoTEpl19M6ws=;
 b=FKbsrLXv3gRIIQ67WVotIZf5zOohbRb0mlpbBezOAQwf+eyGkXuqyMtLIaKUdP1qDF
 ceaWcxKDXxi4QNhWE7acQk/IwXDFhONeohooxWOOyQF9C4cD8x0hpfzNbD0I+cn6s9+k
 jIGpKd48qwiRDu6Q1uYKBeB0IxxJE/9t9LF6LZfibTYn6Y+J9Dqe+t++50mFbY1/f/pO
 XhX4aoFzs2GL72pbo+I4lJMNSxRFaDXfSWlRlv4g7h6k+yts1j6I8GDyfNZij8TRmaKx
 w5LaR59kvXaNLkJU8t23aBqtollEcPluNipDed1Miq9SH9bW9s4T/Sh6j/YbyFxdfvb5
 ElQA==
X-Gm-Message-State: ANoB5plYYi9g1MVfKEJBFXhtg1uPrEC4Y2BPFN3bf4o2H6mhPjE/0Ly2
 mV7DxAXK8oHi2HtAheYT2nAVPJhSqtb9VIyLVIdNRIHpWIZENTxkMrafrAtBS+1NmfZaLDOBuXb
 Cu+3ELtdZtOZ7QHvXRrjC1B428A==
X-Received: by 2002:a05:600c:24e:b0:3c5:f9f1:f956 with SMTP id
 14-20020a05600c024e00b003c5f9f1f956mr5602429wmj.50.1668695049913; 
 Thu, 17 Nov 2022 06:24:09 -0800 (PST)
X-Google-Smtp-Source: AA0mqf660kXw1O9nDmBZzBp9eoh92b2B6Bcx05wnz8U6SS8Dy3l/finKWGNWkc/ihpfy4N9vMJHAMQ==
X-Received: by 2002:a05:600c:24e:b0:3c5:f9f1:f956 with SMTP id
 14-20020a05600c024e00b003c5f9f1f956mr5602401wmj.50.1668695049758; 
 Thu, 17 Nov 2022 06:24:09 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
 by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6112000000b00236e834f050sm1095385wrt.35.2022.11.17.06.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Nov 2022 06:24:09 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 6/8] treewide: Trace IPIs sent via
 smp_send_reschedule()
In-Reply-To: <Y3X7CijMXpqQIHhk@hirez.programming.kicks-ass.net>
References: <20221102182949.3119584-1-vschneid@redhat.com>
 <20221102183336.3120536-5-vschneid@redhat.com>
 <Y3X7CijMXpqQIHhk@hirez.programming.kicks-ass.net>
Date: Thu, 17 Nov 2022 14:24:04 +0000
Message-ID: <xhsmhiljdy7zv.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Juri Lelli <juri.lelli@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Guo Ren <guoren@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, linux-hexagon@vger.kernel.org, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org,
 linux-xtensa@linux-xtensa.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, openrisc@lists.librecores.org,
 Borislav Petkov <bp@alien8.de>, Nicholas Piggin <npiggin@gmail.com>,
 loongarch@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 17/11/22 10:12, Peter Zijlstra wrote:
> On Wed, Nov 02, 2022 at 06:33:34PM +0000, Valentin Schneider wrote:
>
>> diff --git a/kernel/smp.c b/kernel/smp.c
>> index c4d561cf50d45..44fa4b9b1f46b 100644
>> --- a/kernel/smp.c
>> +++ b/kernel/smp.c
>> @@ -167,6 +167,14 @@ send_call_function_ipi_mask(const struct cpumask *mask)
>>      arch_send_call_function_ipi_mask(mask);
>>  }
>>
>> +void smp_send_reschedule(int cpu)
>> +{
>> +	/* XXX scheduler_ipi is inline :/ */
>> +	trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, NULL);
>> +	arch_smp_send_reschedule(cpu);
>> +}
>> +EXPORT_SYMBOL_GPL(smp_send_reschedule);
>
> Yeah, no.. I see some crazy archs do this, but no we're not exporting
> this in generic.

So the list is: ia64, powerpc, riscv
and they all seem to do it because of KVM:
  c4cb768f0277 ("[IA64] export smp_send_reschedule")
  de56a948b918 ("KVM: PPC: Add support for Book3S processors in hypervisor mode")
  d3d7a0ce020e ("RISC-V: Export kernel symbols for kvm")

Other archs get out of it either because their smp_send_reschedule() is
inline (e.g. x86), or because they don't allow building KVM as a module
(e.g. arm64).

If I can cobble the tracepoint+reschedule in an inline helper, then that
wouldn't require any new exports - I'm fighting a bit with the header maze
ATM, but hopefully I can get somewhere with this.

