From: Pavel Machek <pavel@ucw.cz>
Date: Tue, 12 Sep 2017 09:47:02 +0200
Subject: [OpenRISC] [PATCH 10/13] openrisc: add simple_smp dts and
 defconfig for simulators
In-Reply-To: <CAAfxs76zOKM3vs=9_vwpNnceua-THV=h6Y4xAtg-kU=wpRq46g@mail.gmail.com>
References: <cover.1504129273.git.shorne@gmail.com>
 <37f0d48de4690694c18be3d32483dafee0730859.1504129273.git.shorne@gmail.com>
 <20170911223712.GA31546@amd>
 <CAAfxs76zOKM3vs=9_vwpNnceua-THV=h6Y4xAtg-kU=wpRq46g@mail.gmail.com>
Message-ID: <20170912074702.GA25921@amd>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue 2017-09-12 07:55:18, Stafford Horne wrote:
> On Tue, Sep 12, 2017 at 7:37 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > On Thu 2017-08-31 07:03:11, Stafford Horne wrote:
> >> From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> >>
> [...]
> >> +++ b/arch/openrisc/boot/dts/simple_smp.dts
> >> @@ -0,0 +1,58 @@
> >> +/dts-v1/;
> >> +/ {
> >> +     compatible = "opencores,or1ksim";
> >
> > You may want to add some comment on top, explaining what this
> > is... and perhaps link to some page documenting how to set up
> > qemu/FPGAs?
> 
> Sure, I can create an entry in Documentation/devicetree/binding
> documenting this since its been there for a while but was never properly
> documented.

Yep, Documentation/devicetree should be mandatory.

> But, just to be clear, what do you mean by page?  Are you suggesting
> linking to a web page?  Or do you mean something in Documentation/...?

Whatever works for you. Maybe Documentation/ would be better...
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170912/f762320a/attachment.sig>
