From: Vidya Govindan <vidya.mazhur@gmail.com>
Date: Thu, 11 Aug 2016 21:12:35 +0530
Subject: [OpenRISC] Linux on DE0-Nano Board- Fusesoc build problem
In-Reply-To: <CAKaYPCM9Fy3+qx5oL1apYtu=BTMA9Fie0eVkZq2_xQYWBTCOeQ@mail.gmail.com>
References: <CAO0TxAQOW1zpzyag=A68UuU9OEssymCiUNR882TG6F+0=JgORw@mail.gmail.com>
 <CAKaYPCM9Fy3+qx5oL1apYtu=BTMA9Fie0eVkZq2_xQYWBTCOeQ@mail.gmail.com>
Message-ID: <CAO0TxATxupiqXUmRqFX2yTqVfNQZKFPw4BV1=B-A+GK3-56AJA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi All,

I'm now able to build the FPGA image.
I have also built linux for the board.
I'm facing problems in running software with GDB using OPENOCD.
After running

or1k-elf-gdb timer.elf and executing these steps:

target remote :50001
load
set $npc=0x100
continue

I get the following error:
or1k_timer_get_ticks ()
    at /home/wallento/dev/build-or1k-elf/newlib/libgloss/or1k/timer.c:173
173    /home/wallento/dev/build-or1k-elf/newlib/libgloss/or1k/timer.c:
No such file or directory.

Does anyone know what can be the problem?

Regards,
Vidya


On Mon, Aug 8, 2016 at 2:24 AM, Olof Kindgren <olof.kindgren@gmail.com>
wrote:

> On Sun, Aug 7, 2016 at 3:31 PM, Vidya Govindan <vidya.mazhur@gmail.com>
> wrote:
> > Hello All,
> >
> > I'm trying to build an sof file for DE0Nano board using which I want to
> run
> > linux on openrisc platform synthesized on Cyclone IV board.
> > So far I have been able simulate linux using or1ksim.
>
> Great to hear that you got it working with or1ksim. Just out of
> curiosity, did you find out what the problem was?
>
> > I decided to move on to the board and tried the steps mentioned in
> > https://github.com/kdgwill/OR1K/wiki/OpenRisc-tools-Install
> > I'm stuck at the make phase of fusesoc where I get the following error:
> >
> > make: *** No rule to make target `bin/fusesoc', needed by `out/fusesoc'.
> > Stop.
> >
> > As I tried to find out  why I get the error and how I can solve it, I
> came
> > upon lot of other things which basically confused me more. So I have
> > following queries if possible someone can please clarify:
> >
>
> I didn't know about these instructions, and the procedure has changed
> quite a bit since that was written. Unfortunately, the old commands no
> longer work. The correct installation instructions are now like this:
>
> git clone https://github.com/olofk/fusesoc
> cd fusesoc
> pip install .
>
> To automatically download the FuseSoC standard core library
> (orpsoc-cores) and create the configuration files, just run
>
> fusesoc init
>
> Once FuseSoC is installed, you need to create a working directory
> where all systems will be built. This can be placed anywhere, and
> we'll call it $WORKSPACE in this example
>
> mkdir $WORKSPACE
> cd $WORKSPACE
> fusesoc build de0_nano
>
> the above commands will build the SoC
>
>
> > 1.I understand Fusesoc is the latest version of orpsocv3. Is my
> > understanding correct?
>
> I started a project called orpsocv3 about five years ago. After about
> a year I realized that nothing in the code had anything to do with
> OpenRISC, so I decided that orpsoc (OpenRISC Reference Platform SoC)
> was a bad name, and I renamed the project FuseSoC. If you find any
> references to orpsocv3, they are most likely more than four years old,
> and will probably not work anymore. orpsocv3 is a dead project and
> FuseSoC is what we use today
>
> > 2. I have to build Fusesoc and orpsoc cores separately. So once I have
> > installed the Fusesoc framework described in here
> > https://github.com/kdgwill/OR1K/wiki/OpenRisc-tools-Install , I have to
> use
> > either
> > http://www.rs-online.com/designspark/electronics/eng/
> blog/booting-linux-on-a-de0-nano-with-orpsoc
> > or
> > http://web.archive.org/web/20140625095048/http://
> opencores.org/or1k/ORCONF2013_Workshop_ORPSoC_On_DE0_Nano
> > instructions both of which do not talk about Fusesoc (may be because it
> was
> > recently named?)
>
> It's very unfortunate that there has been several articles written
> when it was still orpsocv3. We are trying to improve the situation and
> have started writing new tutorials here
> https://github.com/openrisc/tutorials/ In fact, the first one covers
> the de0 nano board, so please let us know if that works ok
>
> > Am I going correct here?
> > 3. How can I can build Fusesoc successfully and run linux on OpenRISC
> > platform using DE0Nano? Any leads would be greatly appreciated.
> >
>
> There are several steps to accomplish this, but in the most basic
> setup it amounts to
>
> 1. Build the FPGA image (fusesoc build de0_nano)
> 2. Compile a linux kernel for de0_nano
> 3. Download the linux kernel to the SDRAM on the de0 nano via JTAG.
>
> I know that there are lots of things more to explain here, but as I'm
> not really sure on which topics you would like more help, I think it's
> best that you continue to give me questions once you're stuck
> somewhere, and I'll try to answer them
>
> > PS: Please pardon me if any of my queries are stupid.
> >
>
> Not at all. Unfortunately it just highlights how complex this is and
> most of all, the bad state of our documentation. We'll take this
> opportunity to improve on our side too. Also, if you use IRC, you can
> find us on #openrisc on irc.freenode.net . That is perhaps the
> quickest way to get replies
>
>
> > Thanks & Regards,
> > Vidya
> >
>
> Cheers,
> Olof
>
> >
> > _______________________________________________
> > OpenRISC mailing list
> > OpenRISC at lists.librecores.org
> > https://lists.librecores.org/listinfo/openrisc
> >
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160811/585bf416/attachment.html>
