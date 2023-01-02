Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FF0C3DA7C
	for <openrisc@archiver.kernel.org>; Mon,  2 Jan 2023 08:31:06 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id A16F3249D2;
	Mon,  2 Jan 2023 09:31:05 +0100 (CET)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47])
 by mail.librecores.org (Postfix) with ESMTPS id 0829B24ACE
 for <openrisc@lists.librecores.org>; Mon,  2 Jan 2023 09:31:04 +0100 (CET)
Received: by mail-qv1-f47.google.com with SMTP id d13so19294385qvj.8
 for <openrisc@lists.librecores.org>; Mon, 02 Jan 2023 00:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jo2CI5pKv7C2jtNLeQsFhlozXL/lFYNzin08UvE0x2c=;
 b=caHvRiHqKAyj9sh5ZKKJ/HsNTs6iZeOpVElg2nsloMnZcpqh15ECgCLmIE9o3ex5iv
 yXpKM1rKbRlTTZfOWXgOOE7a5w0nTOXJJ2oSY3BgDd/WKmqKa22roV+MZGYngWgYWQ3D
 hnekxI4YtMbyhMBbd0kGIOJgEwTeCq4l2C4MqUCs0rF9JcTeiVzmrdl0thtur3ZmAXgR
 AYwQ2XTYLyqkpCSu9pzcOtQ6uFH6W3CWyJJm6cg4ENrfZffO2gXZJ0LCCoa42MLy8GTx
 dAXtNVHo/VQgtd9F1fawBSbkvOYCAcZr3gx9M4H2oCckJ5PxAa2nLHTCDecYmJTpE42M
 INuw==
X-Gm-Message-State: AFqh2kqQsoxZvfqJHcms2P+4nb2h27CaPzfK2RU+csEEJlxCqwaIROxF
 HhGG810IF6zmik6QX8BYdbQtfSkx/B1kkg==
X-Google-Smtp-Source: AMrXdXu8fI1Xz12Uz7zC4lo6mzxy5JP6CXraQQpTZlTMKNHMFOVvoLbTUOEPyfEC4vwq8AGeWfcyDQ==
X-Received: by 2002:a05:6214:16a:b0:4c6:9cf5:5f3d with SMTP id
 y10-20020a056214016a00b004c69cf55f3dmr57208158qvs.46.1672648262512; 
 Mon, 02 Jan 2023 00:31:02 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com.
 [209.85.219.178]) by smtp.gmail.com with ESMTPSA id
 v7-20020a05620a0f0700b006faf76e7c9asm20267655qkl.115.2023.01.02.00.31.00
 for <openrisc@lists.librecores.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jan 2023 00:31:01 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 83so28730417yba.11
 for <openrisc@lists.librecores.org>; Mon, 02 Jan 2023 00:31:00 -0800 (PST)
X-Received: by 2002:a25:d243:0:b0:702:90b4:2e24 with SMTP id
 j64-20020a25d243000000b0070290b42e24mr2730771ybg.365.1672648260480; Mon, 02
 Jan 2023 00:31:00 -0800 (PST)
MIME-Version: 1.0
References: <78b23407-bdd0-4b1b-bf6e-ecd4c00294ab@app.fastmail.com>
 <20221229113338.2436892-1-andrzej.hajda@intel.com>
In-Reply-To: <20221229113338.2436892-1-andrzej.hajda@intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Jan 2023 09:30:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVaq9Xg3HrqLo1x5SCuwtJBsczLjWAWmH=23ZtNf_e9hQ@mail.gmail.com>
Message-ID: <CAMuHMdVaq9Xg3HrqLo1x5SCuwtJBsczLjWAWmH=23ZtNf_e9hQ@mail.gmail.com>
Subject: Re: [PATCH v2] arch: rename all internal names __xchg to __arch_xchg
To: Andrzej Hajda <andrzej.hajda@intel.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, Boqun Feng <boqun.feng@gmail.com>,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 intel-gfx@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, loongarch@lists.linux.dev,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Thu, Dec 29, 2022 at 12:34 PM Andrzej Hajda <andrzej.hajda@intel.com> wrote:
> __xchg will be used for non-atomic xchg macro.
>
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> [m68k]

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
