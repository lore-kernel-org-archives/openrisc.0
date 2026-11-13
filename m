Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590109;
	b=d4RyDpk0vsgNu8PMSurZyY8y/0yxmm62ItAVFOFlBfB73qXUF6aJLpHNx7wcaBno4yT/
	 QN20v8KoMlL75qmGWpKwgpjaJTa+Lretv0+6jgzH+9M8XugJseYBj/ff8EJUZroyTSHhd
	 OQNwuWPFXBPoRys+LX+4VkmCaRMFF/iDfEYRvXD0fQOHhjuNfXm6c8UuZBLQRdrDkGAp0
	 WqM+vVAKAzVFFd1fJFsMPKw7q0B+lYbIF/Xg8T4QI4Wbh+AIj8EYd5F5mlYcvkZ49qbYb
	 dkeT6yABtTNYKWRXb2PrrW7rUCQH6hHO2Oq6iuSoqSKUeyo0rZtoeW3CGNtBTAlcyIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590109;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=TJaikHgxJ0Cfj902txSyNLryimhDtp9xIHKHj6RuZzg=;
	b=5oHt4zsOe8e1gg5YJ0K+/t8XQ+gDso6VAZXZHUvi6lTiW6FKBh5RcsQRanMkWvF3dKxS
	 P5v+4CDjS7tXQMeNz+57wslvmAJgyukxk0BE+IHIugEfmMwGs96s2VZSNnEWnGS7jpi8D
	 sTKTELyWj5q790Wtj2/HXYUQcwKyPwOuxQduMXRa3Rztb3dI6VUnhbunYH9cWizod0bvP
	 9uqxpuzf9IDWU3iXJzxrG2STFIJNrZkU7onRfdm9kJx18fwY09D8xrT0lPeiY7udTptLo
	 oaR+tw9aeenhSXOaIeMVN7SxRnMZziuyuQ+v7lk5rtAKqIWMvIP1AZzEugEmnsSDQpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XlJa3P+V;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F20F60A5BCC
	for <linux-openrisc@vger.kernel.org>; Fri, 13 Nov 2026 17:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F20F60A5BCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XlJa3P+V
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a8cc11ac42so1050771c88.0
        for <linux-openrisc@vger.kernel.org>; Fri, 13 Nov 2026 09:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794590109; x=1795194909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TJaikHgxJ0Cfj902txSyNLryimhDtp9xIHKHj6RuZzg=;
        b=XlJa3P+V1CGQ/cuiUm4lc7wiEge72cZrg28BycoQJVcJvnvxPuHOXs0s89ppNSq7cq
         KbGid7lOM8ooFynmwNbHbCk9/Y1beu/P89WtAjjGT/WRRpa3DtZKvM6Sbj8jQKK1lEXd
         kh1xG2bZYvyX1QcVjONz4lpxvMU3ue+JnfLJgiQ2Q2plcsqisiv3lUx57xaanJMnWRq7
         Lwp9FMbZfpv2I0hgBXDGZQD8oNGHOjUqkOz5U/0NkM+iy1M+K7517/r9J9EjuX5PezEr
         vG0MnadiHZI0wo+AxWtJ8GOxwBcr2FSBTz2rB+9kIIN/JoUtpjLClHYn7rchIR2h1Rko
         zT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590109; x=1795194909;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TJaikHgxJ0Cfj902txSyNLryimhDtp9xIHKHj6RuZzg=;
        b=iK0xz47iLAaiQCSlf6rITyIg6y/qQje1myGfvQCGuTLKGf5vSx14kjBw1JfKjK+LSo
         QS3Fp88uskO4mlZiwbodoH6RUDB9u1N1QCJ7ASM+BhCyzSC2k/fGMr2tVxbU5Brf/Gd+
         BEkSLcIiTMqBK6CwzIV5oNf7F+yfDzBf++qBCB60dqiWmj6/EvbGiy2Fs0nzdpuveZEs
         i5cUdeNGm6MJ05WgaYG19+K4eOH30usCpHy5EF5+RbtTPPfRkPXcPPxVNI4FAnoqit4H
         HuwzXvd74PClT8LhSdu8viHNx49/9jsDINfn0vDvoSRlAqEVd/0vYGtDrYCOdEvC94yL
         TRVQ==
X-Forwarded-Encrypted: i=1; AL+hErFMsC7Zk6I5i27Hj+RpmjGvT7aVc5X83FEMBS3q+dJ6kG3bhxL+M/ZBokae79x2eiN/C06wAeLsAF98JF0nYg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+7Nx2aOSIMulEA3gGYnNUpy4QDhAG7QCheIG+9xpCg99d9Vxrh
	NHzKYOOqNQvMWRJC1YxobCdKLmTuws0+vo2bGO4AgntNrofEMKkmEiwJ
X-Gm-Gg: AYBFou2PU9PGFKDiQzEjfEjaxukyGfItrC+IKmOthvHsWsldNvTvpmuw8nzLaJR7R65
	8x3cqGNzozE5Fs4C2oPODO+B6HIVjmsbRfeVkEME3mGaTzkSnwfa/2X1ZgG586Oi4SMZ5T2gacW
	FEygKWq3py2ypXtF/kLLFm/qvAJZnex5CM3hagB3hFIDjvX8Th0wlZb76Td8x+ryDQ7131SYWeX
	tfXw2JmtWDB9sozD4nH12kKWmUk1DW6ZOBeiiS4y7THegHGEwe8p+YIRgO6AqJaoNraJ64Tbjca
	VaoatgAAFLyyY2VqkHeCQK0tS3Z8Sr2MghaVpi0CrjhWKNCSugJa42SEDI5qVSmxrGrujPuHEs5
	2QVR2veApj25he1I2SnNK22vZFB0ZWe4Szbjp3qJ2D2gPkua/molReKx1qYJ7K9b+2blueeg8F5
	XKtk+h8qoUX1qf1Xy0nLv/Q3889D7xIrip70Q2a6txkixkgdutz6UCrsfdFkuT9xgFGYA1rn3po
	YQ/zYsK70zRmpSI/CX5A41cBeljtRMa/EQcay1a3bwNdXT9AmDGPdLEXqfv0/s/1pEGiKk=
X-Received: by 2002:a05:7022:b886:b0:1b3:b67e:9fcf with SMTP id a92af1059eb24-1b5030f29damr2891641c88.17.1794590108316;
        Fri, 13 Nov 2026 09:15:08 -0800 (PST)
Received: from [192.168.0.216] ([182.48.212.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319e381sm8468380c88.12.2026.11.13.09.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 09:15:08 -0800 (PST)
Message-ID: <dbfe2a41-c99d-4f00-ac0d-2b2b31a72986@gmail.com>
Date: Fri, 13 Nov 2026 22:45:03 +0530
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
From: Sahil <sahilcdq0@gmail.com>
Subject: Re: [PATCH v3 3/4] openrisc: Add unit tests for KProbes on branch
 instructions
To: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, naveen@kernel.org,
 davem@davemloft.net, mhiramat@kernel.org, pjw@kernel.org,
 wangruikang@iscas.ac.cn, namcao@linutronix.de, kees@kernel.org,
 linux-openrisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-4-sahilcdq0@gmail.com> <avAsy43KVO-7Nm9z@antec>
Content-Language: en-US
In-Reply-To: <avAsy43KVO-7Nm9z@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/26 1:33 PM, Stafford Horne wrote:
> On Tue, Oct 27, 2026 at 01:42:39AM +0530, Sahil Siddiq wrote:
>> Tests already exist lib/tests to verify the generic functionality of
>> KProbes. Add unit tests to verify that KProbes work on instructions
>> that require simulation in the OpenRISC ISA, and that the corresponding
>> delay slots are handled correctly.
>>
>> Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
>> ---
>> Changes v2 -> v3:
>> - arch/openrisc/kernel/tests/test_kprobes_asm.S:
>>    - (test_kprobes_*): Set value in r11 register to 0 prior to running tests
>>    - (test_kprobes_adrp):
>>      Place function at page-aligned address
>>      Use PAGE_SIZE macro instead of magic number
>>      Move value in r13 to r11 before exiting
>>
>> Changes v1 -> v2: New commit
>>
>>   arch/openrisc/Kconfig.debug                   |  30 +++-
>>   arch/openrisc/kernel/Makefile                 |   1 +
>>   arch/openrisc/kernel/tests/Makefile           |   3 +
>>   arch/openrisc/kernel/tests/test_kprobes.c     |  59 +++++++
>>   arch/openrisc/kernel/tests/test_kprobes.h     |  24 +++
>>   arch/openrisc/kernel/tests/test_kprobes_asm.S | 157 ++++++++++++++++++
>>   6 files changed, 273 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/openrisc/kernel/tests/Makefile
>>   create mode 100644 arch/openrisc/kernel/tests/test_kprobes.c
>>   create mode 100644 arch/openrisc/kernel/tests/test_kprobes.h
>>   create mode 100644 arch/openrisc/kernel/tests/test_kprobes_asm.S
>>
>> [...]
>> diff --git a/arch/openrisc/kernel/tests/test_kprobes_asm.S b/arch/openrisc/kernel/tests/test_kprobes_asm.S
>> new file mode 100644
>> index 000000000000..bc87a5fb00d5
>> --- /dev/null
>> +++ b/arch/openrisc/kernel/tests/test_kprobes_asm.S
>> @@ -0,0 +1,157 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * KProbes unit tests for OpenRISC
>> + *
>> + * Unit tests borrowed liberally from similar work of RISC-V. All
>> + * original copyrights apply as per the original source declaration.
>> + */
>> +
>> +#include <linux/linkage.h>
>> +#include <asm/asm.h>
>> +#include <asm/page.h>
>> +
>> +#include "test_kprobes.h"
>> +
>> +SYM_FUNC_START(test_kprobes_j)
>> +test_kprobes_j_addr1:
>> +	l.addi	r11,r0,0
>> +	l.j	2f
>> +	l.nop
> 
> Just a tiny comment here about indenting the delay slots.

Got it, I'll indent this.

> You could also use the delayslots here, for example:
> 
> 	l.j	2f
> 	 l.addi	r11,r0,0

I initially thought of that too. But then I thought by keeping l.addi
before l.j, I would also be able to test this for the case when
there are no delay slots. I can reshuffle the instructions if that
test isn't required. Please let me know what your thoughts are.

>> +1:	l.ori	r13,r13,KPROBE_TEST_MAGIC_LOWER
>> +	l.addi	r11,r13,0
>> +	l.jr	r9
>> +	l.nop
>> +2:	l.movhi	r13,KPROBE_TEST_MAGIC_UPPER
>> +test_kprobes_j_addr2:
>> +	l.j	1b
>> +	l.nop
>> +SYM_FUNC_END(test_kprobes_j)
>> [...]
>> -- 
>> 2.55.0
>>

Regards,
Sahil
