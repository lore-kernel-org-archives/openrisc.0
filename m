Received: from mail-ua1-f66.google.com (mail-ua1-f66.google.com [209.85.222.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B4346783
	for <linux-openrisc@vger.kernel.org>; Sat, 10 Jan 2026 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768053854; cv=none; b=TJml3xigmrTGO+9zYyLOZXDi9Hv+gGtiij57aPrPM/99tZ/+P+2ZGanE94Km8rVHUYESCTw3WLsn3ecMaRqc3aQ6QGVa7QrjmwiWhfdPRALI85/Nl9fE1ItGoKTVdwHpDJyuHH3tWvCY39VeftmYjf1DfvzJLL4pTPTzooRvjlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768053854; c=relaxed/simple;
	bh=tKasUzgnJ5tHsB/zNtMovFVLfO8KZhfIR8BiYuhSUK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JB+9hSrkIxLMV6uiepjsOjIszsEJlUHVJkIFi9281hUetK5uo0zAIuKMmCL4m5IljXTmgXXiKcl8UZpGoE72gYrR4SqoQ0NfsJcdcIjr80n+mHx7w2cLZVvpfwi5912qvL1/DEbDL2ao1UawyaCwqX1ucl0kE+JEMDf5kY6qhoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f66.google.com with SMTP id a1e0cc1a2514c-93f64ae67dbso1577717241.1
        for <linux-openrisc@vger.kernel.org>; Sat, 10 Jan 2026 06:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768053851; x=1768658651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zesx+EQcmeyquMdpinrRlA/4MSp1GKSwu+RTgtqJFw=;
        b=DT/O2dn68Cd+gIWwH7fE1LekUyL/rpyUzOjZAkQHALrc4lVixbUBuv2yjH3iUe8yNQ
         R0evx+7qgH/Ly9TeJz7a0qTc1AaZWabeNFx3tEvJO+b+H0h8Biw0pqmeuD1qY4vk2pmb
         O907zaG7BXRdGveiPKhiC5J73r+v6aBm1MZGsZETw/BdLbe3OvEMPcCF5ZbjFYoEPJq4
         9fZuAZ0pcgf0uordw3uj0VllHkFTdjxYtOlLz6mUJXkeB0L/zfPu0X1E3VOU4OHxac2D
         bUHTG/UPnatHpc6M+AdJSRwr3aqbFI8oQqiP/+SRxT+ztPkugbFGl2J3tlgBo7TfDvlJ
         QFVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5VI3S4eS1PAwVTKC5gHh9U/pEbtl0A3Nia4dNHvFkIZLdWM10gQGw8WKxIcgT8YyOBKQ1DRUVJzyd2WQq/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxepkdFC81Aq9dRV5i7MiX1qiA8Daa1ysUjzssHvpaee1OkcFx8
	KseKs/yENoghcChElh+V1FnMWH3EKhn2kxKqly8YTrawHjZI8H369jZN+CXLu3PR
X-Gm-Gg: AY/fxX6+famE03/PBDg/RuqOAzB7xG5QH59QFiZIwP5kur5qWgahoorji6vpkWmndaf
	cHqOF5GOvO9opCBx5j8XPRP6Gv0VXBw1hU3OhymEGJ5EEYqs2JRh4zP/3mEX+NpTLrD9Fpcu+sa
	BHI6TRuyYuaS0PjdjZxn9OfLvU7p+6N5vB8ChU94+LM9VYUYVUecxVNszC3a+LqyBnXtYIKeL5f
	pa0v5FhVs3DGBCed6oTF1dOA4TMKaTsWjbL3JL5PJ2DqhYKBVKocTNf+3DiZGvSAz6mkJESfVOK
	u4Ap72ZlWwZQO6pgoEPs+eTuI+7qjnkQVHk1HFpIfx5NpCCtvz0OFncX/E6PXyEa6B3YfugD3wL
	dHVGb2kh43RtptkkxxqOektMD2dch2/iy4/uzLf31j9Ow/jUCWWcdUK+Lrck40eGqJCiI/iJco0
	vQBD+VHo/Uoxh7uxFKJslyosQVV/4m4ZizRV5KWThefFJKmyyqZ/qe
X-Google-Smtp-Source: AGHT+IGYrTer3O/dP/GaJ+urc1goPtWMS5tStoqSkVQU51HGJ89vUpYrI2iT6Wa7DxwvKU+EltqMGw==
X-Received: by 2002:a05:6102:3f02:b0:5dc:51c5:e3c7 with SMTP id ada2fe7eead31-5ecb692bd25mr4874694137.26.1768053850547;
        Sat, 10 Jan 2026 06:04:10 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5efb5bb6d11sm1067917137.4.2026.01.10.06.04.10
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 06:04:10 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56378a18ba4so58423e0c.1
        for <linux-openrisc@vger.kernel.org>; Sat, 10 Jan 2026 06:04:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSD9YYJXlvZkPkDcno9UGYIsUHdJ0qLjEF+Gk+ZkAkPcnnD5wmXDyHNMK0K08O/1qPMs97DHd06s6nYTIz5g==@vger.kernel.org
X-Received: by 2002:a05:6122:c86:b0:53c:6d68:1cce with SMTP id
 71dfb90a1353d-56347fcbaefmr4885900e0c.16.1768053850063; Sat, 10 Jan 2026
 06:04:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109134409.2153333-1-shorne@gmail.com> <20260109134409.2153333-2-shorne@gmail.com>
In-Reply-To: <20260109134409.2153333-2-shorne@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 10 Jan 2026 15:03:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWNht25_gY-R8tw9x__a-aRv6ZfKULPkUHrsc7jokizQw@mail.gmail.com>
X-Gm-Features: AZwV_QgHRb84PPZ39iYbXQZP7JLVIPbd6lMKcY-W8c8LRRN13vbxER2EwLDZPl4
Message-ID: <CAMuHMdWNht25_gY-R8tw9x__a-aRv6ZfKULPkUHrsc7jokizQw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] gpio: mmio: Add compatible for opencores GPIO
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux OpenRISC <linux-openrisc@vger.kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Jan 2026 at 14:48, Stafford Horne <shorne@gmail.com> wrote:
> On FPGA Development boards with GPIOs the OpenRISC architecture uses the
> opencores gpio verilog rtl.  This is compatible with the gpio-mmio.  Add
> the compatible string to allow probing this driver from the devicetree.
>
> Link: https://opencores.org/projects/gpio
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
