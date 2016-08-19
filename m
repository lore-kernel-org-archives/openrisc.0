From: Marcus Swift <marcus_swift@crevinn.com>
Date: Fri, 19 Aug 2016 16:18:51 +0100
Subject: [OpenRISC] Join mailing list
In-Reply-To: <7fffc348-1bc3-fe49-6c39-a9e01cf5bef7@wallentowitz.de>
References: <CA+2xKH8XHUixfbwwf1B3a25ULncFUhFK5P6UyCax90c_1ny5PQ@mail.gmail.com>
 <3bf7bdd9-85e0-aa1f-f7d3-eb01a83477ad@wallentowitz.de>
 <CA+2xKH9mGWYLV45862sKwKKC564qx_2RyhrvmSpWjtGx8tODow@mail.gmail.com>
 <7fffc348-1bc3-fe49-6c39-a9e01cf5bef7@wallentowitz.de>
Message-ID: <CA+2xKH9=YJJnr9tP5h8=H25g7xNyj-Oxy5Zze-=_C_xmjcXfLw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stefan

Appreciate you response, very helpful.

I have actually been looking at the Nexys 4 recently and if some work is
being carried out on it already that seems like a good place to jump in!

My idea is to have the OpenRISC SOC running on an FPGA controlling a module
(maybe a compression or encryption core). The main thing I am interested in
is understanding the process and obstacles of implementing this SOC and not
so much the application of the core. There are two parts to the project
then:

1) Getting the SOC up and running on the FPGA with Linux.
2) Adding a Module which maybe shows off the OpenRISC core. Any cool ideas
for a core are welcome!

Over the next little while I plan to tackle part 1. It is still not clear
to me on how this is done and im sure I will be using this mailing list for
help. I currently possess the ordb2a development board which was created by
the community and have been working and experimenting with that.

Looking forward to the addition to the Nexys to the tutorials!

Thanks,
Marcus

On Fri, Aug 19, 2016 at 12:36 PM, Stefan Wallentowitz <
stefan@wallentowitz.de> wrote:

> Hi Markus,
>
> I replied back to the list as your questions are a perfect fit for it.
>
> On 19.08.2016 11:37, Marcus Swift wrote:
> > Thanks Stefan!
> >
> > I am currently an Intern in a design and verification company in
> > Ireland. I have been tasked with researching the OpenRISC project and
> > getting an OpenRISC SOC running on an FPGA (booting Linux and having
> > network/SD capabilities). I understand the project is still active,
> > however I have some questions which I have not been able to answer
> > through the last few weeks of research.
>
> Welcome to the community. This sounds like a legitimate goal. Any
> special purpose that SoC should serve?
>
> > 1) Where is the best place to ask questions and read other peoples
> > questions? Is there an active forum?
>
> This mailing list is probably the preferred way of communication for
> questions and discussions. For quick questions or just to hangout there
> is the IRC channel #openrisc on freenode.
>
> > 2) Is there a supported FPGA for testing (other than the DE0-Nano)?
>
> I am heavily working on a Nexys4 DDR and Arty port. There have been
> other attempts too, all this stuff hopefully consolidates over the next
> weeks.
>
> The Nexys4 DDR is probably a good FPGA for your project, too.
>
> >     - If not what are the steps required to support a board?
> >       -- Download the RTL through FuseSOC
>
> You need to download the core descriptions, yes. FuseSoC fetches most of
> the RTL then based on the dependencies.
>
> >       -- Configure the RTL code for compatability to the FPGA (Memory
> > Controllers, Ethernet Controller, Serial COM)
>
> Yes, it would be copying one board toplevel and then adopt it. I
> currently work on a slightly different approach than the existing: I
> separated the SoCs, the IP and the boards. A "system" is then a
> SoC-board combination. You can see that outlined here:
> https://github.com/wallento/fusesoc_cores
>
> In my project (optimsoc.org) we currently work heavily towards a Nexys4
> demonstrator:
> https://github.com/optimsoc/sources/tree/master/examples/
> compute_tile_nexys4ddr
>
> The OpenRISC-only system is a side product of that then soon.
>
> >       -- Synthase with the FPGA vendors tool and download bit-stream to
> FPGA
>
> Yes.
>
> >       -- Make Linux Binary for OpenRISC (this does not have to be
> > customized between boards?)
>
> If you follow the same base addresses as the existing SoCs I think you
> can run it out of box.
>
> >       -- Somehow upload this to memory on FPGA
>
> Yes, usually that is either an SD card or downloading it via the
> debugger. The dominant way of debugging if JTAG, we work with our own
> (opensocdebug.org).
>
> >       -- Somehow point Program Counter to Linux Binary and it will boot?
>
> Yes, usually you reset or control it via gdb.
>
> > I hope I am not taking advantage of you adding me to the mailing list!
>
> No, that is exactly the purpose of this mailing list :)
>
> > If this is the wrong place to ask this perhaps if you could point me in
> > the right direction of a forum?
>
> We are moving away from opencores.org and this is probably the best way
> to communicate as it is also archived.
>
> > I am going into my final year in Computer Engineering and am looking to
> > do a Final Year Project related to the OpenRISC project. Would be more
> > than happy to document this process as im sure it would help other
> > enthusiastic newbies.
>
> That sounds great. Maybe you can elaborate a bit on your plans (goal and
> roadmap) and we can discuss it a bit further. It would be great if you
> can contribute your work to the tutorials
> (https://github.com/openrisc/tutorials). I will add the Nexys there the
> next weeks.
>
> Looking forward to more discussions.
>
> Cheers,
> Stefan
>
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160819/04bf0b02/attachment.html>
