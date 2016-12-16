From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 16 Dec 2016 15:34:21 -0500
Subject: [OpenRISC] [PATCH 00/18] sim: port for OpenRISC
In-Reply-To: <20161205084050.GA567@lianli.shorne-pla.net>
References: <1479939272-1754-1-git-send-email-shorne@gmail.com>
 <20161125161932.GH21655@vapier.lan>
 <alpine.LFD.2.20.1611260741400.29569@lianli.shorne-pla.net>
 <20161205084050.GA567@lianli.shorne-pla.net>
Message-ID: <20161216203421.GB30602@vapier.lan>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 05 Dec 2016 17:40, Stafford Horne wrote:
> On Sat, Nov 26, 2016 at 07:46:37AM +0900, Stafford Horne wrote:
> > On Fri, 25 Nov 2016, Mike Frysinger wrote:
> > > On 24 Nov 2016 07:14, Stafford Horne wrote:
> > > > The main author is Peter Gavin who should have his FSF copyright in place.
> > > 
> > > what about yourself ?  all authors should have papers in place.
> > 
> > I do not yet, but I would like to.  According to the gcc contributing
> > guidelines [1] it mentions:
> > 
> >   See some documentation by the FSF for details and contact us (either via
> >   the gcc at gcc.gnu.org list or the GCC maintainer that is taking care of
> >   your contributions) to obtain the relevant forms.
> > 
> > I know this is not gcc, but gdb, but I thought it might be the same
> > process. Since it mentions 'via .. maintainer .. taking care of your ..' I
> > thought it best I submit these patches first.
> > 
> > Could you send me the forms?
> > 
> > [1] https://gcc.gnu.org/contribute.html
> 
> I was able to get these forms submitted, but I may have made a mistake.
> Please, help clarify, I sent the program name as "GDB".  However does
> that cover work on all of binutils-gdb?  Or just gdb?

i think each project is considered sep.  you'll want binutils, gdb, and
sim.  this is the form i used in the past (directions at the top):
http://git.savannah.gnu.org/gitweb/?p=gnulib.git;a=blob_plain;f=doc/Copyright/request-assign.future;hb=HEAD
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20161216/71fd579b/attachment.sig>
