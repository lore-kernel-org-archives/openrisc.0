From: Stafford Horne <shorne@gmail.com>
Date: Thu, 25 Apr 2019 07:44:37 +0900
Subject: [OpenRISC] cannot boot linux
In-Reply-To: <HE1PR0801MB164492B92CD96C4E8E0DE800FE3C0@HE1PR0801MB1644.eurprd08.prod.outlook.com>
References: <AM5PR0801MB16336F56C18491748C786E25FE2A0@AM5PR0801MB1633.eurprd08.prod.outlook.com>
 <CAAfxs77PWBihhMSBnYmi8qA_cyROR0s_pvORgMtE3oDcd-bbbQ@mail.gmail.com>
 <HE1PR0801MB164492B92CD96C4E8E0DE800FE3C0@HE1PR0801MB1644.eurprd08.prod.outlook.com>
Message-ID: <CAAfxs76knv7cTKtHjS75b=QzmwTS04t2UcAnRp7OcLT-2Yr43A@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

Good to hear it's working.  I do suggest trying out kernel gdb helpers the
lx-dmesg helper is a lifesaver.

For openocd I did a smp Port but it hasn't gone upstream yet. (Help
appreciated)

You can find my config and code here.

https://github.com/stffrdhrn/or1k-utils/blob/master/openocd/de0_nano.cfg

https://github.com/stffrdhrn/openocd/tree/or1k-multicore

- Stafford


On Thu, Apr 25, 2019, 6:36 AM Basel Sayeh <basel.sayeh@hotmail.com> wrote:

> Hello Stafford,
> I solved it by using the latest 9.0 gcc for or1k in stffrdhrn's repo
> for some reason, gcc 7.2.0 was giving me a bus error, while gcc 9.0 is
> working.
> A small question,
> Do i need any special measures other than patching or1k.cfg to support smp
> other than
> halt; load_image vmlinux; reg r3 0; reg npc 0x100; resume
> ?
>
> https://github.com/baselsayeh/linux_things_openrisc/blob/master/or1k-dualcore.cfg
>
>
> https://github.com/baselsayeh/linux_things_openrisc/blob/master/or1k-dev-dualcore.tcl
>
> Sorry for sending this message twice, as I forgot to add the mailing list
> to the cc field
> ________________________________
> From: Stafford Horne <shorne@gmail.com>
> Sent: Tuesday, April 23, 2019 12:22:56 PM
> To: Basel Sayeh
> Cc: Openrisc
> Subject: Re: [OpenRISC] cannot boot linux
>
> Hello Basel,
>
> Sorry for delay I was off all last week.
>
> What version of Linux are you using and what does your device tree look
> like?  What version of the gcc toolchain are you using?
>
> Also, have you tried the kernel gdb helpers?
>
> Some examples here
> https://www.kernel.org/doc/html/v4.10/dev-tools/gdb-kernel-debugging.html
>
> -stafford
>
> On Mon, Apr 15, 2019, 4:28 PM Basel Sayeh <basel.sayeh@hotmail.com<mailto:
> basel.sayeh at hotmail.com>> wrote:
> Hello
>
> I tried to boot linux via mor1kx cpu built via fusesoc for a qmtech
> Cyclone IV board
> https://github.com/baselsayeh/qmtech_ep4ce15-multicore
>
> Every time the kernel jumps to or32_early_setup, the cpu throws bus errors
> and jumps to 0x200
>
> Here is gdb output just before the error
> https://pastebin.com/U5izVPG9
>
> How i can investigate this?
> Thanks
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org<mailto:OpenRISC@lists.librecores.org>
> https://lists.librecores.org/listinfo/openrisc
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20190425/472d1888/attachment.html>
