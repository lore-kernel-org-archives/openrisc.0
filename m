From: Stafford Horne <shorne@gmail.com>
Date: Tue, 14 Mar 2017 21:54:57 +0900
Subject: [OpenRISC] Build regressions/improvements in v4.11-rc2
In-Reply-To: <87shmgum28.fsf@concordia.ellerman.id.au>
References: <1489394631-9491-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdUSmQ=9VQX_-U6nfxitwxeBJ950JM-+cO7o+3OqFK=c5g@mail.gmail.com>
 <20170313141228.GA2418@lianli.shorne-pla.net>
 <CAMuHMdU7VXnN8i=P-PkYiQpxhFSsFKG3VvDRjKCZ8oH_uivmxw@mail.gmail.com>
 <20170313151001.GB2418@lianli.shorne-pla.net>
 <87shmgum28.fsf@concordia.ellerman.id.au>
Message-ID: <20170314125457.GC2418@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Mar 14, 2017 at 10:36:47PM +1100, Michael Ellerman wrote:
> Stafford Horne <shorne@gmail.com> writes:
> > On Mon, Mar 13, 2017 at 03:17:15PM +0100, Geert Uytterhoeven wrote:
> >> >>
> >> >> OpenRISC needs an updated toolchain.
> >> >
> >> > Thansk for the report.  I have updated the toolchain that is pointed to
> >> > by make.cross [1] a few weeks back.  Fengguang and I updated the
> >> > make.cross tool which the build robot's point to a late tool chain [2],
> >> > what are you using?
> >> 
> >> I'm using the linux-next build service.
> >> http://kisskb.ellerman.id.au/kisskb/head/4495c08e84729385774601b5146d51d9e5849f81/
> >
> > Right, I see the results there but I don't really see how to go about
> > sending patches to reference our latest toolchain.
> >
> > Perhaps Michael can help with that.
> 
> I can. It's fixed now:
> 
>   http://kisskb.ellerman.id.au/kisskb/buildresult/12965819/
> 
> Thanks for the pointer to the toolchain.

Great, thank you.

Note on the warning there:

  #warning syscall statx not implemented [-Wcpp]

I have a patch posted for this, in case anyone wants to review.

  https://lkml.org/lkml/2017/3/13/657

-Stafford
