Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB574439F
	for <linux-openrisc@vger.kernel.org>; Tue, 19 Mar 2024 21:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710884572; cv=none; b=gdYmAASEmNXA2L9FyA2x10e+0DNB/5VKNZtJLe0YzhHWunS8h4rH9agoTpmICESp5W86gjDRbYxtHzUojcuiX9ifXXlubV7JkK+/CStgsE63NNys6nBfRU/yIw0mvrwZD5qzy6RJu/GcyyfzZUQCfRbtdJgquK+gBO6La7fYla4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710884572; c=relaxed/simple;
	bh=JfDM7Rpu7BrNFJcdPNK6Hqao9VkGJPoZRkx/TcGH1Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a+bWv8lX4rcIgV2NRNOTkLxG7ovXYD11uVk+zs6XrW8alGivGUSz9df+dAbtsWiGjTeyt05y9TDQtHD6MSLMPZRXrLSayzZXnK7SAVLk1YcGeuKKrQtHY+qGNgkk/upn3+qGKp6bWLFGzrJTQPh8XXbWjf/55F5U1Xp+zQoK3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bmtp/dqW; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bmtp/dqW"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d38c9ca5bso2960333f8f.2
        for <linux-openrisc@vger.kernel.org>; Tue, 19 Mar 2024 14:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710884569; x=1711489369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=930mtNUQDsot0ayEO353sCcI8S+15b4dvnLyyF/yI9Y=;
        b=Bmtp/dqWOxgc91H/dP4Lh8livURX7OKlGypktvqNbELGc3wwd1tEXmvWiHeSPDLqFY
         ZIRjGt8Vw7d1BXcx3zqVP27yKeYzVwrnkxP7H1UbF0M/A2VVptUPs4Idd7usqUZAb9d0
         o7D2cT0Ij+0wCTKd8wdCSiApjMvn0o8btD0I08SqEzhHoTgQ5q/ZeHUQfjJeX3+Sp7dL
         TGU5ew0aH9KREaKkxy939TkiRr9XGsCpZpgY5srJtlp4Osk2qlg2fjp/5f8q8d2OuHMU
         sYOn5EyECfUaqiU7Un4Mn/mVvF6jNvWWsvqVm9J6yFuxIxRCD3FRQ/lnKn0QNkYikxq/
         AH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710884569; x=1711489369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=930mtNUQDsot0ayEO353sCcI8S+15b4dvnLyyF/yI9Y=;
        b=TkQJKegE4yehaYNqb1buVISs6hifL+a8eR9mG7AOrhh54MDcYVmHJDWpmJnIV5NYH5
         emxQeTs9on43xjCSn7M9054M5dfbP2lnvcDqm+UmqjqGR4d8sid7g8KxC/M4xekcmpa/
         mgL4uKW5fLWuOF3iYZi7CNEvSICMw+7CEhRDst71AlSboWIQfWVBal8Hj8VK3d1OrEXk
         aCZt/TeIZp5CZaY3N5ZAdrKmxWpoQvAaylO7cqvuu+6W9hsuPFTkOH2He+oVstbNtiKL
         7de2vBNapA+Scmvr4/+0nMBntXBHeFjORJ2cdoPlJxrRUX68JPkqLZilW1h8p20g3/Qm
         9HNg==
X-Gm-Message-State: AOJu0YxdoZuFwcOP9uy+HR3TFP9FEoeBjtppITcWybp75dKofivkqWJI
	ZLday64+/gKHhfaFs0yDYGc8PsO256O25oxxAVOkSppKgxxfw6a/
X-Google-Smtp-Source: AGHT+IEuFUgjW+MM+Y2OOdVxmOsFfzbd0tdz7oPU+lhirOq1p6zh8345QrH6peaOTxHT3jWJFwfMLw==
X-Received: by 2002:a5d:6b4b:0:b0:33e:1f2a:d88a with SMTP id x11-20020a5d6b4b000000b0033e1f2ad88amr182938wrw.69.1710884568410;
        Tue, 19 Mar 2024 14:42:48 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d44c5000000b0033b87c2725csm13206997wrr.104.2024.03.19.14.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:42:47 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: GLIBC patches <libc-alpha@sourceware.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH 0/4] OpenRISC fixes for 2.39
Date: Tue, 19 Mar 2024 21:42:40 +0000
Message-ID: <20240319214244.736981-1-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am preparing to get OpenRISC hard-float patches ready for upsteam and took
some time to make sure all the nofpu port tests are clean.  Running the latest
tests I found a few issues.  This series contains a few fixes for these issues.

Also, during reviewing the Linux signal ABI after Linux floating point support
went upstream I found the OpenRISC ucontext definition is missing one field.
This series includes a fix the this ucontext ABI breakage.

Stafford Horne (4):
  or1k: Fix Linux user space signal ABI
  or1k: Update libm test ulps
  or1k: Only define fpu rouding and exceptions with hard-float
  or1k: Add prctl wrapper to unwrap variadic args

 sysdeps/or1k/bits/fenv.h                    | 19 ++++++++++
 sysdeps/or1k/libm-test-ulps                 |  1 +
 sysdeps/unix/sysv/linux/or1k/prctl.c        | 42 +++++++++++++++++++++
 sysdeps/unix/sysv/linux/or1k/sys/ucontext.h |  1 +
 4 files changed, 63 insertions(+)
 create mode 100644 sysdeps/unix/sysv/linux/or1k/prctl.c

-- 
2.44.0

