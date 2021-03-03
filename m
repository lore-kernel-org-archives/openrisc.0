From: Stafford Horne <shorne@gmail.com>
Date: Wed, 3 Mar 2021 23:12:14 +0900
Subject: [OpenRISC] [PATCH 0/4] OpenRISC fixes and setjmp/longjmp work
In-Reply-To: <57222afc-9d92-e52d-34d4-0737eff1ec82@pengutronix.de>
References: <20210303135026.3450789-1-shorne@gmail.com>
 <57222afc-9d92-e52d-34d4-0737eff1ec82@pengutronix.de>
Message-ID: <20210303141214.GG365039@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Mar 03, 2021 at 03:03:11PM +0100, Ahmad Fatoum wrote:
> Hello Stafford,
> 
> On 03.03.21 14:50, Stafford Horne wrote:
> > Hello,
> > 
> > These are the patches I came up with to get the setjmp/longjmp routines to work
> > on OpenRISC.  It seems to be working well.
> > 
> > The patches are on github here:
> >   https://github.com/stffrdhrn/barebox/tree/openrisc-bthread
> > 
> > I had to revert a commit to remove openrisc to do this work, I hope that can be
> > reverted.
> 
> Great. Thanks for taking the time!
> Could this be tested on qemu-system-or1k? If so, it would be great to have this
> documented in-tree, so future changes could be tested.

Sure, I will try to get it working.  For some reason qemu was getting hung.

Give me a few days.

-Stafford
