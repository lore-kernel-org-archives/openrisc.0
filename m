From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Mon, 29 Oct 2018 11:34:27 -0500
Subject: [OpenRISC] [PATCH v3 3/3] or1k: gcc: initial support for
	openrisc
In-Reply-To: <20181029133425.GE1761@lianli.shorne-pla.net>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-4-shorne@gmail.com>
 <20181028025730.GH5766@gate.crashing.org>
 <ed59f12b-a2a3-fa28-0d03-de1d11bb6e42@twiddle.net>
 <20181029133425.GE1761@lianli.shorne-pla.net>
Message-ID: <20181029163426.GM5766@gate.crashing.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Oct 29, 2018 at 10:34:25PM +0900, Stafford Horne wrote:
> On Sun, Oct 28, 2018 at 11:16:13PM +0000, Richard Henderson wrote:
> > On 10/28/18 2:57 AM, Segher Boessenkool wrote:
> > > Is this correct?  Should this be unsigned (u16 and K)?
> > 
> > No, l.xori is signed.
> 
> Right, sorry, I didn't have enough time to look at this at all this morning.  It
> is correct.
> 
> It looks like the documentation for this page [1] is generated from the cgen cpu
> descriptions that were removed from binutils-gdb back in 2014.  Ccing cgen who
> seem to maintain this web page.  How can we go about getting it regenerated?

Is there some better documentation available?  This is what google found
for me.  I would have like better docs (more compact, etc.)  Links to
such would be great to have in readings.html :-)


Segher
