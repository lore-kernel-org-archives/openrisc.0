From: Mike Rapoport <rppt@kernel.org>
Date: Mon, 17 Feb 2020 08:23:44 +0200
Subject: [OpenRISC] [PATCH v2 00/13] mm: remove __ARCH_HAS_5LEVEL_HACK
In-Reply-To: <20200216082230.GV25745@shell.armlinux.org.uk>
References: <20200216081843.28670-1-rppt@kernel.org>
 <20200216082230.GV25745@shell.armlinux.org.uk>
Message-ID: <20200217062344.GA4729@hump>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Feb 16, 2020 at 08:22:30AM +0000, Russell King - ARM Linux admin wrote:
> On Sun, Feb 16, 2020 at 10:18:30AM +0200, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Hi,
> > 
> > These patches convert several architectures to use page table folding and
> > remove __ARCH_HAS_5LEVEL_HACK along with include/asm-generic/5level-fixup.h.
> > 
> > The changes are mostly about mechanical replacement of pgd accessors with p4d
> > ones and the addition of higher levels to page table traversals.
> > 
> > All the patches were sent separately to the respective arch lists and
> > maintainers hence the "v2" prefix.
> 
> You fail to explain why this change which adds 488 additional lines of
> code is desirable.

Right, I should have been more explicit about it.

As Christophe mentioned in his reply, removing 'HACK' and 'fixup' is an
improvement.
Another thing is that when all architectures behave the same it opens
opportunities for cleaning up repeating definitions of page table
manipulation primitives.

 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up

-- 
Sincerely yours,
Mike.
