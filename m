From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 30 Oct 2018 10:41:18 -0500
Subject: [OpenRISC] [PATCH v3 3/3] or1k: gcc: initial support for
	openrisc
In-Reply-To: <20181030112600.GA2843@lianli.shorne-pla.net>
References: <20181027043702.18414-1-shorne@gmail.com>
 <20181027043702.18414-4-shorne@gmail.com>
 <20181028025730.GH5766@gate.crashing.org>
 <ed59f12b-a2a3-fa28-0d03-de1d11bb6e42@twiddle.net>
 <20181029133425.GE1761@lianli.shorne-pla.net>
 <20181029163426.GM5766@gate.crashing.org>
 <4ddf1c0d-76fb-8262-a6a2-afc7f8daee14@twiddle.net>
 <20181030112600.GA2843@lianli.shorne-pla.net>
Message-ID: <20181030154118.GB5994@gate.crashing.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Oct 30, 2018 at 08:26:00PM +0900, Stafford Horne wrote:
> On Mon, Oct 29, 2018 at 04:42:43PM +0000, Richard Henderson wrote:
> > On 10/29/18 4:34 PM, Segher Boessenkool wrote:
> > > Is there some better documentation available?  This is what google found
> > > for me.  I would have like better docs (more compact, etc.)  Links to
> > > such would be great to have in readings.html :-)
> > 
> > https://openrisc.io/architecture
> > 
> > and especially the v1.2 pdf linked from there
> > 
> > https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.2-rev0.pdf
> 
> Thanks,
> 
> I meant to point this out during my previous reply.  Also, I will send a patch
> for adding this to wwwdocs.
> 
>   https://www.gnu.org/software/gcc/readings.html

I figure out how I most likely found the out-of-date page btw: I googled
"openrisc xori" (no quotes).


Segher
