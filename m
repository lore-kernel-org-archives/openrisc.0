From: Stafford Horne <shorne@gmail.com>
Date: Thu, 25 Aug 2016 16:15:26 +0900
Subject: [OpenRISC] Installing gcc commpiler on openrisc linux
In-Reply-To: <ab2639ae-6747-ce88-edc3-559700c4b45c@wallentowitz.de>
References: <CAFoY_wzJ43q=97rSJu2jMnOnOj4QvzR7GkF+LPAyOrfsVdWPsQ@mail.gmail.com>
 <CAAfxs75ioYwn81RX_raF0rWW0Pwu00V6kj4B_RKqYAFWpjbd6g@mail.gmail.com>
 <ab2639ae-6747-ce88-edc3-559700c4b45c@wallentowitz.de>
Message-ID: <CAAfxs74Mvmh1Q-tQXtDfwHE_EpE-Ecs9fjQ=JUNhfw-W+ghALA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

There are two ways.

1.
When building the Linux kernel you can place any files you want under /arch
<https://github.com/openrisc/linux/tree/master/arch>/openrisc
<https://github.com/openrisc/linux/tree/master/arch/openrisc>/support
<https://github.com/openrisc/linux/tree/master/arch/openrisc/support>/
*initramfs* and they will be there when you buy the system.

2. Not got this working myself
When you connect to your serial terminal there are ways to transfer through
the serial connection. You can maybe get builds of zmodem working there.

-Stafford

On 25 Aug 2016 4:13 p.m., "Stefan Wallentowitz" <stefan@wallentowitz.de>
wrote:

> On 25.08.2016 01:44, Stafford Horne wrote:
> > Hello Manaar,
> >
> > The openrisc Linux build creates an image with all the tools provided
> > using busybox (it's in the kernel source tree). So it's basically a
> > busybox embedded system.  You can Google about adding gcc or another c
> > compiler to busybox for details.
> >
> > I don't think it's been done before. Gcc is rather large for de0 nano
> > ;it's not just gcc but linkers and assemblers and libraries you would
> > want to link in. However, I wouldnt bet it's impossible if you strip it
> > down.
> >
> > -Stafford
>
> Hi Manaar,
>
> just to add to this and Jeremy's comment: It is not the standard way to
> compile inside the target system. Instead you cross-compile on your host
> and transfer the binary ELF to the target.
>
> I am not sure if the tutorial already covers adding files to the ramdisk
> (the image you load onto the target). Stafford, you are the expert on
> this, right?
>
> Cheers,
> Stefan
>
>
>
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160825/12fafe83/attachment.html>
