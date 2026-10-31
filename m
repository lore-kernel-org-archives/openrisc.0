Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793491033;
	b=VeJ21FM1VxpK3gWO9t1iHvgn/JlcMl0gziHm8/7b8ENKfze2Jm7ZNfDKWbpsaql8MdES
	 e4orFcbLMCw6F+Rj80hEoNPhKr3OuGsa9/Rs4UMByY2Rh6YLA8ax5XyMNpAaKBCHLJVV+
	 vCndc4nkgt7mlJaZBN3CYEeNsGDp5930/JSKi2MdVaHUDyydBozrXIeEVVARLdQTWmL/v
	 7OkMzbpK8r8O8xJSPoUQXfLd/52eyxDn4VrBfS6guqM4M31VLOoe2I4nYICL3TTy+hlh3
	 Wy1ZCkigBPHZVlpdEBgJkm1gPaiKF+UKRgRDMkM/z8CbKcE6FhErVMlwLMCYLvQcJJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793491033;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=MXDZ/tc0FGE+vZKOkRRrWrPdu4KytGFQa3AK0t7MysI=;
	b=S+SH/DKkXbdBCjUPBqnqJ2rHY2HpFYi4BLYmaQrUSII0VC0jW61iF8frt1q3Ap9WTsWM
	 VNNG6qpvCq9VS7eecskYJzq9mipCjHCPrfFQQXEHmZETPUSAKBnRch1CvaOVuuuXUkS4u
	 GUBQr5rNQbLMXA0Amuzn5LuMjurmA9nWQz029zCkqiUs63BFnJ1P7zd7pURs1OhsnhkY4
	 y6cSnG5jEJOdjmWOk1F4fHjomgTEcGtiFGo5+o4RY266LH23rcre+njSlz6FXP1z3P+Rq
	 w2K9zh0Ew8HHGOE5p6fUrA6ae1qP+/03wWhh9dN88+Ekb43l0uU3/CFHaGiRAspENug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCSgVFKA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8684C606A31A;
	Sat, 31 Oct 2026 23:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCSgVFKA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AFC1F000C1;
	Sat, 31 Oct 2026 23:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793491033;
	bh=MXDZ/tc0FGE+vZKOkRRrWrPdu4KytGFQa3AK0t7MysI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WCSgVFKAoEiUlBRt6zXiht7Cz+aUqr+u8pkCYORaKRffLYfUiW1nNB4dPLmsuMbPD
	 1wdBNztG55Vs2jTuRiMMlABj2JgeGWWeUi0URgCasCymnaXvWEwPNj/nLzkqyeSt1d
	 RUAW1AnfbOdNgZQpaXgh28kEwNxgNzJHuaUgJxLN7iPUIur8rixrRLsbtB+p3SXx96
	 9Is1q95z9l8bZP/e7z3sUfujx+51XR++hsrV/64+6uWqLPhJX7VgDvH8Mh7LpNUw/Z
	 mivUDwm3D1icMiSrin0rQa0ZUkEGQ913wYogPYduADhqTvHTif9rOr3XwbKzqwJ4o1
	 e3xd+HdwD0Zpg==
Message-ID: <3175caa0-9f49-465d-959e-6b6c9bbb4f01@kernel.org>
Date: Sat, 31 Oct 2026 16:57:11 -0700
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
From: Vineet Gupta <vgupta@kernel.org>
Content-Language: en-US
In-Reply-To: <47eb6b48-d664-440f-84b6-ba09f34d5e08@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/19/26 04:16, Arnd Bergmann wrote:
> On Mon, Oct 19, 2026, at 11:49, Thomas Weißschuh wrote:
>> GCC may emit libcalls to __mulsi3(). As modpost is not aware that this
>> function is provided through the linked in libgcc, it fails:
>>
>> ERROR: modpost: kernel/locking/test-ww_mutex.ko: symbol '__mulsi3' undefined!
>> ERROR: modpost: kernel/time/test_udelay.ko: symbol '__mulsi3' undefined!
>> ERROR: modpost: kernel/resource_kunit.ko: symbol '__mulsi3' undefined!
>> ERROR: modpost: fs/fuse/virtiofs.ko: symbol '__mulsi3' undefined!
>> etc.
>>
>> Make sure modpost can see the symbol from libgcc.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes:
>> https://lore.kernel.org/oe-kbuild-all/202610171933.J4bFOfL8-lkp@intel.com/
>> Fixes: 2fc8483fdcde ("nios2: Build infrastructure")
>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> The patch looks correct to me, but it would also be nice to not use
> libgcc at all. What I see is that only arc, nios2, openrisc and
> parisc still link against the toolchain-provided libgcc, everything
> else uses the kernel's own runtime.
>
> It's probably not even that hard to do right, here is what I found
> is imported from libgcc.

And seems like ARC is the biggest offender, what a shame.

> * Generic library helper exists, can be enabled through Kconfig:
>
> === __lshrdi3 ===
> arch/arc/kernel/arcksyms.c
> arch/nios2/kernel/nios2_ksyms.c
> arch/openrisc/kernel/or32_ksyms.c
> arch/parisc/kernel/parisc_ksyms.c
> -> lib/lshrdi3.c
> === __ashldi3 ===
> arch/arc/kernel/arcksyms.c
> arch/nios2/kernel/nios2_ksyms.c
> arch/openrisc/kernel/or32_ksyms.c
> arch/parisc/kernel/parisc_ksyms.c
> -> lib/ashldi3.c
> === __ashrdi3 ===
> arch/arc/kernel/arcksyms.c
> arch/nios2/kernel/nios2_ksyms.c
> arch/openrisc/kernel/or32_ksyms.c
> arch/parisc/kernel/parisc_ksyms.c
> -> lib/ashrdi3.c
> === __cmpdi2 ===
> arch/arc/kernel/arcksyms.c
> -> lib/cmpdi2.c
> === __muldi3 ===
> arch/arc/kernel/arcksyms.c
> arch/nios2/kernel/nios2_ksyms.c
> arch/openrisc/kernel/or32_ksyms.c
> arch/parisc/kernel/parisc_ksyms.c
> -> lib/muldi3.c
> === __ucmpdi2 ===
> arch/arc/kernel/arcksyms.c
> arch/nios2/kernel/nios2_ksyms.c
> arch/openrisc/kernel/or32_ksyms.c
> arch/parisc/kernel/parisc_ksyms.c
> -> lib/ucmpdi2.c

It seems Palmer added those back in 2018 which ARC was still developed 
actively, I totally missed them.
I now have a patch to switch ARC to generic helpers for those.

> * 64-bit division probably should not be provided on arc or
>    nios2 (and sparc32, which has a private copy).
>    parisc64 should get these from libgcc/libgcc2.c.
>
> === __divdi3 ===
> arch/parisc/kernel/parisc_ksyms.c
> === __udivmoddi4 ===
> arch/nios2/kernel/nios2_ksyms.c
> === __udivdi3 ===
> arch/arc/kernel/arcksyms.c

It seems in some of the old binaries I have, dw mmc driver was at some 
point calling 64/64 divide which eventually got fixed.
But agree as of today there are no callers of 64-bit div/mod. I will get 
rid of ?div*di* from ARC.


> arch/parisc/kernel/parisc_ksyms.c
> === __umoddi3 ===
> arch/nios2/kernel/nios2_ksyms.c
> arch/parisc/kernel/parisc_ksyms.c
> === __moddi3 ===
> arch/nios2/kernel/nios2_ksyms.c
> arch/parisc/kernel/parisc_ksyms.c
>
> * floating-point math should not be provided by kernel:
>
> === __divdf3 ===
> arch/arc/kernel/arcksyms.c
> === __divsf3 ===
> arch/arc/kernel/arcksyms.c
> === __fixunsdfsi ===
> arch/arc/kernel/arcksyms.c
> === __floatunsidf ===
> arch/arc/kernel/arcksyms.c
> === __floatunsisf ===
> arch/arc/kernel/arcksyms.c
> === __muldf3 ===
> arch/arc/kernel/arcksyms.c

And a second patch gets rid of those. FWIW back in the day some ARCAngel 
board's HDD driver needed those. Crazy times.

> * no generic implementation in kernel, need to copy from
>    libgcc/lib1funcs.S code:
>
> === __divsi3 ===
> arch/arc/kernel/arcksyms.c
> arch/nios2/kernel/nios2_ksyms.c
> arch/openrisc/kernel/or32_ksyms.c
> -> arch/arm/lib/lib1funcs.S
>     arch/m68k/lib/divsi3.S
>     arch/microblaze/lib/divsi3.S
>     arch/xtensa/lib/divsi3.S
> === __modsi3 ===
> arch/arc/kernel/arcksyms.c
> arch/nios2/kernel/nios2_ksyms.c
> arch/openrisc/kernel/or32_ksyms.c
> -> arch/m68k/lib/modsi3.S
>     arch/microblaze/lib/modsi3.S
>     arch/xtensa/lib/modsi3.S
> === __udivsi3 ===
> arch/arc/kernel/arcksyms.c
> arch/nios2/kernel/nios2_ksyms.c
> arch/openrisc/kernel/or32_ksyms.c
> -> arch/arm/lib/lib1funcs.S
>     arch/m68k/lib/udivsi3.S
>     arch/microblaze/lib/udivsi3.S
>     arch/sh/lib/udivsi3.S
>     arch/xtensa/lib/udivsi3.S
> === __umodsi3 ===
> arch/arc/kernel/arcksyms.c
> arch/nios2/kernel/nios2_ksyms.c
> arch/openrisc/kernel/or32_ksyms.c
> -> arch/arm/lib/lib1funcs.S
>     arch/m68k/lib/umodsi3.S
>     arch/microblaze/lib/umodsi3.S
>     arch/xtensa/lib/umodsi3.S

ARCv2 has hardware divide so these are not needed, but ARC700 doesn't 
and there's a ton of calls for those.

┌───────────┬───────┬───────────┐
│  routine  │ calls │ functions │
├───────────┼───────┼───────────┤
│ __udivsi3 │ 415   │ 238       │
├───────────┼───────┼───────────┤
│ __umodsi3 │ 203   │ 131       │
├───────────┼───────┼───────────┤
│ __divsi3  │ 77    │ 57        │
├───────────┼───────┼───────────┤
│ __modsi3  │ 41    │ 33        │
└───────────┴───────┴───────────┘

I can take a stab at providing the generic libgcc implementation in 
lib/* but I only expect the arches using libgcc version to switch.

Thx,
-Vineet
