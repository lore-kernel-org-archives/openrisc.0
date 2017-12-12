From: Stafford Horne <shorne@gmail.com>
Date: Tue, 12 Dec 2017 23:04:46 +0900
Subject: [OpenRISC] [PATCH v7 4/4] Add gdb for or1k build
In-Reply-To: <CAAfxs75FzHZL7PLeR9A3kHEBb_oAPcy6h_=KOP=s0w2eh6=LFQ@mail.gmail.com>
References: <cover.1496068645.git.shorne@gmail.com>
 <9f7c01d33d453186963b6b13f0f1ef4394b4e98b.1496068645.git.shorne@gmail.com>
 <CAAfxs75FzHZL7PLeR9A3kHEBb_oAPcy6h_=KOP=s0w2eh6=LFQ@mail.gmail.com>
Message-ID: <20171212140446.GB3483@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

I brought this up on the #gcc chat room.  I was asked to check with Jakub and
Richi.

This is a small patch to configure/configure.ac to enable gdb to build for the
or1k target.  I am working on upstreaming the gdb port and have everything OKed
and all copyrights in place for the binutils/gdb/sim projects.

Since binutils copies the configure/configure.ac from the gcc project I would
like to get this patch incorporated into gcc before committing the
binutils/gdb/sim patches.

Please let me know if there are any questions/concerns.

-Stafford

On Sat, Dec 09, 2017 at 06:28:28AM +0900, Stafford Horne wrote:
> Hello,
> 
> This patch was sent in May, now everything is in place to commit the
> OpenRISC gdb port upstream except for the OK from GCC on this patch.
> 
> Are there any concerns?  Who will commit this to GCC?
> 
> On Mon, May 29, 2017 at 11:48 PM, Stafford Horne <shorne@gmail.com> wrote:
> > * ChangeLog:
> >
> > 2017-02-12  Stafford Horne  <shorne@gmail.com>
> >
> >         * configure.ac: Remove logic adding gdb to noconfigsdirs for or1k.
> >         * configure: Regenerate.
> >
> > Cc: gcc-patches at gcc.gnu.org
> > ---
> >  configure    | 7 -------
> >  configure.ac | 7 -------
> >  2 files changed, 14 deletions(-)
> >
> > diff --git a/configure b/configure
> > index be9dd89..0bf47fa 100755
> > --- a/configure
> > +++ b/configure
> > @@ -3632,10 +3632,6 @@ case "${target}" in
> >      ;;
> >    *-*-rtems*)
> >      noconfigdirs="$noconfigdirs target-libgloss"
> > -    # this is not caught below because this stanza matches earlier
> > -    case $target in
> > -      or1k*-*-*) noconfigdirs="$noconfigdirs gdb" ;;
> > -    esac
> >      ;;
> >      # The tpf target doesn't support gdb yet.
> >    *-*-tpf*)
> > @@ -3841,9 +3837,6 @@ case "${target}" in
> >    nvptx*-*-*)
> >      noconfigdirs="$noconfigdirs target-libssp target-libstdc++-v3 target-libobjc"
> >      ;;
> > -  or1k*-*-*)
> > -    noconfigdirs="$noconfigdirs gdb"
> > -    ;;
> >    sh-*-*)
> >      case "${target}" in
> >        sh*-*-elf)
> > diff --git a/configure.ac b/configure.ac
> > index 532c5c2..9d16792 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -966,10 +966,6 @@ case "${target}" in
> >      ;;
> >    *-*-rtems*)
> >      noconfigdirs="$noconfigdirs target-libgloss"
> > -    # this is not caught below because this stanza matches earlier
> > -    case $target in
> > -      or1k*-*-*) noconfigdirs="$noconfigdirs gdb" ;;
> > -    esac
> >      ;;
> >      # The tpf target doesn't support gdb yet.
> >    *-*-tpf*)
> > @@ -1175,9 +1171,6 @@ case "${target}" in
> >    nvptx*-*-*)
> >      noconfigdirs="$noconfigdirs target-libssp target-libstdc++-v3 target-libobjc"
> >      ;;
> > -  or1k*-*-*)
> > -    noconfigdirs="$noconfigdirs gdb"
> > -    ;;
> >    sh-*-*)
> >      case "${target}" in
> >        sh*-*-elf)
> > --
> > 2.9.4
> >
