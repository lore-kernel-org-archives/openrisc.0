Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE71E266591;
	Mon,  4 Aug 2025 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314009; cv=none; b=sdK+mYrxjjYQewKRlO/LEJCIucXmUW8/4mZfL2SjRoPEroIIb3YyDgRn8JiBNppNKxJWlRCiyShus192vTYRBZ8FEKQQI2wlADiENxB88+hDKGwOe0oIo2lXLg95QI1hsgOOY7uDyWEvTlugh3ga54ChyJ93DifAT8LSVXn6uBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314009; c=relaxed/simple;
	bh=w+ii0pd8WozqQuosTf9U0awjIZJs09ZlJiNWHUGU4Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YyfWg78NI8+8qU72A9VUJYn5a7ygSAk8J+6hqCGT2b5vbIAjpuq5hnDaWngzhlKlE38l3DUB23iJgxHz1CeV/s//L9paJ5KjfMULPXXkv+r1HWyQ79kPWFzs/Zx+npQ3dx2BNGVrlnAJCyeIi7uJ58bDHDZiqaSXOuqFvRw4sK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdIJoo7v; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdIJoo7v"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b7892609a5so2898443f8f.1;
        Mon, 04 Aug 2025 06:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754314006; x=1754918806; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=reX/TAZOFXiYMfg3d4WHcKfblCAmf27HtZVBbJ/eLkU=;
        b=kdIJoo7vNzHx20VG7MJcJw+/OM/Bc/eh2Yv4GVn6J+6SGBvnLu08KomGm21zjaR1xa
         6x/aPiYuC8Xc2MuGGzQnDHRNhnftHwZY2DY05Q3v2qpeivsgCmz8rRTnEHO8qt4xFthS
         nIunBEONNO6rZvBF73yay2HMtAJsxF4958N7QGe3k23xpmYiV8eFAujN1HNAVa9RhT52
         rYPHru7vnn1y6F/LwW1EMh1N2NOyoqdDhb9DPCQqF4PuV7enwneyEOMv8sdpIKj0zRUY
         dIh49fzsLFDe1JAorAH74o/y7RabI2zs9gYWkZxYMSe1hGQZjhgpcDhq8gQziT3KqQVQ
         B48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754314006; x=1754918806;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=reX/TAZOFXiYMfg3d4WHcKfblCAmf27HtZVBbJ/eLkU=;
        b=lsovt7pMz0WF1vRG1Edb4nUDO+gHAQDxZD+1/wthls7cWIO431rWfORnLRRvz9Y2ok
         px251I9siwFGaXaxdBHR7T1TpQxWoIjMw3anlull9pZnTP0TZBSdpOaqINnFEed8aJFk
         8bQssKaN+Wj48TiUj+4PII0tzafHmoPBcScumvaTTE/2Yu7fIwus5lleY4cOwB/0yy7n
         /kXmRcnh097+MrKyhdqq4N697Ovi0DNBI0ayjcKQS0exRtqIiYQIK07g5vOip7bGfGEn
         l6sbPbr1O537eT9/cSD+Ubl1/p+iucZJarHwA/N8FsDkba9/TkUg7XYCa2OYs2OxDfS6
         4shg==
X-Forwarded-Encrypted: i=1; AJvYcCXfZzLcetUWRLrIiDahVUD4kVYqoaZzwhhtwz+M7HQ7v3fcFeOEHXysdIezmpcJmEIkatStJjNWHE5ErhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37nix0m4VDtu7qYZRLjtHVXr4ulpfYJIBifizOYEMrxwLQhLJ
	Kny+WAbYVqvt5BvZfc4KvikGsnuY8Fmg56euwN6ZuBivt689nYCttubDX6Aezw==
X-Gm-Gg: ASbGncvoVzF8kEp19JlHCfObVogZrL8ne+rx79oVrhWoqfhQyNEZfZXNzNvyJdvWNuN
	aEMEnjBkTqJDdUNVShUV96LWPDvsIlCgzNElxNxRp1pHAp/plXMXjodXw18jPrtm90x8oFPu0yw
	+r7kSp6cLHCLUWhSFBo9JkkXj0n+7L1SGWP0q8TuHzWDSDc4xG1uJuc434bsAWtniKNPrVOidaI
	ERL/oFysSUQIFJdCOz59zKL62Rne8ketMsHbrLbuvyW+LOkSj+6alz+rbW/NIyzO0BoydoFWf3m
	8dbFme2jA53OByHJmtJMfrI0IBb1mz6VpfhAt81T9cBbH2V6oJzSBDK/ftQ3baPL8s4IWF74/BY
	B+IdFxeTquDVm/yFlYLe1Z2b2b+6JLwjR65UCENUvk0OYT/tb4aikdkO3fYmzSQ==
X-Google-Smtp-Source: AGHT+IGePy04TZReh5cEGG2tCgs8T9Of2PTfMaf7Lk3MAC06MK7gvV2Rra2wJbjl4AxLswQswICrRQ==
X-Received: by 2002:a05:6000:1a89:b0:3b7:9ae1:eb9 with SMTP id ffacd0b85a97d-3b8d9472f36mr6845790f8f.23.1754314005744;
        Mon, 04 Aug 2025 06:26:45 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530a8sm15542357f8f.38.2025.08.04.06.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 06:26:44 -0700 (PDT)
Date: Mon, 4 Aug 2025 14:26:43 +0100
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC updates for 6.17
Message-ID: <aJC1Ex3rjGT_-vxI@antec>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,

I picked up this series very late in the 6.16 merge window hence is is based on
the old v6.15 tag.  If you have any issues let me know and I can rebase.  But,
it should be fine.  Nevertheless..

Please consider for pull,

The following changes since commit 0ff41df1cb268fc69e703a08a57ee14ae967d0ca:

  Linux 6.15 (2025-05-25 16:09:23 -0700)

are available in the Git repository at:

  https://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to f0eedcf22581ca1cc438fb38a479ff41ab882d51:

  openrisc: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers (2025-06-07 06:44:28 +0100)

----------------------------------------------------------------
OpenRISC updates for 6.17

I picked up one series from Thomas Huth:

 - For openrisc Replace __ASSEMBLY__ with __ASSEMBLER__ in headers.

----------------------------------------------------------------
Thomas Huth (2):
      openrisc: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
      openrisc: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers

 arch/openrisc/include/asm/mmu.h         | 2 +-
 arch/openrisc/include/asm/page.h        | 8 ++++----
 arch/openrisc/include/asm/pgtable.h     | 4 ++--
 arch/openrisc/include/asm/processor.h   | 4 ++--
 arch/openrisc/include/asm/ptrace.h      | 4 ++--
 arch/openrisc/include/asm/setup.h       | 2 +-
 arch/openrisc/include/asm/thread_info.h | 8 ++++----
 arch/openrisc/include/uapi/asm/ptrace.h | 2 +-
 8 files changed, 17 insertions(+), 17 deletions(-)
