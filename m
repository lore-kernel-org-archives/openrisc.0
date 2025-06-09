Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB4921CC49
	for <linux-openrisc@vger.kernel.org>; Mon,  9 Jun 2025 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749495157; cv=none; b=cjRQAc4Xx21JmAzz/7J78B71iwW9nGh3JLFUBl3LJaMFXPa2uDpgPCnKoWL8vB91o3hPSWh2ifsFnHbNVexZfoMxOG6bFIRNXWj3a2wm6QzqwuN+7u+gU0ZGBEEKKDnjpt11faOx6AKRq3CKctDc+oonFgOgYfKq6XH8WLIQVbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749495157; c=relaxed/simple;
	bh=Levtmfvv0rwwwpseMSRW8qBekn5KxZb6KJoIpX+UHvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tovXmka1iAYgF4z80HCUIt6C1s20Q4TDpiQlN0GTXg9593yxzvCwuPa5L9A1IcyD7muq8CwsOuOc511MhG57NcnwJHhYOeajgs8DBSZF6/pdoeaEXd48CAbmAfoOknkFv2YGWYgepR+SYPbLCxidDFzjcY1D0HHVKSpIp/lRdSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7NDfH0f; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7NDfH0f"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so41301535e9.3
        for <linux-openrisc@vger.kernel.org>; Mon, 09 Jun 2025 11:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749495154; x=1750099954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yqnwRpiapkoG3nEq9l4SJVCZxQ1TdzaJNT2KrYSEGPU=;
        b=f7NDfH0fkI5qKDgIsDFXPmjBRDA9OX72mN/hRFzUS5XltBfwPyAGMFTHddrd2cdzZz
         fNlUGOAJ6q1NGXpbMGb7TLqdJEjZ23zI7KTqCmbmW3WUspTXiMI4sHqay44p0nvgSqNz
         j3G1xsdc8aL0B8355catBzjL+1B2kKAH5jSx+VxGgC6P8MKDBxW+MWJ3XPyBES31mSqM
         kI+KKCKoo5wB5CXdtr49pXiCwBVYnCkks20k727mx755tWVifKAeopjlGDAoIL2bokkx
         jCK3L6TMFeXeVoaR8LtNBq7PFQlWZl6d/GFFyzl3Fo3ckvxkxpOE70DUat8zDApFxmBk
         8Zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749495154; x=1750099954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqnwRpiapkoG3nEq9l4SJVCZxQ1TdzaJNT2KrYSEGPU=;
        b=lQSPxnjLh/aZ/bHLjiGFg+gXa/CKi6NRhBj9rEvwW93gSIMR57I5wGXh1VutNUKAZe
         3XVOCDIeqL0tKWqZHQIxthSBHXqFmoIt0OFG1C39DdcsGg4pm+QWl6JBa8TtkuQa+tQD
         KngbdBVB9JSI7iEGTQ2H9gzTLZeupBYzN1I8HycJH14/7RSi4ohAJjBYzYdPirLfGvyb
         2uzaeQmUSs2xtukN4ifP11ub26oeMROHoyv80VfsnJqWICxwbHr49xJ/U/TbOrlaCyXi
         P5XPrC2eyKJ3rY5SRECsISSepo4uPc/zLIRzhN5UJm/MdlE/eGdDKeydY3uNHU+PQmz7
         PgoA==
X-Gm-Message-State: AOJu0YxBIlAbAk75QVdxR6YxI6je4By+GuIb3tLtCG4V4K1vqX/4dFDf
	yCVUHQt+ln1oh7YixIpZW85JoZM33mThtqQOBLrPXvSRjrYfSoUFWBlr
X-Gm-Gg: ASbGnctPi34zSNYZ3oX77i6qKQKkPG+gPtYKVolhfNu1bdvrXWWuHdJR2BsgCZO90UT
	7fGyBk4hzSlkB5tvrJcL4dW7s9wDHezS8yh1GSf4himKwwDOrFsRUdQHmJ3dYFqDguruwgX6vF7
	5+BsaJi7mgwaqIS7gTrUdcC9tfGid3FZsRbphjU4SP/SU8psRxVULJ7Boma/J0YVa5vZsFkrBzk
	1QUuec6y9kR2nSfvTuAJpwT67647qLw+BDFAVdCR64U3Mqw/39yIqJ1ItiGLvcLtfrXXzlPmtny
	UQtPMqvo/ustoFv5yig70KwcgfjvjUKc92gOXOccQlvhQPZhEXo/n1xufa7HgkWPlcRd2GN80rX
	fp5S3VnpSK52sVXOuywxqmti7h+oPmE5k8I/V
X-Google-Smtp-Source: AGHT+IFmI9lsLSelrlXNTkZLM9b4eUOo9hiI5OtwlOwTrQteFG5b2FVPsdiJSMZJksa4XHowoOhqRw==
X-Received: by 2002:a05:600c:190b:b0:453:dda:a52e with SMTP id 5b1f17b1804b1-4530ddaa8b3mr46205255e9.33.1749495153437;
        Mon, 09 Jun 2025 11:52:33 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45209ce1f34sm120208615e9.14.2025.06.09.11.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 11:52:31 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GDB patches <gdb-patches@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH] or1k: Fix ICE in libgcc caused by recent validate_subreg changes
Date: Mon,  9 Jun 2025 19:52:22 +0100
Message-ID: <20250609185222.1538148-1-shorne@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit eb2ea476db2 ("emit-rtl: Allow extra checks for
paradoxical subregs [PR119966]") paradoxical subregs or the OpenRISC
condition flag register (reg:BI sr_f) are no longer allowed.

This causes and ICE in the ce1 pass which tries to get the or1k flag
register into an SI register, which is no longer possible.

Adjust or1k_can_change_mode_class to allow changing the or1k flag reg to
SI mode which in turn allows paradoxical subregs to bre generated again.

gcc/ChangeLog:

	PR or1k/120587
	* config/or1k/or1k.cc (or1k_can_change_mode_class): Allow
	changing flags mode from BI to SI to allow for paradoxical
	subregs.
---
 gcc/config/or1k/or1k.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gcc/config/or1k/or1k.cc b/gcc/config/or1k/or1k.cc
index 62e2168e0ee..f1c92c6bf6c 100644
--- a/gcc/config/or1k/or1k.cc
+++ b/gcc/config/or1k/or1k.cc
@@ -1408,8 +1408,9 @@ static bool
 or1k_can_change_mode_class (machine_mode from, machine_mode to,
 			    reg_class_t rclass)
 {
+  /* Allow cnoverting special flags to SI mode subregs.  */
   if (rclass == FLAG_REGS)
-    return from == to;
+    return from == to || (from == BImode && to == SImode);
   return true;
 }
 
-- 
2.49.0

