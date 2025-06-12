Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FBF26D4E2
	for <linux-openrisc@vger.kernel.org>; Thu, 12 Jun 2025 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749745730; cv=none; b=Fp+oke+e+sgeEsTeKuVheAbeqtT852MPmKwwuCK3E/L6b39kSy/DFSov8EMktdtBf77y+L6r5UZkyMh0H1KnUTMPErMyvH1G0fxFkXHSKW9QlpFftby4N9fu8SBJg6eVRcx67mElRBTVmTJI1HLe6rzwd+ePbeMoQKecLXd1hl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749745730; c=relaxed/simple;
	bh=uPO3p+Bzt5Civc5Dd5c6rZ/T3I2evXZb7b1MxLL4zmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ltl0ZWzG00Q6+rmUnSE0hMhGirhrWSOiTYPlCFzCnmH5PVvw58frXf9bbfgKH29cRclG3tQoHUWCFcA7U690EBQn4uaT6rWBO0eTafI0jtli62s5uKzQtTFMzxVfJNLyinYBVnmgwRZJuDnQyWoSKzVsXxyE2ooGBwSAH4HzOb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fx3T1WiR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx3T1WiR"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so10065295e9.1
        for <linux-openrisc@vger.kernel.org>; Thu, 12 Jun 2025 09:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749745727; x=1750350527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kjmFrdeNhutTMNYJTVVPydWsY7q+n9MQCHqvQ9GcvJg=;
        b=Fx3T1WiRA97NvWf+B1oCN6pqCxD2m1sdCiD1/Qy/8+B8m6l1ZwjqnGphd7zCf7HQrm
         7muL6xo4S0vJY0UER8cYMcMXs/xaY+AlhQ8L5KdeQUO3VndRuCzM8eldpp/kR0FvcWEE
         slEka5Z7GVx9w8FV7/KbcY5VH9vsnAFpDLPhDKPSD7XtErY78MO8UIDk2vLUD5mW6NHR
         xFhl5S8ZTT7DXS5m1xNXYjsn+iSOh5h/PmOpwvrYokJaFAwbvQUr8e3jh7QO1dMtXph4
         3qqSQ+V07ibFCCH8J9NdruZ1qA022kKXrcaGO02W4RiV63/IFWUrMnH/34mEWN5kCkxT
         KAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749745727; x=1750350527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjmFrdeNhutTMNYJTVVPydWsY7q+n9MQCHqvQ9GcvJg=;
        b=dIIudwTWootdQCcq1UQkfZBuaIxK6LxaTJTRCgnRV/x8JuwfyQcYzJebYCjFnwmb6r
         8AyCKMJ55G4il5cbSSoSzedxbtrJazaEKSKUSZzoCO15KqZjkwRLxytZYMBI/pAlkthp
         9dvppV8t+7MEDenlIQVLzaHdG6t32Eo01zlT20K8MSF/oOYya81N1q7aBDxrKnZbCsoB
         5UmVwMmQpKw8f0R4FJxcDnahFfpBz9vVV9ezsLIx8kO1DDA38vOPgRA8GoRvHSvyAd73
         vvYGTWaOlA4wfnglCWhGWTApCj6apMEB3A5FIy5iUkA0OSPf6b3dfB5BC+DSDRfz1mYG
         1esA==
X-Gm-Message-State: AOJu0Yw1VEtXPxBY5qUJawakB54+zrjfsWdMA81rCX9/+qdeJjjaoCXi
	scIMD1qO0nysuH7NCaIrdsVaa8j45R+OvUV8O2mwusoRYiG45KAz/6Jyv0Vh5Q==
X-Gm-Gg: ASbGncugmvL2V0ctNFBnAxjqR1gPseyKs/hyY5YyN5Q1inRsGTpKCuY9YX8O8g38Jxy
	6q0b+U68HyX+1iwAo5PKCd9irkD6v0dUFGMa38itRsUlaNX4lsETrMoJYrR7g4luk3tpF7q77fn
	+bKxPHqjYUT8SSmdZ3ocGvGSXarHY/B8zyKQGAaSspNcBBvKW6mRo8cq1+7ZfILlW/EKrbbGNda
	8OkVJ4BGUEi9+j9mGgmN982z+KC6G4P1/o+rqX5bpvwe85KQ68mP3bPoU8rXC2ZMdYhqRHtnFPN
	AvSVuitnCaBNy5qpin0gVdNtByCaLwYGo/2eIFRr5Vh4k17ELd7hK7yIkDi2UE1u3n7W4vovXOB
	YU0lOQBFuOTi6F6Nd+gwP+NTYiw==
X-Google-Smtp-Source: AGHT+IG+dbVy9OuadEpxgiRvVeXO9pN1eZwxsoynDxICv6fAbCYCRcvL5Gs39FcXENU8H3A69br8Zw==
X-Received: by 2002:a05:600c:4f07:b0:450:d3b9:a5fc with SMTP id 5b1f17b1804b1-4532490d350mr70266555e9.27.1749745726677;
        Thu, 12 Jun 2025 09:28:46 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e256d95sm24997775e9.31.2025.06.12.09.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 09:28:45 -0700 (PDT)
Date: Thu, 12 Jun 2025 17:28:44 +0100
From: Stafford Horne <shorne@gmail.com>
To: GCC patches <gcc-patches@gcc.gnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: [PATCH] or1k: Fix ICE in libgcc caused by recent validate_subreg
 changes
Message-ID: <aEsAPJzXb-pTzBD6@antec>
References: <20250609185946.1538314-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609185946.1538314-1-shorne@gmail.com>

On Mon, Jun 09, 2025 at 07:59:46PM +0100, Stafford Horne wrote:
> After commit eb2ea476db2 ("emit-rtl: Allow extra checks for
> paradoxical subregs [PR119966]") paradoxical subregs or the OpenRISC
> condition flag register (reg:BI sr_f) are no longer allowed.
> 
> This causes and ICE in the ce1 pass which tries to get the or1k flag
> register into an SI register, which is no longer possible.
> 
> Adjust or1k_can_change_mode_class to allow changing the or1k flag reg to
> SI mode which in turn allows paradoxical subregs to bre generated again.
> 
> gcc/ChangeLog:
> 
> 	PR or1k/120587
> 	* config/or1k/or1k.cc (or1k_can_change_mode_class): Allow
> 	changing flags mode from BI to SI to allow for paradoxical
> 	subregs.
> ---
> Sending again to correct mailing list.
> 
>  gcc/config/or1k/or1k.cc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/gcc/config/or1k/or1k.cc b/gcc/config/or1k/or1k.cc
> index 62e2168e0ee..f1c92c6bf6c 100644
> --- a/gcc/config/or1k/or1k.cc
> +++ b/gcc/config/or1k/or1k.cc
> @@ -1408,8 +1408,9 @@ static bool
>  or1k_can_change_mode_class (machine_mode from, machine_mode to,
>  			    reg_class_t rclass)
>  {
> +  /* Allow cnoverting special flags to SI mode subregs.  */
>    if (rclass == FLAG_REGS)
> -    return from == to;
> +    return from == to || (from == BImode && to == SImode);
>    return true;
>  }

I have pushed this now, it restores the or1k port to be able to compile again by
providing the behavior with subreg's that we had before.

However, this did uncover an issue with how the (reg:SI SR_F_REGNUM) SR[F]
register is treated in OpenRISC.  I think the backend is producing sub optimal
code that's ok because it gets discarded, but I think its preventing CE passes
from producing optimal cmov sequences.  I am working to fix this by either:

 1. Working withing the current contraints of treating SR[F] as BImode
 2. Change SR[F] to SImode and added proper splits/etc to make it work (like sh
    does)
 3. Harder, convert SR[F] handing to use CC_MODE (this might work the best?)

-Stafford
