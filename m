From: Stafford Horne <shorne@gmail.com>
Date: Sat, 6 Feb 2021 07:36:51 +0900
Subject: [OpenRISC] [PATCH v2] openrisc: use device tree to determine
 present cpus
In-Reply-To: <CAMuHMdXzr4c4=Cg1_Lmw41cmxmMrG4P=dV0yVjuXvuR5pqyh0Q@mail.gmail.com>
References: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
 <20210129221643.GZ2002709@lianli.shorne-pla.net>
 <2a018afc-d797-3a91-ffab-e55ae3b0a795@rwth-aachen.de>
 <20210130230310.GC2002709@lianli.shorne-pla.net>
 <d9f4aafc-4d65-38b0-dde0-5e155836aee1@rwth-aachen.de>
 <20210131212752.GG2002709@lianli.shorne-pla.net>
 <6dbc27f8-5261-59c5-acba-70f6c6a74ba1@rwth-aachen.de>
 <20210205144317.GK2002709@lianli.shorne-pla.net>
 <CAMuHMdXzr4c4=Cg1_Lmw41cmxmMrG4P=dV0yVjuXvuR5pqyh0Q@mail.gmail.com>
Message-ID: <20210205223651.GL2002709@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Feb 05, 2021 at 05:07:51PM +0100, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Fri, Feb 5, 2021 at 3:43 PM Stafford Horne <shorne@gmail.com> wrote:
> > On Mon, Feb 01, 2021 at 12:49:31PM +0100, Jan Henrik Weinstock wrote:
> > > Use the device tree to determine the present cpus instead of assuming all
> > > CONFIG_NRCPUS are actually present in the system.
> > >
> > > Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
> >
> > Hi Jan,
> >
> > I cannot apply this patch, it seems you somehow sent it signed as a multipart
> > message via Thunderbird.
> >
> > This causes errors when trying to apply, even after I tried to manually fix the
> > patch mail:
> >
> >     Applying: openrisc: use device tree to determine present cpus
> >     error: sha1 information is lacking or useless (arch/openrisc/kernel/smp.c).
> >     error: could not build fake ancestor
> >     Patch failed at 0001 openrisc: use device tree to determine present cpus
> >
> > Can you send this using 'git send-email?'
> >
> > If not I can get it applied with some work, otherwise you can point me to a git
> > repo which I can pull it from.
> 
> "b4 am 6dbc27f8-5261-59c5-acba-70f6c6a74ba1 at rwth-aachen.de" works
> fine for me.
> 
> git://git.kernel.org/pub/scm/utils/b4/b4.git

Did it work?  For me I got, base not found.

    Looking up
    https://lore.kernel.org/r/6dbc27f8-5261-59c5-acba-70f6c6a74ba1%40rwth-aachen.de
    Grabbing thread from lore.kernel.org/lkml
    Analyzing 9 messages in the thread
    Will use the latest revision: v2
    You can pick other revisions using the -vN flag
    ---
    Writing
    ./v2_20210201_jan_weinstock_openrisc_use_device_tree_to_determine_present_cpus.mbx
      [PATCH v2] openrisc: use device tree to determine present cpus
    ---
    Total patches: 1
    ---
     Link:
    https://lore.kernel.org/r/6dbc27f8-5261-59c5-acba-70f6c6a74ba1 at rwth-aachen.de
     Base: not found
	   git am
    ./v2_20210201_jan_weinstock_openrisc_use_device_tree_to_determine_present_cpus.mbx

-Stafford
