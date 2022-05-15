Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5135C433F5
	for <openrisc@archiver.kernel.org>; Sun, 15 May 2022 23:12:56 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id 9A0F6248FC;
	Mon, 16 May 2022 01:12:55 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mail.librecores.org (Postfix) with ESMTPS id EF9B5248FC
 for <openrisc@lists.librecores.org>; Mon, 16 May 2022 01:12:53 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id l11so12528774pgt.13
 for <openrisc@lists.librecores.org>; Sun, 15 May 2022 16:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=jX9X/K6NYOh0QtVaCIIs4beankwvdFAqtDOPSegI8eo=;
 b=MEVixSjoSsOmboD8IrkZlxXBUFb0XuJfBElzopgQA1s5/ZQbwFZl4G75xesbsm5dTz
 nWpq6ZGdR8ks3JnMm4LiEvriKaHZXYttdN1rymudTGLvRvm4FqhDBlxbyBcyih7+ye6y
 7UZgLffWkWALbySk0M3WI622PTKb2YTD5Sz/n2C6fwB9YZFrggICrRnvLixmoZ+cZIj8
 hl76BPa41j5GOP5CIPOBxNyPQ07PogxKXzuWsyWkIGZH9dWUuvXrldg06/xPM9Q42wZS
 DdFp7sRZei7rIdBHXk/v0k/GGN7oduiJzyjsd5ZuKsMeSyvaJ3+2oWG9EAt0guVngGSH
 3EoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=jX9X/K6NYOh0QtVaCIIs4beankwvdFAqtDOPSegI8eo=;
 b=7nc+ztEDXu98iPDIKhY9YkztIfpmELLyBlruV9NtQW86VjlFs1JJiOCc+BiW/M941v
 pkxQmOfUeoNykSFurbkVwx7P6lVCJm+GigEP2iS3e/Tl/tWTTaZ45i8zlxjWUAJuVGT8
 Cx723adjI+oD/3Cm236E26W+i1xeXLoo/hebvgPD+PB/fVuTgfHwgvrfcBFXorS032ZF
 LuMwt6M7fLebxR//WA/HcT/kTv+zga/GlgkjE5ODUze4veM3XM3NiW6DFD91cFCXXPU4
 3nJwdUxTkndE9e546z10w6cqXFudjQEOA5ntnnQTNiOCrtN7U9kQ4Q0FHGziuNUtXir6
 a9Wg==
X-Gm-Message-State: AOAM532O96An6mDs1HliF9sjWWlyCgU25KdEHXGG0aQK9Los3gVX86Fq
 jYOnx4YYQNT0mpyu6HBHrO7Peg==
X-Google-Smtp-Source: ABdhPJwvZs0tiOWtF92m4Tn2Pd39456DqEHCWRCCUCKhTmOD24tuOCTyJ9CIm9DCgctKy+k7Sl/n+w==
X-Received: by 2002:a62:e819:0:b0:510:693e:b20c with SMTP id
 c25-20020a62e819000000b00510693eb20cmr14895818pfi.60.1652656372345; 
 Sun, 15 May 2022 16:12:52 -0700 (PDT)
Received: from [192.168.1.6] ([71.212.142.129])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a170902d58900b0015e8d4eb2b8sm5566472plh.258.2022.05.15.16.12.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 May 2022 16:12:51 -0700 (PDT)
Message-ID: <41d45d1e-8f2e-9201-fca4-f2f9c68af5b1@linaro.org>
Date: Sun, 15 May 2022 16:12:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PULL 0/4] OpenRISC fixes for QEMU 2022-05-15
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
References: <20220515013948.2993495-1-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20220515013948.2993495-1-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Openrisc <openrisc@lists.librecores.org>
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On 5/14/22 18:39, Stafford Horne wrote:
> The following changes since commit 2e3408b3cc7de4e87a9adafc8c19bfce3abec947:
> 
>    Merge tag 'misc-pull-request' of gitlab.com:marcandre.lureau/qemu into staging (2022-05-03 09:13:17 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/stffrdhrn/qemu.git tags/or1k-pull-request-20220515
> 
> for you to fetch changes up to e8f0ab0cd674241cbab7231ce05ac1bfa0b4f5ed:
> 
>    target/openrisc: Do not reset delay slot flag on early tb exit (2022-05-15 10:33:01 +0900)
> 
> ----------------------------------------------------------------
> OpenRISC Fixes for 7.0
> 
>   - A few or1ksim fixes and enhancements
>   - A fix for OpenRISC tcg backend around delay slot handling

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/7.1 as appropriate.

The gpg key I have for you is expired.  Have you refreshed the expiration date and pushed 
the new copy somewhere?


r~


> 
> ----------------------------------------------------------------
> Jason A. Donenfeld (3):
>        hw/openrisc: page-align FDT address
>        hw/openrisc: support 4 serial ports in or1ksim
>        hw/openrisc: use right OMPIC size variable
> 
> Stafford Horne (1):
>        target/openrisc: Do not reset delay slot flag on early tb exit
> 
>   hw/openrisc/openrisc_sim.c | 28 +++++++++++++++++++---------
>   target/openrisc/cpu.c      | 11 +++++++++++
>   2 files changed, 30 insertions(+), 9 deletions(-)
> 
> Jason A. Donenfeld (3):
>    hw/openrisc: page-align FDT address
>    hw/openrisc: support 4 serial ports in or1ksim
>    hw/openrisc: use right OMPIC size variable
> 
> Stafford Horne (1):
>    target/openrisc: Do not reset delay slot flag on early tb exit
> 
>   hw/openrisc/openrisc_sim.c | 28 +++++++++++++++++++---------
>   target/openrisc/cpu.c      | 11 +++++++++++
>   2 files changed, 30 insertions(+), 9 deletions(-)
> 

