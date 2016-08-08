From: Vidya Govindan <vidya.mazhur@gmail.com>
Date: Mon, 8 Aug 2016 21:54:27 +0530
Subject: [OpenRISC] Linux on DE0-Nano Board- Fusesoc build problem
In-Reply-To: <CAKaYPCM9Fy3+qx5oL1apYtu=BTMA9Fie0eVkZq2_xQYWBTCOeQ@mail.gmail.com>
References: <CAO0TxAQOW1zpzyag=A68UuU9OEssymCiUNR882TG6F+0=JgORw@mail.gmail.com>
 <CAKaYPCM9Fy3+qx5oL1apYtu=BTMA9Fie0eVkZq2_xQYWBTCOeQ@mail.gmail.com>
Message-ID: <CAO0TxASbKs2ZpqFeWfGONGFV23h7dyX6aiJoXnCTszu-50sz=g@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Olof,

Thanks a lot for your reply , I understand better now.
I got the linux working on ork1sim by not using the copied source( earlier
I was copying the linux folder which did'nt work out).
I  tried to build FPGA image and I have following errors, hoping you can
help out:

1.  When I ran - *~/work/openrisc/fusesoc$ fusesoc init  *after the warning
messages I get

*Directory to use for orpsoc-cores [/home/vidya/.local/share/orpsoc-cores]
: orpsoc-cores*
     So I gave the input as orpsoc-cores which created and downloaded the
cores in fusesoc directory.

Now as you mentioned when I create new directory for build and run the
build command:


*~/work/openrisc$ cd
build_fusesoc_DE0Nano/~/work/openrisc/build_fusesoc_DE0Nano$ fusesoc build
de0_nano * I get the error:



*WARN:  Failed to register cores root 'orpsoc-cores is not a
directory'ERROR: Can't find system 'de0_nano'*
I then tried to build the image inside fusesoc directory as I thought the
cores are present in it and I get the following error:
~/work/openrisc/fusesoc$ fusesoc build de0_nano




















































*WARN:  plusargs section is deprecated and will not be parsed by FuseSoC.
Please migrate to parameters in fifo-1.0WARN:  plusargs section is
deprecated and will not be parsed by FuseSoC. Please migrate to parameters
in vlog_tb_utilsWARN:  plusargs section is deprecated and will not be
parsed by FuseSoC. Please migrate to parameters in elf-loaderWARN:
plusargs section is deprecated and will not be parsed by FuseSoC. Please
migrate to parameters in wb_sdram_ctrlWARN:  plusargs section is deprecated
and will not be parsed by FuseSoC. Please migrate to parameters in
wb_altera_ddr_wrapperWARN:  plusargs section is deprecated and will not be
parsed by FuseSoC. Please migrate to parameters in stream_utils-1.0WARN:
plusargs section is deprecated and will not be parsed by FuseSoC. Please
migrate to parameters in ram_wbWARN:  plusargs section is deprecated and
will not be parsed by FuseSoC. Please migrate to parameters in
wb_intercon-1.0WARN:  plusargs section is deprecated and will not be parsed
by FuseSoC. Please migrate to parameters in wb_interconINFO:  Preparing
adv_debug_sysINFO:  Downloading olofk/adv_debug_sys from githubTraceback
(most recent call last):  File "/usr/local/bin/fusesoc", line 9, in
<module>    load_entry_point('fusesoc==1.4', 'console_scripts',
'fusesoc')()  File
"/usr/local/lib/python2.7/dist-packages/fusesoc/main.py", line 357, in
main    run(parsed_args)  File
"/usr/local/lib/python2.7/dist-packages/fusesoc/main.py", line 291, in
run    args.func(args)  File
"/usr/local/lib/python2.7/dist-packages/fusesoc/main.py", line 65, in
build    backend.configure(args.backendargs)  File
"/usr/local/lib/python2.7/dist-packages/fusesoc/build/quartus.py", line 38,
in configure    super(Quartus, self).configure(args)  File
"/usr/local/lib/python2.7/dist-packages/fusesoc/build/backend.py", line 39,
in configure    super(Backend, self).configure(args)  File
"/usr/local/lib/python2.7/dist-packages/fusesoc/edatool.py", line 60, in
configure    core.setup()  File
"/usr/local/lib/python2.7/dist-packages/fusesoc/core.py", line 125, in
setup    if self.provider.fetch():  File
"/usr/local/lib/python2.7/dist-packages/fusesoc/provider/github.py", line
38, in fetch    self._checkout(self.files_root)  File
"/usr/local/lib/python2.7/dist-packages/fusesoc/provider/github.py", line
64, in _checkout    (filename, headers) = urllib.urlretrieve(url)  File
"/usr/lib/python2.7/urllib.py", line 94, in urlretrieve    return
_urlopener.retrieve(url, filename, reporthook, data)  File
"/usr/lib/python2.7/urllib.py", line 240, in retrieve    fp =
self.open(url, data)  File "/usr/lib/python2.7/urllib.py", line 208, in
open    return getattr(self, name)(url)  File
"/usr/lib/python2.7/urllib.py", line 437, in open_https
h.endheaders(data)  File "/usr/lib/python2.7/httplib.py", line 975, in
endheaders    self._send_output(message_body)  File
"/usr/lib/python2.7/httplib.py", line 835, in _send_output
self.send(msg)  File "/usr/lib/python2.7/httplib.py", line 797, in send
self.connect()  File "/usr/lib/python2.7/httplib.py", line 1178, in
connect    self.timeout, self.source_address)  File
"/usr/lib/python2.7/socket.py", line 571, in create_connection    raise
errIOError: [Errno socket error] [Errno 111] Connection refused*
There are two causes that I can figure out :
1. Maybe because I have different versions of Python?
2. or Maybe because I'm working behind a proxy?or something else.

Can you please tell me what could be the solution?

2. Also I want to run a simple C program on the linux on or1ksim. How can I
do it? I saw using toolchain installed I can cross compile the code and
then run the code in linux. To port the code in the linux I have to use gdb
server ? Do you have any updated links/steps to do this?

Thanks &Regards,
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
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160808/da663cce/attachment.html>
