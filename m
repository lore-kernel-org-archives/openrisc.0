From: Michael Schmitz <schmitzmic@gmail.com>
Date: Wed, 29 Dec 2021 14:20:38 +1300
Subject: [OpenRISC] [RFC 02/32] Kconfig: introduce HAS_IOPORT option and
 select it as necessary
In-Reply-To: <CAMuHMdXk6VcDryekkMJ3aGFnw4LLWOWMi8M2PwjT81PsOsOBMQ@mail.gmail.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-3-schnelle@linux.ibm.com>
 <CAMuHMdXk6VcDryekkMJ3aGFnw4LLWOWMi8M2PwjT81PsOsOBMQ@mail.gmail.com>
Message-ID: <d406b93a-0f76-d056-3380-65d459d05ea9@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Geert, Niklas,



Am 28.12.2021 um 23:08 schrieb Geert Uytterhoeven:
> Hi Niklas,
>
> On Mon, Dec 27, 2021 at 5:44 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>> We introduce a new HAS_IOPORT Kconfig option to gate support for
>> I/O port access. In a future patch HAS_IOPORT=n will disable compilation
>> of the I/O accessor functions inb()/outb() and friends on architectures
>> which can not meaningfully support legacy I/O spaces. On these platforms
>> inb()/outb() etc are currently just stubs in asm-generic/io.h which when
>> called will cause a NULL pointer access which some compilers actually
>> detect and warn about.
>>
>> The dependencies on HAS_IOPORT in drivers as well as ifdefs for
>> HAS_IOPORT specific sections will be added in subsequent patches on
>> a per subsystem basis. Then a final patch will ifdef the I/O access
>> functions on HAS_IOPORT thus turning any use not gated by HAS_IOPORT
>> into a compile-time warning.
>>
>> Link: https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g at mail.gmail.com/
>> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
>> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>
> Thanks for your patch!
>
>> --- a/arch/m68k/Kconfig
>> +++ b/arch/m68k/Kconfig
>> @@ -16,6 +16,7 @@ config M68K
>>         select GENERIC_CPU_DEVICES
>>         select GENERIC_IOMAP
>>         select GENERIC_IRQ_SHOW
>> +       select HAS_IOPORT
>>         select HAVE_AOUT if MMU
>>         select HAVE_ASM_MODVERSIONS
>>         select HAVE_DEBUG_BUGVERBOSE
>
> This looks way too broad to me: most m68k platform do not have I/O
> port access support.
>
> My gut feeling says:
>
>     select HAS_IOPORT if PCI || ISA
>
> but that might miss some intricate details...

In particular, this misses the Atari ROM port ISA adapter case -

	select HAS_IOPORT if PCI || ISA || ATARI_ROM_ISA

might do instead.

Cheers,

	Michael


>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
>
