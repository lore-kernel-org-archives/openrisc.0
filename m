From: Stafford Horne <shorne@gmail.com>
Date: Tue, 18 Sep 2018 18:52:34 +0900
Subject: [OpenRISC] [PATCH 0/4] OpenRISC binutils updates and new relocs
In-Reply-To: <aceede44-4ab0-9267-a949-5cd5f3c5e81e@redhat.com>
References: <20180821143823.16985-1-shorne@gmail.com>
 <20180908213515.GN4594@lianli.shorne-pla.net>
 <aceede44-4ab0-9267-a949-5cd5f3c5e81e@redhat.com>
Message-ID: <20180918095234.GP4594@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Sep 17, 2018 at 04:07:44PM +0100, Nick Clifton wrote:
> Hi Stafford,
> 
> > Does anyone have concerns with these patches?  Mostly they are for openrisc
> > parts only.
> 
> Sorry for the long silence - I have been very busy of late.
> 
> The patch series looks basically fine to me, so I have no concerns there.
> There are a few minor formatting glitches, but nothing serious.

Will you be able to point them out?  Even just some hints?  We have tried to
follow conventions, but there might be some missed spots.  I will go over
everything again just in case and run any formatting tools I have, but any tips
will be helpful.

> I do not see any need to add extra document for the new relocs, unless you
> have created new assembler pseudo-ops to generate them.  (I did not see any
> code to add such operators, but I may have missed something).

As Richard mentioned we have added a few, see PATCH 3/4 in cpu/or1k.opc the
change:

	(parse_reloc): Add new po(), gotpo() and gottppo() for LO13 relocations.

Is this what you mean?  I will look into adding the documentation for these.

> I do have one question though.  Is there a need to be able to distinguish 
> between binaries that use the new l.adrp instruction and those that don't.
> For example if a library is built using the new instruction but then it is
> linked into an executable which is supposed to run on silicon which does
> not support the new instruction, should the linker issue an error ?  If so,
> how does it detect this situation ?

As Richard mentioned we don't handle this.

We have cases like this right now as well, i.e. binaries generated with `l.mul`
or `l.div` instructions will link fine into an executable that assume those
instrunctions should be emulated.  That doesn't throw an error and I don't think
it has been a problem.

-Stafford
