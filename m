Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A72D258ED1;
	Tue,  9 Sep 2025 03:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387576; cv=none; b=J/RcH1PbP8eg/xM8jH7NHgU9Xu9yBr8E+V38PMcag8I8M7SYzwMiwSHa4TQS3Hjvs3lSgALyo3JHTN8RZU4l6EVHRogx8Lcpwb3I+ubKu7EMNZT/4ZQtmpqmX5vpJ/98wEPiEbp9cCMh/X/2uke79Bg4dvOk3tBuuGqx7FpzKWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387576; c=relaxed/simple;
	bh=GAwobPwuA85RVDEbV1UybaTXhbMjkEmbYsUKz2pxb+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m5qIqfJ1sYH+H0XRhytT/5EqqhCAlOChZsh2tZVmXwr2HR61hiHkN0WBxuMVg91zzIId2gZ2al5e0qF7Qc9t1gVs5gr1s5gQ1oE4WHxBfg3HKbwA6xu5aAH4RptsUuNy/Jdvp1jD/w5Bckym0AEFboEVFF4QMI9z1KPHtTbSy1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKArTmPg; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKArTmPg"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4dc35711d9so3571343a12.0;
        Mon, 08 Sep 2025 20:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757387574; x=1757992374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X3Sq71tfB1YOvylIn7CwbEBCJqtla2hsO//XX0YPit4=;
        b=HKArTmPg/CGWdY4b2/GvoqgdCryejnb7XOhK1qsPVadqV2juLIR1eEs5/5iILasvqY
         eunSfFb4pINy5yK12YOKbzRD2x5RDT2K18odmtfTVhQ5ucmBWiRK4xUxcglYH/9lxn1J
         480b+0D39dRpMpDqk6D1jWrNw5TBuIVimPk/Mfqs/G1cArsWYXKsC2SIOCL1kUEk1uV/
         NFhltCNdq8wNtP6yud4yPTeZ+nMw0kfzDeOW1DM++jSU08hr/R4LVxANnzjatD0Ck2ZC
         D3h8k/UridqSZBkxSAYB1M0TTjTyANC3fM6eUQaNdx26JxmpLuBbbUMlfv5Kj3bQoxp1
         Eyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757387574; x=1757992374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3Sq71tfB1YOvylIn7CwbEBCJqtla2hsO//XX0YPit4=;
        b=RKd489eqes00cgOZa+m+li/I1f69hhWiDR75xy4QuzKgYLnrLh/qlaRBMg8GN/Gw9M
         H2FyxmLP1nNc0UHNbQg7nmbhp6aubs0Et1qxzufCSftJfjQpA6GRpetqjUDwTjtO0mQt
         C4k72jmw+D7/7QNDtl/cwjMrEtHYQDPW1/ch6s9NXbGNPdSqp32ajVk/Nirjv06ewGn+
         tDRRT3wcPC8Zk9oY2tsgXEUKPvJAbkW5m3MuZAlq0N64GsVpCmpqDw4IRAODfe+DRbb0
         vPrnAoAqxK/JpSm4d2hv1Tarxqzq6GBUzNFZMgvlQ4ZwC9UIdJxUjqYn9F0H76YMp4vl
         WqZw==
X-Forwarded-Encrypted: i=1; AJvYcCUGHcI75yW/pZA/nwdaHceFFHd6OMHWGv7uOE5d3z59/COLMWPRFRC+Vr1N4soNYsFJMRaDh1KAgG/MysaNjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb4n2s0o3G76C/vPZGSl4pM7MO7BqexXAkpH7JqWIANte+h2Km
	EaFyAKFZVnXHpXCL4Wq1qxRyz9Yp+wYj19Z6fOuj2ddR4Llxky0Ui9zMoxLq2kfsDHripQ==
X-Gm-Gg: ASbGnct98DuVuExrnSVHoWo2TO+L2kTGIVQPuhfTLu/gC0tjpy4FC1w+XpmLygYDXui
	n2Jz+HKg1gxe5pz/GbXmt98tb5K8fzZSQFsvsB+BngKl64Q06R3H5rdE6N+Sab47jUZg87Zs0HL
	E7Pl2FTaDMTd8l1xb6dJ7fWIb6VzF7R6Y7cMTQKpiNBaNeyMj04CWrT6DgnstJlrPo8o1vUMpxS
	uVedjH//XLwSaYhhFcM/UHyUpoDzf3BNcm6yHIEUrooDL1WPTitqA1PfPzHd699Oqm0Xh4vg1NE
	skmTVw7Dnwna+Buw8gxKewXtipTfq6qBEW4aZjADb4DQcetFPkAPyysohH4ls/du3GGPXrRNxY/
	Ni7dw99CRkG6czp8WA+CP7BU547d8
X-Google-Smtp-Source: AGHT+IEvkv2Rz+WM+xGIIqJN4TB9s7Jec0hXu+EKbiu7rA/xDJIjdRIIIFOVqsuuIa87R1FRsu4ndw==
X-Received: by 2002:a17:902:ef4f:b0:24c:7f03:61cb with SMTP id d9443c01a7336-25170394a4emr145849135ad.26.1757387574050;
        Mon, 08 Sep 2025 20:12:54 -0700 (PDT)
Received: from nyaos.. ([38.207.136.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24df9e881casm100456855ad.62.2025.09.08.20.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 20:12:53 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Cc: chenmiao <chenmiao.ku@gmail.com>
Subject: [PATCH 0/1] Add the basic static ftrace support
Date: Tue,  9 Sep 2025 03:12:47 +0000
Message-ID: <20250909031248.591433-1-chenmiao.ku@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: chenmiao <chenmiao.ku@gmail.com>

Hello erverone,

This patch contains basic ftrace support for OR1K platform.
Specifically, function tracer (HAVE_FUNCTION_TRACER), function graph
tracer (HAVE_FUNCTION_GRAPH_TRACER), and a frame pointer test
(HAVE_FUNCTION_GRAPH_FP_TEST) are implemented following the
instructions in Documentation/trace/ftrace-design.txt.

Below, I briefly explain why FTRACE_GRAPH was not enabled.

During testing, it was found that when fgraph is used with static ftrace,
it calls the ftrace_startup_subops function. This function is used by
register_ftrace_graph and always returns the EINVAL value in the case of
static ftrace. So, we disable the fgraph. *If re-initialization is attempted,
it may lead to severe consequences*, leading to the following issues:

[   76.040000] ------------[ cut here ]------------
[   76.040000] WARNING: CPU: 0 PID: 140 at kernel/trace/fgraph.c:1328 register_ftrace_graph+0x750/0x7e4
[   76.040000] function graph ops registered again
[   76.040000] Modules linked in:
[   76.040000] CPU: 0 UID: 0 PID: 140 Comm: bash Not tainted 6.17.0-rc3-00014-gda230ee3ff1c #1 NONE
[   76.040000] Call trace:
[   76.040000] [<0b43fbe5>] dump_stack_lvl+0x8c/0xc4
[   76.040000] [<d2655aeb>] ? register_ftrace_graph+0x750/0x7e4
[   76.040000] [<22405ca2>] dump_stack+0x1c/0x2c
[   76.040000] [<04b97f00>] __warn+0xcc/0x1ac
[   76.040000] [<d2655aeb>] ? register_ftrace_graph+0x750/0x7e4
[   76.040000] [<34636c77>] warn_slowpath_fmt+0x1e8/0x1f0
[   76.040000] [<d2655aeb>] register_ftrace_graph+0x750/0x7e4
[   76.040000] [<94bcf66b>] ? do_ftrace_graph_caller+0x2c/0x40
[   76.040000] [<863d51d0>] ? _raw_spin_unlock_irqrestore+0x3c/0x50
[   76.040000] [<5e3d7fcf>] graph_trace_init+0x60/0xa0
[   76.040000] [<239e8587>] tracing_set_tracer+0x180/0x29c
[   76.040000] [<0bedd84e>] ? mutex_unlock+0x24/0x80
[   76.040000] [<21c17ace>] tracing_set_trace_write+0xa4/0x118
[   76.040000] [<0d244535>] vfs_write+0x108/0x5ac
[   76.040000] [<94bcf66b>] ? do_ftrace_graph_caller+0x2c/0x40
[   76.040000] [<c15d06f8>] ? fdget_pos+0x20/0x210
[   76.040000] [<bc6b8897>] ksys_write+0x94/0x150
[   76.040000] [<06a3d204>] sys_write+0x38/0x4c
[   76.040000] [<2cd910fd>] ? _syscall_return+0x0/0x4
[   76.040000] ---[ end trace 0000000000000000 ]---

Thanks,

Chen Miao

chenmiao (1):
  openrisc: Add the basic static ftrace support

 arch/openrisc/Kconfig                   |   1 +
 arch/openrisc/configs/or1ksim_defconfig |   2 +-
 arch/openrisc/configs/virt_defconfig    |   1 +
 arch/openrisc/include/asm/ftrace.h      |  29 ++++
 arch/openrisc/kernel/Makefile           |   7 +
 arch/openrisc/kernel/entry-ftrace.S     | 185 ++++++++++++++++++++++++
 arch/openrisc/kernel/ftrace.c           |  35 +++++
 7 files changed, 259 insertions(+), 1 deletion(-)
 create mode 100644 arch/openrisc/include/asm/ftrace.h
 create mode 100644 arch/openrisc/kernel/entry-ftrace.S
 create mode 100644 arch/openrisc/kernel/ftrace.c

-- 
2.45.2

