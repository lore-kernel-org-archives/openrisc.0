From: Michael Schmitz <schmitzmic@gmail.com>
Date: Sat, 1 Jan 2022 10:55:27 +1300
Subject: [OpenRISC] [RFC 02/32] Kconfig: introduce HAS_IOPORT option and
 select it as necessary
In-Reply-To: <CAK8P3a2GGGuP0miLRy8w2+8vdSsGRNioBHEZ-ervSBrYbuZ+5w@mail.gmail.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-3-schnelle@linux.ibm.com>
 <CAMuHMdXk6VcDryekkMJ3aGFnw4LLWOWMi8M2PwjT81PsOsOBMQ@mail.gmail.com>
 <d406b93a-0f76-d056-3380-65d459d05ea9@gmail.com>
 <CAK8P3a2j-OFUUp+haHoV4PyL-On4EASZ9+59SDqNqmL8Gv_k7Q@mail.gmail.com>
 <1f90f145-219e-1cad-6162-9959d43a27ad@gmail.com>
 <CAK8P3a3NqU-3nUZ9ve=QyPPB5Uep3eK+_hicjjSiP8VuL4FYfA@mail.gmail.com>
 <0211719b-8402-9865-8e5d-5c0a35715816@gmail.com>
 <CAK8P3a2GGGuP0miLRy8w2+8vdSsGRNioBHEZ-ervSBrYbuZ+5w@mail.gmail.com>
Message-ID: <a635e885-c365-8bdc-bf3c-e74d7d39a786@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Arnd,

Am 01.01.2022 um 05:04 schrieb Arnd Bergmann:
> On Wed, Dec 29, 2021 at 10:44 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Am 30.12.2021 um 14:48 schrieb Arnd Bergmann:
>>> On Tue, Dec 28, 2021 at 11:15 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>>> What some other architectures do is to rely on inb()/outb() to have a
>>> zero-based offset, and use an io_offset in PCI buses to ensure that a
>>> low port number on the bus gets translated into a pointer value for the
>>> virtual mapping in the kernel, which is then represented as an unsigned
>>> int.
>>
>> M54xx does just that for Coldfire:
>>
>> arch/m68k/include/asm/io_no.h:
>> #define PCI_IO_PA       0xf8000000              /* Host physical address */
>>
>> (used to set PCI BAR mappings, so matches your definition above).
>
> I think coldfire gets it right here, using PCI_IOBASE to find the start of
> the window and a zero io_offset:
>
> #define PCI_IOBASE ((void __iomem *) PCI_IO_PA)

Good - I bear that in mind if I ever get around to reactivating my 060 
accelerator and the PCI board for that.

>> All other (MMU) m68k users of inb()/outb() apply an io_offset in the
>> platform specific address translation:
>>
>> arch/m68k/include/asm/io_mm.h:
>>
>> #define q40_isa_io_base  0xff400000
>> #define enec_isa_read_base  0xfffa0000
>> #define enec_isa_write_base 0xfffb0000
>>
>> arch/m68k/include/asm/amigayle.h:
>>
>> #define GAYLE_IO                (0xa20000+zTwoBase)     /* 16bit and
>> even 8bit registers */
>> #define GAYLE_IO_8BITODD        (0xa30000+zTwoBase)     /* odd 8bit
>> registers */
>>
>> (all constants used in address translation inlines that are used by the
>> m68k inb()/outb() macros - you can call that the poor man's version of
>> PCI BAR mappings ...).
>
> This still looks like the same thing to me, where you have inb() take a
> zero-based port number, not a pointer. The effect is the same as the
> coldfire version, it just uses a custom inline function instead of the
> version from asm-generic/io.h.

Right.

>> So as long as support for any of the m68k PCI or ISA bridges is selected
>> in the kernel config, the appropriate IO space mapping is applied. If no
>> support for PCI or ISA bridges is selected, we already fall back to zero
>> offset mapping (but as far as I can tell, it shouldn't be possible to
>> build a kernel without bridge support but drivers that require it).
>
> Right.
>
>>> As this is indistinguishable from architectures that just don't have
>>> a base address for I/O ports (we unfortunately picked 0 as the default
>>> PCI_IOBASE value), my suggestion was to start marking architectures
>>> that may have this problem as using HAS_IOPORT in order to keep
>>> the existing behavior unchanged. If m68k does not suffer from this,
>>> making HAS_IOPORT conditional on those config options that actually
>>> need it would of course be best.
>>
>> Following your description, HAS_IOPORT would be required for neither of
>> PCI, ISA or ATARI_ROM_ISA ??
>
> For these three options, we definitely need HAS_IOPORT, which would
> imply that some version of inb()/outb() is provided. The difference between

Thanks for clarifying that (and to Niklas as well). Did sound a little 
counter-intuitive to me...

> using a custom PCI_IOBASE (or an open-coded equivalent) and using
> a zero PCI_IOBASE in combination with registering PCI using a custom
> io_offset is whether we can use drivers with hardcoded port numbers.
> These should depend on a different Kconfig symbol to be introduced
> (CONFIG_HARDCODED_IOPORT or similar) once we introduce them,
> and you could decide for m68k whether to allow those or not, I would
> assume you do want them in order to use certain legacy ISA drivers.

That's exactly the purpose (though we're overmuch pushing the envelope 
trying to accomodate legacy ISA drivers on too many platforms).

Cheers,

	Michael


>        Arnd
>
