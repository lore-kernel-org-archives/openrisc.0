Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B7B248F64
	for <linux-openrisc@vger.kernel.org>; Thu, 16 Apr 2026 05:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776315656; cv=none; b=UyiZBwQ1+4xT5MAbhHNi3O82313aOKQ0aCEgFSeLwNUfBAV/mcyMPAqvrfeSmk6lnly7wUStkqe2vfSA2frLXBkLQ6KhPROKyn1vT7VNPrtM3TFe2lYN0OJMm62Qn9o50zKSHikRwNQF6KpDL41Ueb7pdH6KgwslTbxe5CEibRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776315656; c=relaxed/simple;
	bh=3td/4pzvTWG4IxGOMMNe4K0Irv/bKmWmSKQjnrJ7WY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxrrYVCQcir+Fw+IP/XzCB8pM3TpYXnnHfYYA9Lkue5PSybgJWURf9G4RMUtMROMfFIFSC0sSpPKck+D84iYwvA6IsYTGQg9zzQY1O9neQyK9qAcUiZqbOFicmjQ6KQ771esiwmQPkvgP+S6qf3Xd+5G1o3sQbL0rYjjLnSAX98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOjAvnR+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOjAvnR+"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35fc0d7c310so2223397a91.1
        for <linux-openrisc@vger.kernel.org>; Wed, 15 Apr 2026 22:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776315654; x=1776920454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OIZUNYBIfgLTI50i/59UGonoLFUcrsjmVah5AkMbODk=;
        b=nOjAvnR+v5nQc5wmKAOfI8ucVmnnjOkxXTruBmKkrp4B3cJmsjqRqTyfog7noY7QEW
         XbgL01qhZ5b5Qpua4Bq3FusW4Fu7aogoxJKaVspPOGrb/drXJ9ObPgNv8VyGQSXxWKR2
         VMveO1HYNxuBRV/F0g3SmKRCsJKO6l6BR6OG+uGYOJFqjAwkPh0jotL/ATDHRneUzsq+
         kLYcCoSmddRjKiGaFlmfoEVYLCTCttRkxx2Uso9Opz5vDGK9bwGzo6oWgY/Eis1UTrDl
         oen+e2yzLgXhXts5p98rVU78kt9zrDfz9e76n8ck9z7k19LG6CzHqgsS/dpDOPL85SXu
         /OXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776315654; x=1776920454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIZUNYBIfgLTI50i/59UGonoLFUcrsjmVah5AkMbODk=;
        b=J1gencp2pk6Izehrz6SAzJXALwkwM4IKU/NxqlydxfN2OzI6hCK3V/G6B3YmIGcLKG
         OwqZnU9+y+YIL+Ef8j5/0RZlao1UQasYhzUTz0Oek3tgkvjdaJqPizdbLe5Dyh/U9LVE
         te62q1sJHG+GxNmBiiwxvZvDOFB/E3puj9YnbpUFrkSK75+ndejWIKDLFsVRv3q3QC7x
         YPnAnsgchm6uyyz6RIkB40g4vGW0VNu1v79jyRClXORlQR3w9cj4K6KkgzzBLFMBevGJ
         BMpzzBIoZFQpEgmIqQk9t3lK4NLj+jsWipuH3mY2Gt4WiqUxdPMVuy/NHllCKEgpx6fH
         rslA==
X-Forwarded-Encrypted: i=1; AFNElJ+8ywNM4dbL/3VR+zC35V5mHzhENUXkKmf8JOacl0emx7D+u34DWsgAhYdb7MD3XjnGGA80bGW6DT7aBCwxig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzIuEgXstPZfVygbe4Cy2Pf8+cY+1mdTGyCchVDQbUBr1g0smM
	4q+7NyPYkc8PoeE7PYd34L5v+ZupYNfAZeTPQG20+FDfhD4mgxao5/r3
X-Gm-Gg: AeBDietcL+iMMYscVLKJFvmyV23m3H5i+E+KPdbKMEdFooe3msRXGp224DXeJ1Qvjch
	HedKq21yD7O5ba200wmA8AHn474naDMGYASmcEJYB6+Alx09HFrXwv0GLtoMD7nghTBHlP6+Yd3
	pfUajgl0j+1whRnL0+FkZ5D5QcsszIcxhWizZNQ9ozVkioxTN5rbMUTJLWX5QkCZRYF0c8A25NU
	hPnqXZuJujTOCmg96XYNnKs3JYb+ut0Es9s/BMwpxUX54y0vDs82WI2xzHRVx08uFPfeYo2rrFZ
	pgnke5npObCBii56YqknkoL22BiLwBrzmvT3lpd4G1dag2Bzj15HID3fMocG1tdn9TWk9vsv073
	8uYxeM4H2bMYXwqQHHoDo5lLm+LaLiJxJu88hjbpagDtSqlncmlWrzlGCYoK9VdvCcCf2susYWa
	NhG29faegnq9F3fHY5LXA1orcOy5976BkY82WNAsIuFNWdb3b3gH4BiJxvqtlyyIuLi2qgDIw=
X-Received: by 2002:a17:90b:3e88:b0:35d:a557:e41 with SMTP id 98e67ed59e1d1-35e4281c1f9mr26138770a91.14.1776315654271;
        Wed, 15 Apr 2026 22:00:54 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c42:2fce:8c3f:5fe6:9cda:e56? ([2401:4900:1c42:2fce:8c3f:5fe6:9cda:e56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd1ee59d4sm2124933a91.2.2026.04.15.22.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 22:00:53 -0700 (PDT)
Message-ID: <20b14305-d13b-4bba-9837-4226e064caab@gmail.com>
Date: Thu, 16 Apr 2026 10:30:46 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] openrisc: Add support for KProbes
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
 naveen@kernel.org, davem@davemloft.net, peterz@infradead.org,
 jpoimboe@kernel.org, jbaron@akamai.com, rostedt@goodmis.org,
 ardb@kernel.org, chenmiao.ku@gmail.com, johannes@sipsolutions.net,
 nsc@kernel.org, masahiroy@kernel.org, tytso@mit.edu,
 linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260407185650.79816-1-sahilcdq0@gmail.com>
 <20260415154826.fc8aeb67f1cb3aa58be6ac48@kernel.org>
Content-Language: en-US
From: Sahil <sahilcdq0@gmail.com>
In-Reply-To: <20260415154826.fc8aeb67f1cb3aa58be6ac48@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Masami,

On 4/15/26 12:18 PM, Masami Hiramatsu (Google) wrote:
> Hi Sahil,
> 
> On Wed,  8 Apr 2026 00:26:48 +0530
> Sahil Siddiq <sahilcdq0@gmail.com> wrote:
> 
>> Hi,
>>
>> This series adds basic support for KProbes on OpenRISC. There are
>> a few changes that I would still like to add and test before this
>> can be considered for merging. I was hoping to get some feedback on
>> the changes made so far. The implementation in this series is based
>> on KProbes for LoongArch, MIPS and RISC-V.
> 
> Thanks for porting!
> Sashiko reviewed this series, can you check the comments?
> Most comments (not all) look reasonable to me.
> 
> https://sashiko.dev/#/patchset/20260407185650.79816-1-sahilcdq0%40gmail.com

Thank you for the link. I'll address the review comments.

> Generally, please make better use of macros rather than magic values
> in your code to make it easier to understand.
> Also, use GENMASK() and BIT() macro to define bitmasks and bit.

Understood. I'll keep that in mind in future patches.

> Thanks,
> 

Thanks,
Sahil
