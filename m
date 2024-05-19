Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8935024E
	for <linux-openrisc@vger.kernel.org>; Sun, 19 May 2024 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716156906; cv=none; b=mR7/MbKu9xdZdPUZCPdCXjLb7oNdAYRPK344tNZdN2a6j/hmOdYaFTzt3mbAQ7rPTm0Ld5WTjo1VIoCNVCYcwzP5/leMI8ytaV5lthrIOK1WyDiYHXJ9+XMu+zZS/tl4eiRCBBg6xMzNQyDa90KV9QRxPh6oycSTqmYoYhGsQ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716156906; c=relaxed/simple;
	bh=Q8MwV2FG+9esaMeCjAoKvO1wVkYLNAIuX47vKlJquxY=;
	h=Message-ID:Date:MIME-Version:To:From:Content-Type; b=jg7rG14Eqb8IN5hnd/bZybqDW2xSv1oNikRDSC9TtCs1h+MYIM1juNa4MzfdXP8p8NoVggznyB1LseL+Mb6l/ZyXwQw8sY6bkhrhog82reEnpDAYUpIKcAv0Rwgch+rWqFFFf1gC3sUCd91EoLSgWginShumBT+/qV0q7S5+zuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccDnSvjW; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccDnSvjW"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7e1ec659c40so185412339f.2
        for <linux-openrisc@vger.kernel.org>; Sun, 19 May 2024 15:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716156903; x=1716761703; darn=vger.kernel.org;
        h=content-transfer-encoding:from:to:content-language:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8MwV2FG+9esaMeCjAoKvO1wVkYLNAIuX47vKlJquxY=;
        b=ccDnSvjWLzR+zobWRpGC+GctLUf5LqQbvvF6D3lpCSfMNQ5XEVIkQTsgXZeeTkwO2s
         d7JN6we3oXxIC60x4YxiGuZHZtqGsgwU5dr02lUnaq77RmDU6Au/Tz3Elw2REWIUl6qa
         lzpCn6aTJEfJO/I1U506lp3D//LwMSJBhD6REyqBuSTFTNBZUVXrOaqXcxhzhLr2fVRw
         nfFr0P7q4h5THNe37yx36YG/YKxwJpfXrM6MIja+LZoH1IA9n7l/qgF+G1KoXoZcV+ed
         OxQoPlo5FwOa0C45yXxdjVnKBrjihIBrPWWPxcCiiQq74w8Uf61jSNT9G64oF3AjvkvH
         5KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716156903; x=1716761703;
        h=content-transfer-encoding:from:to:content-language:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q8MwV2FG+9esaMeCjAoKvO1wVkYLNAIuX47vKlJquxY=;
        b=hIUFS/28XmteAzAmh90Elvg0djwLTw5YIbmX6Z5unzd2shicZkPY11qs5T7H31lyXJ
         VuzMyo+P0PtjAbfTuzA15XVzEqdoOzkeqXxzRpxuavY8IGfabU9R6lfHnkzBLn9S5ha0
         xkivXv9QfsCxtX8LiLnF9Zmp9J8ioNJP/0NzWAixR4hjItLRP4Z9MXz9yGsSkfiadIuL
         tyqWc5rBOkRzfh3/J8AJJnHgzQ0icj48rYkioWQvZWg6jh7p5Dy6e7ETVPxlySyXqbBT
         5pb7SahKCNoXVQuVZp5uGLCWBLPT4c6NzRFpEY0BUwVwc15Rgojljx0+laH9AqhcupXw
         Go8Q==
X-Gm-Message-State: AOJu0Yzg8YBzxHqc7PZFE5ns4y0jZCCn/glUoS5fCrvHN7NGhY1xOJCt
	taPudPXDHyRI5kIas7ZXV6sGl9hMgqO5z9xgF8icF8KT8l+WGc67b0FEouJi
X-Google-Smtp-Source: AGHT+IGmFEXJ7jzONKaNUD/bh7N/GkKSqKcHQovUe7C/xk5X5igPHhJ9QxHVIuU0E32U2xOZ3x154g==
X-Received: by 2002:a6b:5b0e:0:b0:7da:4135:89be with SMTP id ca18e2360f4ac-7e1b521f9b3mr3127255639f.17.1716156903290;
        Sun, 19 May 2024 15:15:03 -0700 (PDT)
Received: from [192.168.1.14] ([98.245.154.160])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e1a88b8942sm551704639f.52.2024.05.19.15.15.02
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 May 2024 15:15:02 -0700 (PDT)
Message-ID: <a003b7f4-42df-4244-9f32-ae41db168cb7@gmail.com>
Date: Sun, 19 May 2024 16:15:02 -0600
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-openrisc@vger.kernel.org
From: el 01 <quantumleo78@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

i'd like to subscribe to the mailing list!

