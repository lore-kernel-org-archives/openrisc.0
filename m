Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C98B15ADF
	for <linux-openrisc@vger.kernel.org>; Thu, 21 Dec 2023 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="dV2pV2RM"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-594178b3959so403190eaf.0
        for <linux-openrisc@vger.kernel.org>; Thu, 21 Dec 2023 00:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1703146588; x=1703751388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4H8xIQ/SVpT9WfB/BP+wTR3QvYNjlqB4qA+BUcm3ppo=;
        b=dV2pV2RMN2jK/8OlNRP4oJ7/gDMY5QvGIsIDIDD+B8pOgtvcBsKmxteswDgIokgJGH
         nKos/bRfNfMcSUwmed5gfZlaNC/JMRagjRM9S2R67cjKyfVbvS9y4xTnMEuur0gq7nNW
         TQBNXmwQKW7MeLBSm9oFOcM1Or7WgsKFgQkeyNzZ6BGBOFvup9tFVXZ7Q9vQibN9RTfE
         AZGAngdiKCqNHf0gH4e9oZhA6TI+5go2ikkeqihlPn7TxUM0h1zXs8wKMRBSt55kwMvT
         Uq9ZNBsLB3QWX1FPMDITNpf3ZqwcW1ifJm+ILcgXeMTrObj5/dSjdOPXsv5HW+sZBcez
         Jz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703146588; x=1703751388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4H8xIQ/SVpT9WfB/BP+wTR3QvYNjlqB4qA+BUcm3ppo=;
        b=ZZDk9DfgCMnME0WbbC46fpGh3CFF+XEij2on3gQrIIo/r6YZtIuvPcAiFDjx9T8dnt
         UNh8zl1CYV68obE4E1h+fhCzJ65z9O/bkUF55tHixrWw4IoWhVSXH3CE4RYkg21N/eFP
         jtwB/z0D+Z7foLn9y8pSYDOfKD2n7azyBEtoMqt4lEbl47YKjYo5K+kKOvkxmW2p/27J
         UxPrSI3FXk78Aur7Gq9ECCbc6bDfHJgU91D8pUEKK9msdp+yj0F/2veBRi+2C8StVI1C
         3wgC924xdjXwXzL2KUbHwDgJkqpJgyuUwcn8Is1Iln3NYFvDJKP+q3NJGF7DOrntIJ9C
         iRuw==
X-Gm-Message-State: AOJu0YyJcAHuMtvPS2zko06i3u+iq+pT5BX3d8t0mFnBTzpeLQd3Q/Wc
	fjCGnM0uwcUPv6AlPDcLkhQb2y5+5EMFstdiocQuLg==
X-Google-Smtp-Source: AGHT+IF8+JkgvlOUXZzofQXPlUpGxqSH7tsviANAlWMWXgQrmZjZD9Ja1ghBXWXLoxGAUEbvkSTPkg==
X-Received: by 2002:a4a:8c66:0:b0:591:cb69:956 with SMTP id v35-20020a4a8c66000000b00591cb690956mr4797195ooj.0.1703146588073;
        Thu, 21 Dec 2023 00:16:28 -0800 (PST)
Received: from ?IPV6:2607:fb90:e600:87e2:3ea9:f4ff:fe4b:aee8? ([2607:fb90:e600:87e2:3ea9:f4ff:fe4b:aee8])
        by smtp.gmail.com with ESMTPSA id h126-20020a4a5e84000000b0058df21de4fasm280401oob.10.2023.12.21.00.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 00:16:27 -0800 (PST)
Message-ID: <8f8eec8f-598c-a1b0-7b8f-21e4f66a4d83@landley.net>
Date: Thu, 21 Dec 2023 02:22:26 -0600
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Adding or1k support to mkroot.
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>
Cc: linux-openrisc@vger.kernel.org, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
References: <79b2561e-3167-9758-8196-f2470aec06f7@landley.net>
 <ZXtck05MRrk2e675@antec> <95d45290-4b92-c189-beeb-b7e34dd298d8@landley.net>
 <ZX1xbs_AGdgLgcx7@antec> <2e1d9f74-88fa-3f5a-7bc3-4fe7b726f2be@landley.net>
 <ZX658P7dEgqCezpi@antec>
From: Rob Landley <rob@landley.net>
In-Reply-To: <ZX658P7dEgqCezpi@antec>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/23 03:05, Stafford Horne wrote:
>> >> > -device virtio-blk-device,drive=d0 \
>> >> >   -drive file=/home/shorne/work/openrisc/or1k-utils/buildroot/output/qemu-fs-or1k.qcow2,id=d0,if=none,format=qcow2 \
>> >> >   -gdb tcp::10001 \
>> >> >   -accel tcg,thread=multi \
>> >> >   -smp cpus=4 -m 768 \

My qemu-system-or1k (built from commit cf6f26d6f9b2 last april) says virt is an
unknown machine type, and to build a newer one I have to upgrade devuan to a
version with python 3.8. (The build refuses to use 3.7.3 since commit ca056f4499c2.)

Rob
