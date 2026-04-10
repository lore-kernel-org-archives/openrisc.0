Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDCC3DA7F1
	for <linux-openrisc@vger.kernel.org>; Fri, 10 Apr 2026 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835133; cv=pass; b=c543u1Iw9fWF1YKyY+3HbRzzNGQ+VEvGwRTBmcWnBNPs7w/llH1F5t3O3emPIkwuYghIZlEyo74STx6Ry8sNTdvCX5Ct/huuE+7QcJrGVcsiUMqKS8gTTnYr8O3q8nGrlp4PgbLcWzEouzx5LxJcYnjO10cR9iOIXvL9CMfPNaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835133; c=relaxed/simple;
	bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQEcVluRzq/5194PqeO3Fq4KS1hdM8QQklAzH6EXvmELEJOkk/1IUrKU/qYvXcFoet0d7se4RccrkB3GE7w5l5NDLSDXahzDWE1z8wKbl6vuv4Rsp5wqhp1cDf/GG8hjmUgB7vhWZJOYcUSC97IsNhhQLdRZektrrlB+M938yqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=cs+zJ0r8; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="cs+zJ0r8"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c1a170a50so2014869c88.0
        for <linux-openrisc@vger.kernel.org>; Fri, 10 Apr 2026 08:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775835131; cv=none;
        d=google.com; s=arc-20240605;
        b=KmeLArmMTbKEAATYtkitqB0Fh8Q58zPwVIRAoY08eqj53hSw4aQA4CVNGXliwItu9P
         3gQSMBH0u44p7BBeD26At0huo95GeBDP/UlKWVY7rPBGvYVoAZS6kzsSpfp+Q5cdxd6n
         KCDRcdu1Zgvj9zQmKnNBvnskwcYXd1hI5g2mZoJ45p5WBWhjdzvQ++pnp03G0Ecd/pkL
         vWN7289ZV0I62C+E1JcJc6dWEMmBWH+3osGbbhBEM5AorK+RE6Dzug0CogXK0/+lNaTS
         b6oKyeGqFRYSRO1UMMQCPIuQE0dVWpO+Q+U247NmbYyNm7BZ30q9tO+xp6X0XEQFf/9h
         JH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        fh=1hk4V3E51xTnAONt7GM5+1uOmcU9f6k9V4PEGFdtE6o=;
        b=QMLudqugCkxIWkfu1JlVYU/k/zcMOSaJfI7pQPa+4pbJ9LRG9y+Zon/jQ+Jc9bOB3T
         +DpX6J3Lm4/Fn8mqCDBIFeCwoCyxQqLX/ZIo5JXn+w3ZJ59tPnDc6eqGMuKdbLt6AhDL
         N7edIjTe0ADLS+lOLdrQncT7hP8DuR/Pl579LJ8Okk4xbNALhH0161KO/kV0yXdTXrn5
         lO/YgZPbKmpiOLBteS0D102u5xNTgBEVHzRfrvBL7z5srYJQwfaawPC+kQb6AkwDtxOi
         3bB10aLQ7Rt0P+Ou4cM0R/zRxeiMqHRvznAECCElq2SYzQOQKRDo7zJDlG0pocjpgUer
         ryJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1775835131; x=1776439931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        b=cs+zJ0r8E1VxbeERL/6orYDfRzBNN0xV+FBDuuOmam2/EuHZ7scxaUctzZ3REo2LBr
         KdQSu4tLtUeUQ/Am7PGmtjXBLQ/7knpdVClf5erC+tpkhYxe59BfVvuW88STHDIDr49T
         TpKPrBeobAalm+DfnxseCj+mCeyPg4AFXq4Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835131; x=1776439931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBQJPBhzAm5teFuL1it4zrQEsej5woZw67yMwyO4d8U=;
        b=rfBGJHcQmjKr9PNuF7Ik9xnc/OfxSm3tFJ64Am/cLWQYY6N4taB3kmtzGC63L1R1A8
         G8IMNHYIi21IGL/P7cewhu2OXoOPVRrFjW5g9UJbqXricrDPyrYVnv0WiyYGvwN7affp
         jn/89I7eUwZwFuymjFeUmNOZC1ldgjsH95dckxjTVphys2SKCqLo0RpQ1BDK5LMEl3it
         xCw9JCz1e5CCz4XKkGKg2ivg+1BDCjRiS0KTOOINilEHYYN8gpKhRNcWKpuTTfMEN9gF
         sFPdSLKhfTWP+b33bU7HGMeclY6hfcoVwKI/uTABd7DYfPvNATFlApQJybOLFYLRdBx7
         9KmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4NZeaTV41zXdpODxZBf7555HQD6oSZ/sJBbyH7Jl88wbQQ4Bb1+LD7znEtuRf+OTUby/4LVlTZfznA4ewfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb0tjrmTUgdA2W/DNFbGYeSrvUM9MK+JKcfuQI7b2k/upchGgU
	no0WTXmttPolGxfa0KT+doOmbw3QpFzix0GlWP2BGCvJP/Qmo8q3wQ4F4PqtRCJiTJ1n2IEDCAn
	RPz7jQaw72ExGTcI5+Vdz59Ala0D2C5hd2X3pRB4uAw==
X-Gm-Gg: AeBDieszqpQYkz1DrkkXkn0TY/eV4+Fse8xH+uw+590bHv0R2XCi0zQt1iU/WCNpj8p
	7TazIB/4R+KluhKtc//wErqVMwXWaDwavVQlDjhdAAJTBszP5QWM7OGE2ThLGoifpc30S9zH4Ss
	00lXyILZBm7Ey7SM4/GfdsjXXOhYtP+eA2BqNX6+VlM3c0WEx5nO6iua/Dv4ZK543LSBWgdNAfW
	y4fk5OYJ7sGwZfl/JnGC6syhTMDj2pz6bVnMbR97My3fWXRe8yIjX04gtm8YZd2GBaRhTtuId/K
	doJL
X-Received: by 2002:a05:7022:6097:b0:128:ccb7:7fa3 with SMTP id
 a92af1059eb24-12c34f069f8mr2159203c88.34.1775835130696; Fri, 10 Apr 2026
 08:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120319.397219631@kernel.org>
In-Reply-To: <20260410120319.397219631@kernel.org>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sat, 11 Apr 2026 00:31:59 +0900
X-Gm-Features: AQROBzAnX-XEClLFV-qWYFUzCuq4P43sNZviESiWFI1yCPXm2VtVZ2QkaUGJoPY
Message-ID: <CAFr9PXk7qK8-2JWrrfgXHoS9JWTRL+WobLjmAesyCE9VLL8ZyQ@mail.gmail.com>
Subject: Re: [patch 27/38] m68k: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, 10 Apr 2026 at 21:39, Thomas Gleixner <tglx@kernel.org> wrote:
>
> The only remaining usage of get_cycles() is to provide
> random_get_entropy().
>
> Switch m68k over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
> providing random_get_entropy() in asm/random.h.

I have built and booted this on my Amiga 4000 and it apparently still
works so FWIW:

Tested-by: Daniel Palmer <daniel@thingy.jp>
