From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 1 Sep 2017 10:03:44 +0200
Subject: [OpenRISC] [PATCH 01/13] openrisc: use shadow registers to save
 regs on exception
In-Reply-To: <CAMuHMdWku57oe4Gpm6nW4jK921d4tEzYby8eyC15-oRtXca9fQ@mail.gmail.com>
References: <cover.1504129273.git.shorne@gmail.com>
 <45e5b91f645a51c3c7a7410f0c67676c5c8193e0.1504129273.git.shorne@gmail.com>
 <CAMuHMdWku57oe4Gpm6nW4jK921d4tEzYby8eyC15-oRtXca9fQ@mail.gmail.com>
Message-ID: <CAMuHMdUWn3qzBp4ezLX0zuReiVStiVxgsFLbz6w4Vp_9qMnxfw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Sep 1, 2017 at 10:02 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Aug 30, 2017 at 11:58 PM, Stafford Horne <shorne@gmail.com> wrote:
>> --- a/arch/openrisc/Kconfig
>> +++ b/arch/openrisc/Kconfig
>> @@ -121,6 +121,16 @@ config OPENRISC_NO_SPR_SR_DSX
>>           Say N here if you know that your OpenRISC processor has
>>           SPR_SR_DSX bit implemented. Say Y if you are unsure.
>>
>> +config OPENRISC_HAVE_SHADOW_GPRS
>> +       bool "Support for shadow gpr files"
>
> default y if SMP?

Oops, that's not sufficient.

bool "Support for shadow gpr files" if !SMP
default y if SMP

>> +       help
>> +         Say Y here if your OpenRISC processor features shadowed
>> +         register files. They will in such case be used as a
>> +         scratch reg storage on exception entry.
>> +
>> +         On SMP systems, this feature is mandatory.
>> +         On a unicore system it's safe to say N here if you are unsure.
>> +

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
