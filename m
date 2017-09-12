From: Stafford Horne <shorne@gmail.com>
Date: Wed, 13 Sep 2017 07:15:35 +0900
Subject: [OpenRISC] [PATCH 10/13] openrisc: add simple_smp dts and
 defconfig for simulators
In-Reply-To: <20170912074702.GA25921@amd>
References: <cover.1504129273.git.shorne@gmail.com>
 <37f0d48de4690694c18be3d32483dafee0730859.1504129273.git.shorne@gmail.com>
 <20170911223712.GA31546@amd>
 <CAAfxs76zOKM3vs=9_vwpNnceua-THV=h6Y4xAtg-kU=wpRq46g@mail.gmail.com>
 <20170912074702.GA25921@amd>
Message-ID: <20170912221535.GT2609@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Sep 12, 2017 at 09:47:02AM +0200, Pavel Machek wrote:
> On Tue 2017-09-12 07:55:18, Stafford Horne wrote:
> > On Tue, Sep 12, 2017 at 7:37 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > > On Thu 2017-08-31 07:03:11, Stafford Horne wrote:
> > >> From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > >>
> > [...]
> > >> +++ b/arch/openrisc/boot/dts/simple_smp.dts
> > >> @@ -0,0 +1,58 @@
> > >> +/dts-v1/;
> > >> +/ {
> > >> +     compatible = "opencores,or1ksim";
> > >
> > > You may want to add some comment on top, explaining what this
> > > is... and perhaps link to some page documenting how to set up
> > > qemu/FPGAs?
> > 
> > Sure, I can create an entry in Documentation/devicetree/binding
> > documenting this since its been there for a while but was never properly
> > documented.
> 
> Yep, Documentation/devicetree should be mandatory.
> 
> > But, just to be clear, what do you mean by page?  Are you suggesting
> > linking to a web page?  Or do you mean something in Documentation/...?
> 
> Whatever works for you. Maybe Documentation/ would be better...

Actually, I forgot, we have something but its here:

  arch/openrisc/README.openrisc

I'll work on some patches to move that to Documentation/ and clean it up.

 -Stafford

