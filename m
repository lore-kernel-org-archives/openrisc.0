From: Stafford Horne <shorne@gmail.com>
Date: Wed, 3 May 2017 00:53:05 +0900
Subject: [OpenRISC] [PATCH v6 2/5] gdb: Add OpenRISC or1k and or1knd
	target support
In-Reply-To: <864lx38h2i.fsf@gmail.com>
References: <cover.1493038197.git.shorne@gmail.com>
 <cover.1493038197.git.shorne@gmail.com>
 <ae4e2c7e3e9d364bf73adba1eedaeb3f4691d907.1493038197.git.shorne@gmail.com>
 <864lx38h2i.fsf@gmail.com>
Message-ID: <20170502155305.GI2724@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Tue, May 02, 2017 at 03:32:53PM +0100, Yao Qi wrote:
> Stafford Horne <shorne@gmail.com> writes:
> 
> > + at kindex target remote
> > + at item target remote
> > +
> > +Connect to a remote OpenRISC 1000 target.  This is supported by
> > + at dfn{Or1ksim}, the OpenRISC 1000 architectural simulator as well as QEMU,
> > +Verilator and Icarus Verilog simulators.  @dfn{Remote serial protocol}
> > +servers, such as OpenOCD, are also available to drive various hardware
> > +implementations via JTAG.
> > +
> > +Example: @code{target remote :51000}
> 
> Do we need to document "target remote"? which is not specific to any
> particular configurations.

I understand this is nothing new, but this tells to the users some extra
details about using target remote for OpenRISC (example which platforms
support it).  Also, this is consistent with some other targets like
Microblaze.

> > +
> > + at kindex target sim
> > + at item target sim
> > +
> > +Runs the builtin CPU simulator which can run very basic
> > +programs but does not support most hardware functions like MMU.
> > +For more complex use cases the user is advised to run an external
> > +target, and connect using @samp{target remote}.
> > +
> > +Example: @code{target sim}
> > +
> > + at end table
> > +
> >  @node PowerPC Embedded
> >  @subsection PowerPC Embedded
> >  
> > @@ -41088,6 +41131,7 @@ registers using the capitalization used in the description.
> >  * M68K Features::
> >  * NDS32 Features::
> >  * Nios II Features::
> > +* OpenRISC 1000 Features::
> >  * PowerPC Features::
> >  * S/390 and System z Features::
> >  * Sparc Features::
> > @@ -41374,6 +41418,32 @@ targets.  It should contain the 32 core registers (@samp{zero},
> >  @samp{pc}, and the 16 control registers (@samp{status} through
> >  @samp{mpuacc}).
> >  
> > + at node OpenRISC 1000 Features
> > + at subsection Openrisc 1000 Features
> > + at cindex target descriptions, OpenRISC 1000 features
> > +
> > +The @samp{org.gnu.gdb.or1k.group0} feature is required for OpenRISC 1000
> > +targets.  It should contain the 32 general purpose registers (@samp{r0}
> > +through @samp{r31}), @samp{ppc}, @samp{npc} and @samp{sr}.
> > +
> > +Along with the default reggroups like @samp{system} and @samp{general}
> > +provided by @value{GDBN}, OpenRISC targets can use the following reggroups
> > +to group their many registers:
> > +
> > + at smallexample
> > + Group      Type
> > + immu       user
> > + dmmu       user
> > + icache     user
> > + dcache     user
> > + pic        user
> > + timer      user
> > + power      user
> > + perf       user
> > + mac        user
> > + debug      user
> > + at end smallexample
> > +
> 
> Why do you need to document the reggroups?

These register groups can be used by the target description features.  If
not documented one would have to look into the code.  In general arbitrary
groups are not allowed by features.  This is also related to patch 1/5.

> > +
> > +extern initialize_file_ftype _initialize_or1k_tdep; /* -Wmissing-prototypes */
> > +
> 
> This is no longer needed, because GDB is moved to C++.
> 
> Otherwise, the code is good to me.
> 
> -- 
> Yao (齐尧)
