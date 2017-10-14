From: Stafford Horne <shorne@gmail.com>
Date: Sat, 14 Oct 2017 10:39:20 +0900
Subject: [OpenRISC] [linux-litex] Linux early_printk on Arty!
In-Reply-To: <CAKaYPCPge8WaDVfXk2YjzWLxdtmaG2JrMJDUXda2gELKsVDzBg@mail.gmail.com>
References: <CAHLUNMyJFPVbuupijW4eNg3N-zLjMMY-LA1Vqfc3vBRxkPseGg@mail.gmail.com>
 <CAKaYPCO3d6-=NUV701Ly=FUkZ3BW+-QMzrfFZWHMuLChyj0Qnw@mail.gmail.com>
 <CAKaYPCOoh2Xerq6hp2wJ1TwWxjYVTA7vR7o8ZqJsZVc7XHjOtQ@mail.gmail.com>
 <CAHLUNMyB+Z=3sM4oV8AAVUiCJLMnB965Aj5SgHR+GMQ89grBxQ@mail.gmail.com>
 <CAKaYPCPge8WaDVfXk2YjzWLxdtmaG2JrMJDUXda2gELKsVDzBg@mail.gmail.com>
Message-ID: <CAAfxs76oGvfDOxidjMJQCvx6_Ag14K1w6JuOOiJR4ZhQwkVsMQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

+CC Openrisc

This is good news.  I am working on getting this up on qemu now.  Then
I will move onto the boards (I have an Arty).

I agree it would be good to use the or1k standards for IRQs, and reset
locations.  But just to give some background (to best of my
understanding) the litex runs a very similar SoC and software stack
with different cpu cores including lm32 and riscv.  Which explains a
bit about why they are using non openrisc standards.

With that said, I will be seeing what I can do to keep it OpenRISC standard.

-Stafford

On Fri, Oct 13, 2017 at 6:41 PM, Olof Kindgren <olof.kindgren@gmail.com> wrote:
>
>
> Den 13 okt. 2017 11:40 skrev "Tim Ansell" <mithro@mithis.com>:
>
> Where is the openrisc mailing list?
>
>
> https://lists.librecores.org/listinfo/openrisc
>
> //Olof
>
>
> Thanks!
>
> Tim 'mithro' Ansell
>
> On 13 October 2017 at 20:36, Olof Kindgren <olof.kindgren@gmail.com> wrote:
>>
>>
>>
>> Den 13 okt. 2017 11:35 skrev "Olof Kindgren" <olof.kindgren@gmail.com>:
>>
>>
>>
>> Den 13 okt. 2017 11:12 skrev "Tim Ansell" <mithro@mithis.com>:
>>
>> Hi everyone,
>>
>> Thanks to Florent fixing an issue with Ethernet on Arty, we have now
>> successfully gotten Linux early_printk output on the Arty when tftp booting!
>>
>> You can see the output here -> http://pastebin.ubuntu.com/25730949/
>>
>> To get this working you need;
>>  - mithro/HDMI2USB-litex-firmware at merge-arty-soc
>>  - Go into third_party/litex and checkout or1k-linux branch (this enables
>> the MMU and or1k timer peripheral).
>>  - mithro/linux-litex at litex-minimal
>>
>> I'm hoping to get the merge-arty-soc branch into
>> timvideos/HDMI2USB-litex-firmware very soon. I have a pending change to
>> LiteX which would make
>>
>> The behaviour of the kernel on the Arty seems to match the behavior on the
>> Opsis board, so we need help from the Linux experts to figure out what is
>> going on.
>>
>> I don't quite understand why we don't get a full stack trace / dump on the
>> kernel panic?
>>
>> shenki thought this behaviour had something to do with IRQs? I'm guessing
>> that we haven't gotten that quite right yet.
>>
>> Couple of things I noticed that were unusual;
>>  * Linux doesn't seem to like IRQs starting at zero.
>>  * The DeviceTree currently in litex-minimal lists the IRQ for the UART as
>> "2" but LiteX we currently define the UART to be at "0".
>>
>> I don't quite yet understand if there is some type of special mapping for
>> the IRQs in the Linux kernel, nor how LiteX maps the IRQs into the or1k PIC
>> register.
>>
>> The SoC does the IRQ mapping here.
>> The IRQs are a 32bit Signal passed into the mor1kx and we use
>> "OPTION_PIC_TRIGGER="LEVEL".
>> I assume this ends up in the mor1kx code here.
>> The register definitions for the SPRs for the PIC can be found here and
>> here.
>> The OpenRISC Linux IRQ code seems to be here.
>>
>> Can other people try and see if they can reproduce?
>>
>> Thanks!
>>
>> Tim 'mithro' Ansell
>>
>> --
>> You received this message because you are subscribed to the Google Groups
>> "Linux for LiteX FPGA SoC" group.
>> To unsubscribe from this group and stop receiving emails from it, send an
>> email to linux-litex+unsubscribe at googlegroups.com.
>> To post to this group, send email to linux-litex at googlegroups.com.
>> To view this discussion on the web, visit
>> https://groups.google.com/d/msgid/linux-litex/CAHLUNMyJFPVbuupijW4eNg3N-zLjMMY-LA1Vqfc3vBRxkPseGg%40mail.gmail.com.
>> For more options, visit https://groups.google.com/d/optout.
>>
>>
>> Could you try mapping the UART to IRQ2? That is the de-facto standard on
>> all OpenRISC SoCs and would help to make sw more compatible across SoCs.
>> Also, I wonder if irq 0 and 1 works for mor1kx. At least on or1200 the two
>> lowest IRQ were non-maskable and I believe internal to the CPU
>>
>> //Olof
>>
>>
>>
>> You should also consider moving this discussion to the main OpenRISC
>> mailing list to reach a larger audience
>>
>> //Olof
>>
>> --
>> You received this message because you are subscribed to the Google Groups
>> "Linux for LiteX FPGA SoC" group.
>> To unsubscribe from this group and stop receiving emails from it, send an
>> email to linux-litex+unsubscribe at googlegroups.com.
>> To post to this group, send email to linux-litex at googlegroups.com.
>> To view this discussion on the web, visit
>> https://groups.google.com/d/msgid/linux-litex/CAKaYPCOoh2Xerq6hp2wJ1TwWxjYVTA7vR7o8ZqJsZVc7XHjOtQ%40mail.gmail.com.
>>
>> For more options, visit https://groups.google.com/d/optout.
>
>
> --
> You received this message because you are subscribed to the Google Groups
> "Linux for LiteX FPGA SoC" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to linux-litex+unsubscribe at googlegroups.com.
> To post to this group, send email to linux-litex at googlegroups.com.
> To view this discussion on the web, visit
> https://groups.google.com/d/msgid/linux-litex/CAHLUNMyB%2BZ%3D3sM4oV8AAVUiCJLMnB965Aj5SgHR%2BGMQ89grBxQ%40mail.gmail.com.
>
> For more options, visit https://groups.google.com/d/optout.
>
>
> --
> You received this message because you are subscribed to the Google Groups
> "Linux for LiteX FPGA SoC" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to linux-litex+unsubscribe at googlegroups.com.
> To post to this group, send email to linux-litex at googlegroups.com.
> To view this discussion on the web, visit
> https://groups.google.com/d/msgid/linux-litex/CAKaYPCPge8WaDVfXk2YjzWLxdtmaG2JrMJDUXda2gELKsVDzBg%40mail.gmail.com.
>
> For more options, visit https://groups.google.com/d/optout.
