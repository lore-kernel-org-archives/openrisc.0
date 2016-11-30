From: Olof Kindgren <olof.kindgren@gmail.com>
Date: Wed, 30 Nov 2016 21:11:18 +0100
Subject: [OpenRISC] Add openrisc for-next branch to linux-next
In-Reply-To: <f7f0e124-00b9-5b21-9ca0-1f17e7c338bd@infradead.org>
References: <alpine.LFD.2.20.1611302214520.29569@lianli.shorne-pla.net>
 <f7f0e124-00b9-5b21-9ca0-1f17e7c338bd@infradead.org>
Message-ID: <CAKaYPCMpZF6tQwQrtkVMZ1+F=vSUWxAx+skyMeU6FPPA_LGgVg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Nov 30, 2016 at 7:38 PM, Randy Dunlap <rdunlap@infradead.org> wrote:

> On 11/30/16 05:22, Stafford Horne wrote:
> > Hi Stephen,
> >
> > I have been working on getting the OpenRISC backlog of fixes sorted out
> for upstream.  Can this branch be added to linux-next?
> >
> >   git://github.com/openrisc/linux.git for-next
> >
> > These have been through a few reviews and we plan to ask Linus to pull
> in the next merge window.
> >
> > -Stafford
>
> Hi,
>
> I see that you have updated MAINTAINERS.  Good.
>
> Does openRISC support VGA console?
> I tried to send a patch to Jason a few days ago.
> Please look at http://marc.info/?l=linux-kernel&m=147968525011508&w=2
> (or I can resend it if you wish).
>
> The kbuild test bot has been reporting this build error for several
> months.  If my fix is wrong, please submit something else.
>
> Thanks.
> --
> ~Randy
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc
>

Hi Randy,

This is a known issue. This patch (https://github.com/openrisc/linux/pull/5)
should take care of it. Can't say if it's the correct solution though, but
it works both with and without a VGA console

//Olof
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20161130/e9d226a1/attachment.html>
