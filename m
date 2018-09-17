From: Nick Clifton <nickc@redhat.com>
Date: Mon, 17 Sep 2018 16:07:44 +0100
Subject: [OpenRISC] [PATCH 0/4] OpenRISC binutils updates and new relocs
In-Reply-To: <20180908213515.GN4594@lianli.shorne-pla.net>
References: <20180821143823.16985-1-shorne@gmail.com>
 <20180908213515.GN4594@lianli.shorne-pla.net>
Message-ID: <aceede44-4ab0-9267-a949-5cd5f3c5e81e@redhat.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

> Does anyone have concerns with these patches?  Mostly they are for openrisc
> parts only.

Sorry for the long silence - I have been very busy of late.

The patch series looks basically fine to me, so I have no concerns there.
There are a few minor formatting glitches, but nothing serious.

I do not see any need to add extra document for the new relocs, unless you
have created new assembler pseudo-ops to generate them.  (I did not see any
code to add such operators, but I may have missed something).

I do have one question though.  Is there a need to be able to distinguish 
between binaries that use the new l.adrp instruction and those that don't.
For example if a library is built using the new instruction but then it is
linked into an executable which is supposed to run on silicon which does
not support the new instruction, should the linker issue an error ?  If so,
how does it detect this situation ?

Cheers
  Nick
