From: Stafford Horne <shorne@gmail.com>
Date: Sat, 25 Feb 2017 04:20:56 +0900
Subject: [OpenRISC] [PATCH v4 05/24] openrisc: head: refactor out tlb
 flush into it's own function
In-Reply-To: <20170224135401.GB21431@chokladfabriken.org>
References: <cover.1487910170.git.shorne@gmail.com>
 <8c9b7db0de3d64c9a6fcd12622636d4aa6a8c30c.1487910170.git.shorne@gmail.com>
 <e824fc06-152d-39cf-1d6a-f007d6246d92@southpole.se>
 <20170224105422.GA21431@chokladfabriken.org>
 <a3f12b07-22f4-b1db-9a24-aba8ae4608d9@southpole.se>
 <20170224135401.GB21431@chokladfabriken.org>
Message-ID: <20170224192056.GO2449@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Feb 24, 2017 at 03:54:02PM +0200, Stefan Kristiansson wrote:
> On Fri, Feb 24, 2017 at 01:48:10PM +0100, Jonas Bonn wrote:
> > On 02/24/2017 11:54 AM, Stefan Kristiansson wrote:
> > >eOn Fri, Feb 24, 2017 at 10:57:19AM +0100, Jonas Bonn wrote:
> > >>On 02/24/2017 05:32 AM, Stafford Horne wrote:
> > >>>From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > >>>
> > >>>This brings it inline with the other setup oprations done like the cache
> > >>>enables _ic_enable and _dc_enable.  Also, this is going to make it
> > >>>easier to initialize additional cpu's when smp is introduced.
> > >>This patch confuses me.  The TLB flush is moved to a point after MMU's are
> > >>enabled.  The TLB flush should happen before enabling the MMU, shouldn't it?
> > >>
> > >It still happens before the MMUs are enabled, the patch only refactors the code
> > >out into a function that is called from the place where it was open coded
> > >before.
> > 
> > Right.  What's the point of moving it then?
> > 
> 
> As the commit message mentions, it's a preparation patch for initialisation
> of secondary cpus, which also will call this function.
> 
> Perhaps this patch should be bundled with those patches.
> 

Thanks for replying on this patch, I think keeping this patch here is
ok.  Since part of the theme of this series is preparing for SMP (which
will be another big series) I think its ok have any non SMP specific
work into here.  Its going to make my life a bit easier going forward.

Also, as this is good refactor to get it structurally in sync with other
initializations I think its not completely out of place.

-Stafford
