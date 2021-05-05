From: Stafford Horne <shorne@gmail.com>
Date: Wed, 5 May 2021 15:30:04 +0900
Subject: [OpenRISC] [PATCH v2 0/2] OpenRISC support for cmodel=large
In-Reply-To: <9a2977bb-b9a3-73e7-2cc8-4705fb6bc30f@benettiengineering.com>
References: <20210501211145.2980164-1-shorne@gmail.com>
 <9a2977bb-b9a3-73e7-2cc8-4705fb6bc30f@benettiengineering.com>
Message-ID: <20210505063004.GT3288043@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, May 03, 2021 at 12:34:22PM +0200, Giulio Benetti wrote:
> Hi Stafford, All,
> 
> I've backported this patchset for Buildroot to versions:
> - 9.3.0
> - 10.3.0
> 
> Does it make sense to send them? I don't know if those version will have
> minor versions where these backported patches can be applied.

Do you mean for me/you to send the backported GCC patches for GCC or buildroot?

I don't need backported versions of the toolchains and usually work off the
latest release/master.  If someone wants them let me know.

-Stafford

> Best regards
> -- 
> Giulio Benetti
> Benetti Engineering sas
> 
> On 5/1/21 11:11 PM, Stafford Horne wrote:
> > Changes from v1:
> >   - Added patch to enabled cmodle=large on crtstuff
> > 
> > This series fixes some bugs found when linking large binaries, both in buildroot
> > and glibc testing.
> > 
> > Stafford Horne (2):
> >    or1k: Add mcmodel option to handle large GOTs
> >    or1k: Use cmodel=large when building crtstuff
> > 
> >   gcc/config/or1k/or1k-opts.h   | 30 ++++++++++++++++++++++++++++++
> >   gcc/config/or1k/or1k.c        | 11 +++++++++--
> >   gcc/config/or1k/or1k.h        |  7 +++++++
> >   gcc/config/or1k/or1k.opt      | 19 +++++++++++++++++++
> >   gcc/doc/invoke.texi           | 12 +++++++++++-
> >   libgcc/config.host            |  4 ++--
> >   libgcc/config/or1k/t-crtstuff |  2 ++
> >   7 files changed, 80 insertions(+), 5 deletions(-)
> >   create mode 100644 gcc/config/or1k/or1k-opts.h
> >   create mode 100644 libgcc/config/or1k/t-crtstuff
> > 
