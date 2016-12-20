From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Dec 2016 21:45:56 +0100
Subject: [OpenRISC] [PATCH] openrisc: Define __kernel_size_t to suppress
	compiler warnings
In-Reply-To: <201612210415.zQ2N1x5s%fengguang.wu@intel.com>
References: <1482242389-30006-1-git-send-email-shorne@gmail.com>
 <201612210415.zQ2N1x5s%fengguang.wu@intel.com>
Message-ID: <CAMuHMdUvXsiuHWuyiriyU5Y3ZJqRT2js++nXTwOd=WCdqArCTw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

On Tue, Dec 20, 2016 at 9:22 PM, kbuild test robot <lkp@intel.com> wrote:
> [auto build test WARNING on linus/master]
> [also build test WARNING on v4.9 next-20161220]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Stafford-Horne/openrisc-Define-__kernel_size_t-to-suppress-compiler-warnings/20161221-024243
> config: openrisc-or1ksim_defconfig (attached as .config)
> compiler: or32-linux-gcc (GCC) 4.5.1-or32-1.0rc1
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=openrisc
>
> All warnings (new ones prefixed by >>):
>
>    crypto/drbg.c: In function 'drbg_seed':
>>> crypto/drbg.c:1062:3: warning: format '%zu' expects type 'size_t', but argument 2 has type 'long unsigned int'
>    crypto/drbg.c: In function 'drbg_generate':
>    crypto/drbg.c:1275:3: warning: format '%zu' expects type 'size_t', but argument 2 has type 'long unsigned int'

When I saw this patch, I was already a bit skeptical about it, but I noticed
other architectures (e.g. avr32) are doing the same, so I didn't reply.

In my experience, "format '%zu' expects argument of type 'size_t', but
argument 3 has type 'unsigned int'" happens when using a compiler that
was not configured to use the correct type (should be unsigned long) for
size_t. Typically this happens when using a compiler not configured for
a Linux target.

Given 0day uses a compiler configured for Linux (or32-linux-gcc), your
patch seems to break such (correct) setups.

What kind of compiler are you using?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

