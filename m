From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Dec 2016 08:05:26 +0100
Subject: [OpenRISC] [PATCH] openrisc: Define __kernel_size_t to suppress
	compiler warnings
In-Reply-To: <871sx28bl0.fsf@linux-m68k.org>
References: <1482242389-30006-1-git-send-email-shorne@gmail.com>
 <201612210415.zQ2N1x5s%fengguang.wu@intel.com>
 <CAMuHMdUvXsiuHWuyiriyU5Y3ZJqRT2js++nXTwOd=WCdqArCTw@mail.gmail.com>
 <871sx28bl0.fsf@linux-m68k.org>
Message-ID: <CAMuHMdVn8FKEkaNeiYaepKcaE6eofZN9kJ0u0yo0Y1X3P37Bfg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Dec 20, 2016 at 11:44 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Dez 20 2016, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> When I saw this patch, I was already a bit skeptical about it, but I noticed
>> other architectures (e.g. avr32) are doing the same, so I didn't reply.
>>
>> In my experience, "format '%zu' expects argument of type 'size_t', but
>> argument 3 has type 'unsigned int'" happens when using a compiler that
>> was not configured to use the correct type (should be unsigned long) for
>> size_t. Typically this happens when using a compiler not configured for
>> a Linux target.
>
> 32-bit targets typically use unsigned int for size_t.  It is part of the
> ABI, so all compilers must agree.  Since or32 is a out-of-tree port, and
> gcc defaults to unsigned long for size_t, mismatches can happen if
> people are using incomplete patches.

Right, thanks for correcting me!
It should indeed be unsigned int on 32-bit, and unsigned long on 64-bit.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

