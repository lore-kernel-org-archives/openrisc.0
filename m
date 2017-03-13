From: Stafford Horne <shorne@gmail.com>
Date: Tue, 14 Mar 2017 00:10:01 +0900
Subject: [OpenRISC] Build regressions/improvements in v4.11-rc2
In-Reply-To: <CAMuHMdU7VXnN8i=P-PkYiQpxhFSsFKG3VvDRjKCZ8oH_uivmxw@mail.gmail.com>
References: <1489394631-9491-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdUSmQ=9VQX_-U6nfxitwxeBJ950JM-+cO7o+3OqFK=c5g@mail.gmail.com>
 <20170313141228.GA2418@lianli.shorne-pla.net>
 <CAMuHMdU7VXnN8i=P-PkYiQpxhFSsFKG3VvDRjKCZ8oH_uivmxw@mail.gmail.com>
Message-ID: <20170313151001.GB2418@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Mar 13, 2017 at 03:17:15PM +0100, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Mon, Mar 13, 2017 at 3:12 PM, Stafford Horne <shorne@gmail.com> wrote:
> > On Mon, Mar 13, 2017 at 11:15:23AM +0100, Geert Uytterhoeven wrote:
> >> On Mon, Mar 13, 2017 at 9:43 AM, Geert Uytterhoeven
> >> <geert@linux-m68k.org> wrote:
> >> > JFYI, when comparing v4.11-rc2[1] to v4.11-rc1[3], the summaries are:
> >> >   - build errors: +6/-13
> >>
> >>   + /home/kisskb/slave/src/arch/openrisc/include/asm/atomic.h: Error:
> >> /home/kisskb/slave/src/arch/openrisc/include/asm/atomic.h:69: unknown
> >> opcode2 `l.swa'.Error: :  => 71
> >>   + /home/kisskb/slave/src/arch/openrisc/include/asm/atomic.h: Error:
> >> unknown opcode2 `l.lwa'.: 70, 69, 107 => 70, 79, 107, 69, 78
> >>   + /home/kisskb/slave/src/arch/openrisc/include/asm/atomic.h: Error:
> >> unknown opcode2 `l.swa'.: 72, 111, 71 => 71, 111, 72, 80, 81
> >>   + /home/kisskb/slave/src/arch/openrisc/include/asm/futex.h: Error:
> >> unknown opcode2 `l.lwa'.:  => 54, 60, 63, 51, 108, 57
> >>   + /home/kisskb/slave/src/arch/openrisc/include/asm/futex.h: Error:
> >> unknown opcode2 `l.swa'.:  => 62, 112, 53, 59, 65, 56
> >>
> >> OpenRISC needs an updated toolchain.
> >
> > Thansk for the report.  I have updated the toolchain that is pointed to
> > by make.cross [1] a few weeks back.  Fengguang and I updated the
> > make.cross tool which the build robot's point to a late tool chain [2],
> > what are you using?
> 
> I'm using the linux-next build service.
> http://kisskb.ellerman.id.au/kisskb/head/4495c08e84729385774601b5146d51d9e5849f81/

Right, I see the results there but I don't really see how to go about
sending patches to reference our latest toolchain.

Perhaps Michael can help with that.

-Stafford
