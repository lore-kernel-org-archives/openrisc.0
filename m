From: Stafford Horne <shorne@gmail.com>
Date: Sun, 15 Aug 2021 07:25:05 +0900
Subject: [OpenRISC] [PATCH v2 0/2] OpenRISC support for cmodel=large
In-Reply-To: <9e4b2d98-5ba1-c35f-b419-3df2d84a5dab@benettiengineering.com>
References: <20210501211145.2980164-1-shorne@gmail.com>
 <da63081f-fe79-32c2-37f1-f17ce62f967b@benettiengineering.com>
 <YRg9yfcMeP6X3zhu@antec>
 <9e4b2d98-5ba1-c35f-b419-3df2d84a5dab@benettiengineering.com>
Message-ID: <YRhCwQPveo8+lnGH@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Aug 15, 2021 at 12:05:37AM +0200, Giulio Benetti wrote:
> On 8/15/21 12:03 AM, Stafford Horne wrote:
> > On Sat, Aug 14, 2021 at 11:01:16PM +0200, Giulio Benetti wrote:
> > > Hi All,
> > > 
> > > On 5/1/21 11:11 PM, Stafford Horne wrote:
> > > > Changes from v1:
> > > >    - Added patch to enabled cmodle=large on crtstuff
> > > > 
> > > > This series fixes some bugs found when linking large binaries, both in buildroot
> > > > and glibc testing.
> > > > 
> > > > Stafford Horne (2):
> > > >     or1k: Add mcmodel option to handle large GOTs
> > > >     or1k: Use cmodel=large when building crtstuff
> > > > 
> > > >    gcc/config/or1k/or1k-opts.h   | 30 ++++++++++++++++++++++++++++++
> > > >    gcc/config/or1k/or1k.c        | 11 +++++++++--
> > > >    gcc/config/or1k/or1k.h        |  7 +++++++
> > > >    gcc/config/or1k/or1k.opt      | 19 +++++++++++++++++++
> > > >    gcc/doc/invoke.texi           | 12 +++++++++++-
> > > >    libgcc/config.host            |  4 ++--
> > > >    libgcc/config/or1k/t-crtstuff |  2 ++
> > > >    7 files changed, 80 insertions(+), 5 deletions(-)
> > > >    create mode 100644 gcc/config/or1k/or1k-opts.h
> > > >    create mode 100644 libgcc/config/or1k/t-crtstuff
> > > > 
> > > 
> > > I've tested this patchset and works as expected.
> > > It fixed libgeos build failure in conjunction with:
> > > https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=3c3de29b048bca6b4aa4235c647b9328e71801b6
> > > 
> > > Hope this helps to commit it upstream since I still don't see it, or am I
> > > wrong?
> > 
> > You are not wrong, I did not push the changed to GCC yet.  I will do soon.
> 
> Ah ok, you're the maintainer :-) I thought there was someone else who needed
> to push it :-)

Yeah, I pushed it now.
