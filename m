Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EF52ED84A
	for <linux-openrisc@vger.kernel.org>; Mon, 18 May 2026 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088114; cv=none; b=FF86lBCxEC8nvAo/k/dflOYO9/VTx4heszlDQLfDPGiEl6Yw6qqR1LbZGGQczjJaUgTH2fdRguA6BtXx/ROVu5qzUM5HSYGWBoaHdyD+CLArM+epR5THoh5ZnmN95wqTG3gCLyrxxsatH7+FYT91Ly6YRGOO5sj8mxusqD55cEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088114; c=relaxed/simple;
	bh=U8RnSVI63jA3VZmVpfcJQT469phe/4cQTvh1xJCcgsw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DTvGI0ZC9zWyQ9y4H+QEEnUcbS0QSS7Bl+meDd/kt7SJyPGaxyprcXsbU+HAmelj8dfUlICNFtecnsph8FrZ0VMBXbe5+geh5LET1EOwAYGJ73/V0zI/+xCJjMSwdp3BR4lH7WXU9zuwf+nlJSxQBbbXB1KJI+djyGon8NMIAOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEvpIDZE; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEvpIDZE"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-366be8040a9so671908a91.3
        for <linux-openrisc@vger.kernel.org>; Mon, 18 May 2026 00:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779088112; x=1779692912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a1o4hxowLzHHd4Yw10PawGm+yAZguIaKz4mMl3Ok7xM=;
        b=HEvpIDZEykUzR0Wr/3UJ/TL1f3AkCw2fOtyiN8Quwfv56Qj3ne3dB5zJvjBP/Wd1L3
         EX7vC+PfiLUf6STkhe8tLbKhfWgJTsHa6vP1/Mb3w5lRF7DMLqNcdjBt0fR/65uydXVb
         hDC6U6+qVm18FSpW0sSLrcmqEkjqd1qR9PQtH670pjm5OUupyVwh+wlFzX1lmAxCGssK
         q0h+cWwEdq8mCBaH3kH+de/TxPwP6CwQH/1y0MSvWqocjhIO8etyt6zdsTszz22cNO5C
         zr5PVEwUh9sRp7vmcaWttS6OJrRl9qYHkjyJcfE708GWYZRXPJ1TPzZ/y1UVV9ISvBmU
         u5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779088112; x=1779692912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1o4hxowLzHHd4Yw10PawGm+yAZguIaKz4mMl3Ok7xM=;
        b=ap2uiN9CEd/uwOq9EM27Dqlhugv1koIVe+bFRXppZcLBDTMQ0SAu+NA9DQVjozZlAm
         +zp0UGog7/FFGPiMom/bAbpYJ1n0ZwwLL03Yht/yqnc1Vw50GxASdrOGW/4mSp/aGm7H
         5YRftx+dc4rhCRtJIZR/GbaqKOIYF5I72FVVoCl5TcA3Gb5JBi/8rZoRO4AzDzBKBKMU
         c0/55MBv68lR/oWDoMsggkVub3qlvdM4xPRYqxs41WUBtMBg1G0pmpeg6H05fv/mkfqn
         9DxIdTZrabRYbbWRoeudU6ImmPmhnUIZfhlL0yP1b9e217YulpjIfCSMq3M6RVFxDy7B
         JBTg==
X-Forwarded-Encrypted: i=1; AFNElJ8ToyqMmycS/AbXyS673JbSqhjndZjFBdRm+/enVYjqkCvyRSqEwOYpjSyfzyP4DGgmG1mcSzmTimVO4Svozw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIkxK5gxquR2CGzKWsAr0LqPDZnLC6cUrO7JSnpZJ6V0KvxHIU
	IAMI+WFmJM4emY3K6bdn723o9UfHswAQu1vUP8BiasqmmQLj8aT9BWI3W40NVdEb
X-Gm-Gg: Acq92OHVflnUA6hSXL51jEsA2wFD62IYR/7voCFyd031b3/NtENvvTiLJ2o2z3DyI75
	J6qrdq8M+//3G6yLVnK8OFcWQDKz6Rqy8sd5cI60jJcOLqQYuOJ0caTZ85t9GofrBDzDE72S+nf
	XevNO9Bco4OnIbQUOFAIj1RA8VxoxI3Ei1iWWMfpGTkjSwn5ca9JWxXsgTG0tYdcglmgX6+vmZ1
	w2ZWBEl9LCvdAETauvlnl9hr1ZWwfZoLeY+skGQhL9r0oGlmnqMOiKba183oWGzSs0nnS6jNIJC
	9xZdJ8HWpuNpTfxlMG55L5H0YZtV00SjIMr6subsACK+BAPk+nym8WJI/cnC2CAIXQLX1sDjfO8
	6TX4nriF8y6W3cuhnMbPx8WoLeh9DboeWNOltikZONPhBhE2kkH2HLxUntuJUzQ49i3Cnw2uqdD
	hmiHll/lTgoVuZBLfIQKGXbi7qDHLHiJFqb/EfiyZKn5fsY5a5NvShTosKnOMF6w==
X-Received: by 2002:a17:90b:2fc4:b0:366:7dbd:cd50 with SMTP id 98e67ed59e1d1-36951dd07a8mr14732610a91.27.1779088112450;
        Mon, 18 May 2026 00:08:32 -0700 (PDT)
Received: from 4rynvubuntu.tailf26d3b.ts.net ([103.27.51.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36959b06290sm5243514a91.2.2026.05.18.00.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:08:31 -0700 (PDT)
From: 4rynv <vyapariaryan642@gmail.com>
To: shorne@gmail.com
Cc: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	oleg@redhat.com,
	linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	4rynv <vyapariaryan642@gmail.com>
Subject: [PATCH] openrisc: ptrace: Rename STACK_FRAME_OVERHEAD to KERNEL_REDZONE_SIZE
Date: Mon, 18 May 2026 07:08:11 +0000
Message-Id: <20260518070811.3816-1-vyapariaryan642@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 128-byte area below the stack pointer is a red zone, not a stack
frame overhead. Rename it to KERNEL_REDZONE_SIZE to match the powerpc
convention and better reflect its actual purpose.

Tests:
- Verified no remaining references to STACK_FRAME_OVERHEAD in
  arch/openrisc/ using grep
- Built arch/openrisc/ successfully with or1k-elf cross-compiler:
  make ARCH=openrisc CROSS_COMPILE=or1k-elf- arch/openrisc/

Resolves the TODO comment in ptrace.h.

Signed-off-by: 4rynv <vyapariaryan642@gmail.com>
---
 arch/openrisc/include/asm/processor.h | 4 +++-
 arch/openrisc/include/asm/ptrace.h    | 3 +--
 arch/openrisc/kernel/asm-offsets.c    | 4 ++--
 arch/openrisc/kernel/process.c        | 4 ++--
 arch/openrisc/kernel/signal.c         | 2 +-
 arch/openrisc/kernel/stacktrace.c     | 2 +-
 6 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
index 3ff893a67c13..f4ababd1de24 100644
--- a/arch/openrisc/include/asm/processor.h
+++ b/arch/openrisc/include/asm/processor.h
@@ -55,7 +55,9 @@ struct thread_struct {
  * user->kernel transition registers are reached by this (i.e. not regs
  * for running signal handler)
  */
-#define user_regs(thread_info)  (((struct pt_regs *)((unsigned long)(thread_info) + THREAD_SIZE - STACK_FRAME_OVERHEAD)) - 1)
+#define user_regs(thread_info) \
+	(((struct pt_regs *)((unsigned long)(thread_info) + \
+	THREAD_SIZE - KERNEL_REDZONE_SIZE)) - 1)
 
 /*
  * Dito but for the currently running task
diff --git a/arch/openrisc/include/asm/ptrace.h b/arch/openrisc/include/asm/ptrace.h
index 28facf2f3e00..940f0b045b2a 100644
--- a/arch/openrisc/include/asm/ptrace.h
+++ b/arch/openrisc/include/asm/ptrace.h
@@ -94,8 +94,7 @@ struct pt_regs {
 	long dummy2;		/* Cheap alignment fix */
 };
 
-/* TODO: Rename this to REDZONE because that's what it is */
-#define STACK_FRAME_OVERHEAD  128  /* size of minimum stack frame */
+#define KERNEL_REDZONE_SIZE  128  /* size of minimum stack frame */
 
 #define MAX_REG_OFFSET offsetof(struct pt_regs, orig_gpr11)
 
diff --git a/arch/openrisc/kernel/asm-offsets.c b/arch/openrisc/kernel/asm-offsets.c
index 3cc826f2216b..07bfa12ca4af 100644
--- a/arch/openrisc/kernel/asm-offsets.c
+++ b/arch/openrisc/kernel/asm-offsets.c
@@ -53,8 +53,8 @@ int main(void)
 	DEFINE(PT_SIZE, sizeof(struct pt_regs));
 
 	/* Interrupt register frame */
-	DEFINE(STACK_FRAME_OVERHEAD, STACK_FRAME_OVERHEAD);
-	DEFINE(INT_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs));
+	DEFINE(KERNEL_REDZONE_SIZE, KERNEL_REDZONE_SIZE);
+	DEFINE(INT_FRAME_SIZE, KERNEL_REDZONE_SIZE + sizeof(struct pt_regs));
 
 	DEFINE(NUM_USER_SEGMENTS, TASK_SIZE >> 28);
 	return 0;
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 73ffb9fa3118..bbe2b36d698d 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -176,12 +176,12 @@ copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	top_of_kernel_stack = sp;
 
 	/* Locate userspace context on stack... */
-	sp -= STACK_FRAME_OVERHEAD;	/* redzone */
+	sp -= KERNEL_REDZONE_SIZE;	/* redzone */
 	sp -= sizeof(struct pt_regs);
 	userregs = (struct pt_regs *) sp;
 
 	/* ...and kernel context */
-	sp -= STACK_FRAME_OVERHEAD;	/* redzone */
+	sp -= KERNEL_REDZONE_SIZE;	/* redzone */
 	sp -= sizeof(struct pt_regs);
 	kregs = (struct pt_regs *)sp;
 
diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index f70a13ee0593..63121750fe5e 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -171,7 +171,7 @@ static inline void __user *get_sigframe(struct ksignal *ksig,
 	unsigned long sp = regs->sp;
 
 	/* redzone */
-	sp -= STACK_FRAME_OVERHEAD;
+	sp -= KERNEL_REDZONE_SIZE;
 	sp = sigsp(sp, ksig);
 	sp = align_sigframe(sp - frame_size);
 
diff --git a/arch/openrisc/kernel/stacktrace.c b/arch/openrisc/kernel/stacktrace.c
index 54d38809e22c..0c4ca1eac2c2 100644
--- a/arch/openrisc/kernel/stacktrace.c
+++ b/arch/openrisc/kernel/stacktrace.c
@@ -79,7 +79,7 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 
 		/* Locate stack from kernel context */
 		ksp = task_thread_info(tsk)->ksp;
-		ksp += STACK_FRAME_OVERHEAD;	/* redzone */
+		ksp += KERNEL_REDZONE_SIZE;	/* redzone */
 		ksp += sizeof(struct pt_regs);
 
 		sp = (unsigned long *) ksp;
-- 
2.34.1

