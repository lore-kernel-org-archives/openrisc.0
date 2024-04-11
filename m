Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2982127E1A;
	Thu, 11 Apr 2024 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858836; cv=none; b=TSi/bTq0V4OcPmGZi5cy8WOacUx7qIPQgAf09JvfTs72gEU3LEDXSsrhO12+juWTN9tcqQbFwG+es4cTUBf3i73ilEKrr/CoaetHmk4gtOKojQ4TWvGQb+9aH0N2vRVXsiulu8CYpXxL8tOzk0rD+Rr5L2RnXc7C5CVZZLsTQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858836; c=relaxed/simple;
	bh=TPD2BnAYpAPjxNEzF7xOyRGc2UuoaAxKFAzlSvtHwnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZlkFJBHIcHDy6HBaENUXntHnIdWCFHxwzvYrrju+usacQZgag2G/higdiGypkwQ4Xlyh/XziDBsWKGNdT0pIORMYg4vaJTMBK4sirFstLN0ZvnAk8VJWbbm01JwXA9pNronC/xwBUZQHiTO0QHUDVEJDvrayVXzpKJIGC6c/y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiHjMA5+; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiHjMA5+"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34665dd7610so12234f8f.3;
        Thu, 11 Apr 2024 11:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712858832; x=1713463632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlOMMt1K4XGZU2OF7U6kzSJw3nCLKyrJjAjRkM9xYL0=;
        b=CiHjMA5+7ZyBpP1HvD4PwVwBf9yCOeymTIVxLCaos+Ie8yOJFO911W3Pk4a+diKqnr
         Ml4yXAToRx/E/1MTj0UasB7mmRyNWC8MgQ7FZb2K4+NnHhoZtAPw5cwVfoIcK5IJsj8p
         PbsmLIhNdZ0FzoYUC0IOgoAHkgjzBZO0yaH8kGtFTAQNHIKQ5GilEnOUz9qaaKzzsu2t
         +HEhd3o6Sh0x7hNcpsNW+g+N26NGqxZAHukOM/sSPqg4YGEydi7G8KlMtzzuN9/XplMP
         P66ogMCV3SVSu8UZgsjedAtTL3WEYmnduE7gMLMgHJAalDgLzX1OK31OtP2Bhj6cPdQH
         ydXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858832; x=1713463632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlOMMt1K4XGZU2OF7U6kzSJw3nCLKyrJjAjRkM9xYL0=;
        b=HQkMBmb9uDJBXIWeJ1oGCTWG38lz0jwfm/PQp3Y0wETGYv8GLDrzVqqq2lEgrjlI7u
         rMmARfbv8uCqx066efWss3FVFuaPg2lWU1tJH9pEeHB2gd/3eB3D/jaBW/XMvw/vzsBB
         V326o0QMYxf+u7aaSzqxsp4Ct3rMbuZsp4ge3CPY1gkpZf6Xx9asiWe2VO+6dgoHvldd
         4NlGxfBjs/SGhKfWDB+c/3nwtfcmBXG5JSt9Cxw9vP2yzsiTu0GySQCpRv1GI/4XXzA5
         sfqGEHYl3OXjCfQ3Vhk4KDC9brIEc6H0ltK7S4bx9Ddw408AEVLVCPUQcoD2eMLkaia0
         FH9g==
X-Gm-Message-State: AOJu0Ywx5lkmEglUjoodYtdwzJA3t9IvYDf1K91rvfzIqP4uKRatdbK/
	wR2WiN+7pgTKeRActu+6SuHu1MJVpNwwdXW3XcvZ8C2Cc7hdfiVgt1MqLQ==
X-Google-Smtp-Source: AGHT+IFptFUxExRxrXSeKH39hp0g5wfvj3vT2UdjtY1CqliZcsznFeq8tgrLRAYNpCnHI77qBEjheQ==
X-Received: by 2002:a5d:4ac4:0:b0:343:4b39:9dbc with SMTP id y4-20020a5d4ac4000000b003434b399dbcmr192754wrs.42.1712858832048;
        Thu, 11 Apr 2024 11:07:12 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id q3-20020adff943000000b00346cc85c821sm1596160wrr.89.2024.04.11.11.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 11:07:11 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: [PATCH 2/5] openrisc: traps: Remove calls to show_registers before die
Date: Thu, 11 Apr 2024 19:06:29 +0100
Message-ID: <20240411180644.2023991-3-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411180644.2023991-1-shorne@gmail.com>
References: <20240411180644.2023991-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The die function calls show_registers unconditionally.  Remove calls to
show_registers before calling die to avoid printing all registers and
stack status two times during a crash.

This was found when testing kernel trap and floating point exception
handling.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/traps.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 6d0fee912747..88fe27e4c10c 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -212,7 +212,6 @@ asmlinkage void do_unaligned_access(struct pt_regs *regs, unsigned long address)
 		force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)address);
 	} else {
 		pr_emerg("KERNEL: Unaligned Access 0x%.8lx\n", address);
-		show_registers(regs);
 		die("Die:", regs, address);
 	}
 
@@ -225,7 +224,6 @@ asmlinkage void do_bus_fault(struct pt_regs *regs, unsigned long address)
 		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 	} else {		/* Kernel mode */
 		pr_emerg("KERNEL: Bus error (SIGBUS) 0x%.8lx\n", address);
-		show_registers(regs);
 		die("Die:", regs, address);
 	}
 }
@@ -421,7 +419,6 @@ asmlinkage void do_illegal_instruction(struct pt_regs *regs,
 	} else {		/* Kernel mode */
 		pr_emerg("KERNEL: Illegal instruction (SIGILL) 0x%.8lx\n",
 			 address);
-		show_registers(regs);
 		die("Die:", regs, address);
 	}
 }
-- 
2.44.0

