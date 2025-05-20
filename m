Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B35C1E5702
	for <linux-openrisc@vger.kernel.org>; Tue, 20 May 2025 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747726749; cv=none; b=gdrF6ldyO1sHLN9GJNzwLKH4HTAqikL9r1YZORGdBYbJzxFJXc1kaN+7f9lgsN/Ol/s7RrfOCXG42g2vLnoU/KA300yY4dB9fuB4QYb8tWOTHAnBeM+GBFXls152ADNJV5FsrsrYKlFHLSaLygmVPN8aUgndrTeDGKa85Ty0hgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747726749; c=relaxed/simple;
	bh=v/Uj6nwrQaij9kcOBMimmKpNeHhBXlq3xaqchHGWz+o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ImIprypYIyUczIPHV7st4ZfX59jTP7VB94q/8Vn4WWv9kieMERAFpTHiDzdgdzBextzyk4bIks1j4GC4a1vT/ZA+H9HrlRhzX0LLpQ9E88vUSMuU1DROBs7xOGlA5RwYuil0X/75gTZodofKGRzd4soKDW9q5QuCTXvh4AY+7gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dofsQfub; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dofsQfub"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad572ba1347so229929966b.1
        for <linux-openrisc@vger.kernel.org>; Tue, 20 May 2025 00:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747726745; x=1748331545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v/Uj6nwrQaij9kcOBMimmKpNeHhBXlq3xaqchHGWz+o=;
        b=dofsQfubazAHLBeozGbQtjJzDiD7OHobn+WJ36Z9He/Qb6fQMQI5YWdiSoHb47rJ4z
         C6HDPJMf8iIjAJuzYpo38b4QCJ5mZA6byJexMBBi2Jv5XdzI60CLtyPB7NWciPgtl9Qi
         veC+MJujiW6j3sa8lvW69+X+TpWQPlx6KoxU1tKPMdymoB1HTqgp55hNmOCpKV+zOeDJ
         7PeXXRFhjJd282iuAfGvF1UTN85cRHa2GnLU2i+NwqQKYI39eQY7lLTjY2IDkT+ByKcZ
         R6fqCVXv4X5ft2F3Kd7jLT/IW1N+yGkzamQj8MQesU4O2tHbLU1/3oqGzgjF/L4BHRKx
         ndRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747726745; x=1748331545;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/Uj6nwrQaij9kcOBMimmKpNeHhBXlq3xaqchHGWz+o=;
        b=eapkwRcy1uZkEgGpvfts1QmnDDgKL9fuIMle7jXZvJtTehOneEc2gOHqIJ297FkAf2
         cgI2dScEv3I+cTQBp0B2wuw6c/WvMUYS2CxoTkJhen2q8HX9XY5GKIsE826ldPTk4BPJ
         Q3WBcN1YY0Qj/zJfKYzTMpKvBwOoOeJ70dMOo5yaFPvNwSqTm+P9PYJZogKE0Qo6tUxX
         knolLS5O9TccvqI5AZN4WFpi9y9tSGJmbGBlZwtSYNduwv7KRkNNN7qSU69Bqs8Hx3sF
         Ay6+ZicqYphFvuPpDBXUUS8PFb5+4/5lfQwaNrOZelPKkhk3Ff3rj8kYW4oeyYMwvhuu
         433g==
X-Forwarded-Encrypted: i=1; AJvYcCVupjJdJwECcFFrK2Qx06ZhSTHQGR1WrsmZogE9R8pUfyi4AyM0j5eXojxHDh80VIOjrebaIcASVj2C0uljBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCR0w/g1TCxC8Pva2ryjsue0HWvu8GI41UEcV6bz3+b6ypOjx2
	+SohRlFAB+obyMLTwhIsEwvupUPqcSCevSHjiMoheZfs4GPTSZ3s5fCDwG7WhuBaEjsJffLYZbS
	SUnIBge0YkAoYl6LQXOkqJKBn81MxnxVhL7db3zedhA==
X-Gm-Gg: ASbGncv+R7Ijn5Oz333laJWKCA5WQREL6mWDmRUi03u8keiCcOzWG7y2jbypJ0BUWiC
	oSH7vLyzvOOsEYcWB13jQcrebJYxGdoFlnzRtSZkf+bUTHG7a46LMnRCLawyidr28sU3mKkyClS
	tgWymlinglE6f3noN/68oczxgLjuczXlJijQ==
X-Google-Smtp-Source: AGHT+IGyyUSETkUgn7h7HkvzkDtG91+dPJI2Fz/hSkHTB051zuXqXFHoDPRJtPNYT1HKF7JGIVgCwvu7WUPA1aii5Sc=
X-Received: by 2002:a17:907:97c6:b0:ad4:cc66:1524 with SMTP id
 a640c23a62f3a-ad52d609746mr1528648466b.54.1747726745393; Tue, 20 May 2025
 00:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miao Chen <chenmiao.ku@gmail.com>
Date: Tue, 20 May 2025 15:38:28 +0800
X-Gm-Features: AX0GCFssMX8JzAWAqAxlw_q-OfhHMEvASKfG_DwZRNk45Gsn2qhQKGNIFo2K3-k
Message-ID: <CAKxVwgfv8+wSHpEndr_RT3duU0U7dzNDRJROFtGnhpmVz1SBkA@mail.gmail.com>
Subject: Need help implementing text_patch for JUMP_LABEL
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: Stafford Horne <shorne@gmail.com>, Linux OpenRISC <linux-openrisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

As part of my participation in GSOC, I am currently working on
implementing the jump_label mechanism for OpenRISC. I have already
implemented the basic functionality of jump_label, but when working on
the arch_jump_label_transform_queue function, I need to perform
instruction replacement and writing. In the implementations for the
ARM64 architecture [1] and RISC-V architecture [2], this is achieved
using text_patch [3].

By the way, ftrace also relies on this functionality for writing
instructions [4].

However, after reviewing the OpenRISC architecture code, I found that
the text_patch functionality is missing. Since you previously worked
on ftrace, I wanted to ask if you have already made progress on the
text_patch part? If not, I might start working on it myself.

Best regards,
Chen Miao

[1] https://github.com/torvalds/linux/blob/a5806cd506af5a7c19bcd596e4708b5c464bfd21/arch/arm64/kernel/jump_label.c#L28
[2] https://github.com/torvalds/linux/blob/a5806cd506af5a7c19bcd596e4708b5c464bfd21/arch/riscv/kernel/jump_label.c#L45
[3] https://github.com/torvalds/linux/blob/master/arch/riscv/include/asm/text-patching.h
[4] https://github.com/torvalds/linux/blob/a5806cd506af5a7c19bcd596e4708b5c464bfd21/arch/riscv/kernel/ftrace.c#L91
