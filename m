Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAA3C433FE
	for <openrisc@archiver.kernel.org>; Fri, 18 Nov 2022 16:42:44 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 589F324A1B;
	Fri, 18 Nov 2022 17:42:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mail.librecores.org (Postfix) with ESMTP id 83AEF249AD
 for <openrisc@lists.librecores.org>; Fri, 18 Nov 2022 17:42:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668789760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iCeupirs0oRwfAYdrtKDNR33oxtw0kRHF9WhmcxURbs=;
 b=is4sSZobXPguOsrAJb7JAyhMO5SpS8UcYWAE+R5d34fjCAKvqtZg6QBIcFoLw5h6mr3RCt
 5EPAB+vTGhKztvDccZH+7yoUS2r4oeOVsIgMWRoR4f+xF1kMvXGjusdUOr+rokCcXgyAxz
 YUK1G/bzc2+QiGQxJI9KYRjL7cpX4AI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-bpKIG6fzNhWG8vl1VJ_Mrg-1; Fri, 18 Nov 2022 11:42:38 -0500
X-MC-Unique: bpKIG6fzNhWG8vl1VJ_Mrg-1
Received: by mail-ed1-f69.google.com with SMTP id
 y18-20020a056402359200b004635f8b1bfbso3295460edc.17
 for <openrisc@lists.librecores.org>; Fri, 18 Nov 2022 08:42:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iCeupirs0oRwfAYdrtKDNR33oxtw0kRHF9WhmcxURbs=;
 b=TC6TB5Ulvl7MevxsicSt3AMZWECMBrN3ljHsjLLeiHY5Ds6RUQ+A3Bcwr2rDgyNw7F
 7FVnYinMLTJ/7hOrnRofmeOCI80LUt136txHc4nqV185NYpOudg1EEf3ApaydSpcUKKq
 8hWDa5EsSeG21g3A1xVz5G1idYauzOOp1MrVQqD0LX+Ur00uEqw3dbypqnQgyKLhM03/
 PauiLr4XxmAc8KBTA4YGv+Jxx5DOstepmXl+Zq3PJZvRqfBlr+D93SvmoswiDVs7WcMG
 v/PUkVOr04g5kVpA+E/BBHvMTQwmpEUQMhssjVsoJIZHgQHfOH3JZzoLV1dgAzdAi+eq
 CzZg==
X-Gm-Message-State: ANoB5pnHDVUwDXEHtsYmC9MkLpgNYYZ0uD9Hx8DwBpQ6vVJeVjhMfAB/
 KyJvG2JqL+rp488SkLuny+7WD/npwpBLoyFLvWRY0qWDWof//vVFz2paJkwwOKsViJ38PPrmES9
 nZ7nwRZI7TaisRCEaMeNAPNEuAA==
X-Received: by 2002:aa7:d4cf:0:b0:461:a9ce:5408 with SMTP id
 t15-20020aa7d4cf000000b00461a9ce5408mr6997409edr.201.1668789757505; 
 Fri, 18 Nov 2022 08:42:37 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5TaV9WywAgyEkJUjIKk83rbFXBQR8khfDHnlKNNSiUU8k8aohx0CjQn5lly7hEq5+W3BWrVw==
X-Received: by 2002:aa7:d4cf:0:b0:461:a9ce:5408 with SMTP id
 t15-20020aa7d4cf000000b00461a9ce5408mr6997376edr.201.1668789757207; 
 Fri, 18 Nov 2022 08:42:37 -0800 (PST)
Received: from [192.168.0.46] (host-95-248-159-81.retail.telecomitalia.it.
 [95.248.159.81]) by smtp.gmail.com with ESMTPSA id
 b10-20020a1709063caa00b0073d83f80b05sm1912134ejh.94.2022.11.18.08.42.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Nov 2022 08:42:36 -0800 (PST)
Message-ID: <1ab5082c-bec5-53f2-501b-f15f7e8edbd9@redhat.com>
Date: Fri, 18 Nov 2022 17:42:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC PATCH v2 8/8] sched, smp: Trace smp callback causing an IPI
To: Peter Zijlstra <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>
References: <20221102182949.3119584-1-vschneid@redhat.com>
 <20221102183336.3120536-7-vschneid@redhat.com>
 <Y3ZBUMteJysc1/lA@hirez.programming.kicks-ass.net>
 <xhsmhfsehy706.mognet@vschneid.remote.csb>
 <Y3dMiyFn6TG1s5g3@hirez.programming.kicks-ass.net>
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <Y3dMiyFn6TG1s5g3@hirez.programming.kicks-ass.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: Juri Lelli <juri.lelli@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-hexagon@vger.kernel.org, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org,
 linux-xtensa@linux-xtensa.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, openrisc@lists.librecores.org,
 Borislav Petkov <bp@alien8.de>, Nicholas Piggin <npiggin@gmail.com>,
 loongarch@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 11/18/22 10:12, Peter Zijlstra wrote:
> On Thu, Nov 17, 2022 at 02:45:29PM +0000, Valentin Schneider wrote:
> 
>>> +	if (trace_ipi_send_cpumask_enabled()) {
>>> +		call_single_data_t *csd;
>>> +		smp_call_func_t func;
>>> +
>>> +		csd = container_of(node, call_single_data_t, node.llist);
>>> +
>>> +		func = sched_ttwu_pending;
>>> +		if (CSD_TYPE(csd) != CSD_TYPE_TTWU)
>>> +			func = csd->func;
>>> +
>>> +		if (raw_smp_call_single_queue(cpu, node))
>>> +			trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, func);
>> So I went with the tracepoint being placed *before* the actual IPI gets
>> sent to have a somewhat sane ordering between trace_ipi_send_cpumask() and
>> e.g. trace_call_function_single_entry().
>>
>> Packaging the call_single_queue logic makes the code less horrible, but it
>> does mix up the event ordering...
> Keeps em sharp ;-)
> 

Having the trace before the IPI avoids the (non ideal) case where the trace stops because of
an IPI execution before we have trace about who sent it... :-(.

-- Daniel

