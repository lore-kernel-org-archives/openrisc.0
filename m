From: Stafford Horne <shorne@gmail.com>
Date: Wed, 20 Dec 2017 22:34:54 +0900
Subject: [OpenRISC] [PATCH v3 4/4] tdesc: handle arbitrary strings in
 tdesc_register_in_reggroup_p
In-Reply-To: <20171219221300.GB32243@lianli.shorne-pla.net>
References: <20171219142257.13402-1-shorne@gmail.com>
 <20171219142257.13402-5-shorne@gmail.com> <836092ptsa.fsf@gnu.org>
 <20171219221300.GB32243@lianli.shorne-pla.net>
Message-ID: <20171220133454.GD32243@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Eli

On Wed, Dec 20, 2017 at 07:13:00AM +0900, Stafford Horne wrote:
> On Tue, Dec 19, 2017 at 06:27:33PM +0200, Eli Zaretskii wrote:
> > > From: Stafford Horne <shorne@gmail.com>
> > > Cc: Openrisc <openrisc@lists.librecores.org>,	Stafford Horne <shorne@gmail.com>
> > > diff --git a/gdb/NEWS b/gdb/NEWS
> > > index 44f481d1f5..7d27262aee 100644
> > > --- a/gdb/NEWS
> > > +++ b/gdb/NEWS
> > > @@ -3,6 +3,13 @@
> > >  
> > >  *** Changes since GDB 8.0
> > >  
> > > +* GDB now supports dynamically creating arbitrary register groups specified
> > > +  in XML target descriptions.  This allows for finer grain grouping of
> > > +  registers on systems with a large amount of registers.
> > > +
> > > +* On Unix systems, GDBserver now does globbing expansion and variable
> > > +  substitution in inferior command line arguments.
> > 
> > The second paragraph doesn't belong to this changeset, right?
> 
> Right, I accidently brought this in during conflict resolution.  Will fix.
> 
> > >  @item group
> > > -The register group to which this register belongs.  It must
> > > -be either @code{general}, @code{float}, or @code{vector}.  If no
> > > - at var{group} is specified, @value{GDBN} will not display the register
> > > -in @code{info registers}.
> > > +The register group to which this register belongs.  It can be one of the
> > > +standard register groups @code{general}, @code{float}, @code{vector} or an
> > > +arbitrary string.  The string should be limited to alphanumeric characters
> > > +and internal hyphens.  If no @var{group} is specified, @value{GDBN} will
> > 
> > What do you mean by "internal hyphens"?
> 
> This means, hyphens withing the register group name, not starting or ending with
> hyphens.  (i.e. special-spr,  but not rg1- or -rg2)

I looked a bit into this,  I seem to have pulled this text from the
target-descriptions.c file.  The line saying ".. and internal hyphens" was added
as a comment in 2007 in commit 123dc839145 by Daniel Jacobowitz.  The commit was
the introduction of the target descriptions code.

I don't see any actual enforcement of the name format.  I can leave that whole
sentence out.

But I think its useful to mention as it is the intended format.  I could change
it to say something like "alphanumeric characters and hyphens as word
separators."  or "The group name should be limited to hyphen-separated
alphanumeric strings."

-Stafford
