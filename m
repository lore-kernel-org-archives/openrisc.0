Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A72024E4A8
	for <linux-openrisc@vger.kernel.org>; Sat,  3 Jan 2026 05:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767419733; cv=none; b=OiGsRorZZHtxjdBnHj8s1lxLiDsPVdB2SpkW4M+LH37btVW4wGbgatYXSOxhvVZp7rGpA+qEk+sO9zs7CuanV/k+iyUGgtHBPmbzH+Zs2SWxhSwJFOw6SLieVMEkaUYUt+DmzwG/ACnr+mbW+EDw/kliLQdAP8qKGaxIGiof67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767419733; c=relaxed/simple;
	bh=3073OMvs0/LjEg4wr9mG+ncYvQgejlGvftaRsNqKdQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2KHUD4Z2Iv8ymqkQFWZzb49QVGuGjXOOkZp4YwEStsO9dq06lvFqFvucPoOPBCO5lO1abbeLBSogMBHt66gqt/hZqsSJAABcg9DlnbWzkKUJJwas+Ng56aDirZY7WLlc1DqLOPtWo26da8Il+x70aPyUUuRvcUk3DH3gaarV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+kqM7Vu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+kqM7Vu"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47d6a1f08bbso3763995e9.2
        for <linux-openrisc@vger.kernel.org>; Fri, 02 Jan 2026 21:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767419730; x=1768024530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3073OMvs0/LjEg4wr9mG+ncYvQgejlGvftaRsNqKdQs=;
        b=J+kqM7VuDohgXrxd7lR0e+wM8kyPNyNEaGS5Lz4WeHSirtVEiESBLdKpTjlSRn+YnW
         m9DjtzH/UrfWqt7je+tew61V71iFTpoy8wveUlhAOgQb7uP6dHkt+khvseylqwhHICrp
         mmp6at4TYAATsexL0XC23eTaZyEIJIUZFKWeTLNC6jeR6FDAjTBAMla111MfvCzz8dUD
         k73S2RHTBRluZ5YzqhduAdrX8BjksTWS64oxr5zMkJpVq+kGroF7I76Xl5zekIwG/93o
         O17lUOqaw5i1kNbMBye78zxE4VHUHFQtPG2NGHTFbOhnC6kiQoOvkZ7g80RAog6pgYpz
         In5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767419730; x=1768024530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3073OMvs0/LjEg4wr9mG+ncYvQgejlGvftaRsNqKdQs=;
        b=AgiUVINEBBwJzLnGw3Rk+gz6c0/lXSo7xr9QBptPw49/d3KItzA8K3axgy6w05dACx
         K6HuTEbHXvFDLJiwfo2Z/4AJsq6Y8r9Y0XgqgGY00mQZy6sAbTvH6lzSW5wXlEuGtATe
         J5efirLMTYOgF66hHyIjo+TxcAM54yT8pvbNxj+udlM0NYDj/NEXLAEzehkrvivpYvj7
         LN/M76HumcToi/IHBwL7D89Uod8SaPHx5+ReziHaDKAH55woSN1mAG/wmWyIWWRyC4NN
         MMNCBP6kiiTcWIEdDoIM1Xl4StfpLG8pxOgOaeUXS67UoFW6R+/KzG9VNmHGlU9sutmI
         Owhg==
X-Forwarded-Encrypted: i=1; AJvYcCU78+Bk6Vid+UbwAPGUu4hBBP9wNRoC2Syf0uXiDFt85EUXPMMq8zBWCX2D6cXa5V8Y5MCheA7Z0purcZ3Aew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgCEWRgH7ESGOC4wNehVMmfOf/zB9ioUrpQBZVtvQwG1fvXilY
	eZPK+ABCNARS3yT77UL83WFhlJ/x5G+yU/1x3mtSMCM0vf2p4lyI1f8x
X-Gm-Gg: AY/fxX7FwWjne5dzBYiRI5DBCc3rc2JclewZfmS6VK6wLwx1EDuEpZ/f80yC8AvNpZQ
	7htOs6ucBTTdXi1H+XPeoCumOcaUh1a+V1ZGd3GHU3Cd0/GBVwwpBSKj37fZwuMgQn/+jo+3wDF
	tKsgoCfn1C+t5YzIxrniPRiLc3IDi6Mrlg1YPWMSn9n6SmUs722qcQsvD62a2k2pize6AjFP+Ug
	NtYwTza03IVjD6Vd3jqAg/PScV6K6KyAJE2CRV1WrAVDWuht7dAgb3Uhpk7TwoM0F/IPbQKQ5A7
	hOCbw0FnA5sZ/OCRzT7CdTPnOtxkIW9dqCliSW1KahgYC++rJr6aRGFCWr3Yhw4PTkL5zedih3b
	6+BF0K0+rxV3n7UlU75VOUg6TWqsvBaeAYQnMqI6jdG5otXz54u7f7Ku34LOxGF6T22pgA8gRgE
	ED07mZgV4QP1J4blBi0psT/TcBrV3uKjpT2Q0l7NULGxnliEduJHQBI90hSqld8Jup
X-Google-Smtp-Source: AGHT+IFDlUycpHh35Bxl9zkKufMif2HIaPtEr71It/NuTPMJMkB/txx1IFoOyyH3seAcSTAkGZqUKg==
X-Received: by 2002:a05:600c:3b07:b0:47a:814c:eea1 with SMTP id 5b1f17b1804b1-47d195917d2mr509496085e9.35.1767419729438;
        Fri, 02 Jan 2026 21:55:29 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6be5a555sm10532405e9.4.2026.01.02.21.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 21:55:28 -0800 (PST)
Date: Sat, 3 Jan 2026 05:55:27 +0000
From: Stafford Horne <shorne@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: Add compatible string opencores,gpio
 to gpio-mmio
Message-ID: <aVivT0ruGpwdBO7L@antec>
References: <20251217080843.70621-1-shorne@gmail.com>
 <20251217080843.70621-2-shorne@gmail.com>
 <20251218-muzzle-diploma-25832f4af271@spud>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-muzzle-diploma-25832f4af271@spud>

On Thu, Dec 18, 2025 at 12:55:07AM +0000, Conor Dooley wrote:
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable

Thanks,

 -Stafford
