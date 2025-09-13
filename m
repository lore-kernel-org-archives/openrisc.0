Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D29B1662E7
	for <linux-openrisc@vger.kernel.org>; Sat, 13 Sep 2025 01:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725775; cv=none; b=r6RcrVh7UOyxjJ0SV7USijYqS01jC9cns4wE93uPg9S54TkRMpTVE2HJ3caq24y1I7NsURfhBnt8isoOIoMAygpkHLKxX+9nBML2QHz2eNSbw51+u7jmrti9yP6RLHyTPBWB9bKgKckDunR//SNdHt8M/vKdIp0BbbFddhFsSyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725775; c=relaxed/simple;
	bh=OB8rvKJ/i9Py5pg6KTYPvKorTOVHkmUl23UIALP6A5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UArl4q3JZIBEB9QYd5Xo66JWDreyLpRigQ38uY6W8pQtFwSMMIpOGcHFBo65adGHjY6ILLKDJjP4iT94yt1Lt7yDLbIHtpPc/j6I6g4jI66PKesw7gLrf51dBx+vwQodqNB3dwcxVU6OqmuAwYPYaWVggSm50DV7zPC0+LkbnC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a67LsgU+; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a67LsgU+"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b02c719a117so429932366b.1
        for <linux-openrisc@vger.kernel.org>; Fri, 12 Sep 2025 18:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725772; x=1758330572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pGfjPJCmTgFBTQIPRnE53dxXo3SbfDBvMh6uq5akyU=;
        b=a67LsgU+PqFcCyQYOwGfpgZYrvZLskJpWHMhCd23XBdT6GhY2QVzopMLEcTiTwcU8n
         aRXxksx8QL94IAJD0uxOztTCPgTj1BtWsyM/kG+nLV+TpshnC7uUxRKpC9wDTpLGZq94
         ZOqsUlHJQkT2klUn9663/rY9OOFnLqMxlMyaQUlsL96ITKc6UC1tGx3tp/iTsNpX/Gl0
         4qJb49YJJmcWjmVUIQnbNHgh0LOmGNGWxeSBQEvg4fPR2zxEy8hvhLyji2gZG7GN034z
         Lx6bYf49mEL+cge+EW32SYuLX3/YuiiyNTqmZ1EKoxUEqsDHaSGO3qHPWNhLDjtiY01k
         zmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725772; x=1758330572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pGfjPJCmTgFBTQIPRnE53dxXo3SbfDBvMh6uq5akyU=;
        b=lE54Hn6w+6KV72H1ai+XxQSDrrkDiU2NUo6aeiWJCeSStbPBDpyfEWdznzUbhboUq0
         3EYai+7HJgeCHGRiIbtBLBP2a6IvwzYhAWpBeOGMZxwIF3Jt/WW+13RadcbJJcruNU6E
         5dvjWLkNwK3SbGwvFh/uBzz8XZp6x3gn+fKvxaza08hmj0U8FYgZR3xOwecSxvxHX6Wl
         hIeKnNw9hvBB+1h1PopOPzh2LbmNep17eJyfJPJTD3ez42g6ZcuMiXGzXqx6+ABF7xEU
         Cj4iC/3gfuJwNCXtkKFmRENQ77M7AhQ6CrFF6c8PcxZqE+SP6SkkPQ9HzySkf6EF2kFr
         z6QA==
X-Forwarded-Encrypted: i=1; AJvYcCVOAIUPNGaboUV3xN8HPVnU6dgDgY/I2gSatKTht3LBLSlC+3qYj/v1kY0ZxEJ7bos8tql9Qg0fetc/zOsycQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuyyDYybml2AeHsBliGwxgGaKceKHtceJUNb/u0wMRTbuLdGnI
	j48w64XQ6UMkh+w112sBGovLWzxD266iAWrVGhki/F0jwE7ihYvEmlMl
X-Gm-Gg: ASbGnctMP4+hYwIYp6Xx4toyroU3gTHcLQWtf9IhJ7zZVnqf7Hlqcqk9c66GIgyEpVY
	9unhxoPd/tl+ODp9iWvF2QW5D5E5jIJ1UfzxGQP5l5XB94O7hAwpF2LLCzxPbKxI6k3kekH3BTL
	5MTISVNjdcPq5BqBfYrFl/eQMUduSniyF3NbInz678ceFrPVZQP4loUOLd9UuoJQTk9RQzskutp
	g0jS5OI8t3oKzBwnJCMSj3Ad0UJVJKjAn0RRJsT8GdSOa4kWyP2Pl0jW0wun3rcFewG1Cm/E18G
	qk0MZ3fQY51rgyBRrjA6NE+0KJmFk0jJtGmXmnJzX9iMAc20GXG7Jf3KmIkG9vxeGHlYjYFahFv
	hgCJ0c2ePYBCW/dRzKwg=
X-Google-Smtp-Source: AGHT+IHrHcZIQpP/M06nOcq3Snl8FXkxUTmgmKKbhKMXWfrO9iWe4P5Ilwjf7ocqvFrLGTk9+k818w==
X-Received: by 2002:a17:907:3d0c:b0:b04:250d:ee7 with SMTP id a640c23a62f3a-b07c37dca1emr487688066b.31.1757725771595;
        Fri, 12 Sep 2025 18:09:31 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07da7a8918sm104574066b.56.2025.09.12.18.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:09:31 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 27/62] init: alpha: remove "extern unsigned long initrd_start, initrd_end"
Date: Sat, 13 Sep 2025 00:38:06 +0000
Message-ID: <20250913003842.41944-28-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These variables already declared in <linux/initrd.h>, which is
included

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/alpha/kernel/core_irongate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
index 05dc4c1b9074..3411564144ae 100644
--- a/arch/alpha/kernel/core_irongate.c
+++ b/arch/alpha/kernel/core_irongate.c
@@ -225,8 +225,6 @@ albacore_init_arch(void)
 	alpha_mv.min_mem_address = pci_mem;
 	if (memtop > pci_mem) {
 #ifdef CONFIG_BLK_DEV_INITRD
-		extern unsigned long initrd_start, initrd_end;
-
 		/* Move the initrd out of the way. */
 		if (initrd_end && __pa(initrd_end) > pci_mem) {
 			unsigned long size;
-- 
2.47.2

