From: Stafford Horne <shorne@gmail.com>
Date: Fri, 17 Mar 2017 18:32:47 +0900
Subject: [OpenRISC] [PATCH v5 1/4] gdb: Add OpenRISC or1k and or1knd
	target support
In-Reply-To: <83lgs4z3ty.fsf@gnu.org>
References: <cover.1489728533.git.shorne@gmail.com>
 <cover.1489728533.git.shorne@gmail.com>
 <61be7be503333904f9533549b0a809bed4066ac3.1489728533.git.shorne@gmail.com>
 <83lgs4z3ty.fsf@gnu.org>
Message-ID: <20170317093247.GO2418@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Mar 17, 2017 at 10:48:25AM +0200, Eli Zaretskii wrote:
> > From: Stafford Horne <shorne@gmail.com>
> > Cc: Franck Jullien <franck.jullien@gmail.com>,	openrisc at lists.librecores.org
> > Date: Fri, 17 Mar 2017 14:43:17 +0900
> > 
> > This patch prepates the current GDB port of the openrisc processor from
> > https://github.com/openrisc/binutils-gdb for upstream merging.
> 
> Thanks.  Some comments on the documentation part of the patch.

Thanks for reviewing, this is actually the second pass of the
documentation.  More reviews are welcome.

> > + at node OpenRISC 1000
> > + at subsection OpenRISC 1000
> > + at cindex OpenRISC 1000
> > +
> > +Previous development versions of @value{GDBN} supported remote connection
> > +via a proprietary JTAG protocol using the @samp{target jtag} command.
> > +Support for this has now been dropped.
> > +
> > +Also, previous verions had support for a @samp{spr} command to access
> > +OpenRISC's numberous special purpose registers.  These are now available
> > +via the normal @samp{info registers} command.
> 
> I'm not sure this is appropriate for the manual.  The manual should
> describe what GDB currently does, not what it did before and no longer
> does.  This text is more appropriate for NEWS, which specifically
> describe changes wrt previous code.

Sure, I can remove.

> > + at kindex target remote
> > + at item target remote
> > +
> > +Connects to remote JTAG server.
> > +This is now the only way to connect to a remote OpenRISC 1000
> > +target.
> 
> Likewise for this sentence: if you don't describe any other way of
> connecting, there's no need to say this is the only way.

Right. I will correct it to better follow other architectures.

> > +There are some known problems with the current implementation
> 
> This should have a colon at its end.

ok

> > + at cindex OpenRISC 1000 known problems
> > +
> > + at enumerate
> > +
> > + at item
> > + at cindex OpenRISC 1000 known problems, hardware breakpoints and watchpoints
> 
> It is not useful to have 2 or more index entries starting from the
> same string and pointing to the same or very close places.  I would
> suggest instead
> 
>   @cindex hardware breakpoints and watchpoints, known problems on OpenRISC 1000

Good point

> > +Some OpenRISC 1000 targets support hardware breakpoints and watchpoints.
> > +Consult the target documentation for details.  @value{GDBN} is not
> > +perfect in handling of watchpoints.  It is possible to allocate hardware
> > +watchpoints and not discover until running that sufficient watchpoints
> > +are not available.  It is also possible that GDB will report watchpoints
> > +being hit spuriously.  This can be down to the assembly code having
> > +additional memory accesses that are not obviously reflected in the
> > +source code.
> 
> The index entry mentions hardware breakpoints, but the text
> exclusively mentions only watchpoints.  Are hardware breakpoints
> affected like that as well?

I don't think it applies to both, Ill add a statement explaining about
breakpoints.  Maybe they should be separate points if they are
different.

> > + at item
> > + at cindex OpenRISC 1000 known problems, architectural compatibility
> 
> Same comment as above about this index entry.

Yes

> > +The OpenRISC 1000 architecture has evolved since the first port for
> > + at value{GDBN}.  In particular the structure of the Unit Present register has
> > +changed and the CPU Configuration register has been added.  The port of
> > + at value{GDBN} version @value{GDBVN} uses the @emph{current}
> > +specification of the OpenRISC 1000.
> 
> I'm not sure what this text conveys.  Can you tell why it is important
> to have this information in the manual?  I might then suggest a change
> in wording.

Its saying that if you are using an old version of the CPU it might not
run as expected with this version of GDB.  Ill change to explain that
without talking about previous ports of GDB.

Something like:

  Earlier version of the OpenRISC architecture did not include the UPR
  (unit present) or CPUCFGR (CPU configuration) registers.  This version
  of @value{GDBN} expects these to be present.

-Stafford
