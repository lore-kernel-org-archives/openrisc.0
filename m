From: Michael Schmitz <schmitzmic@gmail.com>
Date: Wed, 29 Dec 2021 17:15:23 +1300
Subject: [OpenRISC] [RFC 02/32] Kconfig: introduce HAS_IOPORT option and
 select it as necessary
In-Reply-To: <CAK8P3a2j-OFUUp+haHoV4PyL-On4EASZ9+59SDqNqmL8Gv_k7Q@mail.gmail.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-3-schnelle@linux.ibm.com>
 <CAMuHMdXk6VcDryekkMJ3aGFnw4LLWOWMi8M2PwjT81PsOsOBMQ@mail.gmail.com>
 <d406b93a-0f76-d056-3380-65d459d05ea9@gmail.com>
 <CAK8P3a2j-OFUUp+haHoV4PyL-On4EASZ9+59SDqNqmL8Gv_k7Q@mail.gmail.com>
Message-ID: <1f90f145-219e-1cad-6162-9959d43a27ad@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Arnd,

Am 29.12.2021 um 16:41 schrieb Arnd Bergmann:
> On Tue, Dec 28, 2021 at 8:20 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Am 28.12.2021 um 23:08 schrieb Geert Uytterhoeven:
>>> On Mon, Dec 27, 2021 at 5:44 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>>>> We introduce a new HAS_IOPORT Kconfig option to gate support for
>>>> I/O port access. In a future patch HAS_IOPORT=n will disable compilation
>>>> of the I/O accessor functions inb()/outb() and friends on architectures
>>>> which can not meaningfully support legacy I/O spaces. On these platforms
>>>> inb()/outb() etc are currently just stubs in asm-generic/io.h which when
>>>> called will cause a NULL pointer access which some compilers actually
>>>> detect and warn about.
>>>>
>>>> The dependencies on HAS_IOPORT in drivers as well as ifdefs for
>>>> HAS_IOPORT specific sections will be added in subsequent patches on
>>>> a per subsystem basis. Then a final patch will ifdef the I/O access
>>>> functions on HAS_IOPORT thus turning any use not gated by HAS_IOPORT
>>>> into a compile-time warning.
>>>>
>>>> Link: https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g at mail.gmail.com/
>>>> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
>>>> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
>>>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>>
>>> Thanks for your patch!
>>>
>>>> --- a/arch/m68k/Kconfig
>>>> +++ b/arch/m68k/Kconfig
>>>> @@ -16,6 +16,7 @@ config M68K
>>>>         select GENERIC_CPU_DEVICES
>>>>         select GENERIC_IOMAP
>>>>         select GENERIC_IRQ_SHOW
>>>> +       select HAS_IOPORT
>>>>         select HAVE_AOUT if MMU
>>>>         select HAVE_ASM_MODVERSIONS
>>>>         select HAVE_DEBUG_BUGVERBOSE
>>>
>>> This looks way too broad to me: most m68k platform do not have I/O
>>> port access support.
>>>
>>> My gut feeling says:
>>>
>>>     select HAS_IOPORT if PCI || ISA
>>>
>>> but that might miss some intricate details...
>>
>> In particular, this misses the Atari ROM port ISA adapter case -
>>
>>         select HAS_IOPORT if PCI || ISA || ATARI_ROM_ISA
>>
>> might do instead.
>
> Right, makes sense. I had suggested to go the easy way and assume that
> each architecture would select HAS_IOPORT if any configuration supports
> it, but it looks like for m68k there is a clearly defined set of platforms that
> do.
>
> Note that for the platforms that don't set any of the three symbols, the
> fallback makes inb() an alias for readb() with a different argument type,
> so there may be m68k specific drivers that rely on this, but those would
> already be broken if ATARI_ROM_ISA is set.

I'd hope not - we spent some effort to make sure setting ATARI_ROM_ISA 
does not affect other m68k platforms when e.g. building multiplatform 
kernels.

Replacing inb() by readb() without any address translation won't do much 
good for m68k though - addresses in the traditional ISA I/O port range 
would hit the (unmapped) zero page.

Cheers,

	Michael

>
>           Arnd
>
