From: Stafford Horne <shorne@gmail.com>
Date: Fri, 17 Mar 2017 19:03:37 +0900
Subject: [OpenRISC] [PATCH v5 1/4] gdb: Add OpenRISC or1k and or1knd
	target support
In-Reply-To: <83fuicz1nk.fsf@gnu.org>
References: <cover.1489728533.git.shorne@gmail.com>
 <cover.1489728533.git.shorne@gmail.com>
 <61be7be503333904f9533549b0a809bed4066ac3.1489728533.git.shorne@gmail.com>
 <83lgs4z3ty.fsf@gnu.org>
 <20170317093247.GO2418@lianli.shorne-pla.net>
 <83fuicz1nk.fsf@gnu.org>
Message-ID: <20170317100337.GP2418@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Mar 17, 2017 at 11:35:27AM +0200, Eli Zaretskii wrote:
> > Date: Fri, 17 Mar 2017 18:32:47 +0900
> > From: Stafford Horne <shorne@gmail.com>
> > Cc: gdb-patches at sourceware.org, franck.jullien at gmail.com,
> > 	openrisc at lists.librecores.org
> > 
> > > > +The OpenRISC 1000 architecture has evolved since the first port for
> > > > + at value{GDBN}.  In particular the structure of the Unit Present register has
> > > > +changed and the CPU Configuration register has been added.  The port of
> > > > + at value{GDBN} version @value{GDBVN} uses the @emph{current}
> > > > +specification of the OpenRISC 1000.
> > > 
> > > I'm not sure what this text conveys.  Can you tell why it is important
> > > to have this information in the manual?  I might then suggest a change
> > > in wording.
> > 
> > Its saying that if you are using an old version of the CPU it might not
> > run as expected with this version of GDB.  Ill change to explain that
> > without talking about previous ports of GDB.
> > 
> > Something like:
> > 
> >   Earlier version of the OpenRISC architecture did not include the UPR
> >   (unit present) or CPUCFGR (CPU configuration) registers.  This version
> >   of @value{GDBN} expects these to be present.
> 
> That's okay, but we should also tell the reader what to do if the
> expected registers are not present.  Is there anything they could do
> except upgrade to a newer version of OpenRISC?

Actually, sorry, I was going off the text above.  When I checked the
code it seems I removed the code that depended on these registers after
earlier reviews.

The XML target description includes all of these registers and more.  I
may either remove this or change to explain about the target description
architecture dependency.  But the target description is not a hard
dependency.

Thanks for the quick feedback.

-Stafford
