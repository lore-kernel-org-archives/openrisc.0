Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C8F279DB4;
	Tue,  1 Jul 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378214; cv=none; b=pPnsUaVkUXrWn4MvP48UqV53BaWb043lTmvEaZHp0T0/uZtbInSNo80Rpr3tEuraMHf+ERx7DLfcCzIrYZP6rMTPh7VPBBY8sSnQzc/Hndtt6vBTW0xtPTgcEgJR6n3nQJALp0OXIUskSWOygkwU5nft9Gw79hyLEX6U5q6U2I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378214; c=relaxed/simple;
	bh=hj0xanUpqdv+cmAVO+ES1xky96bHgFEr4H5HxHqFIqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UbTc/3JM2Yi1ViBYy7QIwIcBcE5F7P5w5r0fXzhA0BF0YkLc2cjHDbp1nHaS9m9vkEmt4ARBiFnWG9JWMDBEd4AmaEz33Fbu7prbpcTy/v5spzLrLrZ9EFr4usVAm/bA0oM2u1C9o3f6HcLxkMkgBP0uLHKbyMkWb5MYmJ/Gj94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 272072E9D;
	Tue,  1 Jul 2025 06:56:37 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D3E83F58B;
	Tue,  1 Jul 2025 06:56:50 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	linux-openrisc@vger.kernel.org
Subject: [PATCH 13/23] openrisc: ptrace: Use USER_REGSET_NOTE_TYPE() to specify regset note names
Date: Tue,  1 Jul 2025 14:56:06 +0100
Message-Id: <20250701135616.29630-14-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701135616.29630-1-Dave.Martin@arm.com>
References: <20250701135616.29630-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of having the core code guess the note name for each regset,
use USER_REGSET_NOTE_TYPE() to pick the correct name from elf.h.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: linux-openrisc@vger.kernel.org
---
 arch/openrisc/kernel/ptrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
index 8430570d0620..552489b24855 100644
--- a/arch/openrisc/kernel/ptrace.c
+++ b/arch/openrisc/kernel/ptrace.c
@@ -124,7 +124,7 @@ enum or1k_regset {
 
 static const struct user_regset or1k_regsets[] = {
 	[REGSET_GENERAL] = {
-			    .core_note_type = NT_PRSTATUS,
+			    USER_REGSET_NOTE_TYPE(PRSTATUS),
 			    .n = ELF_NGREG,
 			    .size = sizeof(long),
 			    .align = sizeof(long),
@@ -133,7 +133,7 @@ static const struct user_regset or1k_regsets[] = {
 			    },
 #ifdef CONFIG_FPU
 	[REGSET_FPU] = {
-			    .core_note_type = NT_PRFPREG,
+			    USER_REGSET_NOTE_TYPE(PRFPREG),
 			    .n = sizeof(struct __or1k_fpu_state) / sizeof(long),
 			    .size = sizeof(long),
 			    .align = sizeof(long),
-- 
2.34.1

