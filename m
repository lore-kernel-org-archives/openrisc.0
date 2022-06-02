Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179BBC43334
	for <openrisc@archiver.kernel.org>; Thu,  2 Jun 2022 15:39:29 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id DFCB9248EA;
	Thu,  2 Jun 2022 17:39:28 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mail.librecores.org (Postfix) with ESMTPS id 8B68C248DB
 for <openrisc@lists.librecores.org>; Thu,  2 Jun 2022 17:39:26 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id s12so4868815plp.0
 for <openrisc@lists.librecores.org>; Thu, 02 Jun 2022 08:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=MLra2y3RjsABUVe7MidEC48KVDjyFBheFABj2kqJzj8=;
 b=k5lwNeZLwLoOvb++hS1XYKwMF2baoEnxCW23QSQs7hvuecW8h3VD0T/GH17WhwhJ1Z
 9M1eEjDJtWMq0hwpbT3VFzO5wlvFAEQDnxlUTesJ301woDAdQDVdp52/wZDdRHRI9aqc
 xlL5dka7EMMGgqAqqgu/1dAUOZ62BF+PbQASbjXhOBjM6JcTHreKjgg6GCtFjE/HsTr6
 /vpX6m7IlbzN4/FzS4QJjjQnhQHqi2jHvzqROzqoXqlOhN1z9YZwBCq/f2mKRi+ZOIgP
 xCuUWuJdO8rywpU2zhMQ7y7bNKuzjFTDiG7G9zTY58ub6J/I3WvKjGuUbUsdhiBgq7TO
 EGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=MLra2y3RjsABUVe7MidEC48KVDjyFBheFABj2kqJzj8=;
 b=K3w2cALo29PzCADnsovkxLQaDtmAxYPhLZAttZudQ/FE7zIpCfh7qs+UzNAyytwnB+
 96CR/MRqjzGVTXQZuSd3oC2rZPgnpVwYPFJ2koBZOOLGVjS1EmHi5Hl83RNlJVzNzV8P
 AcCrE9dS08rRmWE2gMOqA0ctE5QV41Ft49FytGxb4YhqdYG8vvCZLslMRg+HaJjlmxgG
 OUTQ/8H4DS1WV3JqvKIBXDP4b+NsQILA7lvWiz0DMcvjRNIyeGDxtKwxvnblFfQNfJ6m
 RRNiaYIiG2ByuQHejawSnwOW0gQgoScYxVFPN+x+9CXvW5kHGGFXRqJH269pejtWeh/Z
 sO7Q==
X-Gm-Message-State: AOAM530r7vX+vFrlsuiaoLi3s4zIMGxZtd9P8HSeCwLV4eYlXISw7dv+
 qam+z7YfBZw1qIMVS0/VOemIzw==
X-Google-Smtp-Source: ABdhPJwy2YkV3/aKXqUlF7GdqpTQPI674ntibqTKQTfKHTn4KzSVBad/OBTTPdq4qQYXNHjEcMVNBQ==
X-Received: by 2002:a17:902:b683:b0:163:4ef2:3c40 with SMTP id
 c3-20020a170902b68300b001634ef23c40mr5318537pls.123.1654184364977; 
 Thu, 02 Jun 2022 08:39:24 -0700 (PDT)
Received: from ?IPV6:2607:fb90:80cd:3d17:bb90:8dda:8cb2:7569?
 ([2607:fb90:80cd:3d17:bb90:8dda:8cb2:7569])
 by smtp.gmail.com with ESMTPSA id
 e23-20020aa79817000000b00518a473265csm3717401pfl.217.2022.06.02.08.39.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jun 2022 08:39:24 -0700 (PDT)
Message-ID: <0a1051aa-f2f5-02de-693c-2c8b5e002998@linaro.org>
Date: Thu, 2 Jun 2022 08:39:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 1/3] target/openrisc: Add basic support for semihosting
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
References: <20220527172731.1742837-1-shorne@gmail.com>
 <20220527172731.1742837-2-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20220527172731.1742837-2-shorne@gmail.com>
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

On 5/27/22 10:27, Stafford Horne wrote:
> +void do_or1k_semihosting(CPUOpenRISCState *env, uint32_t k);
...
> +DEF_HELPER_FLAGS_2(nop, 0, void, env, i32)

Just call the helper "semihosting" and be done with it.
And the helper wants an ifdef for system mode.

> @@ -10,6 +10,7 @@ openrisc_ss.add(files(
>     'fpu_helper.c',
>     'gdbstub.c',
>     'interrupt_helper.c',
> +  'openrisc-semi.c',
>     'sys_helper.c',
>     'translate.c',
>   ))

You want to add the new file for system mode only.
Or, now that I think of it, conditional on CONFIG_SEMIHOSTING itself.

> +static void or1k_semi_return_u32(CPUOpenRISCState *env, uint32_t ret)
> +{
> +    cpu_set_gpr(env, 11, ret);
> +}

Let's drop this until you actually use it.  This appears to be attempting to mirror other, 
more complete semihosting, but missing the third "error" argument.


> +void do_or1k_semihosting(CPUOpenRISCState *env, uint32_t k)
> +{
> +    uint32_t result;
> +
> +    switch (k) {
> +    case HOSTED_EXIT:
> +        gdb_exit(cpu_get_gpr(env, 3));
> +        exit(cpu_get_gpr(env, 3));
> +    case HOSTED_RESET:
> +#ifndef CONFIG_USER_ONLY
> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +        return;
> +#endif

Do you in fact want to exit to the main loop after asking for reset?
That's the only way that "no return value" makes sense to me...

> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "or1k-semihosting: unsupported "
> +                      "semihosting syscall %d\n", k);

%u.

>   static bool trans_l_nop(DisasContext *dc, arg_l_nop *a)
>   {
> +    if (semihosting_enabled() &&
> +        a->k != 0) {
> +        gen_helper_nop(cpu_env, tcg_constant_i32(a->k));
> +    }

Perhaps cleaner to move the semihosting dispatch switch here, instead of leaving it to the 
runtime?  The reason we have a runtime switch for other guests is that the semihosting 
syscall number is in a register.  This would then be

     if (semihosting_enabled()) {
         switch (a->k) {
         case 0:
             break; /* normal nop */
         case HOSTED_EXIT:
             gen_helper_semihost_exit(cpu_R(dc, 3));
             break;
         case HOSTED_RESET:
             gen_helper_semihost_reset();
             tcg_gen_movi_tl(cpu_pc, dc->base.pc_next + 4);

             dc->base.is_jmp = DISAS_EXIT;
             break;
         ...
         }
     }


r~
