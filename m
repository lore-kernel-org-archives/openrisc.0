From: Javier <javieralso@gmail.com>
Date: Mon, 6 Jun 2016 20:59:35 +0100
Subject: [OpenRISC] l.bf instruction issue
In-Reply-To: <CAKaYPCNPtoaN1Qe6uQJdSy_Z75una9tOyzFwZWyCggDtGEoCaA@mail.gmail.com>
References: <CAPnaeVAZkj6XtbiArJ0d6gKphnSR=CoXYCimjoy=2N5uc+H3sw@mail.gmail.com>
 <CAKaYPCMin9quv_jRU+Vrdc0nJBPEuqXBWs5djdPP=fxeNvqfLA@mail.gmail.com>
 <CAPnaeVDey2J325MDzdQq6P19h0s-b1UvHXscd+mdhm5ntRfwmQ@mail.gmail.com>
 <CAKaYPCNPtoaN1Qe6uQJdSy_Z75una9tOyzFwZWyCggDtGEoCaA@mail.gmail.com>
Message-ID: <CAPnaeVDFc-pBkVpgvQ3WtZvPOdS0cKx=ScFve3i15r3cUPbemw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On 5 June 2016 at 15:15, Olof Kindgren <olof.kindgren@gmail.com> wrote:

> On Sun, Jun 5, 2016 at 2:23 PM, Javier <javieralso@gmail.com> wrote:
> > Hi Olof and Stefan,
> >
> > Thanks for your comments.
> >
> > After some tests following your advices, looks like Olof was right, it
> was a
> > timing issue. It only happens when I'm debuging step by step. so mistery
> > solved :) thanks
> >
>
> Actually, with this information I would say that the mystery is not solved
> :)
>
> When I said timing issues, I was referring to timing violations in the
> FPGA routing You can check if you have timing issues by looking at the
> end of <workspace>/build/de0_nano/bld_quartus/de0_nano.sta.rpt. In the
> last lines there should be a message saying "Info: Quartus II 64-Bit
> TimeQuest Timing Analyzer was successful. 0 errors, 0 warnings".
>

TimeQuest Timing Analyzer gave me 0 errors, 1 warnings (but the warning was
due Parallel compilation wasn't licensed so it doesn't count)

>
> Single stepping should work as far as I know, but it sounds like it
> doesn't work reliably, so you might have hit a bug here.
>

Yep, you're right. I was meaning that it looked as if it was just a timing
issue but it's true, it can be due to a bug :)

>
> > Regarding Olof's suggestion about to perform a RTL simulation, I've
> tried it
> > with command "fusesoc sim de0_nano" but all that I have is something like
> >
> > Preloading boot ROM from ../src/de0_nano/sw/clear_r3_and_jump_to_0x100.vh
> >
> > And nothing else. I'm just starting with fusesoc and orpsoc and I didn't
> > find much information about RTL simulation, but, as I saw on some
> examples,
> > looks like I can write a program that uses the UART to print on the
> console
> > during simulation.
> >
> > Am I wrong? Is there any way to connect the RTL model being simulated to
> gdb
> > as I can do with or1ksim? I don't think so, but as I said before, I'm not
> > experienced with this so I may be wrong.
> >
>
> There are at least three ways to run a real elf file in simulations.
> As all three methods are pretty slow, I would recommend starting with
> a simple hello world first to see that it works.
>
> The method I mostly use is to load an elf file to the simulated RAM
> before starting the simulation. You can do this by appending
> --elf-load=/path/to/file.elf to load your program.


By simulating this way I saw the behaviour was the expected one: the flag
was set and then l.bf instruction branched

>
> Another method is to put your elf file in the simulated SPI Flash on
> the board. This requires you to first convert your elf file to the
> uBoot uImage format and then to a verilog memload file. There's a
> makefile in ~/.local/share/orpsoc-cores/systems/de0_nano/bench that
> can help you with that. Run "IMAGE=/path/to/file.elf make" to create
> file.vh, which can be loaded into the simulated Flash. To make FuseSoC
> use your new file, you can add the parameter
> --spi_flash_file=/path/to/file.vh . You will also need to change the
> default de0_nano bootloader, so that it loads your file. You do that
> by adding the parameter
>
> --bootrom_file=~/.local/share/orpsoc-cores/systems/de0_nano/sw/spi_uimage_loader.vh
>
> The third option is to load your elf file with gdb or openocd. To do
> that, you add the switch --jtag_vpi_enable . This will open a socket
> on port 5555 that can be used to send JTAG commands from OpenOCD to
> the running simulation, just as you would do on a real target. Once
> the simulation is running, you can now start OpenOCD with "openocd -f
> interface/jtag_vpi.cfg -c "set TAP_TYPE MOHOR" -f
> board/or1k_generic.cfg", and it should connect to the socket. Haven't
> done that for some time though, so I might have gotten some parameter
> wrong. Also, note that this is pretty slow, so I would start with
> option 1 :)


I tried to carry out this simulation but looks like there isn't socket
listening at port 5555. I don't understand exactly why. The command I
issued was:

fusesoc sim de0_nano --vcd --trace_to_screen --trace_enable
--jtag-vpi-enable

And the output I got was:

LXT2 info: dumpfile testlog.vcd opened for output.
No ELF file specified
orpsoc_tb.dut.mor1kx0.bus_gen.ibus_bridge: Wishbone bus IF is
B3_REGISTERED_FEEDBACK
orpsoc_tb.dut.mor1kx0.bus_gen.dbus_bridge: Wishbone bus IF is
B3_REGISTERED_FEEDBACK
Preloading boot ROM from ../src/de0_nano/sw/clear_r3_and_jump_to_0x100.vh
JTAG debug module with VPI interface enabled

S f0000000: 18000000 l.movhi r0,0x0000       r0 = 00000000  flag: x
S f0000004: a8200000 l.ori   r1,r0,0x0000    r1 = 00000000  flag: x
S f0000008: a8c00100 l.ori   r6,r0,0x0100    r6 = 00000100  flag: x
S f000000c: 44003000 l.jr    r6                  flag: x
S f000000c: 44003000 l.jr    r6                  flag: x
S f0000010: 15000000 l.nop   0x0000              flag: x

But when I try to connect with openocd I have a connection refused message.
I also tried to connect with netcat but there are no opened port.

Do I miss something?


>
>
> > Anyway, once more time, thanks for your help with this.
> >
>
> No worries. Don't hesitate to ask for help if you need it, and we are
> usually available at #openrisc on irc.freenode.net if you need quick
> assistance


Thanks for all your help Olof, it's really appreciated :)

Regards


> > Regards,
> > Javier
> >
> >
> >
> > On 4 June 2016 at 20:51, Olof Kindgren <olof.kindgren@gmail.com> wrote:
> >>
> >> On Sat, Jun 4, 2016 at 8:08 PM, Javier <javieralso@gmail.com> wrote:
> >> > Hello everybody.
> >> >
> >> > I'm relatively new with OR1K architecture and I would need some help
> >> > with a
> >> > problem I'm experiencing.
> >> >
> >> > At the moment, I'm developing a small robotic project using a DEO Nano
> >> > board
> >> > and fusesoc. I managed to synthetise the SoC adding a self-made module
> >> > and
> >> > seems to work OK, but during debuging, I noticed something that I
> don't
> >> > know
> >> > whether can be a bug.
> >> >
> >> > When the core (mor1k) executes the instruction l.bf (or l.bnf) and
> the
> >> > flag
> >> > is set (or cleared in the case of l.bnf), the processor doesn't branch
> >> > to
> >> > the target address after executing the instruction in the delay slot.
> >> >
> >> > This happens sometimes, not all the times.
> >> >
> >> > Is this a bug?
> >> >
> >> > For your reference, I tried with mor1k 3.1, 4.1 and master. or1ksim
> >> > works
> >> > fine, but not the implementation.
> >> >
> >> > --
> >> > Javier Almansa Sobrino.
> >> > Ingeniero Informático.
> >> >
> >> > FSF #7032 Member (www.fsf.com)
> >> >
> >> >
> >> > _______________________________________________
> >> > OpenRISC mailing list
> >> > OpenRISC at lists.librecores.org
> >> > https://lists.librecores.org/listinfo/openrisc
> >> >
> >>
> >> Hi Javier,
> >>
> >> There aren't any known bugs in this area at least, but what you're
> >> describing is definitely not the intended behaviour :)
> >>
> >> Is this running on an FPGA target or in RTL simulation? It would be
> >> very helpful also if you have the program you're trying to run
> >> available, especially if you know a certain point in the program where
> >> this usually fails.
> >>
> >> Would be good to confirm also that the design meets timing, if it's
> >> the FPGA implementation. As it seems to happen more or less at random,
> >> it sounds a bit like a timing issue.
> >>
> >> As you say that this happens during debugging, it could also be
> >> related to the debug interface. Are you single-stepping, setting
> >> breakpoints etc?
> >>
> >> //Olof
> >
> >
> >
> >
> > --
> > Javier Almansa Sobrino.
> > Ingeniero Informático.
> >
> > FSF #7032 Member (www.fsf.com)
> >
>



-- 
Javier Almansa Sobrino.
Ingeniero Informático.

FSF #7032 Member (www.fsf.com)
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160606/6b5e9f26/attachment.html>
