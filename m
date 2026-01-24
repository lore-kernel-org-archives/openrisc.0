Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4042D8777
	for <linux-openrisc@vger.kernel.org>; Sat, 24 Jan 2026 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769258208; cv=none; b=Ycw8LLJnRa7hURPevbdiJxuX2NUC5+IP5ZS/6b8RvnU1/g9OfF/4BOLIOVYmjYb2+8Ho7m+yihhMtGTqW8nmrMDTAHJw+xOE8ZsUbF7lJF5dJeF3nCYZQe4RqSl2I/in+HrTLrZberKmjRC/DyiV6+QdZJ1zNKUmt7ffgoSlxQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769258208; c=relaxed/simple;
	bh=2lpZPiehnZVWy67SwNKoHY2awngWTM8se8vqxPxB49s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilg/zAYkt5MxtIQa5G4l/TNCdWPhT9Do4rsfVkE32+//WHP4cUbYpRnDlg+l37XLq+vJ0W2qDD1Juez85txvBKwlRkbZT4c3ryBAtvBzVDXwTxTXKsONdDJkMtcmVomxbemr+/NYCHgNDSzwXSRimv8Uctg6ttZsXf4fA8cUtQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKXZuKU6; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKXZuKU6"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4327555464cso2030964f8f.1
        for <linux-openrisc@vger.kernel.org>; Sat, 24 Jan 2026 04:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769258204; x=1769863004; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aWxFjlQ15iLHcZ2sWOA5/KipFAdTrRSE3rE8bBRoPNA=;
        b=ZKXZuKU6H3gpgJsBv4nBKoSRZurn8Uq84zCD5msjjPeLSfiZHak/zkvW5uVpmUeVvu
         IQ7b6BTrwj2w9L8U1cdLDndX2TzL/nBRBVaPPsIn8I0I/BC+UX1pSiEKnHgOzQiv3Kqr
         2Dtd7OglaljVFT4EHPwI70g2PDFnu58bcaWX3Kf6JXerqh4rxnVtsCzr7ljxQH6OVjNE
         So2h+8zVCiz7V+tb9gMd9NOUm0WTkWZDP1zmhJnqmKNTG7AzfDCANQk7mxiXsXVVb87s
         1WGs3mc42WxRCY8yXugGy/O5l7bEn0cywRpujac9wUrOamSS8ii1q7RU9D8RhPdaqDFw
         xGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769258204; x=1769863004;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWxFjlQ15iLHcZ2sWOA5/KipFAdTrRSE3rE8bBRoPNA=;
        b=ckvgoU4aArX3msEHG0qynQ5xeiBYFZKGZ275VoK9KqH4GOqCE6E4EOTf+bS4Dqt1rK
         OCgFb8PCtzIndsDL5OuZL/BLoqp/p6tYPHO9r0PTHc73WbcidaHIh5C5sWyQT7w2Wzb9
         xRVdVRSQtmsgReNfo11D1ECdhAKzzqz9C8y37ATfhS4tBCsbiY8Pk03cY19hpe7OX/le
         fzU/hJ+vWMMhUjCo3ZZF1xowjyGwP89V6jEhU7ZXV4rDLAs3DMuv/qBPVHdYKgJlsB6f
         lGfKQLnuiHZ5h3HFAOmf8vbeuxkrDvpZGuFDFslQmQeXw41FiAkZgJ06Wmnm8oTYskij
         vGjg==
X-Forwarded-Encrypted: i=1; AJvYcCUwJhqeWRIpO/CmvghzhYD2cwvK8vkxROl/Tu3y/xwUv7ach1vS93xygYmR3LJrEzZ6Kw2VnAq6+uumjogJ7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqwfOoESzyOAUIKSeacxaUx9Lf2dxNx3oIWq6rctehqsXIQRZV
	NCJkr7UDp4HxSwOTc9F2v6KA9UILk/UgkCw/RqNMtUZMgyzlkT2+dkau
X-Gm-Gg: AZuq6aKVCXW1t1FTrUflzc9lcSYiNnD0YKkAt0kT5pt+PhItv7LXOGoRjk8AuHdBsvX
	nNdNm3Myx5sVtHxG5d5GTiMpzkqw90l+bD50fVNCpMEe0q04Z58eWG2azdx4P55QWLLlFglT26Z
	2BBfQUHrEZb1ANGfYqoMrZ8VVd5yT4WyLuSfuMLYIU9xK1o2i8gaATkKM4u0vJM8zIuyjAaUgXH
	SwDR9Gh8i2KRwHYOSbkLiRnLAYaBqWbXZtMRLXP8CQ83sfEGHoLs2KNvSX/Cn5R5DWOpVt1m22n
	WFud0USZp2mm8rjP6lEAVkzh9Qhh1PnKdhkFCKmnu6tj7P0Q/VN3kpBjDEOuXBbF+62NmC390j/
	waaK89k8PjBzIRlulGI9XgjH/Ry9bJTsIjrx6598HvbhjKgvVKNv1TMoyJPY74WuE5BrHEyoeGZ
	faRA3ekrxpzYyXJDsxbdnJCmvdA7+T/BzDLDvaZfpfg1Esd9hQSqGgj3s6UZTO/oww
X-Received: by 2002:a05:6000:1847:b0:435:9756:d4c4 with SMTP id ffacd0b85a97d-435b15d6927mr9998528f8f.17.1769258204232;
        Sat, 24 Jan 2026 04:36:44 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7c9cesm14772613f8f.41.2026.01.24.04.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 04:36:42 -0800 (PST)
Date: Sat, 24 Jan 2026 12:36:42 +0000
From: Stafford Horne <shorne@gmail.com>
To: Gary Lau <zgliu@foxmail.com>
Cc: linusw <linusw@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-openrisc <linux-openrisc@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>, robh <robh@kernel.org>,
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>,
	geert+renesas <geert+renesas@glider.be>,
	"krzysztof.kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>,
	brgl <brgl@kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v6 1/6] dt-bindings: gpio-mmio: Correct opencores GPIO
Message-ID: <aXS82qiNNvPVMqdV@antec>
References: <tencent_F07E7380CFFB3A6A7480FDA42A636B7D290A@qq.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_F07E7380CFFB3A6A7480FDA42A636B7D290A@qq.com>

On Fri, Jan 23, 2026 at 10:18:04PM +0800, Gary Lau wrote:
> Hi Stafford,
> 
> I should clarify my setup: I'm using hardware address translation to make the
> OpenCores 8-bit GPIO appear as 32-bit to the CPU. Specifically:
> 
> 1. Address translation: The CPU's 32-bit addresses are right-shifted by 2 bits
>    (adr_i[2] in Verilog), so each 32-bit CPU access maps to the correct 8-bit
>    OpenCores register.
> 
> 2. Data width adaptation: Only dat_i[7:0] and dat_o[7:0] are connected, so
>    32-bit writes are truncated to 8-bit, and reads are zero-extended.
> 
> This hardware wrapper makes brcm,bcm6345-gpio driver "work" with my OpenCores
> GPIO, but it's really a hardware-level compatibility layer, not true software
> compatibility.
> 
> So you're absolutely right that the native opencores,gpio isn't compatible
> with brcm,bcm6345-gpio. My setup works because of custom hardware translation,
> not because the IP cores are compatible.

Thanks Gary for testing.

-Stafford
