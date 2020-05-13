From: Mike Rapoport <rppt@kernel.org>
Date: Wed, 13 May 2020 08:21:33 +0300
Subject: [OpenRISC] [PATCH 03/12] mm: reorder includes after
 introduction of linux/pgtable.h
In-Reply-To: <20200512192013.GY16070@bombadil.infradead.org>
References: <20200512184422.12418-1-rppt@kernel.org>
 <20200512184422.12418-4-rppt@kernel.org>
 <20200512192013.GY16070@bombadil.infradead.org>
Message-ID: <20200513052133.GN14260@kernel.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, May 12, 2020 at 12:20:13PM -0700, Matthew Wilcox wrote:
> On Tue, May 12, 2020 at 09:44:13PM +0300, Mike Rapoport wrote:
> > diff --git a/arch/alpha/kernel/proto.h b/arch/alpha/kernel/proto.h
> > index a093cd45ec79..701a05090141 100644
> > --- a/arch/alpha/kernel/proto.h
> > +++ b/arch/alpha/kernel/proto.h
> > @@ -2,8 +2,6 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  
> > -#include <linux/pgtable.h>
> > -
> >  /* Prototypes of functions used across modules here in this directory.  */
> >  
> >  #define vucp	volatile unsigned char  *
> 
> Looks like your script has a bug if linux/pgtable.h is the last include
> in the file?

Script indeed cannot handle all the corner case, but this is not one of
them.
I've started initially to look into removing asm/pgtable.h if it was not
needed, but I've run out of patience very soon. This file is what
sneaked in from that attempt.

-- 
Sincerely yours,
Mike.
