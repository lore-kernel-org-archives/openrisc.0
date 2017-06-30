From: Stafford Horne <shorne@gmail.com>
Date: Fri, 30 Jun 2017 22:45:10 +0900
Subject: [OpenRISC] [PATCH] irqchip: or1k-pic: Fix interrupt system.
In-Reply-To: <d41eb84e-d77a-b8d9-d239-9f029b4cf24a@arm.com>
References: <20170630113356.GA20194@gmail.com>
 <20170630130434.GB2589@lianli.shorne-pla.net>
 <d41eb84e-d77a-b8d9-d239-9f029b4cf24a@arm.com>
Message-ID: <20170630134510.GC2589@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Jun 30, 2017 at 02:09:32PM +0100, Marc Zyngier wrote:
> On 30/06/17 14:04, Stafford Horne wrote:
> > +CC Kernel List
> > 
> > On Fri, Jun 30, 2017 at 08:33:56AM -0300, Pedro H. Penna wrote:
> >> Usually, hardware implicitly acknowledges interruts when
> >> reading them. However, if this is not the case, the IRQ
> >> gets fired over and over again in the current implementation.
> >>
> >> This patch uses the right mask acknowledge function to handle the
> >> aforementioned situation on or1k processors that interact with
> >> such kind of hardware.
> >>
> >> Signed-off-by: Pedro H. Penna <pedrohenriquepenna@gmail.com>
> > 
> > Acked-by: Stafford Horne
> 
> Can you please Ack it with an email address?

Sorry about that:

Acked-by: Stafford Horne <shorne@gmail.com>

> > 
> > I am ok to take this patch into my tree if no one objects.  But if someone
> > wants to take it through the drive tree I am fine too.
> 
> I'll queue it through my tree, as I have some last minute fixes to send
> to Thomas.

Thanks,

-Stafford
