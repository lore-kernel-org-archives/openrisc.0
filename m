From: Stafford Horne <shorne@gmail.com>
Date: Tue, 3 May 2016 08:04:20 +0900
Subject: [OpenRISC] [PATCH] cgen: sim: Updates to sim files to match gdb
	types
In-Reply-To: <20160502182904.GJ26300@vapier.lan>
References: <1462069082-8756-1-git-send-email-shorne@gmail.com>
 <20160501190301.GC26300@vapier.lan> <20160502182904.GJ26300@vapier.lan>
Message-ID: <CAAfxs77j2w+D9phjifQZxA-Es8OXKQdYx_KvLAy_NVVJ8Wk7rg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Thanks,

Yes, as far as I know I can only find cgen in cvs.  This patch is based on
the nightly release from 20160401 (I didn't have a cvs client on my
machine) so it should apply find against current CVS.  Let me know if you
have any issues.

-Stafford

On Tue, May 3, 2016 at 3:29 AM, Mike Frysinger <vapier@gentoo.org> wrote:

> On 01 May 2016 15:03, Mike Frysinger wrote:
> > On 01 May 2016 11:18, Stafford Horne wrote:
> > > The types like MACH and MODEL have changes to SIM_MACH and SIM_MODEL
> > > make updates to match these changes.  This way people dont have to
> > > manually update the generated files in GDB.
> > >
> > > I am from openrisc and working on getting the openrisc sim and gdb
> patches
> > > ready for submitting to upstream. This was required to get the sim
> build to
> > > work.
> >
> > looks fine to me (since i did make those changes in the sim), but i'm not
> > a cgen committer.
>
> i talked to Frank and i'll pick this up.
>
> cgen is still using the CVS tree right ?
> -mike
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160503/8e433275/attachment.html>
