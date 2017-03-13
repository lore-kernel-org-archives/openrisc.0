From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Mar 2017 15:17:15 +0100
Subject: [OpenRISC] Build regressions/improvements in v4.11-rc2
In-Reply-To: <20170313141228.GA2418@lianli.shorne-pla.net>
References: <1489394631-9491-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdUSmQ=9VQX_-U6nfxitwxeBJ950JM-+cO7o+3OqFK=c5g@mail.gmail.com>
 <20170313141228.GA2418@lianli.shorne-pla.net>
Message-ID: <CAMuHMdU7VXnN8i=P-PkYiQpxhFSsFKG3VvDRjKCZ8oH_uivmxw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

On Mon, Mar 13, 2017 at 3:12 PM, Stafford Horne <shorne@gmail.com> wrote:
> On Mon, Mar 13, 2017 at 11:15:23AM +0100, Geert Uytterhoeven wrote:
>> On Mon, Mar 13, 2017 at 9:43 AM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> > JFYI, when comparing v4.11-rc2[1] to v4.11-rc1[3], the summaries are:
>> >   - build errors: +6/-13
>>
>>   + /home/kisskb/slave/src/arch/openrisc/include/asm/atomic.h: Error:
>> /home/kisskb/slave/src/arch/openrisc/include/asm/atomic.h:69: unknown
>> opcode2 `l.swa'.Error: :  => 71
>>   + /home/kisskb/slave/src/arch/openrisc/include/asm/atomic.h: Error:
>> unknown opcode2 `l.lwa'.: 70, 69, 107 => 70, 79, 107, 69, 78
>>   + /home/kisskb/slave/src/arch/openrisc/include/asm/atomic.h: Error:
>> unknown opcode2 `l.swa'.: 72, 111, 71 => 71, 111, 72, 80, 81
>>   + /home/kisskb/slave/src/arch/openrisc/include/asm/futex.h: Error:
>> unknown opcode2 `l.lwa'.:  => 54, 60, 63, 51, 108, 57
>>   + /home/kisskb/slave/src/arch/openrisc/include/asm/futex.h: Error:
>> unknown opcode2 `l.swa'.:  => 62, 112, 53, 59, 65, 56
>>
>> OpenRISC needs an updated toolchain.
>
> Thansk for the report.  I have updated the toolchain that is pointed to
> by make.cross [1] a few weeks back.  Fengguang and I updated the
> make.cross tool which the build robot's point to a late tool chain [2],
> what are you using?

I'm using the linux-next build service.
http://kisskb.ellerman.id.au/kisskb/head/4495c08e84729385774601b5146d51d9e5849f81/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
