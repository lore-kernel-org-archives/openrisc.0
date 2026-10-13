Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363494756DA
	for <linux-openrisc@vger.kernel.org>; Tue, 13 Oct 2026 04:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791866484; cv=none; b=MHQlY3BC0Lt3+niI8Vvf41qV+u1qmNWhjKWdBVCzLWyFZWbI6DDnVO92bpTzRsxGGvY4tJNPQlXn0Mr9xDYxng312M4op0zt9ZzXAg/LhhbhbzQW0EH8LqhETzVM8nWd7JEaQSyfsOTSPPjORas2sP7C7vHM9CqPq/d1Z3yWEBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791866484; c=relaxed/simple;
	bh=1FGBCYpqoaQP7nZiD8Xk1Vj+UllHiO8jYhYyecW+KwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aT43/BMe/5S8ZSAH82MQbxZc457BO9wk4ZQlnYTLV4dDcoTFQknu4kyGdeWTPLnqPGVf+2NSJR8IFUvN4f9uMtByBTLot58x/XxQHD6o+JK+lB84imwpUFb7gcM9bEfktVFzuMvzhuex5/mwSu9eaDSjRJKYVFRHu1HJtS9Om0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBYMcNuO; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBYMcNuO"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1419d3416ceso3606449c88.0
        for <linux-openrisc@vger.kernel.org>; Mon, 12 Oct 2026 21:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791866482; x=1792471282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ANl3PjyWBokYmlAx9rJhimSysaOK4KYpgUnncCZm4Lg=;
        b=tBYMcNuOsl6DwXh8T8YdAzzSQ4QzijrLaUpFZha+KvP3jIkn4JXKU4+WNR43gOFzn4
         8ZUHzPbrrHO5PiMt27N5Tvb3SvesP+NJE6AOUBjybjLl9rQkd/jQTP52ZpgU0EU0L1HN
         Bbp0mtyOFjq3EbcDeYL9WzO/r8edVasNdvOYeQSjVoHxIelt8DNt5IumOZtai73SPXEh
         lzIKmZ3VfKJTSypBe0WlGS6OaT1GSpJwyc4j7YvP6gz2c1niQtV4hZ4DjmI97/2Tbiwo
         fhm9HsCLl85fA+t0ZTSm6trhRJkfngypo5P+IVT+cC+vDTVYgkhupyOTAszWDpjV+7e8
         /Lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791866482; x=1792471282;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ANl3PjyWBokYmlAx9rJhimSysaOK4KYpgUnncCZm4Lg=;
        b=hexREHeXKR3y7dmgF03sace4RTFcAawNWbn1K0ZN4kPKQkFw/gc1wlSAOD9qTWxfah
         f4OhjwpFh4MMSAtNIb/+/C4g5JozycsgROuDohyMqDR+lQSvBT5Bo18ulVmHarhy4NW5
         XP8+QbNgsgdg/218gMNkyLs27dCh8Z8vW9EPI+yj4RJxWaBr58LH/K5C/hEL20OD7kuY
         g9qfAAVBiZn0WB5ClTvwHHnNBUMelYhiRoFs994kG9Vy2ReCIV/Il7vDy5KpaVrZZzQv
         aEgBqDi8OrKLnt8k6nPxwgv1o7g4iFxdrHFIINJcHzL9lewV1UKDN1gyR5TAT12xbn0O
         2Nhg==
X-Forwarded-Encrypted: i=1; AKwUvByFQ6XLfx0+PzJt5sF1IbmFzoJqvObqH+rZPlMKAvEBUcYeRiqnQaU0qXDLPcPaUscUtEXbo6lhhcaw18RRrA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL9gjelCw4LuyKBqDqDintBfLWaiV5dXSuFgD7UJTMUtEL13Mv6
	QQzlYTeScM4l/+zDQw1l84HmixQTxj9FXezyIYw0Id7ov8hdoyXxsVbE
X-Gm-Gg: AYBFou2GoHAvYzF4xLWdycLzbgU4hgb+TLgDn+S7Fofa31NVj+DoI7SOyDki6sq5pLH
	WAJwSzaGJz2mCAeGLVwu9H09SSFyaL6tM2P+vUn1bjhg6DElShpN0M7lgdEeCYND6ZACboz+csG
	u6ihIda4JrSii/1GP3chaVYgvMkm22VLjzADx50875+li7+a0d3BxOCd0czb6w48IQfr5KRX6S0
	cQ7L/YM91XkGB6gFXclZXszGCbs3bbaTi0atvMrhCJZmo+/JfH19/S52ZttanIYRdlwiUr4gwHg
	+gm7m0BGWdYHcxbxdq3/bD1LHEDRzm/nncoSlSZ++ULKdQ8QCQb2Dy7HVrgLkckNS/mN+Ve7b3G
	Xnca4qrH8NTFYoqjcJ6j3/bx+SB8aV2+gaQomBdyw2oYTx9tzLJPoaFOIcjM2B0VAbKg6FIAYvl
	qLBD7nqwtkQEajd0GBVtO4X7DAYJRiwE6W2KkdrgL+k9lxtftx+yScFJohfd61SE/kosV/YX7JM
	DzARRIJDhlNrNc4ALYthKoc0+4+Ar2O2Kgr
X-Received: by 2002:a05:701b:230c:b0:14f:5cd:f286 with SMTP id a92af1059eb24-16a6203dc73mr17576796c88.34.1791866482064;
        Mon, 12 Oct 2026 21:41:22 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c43:7890:582d:8daf:d401:c87? ([2401:4900:1c43:7890:582d:8daf:d401:c87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442956asm43133349c88.16.2026.10.12.21.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 21:41:21 -0700 (PDT)
Message-ID: <8ceef81d-bd17-4910-af11-699318691c23@gmail.com>
Date: Tue, 13 Oct 2026 10:11:15 +0530
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] openrisc: Add support for KProbes
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
 naveen@kernel.org, davem@davemloft.net, tytso@mit.edu,
 wangruikang@iscas.ac.cn, namcao@linutronix.de, pjw@kernel.org,
 kees@kernel.org, linux-openrisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20261013042255.7DF701F000FF@smtp.kernel.org>
Content-Language: en-US
From: Sahil <sahilcdq0@gmail.com>
In-Reply-To: <20261013042255.7DF701F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Masami,

On 10/13/26 9:52 AM, Masami Hiramatsu (Google) wrote:
> Hi Sahil,
> 
> Thanks for updating! Could you check Sashiko's comments on the series?
> 
> https://sashiko.dev/#/patchset/20260930203129.51048-1-sahilcdq0%40gmail.com

Thank you for your reply, and apologies for being slow in sending an update.

I have seen Sachiko's review comments. I am still working on getting v3 ready.

> I need OpenRISC maintainer's review for this series too.

Got it, that makes sense.

> Thank you,
> 
> [...]
>

Regards,
Sahil

