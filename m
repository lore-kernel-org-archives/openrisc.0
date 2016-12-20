From: Andreas Schwab <schwab@linux-m68k.org>
Date: Tue, 20 Dec 2016 23:44:43 +0100
Subject: [OpenRISC] [PATCH] openrisc: Define __kernel_size_t to suppress
	compiler warnings
In-Reply-To: <CAMuHMdUvXsiuHWuyiriyU5Y3ZJqRT2js++nXTwOd=WCdqArCTw@mail.gmail.com>
 (Geert Uytterhoeven's message of "Tue, 20 Dec 2016 21:45:56 +0100")
References: <1482242389-30006-1-git-send-email-shorne@gmail.com>
 <201612210415.zQ2N1x5s%fengguang.wu@intel.com>
 <CAMuHMdUvXsiuHWuyiriyU5Y3ZJqRT2js++nXTwOd=WCdqArCTw@mail.gmail.com>
Message-ID: <871sx28bl0.fsf@linux-m68k.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Dez 20 2016, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> When I saw this patch, I was already a bit skeptical about it, but I noticed
> other architectures (e.g. avr32) are doing the same, so I didn't reply.
>
> In my experience, "format '%zu' expects argument of type 'size_t', but
> argument 3 has type 'unsigned int'" happens when using a compiler that
> was not configured to use the correct type (should be unsigned long) for
> size_t. Typically this happens when using a compiler not configured for
> a Linux target.

32-bit targets typically use unsigned int for size_t.  It is part of the
ABI, so all compilers must agree.  Since or32 is a out-of-tree port, and
gcc defaults to unsigned long for size_t, mismatches can happen if
people are using incomplete patches.

Andreas.

-- 
Andreas Schwab, schwab at linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

