From: Stafford Horne <shorne@gmail.com>
Date: Wed, 19 Sep 2018 22:23:40 +0900
Subject: [OpenRISC] [PATCH 0/4] OpenRISC binutils updates and new relocs
In-Reply-To: <20b65fc3-5bbb-6e77-f598-4582204ee0e5@redhat.com>
References: <20180821143823.16985-1-shorne@gmail.com>
 <20180908213515.GN4594@lianli.shorne-pla.net>
 <aceede44-4ab0-9267-a949-5cd5f3c5e81e@redhat.com>
 <20180918095234.GP4594@lianli.shorne-pla.net>
 <20b65fc3-5bbb-6e77-f598-4582204ee0e5@redhat.com>
Message-ID: <20180919132340.GQ4594@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Sep 18, 2018 at 12:55:48PM +0100, Nick Clifton wrote:
> Hi Stafford,
> 
> >> There are a few minor formatting glitches, but nothing serious.
> > 
> > Will you be able to point them out?  Even just some hints?
> 
> Sure...
> 
> So for example in patch 1/4 there is:
> 
>   +enum {
>   +  RTYPE_LO = 0,
> 
> when really it should be:
> 
>   +enum 
>   +{
>   +  RTYPE_LO = 0,
> 
> (And similarly in other places.  Basically, try to avoid ending a line
> with an opening curly brace, unless that brace is the only character on
> the line).
> 
> Then there is:
> 
>   +static int
>   +parse_reloc(const char **strp)
> 
> Which ought to be:
> 
>   +static int
>   +parse_reloc (const char **strp)
> 
> Ie - a single space between the function name and its parameters.
> (I did say that these were minor formatting nits...)  In a similar
> vein there is:
> 
>   +  return parse_imm16(cd, strp, opindex, (long *) valuep, 0);
>   +}
>  
> which also needs a space between the function name and its arguments.
> 
> There are a few other cases of the above issues in the other patches,
> but nothing else of note.

Ack on the braces and function spaces.  I will clean those up.

> One other thing:  There are several places where you add calls to 
> abort().  Now this is not wrong, and certainly not a reason to 
> reject the patch, but I consider it to be unhelpful.  To my mind
> a library, or tool, should generate an error message when something
> goes wrong and not leave the user wondering why they have suddenly
> got a segmentation fault.
> 
> Plus if you have a call to abort() in the code you can bet that some 
> enterprising person with a binary fuzzer will find a way to trigger 
> it, and then file a CVE about it.  (Fixing CVEs is the bane of my 
> life as they involve lots of extra administrivia).

OK, I will fix those too.

> >> I do not see any need to add extra document for the new relocs, unless you
> >> have created new assembler pseudo-ops to generate them.
> 
> > As Richard mentioned we have added a few, see PATCH 3/4 in cpu/or1k.opc the
> > change:
> > 
> > 	(parse_reloc): Add new po(), gotpo() and gottppo() for LO13 relocations.
> > 
> > Is this what you mean?  I will look into adding the documentation for these.
> 
> Please do.  Most likely you will want to create a gas/doc/c-or1k.c file,
> (copying the contents from another, similar file and modifying as needed), and
> then patch the gas/doc/as.texi file to include it and the gas/doc/all.texi file
> to define a macro for it.

Sure I will do that.

> >> I do have one question though.  Is there a need to be able to distinguish 
> >> between binaries that use the new l.adrp instruction and those that don't.
> 
> > As Richard mentioned we don't handle this.
> > 
> > We have cases like this right now as well, i.e. binaries generated with `l.mul`
> > or `l.div` instructions will link fine into an executable that assume those
> > instrunctions should be emulated.  That doesn't throw an error and I don't think
> > it has been a problem.
> 
> OK, well it is your target, so if you are OK with this then so be it.
> I would recommend however thinking about a solution for the future, should the
> openRISC architecture gain more variants.  My suggestion would be to make use
> of ELF notes, as has been done with other ports.

Thanks, I will keep that in mind.

-Stafford
