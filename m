Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF47C433F5
	for <openrisc@archiver.kernel.org>; Tue, 11 Oct 2022 16:40:34 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 78E3D24BD0;
	Tue, 11 Oct 2022 18:40:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mail.librecores.org (Postfix) with ESMTP id 60B4424BD0
 for <openrisc@lists.librecores.org>; Tue, 11 Oct 2022 18:40:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665506430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3pR097ooCx/8nlTemhEf/WDhel/4mmcsp3Jh/tnUV8M=;
 b=A+FV3O0WHCmo+SwD1nwchs7jR+YgzkGCAwje9Xx3LqMKaKhNYS22PO9aAlAwPJn07I5J2/
 kpV/PO/oqIwdn/6o7zffLkdhZI0qNV9qD7Fex2Kug3yazce+8QPRClHb1QT7y44M5ZDAjI
 W5+8s3e6cgGXu8OzkGbgwLWyS5n4UjQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-264-TAs-WHoxNryUTvTAnz9K7Q-1; Tue, 11 Oct 2022 12:40:29 -0400
X-MC-Unique: TAs-WHoxNryUTvTAnz9K7Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 l1-20020a7bc341000000b003bfe1273d6cso3915063wmj.4
 for <openrisc@lists.librecores.org>; Tue, 11 Oct 2022 09:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3pR097ooCx/8nlTemhEf/WDhel/4mmcsp3Jh/tnUV8M=;
 b=OdSJlxVMeqUkaJ4K6okCDlhHEny//uxbV4wfCiYtS4vDvPOyVPVvyiH27T6i+slzGz
 irOm3B0g048gz3isG2/NFSDEnLIeFSbxvmsuu01+jgLL/v60Nfh2uMO/Teyvao8gt+7A
 QxCf/6AcpUlvzGwQXG1fZDtYkgyCj3i1MDTrfOAUee72vKMM33nkM+zp1Y9pcbi5orgz
 IYXJoebOJsOresg+qqDbUxWhxOGS8xOPjCpHWw11J6sp5Fo/b6OlZ6Z9GG8ovZ++JQJ6
 Jo10b2mdnGQFTjie7pyhb1yLHXvaJ0IUYaQQPyODTpqNDiHxh5HzXhNyOqPYVsnB5ScX
 fDkQ==
X-Gm-Message-State: ACrzQf0h/B+WzEusm1H3Hxh+cnhNdjobnVRPS+rV5DcQcsmMbCe7NNJB
 lL3Ij70/tWmIWjM2hvc7G3KG/1EuDvrAm3AqMfM4DCcT3myS4zPxzEJPIirV5XXFpvI2ZTHJW4u
 xYwkECoW5vq4AP3f4X0pCLwWwRA==
X-Received: by 2002:a5d:59a7:0:b0:230:3652:1aa with SMTP id
 p7-20020a5d59a7000000b00230365201aamr8455645wrr.308.1665506428268; 
 Tue, 11 Oct 2022 09:40:28 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4XCj7SFWdE6E5DxEmMGEk+A0mlMYyEPprqhbmdn8jGtDu/Z9OxlEVw6NK6vPTlYZN68wZltQ==
X-Received: by 2002:a5d:59a7:0:b0:230:3652:1aa with SMTP id
 p7-20020a5d59a7000000b00230365201aamr8455591wrr.308.1665506427912; 
 Tue, 11 Oct 2022 09:40:27 -0700 (PDT)
Received: from vschneid.remote.csb ([104.132.153.106])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a7bcd83000000b003a3170a7af9sm7900578wmj.4.2022.10.11.09.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Oct 2022 09:40:27 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [RFC PATCH 0/5] Generic IPI sending tracepoint
In-Reply-To: <3e680bb9-9896-3665-dd59-4f2e6f8205bb@redhat.com>
References: <20221007154145.1877054-1-vschneid@redhat.com>
 <Y0CFnWDpMNGajIRD@fuller.cnet> <xhsmhilkqfi7z.mognet@vschneid.remote.csb>
 <3e680bb9-9896-3665-dd59-4f2e6f8205bb@redhat.com>
Date: Tue, 11 Oct 2022 17:40:26 +0100
Message-ID: <xhsmhfsfufh51.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
 Peter Zijlstra <peterz@infradead.org>,
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
 Douglas RAILLARD <douglas.raillard@arm.com>, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 11/10/22 18:22, Daniel Bristot de Oliveira wrote:
> On 10/11/22 18:17, Valentin Schneider wrote:
>> Thinking out loud, it makes way more sense to record a cpumask in the
>> tracepoint, but perhaps we could have a postprocessing step to transform
>> those into N events each targeting a single CPU?
>
> My approach on the tracers/rtla is to make the simple things in kernel, and beautify
> things in user-space.
>
> You could keep the tracepoint as a mask, and then make it pretty, like cpus=3-5,8
> in user-space. For example with a trace-cmd/perf loadable plugin, libtracefs helper.
>

That's a nice idea, the one downside I see is that means registering an
event handler for all events with cpumasks rather than directly targeting
cpumask fields, but that doesn't look too horrible. I'll dig a bit in that
direction.

> For rtla I was thinking to make a new tool to parse them. and make it pretty there.
>
> -- Daniel

