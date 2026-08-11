Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B9C37C0ED
	for <linux-openrisc@vger.kernel.org>; Tue, 11 Aug 2026 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786431000; cv=none; b=kEOtKaEOnpFtb18gvoaqMzt//q1ohLNAPqZuHM281/5W+2rZRulhjv2hvBxBvfTw6DH9zqnr9R/KLgknUOfwbuNR1HNWBnKNPAAl2h4XVN0INbsGfAItAo2Hp8fVnyPuTmELy2o8PmCwKJIF6D3wl45TlORRCsRbGJc/Fm7X2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786431000; c=relaxed/simple;
	bh=tZZLV6eyiwcGv5N3oyI6rD0AMUqGK1dWtQ5SUdhqr2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GK/MZnPeVD/96lMdSyqQXtjpFBzHC+GN03fvSQEceMqVCTHW2ZtLccTSc0XkbUcbnI6ZI2hXX4VHCNVdYAGtiVfJ4XefAPF3kJYBK95t2JiFAhl1BP6I1NZmPgGsJp1rBpO5t3aQW90s5evIeBrPtIMbJiutZf9Y2IWjeUhenLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5bf95ade656so973051e0c.1
        for <linux-openrisc@vger.kernel.org>; Mon, 10 Aug 2026 23:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786430997; x=1787035797;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0iZRfAdzYvTsaTTh/J3ab87cNtJMKi7JiQC3Jqumorg=;
        b=XaqHAQo337wkR2TXDSGl2ibYfT86u8Im1eRvJVAHUGzeQcMJS33vJZpXYWDTGWZk9o
         jkoHRUuo+1WcbT7ivhlxsi4+RNrffKepAWPuHHBghwOltNwnZaFa8tGB57jVABkAViXf
         Q3Qjq/ATeXqwG2XSVUlS6BrJ1NzuJ5/oJsUC+DpQWcqw3k7nEIfAY/pPSTH/7zlr47iJ
         XJQEPQhwhU4sZABg3CiZoTJxqC9tZufCRF6cTmSYRpxL8wNDU0Q6fzjc/vaj4MVKYMwK
         5ZSKs+59AIt2xXhUlQ1zqil0ssy7LloSPYjjgl9d0mbMY1LgWRL3aJ4sdec1XHS9e+Vt
         KDUg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6WIzt05/8oEcmbIVEOXtWlC9vxIXUvvQoMRge/T3P8PROP4D33AFEJqeGJPhodDf3RPvlWMXFewYPzxU/Cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXjuDgxRi71mA4im0Kke+5KG0b1/asGSYlM3hcd3I6q7SbF9Q5
	pvfmyyOan+E58VzrGtBDEd46mP7rVn1HLRvB01rvg5q22A5OwNcXZf51KpG+CylK
X-Gm-Gg: AR+sD128nUTYWlcLU33dCn0PraspS3bSmcODR+ZY5/Al9ok87DVbisfafuo/ZxHxNl8
	inH/R+maOYE1Zp7c1+thl8odQVGSsJfs3v8R4lRjERDdYoX52bICjLNoRxfaQE8GNSRIiHFTH0b
	JCUFaEWYaHx7cF29IDpl1lgQdoIE/FpDpws/YUhEcJFtNtfWqdXsg5cOIfmRE442j9Y9+d9XM1R
	g2hf5rLTUZflHVLhg13uvHpAPu1U5enbmbWR+t0CggkEULeLfVlu0Biox53vEVm1vAPl2e1wSXX
	HUBD4fKBQUTXExgH7tF2aDvDUUcrpIZOno3ibuig0BNZMoue+Rg+Why/gTHCICOLLKIEcpnZ8S/
	jTvSeVTwXCVrKVwo+CMlNfUW5aKIuFLd8HORVUktVC2pygiqofVIp7fwOOW6T89ovhX1Wexsa1R
	YaQ6cQN8lkkkEHyuiCvsAEzs+V8HxBWhiGpkVUjWz1w8o5+lToSmHHPTnzjjcrhOrEp+ozzCeIU
	ZUg50OnEqT8oOPIDMasjd3LRA==
X-Received: by 2002:a05:6122:e1a7:b0:5bf:a181:d46d with SMTP id 71dfb90a1353d-5c45036db90mr131960e0c.3.1786430997083;
        Mon, 10 Aug 2026 23:49:57 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c451e802bdsm131409e0c.18.2026.08.10.23.49.55
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 23:49:56 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-74ab6c88052so767232137.2
        for <linux-openrisc@vger.kernel.org>; Mon, 10 Aug 2026 23:49:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqJJHGa2/aFF3ZDCGboKfUk22jSdiYhLA9Y4KViWOURqDgC5P0DWgSG8bJLpe4Tyvx8A/GFqKP6BulwnUam0g==@vger.kernel.org
X-Received: by 2002:a05:6102:c4a:b0:738:ecd7:1984 with SMTP id
 ada2fe7eead31-76b54a7a17fmr283026137.3.1786430995503; Mon, 10 Aug 2026
 23:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811042119.3652929-1-anshuman.khandual@arm.com> <20260811042119.3652929-7-anshuman.khandual@arm.com>
In-Reply-To: <20260811042119.3652929-7-anshuman.khandual@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Aug 2026 08:49:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
X-Gm-Features: AUfX_mwgji-OqM2d70As4nCfmG84npBMa5IuhuEcV5XEKzcXYS3fe_Pqx16lD20
Message-ID: <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
Subject: Re: [RFC V2 6/6] mm: Drop pxd_ERROR()
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Anshuman,

Thanks for your patch!

On Tue, 11 Aug 2026 at 06:22, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> pxd_ERROR() has been used in generic mm just to print the page table entry
> in pxd_clear_bad() before clearing those out with pxd_clear() later. These
> pxd_ERROR() macros have been provided by all platforms which basically did
> the same thing.
>
> Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
> page table entries thus completely dropping dependency on platform provided
> pxd_ERROR() macros which can then be dropped off. First move all required
> helpers in core MM into a header file which could then be used else where.

Oh, the "x" in "pxd" is a wildcard?
Except that is not, as it does not match "pte" ;-)

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  arch/m68k/include/asm/mcf_pgtable.h           |  6 ---
>  arch/m68k/include/asm/motorola_pgtable.h      |  8 ----
>  arch/m68k/include/asm/sun3_pgtable.h          |  7 ----

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
