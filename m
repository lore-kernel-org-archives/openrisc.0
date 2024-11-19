Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768BB1D042D;
	Tue, 19 Nov 2024 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036021; cv=none; b=C2MMoVHTWpqGNBi2buRuY0mRION2vC7RSY1MuLv+BEfacCUbf3wMZvEc+PMrenWP+9uzTwmSlxFJLgD6drSaepPIGWsMzhgM5l8NbKkq+XFdTgXS9xXKOl4UNa9sdQf4X5Y1buz1u/LoCYU2zl0iBBxHk+3enToiPk1jqrXOAw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036021; c=relaxed/simple;
	bh=zYT3wiaJgNYtCgjRyWwME1lKWIKJCz8FmK1PV0TsVAM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=laZFCivMBxgnYiZ/u2WoXVvPHvrz5pjWHkly9WrSsH8ir1uWKyUUGqA6/7QojfwXKd5Qyl//Bu4VEtdpSHSfsWhor+2rmA2QIKuQNvjrPp5BouJUuuKp/PW7zKf3y66b2TQx/drrtLwlwFtyq1rdeRWPDNQQ0ChAQzJ/tBtnjsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPoyi1Ay; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPoyi1Ay"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so41069015e9.0;
        Tue, 19 Nov 2024 09:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732036018; x=1732640818; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LO9CBd645FQ9WAIeodAmDWjMjS8bkeVp5VXnKbmx6Vk=;
        b=YPoyi1AyO0z+7faHyqYtcUhujx1iw+UatgZqbaYByyWnkWD3cAR0NSvNrdOG2mYfDE
         X8/soXkAk2EHGaKkZEFASL1L9TnmWLayg9LopMn5xo3lExzqjEdzIVv5M5Rq697HWtX1
         CQ49dcaDF7jN0tUXU1bnOlo3S343IGQo0OJrC2UId5/ajf9uTtIALxpxP2+ZYvPjj0Zt
         +mpg/eJf79Cc73Wf4kbQJ10G0UJQCU9tbOQlXpdlqOw0Q0/XwTbuCLTWuPZWnqgXX6je
         DaY1Q8VsYXG2duL3Lu/117aBX86BAEIyDgToZizKMNjgckln987ecF1BaIJCOayT9pdo
         pcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036018; x=1732640818;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LO9CBd645FQ9WAIeodAmDWjMjS8bkeVp5VXnKbmx6Vk=;
        b=nf7dYxej6v1VfE6/4SDqTMQcFeBRx2YjpIm8SB+v8lmwRU1Z7jW/DJhD975kBi4xqK
         LlDN7i9l2xkdYS/Qw4HLRL+xQwfPp17tHmBEdqqrMGdMNxpsM0w3/+ODr23Bsla9f64R
         ypks/Q1f1af3JguMD01gGupHSe2VAZOVt45A4Naf2kr8KkFvfw1ZNdlRy7zxbKQ/z6ze
         i99YZgYYIoHhyIGGyWO9VoAXgBjK9NzxtaoFwuTqY0DM7EyzUBeK+Lq1jMD8gvg56vTE
         RPw9mvcihwoO7fwDg7kHRIyVCY+bZEdvCvC7xUvzZHL+A3WG6jtoV+gJpTQGEuzFpajW
         Bk+g==
X-Forwarded-Encrypted: i=1; AJvYcCUu9W5yEM/rxfMeJBNc9eHM/QBmoLAD2dYAiYkCOLmF9sv26ZdtnMrj36xXWrgatoIxQLwMj9bmARYID7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZMzkt+6vuRzDDZhxzHcZmnelxh2nRx95B1aXiCTcVB0P1YfZ5
	527lqo9GmP56oGZ3QOz1JoJEpV2NQyt8v9NJ933w2cq0VsxdwNc9E3RUpw==
X-Google-Smtp-Source: AGHT+IE6G8Ve/s0vmwsuGWjMWlgSdOuRUpQKkV3SdLyZuDwIrgRSJdAuvRyH0ozNGZ8s7Hbvke8lhg==
X-Received: by 2002:a05:600c:3491:b0:431:58bc:ad5e with SMTP id 5b1f17b1804b1-432df7901femr122285565e9.28.1732036017559;
        Tue, 19 Nov 2024 09:06:57 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab7220asm197413245e9.6.2024.11.19.09.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:06:56 -0800 (PST)
Date: Tue, 19 Nov 2024 17:06:55 +0000
From: Stafford Horne <shorne@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC updates for 6.13
Message-ID: <ZzzFr1e0ZUOcl_2R@antec>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,

Please consider for pull,

The following changes since commit 5be63fc19fcaa4c236b307420483578a56986a37:

  Linux 6.11-rc5 (2024-08-25 19:07:11 +1200)

are available in the Git repository at:

  https://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 1037d186edfc551fa7ba2d4336e74e7575a07a65:

  openrisc: Implement fixmap to fix earlycon (2024-10-15 18:36:15 +0100)

----------------------------------------------------------------
OpenRISC updates for 6.13

A single fixup from me:

 - Fix bug with earlycon being broken due to removal of early_ioremap.

----------------------------------------------------------------
Stafford Horne (1):
      openrisc: Implement fixmap to fix earlycon

 arch/openrisc/Kconfig              |  3 +++
 arch/openrisc/include/asm/fixmap.h | 21 +++++----------------
 arch/openrisc/mm/init.c            | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 16 deletions(-)
