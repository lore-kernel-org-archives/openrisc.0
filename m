From: Stafford Horne <shorne@gmail.com>
Date: Thu, 11 Jun 2020 05:17:12 +0900
Subject: [OpenRISC] [PATCH 1/1] Initial support for OpenRISC
In-Reply-To: <20200522223218.GD75760@lianli.shorne-pla.net>
References: <20200522113633.209664-1-shorne@gmail.com>
 <20200522113633.209664-2-shorne@gmail.com>
 <87eerc3z7b.fsf@oldenburg2.str.redhat.com>
 <20200522215953.GC75760@lianli.shorne-pla.net>
 <alpine.DEB.2.21.2005222201450.10437@digraph.polyomino.org.uk>
 <20200522223218.GD75760@lianli.shorne-pla.net>
Message-ID: <20200610201712.GL75760@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, May 23, 2020 at 07:32:18AM +0900, Stafford Horne wrote:
> On Fri, May 22, 2020 at 10:02:54PM +0000, Joseph Myers wrote:
> > On Sat, 23 May 2020, Stafford Horne via Libc-alpha wrote:
> > 
> > > For binutils and gcc require patches which are mentioned in the cover letter.
> > > I will document.
> > 
> > In my view the changes need to be upstream before the patch can go into 
> > glibc.  We want to avoid the mess we had with MicroBlaze where the port 
> > turned out to depend on GCC patches that hadn't yet been upstreamed.
> 
> Notes,  I don't think that will be a problem.  Binutils patches are already
> upstream.  The GCC patches should be too before I send the V2 series (I just
> need to push them).


Hi All,

Just an update on this series.  I have made all of the changes but the updates
to new kernel API's are making quite a new test fail.  Mostly these are
environmental issues that I need to sort out.

My todo list now is:

 - Sort out all new failures
 - Sort out the FPU failures (I may mail asking for help on that)
 - Go though all files again to ensure what is and isn't needed (i.e. removed
   due to upstream refactorings)
 - Update the wiki pages as required by NewPorts

It's going to take me a bit longer than I expected to get v2 out.

-Stafford
