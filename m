Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2798F37C10F
	for <linux-openrisc@vger.kernel.org>; Thu,  8 Jan 2026 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858642; cv=none; b=EkdLigaSgHidoymgXKyHjUmkArKAytZSaKzmHfPWBfhYjXg6QFCmAYl/Awz66h9IuD9QHb/f1HJkjduab8qAcTvbdRefLG17C+ExdCgqii3cXMP6J0ilyt19+dy8DgLItOc+2953XQXrGSULElwz2MAigvWHg1stVqgcwl1bTy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858642; c=relaxed/simple;
	bh=kRy7DNw+fulZHF6KL6RSdTY4oFE4rQkK/b/b5F2abBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jj2OpbLxHvXRPtuFY4CoonpMWRjPu8zwG6Pq5JmddeuIZ0sfC0lZr35Ls/T2JaOwJl3+tRmxJ6ZtnO6nYMCPyx0zHARUu6xxgecVbY5HnvYqqOl/IHwTZoF8WqRuiuhnfTzUeMVhNiq05v2guzDUbanbPmDwu2UdaPUNUvJIshM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkZt0S9C; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkZt0S9C"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso7906485e9.1
        for <linux-openrisc@vger.kernel.org>; Wed, 07 Jan 2026 23:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767858630; x=1768463430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VFk3K6PIfFKKeMfxjlBdSwZqQED8HkDY5r3p5jOG4Bk=;
        b=nkZt0S9CNQkM4KswXRGOt4dFk0qApsuwZeMjTupOt+g8g4vkmVMILICnhmhm+AbFaB
         xYY/GdUL+1klkQIRVTK9LGvspHyviczRqLYaeel2XWUpDyeSynvN3SmXkiBjlwawee0Y
         zTVBy7V71cSQ+3WgAKqFGYjObbjLFC2Q9b/C1o90Z2s9oES4+SILRElc/1PUgMhmjbVS
         K39ker4397iZyl6aaDuVftZvyr09j1HX69Etsu1kKjr2/iwswIY0rEPWs0Ie1oNmbqED
         nD0zMQqy/33Uhbhfor6NbQmTIayJ82lYwJDyMOs0B80hllJhuVdW5t20sB/CietXBlWL
         296A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767858630; x=1768463430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFk3K6PIfFKKeMfxjlBdSwZqQED8HkDY5r3p5jOG4Bk=;
        b=vJCv/uWjFXm9J4FKim2a8r5KrjRdRemZcG2K4VVGCZScLoGcNZDwn4CbDhQLp/4ZpQ
         MkkInHLgn0SpFLRx/lvl46mrScoIiZDfb82e+B3tlxBBWsx91XNOwISv261WDGz3viP+
         gxnM4/SNJlN7xclhUFJ1w53jVIY11JmpsCYoDvYKmdkWJog+5GLRUKRPYFbho2O6F/Nm
         VX4jO98egBvRvl1awGt5fqao5Y2HAr0Mt+KprfNOWQnp4ZfHUZoxp+cis/Cp4c4Eod7Z
         ktmg4UHMk7IbaWRTHwnfM4zKuv8TA/lor0eDHKVhSeaFSILYeDNOc0NDb1yBDxbqzmoc
         vBXg==
X-Forwarded-Encrypted: i=1; AJvYcCVXVkOV7ltRIpPNCPSuqAmG3BP7XPx822lFlO0AOmP8tyDgGziROXbtKWGfpEvKYoKTU7J6tndUupmFF8edmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIFw6tEDkLo/buB0oT/p6JTNVRauULImfdvNksaeO0TEAyDZEV
	skg5akkQ9A25r25nGU+Xeorm7xjdEjYwp+T6A2BYYpnlMssBJqn4p3zx
X-Gm-Gg: AY/fxX5rCQwLf8lCSqNG+HvMbfAOQiostCHyoQp5Ca+UwwRPucrkh1+nyGwWqaUkooj
	T8160t+UWrUo5UUAMBAdR6zPdYtLpsGxwks/rJZfBS1OE24juB8NbNT1dyTynesKTm9XjanFxU8
	OheflJUeElTCDWiQ4fNfk0sHod8H1e3djD/8DGpdstrCmGqAfsmO3c4dpxTsxFl8ggESsJ5810M
	AU8SiFtOSgPbGp3WiOpO5GMZX7vG1hOk6/CP2r238L3neLybHUBF5mYLS7ztHWLeHbzIScZDK9+
	JURYBZsRuD5xsqSlOTFK7IcJANhrd3iwmKBNuOjtjkpATuFqtlbs8Ns+yP1mfRQhlAHKpadGkBE
	ytd9TnScJY0molbDZOpIYsMRJW3gZ/4u/YoY6HtVExvHpUMPRagoo0Ir6vNCi3cW/MU4UDOhmsn
	k+Pg7wslSLBCqXAVGEo9jTfCAlcmkyKWJ5Eh3eEzJV5aTUFbkqsWUZI3M10+RrTzZ1
X-Google-Smtp-Source: AGHT+IFyoRt2dNQOmJxXYPgtoHsx+IUK5C9FJ9EM4O+p7P4XzBFb87PUvms2YVvujmSmeqx+2jAPFg==
X-Received: by 2002:a05:600c:1792:b0:47d:7004:f488 with SMTP id 5b1f17b1804b1-47d7f6163f8mr74389625e9.10.1767858630018;
        Wed, 07 Jan 2026 23:50:30 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dad8bsm15257199f8f.8.2026.01.07.23.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 23:50:29 -0800 (PST)
Date: Thu, 8 Jan 2026 07:50:28 +0000
From: Stafford Horne <shorne@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] openrisc: dts: Add de0 nano config and devicetree
Message-ID: <aV9hxM_YnV5P-l_R@antec>
References: <20251217080843.70621-1-shorne@gmail.com>
 <20251217080843.70621-3-shorne@gmail.com>
 <CAMuHMdVCY=5UypK65Ver6UZM_m6DZuw9mhfANMx4+Y6PgNAdmA@mail.gmail.com>
 <aVi0W6syzK6buL_v@antec>
 <CAMuHMdUP3z4Os=3XC6Nuzx8QAap=LTcuJrGZsy71GO=NFTOjZg@mail.gmail.com>
 <aVzb6pStdagr3IUX@antec>
 <CAMuHMdXr7H_M-QO-3ty4mpycMfDHsxrDWejjw7u3RPcUqioapw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXr7H_M-QO-3ty4mpycMfDHsxrDWejjw7u3RPcUqioapw@mail.gmail.com>

On Tue, Jan 06, 2026 at 11:18:01AM +0100, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Tue, 6 Jan 2026 at 10:54, Stafford Horne <shorne@gmail.com> wrote:
> > Just curious, Do you have a quick way to enable out of tree debug patches i.e.
> > to dts and defconfigs?
> 
> Keep them in your local working branch, and rebase that when upgrading?
> /me has +1200 local patches :-(

I see :)

I am going to play with mini.config's using KCONFIG_ALLCONFIG.

-Stafford
