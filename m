From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Date: Fri, 24 Feb 2017 12:54:23 +0200
Subject: [OpenRISC] [PATCH v4 05/24] openrisc: head: refactor out tlb
 flush into it's own function
In-Reply-To: <e824fc06-152d-39cf-1d6a-f007d6246d92@southpole.se>
References: <cover.1487910170.git.shorne@gmail.com>
 <8c9b7db0de3d64c9a6fcd12622636d4aa6a8c30c.1487910170.git.shorne@gmail.com>
 <e824fc06-152d-39cf-1d6a-f007d6246d92@southpole.se>
Message-ID: <20170224105422.GA21431@chokladfabriken.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

eOn Fri, Feb 24, 2017 at 10:57:19AM +0100, Jonas Bonn wrote:
> On 02/24/2017 05:32 AM, Stafford Horne wrote:
> >From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> >
> >This brings it inline with the other setup oprations done like the cache
> >enables _ic_enable and _dc_enable.  Also, this is going to make it
> >easier to initialize additional cpu's when smp is introduced.
> 
> This patch confuses me.  The TLB flush is moved to a point after MMU's are
> enabled.  The TLB flush should happen before enabling the MMU, shouldn't it?
> 

It still happens before the MMUs are enabled, the patch only refactors the code
out into a function that is called from the place where it was open coded
before.

Stefan
