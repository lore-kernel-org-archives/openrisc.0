Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590211;
	b=J/uf+cuNFjqroPcBcLWdL8BxUQu/BOoo+ahle2RFXivDiPM7nLRzBzjwoU+8PhiQD5Bt
	 o/wBS8c6de8QIpeXKBpfYyCQFqP3ejLqP4dlyEzlv6G2LJedhU3FI8RMiRrMO6fT6v5za
	 hodh8QQXLMYhAjTl2RlQNPrpyx9EV7r0m65B/bsSmZ4J1Pc6/9ylNMuvP65UhwzZ9fUp1
	 9VIF/dJCpYtLYJDl/pwQ4b8Nicz/bWmKfg1idXd/Ec1LZKOWDJbPDZ6b4DSydXtTZGbZu
	 vlmQtIltIl17/haR/v5QUKdxgkKP104Emj4WKwgiwqthQmXk+py5ayDm71pd6iDojmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=1NnwoeqjhMRZA613FNn5ml0JxbTNE6hC+WRkyiGE1vE=;
	b=ddixfJPxM7/Uk9mpYfI9zSp3+udG6SCnagYc0D9lgNiBAPnUbFE+naxvkxgiKjtxrrCu
	 M/3wSjbNAQyN2MWXHJnl+0xhav7QdQ7CGTjl93r8hSz/1h23f6mb6D0OaYO1PQdDo8sPd
	 h3F5q5DJnfwIUmu1fH5D2KlDoz2tfbvuS9Mfx8s/+CoIXTRsr8e6Vz4SM07O/pAbBrIyv
	 0jcaUXgpxPe4A4aXl+D0SNgmyw3F2qawBk4x42YCjEYoiemFKYtw6cvWCC2Su0DGLQKrF
	 GP3qV0c6vmnfUZZ9zvhmNLsRSGhlSI8KlPcM4vG45m14xCO4o5xYdcHzZHtCkh08dXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=smAQ9sJ9;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6FA606A890
	for <linux-openrisc@vger.kernel.org>; Fri, 13 Nov 2026 17:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE6FA606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=smAQ9sJ9
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-170135e43c7so1196223c88.0
        for <linux-openrisc@vger.kernel.org>; Fri, 13 Nov 2026 09:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794590210; x=1795195010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1NnwoeqjhMRZA613FNn5ml0JxbTNE6hC+WRkyiGE1vE=;
        b=smAQ9sJ9ED1e8iN8XRJLVO5ZrCNIyjWAp7cVA/514X2FbnIKXxGzVIvvjYL9swD0c7
         IM8Hx4zvQiFcGWf5cjri06K4RgyFXDDspxmF+rbSEQ+zmUxHnlgd0a6hEked587iN+A2
         Sk3ztiLzIJ3JGPzUHSMgK0VNTsolGVU/3ANRTfp8Q22+yzizwMG6oEtPqaZPmFEzEkWA
         2rV65rmhuS0veszEllCWZYQUEshFDyL884+hvCtufoj9GeEoXPfM8e/SUp7g0dqtPHDG
         1kwdn5/mrsd5wJ+dXAZzoFVdIybtHrSxPpwyZfYr+lHnogfPbYRsHnQD7rgcCECJiyMi
         qniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590210; x=1795195010;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1NnwoeqjhMRZA613FNn5ml0JxbTNE6hC+WRkyiGE1vE=;
        b=B/w3mIJF9s5RxdTs8eUGaO/1TlQUsZTEztYJ0B+cNUxP98sh6Hsz+snSR1pLlIs0DG
         FeR6e+OrpL6TAqO7sDIiAkBkkIjTbFYdKW2pEBzK7xa0RH4ABYva4/ymDxx2PeVb0kZa
         zNm+lJT4T7SyL2WAQL5yJezyHrWnJNLmRm19lVnr0nwcr8ltKNM6FiO1sN5dQo6ZMjym
         9WlQppA1z3gQPkSG9PHrpWvFLe30osa0clBSRunAzhuR1Fi6o0S1zMycX9Mm4zHuejwA
         bEwnsJcwY+QcfNAKvdykjFObtH+BcQsA+YHLsOxEmCFvckx9lWKyrfcAp0kS6uHM7moc
         boOg==
X-Forwarded-Encrypted: i=1; AL+hErFc9K+WnAnoyl6uYYQg2YDU+eomWBAQzAJJXqGtm+763iTUuS/1WCp6zB2SPCfUJ6x/K83cXzaZ49hlcDJ2Bg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/RmT8WCMOjdNrH1qq8w8cM6S2SchWR9IkC9GdvfMYPYVzigeyX
	G6QRGrFk3qgPXNG1Lj/TOTmapciHWWx5hz3rm60uERf/+vs5+DMXlQZR
X-Gm-Gg: AYBFou29+GnV3Vyy7pCzwXl8FytZ13pCpBJJQELxjF2V5tuihYw5RTZmd8mYlya37gB
	nuP2YcMLN4fvalzpfBNCg8p1yu607AtYcG8iqTtmIsjYFlzya5muFTgUXxbkUSanKKDCmeDetsE
	kT3dcxak7ULAf/QuAqct6mx4fVF/ZkVKh9LOy/dkvKKlgaejFHjRm0uPOedzZ8+8AdBNgjqLpX6
	ctYetNA4y6+cUw8FSkC3v58FROiI6r/ez5kHsTJDht2sYGGMlKtUXM7AJHVqK6//Pc6mLMiMATJ
	fLuMkLuEdKQD79GuRpwU6rBRuVYNvk2BBgMMVga0yGSq62KO14dvfVgyXAIJU3VYeYGLdveZe09
	LMUKeG3JFiodOdujBewZcLLsImHdEXXETjgpClcVKNMpwA73lzcst2XdN8HIxtgECZWO+SZoET2
	WpgfYj/fXMLU8vwocOUSSRilO2c0WUjufoQnwdkPiyLSgqWXdktUo6cokKJdZt1i94LMu4+g+5C
	HDTxP4DUtBuMYUNWCP+VaQxP9oTdbDiFFl8YvRh3dd7kuVVvBlWa9Hz84tURggu2d41wdwL
X-Received: by 2002:a05:701b:2202:b0:1b5:e9d:c641 with SMTP id a92af1059eb24-1b50e9dcabfmr765113c88.18.1794590209794;
        Fri, 13 Nov 2026 09:16:49 -0800 (PST)
Received: from [192.168.0.216] ([182.48.212.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm10299969c88.5.2026.11.13.09.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 09:16:49 -0800 (PST)
Message-ID: <3a931844-7b7f-4408-8d92-d0604ca7d51d@gmail.com>
Date: Fri, 13 Nov 2026 22:46:45 +0530
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
Subject: Re: [PATCH v3 4/4] openrisc: Add Kretprobes
To: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, naveen@kernel.org,
 davem@davemloft.net, mhiramat@kernel.org, pjw@kernel.org,
 wangruikang@iscas.ac.cn, namcao@linutronix.de, kees@kernel.org,
 linux-openrisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-5-sahilcdq0@gmail.com> <avArkiSOmUfSrmYF@antec>
Content-Language: en-US
In-Reply-To: <avArkiSOmUfSrmYF@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/26 1:28 PM, Stafford Horne wrote:
> On Tue, Oct 27, 2026 at 01:42:40AM +0530, Sahil Siddiq wrote:
>> Add Kretprobes support for OpenRISC. Kretprobes allow a probe to be
>> fired when a function returns. They are built on top of the generic
>> rethook framework and also require the KProbe mechanism introduced
>> in the previous commit. This work is primarily based on similar work
>> done for RISC-V.
>>
>> Kretprobes work by inserting a KProbe at a function's entry point.
>> When the function begins to execute, the KProbe is fired and its
>> pre-handler replaces the function's return address with that of the
>> rethook trampoline. The trampoline in turn calls the kretprobe handler.
>> Control is returned to the original caller following this.
>>
>> Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
>> ---
>> Changes v2 -> v3:
>> - arch/openrisc/kernel/rethook_trampoline.S:
>>    (save_all_base_regs): Save SR and SP registers
>>    (restore_all_base_regs): Restore SR register
>>
>> Changes v1 -> v2: New commit
>>
>> [...]
>> +#include <linux/kprobes.h>
>> +#include <linux/rethook.h>
>> +#include "rethook.h"
>> +
>> +unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs)
>> +{
>> +	return rethook_trampoline_handler(regs, regs->gpr2);
>> +}
>> +NOKPROBE_SYMBOL(arch_rethook_trampoline_callback)
>> +
>> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
>> +{
>> +	/* Store original return address and frame pointer */
>> +	rhn->ret_addr = regs->gpr9;
>> +	rhn->frame = regs->gpr2;
>> +
>> +	/* Set return address to trampoline */
>> +	regs->gpr9 = (unsigned long)arch_rethook_trampoline;
> 
> Though this will work, in the kernel code we prefer to regs->gpr[n] syntax
> for accessing gprs.  So to be consistent could you use that?  i.e. regs->gpr[9];

Sure, I'll change this.

>> +}
>> +NOKPROBE_SYMBOL(arch_rethook_prepare)
>> diff --git a/arch/openrisc/kernel/rethook.h b/arch/openrisc/kernel/rethook.h
>> new file mode 100644
>> index 000000000000..332306a5c380
>> --- /dev/null
>> +++ b/arch/openrisc/kernel/rethook.h
>> @@ -0,0 +1,8 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +#ifndef __OPENRISC_RETHOOK_H
>> +#define __OPENRISC_RETHOOK_H
>> +
>> +unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
>> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount);
>> +
>> +#endif
>> diff --git a/arch/openrisc/kernel/rethook_trampoline.S b/arch/openrisc/kernel/rethook_trampoline.S
>> new file mode 100644
>> index 000000000000..5e8fd5a65222
>> --- /dev/null
>> +++ b/arch/openrisc/kernel/rethook_trampoline.S
>> [...]
>> +SYM_CODE_START(arch_rethook_trampoline)
>> +	/* Allocate enough space on stack for pt_regs */
>> +	l.addi	r1,r1,-PT_SIZE
>> +	save_all_base_regs
>> +
>> +	l.addi	r3,r1,0	/* pt_regs */
>> +	l.jal	arch_rethook_trampoline_callback
>> +	l.nop
> 
> Could you indent the delay slot? For example:
> 
> 	l.jal	...
> 	 l.nop
> 
>> +
>> +	/* use the result as the return-address */
>> +	l.addi	r9,r11,0
>> +
>> +	restore_all_base_regs
>> +	l.addi	r1,r1,PT_SIZE
>> +
>> +	l.jr	r9
>> +	l.nop
> 
> Indent here too.

Sure, I'll format these as well.

>> +SYM_CODE_END(arch_rethook_trampoline)
> 
> Thanks,
> 
> -Stafford

Thanks,
Sahil
