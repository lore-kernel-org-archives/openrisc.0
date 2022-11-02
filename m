Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03181C4332F
	for <openrisc@archiver.kernel.org>; Wed,  2 Nov 2022 18:30:50 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id B4C1F24C68;
	Wed,  2 Nov 2022 19:30:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mail.librecores.org (Postfix) with ESMTP id 2BA0824BF2
 for <openrisc@lists.librecores.org>; Wed,  2 Nov 2022 19:30:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667413846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DOAMp7M3Dm3mqYAl0WmtrSxJ5fQ0T+HY063YNavNlMw=;
 b=ddcCeBPGHt6g2ctdeAKCPfxDohOzZIpCdWTFBBKiJIztqdeTD4j9nFSLFJe2VfweQ2rsn0
 VE2hSjUriixMfk3GbVDySd4fGYXx6YbKDpW/HCmiBRNiEHKbMNmiVMU7G6pSVGDA4+Bd/j
 pfZE6oSf1xL3WAnVeP+ZASIM9VIHWa8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-522-qIsBk4svPsC8_f6MQVlKaw-1; Wed, 02 Nov 2022 14:30:46 -0400
X-MC-Unique: qIsBk4svPsC8_f6MQVlKaw-1
Received: by mail-qv1-f70.google.com with SMTP id
 ob9-20020a0562142f8900b004bba5363ad9so10129293qvb.8
 for <openrisc@lists.librecores.org>; Wed, 02 Nov 2022 11:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DOAMp7M3Dm3mqYAl0WmtrSxJ5fQ0T+HY063YNavNlMw=;
 b=jk5k6B+XbfCTQljVD4PCIziMf/f29+t3E7KGcP5dwvqcH9I494jRuXYRmBrxJWmg/7
 Xm5oG0htBZhyIOo1GwwK8MWngdc91QhxtcwXMFkndQt83MR13keRbisDnI9G/Beto4H9
 7zUe/6+WUjBTInn9ERsAsQrcxU79jgh0IOssI7kepKTvG/Vcv26HYZ0sVFin1Y0wOQAL
 En9zn1h6GpcmrnTli3mCex/JQqxnDMoHVKia//v3GTY5DaiqWE2PWIEPFwSFphARz0J9
 hHZ3/lb1Zy7LzCcdi3ZtZRHs0jcHr4RfIcYuiqRIP3euVWuikD9E7S8QCd7OJFWUgRTL
 PRAQ==
X-Gm-Message-State: ACrzQf1nYgy3fEcC3rJ5VeU6I33b2CzEXDbJPoS3/Avr6hqn8AvfUezb
 eWPajTpIeRSA5ispXq+Q4RZFUHzyvey8SIA0fFah0hKMUFICuj46vfiWamGqCqIq0pXboFHCBCB
 k9qIJt4O0T9t8CXRxZva6LtZFkQ==
X-Received: by 2002:ac8:7d8c:0:b0:39c:f4b6:f02f with SMTP id
 c12-20020ac87d8c000000b0039cf4b6f02fmr20509033qtd.252.1667413840494; 
 Wed, 02 Nov 2022 11:30:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4avLCdiC1e+YjDgGOUynVvkPGro1QBzGCbIXRErpBO4pdwyJNVuMKcAEHPTKixBfYKlupYaQ==
X-Received: by 2002:ac8:7d8c:0:b0:39c:f4b6:f02f with SMTP id
 c12-20020ac87d8c000000b0039cf4b6f02fmr20508984qtd.252.1667413840179; 
 Wed, 02 Nov 2022 11:30:40 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a05620a29d000b006cec8001bf4sm9133847qkp.26.2022.11.02.11.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Nov 2022 11:30:39 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, x86@kernel.org
Subject: [RFC PATCH v2 0/8] Generic IPI sending tracepoint
Date: Wed,  2 Nov 2022 18:29:41 +0000
Message-Id: <20221102182949.3119584-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
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
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marcelo Tosatti <mtosatti@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Steven Rostedt <rostedt@goodmis.org>, "David S. Miller" <davem@davemloft.net>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Nicholas Piggin <npiggin@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

Background
==========

Detecting IPI *reception* is relatively easy, e.g. using
trace_irq_handler_{entry,exit} or even just function-trace
flush_smp_call_function_queue() for SMP calls.  

Figuring out their *origin*, is trickier as there is no generic tracepoint tied
to e.g. smp_call_function():

o AFAIA x86 has no tracepoint tied to sending IPIs, only receiving them
  (cf. trace_call_function{_single}_entry()).
o arm/arm64 do have trace_ipi_raise(), which gives us the target cpus but also a
  mostly useless string (smp_calls will all be "Function call interrupts").
o Other architectures don't seem to have any IPI-sending related tracepoint.  

I believe one reason those tracepoints used by arm/arm64 ended up as they were
is because these archs used to handle IPIs differently from regular interrupts
(the IRQ driver would directly invoke an IPI-handling routine), which meant they 
never showed up in trace_irq_handler_{entry, exit}. The trace_ipi_{entry,exit}
tracepoints gave a way to trace IPI reception but those have become redundant as
of: 

      56afcd3dbd19 ("ARM: Allow IPIs to be handled as normal interrupts")
      d3afc7f12987 ("arm64: Allow IPIs to be handled as normal interrupts")

which gave IPIs a "proper" handler function used through
generic_handle_domain_irq(), which makes them show up via
trace_irq_handler_{entry, exit}.

Changing stuff up
=================

Per the above, it would make sense to reshuffle trace_ipi_raise() and move it
into generic code. This also came up during Daniel's talk on Osnoise at the CPU
isolation MC of LPC 2022 [1]. 

Now, to be useful, such a tracepoint needs to export:
o targeted CPU(s)
o calling context

The only way to get the calling context with trace_ipi_raise() is to trigger a
stack dump, e.g. $(trace-cmd -e ipi* -T echo 42).

This is instead introducing a new tracepoint which exports the relevant context
(callsite, and requested callback for when the callsite isn't helpful), and is
usable by all architectures as it sits in generic code. 

Another thing worth mentioning is that depending on the callsite, the _RET_IP_
fed to the tracepoint is not always useful - generic_exec_single() doesn't tell
you much about the actual callback being sent via IPI, which is why the new
tracepoint also has a @callback argument.

Patches
=======

o Patch 1 is included for convenience and will most likely be merged
  independently. FYI I have libtraceevent patches [2] to improve the
  pretty-printing of cpumasks using the new type, which look like:
  <...>-3322  [021]   560.402583: ipi_send_cpumask:     cpumask=14,17,21 callsite=on_each_cpu_cond_mask+0x40 callback=flush_tlb_func+0x0
  <...>-187   [010]   562.590584: ipi_send_cpumask:     cpumask=0-23 callsite=on_each_cpu_cond_mask+0x40 callback=do_sync_core+0x0

o Patches 2-6 spread out the tracepoint accross relevant sites.
o Patch 8 is trying to be smart about tracing the callback associated with the
  IPI.

This results in having IPI trace events for:

o smp_call_function*()
o smp_send_reschedule()
o irq_work_queue*()
o standalone uses of __smp_call_single_queue()

This is incomplete, just looking at arm64 there's more IPI types that aren't
covered: 

  IPI_CPU_STOP,
  IPI_CPU_CRASH_STOP,
  IPI_TIMER,
  IPI_WAKEUP,

... But it feels like a good starting point.

Links
=====

[1]: https://youtu.be/5gT57y4OzBM?t=14234
[2]: https://lore.kernel.org/all/20221018151630.1513535-1-vschneid@redhat.com/

Revisions
=========

v1 -> v2
++++++++

o Ditched single-CPU tracepoint
o Changed tracepoint signature to include callback
o Changed tracepoint callsite field to void *; the parameter is still UL to save
  up on casts due to using _RET_IP_.
o Fixed linking failures due to not exporting smp_send_reschedule()

Steven Rostedt (Google) (1):
  tracing: Add __cpumask to denote a trace event field that is a
    cpumask_t

Valentin Schneider (7):
  trace: Add trace_ipi_send_cpumask()
  sched, smp: Trace IPIs sent via send_call_function_single_ipi()
  smp: Trace IPIs sent via arch_send_call_function_ipi_mask()
  irq_work: Trace self-IPIs sent via arch_irq_work_raise()
  treewide: Trace IPIs sent via smp_send_reschedule()
  smp: reword smp call IPI comment
  sched, smp: Trace smp callback causing an IPI

 arch/alpha/kernel/smp.c                      |  2 +-
 arch/arc/kernel/smp.c                        |  2 +-
 arch/arm/kernel/smp.c                        |  5 +-
 arch/arm64/kernel/smp.c                      |  3 +-
 arch/csky/kernel/smp.c                       |  2 +-
 arch/hexagon/kernel/smp.c                    |  2 +-
 arch/ia64/kernel/smp.c                       |  4 +-
 arch/loongarch/include/asm/smp.h             |  2 +-
 arch/mips/include/asm/smp.h                  |  2 +-
 arch/openrisc/kernel/smp.c                   |  2 +-
 arch/parisc/kernel/smp.c                     |  4 +-
 arch/powerpc/kernel/smp.c                    |  4 +-
 arch/powerpc/kvm/book3s_hv.c                 |  1 +
 arch/riscv/kernel/smp.c                      |  4 +-
 arch/s390/kernel/smp.c                       |  2 +-
 arch/sh/kernel/smp.c                         |  2 +-
 arch/sparc/kernel/smp_32.c                   |  2 +-
 arch/sparc/kernel/smp_64.c                   |  2 +-
 arch/x86/include/asm/smp.h                   |  2 +-
 arch/x86/kvm/svm/svm.c                       |  1 +
 arch/x86/kvm/x86.c                           |  1 +
 arch/xtensa/kernel/smp.c                     |  2 +-
 include/linux/smp.h                          |  2 +-
 include/trace/bpf_probe.h                    |  6 ++
 include/trace/events/ipi.h                   | 22 +++++++
 include/trace/perf.h                         |  6 ++
 include/trace/stages/stage1_struct_define.h  |  6 ++
 include/trace/stages/stage2_data_offsets.h   |  6 ++
 include/trace/stages/stage3_trace_output.h   |  6 ++
 include/trace/stages/stage4_event_fields.h   |  6 ++
 include/trace/stages/stage5_get_offsets.h    |  6 ++
 include/trace/stages/stage6_event_callback.h | 20 ++++++
 include/trace/stages/stage7_class_define.h   |  2 +
 kernel/irq_work.c                            | 16 ++++-
 kernel/sched/core.c                          | 34 +++++++---
 kernel/sched/smp.h                           |  1 +
 kernel/smp.c                                 | 66 ++++++++++++++++++--
 samples/trace_events/trace-events-sample.c   |  2 +-
 samples/trace_events/trace-events-sample.h   | 34 +++++++---
 39 files changed, 241 insertions(+), 53 deletions(-)

--
2.31.1

