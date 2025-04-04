Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1210D2E62B2;
	Fri,  4 Apr 2025 05:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743743374; cv=none; b=S6geISX79XvgcSDU87x5n1KONNvnk/D81hB/8d3DXVYMk2jTbLQl5VWW4ZMzfW5BHLCzInpg9RTziW7cbIAoU+wZFWhc02YV+WDlXKZqW+xs+MdgLlgOsCY7TlX62CMUBd3sUtATaFzui7HL81ZCIUXhUC72KkcBOUkfuxaW9DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743743374; c=relaxed/simple;
	bh=+Y89xKdY3aybpX6e1Po7JdL1tt3WjlRY6OuWx+f16Ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHP1aI3VPdDr8fy736ohpYn5DSEyhqbPmgrgWphfTgpYH/qidUPWTCbumEMV9VyMNONB/mByWCeqWok1OR7LvVGGIOZixAOjABCabSHpp5Y+Gyulme04mvG4OHkvSK6xc703r3IfAlhEv5yD43c9+YpWkB3nNp8JLLmhJ4HM0Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPFARCoH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPFARCoH"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2243803b776so24032965ad.0;
        Thu, 03 Apr 2025 22:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743743372; x=1744348172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wSKBdKJWD85BGkVJG82rz/2xZOHcRMfuk0+Kg65yG/k=;
        b=MPFARCoHwA8FG8NH7FmvzFPVIXVaCTZ0JA3Oh7+ruG2fVyCrW/eZXXr8lPqACeyn5v
         zcp6K1z7rUjA+2ONsa0xYouZ0PhdJfMwfWjjtJIwABEneb58+GAdeEdg1nl6FSRb0fFr
         CX7nw16QxPgciXvni6KA5wxDt1p0cTJ+m3PvqqQ3AWaImkDrBEV2ovOVxRza7SYciDYq
         nLWcUDzQ4gelFO+Elsd72pACH+gevKNIHjMxtdTmewpTlkjjz5i2ujibSCGj4g6DzfjO
         rV5jao2B/kNemUxyXP9BMKBoEq2yZbDMKAyIRZ2Wuj0iPd/duxATBWX/Sw2E8suvposm
         2+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743743372; x=1744348172;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSKBdKJWD85BGkVJG82rz/2xZOHcRMfuk0+Kg65yG/k=;
        b=p10gcdyaxwzKP/R7EAZTlxMyTzMdHXVOELw305lr5KT9lkFUxZIsULKvWrTBSRVzS4
         Oyd7z/mZ4QxvGC4tRQbyOb6oMCUhri+50j9t9ImEUK6CA/TCMUHiKQjUtN285ax8vExa
         wuCaD45KATuLTbk0T6crS4MJD80guUW9muVQHNJKh+I2jbvshfx9epuZ5MjE67K2FrWt
         +3Zczgx7wfGLRxt9zZzU9kYPqilJigAmmsnzDVTp7NJRlOQ8St7gKphorkXXm03ps6gO
         FDxqYOZdemNqM4xQpcSnE/6S6kTa5CoJoFv6YJ9fZv0RnABc3IesEeOtNqYrBoN3mxH2
         yKPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMJ3wuGqzNwe+SbKdhUDihTWDizA88MMQzFjrMQtVWovZZH+Tm24yoxw/Z5Dmh5FjYRLFkuJ0smB9ITgk=@vger.kernel.org, AJvYcCVC0sdPGpEyp3Ba3w+Q2ivWvOI5WrhoupzvPkkCjXv5fDLdEBQKcnYZHpAcT5Nfq/gw9tQ8PCCdb2Hxo6qeD6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSnN6XB/q9D7Y4qRBZ+FUn2RfGihui8X/Eqa5Rua0IOyht70yY
	Sb4e9BYkawXcHbs4VbZMcpVoamfXIHHWlvxL/IfhTYAvAldwzkDF
X-Gm-Gg: ASbGnctSOViVhF+rUZ5pnFAj7rm0kle+k8TzPMtsIRtJ3/G+kfyGxHDQcYMEaGRhwah
	PtNNi6PLQd+I0WlmF5gCahNHM4+EfHUJhix6kOZp/afjLVyPDRGYt1IYZd0ilPDGPg+x+c0JBE2
	tS8xtVQa3IWJ2wrQ/A34HYxkjzzpAV2OiGcKw5E8PwKMtPtJa+xmjQV9gM6Q212OqyjmNgrWSh/
	mhBue5t3yPihFwmQihFFqRRmJuKJ94MJm8Qmcx9+sbu7dpO9A3ItRPeZJhzn1r/eYen36kDQuky
	HS4WTDak7J/Ysarj/kdesKz028nOqm2l0d95HAiRrWXFZ0Y/MzkjqwHJF8E/Rh9KHtc0g2cXNNf
	sje+eta9cP9y8
X-Google-Smtp-Source: AGHT+IEanHeNGYxM9ZfIUf0DXDVlfWjo7Bj0q9virSicUpWfttVcUSwisBFmzQ2nyhEd83Bv9pqF9g==
X-Received: by 2002:a17:902:f642:b0:220:e896:54e1 with SMTP id d9443c01a7336-22a8a06af6amr24516185ad.26.1743743372375;
        Thu, 03 Apr 2025 22:09:32 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c44:1eed:2902:4d97:bc47:aea3? ([2401:4900:1c44:1eed:2902:4d97:bc47:aea3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e173sm23535165ad.192.2025.04.03.22.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 22:09:31 -0700 (PDT)
Message-ID: <af85b465-13e5-44e5-a0af-c7c68af7d43e@gmail.com>
Date: Fri, 4 Apr 2025 10:39:22 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] openrisc: Fix build warning in cache.c
To: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
 sahilcdq@proton.me, linux-openrisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20250401200129.287769-1-sahilcdq@proton.me>
 <Z-6VyRhGdInVidsw@antec>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <Z-6VyRhGdInVidsw@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stafford,

On 4/3/25 7:36 PM, Stafford Horne wrote:
> [...]
> I will just take this fix and apply it to the series (git fixup) rather than
> take this patch as is.  Also, as registers should be unsigned short, I think
> we should change the type to that.
> 
> I will fixup patches in place.
> 

Sure thing. Will you be changing the register types as well in place with this
fix? Let me know if I should send v2 of this patch so the changes are together.

Also, should the types used in mfspr also be changed?

Thanks,
Sahil
