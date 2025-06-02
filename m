Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D832C326A
	for <linux-openrisc@vger.kernel.org>; Mon,  2 Jun 2025 03:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748834271; cv=none; b=P9rl+6cMuaYN153bZn75Nwi2QuTRjywoCQ8b9hcb0A+OKut+LnQDhMuHu/DbaBiPUrDk6sQjdRGn2U9DJ9LDwVutfCYf0a6KBtTI6ALl2a9896QsM05f3bJuII7nDaB8pfpTWT/OczO0Q70OcJ3umK587RayZ6CnhnAG4hIYa14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748834271; c=relaxed/simple;
	bh=QA6t1Lq8mi6apLSOn5R+JBJX+RcNBufznVXfy9/6DT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaFWMmGlc2ZvToVeJiBlzSJzC1YKckCTIuN7a3Dmbf3lHrVGHWqRad4G1c3O7s42FRiQ+S3c/XzuPpVEVRi5LAwcCKLObIs2bAO6khHEd/Qf6YvdiNOVKJkI3Wrb44v5Oz1DPXR5s6Eh8XeYv2TqrejzF5Nh9y48ix834DEusTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KireGKb8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KireGKb8"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234488c2ea6so41008445ad.3
        for <linux-openrisc@vger.kernel.org>; Sun, 01 Jun 2025 20:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748834269; x=1749439069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3OaGJSLjbqlx9G9/gMKW2P4eEfkmk9doG+mBFIuo7q4=;
        b=KireGKb8Y79gcnL4LuMoBOb3DB+P4QdT/gPOIapvUo2W2YNMqlRNA8O7ZfA5arTPZX
         /tBBxrYAOQtO/4m0qoiJaEMSzxbdKiBtSgIbUoAuPSvmXoHFksU5+BDgJp+qbJ4a/kg8
         saLNK/W9O8v1QmgibJ2Wrhnqf1+1HTJyPnMo2YkUeCeB4G/XfUF0iHpxAIBeYraD4kJG
         uMem6w8A29lIBuBr5GSiCwb/wSTQux6ccpwdqei86sl6K2OwNfMRuLX7DNmM9F8sGzMM
         aHgAXVh81l3yiP9i4gkE73mmgJkjEnXEtgvdlVlztGKkijarkNr2qnHIwV7ajJJBuH6D
         setg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748834269; x=1749439069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OaGJSLjbqlx9G9/gMKW2P4eEfkmk9doG+mBFIuo7q4=;
        b=UWZRZ8WSH8N4+mzWiI/ztM5mxukoeuOo6zJAfXKjKBgdePlma0RwB4X/0H46ZG56li
         1DhnWDPQD/Ag6uqraBfzrYmTfNTXvmGqTrxQ6UBRKKgX7O9truO+oPk57cgLDeNfNOox
         E/5YOH9ytlTQ98V2Sz5AUv3aL6ltwbM6aRZ0kFUz+4v7eDSWmQfjOmf9vaNcbajHMZ7M
         uZGGxwxacgIZQlvblXbPRQBV/NuU7NUEypLswTkp/88A4udguUDn1a0cvL6JLdYH35I5
         LdjcBoNfKy9Z0uitdBVuaxfDva8v/SWeagZRzkIXqSdnIaOM6zi1ybaLAfbtgqaIlx3M
         WT3Q==
X-Gm-Message-State: AOJu0YxJLZFGcUwPZ7o+9zo9UO//wioqgoWAIe7B1NwfBnFBX8hxPpzk
	SHr/2ZivKhNzILPXIkTPYOFKvTcN8U50qyBnqnRmlaX3yCEzp0NkXXKgfWs9qQ==
X-Gm-Gg: ASbGncszClPEF5md7LwBnnIH492xd5qhO71k1jA61J9CP01mvEeKgCNSwVNwWPUtNOr
	XC+tLeyEuiCAjJ/QyxVrz9jk+qxUUPcZlDAHvG8Jsa7S/CGBXx/BvbzuWdK9HC+7eSnahdWU5f6
	feVo4lan6/Ch/rGeD64qPDuhrfrcSDssCiqMJlWUG+R15tJGqqHcLyJtg0Srn1OK4Kb0FMWl/vW
	T0V53usxUbWVJsCakdxcdTSRcp9h0JSALWRavJqdYNV/UGnta6fAHSV+GLwP4o60Na85F6Eguwd
	lzoVI81zqpa9S5rsf2AGfKgQlmD06v5Uk54e5bSv6FyZ5FSYeH8ka4AJ
X-Google-Smtp-Source: AGHT+IHZ11LeY103DCwIHKUw5eoFSsYGdfrGbb2oCEJOwhFnM9SUk1t4Q2ZmjyEzUCT+lQt9OVuV+w==
X-Received: by 2002:a17:902:f70e:b0:235:be0:db53 with SMTP id d9443c01a7336-2353965b008mr125235345ad.51.1748834269011;
        Sun, 01 Jun 2025 20:17:49 -0700 (PDT)
Received: from [172.31.0.38] ([136.38.201.137])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2ecebb4834sm3999533a12.74.2025.06.01.20.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jun 2025 20:17:48 -0700 (PDT)
Message-ID: <9cbd6d7f-c5d0-4825-9b06-e694d32cdecd@gmail.com>
Date: Sun, 1 Jun 2025 21:17:45 -0600
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] or1k: Fix struct return test
To: Stafford Horne <shorne@gmail.com>, GCC patches <gcc-patches@gcc.gnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <20250531060321.3687859-1-shorne@gmail.com>
Content-Language: en-US
From: Jeff Law <jeffreyalaw@gmail.com>
In-Reply-To: <20250531060321.3687859-1-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/31/25 12:03 AM, Stafford Horne wrote:
> In or1k structs are returned from functions using the memory address
> passed in r3.  In the current version of GCC the struct stores changed
> from r11 (the return value) to r3 the incoming memory address.  Both of
> are valid.
> 
> Adjust the test to match what GCC is producing now.
> 
> gcc/testsuite/ChangeLog:
> 
> 	* gcc.target/or1k/return-2.c: Fix test.
Given you're the maintainer of this port it seems like you can 
self-approve and commit this and the long jump offset patch.

Jeff
