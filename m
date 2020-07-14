From: Stafford Horne <shorne@gmail.com>
Date: Wed, 15 Jul 2020 04:42:02 +0900
Subject: [OpenRISC] [PATCH] OPENRISC ARCHITECTURE: Replace HTTP links
 with HTTPS ones
In-Reply-To: <CAMuHMdXMumw9CnMHOc_GJGO0MNsLowTv-wE399BMJveXgTXbLQ@mail.gmail.com>
References: <20200710062019.28755-1-grandmaster@al2klimov.de>
 <20200713113430.1c1777bb@lwn.net>
 <CAMuHMdXoUME_dCOZP1N0tXyMv61edfNECM4-n4NPa56YbBCncw@mail.gmail.com>
 <20200714074022.24481c73@lwn.net>
 <CAMuHMdXMumw9CnMHOc_GJGO0MNsLowTv-wE399BMJveXgTXbLQ@mail.gmail.com>
Message-ID: <20200714194202.GE437393@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Jul 14, 2020 at 07:30:38PM +0200, Geert Uytterhoeven wrote:
> On Tue, Jul 14, 2020 at 3:40 PM Jonathan Corbet <corbet@lwn.net> wrote:
> > On Tue, 14 Jul 2020 09:22:39 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > -     website         http://openrisc.io
> > > > > +     website         https://openrisc.io
> > > > >       email           openrisc at lists.librecores.org
> > > > >       =======         =============================
> > > >
> > > > Applied, thanks.
> > >
> > > Is that site accessible for anyone? It times out for me.
> >
> > Works for me.
> 
> Now it indeed does.

Thanks for checking,

There was an issue with our server hardware that hosts https://openrisc.io as
well as other FOSSI sites including https://www.librecores.org and
https://fossi-foundation.org.

We migrated these all to different infrastructure (github pages) to fix the
issue.  They should be more stable now.

-Stafford
