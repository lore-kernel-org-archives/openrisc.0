Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F139520A5FC;
	Fri, 10 Jan 2025 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504590; cv=none; b=A1iV4sQwy4fuzujwU79U9F20E8kCjDNGk+xIGt1Y1KBzL/iDGD5281k049+bSM9CIrBU2ApHYRYEgITYE7rqQOq2O1CrB9PIeubhsto3GzXPgIrd0uq+C6FU0dqOlXsVGOFJBgubIOLKxiFuYtuw9LVByCezLpi51KG8smjcmWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504590; c=relaxed/simple;
	bh=rqggyW6QZm407UobnUyp1FVC7BFjRNq4aag1f1kCSTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALWc6noK0pqEN09cloXLRkmk9ytTbKEaRdz+D0NxrrzdC7JrcGFrKYfxeHDnubjTWUdPKtnkKS+CXomKDFxmHipzydg/2y+eLg3ENp4ZxHzpY+Yd8m54d78Gpq961zO9WKBnpf0dmGdNiPs5ATPyC8+wb28XetwJkGWyvZPGOlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNs+1S7y; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNs+1S7y"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3863494591bso1040624f8f.1;
        Fri, 10 Jan 2025 02:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736504586; x=1737109386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uptf3GXc/k/u9e7lbAQhZINoMQaRjvXtjGmMCYEc/JE=;
        b=bNs+1S7y8xytKBRCD5lws4rSenniMWMp2EM277yJLH9OQWsCjbQ6uSYUlgkkvZ2GJc
         va+70G8FbEM36fz6NfGeQqio6udBi0Rmj7w3j3XIbZ4iSw4V/nx2tp5KUVMaI3xr4SOm
         zJxLTL7Xn+vYdBG2He9zkoz5qtYI0RJa52VYJUW+MueGSThKLRsXZz7d9mG6Y5AF/9E/
         TPqoFQolyYW2N7N0unUfcb9QtZVcXb743AvFPcLoLuETn8H9CkL7jvgv1JQD1eYxQhBs
         oTk2gPXYJSI6RZBMY0mun23yRsQaqlkn5REowiJR1tM0aQSMM0kbgtWrAuI6+kihjbGD
         KAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504586; x=1737109386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uptf3GXc/k/u9e7lbAQhZINoMQaRjvXtjGmMCYEc/JE=;
        b=DzdwZdaP2l6fhJb8S4meDdDSwwRT2GaFgl/H4kdED5CumfAWcEERz+Ez3Q+HBvs1fG
         vM/t8jgocRNQbfJEw75Q2djUN7HMW1+dWhergZLElcBLZVXV5uml36Cc5tO7NnWnnjyT
         pdb2+11O23NsSdbXto89Dt9ypD7mw1kq/6RoZbmSLrXLRTEw0LfAkhyrMsG8OHn78/gW
         CuIQqmU9Ql3Nbl/697GW2EnULFYIwpQyUAdFAjIxLl5pUHTZnoht0i4U9zCP/sOiAyyQ
         7aSrkhIpkan5SOZ9LXMaYZzXHxl5fnyMsvDVXQppZly1qTLUJi+/mYeeFEa3TlzbDlor
         fRjw==
X-Gm-Message-State: AOJu0YzlM+QguXuzaT86KM0cTroskuUX+dqBadoU8rJW54TMe+KTPCKP
	zUsqtFwa7+hznjM1U0Yz+UlZrNn/kX39c7aSrJiDxyj0fpcM4jzJJHBUzw==
X-Gm-Gg: ASbGncs+jtWyW/M/W8RZkwV08xE2FyevxfMewfC4HDmqCHRNGm0GISoprY/GWAclsjK
	JIq9U0KLIjKELsn2DQ29c4uc3P/XiIDgQDzqjaxe3ITSpun57acJL4gdOyZzqZ3d5ikh1XruWFU
	CDvaWQk7x+cBjxh2o/0zq12X0v2cMn95GAKzfoVi8KMUMeTPuhItPK/D54AtZiiR8jmL1kV6K+a
	TNYzy19viOxFk94PJNHkaXFrZKzNOurPfFTHa1Pt6HJWnQReYQJNKaNT02V+z9L+gem/STLiJpa
	00rWVpBkPuMIkwvoTPck
X-Google-Smtp-Source: AGHT+IEPudct7hjeXT2efX3Ffw4ABkF+MQ0uNBX6Rjj4y4YEv3Pr5n0gzGpy3z45iBW839P4MKeRNA==
X-Received: by 2002:a5d:588f:0:b0:385:f062:c2df with SMTP id ffacd0b85a97d-38a872d2b3cmr8354456f8f.11.1736504585889;
        Fri, 10 Jan 2025 02:23:05 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436dcc8ddddsm74859185e9.0.2025.01.10.02.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:23:04 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org
Subject: [PATCH 0/3] Add OpenRISC restartable sequences support
Date: Fri, 10 Jan 2025 10:22:42 +0000
Message-ID: <20250110102248.3295944-1-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds restartable sequences support to OpenRISC.  This came after
discussions with Michael on the libc-alpha list where he added some preliminary
rseq support [1].

The changes use mostly the riscv port as a template.

The patches were tested with selftests on qemu using my glibc branch containing
rseq patches [2].

Note the RSEQ_SIG instruction I chose is a `l.nop 0x35` which is just a nop,
which is different than most other architectures that use a `break` instruction.
As the signature does not need to actually be a break or trap instruction I
figured the nop is good for this.

[1] https://gcc.gnu.org/pipermail/libc-alpha/2025-January/163504.html
[2] https://github.com/stffrdhrn/or1k-glibc/commits/or1k-rseq/

Michael Jeanson (1):
  openrisc: Add HAVE_REGS_AND_STACK_ACCESS_API support

Stafford Horne (2):
  openrisc: Add support for restartable sequences
  rseq/selftests: Add support for OpenRISC

 arch/openrisc/Kconfig                         |   2 +
 arch/openrisc/include/asm/ptrace.h            |  73 +++-
 arch/openrisc/kernel/entry.S                  |   4 +
 arch/openrisc/kernel/ptrace.c                 |  96 ++++
 arch/openrisc/kernel/signal.c                 |   2 +
 tools/testing/selftests/rseq/param_test.c     |  24 +
 tools/testing/selftests/rseq/rseq-or1k-bits.h | 412 ++++++++++++++++++
 .../selftests/rseq/rseq-or1k-thread-pointer.h |  13 +
 tools/testing/selftests/rseq/rseq-or1k.h      | 181 ++++++++
 .../selftests/rseq/rseq-thread-pointer.h      |   2 +
 tools/testing/selftests/rseq/rseq.h           |   2 +
 11 files changed, 810 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-or1k-bits.h
 create mode 100644 tools/testing/selftests/rseq/rseq-or1k-thread-pointer.h
 create mode 100644 tools/testing/selftests/rseq/rseq-or1k.h

-- 
2.47.0

