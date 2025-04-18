Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE79019D898;
	Fri, 18 Apr 2025 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744962434; cv=none; b=riDkVb1VhVSfX8JDN3WU+VF3M1ZtbdE+ogdhT8LZhuidq0v4+jhLGF67klxgPqV+smeRdWC5u5IsvxI+dTnLnuGitjscqdg5hxU2yKDuZuWjOuzfWGCWsZCom3VoXBz9OJmijiEOS8UKbyhYrJAqzgk08p3+tSSshRa+KyBl91c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744962434; c=relaxed/simple;
	bh=MbtUPtvvj3TCYAMSHd4Kc+YfY9lvMZ5DrE3AulrQrNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxMY7lNfD2dQT+CKXgSBzquj2qr713+oWH5bLGtiMZozVvsrH2+bazxHGnIctvK7nz/LzYB/wyXknpiC2nOVzhujWAypVzLDHAfVYJtSU9/AC+GHgIqU7+Y2ND1ZAlA9Mq9k7YNw356sGUwrIDdDakmZpo2/HzX2wEViDcMHZ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUDNmr+r; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUDNmr+r"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3995ff6b066so890899f8f.3;
        Fri, 18 Apr 2025 00:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744962431; x=1745567231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TzOX89SomSA3xclvKwx4fBR00BceY95Bv5Epbfz39/Q=;
        b=PUDNmr+rfioxcFLrfpsnJawpXfnef+3HzZbG1mWIou3NpNkOOx9jo+vESejLfgZI4R
         6PerfDEvYf7uzUfwtwFIAAEfacatb1Hi+e2Wemxmel5r16OkGIV+DDtqpz5+hDUVTLA6
         nXour3uojjdbnQ6Bs0rJH9h9oxVXytnI1cTUZydVAE5JaH74XhcAfH3R9Hwg1UpfgO6z
         yzdqgbq08X9IhwjtRq2rrcYOCzgrmWTWYMYUNsDmHvMxopnhmILmladJLy2/QZHNkafp
         A+JoBbGudOyKiI/k7GHJZODqFcb2c7HWI1TlWq/7ikfDS+v2jZ+6Id1Rr7QKQO8rhHkB
         ehGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744962431; x=1745567231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzOX89SomSA3xclvKwx4fBR00BceY95Bv5Epbfz39/Q=;
        b=IT4jaTM+LVIxSt6NhFtNllw5ZrPUwIf0+BRVMPaG1gXkuuA7JZje+08Mni40wEGSIU
         hmhUigZlOrXe2Ex78mGrKsK38OTgBXYQg1e68QCPxVVO6jf4J1+cw3GKHBD0/5pZ3Q2J
         5pDEg/zSxSqZCBPya8L0J3+iNYWo4eykQ135a889ypL8MAPNXGavODZmjwyGRbU7EUOG
         w5KuB1hCkt+1tQOcD+i/kGcW9mmzjLpSQ28OJtRVWKn1JDOFw8jriYuwS6dnF3MWOX1k
         UJAJV0hU4tqkRekOBcvid7n3ezsD5BwI0+pakrwqGuRLXH/sqPMZ3/wQy0rw3Z+8T0rv
         XeeA==
X-Forwarded-Encrypted: i=1; AJvYcCUcY/QfKrxT/Siw7rGMK5Zn/wxvb1tjbYWBSw4yqA6YedEkN9aFL2eOhdL4aGBzs/9ZczWg9MD5qekJBPOlFnw=@vger.kernel.org, AJvYcCXKX9FY8dCmo3hieTqom3P58CJF0RPF59BHewPOHPuYk3Svyk2nXpvY8HZceZ0PcdOcz+ZVXyiMtD9cn+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAIlYSHbhltt8Cy3dylo7PKD5Jp2yqnHUu5DZ5mbIaZKZm7qBK
	LeLxp9eqbP0VYpifi/yhfpoXFKPme5gtGXXEv3tK2XmAS6MbSShr
X-Gm-Gg: ASbGncs45Lnv8LtCpu5LMUCsqrOuP8OezZb1dH/O22A+YozHKH5fhrTiMrepZ2p+5fZ
	ydLxpclgMo5HLG0mAdkf1LJ2Xtdh3TKs0oF7V4Fa3DmXfyaY5ocQ/c7viv8ZwJJ64s9mxp3L/BY
	bvMp3x5yWRMlmMmGBINhp4+ZB06gL40XZt1YLIuemvOW5TvxF3WjWLXjeve7AncZq5ocqoQ8HWo
	6r/kSvjSOptNmXIMG/AeVHcxqUtFGY+YQkxTJfbHg0QAbInybpPJbbTg2kukoCMTjokJF35u+Ks
	vKtVTT3zayLoiYRwxofb2utG/TPYZxffuJw5QuW46k98Oyaj2JXQCPITGcOeRJEF2qZa5E/GSOZ
	UZo5Z7+G09gkK/yM=
X-Google-Smtp-Source: AGHT+IGwANU2quVjQS0PiBWL+69cn6sm4Ww5tz2IbDKvbOcZeplsf7AT2NCq1b9uV9IL8fRr+0aRoQ==
X-Received: by 2002:a5d:6485:0:b0:397:3900:ef80 with SMTP id ffacd0b85a97d-39efba52e6dmr1167558f8f.22.1744962430967;
        Fri, 18 Apr 2025 00:47:10 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5bbcaasm12371985e9.21.2025.04.18.00.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 00:47:09 -0700 (PDT)
Date: Fri, 18 Apr 2025 08:47:09 +0100
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	sahilcdq@proton.me, linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] openrisc: Fix build warning in cache.c
Message-ID: <aAIDfcZ4XD5f6mA4@antec>
References: <20250401200129.287769-1-sahilcdq@proton.me>
 <Z-6VyRhGdInVidsw@antec>
 <af85b465-13e5-44e5-a0af-c7c68af7d43e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af85b465-13e5-44e5-a0af-c7c68af7d43e@gmail.com>

On Fri, Apr 04, 2025 at 10:39:22AM +0530, Sahil Siddiq wrote:
> Hi Stafford,
> 
> On 4/3/25 7:36 PM, Stafford Horne wrote:
> > [...]
> > I will just take this fix and apply it to the series (git fixup) rather than
> > take this patch as is.  Also, as registers should be unsigned short, I think
> > we should change the type to that.
> > 
> > I will fixup patches in place.
> > 
> 
> Sure thing. Will you be changing the register types as well in place with this
> fix? Let me know if I should send v2 of this patch so the changes are together.

Hi Sahil,

Sorry for delay in getting back on this.  I was working on getting this patches
ready for upstreaming and noticed one thing:

    ---------------------------------------------------------------------------------------
    ./patches/or1k-20250418/0001-openrisc-Refactor-struct-cpuinfo_or1k-to-reduce-dupl.patch
    ---------------------------------------------------------------------------------------
    WARNING: From:/Signed-off-by: email address mismatch: 'From: Sahil Siddiq <icegambit91@gmail.com>' != 'Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>'

    total: 0 errors, 1 warnings, 102 lines checked

As you can see above the scripts/checkpatch.pl is failing with the warning
about your email and signed-off-by not matching.  You can see more about it
in the FROM_SIGN_OFF_MISMATCH section of the checkpatch[0] docs.

How would you like to resolve this?

-Stafford

[0] https://docs.kernel.org/dev-tools/checkpatch.html


