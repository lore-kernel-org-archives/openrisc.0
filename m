Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9908197A7E
	for <linux-openrisc@vger.kernel.org>; Tue, 25 Feb 2025 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504321; cv=none; b=dIUBzNuG2UKC1Gg8TfL+BhCAq7Bg35VCTXvyAtcjnMhokkBdK1g1wLmO/w5QS3vDbIAZB1pmM2oFLCriPMbsL4Vtv/ZIw0DdfK01dkVu/yCOFshRe4mLNJUvLC4tB0Idk8z4BbZeTkVdFZicfg+cSV5cLMsjyFfdxk0aH8MLnRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504321; c=relaxed/simple;
	bh=YkdFAHBjOUpRsug02dxrAlfWEiZciwPW9cNDFTo6dRc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JCDDuFvUK77hZ122yw06AL8sXFpG3GZYOl/rokzQQOC4gOASoklCqYbP4ggS4Q26M9GYD4N0DQn3xWUjsT4T3i4Pq/AM+LQ9kuoGv5TtprV4CtI4dNE028Ag/xbsTYwU2WZtXElbjJz4NvKV3VhoprjhIYjDXl+zAnoD+bi/eyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1E6V8ad; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1E6V8ad"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4399deda4bfso40745735e9.0
        for <linux-openrisc@vger.kernel.org>; Tue, 25 Feb 2025 09:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740504318; x=1741109118; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NZM+Kr1XuiGGRrmLCuQ/UV34khVg/XzoQYSsVZ6wH/A=;
        b=Q1E6V8adl6O9BObd1rVBLGObNYWh0RByFXKudjUYb4Z0Qlfc1EWLHDJGhNTMe2EqYs
         wbV8NC9fX53qbZwaLPP7rrslzs4RQeCOxEaoP4UXZ532CAyoBNfEav8Prfnp/2C77i5S
         tpwEIoI0/g4+X5piVOxCYg2YKd3oS8tzbZJ1yHmjBEfPceKam8X/QYVU5k1HLRM0UOk/
         QPzBxIO+PABUihxuZUyd1MTVhBDlOehze1PxbNfQeWky7YXRHU4a+9kuRo8xIwdAOiEU
         Lu8aihcUpRi85dTtL6ty9nn7TXEBS800Xkt2qycAvoDQGGYrtsqJtkwHcYjUWCn+qohn
         +X5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740504318; x=1741109118;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZM+Kr1XuiGGRrmLCuQ/UV34khVg/XzoQYSsVZ6wH/A=;
        b=VOueK/bho3QCttrrw8L7k14HCovfaU2OGcxg8UwlU3sxD2EIen2o4VtSjQ+oLo6TKX
         gI++nFoh/itMJvrXAdzsmdoa7jC7GvHhl+xzacsySRKu7fRrUNbg1MLV9sMST/1YfaiP
         JURPdMsytM8/ZB5o08SKyCccfWU3NH3EUCF27OquUGKlG0tsUiozU/eiRPES9PWK+RMn
         1SWSneJ15y+NTUz8OIJNeUZ/AOeCfh14g+TSDBvrEHu1K8IVBWkGF2reK+TR4dD8z/Gm
         dJz9pAh+xippM05ZKr66BJunUnSMJ4qKKIWG8zOnU+QtMvnVVGLiGkGlGuAhuixSN3UW
         dEtg==
X-Gm-Message-State: AOJu0YwqvRsR12XivGzTyVZ+SyxZ6677pnaCJr7xMyVtQndJy7Cdgkg1
	lWfwm4QMaljf+sZwn3Icj5scJD0zMRZRJ7he5tdoRzdIOzzFkIUHsPlU0w==
X-Gm-Gg: ASbGncsc7LTmOJUghQ5Ivhq3lLgiLDeHtF/z+Xj8o7xpUMow7/ABiaRxp2AogBUyKPC
	sp1/jOCN+2c+oZf0e+b5CKoaAxT/80EZTbX4dQQJLefowFFrXuz4O2pZvbwvtQtn1RDTVyaBpf4
	i73LlkVGP+G7QxmKgjraQR86RSFPiHZRY5ZrF2lmH4/mdkl0uIEaZ6jLGIolLuZKHEA5+5ZXt3P
	ubTVUMfYNC4hkcOh5NYMnbQiGJWMacyDlpgFO8lvelR5eeBsu2MXhTV/+IhSNwm6mdqjWmBMhJ4
	pX3wIN//0Dnm8x1jMNRi9pCzxA7TwrCtt7VK21cfoCC5OzMV2b1UUm+QBVkDFxasfw==
X-Google-Smtp-Source: AGHT+IHjssl4LoEadEDEr2XNQtQTr6u1Ahrcgyt7Q5ADDWgzuoLjwI/82qY72ohM7Ude7x9Xr76NOQ==
X-Received: by 2002:a05:600c:1c98:b0:439:8ec2:a9dc with SMTP id 5b1f17b1804b1-439ae227e58mr172740025e9.31.1740504317663;
        Tue, 25 Feb 2025 09:25:17 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e71c0sm2950726f8f.78.2025.02.25.09.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:25:16 -0800 (PST)
Date: Tue, 25 Feb 2025 17:25:15 +0000
From: Stafford Horne <shorne@gmail.com>
To: embench@googlegroups.com
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Embench iot results json
Message-ID: <Z738-wVIIUUe9251@antec>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I am working on gathering embench results for OpenRISC and I would like to add
the results to embench-iot-results[0], or at least be able to generate similar
tables comparing OpenRISC to RISC-V and ARM.

How are the json files created?  I looked through the differenent repositories
and was not able to find any tools that generate json files in the same format.

Would it be accepted to add other processor results to embench-iot-results?

[0] https://github.com/embench/embench-iot-results

-Stafford
