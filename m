From: Stafford Horne <shorne@gmail.com>
Date: Wed, 12 Jun 2019 22:09:32 +0900
Subject: [OpenRISC] [PATCH v3 10/11] sim/testsuite/or1k: Add test case
 for l.adrp instruction
In-Reply-To: <20190611214811.GS23204@embecosm.com>
References: <20190610204940.3846-1-shorne@gmail.com>
 <20190611214811.GS23204@embecosm.com>
Message-ID: <20190612130932.GB2358@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Jun 11, 2019 at 10:48:11PM +0100, Andrew Burgess wrote:
> * Stafford Horne <shorne@gmail.com> [2019-06-11 05:49:39 +0900]:
> 
> > This is a simple test to ensure that the l.adrp instruction can be assembled and
> > simulated correctly.
> > 
> > sim/testsuite/sim/or1k/ChangeLog:
> > 
> > yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>
> > 
> > 	* adrp.S: New file.
> 
> This is fine with one nit below.
> 
> Thanks,
> Andrew
> 
> 
> > ---
> > Changes since v2:
> >  - new patch
> > 
> >  sim/testsuite/sim/or1k/adrp.S | 73 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100644 sim/testsuite/sim/or1k/adrp.S
> > 
> > diff --git a/sim/testsuite/sim/or1k/adrp.S b/sim/testsuite/sim/or1k/adrp.S
> > new file mode 100644
> > index 0000000000..ba384ccc84
> > --- /dev/null
> > +++ b/sim/testsuite/sim/or1k/adrp.S
> > @@ -0,0 +1,73 @@
> > +/* Tests the load page address instruction.
> > +
> > +   Copyright (C) 2017-2019 Free Software Foundation, Inc.
> 
> This date range should just be '2019'.

Oh, of course, bad copy from me. 

-Stafford 
