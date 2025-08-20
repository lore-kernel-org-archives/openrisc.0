Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6199620B1F4
	for <linux-openrisc@vger.kernel.org>; Wed, 20 Aug 2025 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755683109; cv=none; b=YJyPK9DB8kv/3MoAXEcR7Iavhhp2gVEFjBEWKCTUcWcoe7iOvUz1HaCEBHlp6auHHn9vLKuSxcfQl0nnNURhSTTKQQlDR0shW498rvZuxhqCHAOfCSneqUJAjVUW+icn/X3SgjeK0NZbFwFuO5jI1c4aGrEtqfCXSMpdqbC0K0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755683109; c=relaxed/simple;
	bh=SNEETHOosbwwJ3lFopRFnKyijEaXtAuzlyyIF8zdf4o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jjRhab0IBoX9apYHCcQYL2Au9VX93HvJWknKXZwBYLj9IBkH+k4X9m040VcsGI/8NVgKiZUqWEGbOK7HgfHSwGTjsxYl5RW1GaJ4+Vm+AE+Rerp08Rxd8KToYxsNSmAXbXKhI3V1y3++qIQYRC3jiXs2sNaB8ytDnPQP5/bFqFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EK/Hh5iY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EK/Hh5iY"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7347e09so1030124966b.0
        for <linux-openrisc@vger.kernel.org>; Wed, 20 Aug 2025 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755683105; x=1756287905; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SNEETHOosbwwJ3lFopRFnKyijEaXtAuzlyyIF8zdf4o=;
        b=EK/Hh5iYmad0ePZvKe5K4i8HCSNxwmqrZsbtLL9OZyoiN0vXPM1R64CV+IgBRrD8Lo
         +zXL1j2hITm4nHT0/taFUVtPgBKjsBAIDqjcYg0zNVb4oMN0pkyOvme7+A9w7McneERr
         FlsljfViYvJ5FmW0RozprlNbZsKBK1WqPcUBKM2WvO7G11fKncSTtTS/1XwupPnOkjy0
         coAZjKaa/2cV5lkQB4K98x9As8oiFTKzh+6DqSYmtSQcuc4iozHQ1ah98zXsLPUXQmyC
         15cEiAOPg7jMe1mVW0ItoUf7cQaqz0OQmGToVjMx/fea6D4IT2u3eg3sueVmOZGl1wbX
         SbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755683105; x=1756287905;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNEETHOosbwwJ3lFopRFnKyijEaXtAuzlyyIF8zdf4o=;
        b=CW7JId9C24+YL7NMrsBRrkAIIF/CV4opCQc/NmOhi5RcHw6Pfkl2is9NUZTs7Du2JZ
         OEwuF39SvelPpMxYJl3TMVUq3HJUGrUxdS5SrRmSi8EpYuTBCuwtvs7tsBG7D389iME5
         8U5Lhhy7fdzg1R6B9lPjJGQC4GbmQ6uwWEPtzIdl/GGdNKtV5IMmyZBaHj/qDvPcbICi
         +TrM1OFx27VYL/kAj4OOUOfO6fRFhc6boteRBv38mYwjuyRIcK2dJ3JE2YYPNkk+t6i9
         mXz7BX8lEtEUucXRXYFjmro38nZx2PiWSN3XRVZ4C9puYl5W61gYlCLpLvCds1m9G3cT
         f2XQ==
X-Gm-Message-State: AOJu0YzrO4oEaz3D/Y+C7UzP0sOjVJ1XkgC89S1facdVyJm44QAeoblh
	P4IqaTbGkcnl/jn5KHcpejU04cpDZBa2mAj1vdrCn5sS5lRkGBLt0Dr458FzUfKurVXbTkfFNej
	mK7jOInH92HkOm6OlQPmB8yEdRPxs6Bs/qAFdClA5iyiE
X-Gm-Gg: ASbGncvFbUVEXHBAjjYpTNyWaRJioK1NH0+y10K+AQ9o3hB1jQyws6AkPPkw5TQedi2
	rZ4zuAVIkKfUhifRJR5ByPTG6LBEY9bUgxY2db8YWcM8SjYWPRhyUR1pGu7L9JMbfBydAez5L5W
	HajAsL1M/yY9/XgnpK0nGaHA+W+f21vV4A5nbDBxs4kLkH5xKEPEPvc+H5JC7axaFMxNoc1Yy0o
	T7xuAGRIq2TEZpqLA==
X-Google-Smtp-Source: AGHT+IHT72QkCzf95QuWdxB2o0L68VaiLZsw0j22AhG+g+vb/Du93786+UtRlFZe9NV7f4nZ/Leon2f1+r9CujAPSug=
X-Received: by 2002:a17:907:3c8b:b0:afc:b13d:ea7a with SMTP id
 a640c23a62f3a-afdf020c2f4mr188598166b.57.1755683105240; Wed, 20 Aug 2025
 02:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miao Chen <chenmiao.ku@gmail.com>
Date: Wed, 20 Aug 2025 17:44:27 +0800
X-Gm-Features: Ac12FXyJSocbLh24Uzt3tric1YZLn2sAw3TalNpspTdtDH6a_dHugTFUDPr-Rfk
Message-ID: <CAKxVwgdr6pKEGUhS00B7ngvvpTky7zuGqjfcjOV0p8RLTob_cw@mail.gmail.com>
Subject: Discussion: Enhancing ASM with syntax sugar
To: Linux OpenRISC <linux-openrisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

This June, I joined the OpenRISC community through GSoC and have been
gradually completing the various tasks for GSoC. While working on
these tasks, I often find myself thinking: Is OpenRISC assembly a bit
complex to write? Yes, even though OpenRISC is actually quite simple,
I=E2=80=99m greedy enough to want it to be even simpler=E2=80=94at least in=
 terms of
usability. Therefore, the syntactic sugar here mainly involves two
aspects: *pseudo-instructions and register aliases*.

First, I confirmed with my mentor, Shorne, that OpenRISC does not have
pseudo-instructions. When I actually write code=E2=80=94for example, when I
need to load a function address and call it=E2=80=94I have to use the
following approach:

l.movhi r15, hi(function_addr)
l.ori r15, r15, lo(function_addr)
l.jalr r15
l.nop

If we had a pseudo-instruction like l.la(more inclined to design it as
a macro, since there are just too many similar operations like this),
we could do something like this:

l.la r15, function_addr
l.jalr r15
l.nop

Of course, this is just one example=E2=80=94there are many more, such as
loading immediate values, pushing to the stack, popping from the
stack, and so on. These can be left for further discussion.

Second, when writing assembly, I find the register set design a bit
confusing. We have SPR, GPR, and SR here. The SPR is divided into
multiple groups, each with different meanings, and within each group,
different items have their own specific purposes. For the GPR, the
usage is defined by the ABI=E2=80=94for example, r3 and r4 serve as functio=
n
arguments, while r11 is used for the function return value. Honestly,
I constantly need to refer to the ABI conventions under GCC.

This makes me wonder: Would it be better to introduce aliases like a0
to represent the first ABI-defined argument (e.g., a0-> r3), a1-> r4,
and r13 as the first temporary register (e.g., t0-> r13)?

For each register group, perhaps we could establish a set of
conventional register aliases to make coding more convenient. Of
course, this is just a suggestion for discussion=E2=80=94it might also be t=
hat
I'm being a bit too lazy.

Of course, our priority remains maintaining the simplicity of OpenRISC
while considering usability improvements. We shouldn=E2=80=99t make things
overly flashy!

Thanks,
Chen Miao
