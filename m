Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793492819;
	b=1IUm5hcf2agbmkCKTDf7f9lknO7sz+iLel6J6jqS3Ccjw0vrbCTN5Bbyh3O6OTLJ1/xP
	 hiidEQSTzgIUkj8md95TaeTwcQ/ZXmvnjx6fc/xKNhmnaLH6DvyIvud1fsblhfbQdJl+C
	 98e453t0sJb6ZNX8hTA1vk9PHCyhXYY8eamZl+vUCq2JhX/XX3NniNo8HIjGXVzSckKGR
	 OYQqdTIy3sOlyCEIgRbfTPB4PqNeAh3e6rIr5br/jYjuHbyS2eT3EOhWJMiEXbIKbcK+Y
	 4vAT3DpU24w4RWY11r6wCU6zKwRgnbh5rBrVwyLoudA0WLZac4Pd8nUGVxGwqb6txrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793492819;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=LC77J+RN6Dhy59laDBKh+N+IhdE7yeQVClWRQIT4qUg=;
	b=2qKfWxZiuxJKw07FI1ZM9X494aSG5yhlYvjWjgtSBSaj6Ipc5pZ1l8aV5TDFmHyZaC5L
	 Dy9sH1xpT5LYu0OlA979BV81KbdevoLEg7iXZnFzdpX4vFjDZk35l4r0Sql5DaAvhlXZM
	 Ozt2s8cma9sOiMMg+BAXD1BL6VUZlJAs1xCUIdx+sTIfhGydTycncwAfF/N5euaWX6qJH
	 S0JaNqAoJGZHVnWWNzyKV4oC6NT8YQhaaz/GVk8VKRhI8wceL2mMdGP7sOY/wvomFSscv
	 TothxhvjEIXVFFeAIHMKjOwMonfveZYMWAQ7sGbBI8FgejDfG5RelEsT5ovef9RUiMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LSJi3sDz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF55606A31A;
	Sun,  1 Nov 2026 00:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LSJi3sDz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9621F000C1;
	Sun,  1 Nov 2026 00:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793492818;
	bh=LC77J+RN6Dhy59laDBKh+N+IhdE7yeQVClWRQIT4qUg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=LSJi3sDzqNH53xwgmCQVRjs5P3KxhDowBzhYuUU8msQ2AgB7lpotYxsHRrJG0iClj
	 kpIrcXC40v6h63d1PdapIP12ArfdiJoWwpWDXHQdq1no5M4gvXZ0KVb1XNuiiAzYu3
	 7GzqVw2Pcn1U1Xz+6nbGQwhOSWakM7WMwGBaWsl0hqb34ftplQn7PLgeKJqsCD/XNW
	 t3n1MCHTs76kO1sksUX6LYr948fLQUWPWTcEIgxOf/3lq2NM/mgiXEsL4sbiIBLwpB
	 KX6+RWCZD+IEqyN0t4epgjEdQspqh8J59zPctS4a5HZB/Owc8dTCb/rOIVtS1AqPO0
	 aIxSiDg5CFOUw==
Message-ID: <e9f9ac85-442a-4bcc-8ec6-a03a6519178d@kernel.org>
Date: Sat, 31 Oct 2026 17:26:55 -0700
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Post: <mailto:linux-openrisc@vger.kernel.org>
List-Help: <mailto:linux-openrisc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-openrisc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nios2: ksyms: Declare __mulsi3 export
From: Vineet Gupta <vgupta@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Dinh Nguyen <dinguyen@kernel.org>,
 "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>,
 Ley Foon Tan <lftan@altera.com>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>
References: <20261019-nios2-mulsi3-v1-1-4fd75b1bacef@linutronix.de>
 <47eb6b48-d664-440f-84b6-ba09f34d5e08@app.fastmail.com>
 <3175caa0-9f49-465d-959e-6b6c9bbb4f01@kernel.org>
Content-Language: en-US
In-Reply-To: <3175caa0-9f49-465d-959e-6b6c9bbb4f01@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/31/26 16:57, Vineet Gupta wrote:
>> * no generic implementation in kernel, need to copy from
>>     libgcc/lib1funcs.S code:
>>
>> === __divsi3 ===
>> arch/arc/kernel/arcksyms.c
>> arch/nios2/kernel/nios2_ksyms.c
>> arch/openrisc/kernel/or32_ksyms.c
>> -> arch/arm/lib/lib1funcs.S
>>      arch/m68k/lib/divsi3.S
>>      arch/microblaze/lib/divsi3.S
>>      arch/xtensa/lib/divsi3.S
>> === __modsi3 ===
>> arch/arc/kernel/arcksyms.c
>> arch/nios2/kernel/nios2_ksyms.c
>> arch/openrisc/kernel/or32_ksyms.c
>> -> arch/m68k/lib/modsi3.S
>>      arch/microblaze/lib/modsi3.S
>>      arch/xtensa/lib/modsi3.S
>> === __udivsi3 ===
>> arch/arc/kernel/arcksyms.c
>> arch/nios2/kernel/nios2_ksyms.c
>> arch/openrisc/kernel/or32_ksyms.c
>> -> arch/arm/lib/lib1funcs.S
>>      arch/m68k/lib/udivsi3.S
>>      arch/microblaze/lib/udivsi3.S
>>      arch/sh/lib/udivsi3.S
>>      arch/xtensa/lib/udivsi3.S
>> === __umodsi3 ===
>> arch/arc/kernel/arcksyms.c
>> arch/nios2/kernel/nios2_ksyms.c
>> arch/openrisc/kernel/or32_ksyms.c
>> -> arch/arm/lib/lib1funcs.S
>>      arch/m68k/lib/umodsi3.S
>>      arch/microblaze/lib/umodsi3.S
>>      arch/xtensa/lib/umodsi3.S
> ARCv2 has hardware divide so these are not needed, but ARC700 doesn't
> and there's a ton of calls for those.
>
> ┌───────────┬───────┬───────────┐
> │  routine  │ calls │ functions │
> ├───────────┼───────┼───────────┤
> │ __udivsi3 │ 415   │ 238       │
> ├───────────┼───────┼───────────┤
> │ __umodsi3 │ 203   │ 131       │
> ├───────────┼───────┼───────────┤
> │ __divsi3  │ 77    │ 57        │
> ├───────────┼───────┼───────────┤
> │ __modsi3  │ 41    │ 33        │
> └───────────┴───────┴───────────┘
>
> I can take a stab at providing the generic libgcc implementation in
> lib/* but I only expect the arches using libgcc version to switch.

It seems there 4 are always needed together or not at all.
Do we want 4 Kconfig gates or just one will suffice ?

Thx,
-Vineet
