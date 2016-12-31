From: Stafford Horne <shorne@gmail.com>
Date: Sun, 1 Jan 2017 07:50:59 +0900
Subject: [OpenRISC] [PATCH 0/3] Openrisc 4.10 fixes
In-Reply-To: <5edddd32-2a31-8b52-adfa-f5edae1fc227@southpole.se>
References: <cover.1483184705.git.shorne@gmail.com>
 <5edddd32-2a31-8b52-adfa-f5edae1fc227@southpole.se>
Message-ID: <20161231225059.GC2777@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Jonas,

On Sat, Dec 31, 2016 at 03:10:37PM +0100, Jonas Bonn wrote:
> Hi Stafford,
> 
> On 12/31/2016 12:52 PM, Stafford Horne wrote:
> > Hello,
> > 
> > These are a few small changes for openrisc I would like to include in 4.10.
> > The main change is a fix for building with alldefconfig to properly setup
> > then _text symbol.  Others are trivial.
> > 
> > If no complaints I will push to 4.10 for inclusion and start working on
> > 4.11 changes.
> 
> Post-merge window patches should  be bug fixes, only.  Patch 1/3 probably
> qualifies, but the others are far too trivial to be pushing now.  Just put
> them on your 4.11 branch.

Thanks, for some reason I thought minor changes like this were ok too.
I will only push the one change in this case.  The rest will go to my
4.11 queue, which I'll send for review in the next few days.

That brings up a question, Do you want to stay in the MAINTAINERS file?
I noticed sometimes you dont get around to review, but often when you do
the reviews are helpful like this one.

> > Let me know if these are too minor to even post for review.
> Nothing is too minor to post for review!

Good to know!

-Stafford

> > 
> > Stafford Horne (3):
> >    openrisc: Add _text symbol to fix ksym build error
> >    openrisc: Add .gitignore
> >    MAINTAINERS: Add the openrisc official repository
> > 
> >   MAINTAINERS                        | 1 +
> >   arch/openrisc/kernel/.gitignore    | 1 +
> >   arch/openrisc/kernel/vmlinux.lds.S | 2 ++
> >   3 files changed, 4 insertions(+)
> >   create mode 100644 arch/openrisc/kernel/.gitignore
> > 
> 

