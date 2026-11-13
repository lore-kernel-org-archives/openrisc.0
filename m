Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590551;
	b=F1dCpUWkILnEaI+Oo2K+TUBjrZ8nMH/CHiw+I+GAmlQDER6NdX6NDhM6acPKRZFGNxtq
	 FxQXM663sm1IpHnVPsPiUkx+5TFpKuPbJDcHYtH7sTTsTlywzKzfJrX5lUyFKGwpyR0ku
	 JLmDrpmcM0qXX2ZTRjgxsif89q+3y2N3DlI4jvDM0Imp3DU1ZHI/r/EwDuviamTp/PlDV
	 z+58N/rACO/QRYd/eCydwzs/QN0Kqq01qcN6OOr4fIRZyYSxX8jLD1rYgn4vFe3GZVngF
	 Yvv+igjsI8fMhNKwEtDlEgfSw6lsE/JCCuV531WyAM6w3H7MNatvXsFi7sRJ5d0M8+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=OXfE/1W5iYUB1NrGTtPkTsDeQzVdgtifzj98ImHtgPo=;
	b=vMXoLR3DmbCjqwPkf9QCHZfF8P7Vdt0VkSSQd0OoIWZ47/tHxlsLB/i1VogqbWWkdBwP
	 lFnafega2ObQ+OIJYPm0c8RrcbBFjyFtOVj/30slAiWjbsEvfpUsXTLUlRNHEwVwwW+oT
	 DSLqkF+0lWrY5gfmXcQuQ/06b2YL1i6UBF+wNo63ezMXfeB0qrKDRgP2f86XiCDGdc+5s
	 NcsoY8zXrEeea0wntc8D5iCOuHMMbymbiIYTVLXDAwozMmhjbu8mj2CndyBquY346vb2F
	 vQfqMLptWQ8glFomKI8guOGiFdOymrbzSeoXhZMAVD1GTwjx8OqbKec5SLbfelkR6YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fjxkZf+O;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663856074B30
	for <linux-openrisc@vger.kernel.org>; Fri, 13 Nov 2026 17:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 663856074B30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fjxkZf+O
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-37986eb6fa2so2930701eec.0
        for <linux-openrisc@vger.kernel.org>; Fri, 13 Nov 2026 09:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794590550; x=1795195350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OXfE/1W5iYUB1NrGTtPkTsDeQzVdgtifzj98ImHtgPo=;
        b=fjxkZf+OCvJgyRQFlINphS3GvpNklkEUcMMifyEbajyUYfgGR2pCfZgoTsPAe0hjAN
         opijHSp8A/8EAoZumHy2iy34a2kc9kVqiTkavKjQjeurqIehnM9CkOfx81Z8oR0yX5ul
         J9tpsR6m3FHT4a9p/xAt+ZRJcodC3CjeXxhpf9FCU48HlCxCPWQjC75knoVVqu2lFIcN
         nHSzSqeeHutQy5biOw2l6oclNIlpNzW/Xl9YJQzjU9ivLVJYXXUktQN+NseViVRMAX5J
         NZhkkF6lfJOMroSC3tEqiJyfGmbFOukuvKX4idxUk3fiKCZTP5Kb2PQA+EOwg831zczn
         WIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590550; x=1795195350;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OXfE/1W5iYUB1NrGTtPkTsDeQzVdgtifzj98ImHtgPo=;
        b=qD+sBgmPJ7IYbz1goqWD5nSuFVKP4pphS/fHjEqcHpKCNpzS9QTN9v936FG6neVAtI
         5XhHRyijVZW4PyxabF2qCrBv319ChShupZBM192zWagO2mUThLtF4eso1fipB+muQJ1+
         2Bhs9jRtYHCkc1fRdMCQMC4oj07VULw614DA9Zl0k8R4fZ72cLC0QoFU/6EqhhV8G54x
         uLMkFkU38doHYes6XCyq5du/f5qgzDAG6JoqVoNG90C5Ayw819pQ/k2F6Bw2MvmZ8Igh
         oQiE8lTvcZG07gdyEZlIhk9bWt2+zZ+lFAB4+U+HfTHF50IUqK5LnzCq3jQLXiE7wySU
         MsJw==
X-Forwarded-Encrypted: i=1; AL+hErG0t27noV3hG5NBk2mzWJWB2iJRRCN3/+3xv4srHVGOxOc1PkNoHwF37dmcTKi69m3Xf/o8BXSKvxzQoJ3GLA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9gKNeVi48Z36Xy6rIiXiJU4vkw6VY4S8b+wgEjAmvruT5DMzAT
	aZKVsuKdDThJMoTJD2aBNps4QRxMxmD6KQWsW1B8L0KTZYLoUerhXQM/nIBz9Q==
X-Gm-Gg: AYBFou3OZzXPB7Ok0Rid5jfIJbSqxfqfZFJY9wY5rFklpiuyD3C2IK82BxFnNYvQ3B1
	hnGBUJL5EKbMHe/I3g+PTPtSbCPJR4HJ5PbG4skxoa4ui16GYqcO2DjZr0PjZSAjuCEDAtPtSq7
	L7alhWacvlrfk563d1NmcV01OjrBKR7aqReM+i1v7rWbVFF0WD5bCIKKI3NYCMhhpVIre5Prj7A
	sc5pAa5WbVf321D9OWu9eIWjmk6XcxIbS5EDcV9zwa6IlbcmW2X0xZOq2A0o7at/w2AW0yXQuik
	LuKiSg6Semp+knTAtW+BEBtQDnM7cxu7GmoGgpIKM+QqlFcP4RtAxLFHVU1gfulAh6gwpCt05g3
	JyApseykoBb27UlqKbb+irgI1ZLLlDcPevNia0jVhGOiwm3Vh/2uRATYasOTO8hpMASChKnPtIS
	TTqCl7wUn0eDkUMxdP1vg6VSvS3f7upXk8hTTqc0KOeS+BGOYpWMt5BZzQ+rh5pl8CaPfKsoNEh
	zl/L2ox1KsofW9AoiQ9XLXUXeYFVoFuCQtssEIBHyNhxxjOFBLbcVGifkib2XkgRSFQ+7aJ
X-Received: by 2002:a05:693c:8105:b0:36a:54a0:6b4c with SMTP id 5a478bee46e88-3796721e0femr2979743eec.25.1794590550340;
        Fri, 13 Nov 2026 09:22:30 -0800 (PST)
Received: from [192.168.0.216] ([182.48.212.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379560f5e06sm11744319eec.19.2026.11.13.09.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 09:22:30 -0800 (PST)
Message-ID: <2f9cd058-c2a2-4a7f-a755-a66653a8f659@gmail.com>
Date: Fri, 13 Nov 2026 22:52:25 +0530
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
Subject: Re: [PATCH v3 0/4] openrisc: Add support for KProbes and Kretprobes
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
 naveen@kernel.org, davem@davemloft.net, pjw@kernel.org,
 wangruikang@iscas.ac.cn, namcao@linutronix.de, kees@kernel.org,
 linux-openrisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-1-sahilcdq0@gmail.com>
 <undine-1794560694824423564-2986102e2a604795@undined.local>
Content-Language: en-US
From: Sahil <sahilcdq0@gmail.com>
In-Reply-To: <undine-1794560694824423564-2986102e2a604795@undined.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Masami,

On 11/13/26 2:34 PM, Masami Hiramatsu (Google) wrote:
> Hi Sahil,
> 
> Can you update the series according to the Sashiko's comment[1]?
> 
> [1] https://sashiko.dev/#/patchset/20261026201240.107462-3-sahilcdq0%40gmail.com

Sure, I'll make those changes along with the ones suggested by Stafford.

> Also, can you check your git email settings, so that the next
> version does *NOT* reply to the previous version.
> 
> This mail has
> 
>    Message-ID: <20261026201240.107462-1-sahilcdq0@gmail.com>
>    X-Mailer: git-send-email 2.55.0
>    In-Reply-To: <20260930202744.50489-1-sahilcdq0@gmail.com>
>    References: <20260930202744.50489-1-sahilcdq0@gmail.com>
> 
> But I can not find "20260930202744.50489-1-sahilcdq0@gmail.com" in
> the LKML archive.
> 
> Also "[PATCH v3 2/4] openrisc: Add KProbes" has
> 
>    Message-ID: <20261026201240.107462-3-sahilcdq0@gmail.com>
>    X-Mailer: git-send-email 2.55.0
>    In-Reply-To: <20260930202744.50489-1-sahilcdq0@gmail.com>
>    References: <20260930202744.50489-1-sahilcdq0@gmail.com>
> 
> This should be in reply to the cover mail
> "20261026201240.107462-1-sahilcdq0@gmail.com"

Oh, that's weird. Maybe I used the wrong message-id when setting "in-reply-to"
using git-send-email. I'll send the next series such that it doesn't reply to
the previous version.

> 
> Thank you,
Thanks,
Sahil
