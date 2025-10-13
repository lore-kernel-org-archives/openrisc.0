Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C3B2FDC41
	for <linux-openrisc@vger.kernel.org>; Mon, 13 Oct 2025 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349467; cv=none; b=lljoApMIqSJMCZBiZWkdnVQ4R31LNyanDBWh4n4hJ7Ebox7uEmWGkkUf55WWTUZYkBQ5oM8XSoZi7+iAsTu+eMFX6LSr+Y/xFIgG7XUdyjkWihN50esE1RAer0hItNzdUOMCJAmNYWyUpcBHS0axnbVBR1pCdvOUp6sZMpo9eZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349467; c=relaxed/simple;
	bh=ZuPAOglWfkrlozTa9bHQkbIm5fGJG00hwMhQdCV1duo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ck2uYVs2/7VhU3P6qOYeRaPnYW874SdCA39wvIL2GhK8zLrs6EKgkuCHRtdCHdWkCMT6sXClrWqGY86191xvCUfpapdgq2EJ1TouV3ZvUrzAXhVCw1jklcZZvjJv72fy6dlIBWzu0eJtZc9dtK5+4ail96HPmldy7NK7J/6cFSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5yLh/W8; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5yLh/W8"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-330a4d4359bso3363079a91.2
        for <linux-openrisc@vger.kernel.org>; Mon, 13 Oct 2025 02:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760349466; x=1760954266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i3XnHndYuazUzKkBoZfqihk8WxxHAQT9C3eBczoAx1A=;
        b=A5yLh/W8EGFsw5/VlizUM4o/Ju7cqnmK+ujPR6zR2btR+uzK8oCk4W1NrZFuHdQxmw
         OoGV90rXMSvN/jqCPG/VWB5OtbjWmEZ3Xq112eySbYvOWY9Bvzq5VKbvJsyKqv/4/XVn
         96sknkxflNHxkfSyFvWCs78mJdcEa3rwQC5aFUKMbbwEPVEyIx08toat2nA6v3R5IvUB
         3ITHZjBkzarxiRQF8/8ZQAq9iaCeUf2z7Bj+SQKmH8VK6YW40gEjv38G5AmkYYzaVdYa
         ZyT1gJ+pyKaI07FhUFnxOpB4jjQF88zQoea3r7emP92PJyUAk3aHqwWtqE0GFHJel3Yo
         WlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349466; x=1760954266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3XnHndYuazUzKkBoZfqihk8WxxHAQT9C3eBczoAx1A=;
        b=YYtIcIBoILb+Rl0x0wc2b+ifWt5D4xk9xiZp4UBc3G6/JEc8+CLV8tx82/2dvRkeSO
         7lPXjBtIPWFhNy6LNIOHeuUzgPVy3250px+UM8ohVvVGKadbHpRhj0KIjD1ghsuKNj4O
         Xw7ecQqAI+Mb/g4jaycdzLZXEq6MzIam/1is7a2ekNo2NEQ4sR5OFq6rtYUPlDOii1Sa
         SltQ9pmOwmeptUw1F3ptC+iWsus9pIWIy7uy9EPYS0dKyAluwi1Mri/A9yBfQ6yXsqrz
         enbwSzZliokH1AbVMEUSrKhloHcB2pgYhSOHQltI804TMFrIPAADtMm3ybuKp/Vi5pCP
         +Blw==
X-Gm-Message-State: AOJu0YyywkrBCJjtMVYesXIf3+7hhHUzLgs+urcEtmyuJtQgSJoZQK66
	RhceFcyptIwPm7sOvGTeyR7YRiyHE10uSd9vJy+XttRgkiW0KZmUhwhs
X-Gm-Gg: ASbGnctXEXecMJ1ZAVgoer/FrMIvcGxWlSsjAVX3aX/KCtXi5NQCpLE0eCauBRulK4V
	lsr5C+Z3soxMkzX26hpWppTltoWqqIptPwcWMnW3Ni6NLC8+fHcxIkAJ4hEagibbRkOQYNN5WZe
	7/NanosehZ93Tvth5QbOeKBc/5+3B0aYRdTbfOZ+rLpt3kGIzWP5kLlCqIlQyei6qQJomQSMYeS
	dgelqk3iPnpHJgUGPBBT1XXai5IG6Nt3mGyR5NnpoulJzk4j1HsZdGLrvSe5PvHW+B3uxeWzQP/
	pI1X8ZZmK+6V6gVmjeGS/99/go5O9EvG+EFuwXNfyeNkAG7MuXX7YinWMfkFY2XNQ+4H+HEkiKT
	4Acqho7DRKMP2LwesnVMXbzTM0CT3+widyF7wfgi2QAA=
X-Google-Smtp-Source: AGHT+IHQTu4pibsF4lm5RR/qerTFyyf5uF7jaQuf7q1QL9EChi16hw+7XrobofPehr1xtNWyrqqeEw==
X-Received: by 2002:a17:90b:1d89:b0:330:797a:f504 with SMTP id 98e67ed59e1d1-33b5114d664mr27383350a91.3.1760349465588;
        Mon, 13 Oct 2025 02:57:45 -0700 (PDT)
Received: from HP.. ([119.63.139.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b52953666sm9239659a91.2.2025.10.13.02.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:57:44 -0700 (PDT)
From: Taimoor Zaeem <taimoorzaeem@gmail.com>
To: jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	oleg@redhat.com
Cc: linux-openrisc@vger.kernel.org,
	Taimoor Zaeem <taimoorzaeem@gmail.com>
Subject: [PATCH] openrisc: rename STACK_FRAME_OVERHEAD to MIN_REDZONE
Date: Mon, 13 Oct 2025 14:57:04 +0500
Message-ID: <20251013095704.43277-1-taimoorzaeem@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As mentioned in the TODO, the STACK_FRAME_OVERHEAD is
the red zone, hence renamed to MIN_REDZONE in ptrace.h
and processor.h.

Signed-off-by: Taimoor Zaeem <taimoorzaeem@gmail.com>
---
 arch/openrisc/include/asm/processor.h | 2 +-
 arch/openrisc/include/asm/ptrace.h    | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
index 3ff893a67c13..b0a00dcebf0c 100644
--- a/arch/openrisc/include/asm/processor.h
+++ b/arch/openrisc/include/asm/processor.h
@@ -55,7 +55,7 @@ struct thread_struct {
  * user->kernel transition registers are reached by this (i.e. not regs
  * for running signal handler)
  */
-#define user_regs(thread_info)  (((struct pt_regs *)((unsigned long)(thread_info) + THREAD_SIZE - STACK_FRAME_OVERHEAD)) - 1)
+#define user_regs(thread_info)  (((struct pt_regs *)((unsigned long)(thread_info) + THREAD_SIZE - MIN_REDZONE)) - 1)
 
 /*
  * Dito but for the currently running task
diff --git a/arch/openrisc/include/asm/ptrace.h b/arch/openrisc/include/asm/ptrace.h
index 28facf2f3e00..0b86764653ef 100644
--- a/arch/openrisc/include/asm/ptrace.h
+++ b/arch/openrisc/include/asm/ptrace.h
@@ -94,8 +94,7 @@ struct pt_regs {
 	long dummy2;		/* Cheap alignment fix */
 };
 
-/* TODO: Rename this to REDZONE because that's what it is */
-#define STACK_FRAME_OVERHEAD  128  /* size of minimum stack frame */
+#define MIN_REDZONE  128  /* size of minimum stack frame */
 
 #define MAX_REG_OFFSET offsetof(struct pt_regs, orig_gpr11)
 
-- 
2.43.0

