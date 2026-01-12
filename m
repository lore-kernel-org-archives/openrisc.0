Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF908340A46
	for <linux-openrisc@vger.kernel.org>; Mon, 12 Jan 2026 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768206772; cv=none; b=KxkShv6kFeLo7pDzOB9w19EvKhX/NGht/Ytjt0s1Toaacj8OFdTF56vaz5xbK1/ZOk5j+WdaHI5EVDTJUUrXztx2QaCM14VWFeRfzU0Zcn69q7SF81bipAHFgDTl4tZpgBSh3VWS3EUGmGjGQYHl9e0vVPmNJDliRQTSw26t93A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768206772; c=relaxed/simple;
	bh=CHhxbYtVRJ8UvARH1WuSWqeG79V38j2YQwQMMpKhPlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEALEJS9shkrNNDyIpHAKXBXF1Gu9QgWYZNMsPKSXc9wd8Rg5nniFJvn3PgXplJ5uh/9S7HS8kub2YpqqP/fyoxxs267XGDvEK8+wlZySagiEqyANnbd82M34bE8HADi7iTsw2XsGdiZyDrPCDqkfQDmLHMP56z9KQ5EafdQMmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3yFqGeO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3yFqGeO"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so67019865e9.2
        for <linux-openrisc@vger.kernel.org>; Mon, 12 Jan 2026 00:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768206769; x=1768811569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p51irmMY54wjEoANrY9x5z2U+DeQ+nE/A1c1QJUgAvU=;
        b=U3yFqGeOJ/quAntAUd8gY5ATQsK3KjF7LZAeI6ly0pJlc/lUkNSOlkls8i1hUPZl2H
         x7t5mB9gQrGxk5yNCCC8owrgPj7QMYdInAI5UTndW03LQDe+kT9s5gYpfTcAjt/r8Cc/
         i+cmxW6Jf12EOSWe8WGCJaoeozL6F8c61PAu6FlW81CYHoyt8/pU3Dd9NfWii+JQh9Eq
         WuVZTF2H3vRFnyUBxLwCW5JYCS9Y6lVdahnjsb03bN/nlEUyfgSCR7lU9A7OKhZ7kCvU
         QEiE0DdlvALZ2YjjSFAOsI7y49nmcS3Ury/h62HduIsRBhQW1yVX+titDY26q428CNDS
         toOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768206769; x=1768811569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p51irmMY54wjEoANrY9x5z2U+DeQ+nE/A1c1QJUgAvU=;
        b=cJFX9lYdP7/NEiqVqHERC4PysCwA+2YoAZCt8H6zNn3JbAJHlovSs4sC3yjwDQ1bxM
         m+hRVwrgWMAvgzOjwT1ZQjYtlI+EXhdPGpxsk9h7w9TIQwxje6y6xw0CLg/UiupflxRo
         +aommX1swaMbPQlo9yhC1252PYK91pA88O3u+wGSmSYs7OhprJAAxRpcdcNTV4QO3qRd
         KFCcuEcCsgeElIIzJPW9MLm6wORLnR/3z5P4xm75SoOLPlZ8Vakbij4aUAyMCw2ST27w
         QVRTmnRcMt0+HMRduTdbwMVjeCChcDsQbiwRHv0SfwreQoot0QHggEgNTzV78kNKyIoT
         RjVA==
X-Forwarded-Encrypted: i=1; AJvYcCX1HgjkICGFthR93tXzhCK3kIunQJWdzOf0+uUBS3hn3RyFMbVh02aY3EYJ2BdMvMBboUKcblnMQKi8ibwrLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcrxEHNxDkgZb5PejknTPQBhNkrY2HLA12O/P2rw7sbLY6VkK0
	TglxCd/64sdanzV80sb76tlXlgeqPF3NnTyUT/DhB3JQKm5XNBERWHWF
X-Gm-Gg: AY/fxX5I+EI1GqT0SKDnGKCVcmYGgdZQ0AHPWSzjeMAwX6DZYkKMJ6cOVPu5yQJu9LM
	5BGmRBf8Aya0G1ElEEZ11PVDXP1zHndSxDeFZGostavhhwoMkzZcwy3ZuUBlQmHy1PCf/pGhyP4
	jimKgi1QdTGYT9HNWDVYomiK/l1BajTsVKjZoUb3VHpb496x+YbPWrfC062ONm8u8Jl6oGG/gSA
	tCCS2Pvj/AsyHpsJlS1xscThaD+uTsHz341AIH042OgbA2ZDPPUKyqOJhC9u+iDRsHLttxtA3zx
	Tbe9zr+OJhbAKlVgCYfGlp6OZEXHKas2rAbr8xdC4vnoJJPK5SrLkAR9DSGd3QAF58Bya3RTSD5
	IjMAj3g7KKcEWZscnmu+mHjKs3hQjjsQu+gok0n2YdyKed8VWvk8yV1brb8DLfGNqu13SuzbUdA
	x7G6G1/yL7mVgxqQ/0+/lzpxmHW6vY7nXMYCnJhsgsAvJrjsNrk1VeNl2olu744fQJxjUISEohR
	bw=
X-Google-Smtp-Source: AGHT+IH6wXfedcQ2yu1RtG+zbjkyA3yU3V5+gN1yJHGFYOVEaMi7Q5RPlb6IdLZcFS0Zw8lmttQbCA==
X-Received: by 2002:a05:600c:630f:b0:47d:5d27:2a7f with SMTP id 5b1f17b1804b1-47d84b38534mr177978875e9.26.1768206769102;
        Mon, 12 Jan 2026 00:32:49 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f695225sm344466455e9.4.2026.01.12.00.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 00:32:48 -0800 (PST)
Date: Mon, 12 Jan 2026 08:32:47 +0000
From: Stafford Horne <shorne@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/6] dt-bindings: gpio-mmio: Add opencores GPIO
Message-ID: <aWSxr8TnZMoZ0ezl@antec>
References: <20260109134409.2153333-1-shorne@gmail.com>
 <20260109134409.2153333-3-shorne@gmail.com>
 <20260111-bold-wolf-of-champagne-58fac7@quoll>
 <aWPT_HsRVC0dQ_j6@antec>
 <fb977dc3-54ea-4c58-be85-111fd7e1c371@kernel.org>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb977dc3-54ea-4c58-be85-111fd7e1c371@kernel.org>

On Mon, Jan 12, 2026 at 08:31:03AM +0100, Krzysztof Kozlowski wrote:
> On 11/01/2026 17:46, Stafford Horne wrote:
> > On Sun, Jan 11, 2026 at 11:18:42AM +0100, Krzysztof Kozlowski wrote:
> >> On Fri, Jan 09, 2026 at 01:43:53PM +0000, Stafford Horne wrote:
> >>> Add a device tree binding for the opencores GPIO controller.
> >>>
> >>> On FPGA Development boards with GPIOs the OpenRISC architecture uses the
> >>> opencores gpio verilog rtl which is compatible with the MMIO GPIO driver.
> >>>
> >>> Link: https://opencores.org/projects/gpio
> >>> Signed-off-by: Stafford Horne <shorne@gmail.com>
> >>> ---
> >>> Since v2:
> >>>  - Fixup patch to simply add opencores,gpio and add an example.
> >>
> >> Simplify? You completely changed the meaning of binding here - now
> >> device is not compatible.
> >>
> >> I don't know which one is correct, but your changelog must explain why
> >> now devices are not compatible but they were before.

Trying to answer this better this time:

As per our discussion with Geert and Linus W.  It was pointed out that the
original patch, which added openrisc,gpio to be allowed along with the broadcom
chip e.g. ( compatible = "opencores,gpio", "brcm,bcm6345-gpio"; ), was wrong.

The opencores,gpio is compatible with the gpio-mmio driver, but it is not a
hardware clone with the broadcomm chip.  It has 8-bit registers vs 32-bit
registers and the register map is different.  Instead of allowing opencores,gpio
to be specified along with the broadcom chip, opencores,gpio should be specified
on its own.

So we agreed to resend the patch with to parts:

 1. A commit to add the opencores,gpio to the driver compatibility list. (new
    1/6)
 2. A commit to add opencores,gpio to the binding (replacement of the
    original patch 2/6)

(now I understand this order is bad, I can resend)

This is a "simplification" as we are now just adding the opencores,gpio string
to the list rather than changing the schema with oneOf and items.

I wanted top get it out quickly so it can be fixed up before the merge window
opens.

> > Hello,
> > 
> > Did you miss the 1/6 patch in this series?  We add the compatible string to the
> 
> There is no 1/6!

It seems you are not on it, but it is on lore here, if you missed it.

 https://lore.kernel.org/lkml/20260109134409.2153333-2-shorne@gmail.com/

Reading the bindings submitting patches doc's it seems I need to send the whole
series to the bindings list.  Which may explain.

> > driver there before we add it here.
> 
> How does it matter? How can you add something to the driver before you
> document the ABI? Did you read the submitting patches doc?

Sorry, I didn't read, or realize there was a device tree bindings specific patch
document.  I see it now, and I see point 5 makes it clear that we should
document the binding before the code change.  I got the order swapped.

 https://docs.kernel.org/devicetree/bindings/submitting-patches.html

If necessary I can resend the 2 patches in the right order as a series to the
devicetree list.  devicetree@vger.kernel.org

> > 
> > Sorry, I thought the series and the over letter would be enough to understand
> > what I meant by the "Fixup" description here.
> 
> You still did not answer to my comments.

OK, I tried again above.

-stafford
