From: Stafford Horne <shorne@gmail.com>
Date: Thu, 4 Mar 2021 05:25:31 +0900
Subject: [OpenRISC] [PATCH 0/4] OpenRISC fixes and setjmp/longjmp work
In-Reply-To: <20210303141214.GG365039@lianli.shorne-pla.net>
References: <20210303135026.3450789-1-shorne@gmail.com>
 <57222afc-9d92-e52d-34d4-0737eff1ec82@pengutronix.de>
 <20210303141214.GG365039@lianli.shorne-pla.net>
Message-ID: <20210303202531.GH365039@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Mar 03, 2021 at 11:12:14PM +0900, Stafford Horne wrote:
> On Wed, Mar 03, 2021 at 03:03:11PM +0100, Ahmad Fatoum wrote:
> > Hello Stafford,
> > 
> > On 03.03.21 14:50, Stafford Horne wrote:
> > > Hello,
> > > 
> > > These are the patches I came up with to get the setjmp/longjmp routines to work
> > > on OpenRISC.  It seems to be working well.
> > > 
> > > The patches are on github here:
> > >   https://github.com/stffrdhrn/barebox/tree/openrisc-bthread
> > > 
> > > I had to revert a commit to remove openrisc to do this work, I hope that can be
> > > reverted.
> > 
> > Great. Thanks for taking the time!
> > Could this be tested on qemu-system-or1k? If so, it would be great to have this
> > documented in-tree, so future changes could be tested.
> 
> Sure, I will try to get it working.  For some reason qemu was getting hung.
> 
> Give me a few days.

Got it working and posted a sepaate patch.  I will add documentation as well, but
here is what I ran. It should be similar to what I documented on the qemu wiki:

  https://wiki.qemu.org/Documentation/Platforms/OpenRISC

    $ /home/shorne/work/openrisc/qemu/build/or1k-softmmu/qemu-system-or1k -cpu or1200 \
      -M or1k-sim \
      -kernel /home/shorne/work/openrisc/barebox/barebox \
      -net nic -net tap,ifname=tap0,script=no,downscript=no \
      -serial mon:stdio -nographic \
      -gdb tcp::10001 \
      -m 32

    barebox 2021.02.0-00120-g763c6fee7-dirty #14 Thu Mar 4 05:13:51 JST 2021


    Board: or1ksim
    mdio_bus: miibus0: probed
    malloc space: 0x01b80000 -> 0x01f7ffff (size 4 MiB)

    Hit any to stop autoboot:    3
    barebox at or1ksim:/
    barebox at or1ksim:/
    barebox at or1ksim:/ bthread -v
    bthread_printer yield #1
    bthread_printer yield #2
    bthread_printer yield #3
    bthread_printer yield #4
    9963 bthread yield calls in 1s

-Stafford
