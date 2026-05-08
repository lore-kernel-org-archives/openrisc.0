Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED18274FDF;
	Fri,  8 May 2026 04:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214077; cv=none; b=pt3XvUbrguxy6Y0amiqRvavcjabvtLq8t2lj66t27F7ZPqf51fXdMrUqYRLcI2j/drN+rCQFrRfNJyEP5NFixOsl7/UHPJE24qhFwKrM0fhW6j0MNQoEpuq7JxyO5RLI/qojh4kzLMFM1J+/XbCX/rEtQQa4Hee6gVGJARuM2Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214077; c=relaxed/simple;
	bh=d8+99RDKvb1IG1yhbTg++mHKBIceCvRDE6X5g1vmCS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PCjbvchsbJdlRVUMZplfGiMW6uK/862SnmRmNr/Y8lceToDN4qrgDzbJ0MdaGjNGvzsKd7Dj9zUGuTa6NcgLkeX7i9LBE9upv4ts4AiiHeGFRAGZZdocIP8wRzqwM7T02FGuFX/x8qrZ2PDZFvbzNQrVQoZzqMOr/MYzLV0DxQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJeMrebn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJeMrebn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949AFC2BCB4;
	Fri,  8 May 2026 04:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214077;
	bh=d8+99RDKvb1IG1yhbTg++mHKBIceCvRDE6X5g1vmCS0=;
	h=From:To:Cc:Subject:Date:From;
	b=LJeMrebnUZs4G8k4Yo4wfoWDarO5LXUlEivq8SwGStTr30uWdL3N1df/T5pDNbzZn
	 beuh1t4xmJdXSmJ5MPkgktfKHa1MwJgEnW1cOXlnCG4oAwsmZmESzbWtR5NyVhOcR+
	 ij6cQhBV12P3/08CzPvsC3BJte+WNi0iDY+LWIig0vGlwUdY6Z/jkyYLAll7ibNqxD
	 AX0Y7ksfQwxMfx46lAK/RhyNFxW5c+Ai9jMnYc9sRihbBmaUbS+MO4qq8Oz6zfIcJz
	 xvx4g6MUG3KULSwVT2iZXZQdkU2mc2DSk6OCrKduiZA8L6aYdA5nVkyn4px2LLO0tN
	 26ek7dl0Hpe+A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id B11B8F40076;
	Fri,  8 May 2026 00:21:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 08 May 2026 00:21:14 -0400
X-ME-Sender: <xms:umT9adO9nYHswbTr8icyE_mwkTqEyjxbZfv1UoK0KXwHmhl-PlyIlA>
    <xme:umT9aSmFAX20Cl0N5iA7EBVed4B3LQ4JeUruYX24fBZqBkHPJXz0LTiHhRNVDHAbH
    47aPIaf-cAFAcNVNtUt76Nsq63xNWfeB_tKjb6faLqqiQbK-g>
X-ME-Received: <xmr:umT9aRNOaSCT_vER4kpeD0bac17I0sLF3DaVP9duBc1YX7D8my9yFz1Qj4Oo43YmMwxh4dNSqoWnE3MsyngG16kElHsdXR0X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdelfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeffhe
    ffjedvuddtffeguedtudehieejhffgkeevteefvefhfeehiefgteduueefkeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrhhnvg
    hlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepheeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghp
    thhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghssehsoh
    huthhhphholhgvrdhsvgdprhgtphhtthhopehsthgvfhgrnhdrkhhrihhsthhirghnshhs
    ohhnsehsrghunhgrlhgrhhhtihdrfhhipdhrtghpthhtohepshhhohhrnhgvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohephhgtrgeslhhinhhugidrihgsmhdrtghomhdprhgtphht
    thhopehgohhrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheprghgohhruggvvg
    hvsehlihhnuhigrdhisghmrdgtohhm
X-ME-Proxy: <xmx:umT9acqd7k5gzP-AMWhRPHYtuo6VRGLYJhHK0Eaqd-OgSXLMz1-3mQ>
    <xmx:umT9aQNAGpMWoKN50y_eTdtWs9X0ZUlEzf6vFyqQJXr_KohuuK7mhQ>
    <xmx:umT9aaPr1aHdB_uMpPNwsy_DjjzIfoTr1pFG0R4pqPlZMUJ98nzlaA>
    <xmx:umT9aeyiMDLiRog4QVL_0EfGtebN8I5w8UpYhkJ3n_9VIQluRdKF5A>
    <xmx:umT9aWV5uuzc3lAKSVLDCg07rlPBP-ev9qb11r3TvDZyHuQUw9SHs51j>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 00:21:14 -0400 (EDT)
From: Boqun Feng <boqun@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,	Will Deacon <will@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,	Arnd Bergmann <arnd@arndb.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,	Jinjie Ruan <ruanjinjie@huawei.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Lyude Paul <lyude@redhat.com>,	Sohil Mehta <sohil.mehta@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,	linux-kernel@vger.kernel.org,
	linux-openrisc@vger.kernel.org,	linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org,	rust-for-linux@vger.kernel.org
Subject: [PATCH 00/11] Refcounted interrupt disable and SpinLockIrq for rust (Part 1)
Date: Thu,  7 May 2026 21:21:00 -0700
Message-ID: <20260508042111.24358-1-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Peter,

This is a follow-up for Lyude's work [1]. Per your feedback at [2], I
did some digging and turned out that ARM64 already kinda did this. The
basic idea is based on:

1) preempt_count() previously mask our NEED_RESCHED bit, so the
   effective bits is 31bits
2) with a 64bit preempt count implementation (as in your PREEMPT_LONG
   proposal), the effective bits that record "whether we CAN preempt or
   not" still fit in 32bit (i.e. an int)

as a result, I don't think we need to change the existing
preempt_count() API, but rather keep "32bit vs 64bit" as an
implementation detail. This saves us the need to change the printk code
for preempt_count().

For people who have reviewed the previous version, patch 8-11 are new,
please take a look.

The patchset passed the build and booting tests and also a "perf record"
test on x86 for NMI code path.

I would like to target this changes for 7.2 if possible.

[1]: https://lore.kernel.org/all/20260121223933.1568682-1-lyude@redhat.com/
[2]: https://lore.kernel.org/all/20260204111234.GA3031506@noisy.programming.kicks-ass.net/

Regards,
Boqun

Boqun Feng (8):
  preempt: Introduce HARDIRQ_DISABLE_BITS
  preempt: Introduce __preempt_count_{sub, add}_return()
  irq & spin_lock: Add counted interrupt disabling/enabling
  locking: Switch to _irq_{disable,enable}() variants in cleanup guards
  sched: Remove the unused preempt_offset parameter of __cant_sleep()
  sched: Avoid signed comparison of preempt_count() in __cant_migrate()
  preempt: Introduce PREEMPT_COUNT_64BIT
  arm64: sched/preempt: Enable PREEMPT_COUNT_64BIT

Joel Fernandes (1):
  preempt: Track NMI nesting to separate per-CPU counter

Lyude Paul (2):
  openrisc: Include <linux/cpumask.h> in smp.h
  irq: Add KUnit test for refcounted interrupt enable/disable

 arch/arm64/Kconfig                   |   1 +
 arch/arm64/include/asm/preempt.h     |  18 +++++
 arch/openrisc/include/asm/smp.h      |   2 +
 arch/s390/include/asm/preempt.h      |  10 +++
 arch/x86/Kconfig                     |   1 +
 arch/x86/include/asm/preempt.h       |  61 +++++++++++----
 arch/x86/kernel/cpu/common.c         |   2 +-
 include/asm-generic/preempt.h        |  14 ++++
 include/linux/hardirq.h              |  41 ++++++++--
 include/linux/interrupt_rc.h         |  63 ++++++++++++++++
 include/linux/kernel.h               |   4 +-
 include/linux/preempt.h              |  35 ++++++---
 include/linux/spinlock.h             |  51 +++++++++----
 include/linux/spinlock_api_smp.h     |  27 +++++++
 include/linux/spinlock_api_up.h      |   9 +++
 include/linux/spinlock_rt.h          |  15 ++++
 kernel/Kconfig.preempt               |   4 +
 kernel/irq/Makefile                  |   1 +
 kernel/irq/refcount_interrupt_test.c | 109 +++++++++++++++++++++++++++
 kernel/locking/spinlock.c            |  29 +++++++
 kernel/sched/core.c                  |  18 +++--
 kernel/softirq.c                     |  11 +++
 lib/locking-selftest.c               |   2 +-
 23 files changed, 476 insertions(+), 52 deletions(-)
 create mode 100644 include/linux/interrupt_rc.h
 create mode 100644 kernel/irq/refcount_interrupt_test.c

-- 
2.50.1 (Apple Git-155)

